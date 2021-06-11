Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3473A4228
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jun 2021 14:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhFKMoN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Jun 2021 08:44:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:24234 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230382AbhFKMoJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Jun 2021 08:44:09 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15BCY9uL009855;
        Fri, 11 Jun 2021 08:42:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=a5WRh0MAjG2DP5aTknLcy+PSuacHavo64fKGsZkzwF0=;
 b=nGac9Bjy5ASQhxp1Z+a18JnPsEAPz57D8F2IddrEyRghCNNItZYMWh4dEc4lOOd1JdzU
 xu8HLb27IibM0T5WE4h95HPLsqj2/mgBf5m1zkESqRlluxh8gF80hC8FV4AZKKzZcYEK
 8NAA060EEY/RbpjapjXPQk0z0/f1vfJCQE1qpdm0LQwQ64hj//9Y70fl5rM7DSZveYYj
 +Jv5jX07KIENM7C/sXvM5nd3q95Dw+797uOA2iukDWsBWoNq20kzp08sTWYDOMK53Zrv
 lNWZTl+NS+qnsrCgubWDp4b2Wv1kabGTHlDruOeQghBsNwMWfk4cbszBgHnvAe1583D6 8Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3947x987s2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:42:01 -0400
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15BCZJLC013549;
        Fri, 11 Jun 2021 08:42:01 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3947x987r5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 08:42:01 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15BCVvt5004892;
        Fri, 11 Jun 2021 12:41:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3936ns0j0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Jun 2021 12:41:59 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15BCfv0q28049792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Jun 2021 12:41:57 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3D5B752050;
        Fri, 11 Jun 2021 12:41:57 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.85.83.107])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 613A55206D;
        Fri, 11 Jun 2021 12:41:55 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     mpe@ellerman.id.au, shuah@kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        psampat@linux.ibm.com, pratik.r.sampat@gmail.com
Subject: [RFC 0/2] CPU-Idle latency selftest framework
Date:   Fri, 11 Jun 2021 18:11:52 +0530
Message-Id: <20210611124154.56427-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NdzjWYErMp3zz-_gDPdC9Vim00ndpAAZ
X-Proofpoint-ORIG-GUID: li3M71lYsUdbBpi0D5AZavIakVCRF0PR
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-11_05:2021-06-11,2021-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106110080
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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
# Observed Average IPI latency(ns) - Snooze: 3265
# Observed Average IPI latency(ns) - Stop0_lite: 3507
# Observed Average IPI latency(ns) - Stop0: 3739
# Observed Average IPI latency(ns) - Stop2: 3807
# Observed Average IPI latency(ns) - Stop4: 17070
# Observed Average IPI latency(ns) - Stop5: 1038174
# 
# --Timeout Latency Test--
# Baseline Average timeout diff(ns): 1420
# Observed Average timeout diff(ns) - Snooze: 1640
# Observed Average timeout diff(ns) - Stop0_lite: 1764
# Observed Average timeout diff(ns) - Stop0: 1715
# Observed Average timeout diff(ns) - Stop2: 1845
# Observed Average timeout diff(ns) - Stop4: 16581
# Observed Average timeout diff(ns) - Stop5: 939977

Pratik R. Sampat (2):
  powerpc/cpuidle: Extract IPI based and timer based wakeup latency from
    idle states
  powerpc/selftest: Add support for cpuidle latency measurement

 arch/powerpc/kernel/Makefile                  |   1 +
 arch/powerpc/kernel/test-cpuidle_latency.c    | 157 +++++++
 lib/Kconfig.debug                             |  10 +
 tools/testing/selftests/powerpc/Makefile      |   1 +
 .../powerpc/cpuidle_latency/.gitignore        |   2 +
 .../powerpc/cpuidle_latency/Makefile          |   6 +
 .../cpuidle_latency/cpuidle_latency.sh        | 419 ++++++++++++++++++
 .../powerpc/cpuidle_latency/settings          |   1 +
 8 files changed, 597 insertions(+)
 create mode 100644 arch/powerpc/kernel/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/Makefile
 create mode 100755 tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/settings

-- 
2.17.1

