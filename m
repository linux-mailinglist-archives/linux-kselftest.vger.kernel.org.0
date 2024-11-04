Return-Path: <linux-kselftest+bounces-21356-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6129BABF0
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 06:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2191C20B61
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 05:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1861218C341;
	Mon,  4 Nov 2024 05:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m25UMVyy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84918167296;
	Mon,  4 Nov 2024 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696462; cv=none; b=MVHH6sKzgPiVoEwq1ARyAYrgEGd0qkgcVdqynJJbARQsDBsum/nBrT99GjK0fOD0WmGpiRkT2PJw/d5IynPpdrwJZxr5lk7YIhRdzAXsJGMTUMw/u+vzxTGtJsQriOEn3x3WilfVphfFs6l7L4Xv+ywLuqOY1vsMwWLbjwDTfK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696462; c=relaxed/simple;
	bh=ktDAHwazGWY+plW4eh0jRusrcAntuwF/4zFZNHFXc/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hG6bEhKqBVL4fFDW0JL3wNHVsL6LEdPhMQAGcDuUouds625LUhc2QKCHaYG1zNbL116w565hgqKR5aqKzrwwj/MnFZ/W9ZJqIiOwgKP/qSnobU5woV6pXSOlzgHLCFLl7qY3E6TR/znoxkHytqOOZeCCBQZZIVc13ORfajth4Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m25UMVyy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A44E01u019687;
	Mon, 4 Nov 2024 05:00:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=waXRDhrP74pyp3e+J
	NR0YrviqCskMEuMN4GhuoSU9zk=; b=m25UMVyy/qUNB3Ervmk1gGEJ8CZpE0kwu
	6ld17XagCkScvcqCeHThV4mDoFyZRRPAmDYyeBQIkNAPUDoXqHxsZidk1p0dUmmH
	dL33WjNLRuv1GcGg0qwTA8xXvj0A6lOfhcqPrHMDzIdyOsP+z0WudQWVbl0phlZw
	btb/0E4ineJ2ERE1mLL+ARSuLTgn0Uc/3tecINHO6Ihtqb5JGKFV8GnQjQq6M+RB
	Tau5mUYuVYA1rdCCdEhD2x3Gp2jlJF/ihssQheH+v9UZHZI1SOydOfC3mIlp6dOp
	5+M6sQHuE962ROx5HJvdWbWfBqS3Q30WlkZq1l3SkJhPWRp0GULMg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pjku8mxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:37 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A44wiuN003330;
	Mon, 4 Nov 2024 05:00:36 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pjku8mxh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A43gYa9024261;
	Mon, 4 Nov 2024 05:00:34 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42nxsxt2hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:34 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A450VWc27132622
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 05:00:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B1932004F;
	Mon,  4 Nov 2024 05:00:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62B7020040;
	Mon,  4 Nov 2024 05:00:23 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.56.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 05:00:22 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Subject: [PATCH 1/3] libbpf: Fix accessing the syscall argument on powerpc
Date: Mon,  4 Nov 2024 10:30:05 +0530
Message-ID: <20241104050007.13812-2-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104050007.13812-1-skb99@linux.ibm.com>
References: <20241104050007.13812-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fmgv3EWaqAv_zeu_UpHKqDmCVKtwyRI5
X-Proofpoint-ORIG-GUID: IuVlMS63keH3rEBA_qLKbXpo26Nc3OXw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=810
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040039

Since commit 7e92e01b7245 ("powerpc: Provide syscall wrapper"), powerpc
selects ARCH_HAS_SYSCALL_WRAPPER so let's use the generic implementation
of PT_REGS_SYSCALL_REGS().

Also, allow overriding PT_REGS_PARM1{_CORE}_SYSCALL for powerpc as
powerpc needs orig_gpr3, similar to s390 and arm64.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/lib/bpf/bpf_tracing.h | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index a8f6cd4841b0..933e1dab6c8f 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -287,6 +287,10 @@ struct pt_regs___arm64 {
  * section "Function Calling Sequence")
  */
 
+struct pt_regs___powerpc {
+	unsigned long orig_gpr3;
+} __attribute__((preserve_access_index));
+
 #define __PT_PARM1_REG gpr[3]
 #define __PT_PARM2_REG gpr[4]
 #define __PT_PARM3_REG gpr[5]
@@ -296,8 +300,6 @@ struct pt_regs___arm64 {
 #define __PT_PARM7_REG gpr[9]
 #define __PT_PARM8_REG gpr[10]
 
-/* powerpc does not select ARCH_HAS_SYSCALL_WRAPPER. */
-#define PT_REGS_SYSCALL_REGS(ctx) ctx
 #define __PT_PARM1_SYSCALL_REG orig_gpr3
 #define __PT_PARM2_SYSCALL_REG __PT_PARM2_REG
 #define __PT_PARM3_SYSCALL_REG __PT_PARM3_REG
@@ -307,6 +309,9 @@ struct pt_regs___arm64 {
 #if !defined(__arch64__)
 #define __PT_PARM7_SYSCALL_REG __PT_PARM7_REG /* only powerpc (not powerpc64) */
 #endif
+#define PT_REGS_PARM1_SYSCALL(x) (((const struct pt_regs___powerpc *)(x))->orig_gpr3)
+#define PT_REGS_PARM1_CORE_SYSCALL(x) \
+	BPF_CORE_READ((const struct pt_regs___powerpc *)(x), __PT_PARM1_SYSCALL_REG)
 
 #define __PT_RET_REG regs[31]
 #define __PT_FP_REG __unsupported__
-- 
2.43.5


