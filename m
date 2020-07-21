Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA53822803C
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jul 2020 14:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbgGUMoo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 Jul 2020 08:44:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:27488 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727983AbgGUMoo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 Jul 2020 08:44:44 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06LCXIU1141883;
        Tue, 21 Jul 2020 08:44:25 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h8r6eh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 08:44:25 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06LCZPoX149175;
        Tue, 21 Jul 2020 08:44:23 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32d5h8r6dn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 08:44:23 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06LCeSXc023133;
        Tue, 21 Jul 2020 12:44:21 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 32brq7uywn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Jul 2020 12:44:21 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06LCh3MT60752264
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jul 2020 12:43:03 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FE894204B;
        Tue, 21 Jul 2020 12:43:03 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 105E642047;
        Tue, 21 Jul 2020 12:43:01 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.79.210.59])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 21 Jul 2020 12:43:00 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, npiggin@gmail.com, ego@linux.vnet.ibm.com,
        svaidy@linux.ibm.com, pratik.r.sampat@gmail.com,
        psampat@linux.ibm.com, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 0/2] Selftest for cpuidle latency measurement
Date:   Tue, 21 Jul 2020 18:12:58 +0530
Message-Id: <20200721124300.65615-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-21_08:2020-07-21,2020-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=724 spamscore=0 adultscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007210089
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

v2: https://lkml.org/lkml/2020/7/17/369
Changelog v2-->v3
Based on comments from Gautham R. Shenoy adding the following in the
selftest,
1. Grepping modules to determine if already loaded
2. Wrapper to enable/disable states
3. Preventing any operation/test on offlined CPUs 
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
 drivers/cpuidle/test-cpuidle_latency.c     | 150 ++++++++++
 lib/Kconfig.debug                          |  10 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 310 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   1 +
 7 files changed, 479 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.25.4

