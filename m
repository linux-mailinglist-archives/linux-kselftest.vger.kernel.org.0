Return-Path: <linux-kselftest+bounces-38454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B7B1D5C4
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 12:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2A53AE82A
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Aug 2025 10:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E325F997;
	Thu,  7 Aug 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SIkY1pPY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604D92512FC;
	Thu,  7 Aug 2025 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754562342; cv=none; b=eOMuCFY2J0AObwRTL2saqIAoIVWfB0gtls2a+LlRgbqXgJrqhlaiZBtADaovIUc9A8Vns8YDHgblxqPp3mHywl+4yQasqABhuWcWWsrMLXd3nB6rjP3V6DwcMU5MAiAyWsrhHEGLNq0NpnMnWHDddLZYcA5bWKU/8lUF53B5esk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754562342; c=relaxed/simple;
	bh=snKSvW25hHXDdjSinl1Mu+gMA4jqOCqdHtVgELHSusM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0rN2iyZzJcEX/QhMdOBxNsZR5mVzVgSG+OmiPaTIjuD0K6by17m/tuKLFXiABJs9au2AtPXGk7LB1U5TBIk0RIfVm/lNF4rIWsYjOnlM1xpB0yZZdujV4SyDGdB94tDXaBPfsn6E2xzjnDDLm4rC4jGJnSdEK6JAnOJJ4P2Lns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SIkY1pPY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5772hmhH017964;
	Thu, 7 Aug 2025 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=q/n9IO
	oKSeE8+THMQcptmNLhqb7HZ1tOw0supiHJzNM=; b=SIkY1pPYn9+X0G1rNERlQk
	v42Rkt6lR4IzfGcvV1otHLv+cotW2HNqsaQmx3ZChzvC0UvmJ9/7nqEd7/shOZQc
	dL5H1e9qD8VOawQOKmd5swBJF/7Ty8Q1yvxBXkZsd1S9RlR/AsRZ5kDw4UvimY6E
	NNFxpWSE5NTiggkkd/zIVWu5Hhx2dT7x5njURQPMiZl4IDLkqUz4tYul47TrDeiG
	D/V9fCQaGlSJ8uN+MlqHEFRwYbsUYXCk01W261afZXdCbVYj90/FjUSOVkJa2Zjo
	ZETDe2qebEJj6AA+wpCC104J3XTdXaAD3G4DS53eCJ6T6zDM5zvWGGP0ud594Bqg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq639chs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:25:03 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 577ANGww023432;
	Thu, 7 Aug 2025 10:25:02 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48bq639chk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:25:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5779UA6A007973;
	Thu, 7 Aug 2025 10:25:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48bpwn03mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Aug 2025 10:25:01 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 577AOv0o38863326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Aug 2025 10:24:57 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C21820087;
	Thu,  7 Aug 2025 10:24:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3F4E20089;
	Thu,  7 Aug 2025 10:24:52 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.219.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  7 Aug 2025 10:24:52 +0000 (GMT)
Date: Thu, 7 Aug 2025 15:54:50 +0530
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
Subject: Re: [bpf-next 3/6] bpf,powerpc: Implement bpf_addr_space_cast
 instruction
Message-ID: <aJR+8t1CnEig3exH@linux.ibm.com>
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-4-skb99@linux.ibm.com>
 <bc6ef2d1-da06-4b29-a0ec-67549074bc0b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc6ef2d1-da06-4b29-a0ec-67549074bc0b@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA3MDA4MiBTYWx0ZWRfX4X8+b7TBCu10
 v2FCM2q/D7IdqTTAEakrGIKjyOEKAyfJyz4xOc3naRg72vBrs4oX23mnL/+aPQPyWrCZ7UzX1gT
 PrgAjOcFAJmuXXs1dCyEZQlbpZA5TRMYa9vGGbPE989pS6o6AVwLdkLL9noesgPwUtdQa7mLvLW
 LXKPBZ8TI+dnot0xrOpKMO1YxoiQxfraoDKDidsFfC2A8o7ARgyTXIu9xTz84glEvWWzryX1A+S
 TtxbHCOeRqaJ/TvfUeRDcEW2ugQcxNm/p4jBCuwjU15knWhLo1SsSdvWP/UGiH6/gPJ2J14mBBF
 eCfOMcQTmKcDS76nd+QHUv0+ApCsXGY8pHr5J4J8SvGWtKrD9ADMbnPBdkzCAVHy8Npooq233t0
 aK/PkLvhooFW2z/b1C9wCa1lwyFsU8Zng5Ptq1nH6o3/VcPStExn+XqkTqDK4rpEq7vQnPkw
X-Proofpoint-GUID: aA2OhVPsH9My90VlPxNb2NK2hg2CIuoO
X-Authority-Analysis: v=2.4 cv=PoCTbxM3 c=1 sm=1 tr=0 ts=68947eff cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=8nJEP1OIZ-IA:10 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=hIbISvocxoUqj33YnGsA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: gG9yARwJAw8rtXy6ojXK43-BLELMc_XA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-07_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=944 mlxscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508070082

On Tue, Aug 05, 2025 at 09:29:07AM +0200, Christophe Leroy wrote:
> 
> 
> Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> > LLVM generates bpf_addr_space_cast instruction while translating
> > pointers between native (zero) address space and
> > __attribute__((address_space(N))). The addr_space=0 is reserved as
> > bpf_arena address space.
> > 
> > rY = addr_space_cast(rX, 0, 1) is processed by the verifier and
> > converted to normal 32-bit move: wX = wY.
> > 
> > rY = addr_space_cast(rX, 1, 0) : used to convert a bpf arena pointer to
> > a pointer in the userspace vma. This has to be converted by the JIT.
> > 
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >   arch/powerpc/net/bpf_jit.h        |  1 +
> >   arch/powerpc/net/bpf_jit_comp.c   |  6 ++++++
> >   arch/powerpc/net/bpf_jit_comp64.c | 11 +++++++++++
> >   3 files changed, 18 insertions(+)
> > 
> > diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> > index 2d095a873305..748e30e8b5b4 100644
> > --- a/arch/powerpc/net/bpf_jit.h
> > +++ b/arch/powerpc/net/bpf_jit.h
> > @@ -165,6 +165,7 @@ struct codegen_context {
> >   	unsigned int exentry_idx;
> >   	unsigned int alt_exit_addr;
> >   	u64 arena_vm_start;
> > +	u64 user_vm_start;
> >   };
> >   #define bpf_to_ppc(r)	(ctx->b2p[r])
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 35bfdf4d8785..2b3f90930c27 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -205,6 +205,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> >   	/* Make sure that the stack is quadword aligned. */
> >   	cgctx.stack_size = round_up(fp->aux->stack_depth, 16);
> >   	cgctx.arena_vm_start = bpf_arena_get_kern_vm_start(fp->aux->arena);
> > +	cgctx.user_vm_start = bpf_arena_get_user_vm_start(fp->aux->arena);
> >   	/* Scouting faux-generate pass 0 */
> >   	if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false)) {
> > @@ -441,6 +442,11 @@ bool bpf_jit_supports_kfunc_call(void)
> >   	return true;
> >   }
> > +bool bpf_jit_supports_arena(void)
> > +{
> > +	return IS_ENABLED(CONFIG_PPC64);
> > +}
> > +
> >   bool bpf_jit_supports_far_kfunc_call(void)
> >   {
> >   	return IS_ENABLED(CONFIG_PPC64);
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 16e62766c757..d4fe4dacf2d6 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -812,6 +812,17 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >   		 */
> >   		case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
> >   		case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
> > +
> > +			if (insn_is_cast_user(&insn[i])) {
> > +				EMIT(PPC_RAW_RLDICL(tmp1_reg, src_reg, 0, 32));
> 
> Define and use PPC_RAW_RLDICL_DOT to avoid the CMPDI below.
> 
Alright Chris, will define and implement it here.
> > +				PPC_LI64(dst_reg, (ctx->user_vm_start & 0xffffffff00000000UL));
> > +				EMIT(PPC_RAW_CMPDI(tmp1_reg, 0));
> > +				PPC_BCC_SHORT(COND_EQ, (ctx->idx + 2) * 4);
> > +				EMIT(PPC_RAW_OR(tmp1_reg, dst_reg, tmp1_reg));
> > +				EMIT(PPC_RAW_MR(dst_reg, tmp1_reg));
> > +				break;
> > +			}
> > +
> >   			if (imm == 1) {
> >   				/* special mov32 for zext */
> >   				EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
> 

