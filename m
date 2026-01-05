Return-Path: <linux-kselftest+bounces-48198-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A69CF3185
	for <lists+linux-kselftest@lfdr.de>; Mon, 05 Jan 2026 11:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D92F0303F7B9
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jan 2026 10:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0513176E0;
	Mon,  5 Jan 2026 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XWSIeIo0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2533164B8;
	Mon,  5 Jan 2026 10:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610414; cv=none; b=sPqpzRKXJgCMP9PuhGa+TBUIWMu4MYwD4riU3RtAa7+xuLu2B5rgo8I1lff1RUjObPNTqpW4rvO0MO1MQHLmpkx5VAz25z88cssRHg1zUOREy+mIswbtXLQr6cvqtv5QR4dSUyHJpFygLa7Oub7GUd4ivEGgM/GNy4swmr2pPB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610414; c=relaxed/simple;
	bh=lRtu9kw1ZhjXWN+KoM32YsPv1tHn0e8qSptl/UDCCP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOmW/JRpBsTR7SBmaRDSWBXem82rLxj5Vd2hHl+tMGOR1/r/6iBF0toRlScZh3FDYu11TXfBHQsFUQWWF0iWWGZIRCXu4MuOZtkvcDcPTiQGjDKN0JYCsxb+Q1/Mm4YSbdNznCBaqInr+T+GrBhY4rwR/roNOOY7WjufMCgZftw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XWSIeIo0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604GPB0w026573;
	Mon, 5 Jan 2026 10:53:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wzBaK8qWCdkqUY3g3
	Sj7Uoi09hD+8UHUGtCXe7xrww4=; b=XWSIeIo0bW23L4gDlGvrs5W+b77vSVXhJ
	K0m+iqZK9PbxvJOhDyt9bpOEQl2yXRr800GY93lyP/SkAe+/MtCyeP4Av9ulC34+
	8HKeselPnsN56tiNTYAyCgROnHmSOa7Q1rJXgCzD/6Atpq0PToasqvqqndEXQijK
	6VBR01d/LUx5/tdFSGLTcqCq5QoX+VMePHq++YnCWtc4lujmoR1fMh4qXCBNTMM7
	9/0N1wwWgKShkeRc9hNm1wx2mb4IPR3mW8eLnBr6KLGQG4OoGTlSNwzXHfwXp3Ek
	3upNx9Eno3yZasVsS0zRwyN8MZQemtIpb5m+VLfvGWVTIcqhgr2Fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrte68c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:53:04 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 605Aflws021848;
	Mon, 5 Jan 2026 10:53:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betrte68a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:53:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6058CIJB019161;
	Mon, 5 Jan 2026 10:53:02 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg50w08b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Jan 2026 10:53:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 605AqwGm35717390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Jan 2026 10:52:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B296E20049;
	Mon,  5 Jan 2026 10:52:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D39E520040;
	Mon,  5 Jan 2026 10:52:52 +0000 (GMT)
Received: from abhi.. (unknown [9.124.213.127])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Jan 2026 10:52:52 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org,
        Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH 4/6] powerpc64/bpf: Add arch_bpf_stack_walk() for BPF JIT
Date: Mon,  5 Jan 2026 16:22:10 +0530
Message-ID: <20260105105212.136645-5-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260105105212.136645-1-adubey@linux.ibm.com>
References: <20260105105212.136645-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=aaJsXBot c=1 sm=1 tr=0 ts=695b9810 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ovcAVf-9gG4EF5hqTukA:9
X-Proofpoint-GUID: 1uSL2weSR1s7cYHIVMHughtrBm0l5nTR
X-Proofpoint-ORIG-GUID: tpHHNSAoaRePyi43WYGB6w5odCvUn63K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5NSBTYWx0ZWRfX24Ob40dEZRU3
 4OeIU1sWWHJj6V9Ero72BF35800d8+4vHVBb5/GIWkh6/A8enM+2p3FpVBtboHL7CXeLyHHfjRa
 e+vsHPd4noSEadDT4UhV0ZdKRJcnhgLDE0wM9RO0dtrt0cRAAkUj8xOf48bd9nykQcr/aUaJSbM
 +ATcObndzJHpS18pdsTW9Js2Dm2BYaDmMszLAjm0Xna0fb+3PpuNLfTdyILL0tHFphqMbL+yZq8
 jtdBTVE/OvLB19fnSklIaDf5LduA/O6Z8EQAc9mNgRkjr4/h19ws/d/UnVzU2fPfT/vC9l/qNaV
 OpXlxhCPA6yKWI2tMAMznNBhj3cr/S6XemSthsGMcJl2avlrK4X90bVnoCC+VTOAcVjUP1OdJlf
 Fz9weRbgutZEG+S508m7SEsKchu4VSqtbDBXrJw6txutUxu4UVYEwKIPAZcPYev8Lgou8gwcjEX
 OEWHq7uYip4Xt6eUMqg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601050095

From: Abhishek Dubey <adubey@linux.ibm.com>

This function is used by bpf_throw() to unwind the stack
until frame of exception-boundary during BPF exception
handling.

This function is necessary to support BPF exceptions on
PowerPC.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp64.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 37c547b49da8..0f3af67914d6 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -237,6 +237,34 @@ void bpf_jit_build_epilogue(u32 *image, struct codegen_context *ctx)
 	bpf_jit_build_fentry_stubs(image, ctx);
 }
 
+void arch_bpf_stack_walk(bool (*consume_fn)(void *, u64, u64, u64), void *cookie)
+{
+	// callback processing always in current context
+	unsigned long fp = current_stack_frame();
+
+	for (;;) {
+		unsigned long *frame = (unsigned long *) fp;
+		unsigned long ip;
+
+		if(!validate_sp(fp, current))
+			return;
+
+		ip = frame[STACK_FRAME_LR_SAVE];
+		if (!ip)
+			break;
+
+		/*
+		 * consume_fn common code expects stack pointer(sp) in third
+		 * argument. There is no sp in ppc64, rather pass frame
+		 * pointer.
+		 */
+		if (ip && !consume_fn(cookie, ip, fp, fp))
+			break;
+
+		fp = frame[0];
+	}
+}
+
 int bpf_jit_emit_func_call_rel(u32 *image, u32 *fimage, struct codegen_context *ctx, u64 func)
 {
 	unsigned long func_addr = func ? ppc_function_entry((void *)func) : 0;
-- 
2.48.1


