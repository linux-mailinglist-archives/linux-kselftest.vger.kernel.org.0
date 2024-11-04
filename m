Return-Path: <linux-kselftest+bounces-21355-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4299BABEE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 06:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA5D3B20C41
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 05:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD4918C02E;
	Mon,  4 Nov 2024 05:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G4c4zK2s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8C10F1;
	Mon,  4 Nov 2024 05:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730696460; cv=none; b=e3j4awykzEGjwfeEiTATOewtTIoANKJwI8AD3bdxtq8oHiKq45jqmsb5xvXfKbW6fmEo12Ee7+xjyd1BgkrjHnEiFpLjhOJJ8pkETTVeFu2JkFH/ivzA9gzzbio62fPQo3DEEl/cfS3DEGOBRPzx/CVYLSLvLWsjqwOLTomCayU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730696460; c=relaxed/simple;
	bh=Rm82q0ZknfUmj4kwcWzzFUkJM8pgl/vkFS6bUCrEUQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rapgRLU29BLs7qxegOUxQfFrxyeLJpP5O7uL42ElrzL6NNDBKrnFoByWOSgNJMNRKLR+pPir+La5+uP2ilDKEY2HxbE2YqBCANDi+rCS7qTxS1LnkE3lFOF/NtL14KHiAWziGlyBfF1ihZ+lf6dQyXGFz3jkI1qgoY18cCLs3E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G4c4zK2s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A44E01v019687;
	Mon, 4 Nov 2024 05:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=e70GGPQYM1V4LtEUN
	OoedzvOzqQVu1Uij7dITb52iSY=; b=G4c4zK2sKMhI+BnKpH8F+9FJpuofLwJy0
	EXgkiuzFsKBdRZO+ermeTo6GTX+eEm4bJ4HgNgPN1pC6LUd8fksGK6WC8OVs94OR
	TtbFqEhmWOOWcAZwkIUddVKxS2qhMqoF2TxL338/nb7v1Cf8AVHNfsIklDE8kaUN
	GIavd0uj/hBJLx5y4aUmcovIYR267YtNOtAKWaJFK6L4n1wBQJdbuzn2FGyLBkgL
	yH9nfZp4qSkuqtUe58tMfdV+Re5JZsc1RY0RPKTDv4UPl0N46FVRHqDVix4zI1fj
	4zadDHnpT/C7SVsEDF1bqsKi5poUOrGxU8yQ/0J/I/K/BlczGFx6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pjku8my1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A450g8b006135;
	Mon, 4 Nov 2024 05:00:42 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42pjku8mxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A3GYXKY024243;
	Mon, 4 Nov 2024 05:00:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42nxds1j2w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Nov 2024 05:00:41 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A450evS34079428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Nov 2024 05:00:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F267920049;
	Mon,  4 Nov 2024 05:00:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 31E1A2004B;
	Mon,  4 Nov 2024 05:00:32 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.56.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Nov 2024 05:00:31 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, shuah@kernel.org, mykolal@fb.com
Subject: [PATCH 2/3] libbpf: Remove powerpc prefix from syscall function names
Date: Mon,  4 Nov 2024 10:30:06 +0530
Message-ID: <20241104050007.13812-3-skb99@linux.ibm.com>
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
X-Proofpoint-GUID: gHA9h9E6M1FDMEIDMwKuHaHDW1mQsKkB
X-Proofpoint-ORIG-GUID: nsJVGQHgJ0gwUPAZh_NGiCTYcTJeaz35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 mlxlogscore=806
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411040039

Since commit 94746890202cf ("powerpc: Don't add __powerpc_ prefix to
syscall entry points") drops _powerpc prefix to syscall entry points,
even though powerpc now supports syscall wrapper, so /proc/kallsyms
have symbols for syscall entry without powerpc prefix(sys_*).

For this reason, arch specific prefix for syscall functions in powerpc
is dropped.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 tools/lib/bpf/libbpf.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 219facd0e66e..3a370fa37d8a 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11110,9 +11110,7 @@ static const char *arch_specific_syscall_pfx(void)
 #elif defined(__riscv)
 	return "riscv";
 #elif defined(__powerpc__)
-	return "powerpc";
-#elif defined(__powerpc64__)
-	return "powerpc64";
+	return "";
 #else
 	return NULL;
 #endif
@@ -11127,7 +11125,11 @@ int probe_kern_syscall_wrapper(int token_fd)
 	if (!ksys_pfx)
 		return 0;
 
+#if defined(__powerpc__)
+	snprintf(syscall_name, sizeof(syscall_name), "sys_bpf");
+#else
 	snprintf(syscall_name, sizeof(syscall_name), "__%s_sys_bpf", ksys_pfx);
+#endif
 
 	if (determine_kprobe_perf_type() >= 0) {
 		int pfd;
@@ -11272,8 +11274,12 @@ struct bpf_link *bpf_program__attach_ksyscall(const struct bpf_program *prog,
 		 * compiler does not know that we have an explicit conditional
 		 * as well.
 		 */
+#if defined(__powerpc__)
+		snprintf(func_name, sizeof(func_name), "sys_%s", syscall_name);
+#else
 		snprintf(func_name, sizeof(func_name), "__%s_sys_%s",
 			 arch_specific_syscall_pfx() ? : "", syscall_name);
+#endif
 	} else {
 		snprintf(func_name, sizeof(func_name), "__se_sys_%s", syscall_name);
 	}
-- 
2.43.5


