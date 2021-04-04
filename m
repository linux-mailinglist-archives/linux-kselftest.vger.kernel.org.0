Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5221353773
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Apr 2021 10:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhDDIeN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Apr 2021 04:34:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3134 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229861AbhDDIeN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Apr 2021 04:34:13 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1348XgBK074889;
        Sun, 4 Apr 2021 04:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=OHi2vwctu5KRILp+KYAuShu5xxEofmX7L+tcwpSherQ=;
 b=QxJe5/a2eGvqulK4X8FH0znoVN+vMnZj9YiQYpLGt8Jzbeq5c7cXi00BXL3dffwPeJF8
 tPJeU0th0Va+9KAsIw+zENPr/cz7OkgJzRLvYU2C6ove1K9NbH5MfN/77TOlm7rFuRpr
 oymPAGMmjarJgNEFYf3+CH1ndhajXnFEtapFMFn/bTBr3ZzKY9zIlUjnKMNd/v/61ilZ
 i1Hu5OHF7n8kRt058ya7coEkw40XPe31KeRBS0NqFU6U7toUCjg68OOmI8rMLvaT4QW2
 DxdFjpcbghM6JlafISam1ZCf0YpjHR4xHFos/QDbvU9yUeaps3RSU+kVRQ5IT+j/jRuI 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5bx4m71-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Apr 2021 04:34:04 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1348Y39q075977;
        Sun, 4 Apr 2021 04:34:03 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37q5bx4m6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Apr 2021 04:34:03 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 1348Xggb000725;
        Sun, 4 Apr 2021 08:34:01 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 37q2y9g7hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 04 Apr 2021 08:34:01 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1348Xw1Q22938088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 4 Apr 2021 08:33:58 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2FB084C040;
        Sun,  4 Apr 2021 08:33:58 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A32F4C044;
        Sun,  4 Apr 2021 08:33:55 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.90.174])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  4 Apr 2021 08:33:55 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        dsmythies@telus.net, ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        psampat@linux.ibm.com
Subject: [RFC v3 0/2] CPU-Idle latency selftest framework
Date:   Sun,  4 Apr 2021 14:03:52 +0530
Message-Id: <20210404083354.23060-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: M2wbZFKqMMmK2AqBxP7D4A6Xy34zCsvN
X-Proofpoint-ORIG-GUID: _FWaEj3xlXnVbkWZmODaSf403vnSq3Oc
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-04_01:2021-04-01,2021-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104030000 definitions=main-2104040058
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog
RFC v2-->v3

Based on comments by Doug Smythies,
1. Changed commit log to reflect the test must be run as super user.
2. Added a comment specifying a method to run the test bash script
without recompiling.
3. Enable all the idle states after the experiments are completed so
that the system is in a coherent state after the tests have run
4. Correct the return status of a CPU that cannot be off-lined.

RFC v2: https://lkml.org/lkml/2021/4/1/615
---
A kernel module + userspace driver to estimate the wakeup latency
caused by going into stop states. The motivation behind this program is
to find significant deviations behind advertised latency and residency
values.

The patchset measures latencies for two kinds of events. IPIs and Timers
As this is a software-only mechanism, there will additional latencies of
the kernel-firmware-hardware interactions. To account for that, the
program also measures a baseline latency on a 100 percent loaded CPU
and the latencies achieved must be in view relative to that.

To achieve this, we introduce a kernel module and expose its control
knobs through the debugfs interface that the selftests can engage with.

The kernel module provides the following interfaces within
/sys/kernel/debug/latency_test/ for,

IPI test:
    ipi_cpu_dest = Destination CPU for the IPI
    ipi_cpu_src = Origin of the IPI
    ipi_latency_ns = Measured latency time in ns
Timeout test:
    timeout_cpu_src = CPU on which the timer to be queued
    timeout_expected_ns = Timer duration
    timeout_diff_ns = Difference of actual duration vs expected timer

Sample output on a POWER9 system is as follows:
# --IPI Latency Test---
# Baseline Average IPI latency(ns): 3114
# Observed Average IPI latency(ns) - State0: 3265
# Observed Average IPI latency(ns) - State1: 3507
# Observed Average IPI latency(ns) - State2: 3739
# Observed Average IPI latency(ns) - State3: 3807
# Observed Average IPI latency(ns) - State4: 17070
# Observed Average IPI latency(ns) - State5: 1038174
# Observed Average IPI latency(ns) - State6: 1068784
# 
# --Timeout Latency Test--
# Baseline Average timeout diff(ns): 1420
# Observed Average timeout diff(ns) - State0: 1640
# Observed Average timeout diff(ns) - State1: 1764
# Observed Average timeout diff(ns) - State2: 1715
# Observed Average timeout diff(ns) - State3: 1845
# Observed Average timeout diff(ns) - State4: 16581
# Observed Average timeout diff(ns) - State5: 939977
# Observed Average timeout diff(ns) - State6: 1073024


Things to keep in mind:

1. This kernel module + bash driver does not guarantee idleness on a
   core when the IPI and the Timer is armed. It only invokes sleep and
   hopes that the core is idle once the IPI/Timer is invoked onto it.
   Hence this program must be run on a completely idle system for best
   results

2. Even on a completely idle system, there maybe book-keeping tasks or
   jitter tasks that can run on the core we want idle. This can create
   outliers in the latency measurement. Thankfully, these outliers
   should be large enough to easily weed them out.

3. A userspace only selftest variant was also sent out as RFC based on
   suggestions over the previous patchset to simply the kernel
   complexeity. However, a userspace only approach had more noise in
   the latency measurement due to userspace-kernel interactions
   which led to run to run variance and a lesser accurate test.
   Another downside of the nature of a userspace program is that it
   takes orders of magnitude longer to complete a full system test
   compared to the kernel framework.
   RFC patch: https://lkml.org/lkml/2020/9/2/356

4. For Intel Systems, the Timer based latencies don't exactly give out
   the measure of idle latencies. This is because of a hardware
   optimization mechanism that pre-arms a CPU when a timer is set to
   wakeup. That doesn't make this metric useless for Intel systems,
   it just means that is measuring IPI/Timer responding latency rather
   than idle wakeup latencies.
   (Source: https://lkml.org/lkml/2020/9/2/610)
   For solution to this problem, a hardware based latency analyzer is
   devised by Artem Bityutskiy from Intel.
   https://youtu.be/Opk92aQyvt0?t=8266
   https://intel.github.io/wult/

Pratik Rajesh Sampat (2):
  cpuidle: Extract IPI based and timer based wakeup latency from idle
    states
  selftest/cpuidle: Add support for cpuidle latency measurement

 drivers/cpuidle/Makefile                   |   1 +
 drivers/cpuidle/test-cpuidle_latency.c     | 157 ++++++++++
 lib/Kconfig.debug                          |  10 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 326 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   2 +
 7 files changed, 503 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.17.1

