Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E143933B1B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Mar 2021 12:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhCOLtO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Mar 2021 07:49:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:64246 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhCOLsl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Mar 2021 07:48:41 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FBYefu133895;
        Mon, 15 Mar 2021 07:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=cflSiQnM0VpVtJ6xtAED+IBQIVCQYfh6+EN3o3Yx+eM=;
 b=UguHRoIuoNSXjCU/hQdL3PtRPqs8DQAzSUHKEeMOo3RaAuNdasuxCZ4pKoADBeVaUS9H
 SK62N9QrLGrvSbst6ksPKCsH6d/AaGXidaQ5A27I4ayn0RKkjsCT8Qo1bflwSCsjSRw1
 fmUKAYQXhGi7Ad9fw+DvFzITYrQzPL31L/TT/SzLl6za+W3Tkj6NC/8fgv02rC8KhhO1
 7x7lZBOgSFN2CvQ1XahBS61ZdspBx0YlusuMrKi7qZoHHM+yUV6rzxW2WmQ1F98+wOkK
 fR3PV76m1RvAYHFO9ziZx1d8Zuu39+/Mi+VFosQQegtx4HumxVK+5WtYurEwyoG2FoC+ zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379yhqkqxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 07:48:37 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12FBaUF6144777;
        Mon, 15 Mar 2021 07:48:36 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 379yhqkqwh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 07:48:36 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12FBgk4u011093;
        Mon, 15 Mar 2021 11:48:34 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04ams.nl.ibm.com with ESMTP id 378n18htkf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Mar 2021 11:48:34 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12FBmVAj25625038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Mar 2021 11:48:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 383915204F;
        Mon, 15 Mar 2021 11:48:31 +0000 (GMT)
Received: from pratiks-thinkpad.ibmuc.com (unknown [9.85.95.254])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id B58015204E;
        Mon, 15 Mar 2021 11:48:28 +0000 (GMT)
From:   Pratik Rajesh Sampat <psampat@linux.ibm.com>
To:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shuah@kernel.org,
        ego@linux.vnet.ibm.com, svaidy@linux.ibm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, pratik.r.sampat@gmail.com,
        psampat@linux.ibm.com
Subject: [RFC 0/2] CPU-Idle latency selftest framework
Date:   Mon, 15 Mar 2021 17:18:25 +0530
Message-Id: <20210315114827.46036-1-psampat@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_03:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011 phishscore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103150081
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
 tools/testing/selftests/cpuidle/cpuidle.sh | 316 +++++++++++++++++++++
 tools/testing/selftests/cpuidle/settings   |   2 +
 7 files changed, 493 insertions(+)
 create mode 100644 drivers/cpuidle/test-cpuidle_latency.c
 create mode 100644 tools/testing/selftests/cpuidle/Makefile
 create mode 100755 tools/testing/selftests/cpuidle/cpuidle.sh
 create mode 100644 tools/testing/selftests/cpuidle/settings

-- 
2.17.1

