Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C69779A2E1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Sep 2023 07:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbjIKFg4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 01:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjIKFgz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 01:36:55 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C3510A;
        Sun, 10 Sep 2023 22:36:50 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38B5X9iA010461;
        Mon, 11 Sep 2023 05:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=powS5HRcXLqTXorjnWFvAJPdjtsxApYzkCpUjdalHkw=;
 b=dssHz3hr9nkE0YH26co5ag+j7kwWQS11Z9hLtGEKLLSwReGow4OvsueHRlHXElwhRLJa
 a/UlyGLlczdoLioDlc3JDdGZsPwfeD07P1gu7xz5+aOrsi1pcK9/VOgNGac5q47sa8OW
 6BjqtXZ3HV+/c4CdeNqAfnlCrMUffl2YBRZiICeaX8uIcMBMqMUSD7SOng9uAIhykCEZ
 2VEOb6h1UZO/FM+bSVRzSTgL49x89cvVZ4bg17evJ0AKcEitwWrsQznL7+0cZYRlrcOF
 hELo2Ja1wHaefPBZrtVYrCtqLnn2NaEa4m79y4Tfm1ih+My+4iBm4qEnAgdaAkkkcflF Jw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1vuf84su-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:36:33 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38B5Z4OQ018621;
        Mon, 11 Sep 2023 05:36:32 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t1vuf84pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:36:31 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38B4KF8j012083;
        Mon, 11 Sep 2023 05:36:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dy8adx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Sep 2023 05:36:30 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38B5aShV12452538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Sep 2023 05:36:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3EE8F20040;
        Mon, 11 Sep 2023 05:36:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F4672004B;
        Mon, 11 Sep 2023 05:36:25 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com.com (unknown [9.171.42.194])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 11 Sep 2023 05:36:25 +0000 (GMT)
From:   Aboorva Devarajan <aboorvad@linux.vnet.ibm.com>
To:     aboorvad@linux.vnet.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        rmclure@linux.ibm.com, arnd@arndb.de, joel@jms.id.au,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        pratik.r.sampat@gmail.com
Cc:     sshegde@linux.vnet.ibm.com, srikar@linux.vnet.ibm.com
Subject: [RFC v3 0/2] CPU-Idle latency selftest framework
Date:   Mon, 11 Sep 2023 11:06:18 +0530
Message-Id: <20230911053620.87973-1-aboorvad@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AiFXolyQq-kRKwtTnFsqmHKmO7onNZs3
X-Proofpoint-GUID: IQT2pzrBtztzNQKqj3s3CiDyfYKy0bGM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-11_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309110051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changelog: v2 -> v3

* Minimal code refactoring
* Rebased on v6.6-rc1

RFC v1: 
https://lore.kernel.org/all/20210611124154.56427-1-psampat@linux.ibm.com/

RFC v2:
https://lore.kernel.org/all/20230828061530.126588-2-aboorvad@linux.vnet.ibm.com/

Other related RFC:
https://lore.kernel.org/all/20210430082804.38018-1-psampat@linux.ibm.com/

Userspace selftest:
https://lkml.org/lkml/2020/9/2/356

----

A kernel module + userspace driver to estimate the wakeup latency
caused by going into stop states. The motivation behind this program is
to find significant deviations behind advertised latency and residency
values.

The patchset measures latencies for two kinds of events. IPIs and Timers
As this is a software-only mechanism, there will be additional latencies
of the kernel-firmware-hardware interactions. To account for that, the
program also measures a baseline latency on a 100 percent loaded CPU
and the latencies achieved must be in view relative to that.

To achieve this, we introduce a kernel module and expose its control
knobs through the debugfs interface that the selftests can engage with.

The kernel module provides the following interfaces within
/sys/kernel/debug/powerpc/latency_test/ for,

IPI test:
    ipi_cpu_dest = Destination CPU for the IPI
    ipi_cpu_src = Origin of the IPI
    ipi_latency_ns = Measured latency time in ns
Timeout test:
    timeout_cpu_src = CPU on which the timer to be queued
    timeout_expected_ns = Timer duration
    timeout_diff_ns = Difference of actual duration vs expected timer

Sample output is as follows:

# --IPI Latency Test---
# Baseline Avg IPI latency(ns): 2720
# Observed Avg IPI latency(ns) - State snooze: 2565
# Observed Avg IPI latency(ns) - State stop0_lite: 3856
# Observed Avg IPI latency(ns) - State stop0: 3670
# Observed Avg IPI latency(ns) - State stop1: 3872
# Observed Avg IPI latency(ns) - State stop2: 17421
# Observed Avg IPI latency(ns) - State stop4: 1003922
# Observed Avg IPI latency(ns) - State stop5: 1058870
#
# --Timeout Latency Test--
# Baseline Avg timeout diff(ns): 1435
# Observed Avg timeout diff(ns) - State snooze: 1709
# Observed Avg timeout diff(ns) - State stop0_lite: 2028
# Observed Avg timeout diff(ns) - State stop0: 1954
# Observed Avg timeout diff(ns) - State stop1: 1895
# Observed Avg timeout diff(ns) - State stop2: 14556
# Observed Avg timeout diff(ns) - State stop4: 873988
# Observed Avg timeout diff(ns) - State stop5: 959137

Aboorva Devarajan (2):
  powerpc/cpuidle: cpuidle wakeup latency based on IPI and timer events
  powerpc/selftest: Add support for cpuidle latency measurement

 arch/powerpc/Kconfig.debug                    |  10 +
 arch/powerpc/kernel/Makefile                  |   1 +
 arch/powerpc/kernel/test_cpuidle_latency.c    | 154 ++++++
 tools/testing/selftests/powerpc/Makefile      |   1 +
 .../powerpc/cpuidle_latency/.gitignore        |   2 +
 .../powerpc/cpuidle_latency/Makefile          |   6 +
 .../cpuidle_latency/cpuidle_latency.sh        | 443 ++++++++++++++++++
 .../powerpc/cpuidle_latency/settings          |   1 +
 8 files changed, 618 insertions(+)
 create mode 100644 arch/powerpc/kernel/test_cpuidle_latency.c
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/.gitignore
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/Makefile
 create mode 100755 tools/testing/selftests/powerpc/cpuidle_latency/cpuidle_latency.sh
 create mode 100644 tools/testing/selftests/powerpc/cpuidle_latency/settings

-- 
2.25.1

