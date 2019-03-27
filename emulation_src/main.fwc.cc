#include "libZebuZEMI3.hh"
#include "libZebu.hh"
#include "stdlib.h"
#include <iostream>
#include <unistd.h>
#include "xtor.h"     // xtor include
using namespace std;
using namespace ZEBU;

int main()
{
  ZEMI3Manager *manager;
  manager = ZEMI3Manager::open("../zcui.work/zebu.work");
  // Zemi3 xtor
  manager->addXtor("xtor", "LPF1s_TB.x0");

  Board *z = ZEBU::getBoard();
    //  Sniffer::Configuration cfg;
    //  cfg.folderName = "sniffer";
    //  cfg.sniffOutput = 0;
    //  Sniffer::Start(cfg);

  FastWaveformCapture wav;
  wav.initialize(z);
  wav.add("debug_fwc");
  wav.dumpFile("myfwc.ztdb");

  RunManager* rm = z->getMainRunManager();

  //CCall::Start(z);
  manager->init();
  manager->start();
  
  //ZEBU_CurrentTimeType t = z->getCurrentTime();
  //svScope s = svGetScopeFromName("LPF1s_TB.x0");
  //svSetScope(s);

  //rm->advanceTickClock(1000);
  rm->advanceTime(1000);
  sleep(1);

  //CCall::Stop(z);
  wav.closeFile();
  manager->close();
  return 0;
}

