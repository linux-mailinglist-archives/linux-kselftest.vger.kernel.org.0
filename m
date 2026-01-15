Return-Path: <linux-kselftest+bounces-48993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 039A3D232C2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E82093048FF8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 08:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E5332EB6;
	Thu, 15 Jan 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayuJIOH0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D529B217;
	Thu, 15 Jan 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768465756; cv=none; b=cP/djRbT0WJLx9SRJryDeBecgB1MgTPmn7Hhz7DU7rBzmgot6Og/4N8pQ+WO8bduFLbCQXp5XPBsekNhgh+n5maCsI2vf+4s1wsKyE2pax3+5YkO+W3MUPZZXJ73OmjMGrlPVyrUluubinoMWyLkhAl0DWMM68GUdM0Hy+lAv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768465756; c=relaxed/simple;
	bh=S7HCfIKFFGeY+CKuWgYtJmjmqfuD6022qSuM1DWTvnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0rwlrTRNybtOQjNFtat7reVqr/hwx6lATjloVJ6qiAfCBEaZC6Qu1XWh6Xy0n0w9Z2Ot7zZ5Pu1Jsb6xFlvHC84pDcKSVTuY1A/UF/WPd2UH9iUnGtoJJv/+qcHNc2aVxbSbLaQfiMazbD93q6uGNpKeCzxdhd7216wP+0a7O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayuJIOH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113C8C19423;
	Thu, 15 Jan 2026 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768465756;
	bh=S7HCfIKFFGeY+CKuWgYtJmjmqfuD6022qSuM1DWTvnc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ayuJIOH08LJP9jBCA9D+qP6XHanepkz7rJN91tCFuJ39w3rIauqP/TYpFNDB5Fgyh
	 9dEae1j7KdrQrcE7qUgGouvdd4g5gNiDrEOhG3qmq3Z/DZqveVSNYOc23ejtV0VglA
	 JGq++rwmFRjjGO8C9u4t4G9phCIBr50fB6ARyhSS3lEN0TSBgjYJvg4d5XBnt5qFUL
	 Mp38kj1b3bvQ9RKHuLUdSaNBSiT+vMBm4WT+Vd9TTJZzb8lrxVLSgtiKQfo95yHH1Q
	 GV0Z5ZHP7nMGeU7Wgmb1eA1bE11tczFWkrPdIwyeAZAcAg+St3ltx8J5NIXP7TaiuP
	 +vG15luoN3kCg==
Message-ID: <2c0588cd-f71b-40e5-a2cd-269d27e35abc@kernel.org>
Date: Thu, 15 Jan 2026 09:29:06 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] powerpc64/bpf: Move tail_call_cnt to bottom of
 stack frame
To: adubey@linux.ibm.com, bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
 andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 memxor@gmail.com, iii@linux.ibm.com, shuah@kernel.org
References: <20260114114450.30405-1-adubey@linux.ibm.com>
 <20260114114450.30405-2-adubey@linux.ibm.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260114114450.30405-2-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 14/01/2026 à 12:44, adubey@linux.ibm.com a écrit :
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> In the conventional stack frame, the position of tail_call_cnt
> is after the NVR save area (BPF_PPC_STACK_SAVE). Whereas, the
> offset of tail_call_cnt in the trampoline frame is after the
> stack alignment padding. BPF JIT logic could become complex
> when dealing with frame-sensitive offset calculation of
> tail_call_cnt. Having the same offset in both frames is the
> desired objective.
> 
> The trampoline frame does not have a BPF_PPC_STACK_SAVE area.
> Introducing it leads to under-utilization of extra memory meant
> only for the offset alignment of tail_call_cnt.
> Another challenge is the variable alignment padding sitting at
> the bottom of the trampoline frame, which requires additional
> handling to compute tail_call_cnt offset.
> 
> This patch addresses the above issues by moving tail_call_cnt
> to the bottom of the stack frame at offset 0 for both types
> of frames. This saves additional bytes required by BPF_PPC_STACK_SAVE
> in trampoline frame, and a common offset computation for
> tail_call_cnt serves both frames.
> 
> The changes in this patch are required by the third patch in the
> series, where the 'reference to tail_call_info' of the main frame
> is copied into the trampoline frame from the previous frame.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   arch/powerpc/net/bpf_jit.h        |  4 ++++
>   arch/powerpc/net/bpf_jit_comp64.c | 31 ++++++++++++++++++++-----------
>   2 files changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index 8334cd667bba..45d419c0ee73 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -72,6 +72,10 @@
>   	} } while (0)
>   
>   #ifdef CONFIG_PPC64
> +
> +/* for tailcall counter */
> +#define BPF_PPC_TAILCALL        8

This needs to be defined outside of CONFIG_PPC64 ifdef because from 
patch 3 it is used in bpf_jit_comp.c which is also built on powerpc32.

> +
>   /* If dummy pass (!image), account for maximum possible instructions */
>   #define PPC_LI64(d, i)		do {					      \
>   	if (!image)							      \

