Return-Path: <linux-kselftest+bounces-33288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7EABAF5C
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 12:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86FBD3AA1BC
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10654216399;
	Sun, 18 May 2025 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="h1ypzLgn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13927215F7F;
	Sun, 18 May 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747564977; cv=none; b=gJPJxc8pTBXMTz1xlDQ+oRSFLr5gE+oULqFeF3atT217ga9Ri7LWaEJknQXckiR/hbXe7rLRoBlUaxNM0LBRVlGIJDXemXAet1G8dwui0ZHgSW5YARqOoDmk2XEuSNkvmXYMwP0KQPisSqBgZKCooB8Cwfh8d3pzC6LxKUch5d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747564977; c=relaxed/simple;
	bh=n9eTJbU91BEV8Rgv1o7VL/pis9KHAw7HHdOrzGsfwKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+eakiDoZUbBmdUktohoCwY1xJ9PDFdn3AXlzPRZbsg0g8qvD+Je+JN7g+gEXmXoOubGf7pyBrlLyLaFi2hSaiq/TlXxP/TbAk8TaXDnnJ12wEQpTsrDhBiwTE2CpYRdBFV0sJT0OQEPA3ZuSEjFBqZZLtmsFmlSQql/8a0fIO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=h1ypzLgn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54I6Iima003730;
	Sun, 18 May 2025 10:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=heuLHY
	aaHMFynaFvPRzJR2yEb63hbYZtGMxVNVbbAFA=; b=h1ypzLgn2jPHE7ZNdyt/cI
	NJiE4AYh8yNaa68QTh+P1dhYyIMQpuHVwOwoKNMQbRXHSvtaGABo7rj2KlfY5TtL
	miJItmHIpFho2SLoTJ3WNpIlbAtUjm6XpAKdpXyjCb1vmmSCQKgO8q9Lu1zfwvtp
	1uBWeUBs/w4N2ARo/riPv6G9a8BXZaSEbhb6/KCRTRL3TlBgoyuTxmVgXuCP9ikf
	JT60obY1I8JaNf8a7Lh9UuWmiatrrjxR9XDS5tPc08Tntr8svSvfgcKr5sliPsPq
	F1tPTAve8WjU5pPd7oQbyaQ3FP00PdtFVpaihZOrDodEvbOkXGn3wWIUT/oPBwoA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qa5srkmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 10:41:27 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54IAfRjr001684;
	Sun, 18 May 2025 10:41:27 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46qa5srkmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 10:41:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54I5qFxw028878;
	Sun, 18 May 2025 10:41:25 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46q55yhrb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 10:41:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54IAfMdj44630526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 10:41:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 352EB20076;
	Sun, 18 May 2025 10:41:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F2DC2004F;
	Sun, 18 May 2025 10:41:04 +0000 (GMT)
Received: from [9.43.41.62] (unknown [9.43.41.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 May 2025 10:41:04 +0000 (GMT)
Message-ID: <d351c0ba-04fa-4764-a3a2-c4a8727aa582@linux.ibm.com>
Date: Sun, 18 May 2025 16:11:03 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 06/11] bpf, arm64, powerpc: Change nospec to
 include v1 barrier
To: Luis Gerhorst <luis.gerhorst@fau.de>, Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Puranjay Mohan <puranjay@kernel.org>,
        Xu Kuohai <xukuohai@huaweicloud.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Henriette Herzog <henriette.herzog@rub.de>,
        Saket Kumar Bhaskar <skb99@linux.ibm.com>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        Jiayuan Chen <mrpre@163.com>, Matan Shachnai <m.shachnai@gmail.com>,
        Dimitar Kanaliev <dimitar.kanaliev@siteground.com>,
        Shung-Hsi Yu <shung-hsi.yu@suse.com>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kselftest@vger.kernel.org
Cc: Maximilian Ott <ott@cs.fau.de>, Milan Stephan <milan.stephan@fau.de>
References: <20250421091802.3234859-1-luis.gerhorst@fau.de>
 <20250421091802.3234859-7-luis.gerhorst@fau.de>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250421091802.3234859-7-luis.gerhorst@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=f8FIBPyM c=1 sm=1 tr=0 ts=6829b958 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=mDV3o1hIAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=FMlO6nWJ9hO8ORJyGsUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: zB_5p2bcrH0UuQ76ZswqSWM9r0wRWxoV
X-Proofpoint-ORIG-GUID: 36MgEHlDP0aJI_G5yj_BzF4LKeTqnmf9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDEwMCBTYWx0ZWRfX5SRtsWH1kxHV yrieVj7XYZpYaGdoIYIts9JxBzj4CDNSi4cDQAf4RRMtMWJ3hj1XDqhuiqS0Kns4MnvCxKmxKaN oLlPaMjzEZXT2XTQNewF6RDxX+5xidk1LFrUGaDubEaEfw2UXBS3oqPceCa0ci/lPCCglExkkVQ
 B4YUc1Dk029IQCRTkplaztQ2z3b5RWhW57MhmaM/UUONkGdqbgH0mZxKwyrocmmZ0uHmVCQNE03 QRzbl10UzBY7MMV5g9AKPLhUR8QtRWiPUNukmyN4+BcLZFrl0Mux789FCkBuwbtsUnokPqcOmPg ktuX63FK/J5Z9Po+SXPnZv2yhooigY97bZBJY9KV2Ewhb3fUaCm6o0wSje4pJPfuvj8fv5pJ3Fv
 huRPWVPPv4HphL3ICdA1ZFMnrMkRPUGbyv8rOUQ1+3agb55ynoB74RLKiwk+gxWLR3qrsbUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1011 malwarescore=0 adultscore=0 impostorscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180100



On 21/04/25 2:47 pm, Luis Gerhorst wrote:
> This changes the semantics of BPF_NOSPEC (previously a v4-only barrier)
> to always emit a speculation barrier that works against both Spectre v1
> AND v4. If mitigation is not needed on an architecture, the backend
> should set bpf_jit_bypass_spec_v4/v1().
> 
> As of now, this commit only has the user-visible implication that unpriv
> BPF's performance on PowerPC is reduced. This is the case because we
> have to emit additional v1 barrier instructions for BPF_NOSPEC now.
> 
> This commit is required for a future commit to allow us to rely on
> BPF_NOSPEC for Spectre v1 mitigation. As of this commit, the feature
> that nospec acts as a v1 barrier is unused.
> 
> Commit f5e81d111750 ("bpf: Introduce BPF nospec instruction for
> mitigating Spectre v4") noted that mitigation instructions for v1 and v4
> might be different on some archs. While this would potentially offer
> improved performance on PowerPC, it was dismissed after the following
> considerations:
> 
> * Only having one barrier simplifies the verifier and allows us to
>    easily rely on v4-induced barriers for reducing the complexity of
>    v1-induced speculative path verification.

Fair enough.

> 
> * For the architectures that implemented BPF_NOSPEC, only PowerPC has
>    distinct instructions for v1 and v4. Even there, some insns may be
>    shared between the barriers for v1 and v4 (e.g., 'ori 31,31,0' and
>    'sync'). If this is still found to impact performance in an
>    unacceptable way, BPF_NOSPEC can be split into BPF_NOSPEC_V1 and
>    BPF_NOSPEC_V4 later. As an optimization, we can already skip v1/v4
>    insns from being emitted for PowerPC with this setup if
>    bypass_spec_v1/v4 is set.
> 

Agreed.

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> Vulnerability-status for BPF_NOSPEC-based Spectre mitigations (v4 as of
> this commit, v1 in the future) is therefore:
> 
> * x86 (32-bit and 64-bit), ARM64, and PowerPC (64-bit): Mitigated - This
>    patch implements BPF_NOSPEC for these architectures. The previous
>    v4-only version was supported since commit f5e81d111750 ("bpf:
>    Introduce BPF nospec instruction for mitigating Spectre v4") and
>    commit b7540d625094 ("powerpc/bpf: Emit stf barrier instruction
>    sequences for BPF_NOSPEC").
> 
> * LoongArch: Not Vulnerable - Commit a6f6a95f2580 ("LoongArch, bpf: Fix
>    jit to skip speculation barrier opcode") is the only other past commit
>    related to BPF_NOSPEC and indicates that the insn is not required
>    there.
> 
> * MIPS: Vulnerable (if unprivileged BPF is enabled) -
>    Commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip speculation
>    barrier opcode") indicates that it is not vulnerable but this
>    contradicts the kernel and Debian documentation. Therefore I assume
>    that there exist vulnerable MIPS CPUs (but maybe not from Loongson?).
>    In the future, BPF_NOSPEC could be implemented for MIPS based on the
>    GCC speculation_barrier [1]. For now, we rely on unprivileged BPF
>    being disabled by default.
> 
> * Other: Unknown - To the best of my knowledge there is no definitive
>    information available that indicates that any other arch is
>    vulnerable. They are therefore left untouched (BPF_NOSPEC is not
>    implemented, but bypass_spec_v1/v4 is also not set).
> 
> I did the following testing to ensure the insn encoding is correct:
> 
> * ARM64:
>    * 'dsb nsh; isb' was successfully tested with the BPF CI in [2]
>    * 'sb' locally using QEMU v7.2.15 -cpu max (emitted sb insn is
>      executed for example with './test_progs -t verifier_array_access')
> 
> * PowerPC: The following configs were tested locally with ppc64le QEMU
>    v8.2 '-machine pseries -cpu POWER9':
>    * STF_BARRIER_EIEIO + CONFIG_PPC_BOOK32_64
>    * STF_BARRIER_SYNC_ORI (forced on) + CONFIG_PPC_BOOK32_64
>    * STF_BARRIER_FALLBACK (forced on) + CONFIG_PPC_BOOK32_64
>    * CONFIG_PPC_E500 (forced on) + STF_BARRIER_EIEIO
>    * CONFIG_PPC_E500 (forced on) + STF_BARRIER_SYNC_ORI (forced on)
>    * CONFIG_PPC_E500 (forced on) + STF_BARRIER_FALLBACK (forced on)
>    * CONFIG_PPC_E500 (forced on) + STF_BARRIER_NONE (forced on)
>    Most of those cobinations should not occur in practice, but I was not
>    able to get an PPC e6500 rootfs (for testing PPC_E500 without forcing
>    it on). In any case, this should ensure that there are no unexpected
>    conflicts between the insns when combined like this. Individual v1/v4
>    barriers were already emitted elsewhere.
> 
> [1] https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=29b74545531f6afbee9fc38c267524326dbfbedf
>      ("MIPS: Add speculation_barrier support")
> [2] https://github.com/kernel-patches/bpf/pull/8576
> 
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Cc: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>
> ---
>   arch/arm64/net/bpf_jit.h          |  5 +++
>   arch/arm64/net/bpf_jit_comp.c     |  9 +++--
>   arch/powerpc/net/bpf_jit_comp64.c | 58 ++++++++++++++++++++++---------
>   include/linux/filter.h            |  2 +-
>   kernel/bpf/core.c                 | 17 ++++-----
>   5 files changed, 64 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit.h b/arch/arm64/net/bpf_jit.h
> index a3b0e693a125..bbea4f36f9f2 100644
> --- a/arch/arm64/net/bpf_jit.h
> +++ b/arch/arm64/net/bpf_jit.h
> @@ -325,4 +325,9 @@
>   #define A64_MRS_SP_EL0(Rt) \
>   	aarch64_insn_gen_mrs(Rt, AARCH64_INSN_SYSREG_SP_EL0)
>   
> +/* Barriers */
> +#define A64_SB aarch64_insn_get_sb_value()
> +#define A64_DSB_NSH (aarch64_insn_get_dsb_base_value() | 0x7 << 8)
> +#define A64_ISB aarch64_insn_get_isb_value()
> +
>   #endif /* _BPF_JIT_H */
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 0f617b55866e..ccd6a2f31e35 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1581,9 +1581,14 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   			return ret;
>   		break;
>   
> -	/* speculation barrier */
> +	/* speculation barrier against v1 and v4 */
>   	case BPF_ST | BPF_NOSPEC:
> -		/* See bpf_jit_bypass_spec_v4() */
> +		if (alternative_has_cap_likely(ARM64_HAS_SB)) {
> +			emit(A64_SB, ctx);
> +		} else {
> +			emit(A64_DSB_NSH, ctx);
> +			emit(A64_ISB, ctx);
> +		}
>   		break;
>   
>   	/* ST: *(size *)(dst + off) = imm */
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index b5339c541283..c00951e2a50e 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -800,26 +800,52 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   
>   		/*
>   		 * BPF_ST NOSPEC (speculation barrier)
> +		 *
> +		 * The following must act as a barrier against both Spectre v1
> +		 * and v4 if we requested both mitigations. Therefore, also emit
> +		 * 'isync; sync' on E500 or 'ori31' on BOOK3S_64 in addition to
> +		 * the insns needed for a Spectre v4 barrier.
> +		 *
> +		 * If we requested only !bypass_spec_v1 OR only !bypass_spec_v4,
> +		 * we can skip the respective other barrier type as an
> +		 * optimization.
>   		 */
>   		case BPF_ST | BPF_NOSPEC:
> -			switch (stf_barrier) {
> -			case STF_BARRIER_EIEIO:
> -				EMIT(PPC_RAW_EIEIO() | 0x02000000);
> -				break;
> -			case STF_BARRIER_SYNC_ORI:
> +			bool sync_emitted = false;
> +			bool ori31_emitted = false;
> +#ifdef CONFIG_PPC_E500
> +			if (!bpf_jit_bypass_spec_v1()) {
> +				EMIT(PPC_RAW_ISYNC());
>   				EMIT(PPC_RAW_SYNC());
> -				EMIT(PPC_RAW_LD(tmp1_reg, _R13, 0));
> -				EMIT(PPC_RAW_ORI(_R31, _R31, 0));
> -				break;
> -			case STF_BARRIER_FALLBACK:
> -				ctx->seen |= SEEN_FUNC;
> -				PPC_LI64(_R12, dereference_kernel_function_descriptor(bpf_stf_barrier));
> -				EMIT(PPC_RAW_MTCTR(_R12));
> -				EMIT(PPC_RAW_BCTRL());
> -				break;
> -			case STF_BARRIER_NONE:
> -				break;
> +				sync_emitted = true;
> +			}
> +#endif
> +			if (!bpf_jit_bypass_spec_v4()) {
> +				switch (stf_barrier) {
> +				case STF_BARRIER_EIEIO:
> +					EMIT(PPC_RAW_EIEIO() | 0x02000000);
> +					break;
> +				case STF_BARRIER_SYNC_ORI:
> +					if (!sync_emitted)
> +						EMIT(PPC_RAW_SYNC());
> +					EMIT(PPC_RAW_LD(tmp1_reg, _R13, 0));
> +					EMIT(PPC_RAW_ORI(_R31, _R31, 0));
> +					ori31_emitted = true;
> +					break;
> +				case STF_BARRIER_FALLBACK:
> +					ctx->seen |= SEEN_FUNC;
> +					PPC_LI64(_R12, dereference_kernel_function_descriptor(bpf_stf_barrier));
> +					EMIT(PPC_RAW_MTCTR(_R12));
> +					EMIT(PPC_RAW_BCTRL());
> +					break;
> +				case STF_BARRIER_NONE:
> +					break;
> +				}
>   			}
> +#ifdef CONFIG_PPC_BOOK3S_64
> +			if (!bpf_jit_bypass_spec_v1() && !ori31_emitted)
> +				EMIT(PPC_RAW_ORI(_R31, _R31, 0));
> +#endif
>   			break;
>   
>   		/*
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5cf4d35d83e..eca229752cbe 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -82,7 +82,7 @@ struct ctl_table_header;
>   #define BPF_CALL_ARGS	0xe0
>   
>   /* unused opcode to mark speculation barrier for mitigating
> - * Speculative Store Bypass
> + * Spectre v1 and v4
>    */
>   #define BPF_NOSPEC	0xc0
>   
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 804f1e52bfa3..fe16be379bf4 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2102,14 +2102,15 @@ static u64 ___bpf_prog_run(u64 *regs, const struct bpf_insn *insn)
>   #undef COND_JMP
>   	/* ST, STX and LDX*/
>   	ST_NOSPEC:
> -		/* Speculation barrier for mitigating Speculative Store Bypass.
> -		 * In case of arm64, we rely on the firmware mitigation as
> -		 * controlled via the ssbd kernel parameter. Whenever the
> -		 * mitigation is enabled, it works for all of the kernel code
> -		 * with no need to provide any additional instructions here.
> -		 * In case of x86, we use 'lfence' insn for mitigation. We
> -		 * reuse preexisting logic from Spectre v1 mitigation that
> -		 * happens to produce the required code on x86 for v4 as well.
> +		/* Speculation barrier for mitigating Speculative Store Bypass,
> +		 * Bounds-Check Bypass and Type Confusion. In case of arm64, we
> +		 * rely on the firmware mitigation as controlled via the ssbd
> +		 * kernel parameter. Whenever the mitigation is enabled, it
> +		 * works for all of the kernel code with no need to provide any
> +		 * additional instructions here. In case of x86, we use 'lfence'
> +		 * insn for mitigation. We reuse preexisting logic from Spectre
> +		 * v1 mitigation that happens to produce the required code on
> +		 * x86 for v4 as well.
>   		 */
>   		barrier_nospec();
>   		CONT;


