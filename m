Return-Path: <linux-kselftest+bounces-38277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2EB1AE4F
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 08:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2534118860B4
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 06:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE5F221F1F;
	Tue,  5 Aug 2025 06:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rwJGj8Xs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE5F21ABD4;
	Tue,  5 Aug 2025 06:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754375338; cv=none; b=WjBo+C0f4zmxSzu3U74WUqW9X1TUlPJ+Tm7OLfoEdhQCB7FLeLjxYgESU2T1dVDgy1TKn1owuKrQkXFOAHBSqqovNF0Vdbh0Qzbcux5xaZucIGeP/uD+uEV8BzHqC4WJVSsfOC41ZLbcoeK8+4FDhhYPMRc2X4DWBzz5oxvpTN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754375338; c=relaxed/simple;
	bh=tDb0utGZTArtNfFSd6neOlBozPWyxPy0tHD5x7njrO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3QFjDnMlZN1fPLpTa1l6NqSYLuBORTGgreVznIhuuulK5g0bMvup5PJ3LUmENg6oBOBqzcL2x/pMci31XLF8tPlMP/wthqRPhCwT7U0j1RyoN3dCG1wzx8B3nrwziSM2HblDROvofTtRv1Yzr5Ubm72EbLrfPAgZUZ+EPvKsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rwJGj8Xs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5751HI4g022644;
	Tue, 5 Aug 2025 06:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=915EIUlr6NurvmoEp
	wAUEJwm/kXsIw8K6Gqpj5VTM4A=; b=rwJGj8XsZl4Bs9y5QYaCw++urJOgE4HjL
	Nq8FPspsKWhjMkX7AqdiKcwbbwVCCWPXqxK4GsU0Z55MQezPcFu63PWjGY0W1hX+
	yGXsY9Evm0rEYKQHjBGq7/jmI99KQ81nI9TaW84fqmaojZvmA3YjV7oToeYbwNYp
	fCwCcIxwe+21bXSdoTtsULu0ozQXwNnqq7KesTnfyQErdrUdTF+yxZk2kYtg5jmP
	6CjymtJIaZgcD7AvQZPFTMc00rtCQrZVAlZyKIEvpNjNIz8X75IyQodlxA43+OFE
	Q+8Xiuf+fzrNzSY1JNCLOOQk3Yjt+QGLQRXr2eY4uYWgM8G+pVVHw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0vs0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:23 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5756P3Pd023405;
	Tue, 5 Aug 2025 06:28:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0vs0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57559APF001780;
	Tue, 5 Aug 2025 06:28:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 489y7ks10r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 06:28:22 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5756SHN559638204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 06:28:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5698920043;
	Tue,  5 Aug 2025 06:28:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63A8320040;
	Tue,  5 Aug 2025 06:28:10 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.39.141])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 Aug 2025 06:28:10 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        christophe.leroy@csgroup.eu, naveen@kernel.org, maddy@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, memxor@gmail.com,
        iii@linux.ibm.com, shuah@kernel.org
Subject: [bpf-next 2/6] bpf,powerpc: Implement PROBE_MEM32 pseudo instructions
Date: Tue,  5 Aug 2025 11:57:43 +0530
Message-ID: <20250805062747.3479221-3-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250805062747.3479221-1-skb99@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5GZma-dZGgal9zCf26Gy1vfz1S5_bwv3
X-Proofpoint-ORIG-GUID: Te_J4uSLL7WmQIYhyQWLAeX1HJUOmFeh
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=6891a487 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=ZFvp2un6vmrCkh9nRUAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NSBTYWx0ZWRfX9sfsT883v+S1
 9/epqTWQdufx/qfvhczBMr+Uylx0mKHdzY5/xQMoBY9NaAjHciLSDn4gGOdKC/k28Ljxd5DRk5B
 i1jiBYxcFCPqXt5AmhJHnhab/7oLy2EljNQSLO+J5/uvJ9q1khnjmACZVb7xtG0S9MZgz4YhetO
 JAmB3bhhYpeY5U8b2Yrrph+46TlI8wzNU3/6CfINAKGSPe8Jb4COZrJcLWi1u29UIetr4lYeoGM
 fjdVZrmTtLpwGyjHEpMfsiQsZ2C/QBawVt7MpmrsEk7eqWC70xYMg/cboy/bGdKTG0pJ5q4CWQg
 HlX/HCKXKiZ+j8psAHsIrf4nt7tiyDaL8T+JE5Yo1FV4YKeApWOttYHqj94dBxxgCz6+kgVs89X
 WkmI9gQ8a+H+ABSiJ9PtniXm/kvorYlNCWYuCjYjBua5pHlx9z5hdskcJThWkBuHD6J/pbJA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=899 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050045

Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
instructions.  They are similar to PROBE_MEM instructions with the
following differences:
- PROBE_MEM32 supports store.
- PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
src/dst register
- PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in _R26
in the prologue). Due to bpf_arena constructions such _R26 + reg +
off16 access is guaranteed to be within arena virtual range, so no
address check at run-time.
- PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
LDX faults the destination register is zeroed.

To support these on powerpc, we do tmp1 = _R26 + src/dst reg and then use
tmp1 as the new src/dst register. This allows us to reuse most of the
code for normal [LDX | STX | ST].

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        |   5 +-
 arch/powerpc/net/bpf_jit_comp.c   |  10 ++-
 arch/powerpc/net/bpf_jit_comp32.c |   2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 108 ++++++++++++++++++++++++++++--
 4 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 4c26912c2e3c..2d095a873305 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -161,9 +161,10 @@ struct codegen_context {
 	unsigned int seen;
 	unsigned int idx;
 	unsigned int stack_size;
-	int b2p[MAX_BPF_JIT_REG + 2];
+	int b2p[MAX_BPF_JIT_REG + 3];
 	unsigned int exentry_idx;
 	unsigned int alt_exit_addr;
+	u64 arena_vm_start;
 };
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
@@ -201,7 +202,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
 
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx,
-			  int jmp_off, int dst_reg);
+			  int jmp_off, int dst_reg, u32 code);
 
 #endif
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index c0684733e9d6..35bfdf4d8785 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -204,6 +204,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
 
 	/* Make sure that the stack is quadword aligned. */
 	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
+	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
 
 	/* Scouting faux-generate pass 0 */
 	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
@@ -326,7 +327,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
  */
 int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
 			  struct codegen_context *ctx, int insn_idx, int jmp_off,
-			  int dst_reg)
+			  int dst_reg, u32 code)
 {
 	off_t offset;
 	unsigned long pc;
@@ -354,7 +355,12 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
 		(fp->aux->num_exentries * BPF_FIXUP_LEN * 4) +
 		(ctx->exentry_idx * BPF_FIXUP_LEN * 4);
 
-	fixup[0] = PPC_RAW_LI(dst_reg, 0);
+	if ((BPF_CLASS(code) == BPF_LDX && BPF_MODE(code) == BPF_PROBE_MEM32) ||
+	    (BPF_CLASS(code) == BPF_LDX && BPF_MODE(code) == BPF_PROBE_MEM))
+		fixup[0] = PPC_RAW_LI(dst_reg, 0);
+	else if (BPF_CLASS(code) == BPF_ST || BPF_CLASS(code) == BPF_STX)
+		fixup[0] = PPC_RAW_NOP();
+
 	if (IS_ENABLED(CONFIG_PPC32))
 		fixup[1] = PPC_RAW_LI(dst_reg - 1, 0); /* clear higher 32-bit register too */
 
diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index 0aace304dfe1..3087e744fb25 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -1087,7 +1087,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				}
 
 				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx, insn_idx,
-							    jmp_off, dst_reg);
+							    jmp_off, dst_reg, code);
 				if (ret)
 					return ret;
 			}
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 489de21fe3d6..16e62766c757 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -44,6 +44,7 @@
 /* BPF register usage */
 #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
 #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)
+#define ARENA_VM_START  (MAX_BPF_JIT_REG + 2)
 
 /* BPF to ppc register mappings */
 void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
@@ -61,6 +62,8 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
 	ctx->b2p[BPF_REG_7] = _R28;
 	ctx->b2p[BPF_REG_8] = _R29;
 	ctx->b2p[BPF_REG_9] = _R30;
+	/* non volatile register for kern_vm_start address */
+	ctx->b2p[ARENA_VM_START] = _R26;
 	/* frame pointer aka BPF_REG_10 */
 	ctx->b2p[BPF_REG_FP] = _R31;
 	/* eBPF jit internal registers */
@@ -69,8 +72,8 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
 	ctx->b2p[TMP_REG_2] = _R10;
 }
 
-/* PPC NVR range -- update this if we ever use NVRs below r27 */
-#define BPF_PPC_NVR_MIN		_R27
+/* PPC NVR range -- update this if we ever use NVRs below r26 */
+#define BPF_PPC_NVR_MIN		_R26
 
 static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
 {
@@ -170,10 +173,17 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
 			EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
 
+	if (ctx->arena_vm_start)
+		EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
+				 bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
+
 	/* Setup frame pointer to point to the bpf stack area */
 	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
 		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
 				STACK_FRAME_MIN_SIZE + ctx->stack_size));
+
+	if (ctx->arena_vm_start)
+		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
 }
 
 static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx)
@@ -185,6 +195,10 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
 		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
 			EMIT(PPC_RAW_LD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
 
+	if (ctx->arena_vm_start)
+		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
+				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
+
 	/* Tear down our stack frame */
 	if (bpf_has_stack_frame(ctx)) {
 		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
@@ -990,6 +1004,50 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 			}
 			break;
 
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
+
+			EMIT(PPC_RAW_ADD(tmp1_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
+
+			ret = bpf_jit_emit_probe_mem_store(ctx, src_reg, off, code, image);
+			if (ret)
+				return ret;
+
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    ctx->idx - 1, 4, -1, code);
+			if (ret)
+				return ret;
+
+			break;
+
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
+
+			EMIT(PPC_RAW_ADD(tmp1_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
+
+			if (BPF_SIZE(code) == BPF_W || BPF_SIZE(code) == BPF_DW) {
+				PPC_LI32(tmp2_reg, imm);
+				src_reg = tmp2_reg;
+			} else {
+				EMIT(PPC_RAW_LI(tmp2_reg, imm));
+				src_reg = tmp2_reg;
+			}
+
+			ret = bpf_jit_emit_probe_mem_store(ctx, src_reg, off, code, image);
+			if (ret)
+				return ret;
+
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    ctx->idx - 1, 4, -1, code);
+			if (ret)
+				return ret;
+
+			break;
+
 		/*
 		 * BPF_STX ATOMIC (atomic ops)
 		 */
@@ -1142,9 +1200,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 				 * Check if 'off' is word aligned for BPF_DW, because
 				 * we might generate two instructions.
 				 */
-				if ((BPF_SIZE(code) == BPF_DW ||
-				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_PROBE_MEMSX)) &&
-						(off & 3))
+				if ((BPF_SIZE(code) == BPF_DW && (off & 3)) ||
+				    (BPF_SIZE(code) == BPF_B &&
+				     BPF_MODE(code) == BPF_PROBE_MEMSX) ||
+				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_MEMSX))
 					PPC_JMP((ctx->idx + 3) * 4);
 				else
 					PPC_JMP((ctx->idx + 2) * 4);
@@ -1190,12 +1249,49 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
 
 			if (BPF_MODE(code) == BPF_PROBE_MEM) {
 				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
-							    ctx->idx - 1, 4, dst_reg);
+							    ctx->idx - 1, 4, dst_reg, code);
 				if (ret)
 					return ret;
 			}
 			break;
 
+		/* dst = *(u64 *)(ul) (src + ARENA_VM_START + off) */
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
+		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
+
+			EMIT(PPC_RAW_ADD(tmp1_reg, src_reg, bpf_to_ppc(ARENA_VM_START)));
+
+			switch (size) {
+			case BPF_B:
+				EMIT(PPC_RAW_LBZ(dst_reg, tmp1_reg, off));
+				break;
+			case BPF_H:
+				EMIT(PPC_RAW_LHZ(dst_reg, tmp1_reg, off));
+				break;
+			case BPF_W:
+				EMIT(PPC_RAW_LWZ(dst_reg, tmp1_reg, off));
+				break;
+			case BPF_DW:
+				if (off % 4) {
+					EMIT(PPC_RAW_LI(tmp2_reg, off));
+					EMIT(PPC_RAW_LDX(dst_reg, tmp1_reg, tmp2_reg));
+				} else {
+					EMIT(PPC_RAW_LD(dst_reg, tmp1_reg, off));
+				}
+				break;
+			}
+
+			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
+				addrs[++i] = ctx->idx * 4;
+
+			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
+						    ctx->idx - 1, 4, dst_reg, code);
+			if (ret)
+				return ret;
+			break;
+
 		/*
 		 * Doubleword load
 		 * 16 byte instruction that uses two 'struct bpf_insn'
-- 
2.43.5


