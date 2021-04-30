Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09ED536F716
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Apr 2021 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbhD3I3I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Apr 2021 04:29:08 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5326 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhD3I3F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Apr 2021 04:29:05 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13U83EqE157389;
        Fri, 30 Apr 2021 04:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=fE9zG0FYYuQF2wymHMuGmv1VN1rgn/UZKsrdJ55RUq0=;
 b=YA2CDqftoRLPHX48nQG3uF4e9EYYhfw2N934egBUlEllInh+ewsM7HACXHTT9c1bs0co
 zFI4lpdVWGg/caaiM+NnLuR+9KNtBaTk8AR8ibJ/M5vUWfKxxwnrwyGbjWmObB4HXUmh
 FyD1YRqoUXMVmc5k1uyqGt+l2L+JGYEc5sVJbHHeAa8/Ijb1pL8NcAlbdYY7ysuJA/mM
 DeuncxTPTlg4BbLvk+V6Dq8+7KPVZvutLQ1jZPf2slf6nnuwe30inlDSlOkhHBITieMy
 yUMfXHHDKNwxigNoWKA09lbksHJ6uowuTF2bNwG4x3Xhuq16is4GPm4rY2RBI9DbcQeF Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3889t272wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 04:28:12 -0400
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13U83ara162593;
        Fri, 30 Apr 2021 04:28:12 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3889t272vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 04:28:12 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13U8JUU8002817;
        Fri, 30 Apr 2021 08:28:10 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 384akhay0v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Apr 2021 08:28:10 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13U8RhYT29688290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 08:27:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2EA7C52057;
        Fri, 30 Apr 2021 08:28:08 +0000 (GMT)
Received: from pratiks-thinkpad.in.ibm.com (unknown [9.85.87.236])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BE81552050;
        Fri, 30 Apr 2021 08:28:05 +0000 (GMT)
From:   "Pratik R. Sampat" <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        dsmythies@telus.net, dedekind1@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        pratik.r.sampat@gmail.com, psampat@linux.ibm.com
Subject: [PATCH v5 0/2] CPU-Idle latency selftest framework
Date:   Fri, 30 Apr 2021 13:58:02 +0530
Message-Id: <20210430082804.38018-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.30.2
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zFLV_2iD0pfcz4rCzmsbKIT057gkM308
X-Proofpoint-ORIG-GUID: 8QIB4FOBu4RV4Wea_UEHzSEtDS8Byf_F
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-30_05:2021-04-28,2021-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300056
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog RFC v4 --> PATCH v5:
1. Added a CPU online check prior to parsing the CPU topology to avoid
   parsing topologies for CPUs unavailable for the latency test
2. Added comment describing the selftest in cpuidle.sh

As I have made changes to cpuidle.sh's working, hence dropping
"Reviewed-by" from Doug Smythies for the second patch, while retaining
it for the first patch.

RFC v4: https://lkml.org/lkml/2021/4/12/99
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

Pratik R. Sampat (2):
  cpuidle: Extract IPI based and timer based wakeup latency from idle
    states
  selftest/cpuidle: Add support for cpuidle latency measurement

 drivers/cpuidle/Makefile                   |   1 +
 drivers/cpuidle/test-cpuidle_latency.c     | 157 ++++++++
 lib/Kconfig.debug                          |  10 +
 tools/testing/selftests/Makefile           |   1 +
 tools/testing/selftests/cpuidle/Makefile   |   6 +
 tools/testing/selftests/cpuidle/cpuidle.sh | 414 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   2 +
 7 files changed, 591 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.17.1

