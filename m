Return-Path: <linux-kselftest+bounces-27529-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08CFCA44C09
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 21:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96EEA3AE67D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 20:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF0520F08F;
	Tue, 25 Feb 2025 20:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JE2z64t7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937C620F06D;
	Tue, 25 Feb 2025 20:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740514174; cv=none; b=FuljLAoF+hbm27Ve167D0eXOn4LecsKxR35p43GOtvo1A2RmtCzzIBVPHmV8rr17dXWyRTsQl3xDC0LJ/e/24x5C8M79zTH8wUsofsuYcpoS6IuSMkQ3la/4PVYbnqoKmxCJDTMoenl5DNbTUP7UYw40+th914kJGZ1NsXB3gr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740514174; c=relaxed/simple;
	bh=dmRYgbBgNbE0KIqy2IkqRL4dfNeKhxJpfjAYZ1perr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvKR6xicNM0nbOf0hcNH40M1elftQu9IqEdcLl3y68Q54W1jyBOUfBS0BHCt8gM1AGJaDf/d+uQKROy6C8jm2C5O2A3rfyYWZawrp0ZNHpiDVkcdFq7z1LXZjVjjNzuGY8Ptvc1zHWVOKQS+YiG+r2xKCziWrq3DATpVTLRQ65U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JE2z64t7; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PIXtPx013169;
	Tue, 25 Feb 2025 20:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=Xj6W16NaZnM+zUJ8G5K8YCYzStAxq
	s0M7oAS0qsagM0=; b=JE2z64t7LlBQSSzAdT5iR3X0YqwBYcFkxEB7YRWq/knh2
	4MqE6zg92p3IbF4YHJSC7KRIZOUWJBC/S+NbM0hhXvFVAdMkSC3R1YItrr4uypY/
	weo4cAw9P2L+HaOc23ogM5vFl2wzpmMWU8JmtjU1WOlU85doUQIFZBoiO89yRi/3
	fStIhobY5j36JoI6EgUcCWWB2Y1leEzz7+EFuhzDnD3DOf7ugMVjcqR6BfVu3PaQ
	M1IQaQhwYi3zbNQ/qtfVTPRq8bmxiCozKc0zXQJJavo2JeTz8u6Vq/owbiDZAXUy
	5LoE5at2836gVTzDvLRbuBswkX3SYqiubTZ5dkgjA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y6mbpa78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:09:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PJLldY025436;
	Tue, 25 Feb 2025 20:09:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51g9ys3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 20:09:26 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51PK9QpT011891;
	Tue, 25 Feb 2025 20:09:26 GMT
Received: from sishan-generic.osdevelopmeniad.oraclevcn.com (sishan-generic.appad1iad.osdevelopmeniad.oraclevcn.com [100.100.231.227])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 44y51g9yrn-1;
	Tue, 25 Feb 2025 20:09:26 +0000
From: Sinadin Shan <sinadin.shan@oracle.com>
To: shuah@kernel.org, sshegde@linux.ibm.com, chris.hyser@oracle.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinadin Shan <sinadin.shan@oracle.com>
Subject: [PATCH v3 0/2] selftests: sched: Add default target support for sched
Date: Tue, 25 Feb 2025 20:09:08 +0000
Message-ID: <20250225200910.260569-1-sinadin.shan@oracle.com>
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
 definitions=2025-02-25_06,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250122
X-Proofpoint-ORIG-GUID: r-lM0GTdM3q-m3oZgTd3oJ5SuSNplh8T
X-Proofpoint-GUID: r-lM0GTdM3q-m3oZgTd3oJ5SuSNplh8T

This patch series introduces changes to add default build support for
the sched tests in selftests.

The only test under sched is cs_prctl_test which validates cookies when
core scheduling is in effect. This test fails on systems where core
scheduling is disabled. The patch series also modifies this behaviour to
gracefully skip the test on such systems.

A system with core scheduling disabled would skip the test like:
~# ./run_kselftest.sh
TAP version 13
1..1
 timeout set to 45
 selftests: sched: cs_prctl_test
 prctl failed: Invalid argument
 Core sched not supported, hence skipping tests
ok 1 selftests: sched: cs_prctl_test # SKIP

Signed-off-by: Sinadin Shan <sinadin.shan@oracle.com>
---
v3:
* Use prctl to check core sched support instead of config
* v2 link: https://lore.kernel.org/all/20250221115750.631990-1-sinadin.shan@oracle.com/
v2:
* Add patch to skip cs_prctl_test on core scheduling disabled systems
* v1 link: https://lore.kernel.org/all/20250219064658.449069-1-sinadin.shan@oracle.com
---

Sinadin Shan (2):
  selftests: sched: add sched as a default selftest target
  selftests: sched: skip cs_prctl_test for systems with core scheduling
    disabled

 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/sched/cs_prctl_test.c | 34 ++++++++++++++++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.43.5


