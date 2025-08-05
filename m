Return-Path: <linux-kselftest+bounces-38283-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BFAB1AFD3
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 09:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3469717E4DA
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 07:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8C62580F7;
	Tue,  5 Aug 2025 07:50:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB08F2580CC;
	Tue,  5 Aug 2025 07:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754380242; cv=none; b=GT+CxnyE7zApG5cXy8UZseEGXf9aZtdntTgNo6/SZFFw8NnfSh6cNOLht/45G4LzQaRCq1UlzfPOmmlSQA6HPq/ZJoWm/dFy7afJGA1DY1G7CoRyrYGlH1ShUYDeIsVGF/WDuyeX7SnzdhdRNtIRDbPZjtLAlOaGiRouORwAWpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754380242; c=relaxed/simple;
	bh=X34zklE2dG57JiP1U/Y/znUa2KrJiBam6wOU3O++NQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WMhf/cnPVGa4ABRq0zJn+UTeLq750JhuSjZYHBTqXwFo2ryBg1WtH5aMj/ErO4EjRiHxAW300xzNahMvvMPkE4eX+4JzBCBjWpXPvHhKRCf1D38YcmXV6RBVOtyoAGwVk78gJrm1ODWDYljN2fkrhT5Iqyy8YfxMChAjAgFfP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4bx4tk4fRkz9sqT;
	Tue,  5 Aug 2025 09:34:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2KWXNzhh9Q9; Tue,  5 Aug 2025 09:34:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4bx4tk3tHTz9sps;
	Tue,  5 Aug 2025 09:34:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7BB458B765;
	Tue,  5 Aug 2025 09:34:22 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 60eHZvnq60Lk; Tue,  5 Aug 2025 09:34:22 +0200 (CEST)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4970B8B763;
	Tue,  5 Aug 2025 09:34:21 +0200 (CEST)
Message-ID: <e65548d0-14aa-4b9c-8051-7c91c5dffd1f@csgroup.eu>
Date: Tue, 5 Aug 2025 09:34:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bpf-next 1/6] bpf,powerpc: Introduce
 bpf_jit_emit_probe_mem_store() to emit store instructions
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20250805062747.3479221-1-skb99@linux.ibm.com>
 <20250805062747.3479221-2-skb99@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Content-Language: fr-FR
In-Reply-To: <20250805062747.3479221-2-skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 05/08/2025 à 08:27, Saket Kumar Bhaskar a écrit :
> bpf_jit_emit_probe_mem_store() is introduced to emit instructions for
> storing memory values depending on the size (byte, halfword,
> word, doubleword).

Build break with this patch

   CC      arch/powerpc/net/bpf_jit_comp64.o
arch/powerpc/net/bpf_jit_comp64.c:395:12: error: 
'bpf_jit_emit_probe_mem_store' defined but not used 
[-Werror=unused-function]
  static int bpf_jit_emit_probe_mem_store(struct codegen_context *ctx, 
u32 src_reg, s16 off,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [scripts/Makefile.build:287: 
arch/powerpc/net/bpf_jit_comp64.o] Error 1


> 
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit_comp64.c | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index 025524378443..489de21fe3d6 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -409,6 +409,36 @@ asm (
>   "		blr				;"
>   );
>   
> +static int bpf_jit_emit_probe_mem_store(struct codegen_context *ctx, u32 src_reg, s16 off,
> +					u32 code, u32 *image)
> +{
> +	u32 tmp1_reg = bpf_to_ppc(TMP_REG_1);
> +	u32 tmp2_reg = bpf_to_ppc(TMP_REG_2);
> +
> +	switch (BPF_SIZE(code)) {
> +	case BPF_B:
> +		EMIT(PPC_RAW_STB(src_reg, tmp1_reg, off));
> +		break;
> +	case BPF_H:
> +		EMIT(PPC_RAW_STH(src_reg, tmp1_reg, off));
> +		break;
> +	case BPF_W:
> +		EMIT(PPC_RAW_STW(src_reg, tmp1_reg, off));
> +		break;
> +	case BPF_DW:
> +		if (off % 4) {
> +			EMIT(PPC_RAW_LI(tmp2_reg, off));
> +			EMIT(PPC_RAW_STDX(src_reg, tmp1_reg, tmp2_reg));
> +		} else {
> +			EMIT(PPC_RAW_STD(src_reg, tmp1_reg, off));
> +		}
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
>   static int emit_atomic_ld_st(const struct bpf_insn insn, struct codegen_context *ctx, u32 *image)
>   {
>   	u32 code = insn.code;


