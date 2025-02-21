Return-Path: <linux-kselftest+bounces-27155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1486AA3F390
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E0417CD19
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 11:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F6F209F41;
	Fri, 21 Feb 2025 11:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bbz5eR4g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F0209F40;
	Fri, 21 Feb 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740139104; cv=none; b=tquRmxHj8l/rvG6i4DxLIy5E7xri60AjB+ULhBWI0kMfF4yA9eBMf84AEuFElIGkY1ewqIOM0M+KzWUCTvHQgrJqymo9MsoxPkI1GQHInDJEyI67Q9zWthB8Yjp76Z64LUVE61avqqI5TeGjcrjMt9iKdLAiJW0/zui1fDnZlw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740139104; c=relaxed/simple;
	bh=Wre7DToNQmAYlH5+eD5XBZVqjCkB7Ti0uCOHtPbf8ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FmBnIS57NI9txtQxsOcrH2FFRsgMBK4aBPMk3sUvbER0Nd1itvv639dX7z+Z9AdLfPirrG6qm5rwme6WgkvTW13eUMv8ousmpXJGpmOGxYvM7YbxjxyoCJjvm7+lO6vHkvhnPSkw33llqDOfDoPWjDirA+le/P8lqn662NTfI4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bbz5eR4g; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51L8fbPT001453;
	Fri, 21 Feb 2025 11:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=3/EJjpBuSVpJ4Ie3e0BPWZe+0hwUL
	45gM0e0nvReiWI=; b=bbz5eR4goezrwpg5srUVP9ISoH5b6JnUr3sB9sHDg2t7R
	2F9boUMD7n7fGzBK9uLroI22MkuSc4IMR/nJfFgKSeQ0+mKbKUU87JQDqRv0w4V2
	RANb/nmBLnbW3c/5lZdhzeklHnNY51Lv5HtAxTr7vtu7ES5CzrdojGO3S/KKOV4m
	HdTn53R/a/3jm/obvk6VTC44HS+OH7kzuRTmTk1birLu8HH2NEAociqf+ll4oN3d
	2sQD4+XRvRdyM1S6RbFFlXfkEKdFJT+qwq402UOURiKwK9yL7T6hh8wU14IzAauS
	cAA0SLRHkc/GOJHIHuw128c2h5E512PxsMI3DILrQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w02yp4uw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:58:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51LAjA2L025287;
	Fri, 21 Feb 2025 11:58:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w090fss6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Feb 2025 11:58:15 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51LBwE97029660;
	Fri, 21 Feb 2025 11:58:14 GMT
Received: from sishan-bugs.osdevelopmeniad.oraclevcn.com (sishan-bug36880967.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.254.109])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 44w090fsnx-1;
	Fri, 21 Feb 2025 11:58:14 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        chris.hyser@oracle.com, sshegde@linux.ibm.com,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH v2 0/2] selftests: sched: Add default target support for sched
Date: Fri, 21 Feb 2025 11:57:48 +0000
Message-ID: <20250221115750.631990-1-sinadin.shan@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-21_03,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502210088
X-Proofpoint-ORIG-GUID: WlDt-8RLsFjEovumVZ4K7F6Dh-uWzOQ8
X-Proofpoint-GUID: WlDt-8RLsFjEovumVZ4K7F6Dh-uWzOQ8

This patch series introduces changes to add default build support for
the sched tests in selftests.

The only test under sched is cs_prctl_test which validates cookies when
core scheduling is in effect. This test fails on systems where core
scheduling is disabled. The patch series also modifies this behaviour to
gracefully skip the test on such systems.

For example, such a test skip would look like:
TAP version 13
1..1
 timeout set to 45
 selftests: sched: cs_prctl_test
 Checking for CONFIG_SCHED_CORE support
 Core scheduling not enabled in kernel, hence skipping tests
ok 1 selftests: sched: cs_prctl_test # SKIP

and a successful run:
TAP version 13
1..1
 timeout set to 45
 selftests: sched: cs_prctl_test
 Checking for CONFIG_SCHED_CORE support
 CONFIG_SCHED_CORE=y
.
.
.
 SUCCESS !!!
ok 1 selftests: sched: cs_prctl_test

Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
---
v2:
* Add patch to skip cs_prctl_test on core scheduling disabled systems
* v1 link: https://lore.kernel.org/all/20250219064658.449069-1-sinadin.shan@oracle.com
--- 

Sinadin Shan (2):
  selftests: sched: add sched as a default selftest target
  selftests: sched: skip cs_prctl_test for systems with core scheduling
    disabled

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/sched/cs_prctl_test.c | 29 ++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.43.5


