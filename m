Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB5C22380F
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jul 2020 11:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGQJSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Jul 2020 05:18:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgGQJSn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Jul 2020 05:18:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06H934i2174163;
        Fri, 17 Jul 2020 05:18:09 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32b61kcwcf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 05:18:09 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06H93DjZ174849;
        Fri, 17 Jul 2020 05:18:08 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32b61kcwbk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 05:18:08 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06H99wmV024480;
        Fri, 17 Jul 2020 09:18:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 329nmyjr55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Jul 2020 09:18:06 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06H9I4n855705760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Jul 2020 09:18:04 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B5BB52054;
        Fri, 17 Jul 2020 09:18:04 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.80.176])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E91DF5204E;
        Fri, 17 Jul 2020 09:18:01 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/2] Selftest for cpuidle latency measurement
Date:   Fri, 17 Jul 2020 14:47:59 +0530
Message-Id: <20200717091801.29289-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-17_04:2020-07-17,2020-07-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007170066
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v1: https://lkml.org/lkml/2020/7/7/1036
Changelog v1 --> v2
1. Based on Shuah Khan's comment, changed exit code to ksft_skip to
   indicate the test is being skipped
2. Change the busy workload for baseline measurement from
   "yes > /dev/null" to "cat /dev/random to /dev/null", based on
   observed CPU utilization for "yes" consuming ~60% CPU while the
   latter consumes 100% of CPUs, giving more accurate baseline numbers
---

The patch series introduces a mechanism to measure wakeup latency for
IPI and timer based interrupts
The motivation behind this series is to find significant deviations
behind advertised latency and resisdency values

To achieve this, we introduce a kernel module and expose its control
knobs through the debugfs interface that the selftests can engage with.

The kernel module provides the following interfaces within
/sys/kernel/debug/latency_test/ for,
1. IPI test:
  ipi_cpu_dest   # Destination CPU for the IPI
  ipi_cpu_src    # Origin of the IPI
  ipi_latency_ns # Measured latency time in ns
2. Timeout test:
  timeout_cpu_src     # CPU on which the timer to be queued
  timeout_expected_ns # Timer duration
  timeout_diff_ns     # Difference of actual duration vs expected timer
To include the module, check option and include as module
kernel hacking -> Cpuidle latency selftests

The selftest inserts the module, disables all the idle states and
enables them one by one testing the following:
1. Keeping source CPU constant, iterates through all the CPUS measuring
   IPI latency for baseline (CPU is busy with
   "cat /dev/random > /dev/null" workload) and the when the CPU is
   allowed to be at rest
2. Iterating through all the CPUs, sending expected timer durations to
   be equivalent to the residency of the the deepest idle state
   enabled and extracting the difference in time between the time of
   wakeup and the expected timer duration

Usage
-----
Can be used in conjuction to the rest of the selftests.
Default Output location in: tools/testing/cpuidle/cpuidle.log

To run this test specifically:
$ make -C tools/testing/selftests TARGETS="cpuidle" run_tests

There are a few optinal arguments too that the script can take
	[-h <help>]
	[-m <location of the module>]
	[-o <location of the output>]

Sample output snippet
---------------------
--IPI Latency Test---
--Baseline IPI Latency measurement: CPU Busy--
SRC_CPU   DEST_CPU IPI_Latency(ns)
...
0            8         1996
0            9         2125
0           10         1264
0           11         1788
0           12         2045
Baseline Average IPI latency(ns): 1843
---Enabling state: 5---
SRC_CPU   DEST_CPU IPI_Latency(ns)
0            8       621719
0            9       624752
0           10       622218
0           11       623968
0           12       621303
Expected IPI latency(ns): 100000
Observed Average IPI latency(ns): 622792

--Timeout Latency Test--
--Baseline Timeout Latency measurement: CPU Busy--
Wakeup_src Baseline_delay(ns) 
...
8            2249
9            2226
10           2211
11           2183
12           2263
Baseline Average timeout diff(ns): 2226
---Enabling state: 5---
8           10749                   
9           10911                   
10          10912                   
11          12100                   
12          73276                   
Expected timeout(ns): 10000200
Observed Average timeout diff(ns): 23589

Pratik Rajesh Sampat (2):
  cpuidle: Trace IPI based and timer based wakeup latency from idle
    states
  selftest/cpuidle: Add support for cpuidle latency measurement

 drivers/cpuidle/Makefile                   |   1 +
 drivers/cpuidle/test-cpuidle_latency.c     | 150 ++++++++++++
 lib/Kconfig.debug                          |  10 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 257 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   1 +
 7 files changed, 426 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.25.4

