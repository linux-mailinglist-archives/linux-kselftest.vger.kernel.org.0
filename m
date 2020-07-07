Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7BC21722D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jul 2020 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbgGGP3x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jul 2020 11:29:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728955AbgGGP3w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jul 2020 11:29:52 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 067F3Ghu051693;
        Tue, 7 Jul 2020 11:29:25 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 324pxshwr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 11:29:24 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 067F6qAD013963;
        Tue, 7 Jul 2020 15:29:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 322h1h3gw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 15:29:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 067FTKUU53673996
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 15:29:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F113AE057;
        Tue,  7 Jul 2020 15:29:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EB1EAE045;
        Tue,  7 Jul 2020 15:29:18 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.70.197])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 15:29:18 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, srivatsa@csail.mit.edu,
        shuah@kernel.org, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 0/2] Selftest for cpuidle latency measurement
Date:   Tue,  7 Jul 2020 20:59:15 +0530
Message-Id: <20200707152917.10652-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_08:2020-07-07,2020-07-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 cotscore=-2147483648 suspectscore=0 adultscore=0
 mlxlogscore=623 spamscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070109
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
enables them one by one testing:
1. Keeping source CPU constant, iterates through all the CPUS measuring
   IPI latency for baseline (CPU is busy with "yes" workload) and the
   when the CPU is at rest
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
---Enabling state: 0---
SRC_CPU   DEST_CPU Base_IPI_Latency(ns) IPI_Latency(ns)
0            0          328                291
0            1         1500               1071
0            2         1070               1062
0            3         1557               1668
. . . .
Expected IPI latency(ns): 1000
Baseline Average IPI latency(ns): 1113
Observed Average IPI latency(ns): 1023
--Timeout Latency Test--
---Enabling state: 0---
Wakeup_src Baseline_delay(ns)  Delay(ns)
0            3134               2128
1            2275               2107
2            2222               2198
3            2421               2325
. . . .
Expected timeout(ns): 200
Baseline Average timeout diff(ns): 2513
Observed Average timeout diff(ns): 2189

Pratik Rajesh Sampat (2):
  cpuidle: Trace IPI based and timer based wakeup latency from idle
    states
  selftest/cpuidle: Add support for cpuidle latency measurement

 drivers/cpuidle/Makefile                   |   1 +
 drivers/cpuidle/test-cpuidle_latency.c     | 150 +++++++++++++
 lib/Kconfig.debug                          |  10 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 240 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   1 +
 7 files changed, 409 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.25.4

