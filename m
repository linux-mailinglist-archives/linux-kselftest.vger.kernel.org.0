Return-Path: <linux-kselftest+bounces-21367-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B19BB089
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 11:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6B6282FBE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 10:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7207D1AF0CD;
	Mon,  4 Nov 2024 10:05:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610A19309A;
	Mon,  4 Nov 2024 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714709; cv=none; b=HZTBVz6audzob+FsJltGvk8HAQMCT4oNAHsji2At5/UrmGjbCYMaaj3v8FxLLjp9IaZX7TSkaoYFmmnILyYHAUofJHTNAvH0xJCwD83ZbzjtELSNPXjaZpDOAYLw0/Ed1sq46uskm+oKx81FZGhbbi9tqhbTeo5/BdJl3AqJnhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714709; c=relaxed/simple;
	bh=oye8m5QukDJKi6MQxANktZb9h404h7pmP4bgpZ9W0cM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5JbpxScA/2LZrBl/Use8PBo56TjAxxH3MXS6BUBUx3NrXr4OTM85WQDft8ta8FyVTje4tiwFTnp19KJKRHUVqULeQe9qtLys+OOJ54NGPOPccERrfTvCbyibhc9Rxsa5qIz/W2Xpmve4IH2WTyHO6KE22xexqF6ge2yHI+pe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id B85F71BF209;
	Mon,  4 Nov 2024 10:04:56 +0000 (UTC)
Message-ID: <a48514dc-6fe0-4f06-a5ee-10b1cf0f55e1@ghiti.fr>
Date: Mon, 4 Nov 2024 11:04:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add missing per-arch include path
Content-Language: en-US
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
References: <20240927131355.350918-1-bjorn@kernel.org>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240927131355.350918-1-bjorn@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Bjorn,

On 27/09/2024 15:13, Björn Töpel wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
>
> libbpf does not include the per-arch tools include path, e.g.
> tools/arch/riscv/include. Some architectures depend those files to
> build properly.
>
> Include tools/arch/$(SUBARCH)/include in the libbpf build.
>
> Fixes: 6d74d178fe6e ("tools: Add riscv barrier implementation")
> Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
> ---
>   tools/lib/bpf/Makefile | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
> index 1b22f0f37288..857a5f7b413d 100644
> --- a/tools/lib/bpf/Makefile
> +++ b/tools/lib/bpf/Makefile
> @@ -61,7 +61,8 @@ ifndef VERBOSE
>   endif
>   
>   INCLUDES = -I$(or $(OUTPUT),.) \
> -	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi
> +	   -I$(srctree)/tools/include -I$(srctree)/tools/include/uapi \
> +	   -I$(srctree)/tools/arch/$(SRCARCH)/include
>   
>   export prefix libdir src obj
>   
>
> base-commit: db5ca265e3334b48c4e3fa07eef79e8bc578c430


You can add:

Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


