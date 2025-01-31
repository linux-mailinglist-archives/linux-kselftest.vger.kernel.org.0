Return-Path: <linux-kselftest+bounces-25463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8231AA239B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA88B167DE9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 07:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC845143888;
	Fri, 31 Jan 2025 07:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CFu4PSAZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346B824B28;
	Fri, 31 Jan 2025 07:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738307170; cv=none; b=M4ViVT591VI2eEOW5oT8zUXts3at61llnY2KizRYwtTZ7QQaJQlauftXZ87SymaFZ7bOkJFR7Pj0B9R/oFIdv4x5rPChGPWkSMXYZeMNnGjymkx4i6sbkByww23B5QJGjvxbxirLeWqA729ufRO+GbzmKfiVKzWkhvC3tP/5jdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738307170; c=relaxed/simple;
	bh=6DumR7Mge3kd2XSzM7I4GxupibJ2zmTPozvXKs7+JPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUtFeagLGNYva0woNaUX/4SkpPvW5R49t1JFaPlPVfXtLp3FmhUCWbL1qIIfznZ81XcL7LABQXMI9G4KYCo57oEHiHeijnMqxhFHCncPSlkMkcan5ueezGqOGNjRyxoh08kuIZ4zERpas9w9PkpUA/EOyGh43QGdsjUxlO03chE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CFu4PSAZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50V2Odtn016645;
	Fri, 31 Jan 2025 07:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=53P03y6wzOUcXrafDARHZxxZFZINIDTYpG0LthlED
	8c=; b=CFu4PSAZFsPKaGH7dLfpVIEG4dYGFjj29hxYeZqW10R+xfbFvmHZu4V9g
	5Ue2DQtsGG1CP0wVNif7fEUgWscBF86VR8QLSbjBtYjqEnKtv/38d+sZ7kslUoRX
	HznZqv4Y9jSFz1ZrX48RklhCa1YTaHBdzLYCsZch03mY77JVYpiDEOhK3VNkGmIU
	pFPcweb1UmOj2mYX+caoFPS+jEY/d1ybldiWM/s0fCangDZqd5bUGEn60KbRQTIZ
	5FcWW7X3FstXe6RbGwKxSUyzb4GvXurKzEyeRv5UI6aJsFZubXEgYqS+7sWYitz9
	kH4eymVS6bEVqGXd/g79DFPjtSZkQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk913e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 07:05:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50V74xJV012444;
	Fri, 31 Jan 2025 07:05:42 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44gmk913e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 07:05:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50V3bCrC013864;
	Fri, 31 Jan 2025 07:05:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44gf93acv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jan 2025 07:05:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50V75dKA40239450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jan 2025 07:05:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 12518200C5;
	Fri, 31 Jan 2025 07:05:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7E6200C4;
	Fri, 31 Jan 2025 07:05:29 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.60.42])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jan 2025 07:05:29 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Subject: [PATCH v2 1/2] selftests/bpf: Define SYS_PREFIX for powerpc
Date: Fri, 31 Jan 2025 12:35:21 +0530
Message-ID: <7192d6aa9501115dc242435970df82b3d190f257.1738302337.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: I0D88icMCqPAshbr_m6zzehm50ajZmCf
X-Proofpoint-ORIG-GUID: zVYdDYEerUlTTlmtIiJQ4mwKynbTRaT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-31_02,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 phishscore=0 priorityscore=1501 mlxlogscore=825
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2501310051

Since commit 7e92e01b7245 ("powerpc: Provide syscall wrapper")
landed in v6.1, syscall wrapper is enabled on powerpc. Commit
94746890202c ("powerpc: Don't add __powerpc_ prefix to syscall 
entry points") , that drops the prefix to syscall entry points,
also landed in the same release. So, add the missing empty
SYS_PREFIX prefix definition for powerpc, to fix some fentry
and kprobe selftests.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index f45f4352f..02c9f7964 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -172,6 +172,9 @@
 #elif defined(__TARGET_ARCH_riscv)
 #define SYSCALL_WRAPPER 1
 #define SYS_PREFIX "__riscv_"
+#elif defined(__TARGET_ARCH_powerpc)
+#define SYSCALL_WRAPPER 1
+#define SYS_PREFIX ""
 #else
 #define SYSCALL_WRAPPER 0
 #define SYS_PREFIX "__se_"
-- 
2.43.5


