Return-Path: <linux-kselftest+bounces-33287-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D25ABAF56
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 12:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689B8178F2B
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0207215040;
	Sun, 18 May 2025 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GnlrYf/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AAB1C6FE2;
	Sun, 18 May 2025 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747564812; cv=none; b=TyTYtsuY7yJguDptuy/FQMvlxl5va7wdByAgMPWtD/TKrl7RsAZOXsTIMGs0XAcIK+NjlvnihAjxSl3Zd2nS1KO2DzTBRFDD7bVl/NwvCoCoHxGNBDdWWYRapQp8M2u8iEwhYF5oXR8xIh/DAh188nKhSBAYXmv3aB17CPIk03k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747564812; c=relaxed/simple;
	bh=4MMf0isE/u2ZflvK/FTsv0kklkEQvlodOFYQFj9m/bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DEOqipnOVPPKuGSmZ8rfNKA2NKpyKvXF/WFRseV12r8F4o5oS07k/qea4myRw+WZKBw4XH8MSKURTQl4bHNKKm1gOfZ78vGivjHMly/IiMZrXW+Q/mgPudutq7jmDh/6n+8IKtbUS43yheaIAxk9GM7j1dMBw5R1tg51KJ6/CaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GnlrYf/b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54I30DcD010129;
	Sun, 18 May 2025 10:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FAVrjy
	1LBV6r8dXd+SHBdcRzoBuXW5h14lGv0i65eOg=; b=GnlrYf/bBdEUlPPlbwklkx
	k0Q+w9wF6HluwgaZAGgVq7LweJFGs2eanQUk8yBB40uZR0hUo1WH4m8010QrDcVf
	coirKtxKJkiH63vFNb9TNRQJa9Vg4dbc4PJM2a4xeOvTqKt6nq/eIG1rGxEgulNc
	jpIX43U2tIgP43Z//2XPrx2zwSISxuWplRbDpJ6U0SJL2CId6LeMMw3cGYPDTlhz
	gSfcu6f/22l8kNdztPLmsZEinZtJbTNVveBfUQUcUEfwq/chq2Zo1fejY+ZemExh
	eIUCGYzOseoP+3iFDM42hoiYolD6YMACQzB5gkKbrP30yawfK4Yy1J8Kph7qWZmA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46q056a5tp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 10:38:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54IAcljG003315;
	Sun, 18 May 2025 10:38:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46q056a5tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 10:38:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54I7ugZE007338;
	Sun, 18 May 2025 10:38:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46q70k1c1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 18 May 2025 10:38:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54IAchrE48300410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 18 May 2025 10:38:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E752220114;
	Sun, 18 May 2025 10:38:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A1E20113;
	Sun, 18 May 2025 10:38:35 +0000 (GMT)
Received: from [9.43.41.62] (unknown [9.43.41.62])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 18 May 2025 10:38:35 +0000 (GMT)
Message-ID: <e07a6fd9-9810-4288-97ce-33c97f4ac30e@linux.ibm.com>
Date: Sun, 18 May 2025 16:08:34 +0530
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 05/11] bpf, arm64, powerpc: Add
 bpf_jit_bypass_spec_v1/v4()
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
References: <20250501073603.1402960-1-luis.gerhorst@fau.de>
 <20250501073603.1402960-6-luis.gerhorst@fau.de>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20250501073603.1402960-6-luis.gerhorst@fau.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE4MDEwMCBTYWx0ZWRfX0oTAgd69TtH8 GdmXyHtNqw3iUln/YOdlEFfm9aAogUY7MSX4Pf860Y6GWtCM6F57SSU2gfIQ8Ytrykeg+ApAa9x 3/o23Bzr8vnwGSnC0VDI0MP60RsE8rZtOv9j4DC1yOQ4tj6sDTfqWZPES98cF/hTMzJ4vibXwf6
 jHtERKhTZcZbUJNBuSW+Q4a+OQUnHEaPTmKDk+nndESveMJkJubb+cdTRDgjMRW7TAs+9qSH2Xq rRKVyR39IBIQVOcYopmw5xjv7ZGT8+81MPyRWiw5rlCdeq0H+1CHOwIHIiSW4tiQ7g7ckGDwfXy 7TN+eHFrXGmKdH6eQvZAuRcy0ZB0b7XaCXiWejTWDGgzbmwD+/XU95L86LIh9DsPgUC1v+UcBWP
 waO56QJI9uyNf3X99nTRRm4JZE9dm58Ug8UpZMLpgbzbpe5YlYtPpndUU57XziwETjbryW2x
X-Authority-Analysis: v=2.4 cv=H5vbw/Yi c=1 sm=1 tr=0 ts=6829b8b8 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=mFe75aD0Q6rLs-ne4sYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: kcHnYx0Yg8HMRdm5KtX2b3uA24X_g6I5
X-Proofpoint-ORIG-GUID: twxZW800zCAvCaXjU8KduWmD8cO-KK8t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-18_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505180100



On 01/05/25 1:05 pm, Luis Gerhorst wrote:
> JITs can set bpf_jit_bypass_spec_v1/v4() if they want the verifier to
> skip analysis/patching for the respective vulnerability. For v4, this
> will reduce the number of barriers the verifier inserts. For v1, it
> allows more programs to be accepted.
> 
> The primary motivation for this is to not regress unpriv BPF's
> performance on ARM64 in a future commit where BPF_NOSPEC is also used
> against Spectre v1.
> 
> This has the user-visible change that v1-induced rejections on
> non-vulnerable PowerPC CPUs are avoided.
> 
> For now, this does not change the semantics of BPF_NOSPEC. It is still a
> v4-only barrier and must not be implemented if bypass_spec_v4 is always
> true for the arch. Changing it to a v1 AND v4-barrier is done in a
> future commit.
> 
> As an alternative to bypass_spec_v1/v4, one could introduce NOSPEC_V1
> AND NOSPEC_V4 instructions and allow backends to skip their lowering as
> suggested by commit f5e81d111750 ("bpf: Introduce BPF nospec instruction
> for mitigating Spectre v4"). Adding bpf_jit_bypass_spec_v1/v4() was
> found to be preferable for the following reason:
> 
> * bypass_spec_v1/v4 benefits non-vulnerable CPUs: Always performing the
>    same analysis (not taking into account whether the current CPU is
>    vulnerable), needlessly restricts users of CPUs that are not
>    vulnerable. The only use case for this would be portability-testing,
>    but this can later be added easily when needed by allowing users to
>    force bypass_spec_v1/v4 to false.
> 
> * Portability is still acceptable: Directly disabling the analysis
>    instead of skipping the lowering of BPF_NOSPEC(_V1/V4) might allow
>    programs on non-vulnerable CPUs to be accepted while the program will
>    be rejected on vulnerable CPUs. With the fallback to speculation
>    barriers for Spectre v1 implemented in a future commit, this will only
>    affect programs that do variable stack-accesses or are very complex.
> 
> For PowerPC, the SEC_FTR checking in bpf_jit_bypass_spec_v4() is based
> on the check that was previously located in the BPF_NOSPEC case.
> 
> For LoongArch, it would likely be safe to set both
> bpf_jit_bypass_spec_v1() and _v4() according to
> commit a6f6a95f2580 ("LoongArch, bpf: Fix jit to skip speculation
> barrier opcode"). This is omitted here as I am unable to do any testing
> for LoongArch.
> 
> Signed-off-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Cc: Henriette Herzog <henriette.herzog@rub.de>
> Cc: Maximilian Ott <ott@cs.fau.de>
> Cc: Milan Stephan <milan.stephan@fau.de>

for the powerpc part..

Acked-by: Hari Bathini <hbathini@linux.ibm.com>

> ---
>   arch/arm64/net/bpf_jit_comp.c     | 21 ++++++++++++---------
>   arch/powerpc/net/bpf_jit_comp64.c | 21 +++++++++++++++++----
>   include/linux/bpf.h               | 11 +++++++++--
>   kernel/bpf/core.c                 | 15 +++++++++++++++
>   4 files changed, 53 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 70d7c89d3ac9..0f617b55866e 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -1583,15 +1583,7 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
>   
>   	/* speculation barrier */
>   	case BPF_ST | BPF_NOSPEC:
> -		/*
> -		 * Nothing required here.
> -		 *
> -		 * In case of arm64, we rely on the firmware mitigation of
> -		 * Speculative Store Bypass as controlled via the ssbd kernel
> -		 * parameter. Whenever the mitigation is enabled, it works
> -		 * for all of the kernel code with no need to provide any
> -		 * additional instructions.
> -		 */
> +		/* See bpf_jit_bypass_spec_v4() */
>   		break;
>   
>   	/* ST: *(size *)(dst + off) = imm */
> @@ -2762,6 +2754,17 @@ bool bpf_jit_supports_percpu_insn(void)
>   	return true;
>   }
>   
> +bool bpf_jit_bypass_spec_v4(void)
> +{
> +	/* In case of arm64, we rely on the firmware mitigation of Speculative
> +	 * Store Bypass as controlled via the ssbd kernel parameter. Whenever
> +	 * the mitigation is enabled, it works for all of the kernel code with
> +	 * no need to provide any additional instructions. Therefore, skip
> +	 * inserting nospec insns against Spectre v4.
> +	 */
> +	return true;
> +}
> +
>   bool bpf_jit_inlines_helper_call(s32 imm)
>   {
>   	switch (imm) {
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 233703b06d7c..b5339c541283 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -363,6 +363,23 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	return 0;
>   }
>   
> +bool bpf_jit_bypass_spec_v1(void)
> +{
> +#if defined(CONFIG_PPC_E500) || defined(CONFIG_PPC_BOOK3S_64)
> +	return !(security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
> +		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR));
> +#else
> +	return true;
> +#endif
> +}
> +
> +bool bpf_jit_bypass_spec_v4(void)
> +{
> +	return !(security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
> +		 security_ftr_enabled(SEC_FTR_STF_BARRIER) &&
> +		 stf_barrier_type_get() != STF_BARRIER_NONE);
> +}
> +
>   /*
>    * We spill into the redzone always, even if the bpf program has its own stackframe.
>    * Offsets hardcoded based on BPF_PPC_STACK_SAVE -- see bpf_jit_stack_local()
> @@ -785,10 +802,6 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
>   		 * BPF_ST NOSPEC (speculation barrier)
>   		 */
>   		case BPF_ST | BPF_NOSPEC:
> -			if (!security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) ||
> -					!security_ftr_enabled(SEC_FTR_STF_BARRIER))
> -				break;
> -
>   			switch (stf_barrier) {
>   			case STF_BARRIER_EIEIO:
>   				EMIT(PPC_RAW_EIEIO() | 0x02000000);
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 3f0cc89c0622..6f5e54c680db 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2268,6 +2268,9 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array *array,
>   	return ret;
>   }
>   
> +bool bpf_jit_bypass_spec_v1(void);
> +bool bpf_jit_bypass_spec_v4(void);
> +
>   #ifdef CONFIG_BPF_SYSCALL
>   DECLARE_PER_CPU(int, bpf_prog_active);
>   extern struct mutex bpf_stats_enabled_mutex;
> @@ -2455,12 +2458,16 @@ static inline bool bpf_allow_uninit_stack(const struct bpf_token *token)
>   
>   static inline bool bpf_bypass_spec_v1(const struct bpf_token *token)
>   {
> -	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
> +	return bpf_jit_bypass_spec_v1() ||
> +		cpu_mitigations_off() ||
> +		bpf_token_capable(token, CAP_PERFMON);
>   }
>   
>   static inline bool bpf_bypass_spec_v4(const struct bpf_token *token)
>   {
> -	return cpu_mitigations_off() || bpf_token_capable(token, CAP_PERFMON);
> +	return bpf_jit_bypass_spec_v4() ||
> +		cpu_mitigations_off() ||
> +		bpf_token_capable(token, CAP_PERFMON);
>   }
>   
>   int bpf_map_new_fd(struct bpf_map *map, int flags);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index ba6b6118cf50..804f1e52bfa3 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -3029,6 +3029,21 @@ bool __weak bpf_jit_needs_zext(void)
>   	return false;
>   }
>   
> +/* By default, enable the verifier's mitigations against Spectre v1 and v4 for
> + * all archs. The value returned must not change at runtime as there is
> + * currently no support for reloading programs that were loaded without
> + * mitigations.
> + */
> +bool __weak bpf_jit_bypass_spec_v1(void)
> +{
> +	return false;
> +}
> +
> +bool __weak bpf_jit_bypass_spec_v4(void)
> +{
> +	return false;
> +}
> +
>   /* Return true if the JIT inlines the call to the helper corresponding to
>    * the imm.
>    *


