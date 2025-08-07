Return-Path: <linux-kselftest+bounces-38472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E62EB1D8FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 15:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42441566093
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 13:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E44625A646;
	Thu,  7 Aug 2025 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gn5mMbzy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50976233713;
	Thu,  7 Aug 2025 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754573210; cv=none; b=lOTQWE5gx82N2c/JcdbZ7Uw1aMcnNItFwiERMAuq5aEEa4IAM4UB/vXn/hWo7kpoGmj2EP5LuI/oTIZF0QhytQUHJy55QhW6+/v/seFRYIZimVXlJE7iDWhwG0mUgoqqrzySCfON2kzVW70PjH76qIrrgD8wGgdZi7rVZx2v+FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754573210; c=relaxed/simple;
	bh=KAVhXMrcZbEZXDk69RtWXbUN9zoFR9b7YkdCbgO9hXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHu5E+ZBZXJICcgnpDb0cYDMib4NWR9XV7ev2UVfVzVLJRdA2wWIES4XSSX0A3JBPHQ9pdmYzkL6OIZK1M2s0YWSP2XzbFe5CKz1XBUiMH1ZP4u3fCYD1TmK8pYdY/Dc1diIjP1CIfSvkOD1keNvEvHH2tAqyRV73SsheEn7b6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gn5mMbzy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5773hi2J017879;
	Thu, 7 Aug 2025 13:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9oVqEe
	j9wiaQjQl3Hk9fdlTeBWzpOkwFCwpLKucQfvY=; b=Gn5mMbzyp8Y4jCK0TxCu/R
	obNSQ3+tbhzPPinnlIF0Mn+g29VBbQ7h546MbVZBUCr5YgHDNEVA9+9FMLyyEXpD
	Dki1GCUf+km7ofosPf9S1VTK3JjWnA2HDAG6R6geNFXxdkv4ZGtS8qlCgq59QrGK
	01Ne3bIj5BLE5af3sLXy6KA8N64J42fxZzNCI2n2FVoxVGqK30yHbS0E84nZRrIF
	ugIdr0Cw8E19HtjMt6Wo8n8tjqCb8qlxLCSot63Iskbdjhc3ugff0EGeX/W4OIhL
	n38/LTl/6oQSh+Ro3bGQkUvpljvpW7zwUgUszCJzx0TRIoIUyVxpCPmm/h+V9YyA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63a6kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:26:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577DMSoX002781;
	Thu, 7 Aug 2025 13:26:09 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq63a6kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:26:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779chwF022668;
	Thu, 7 Aug 2025 13:26:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48bpwqgsk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 13:26:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577DQ4H920120054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 13:26:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 728AC20043;
	Thu,  7 Aug 2025 13:26:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF21D20040;
	Thu,  7 Aug 2025 13:25:57 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.75.32])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 13:25:57 +0000 (GMT)
Date: Thu, 7 Aug 2025 18:55:54 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        naveen@kernel.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, memxor@gmail.com, iii@linux.ibm.com,
        shuah@kernel.org
Subject: Re: [bpf-next 2/6] bpf,powerpc: Implement PROBE_MEM32 pseudo
 instructions
Message-ID: <aJSpYtksqwp4IVkX@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-3-skb99@linux.ibm.com>
 <c53da8e9-c15d-47b4-9422-4461f0b7c188@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c53da8e9-c15d-47b4-9422-4461f0b7c188@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDEwOCBTYWx0ZWRfX/iEXtPdpd1Eg
 6g8RAHUynDG+j2LPpWMxbIzSAYgHmLZvggunwNd6WdY+o0Wu753R+D/EkBzHkLgcFXeYDZh63bu
 dEX+o7bGxgP/RHj8OQACTVn9VeKaCdLiFMyhjL6tXCGD71VrG/9RZ0f8KtC2UqArdGmub2Df56i
 csCTLyOvMaDrYGuWrPprmXmiPoVLJ2cT8Z/9H33DQ1qKHfLcU84TvbOrY9CnQuWQDZtA7UD7wUq
 Dks7hllZM60dBYwizrhqO23ZgZ8qokvXL34P7JWRa56ouEVEl0SM9Lg4IM5SOCVYSWOHnnr6o67
 gwUPpkriSp5pFk8B4NFFnajkz4oLlGn3JwQO/YzKnlzt8QlKu0hcLxLogPY1t9+qcguLOPTO2Kx
 NXFwL5J2EjSoNnN1yrwdf2Xlwtb2xa1jOtt33mMZAYz7hfclqzNKEhsntzHqzWHPsM0ESi2H
X-Proofpoint-GUID: X-mH1yrkqFE2hfomJdku2NBcgpwQzPab
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=6894a972 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=_ttamy9umuXLLvATu48A:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: vEDoO0hLNA0SKg24SpSXOqYsQmNfBFJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070108

On Tue, Aug 05, 2025 at 09:41:37AM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> > Add support for [LDX | STX | ST], PROBE_MEM32, [B | H | W | DW]
> > instructions.  They are similar to PROBE_MEM instructions with the
> > following differences:
> > - PROBE_MEM32 supports store.
> > - PROBE_MEM32 relies on the verifier to clear upper 32-bit of the
> > src/dst register
> > - PROBE_MEM32 adds 64-bit kern_vm_start address (which is stored in _R26
> > in the prologue). Due to bpf_arena constructions such _R26 + reg +
> > off16 access is guaranteed to be within arena virtual range, so no
> > address check at run-time.
> > - PROBE_MEM32 allows STX and ST. If they fault the store is a nop. When
> > LDX faults the destination register is zeroed.
> > 
> > To support these on powerpc, we do tmp1 = _R26 + src/dst reg and then use
> > tmp1 as the new src/dst register. This allows us to reuse most of the
> > code for normal [LDX | STX | ST].
> > 
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >   arch/powerpc/net/bpf_jit.h        |   5 +-
> >   arch/powerpc/net/bpf_jit_comp.c   |  10 ++-
> >   arch/powerpc/net/bpf_jit_comp32.c |   2 +-
> >   arch/powerpc/net/bpf_jit_comp64.c | 108 ++++++++++++++++++++++++++++--
> >   4 files changed, 114 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> > index 4c26912c2e3c..2d095a873305 100644
> > --- a/arch/powerpc/net/bpf_jit.h
> > +++ b/arch/powerpc/net/bpf_jit.h
> > @@ -161,9 +161,10 @@ struct codegen_context {
> >   	unsigned int seen;
> >   	unsigned int idx;
> >   	unsigned int stack_size;
> > -	int b2p[MAX_BPF_JIT_REG + 2];
> > +	int b2p[MAX_BPF_JIT_REG + 3];
> >   	unsigned int exentry_idx;
> >   	unsigned int alt_exit_addr;
> > +	u64 arena_vm_start;
> >   };
> >   #define bpf_to_ppc(r)	(ctx->b2p[r])
> > @@ -201,7 +202,7 @@ int bpf_jit_emit_exit_insn(u32 *image, struct codegen_context *ctx, int tmp_reg,
> >   int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
> >   			  struct codegen_context *ctx, int insn_idx,
> > -			  int jmp_off, int dst_reg);
> > +			  int jmp_off, int dst_reg, u32 code);
> >   #endif
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index c0684733e9d6..35bfdf4d8785 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -204,6 +204,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >   	/* Make sure that the stack is quadword aligned. */
> >   	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
> > +	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
> >   	/* Scouting faux-generate pass 0 */
> >   	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> > @@ -326,7 +327,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >    */
> >   int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass,
> >   			  struct codegen_context *ctx, int insn_idx, int jmp_off,
> > -			  int dst_reg)
> > +			  int dst_reg, u32 code)
> >   {
> >   	off_t offset;
> >   	unsigned long pc;
> > @@ -354,7 +355,12 @@ int bpf_add_extable_entry(struct bpf_prog *fp, u32 *image, u32 *fimage, int pass
> >   		(fp->aux->num_exentries * BPF_FIXUP_LEN * 4) +
> >   		(ctx->exentry_idx * BPF_FIXUP_LEN * 4);
> > -	fixup[0] = PPC_RAW_LI(dst_reg, 0);
> > +	if ((BPF_CLASS(code) == BPF_LDX && BPF_MODE(code) == BPF_PROBE_MEM32) ||
> > +	    (BPF_CLASS(code) == BPF_LDX && BPF_MODE(code) == BPF_PROBE_MEM))
> > +		fixup[0] = PPC_RAW_LI(dst_reg, 0);
> > +	else if (BPF_CLASS(code) == BPF_ST || BPF_CLASS(code) == BPF_STX)
> > +		fixup[0] = PPC_RAW_NOP();
> > +
> 
> Is there also a 'else' to consider ? If not, why not just a 'else' instead
> of an 'if else' ?
> 
Thanks Chris, for pointing it out. Will try to accomodate this in v2.
> >   	if (IS_ENABLED(CONFIG_PPC32))
> >   		fixup[1] = PPC_RAW_LI(dst_reg - 1, 0); /* clear higher 32-bit register too */
> > diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
> > index 0aace304dfe1..3087e744fb25 100644
> > --- a/arch/powerpc/net/bpf_jit_comp32.c
> > +++ b/arch/powerpc/net/bpf_jit_comp32.c
> > @@ -1087,7 +1087,7 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >   				}
> >   				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx, insn_idx,
> > -							    jmp_off, dst_reg);
> > +							    jmp_off, dst_reg, code);
> >   				if (ret)
> >   					return ret;
> >   			}
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 489de21fe3d6..16e62766c757 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -44,6 +44,7 @@
> >   /* BPF register usage */
> >   #define TMP_REG_1	(MAX_BPF_JIT_REG + 0)
> >   #define TMP_REG_2	(MAX_BPF_JIT_REG + 1)
> > +#define ARENA_VM_START  (MAX_BPF_JIT_REG + 2)
> >   /* BPF to ppc register mappings */
> >   void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
> > @@ -61,6 +62,8 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
> >   	ctx->b2p[BPF_REG_7] = _R28;
> >   	ctx->b2p[BPF_REG_8] = _R29;
> >   	ctx->b2p[BPF_REG_9] = _R30;
> > +	/* non volatile register for kern_vm_start address */
> > +	ctx->b2p[ARENA_VM_START] = _R26;
> >   	/* frame pointer aka BPF_REG_10 */
> >   	ctx->b2p[BPF_REG_FP] = _R31;
> >   	/* eBPF jit internal registers */
> > @@ -69,8 +72,8 @@ void bpf_jit_init_reg_mapping(struct codegen_context *ctx)
> >   	ctx->b2p[TMP_REG_2] = _R10;
> >   }
> > -/* PPC NVR range -- update this if we ever use NVRs below r27 */
> > -#define BPF_PPC_NVR_MIN		_R27
> > +/* PPC NVR range -- update this if we ever use NVRs below r26 */
> > +#define BPF_PPC_NVR_MIN		_R26
> >   static inline bool bpf_has_stack_frame(struct codegen_context *ctx)
> >   {
> > @@ -170,10 +173,17 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
> >   		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
> >   			EMIT(PPC_RAW_STD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
> > +	if (ctx->arena_vm_start)
> > +		EMIT(PPC_RAW_STD(bpf_to_ppc(ARENA_VM_START), _R1,
> > +				 bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
> > +
> >   	/* Setup frame pointer to point to the bpf stack area */
> >   	if (bpf_is_seen_register(ctx, bpf_to_ppc(BPF_REG_FP)))
> >   		EMIT(PPC_RAW_ADDI(bpf_to_ppc(BPF_REG_FP), _R1,
> >   				STACK_FRAME_MIN_SIZE + ctx->stack_size));
> > +
> > +	if (ctx->arena_vm_start)
> > +		PPC_LI64(bpf_to_ppc(ARENA_VM_START), ctx->arena_vm_start);
> >   }
> >   static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx)
> > @@ -185,6 +195,10 @@ static void bpf_jit_emit_common_epilogue(u32 *image, struct codegen_context *ctx
> >   		if (bpf_is_seen_register(ctx, bpf_to_ppc(i)))
> >   			EMIT(PPC_RAW_LD(bpf_to_ppc(i), _R1, bpf_jit_stack_offsetof(ctx, bpf_to_ppc(i))));
> > +	if (ctx->arena_vm_start)
> > +		EMIT(PPC_RAW_LD(bpf_to_ppc(ARENA_VM_START), _R1,
> > +				bpf_jit_stack_offsetof(ctx, bpf_to_ppc(ARENA_VM_START))));
> > +
> >   	/* Tear down our stack frame */
> >   	if (bpf_has_stack_frame(ctx)) {
> >   		EMIT(PPC_RAW_ADDI(_R1, _R1, BPF_PPC_STACKFRAME + ctx->stack_size));
> > @@ -990,6 +1004,50 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >   			}
> >   			break;
> > +		case BPF_STX | BPF_PROBE_MEM32 | BPF_B:
> > +		case BPF_STX | BPF_PROBE_MEM32 | BPF_H:
> > +		case BPF_STX | BPF_PROBE_MEM32 | BPF_W:
> > +		case BPF_STX | BPF_PROBE_MEM32 | BPF_DW:
> > +
> > +			EMIT(PPC_RAW_ADD(tmp1_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
> > +
> > +			ret = bpf_jit_emit_probe_mem_store(ctx, src_reg, off, code, image);
> > +			if (ret)
> > +				return ret;
> > +
> > +			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
> > +						    ctx->idx - 1, 4, -1, code);
> > +			if (ret)
> > +				return ret;
> > +
> > +			break;
> > +
> > +		case BPF_ST | BPF_PROBE_MEM32 | BPF_B:
> > +		case BPF_ST | BPF_PROBE_MEM32 | BPF_H:
> > +		case BPF_ST | BPF_PROBE_MEM32 | BPF_W:
> > +		case BPF_ST | BPF_PROBE_MEM32 | BPF_DW:
> > +
> > +			EMIT(PPC_RAW_ADD(tmp1_reg, dst_reg, bpf_to_ppc(ARENA_VM_START)));
> > +
> > +			if (BPF_SIZE(code) == BPF_W || BPF_SIZE(code) == BPF_DW) {
> > +				PPC_LI32(tmp2_reg, imm);
> > +				src_reg = tmp2_reg;
> > +			} else {
> > +				EMIT(PPC_RAW_LI(tmp2_reg, imm));
> > +				src_reg = tmp2_reg;
> > +			}
> > +
> > +			ret = bpf_jit_emit_probe_mem_store(ctx, src_reg, off, code, image);
> > +			if (ret)
> > +				return ret;
> > +
> > +			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
> > +						    ctx->idx - 1, 4, -1, code);
> > +			if (ret)
> > +				return ret;
> > +
> > +			break;
> > +
> >   		/*
> >   		 * BPF_STX ATOMIC (atomic ops)
> >   		 */
> > @@ -1142,9 +1200,10 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >   				 * Check if 'off' is word aligned for BPF_DW, because
> >   				 * we might generate two instructions.
> >   				 */
> > -				if ((BPF_SIZE(code) == BPF_DW ||
> > -				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_PROBE_MEMSX)) &&
> > -						(off & 3))
> > +				if ((BPF_SIZE(code) == BPF_DW && (off & 3)) ||
> > +				    (BPF_SIZE(code) == BPF_B &&
> > +				     BPF_MODE(code) == BPF_PROBE_MEMSX) ||
> > +				    (BPF_SIZE(code) == BPF_B && BPF_MODE(code) == BPF_MEMSX))
> >   					PPC_JMP((ctx->idx + 3) * 4);
> >   				else
> >   					PPC_JMP((ctx->idx + 2) * 4);
> > @@ -1190,12 +1249,49 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >   			if (BPF_MODE(code) == BPF_PROBE_MEM) {
> >   				ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
> > -							    ctx->idx - 1, 4, dst_reg);
> > +							    ctx->idx - 1, 4, dst_reg, code);
> >   				if (ret)
> >   					return ret;
> >   			}
> >   			break;
> > +		/* dst = *(u64 *)(ul) (src + ARENA_VM_START + off) */
> > +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_B:
> > +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_H:
> > +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_W:
> > +		case BPF_LDX | BPF_PROBE_MEM32 | BPF_DW:
> > +
> > +			EMIT(PPC_RAW_ADD(tmp1_reg, src_reg, bpf_to_ppc(ARENA_VM_START)));
> > +
> > +			switch (size) {
> > +			case BPF_B:
> > +				EMIT(PPC_RAW_LBZ(dst_reg, tmp1_reg, off));
> > +				break;
> > +			case BPF_H:
> > +				EMIT(PPC_RAW_LHZ(dst_reg, tmp1_reg, off));
> > +				break;
> > +			case BPF_W:
> > +				EMIT(PPC_RAW_LWZ(dst_reg, tmp1_reg, off));
> > +				break;
> > +			case BPF_DW:
> > +				if (off % 4) {
> > +					EMIT(PPC_RAW_LI(tmp2_reg, off));
> > +					EMIT(PPC_RAW_LDX(dst_reg, tmp1_reg, tmp2_reg));
> > +				} else {
> > +					EMIT(PPC_RAW_LD(dst_reg, tmp1_reg, off));
> > +				}
> > +				break;
> > +			}
> > +
> > +			if (size != BPF_DW && insn_is_zext(&insn[i + 1]))
> > +				addrs[++i] = ctx->idx * 4;
> > +
> > +			ret = bpf_add_extable_entry(fp, image, fimage, pass, ctx,
> > +						    ctx->idx - 1, 4, dst_reg, code);
> > +			if (ret)
> > +				return ret;
> > +			break;
> > +
> >   		/*
> >   		 * Doubleword load
> >   		 * 16 byte instruction that uses two 'struct bpf_insn'
> 
Thanks for reviewing, Chris.

Regards,
Saket

