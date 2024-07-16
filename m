Return-Path: <linux-kselftest+bounces-13776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785AA932591
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF5A1C21226
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jul 2024 11:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199491990C2;
	Tue, 16 Jul 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GKT+GRYS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526487CF16;
	Tue, 16 Jul 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721129231; cv=none; b=QzZ4fH85zheFfwkW2XlwD99xIxPKZl0UOkhUoEQ/18tQMDTLFXLwEAJvhQHRyno99u31ZP/8KY1kwelGbXuzqk6cKW+ZTrRXXoOC14E803f/0l2YtbKCTXr1y1Z5xavIxWM4rQfk7L10mOqDJR55K4wM1tBhDBFqkguzo7Jnlks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721129231; c=relaxed/simple;
	bh=06pZoshpVaDCWpVbnS4alVx8Yojx+yVOtahfoeJQMr4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c9X5FAmNtdF/6Cx9EolxA3WtSgMPhRwhyMwV/0eF60b5ynpQOJ0Qm2KUEJt1An73KZiZqvgxT5a+dbfI7mbQiVn/feRtMUCNEgqbiXm42BcmsifxyC9k10448MQFfwXgeshUbPbzQbTRw28Lt94XmZP8mVVJ6pGhToUnv4LT03s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GKT+GRYS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46GBQWu3001659;
	Tue, 16 Jul 2024 11:27:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=P96N3vH383vN0+zZAMqMKRSt12
	Td5N5n/7XfR+12Oc0=; b=GKT+GRYSTL9UjJvOyBJb6TV4Vc9wZ9zhvv8evFfECN
	HDGsJ6ZRNsm4kN4j2hJ38iAJ//+6iI7cz0Nbr/fupTF3sxbR3N4KGyH8QPdJk7mk
	gtvZD9yL4t0d5grfKZAKFrzA13oh6MPfp6GbtvqNXi8Ky97W967hoQ82eHSSb6Se
	vJ/gq4bf+vwIVobQfSkRxPYpOe4crfBpudOr4rCGYMti9DZDZ2lNrVjK/J1I+CGD
	rpaqNAGc8mnjFHf9VLqStwcOzrQptWe7Ls+aEUm0kHJlqpm+fWzAkCmpDVzHPU2b
	7sDkBzr1WF52gkD96hc1zKopQJz7NsHJWWmgXq6ifsrA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40dntyg9fj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 11:27:01 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46GBCETm023033;
	Tue, 16 Jul 2024 11:27:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40c64m3fyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jul 2024 11:27:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46GBQvcf21627340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jul 2024 11:26:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 22A2320043;
	Tue, 16 Jul 2024 11:26:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B1DB20040;
	Tue, 16 Jul 2024 11:26:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.220.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jul 2024 11:26:55 +0000 (GMT)
From: Akanksha J N <akanksha@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        rostedt@goodmis.org, naveen@kernel.org, akanksha@linux.ibm.com
Subject: [PATCH v1] selftests/ftrace: Skip test for optimized probes on PowerPC if Secure Boot is enabled
Date: Tue, 16 Jul 2024 16:56:51 +0530
Message-Id: <20240716112651.11345-1-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gHejGokwyHvEE4by6Njdh-KTPNs2AfzR
X-Proofpoint-ORIG-GUID: gHejGokwyHvEE4by6Njdh-KTPNs2AfzR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_19,2024-07-16_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407160083

Currently while accessing debugfs with Secure Boot enabled on PowerPC,
it is causing the kprobe_opt_types.tc test to fail. Below is the snippet
of the error:

+++ grep kernel_clone /sys/kernel/debug/kprobes/list
grep: /sys/kernel/debug/kprobes/list: Operation not permitted
++ PROBE=
+ '[' 2 -ne 0 ']'
+ kill -s 37 7595
++ SIG_RESULT=1
+ eval_result 1
+ case $1 in
+ prlog '	[\033[31mFAIL\033[0m]'
+ newline='\n'
+ '[' '	[\033[31mFAIL\033[0m]' = -n ']'
+ printf '	[\033[31mFAIL\033[0m]\n'
	[FAIL]

This is happening when secure boot is enabled, as it enables lockdown
by default. With lockdown, access to certain debug features and
filesystems like debugfs may be restricted or completely disabled.

To fix this, modify the test to check for Secure Boot status using
lsprop /proc/device-tree/ibm,secure-boot. And, skip execution of the
test on PowerPC if Secure Boot is enabled (00000002).

With this patch, test skips as unsupported:
=== Ftrace unit tests ===
[1] Register/unregister optimized probe	[UNSUPPORTED]

Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
index 9f5d99328086..87e2f81e46b8 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
@@ -10,6 +10,11 @@ x86_64)
 arm*)
 ;;
 ppc*)
+lsprop_output=$(lsprop /proc/device-tree/ibm,secure-boot)
+if echo "$lsprop_output" | grep -q "00000002"; then
+	echo "Secure Boot is enabled on PowerPC."
+	exit_unsupported
+fi
 ;;
 *)
   echo "Please implement other architecture here"
-- 
2.39.3 (Apple Git-146)


