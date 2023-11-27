Return-Path: <linux-kselftest+bounces-649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF47FA2DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 15:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F1CB20FCD
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Nov 2023 14:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC46E2D04C;
	Mon, 27 Nov 2023 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lkocpGUk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B53866
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 06:32:41 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-359c22c44d6so17846995ab.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Nov 2023 06:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701095560; x=1701700360; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=576agieZsbz96FiroK7MxYXEH2pDI3CMW/6FzJlxhYw=;
        b=lkocpGUk5mMM6YHccsm29CP+zyKk3th9gRHqNNZcGZ5tKx49nJk+W5k1SSwulXKjnE
         M2eG1uLDQJG949TEZ0FmWuvJCoKYBtxG8rd9Sa19dD3Mamkl/BZWYAk8EXIxDdBvHVst
         ZIbgZIsr9zraVTvWblQ2CDuHXA01iJ8CXFmrPqlmDQ8ciDs16ezA6cpWj64QVM/Oqmqr
         k9xLV8gBd0WnSI8/ZoNy/MraCmxN3zTJSU3/7+wFDozP1WjPCqQXdhuNJQK0WOUhaYZn
         tlscKTwvRfZS7cN1yFuOBJFinel3wxXASsNZdkh7/0UYFLKOM/AqILGgrKEJK5mEddEy
         i3Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701095560; x=1701700360;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=576agieZsbz96FiroK7MxYXEH2pDI3CMW/6FzJlxhYw=;
        b=ggA0goyiDoSUhoi5sV702KcpZDiiKnKH91doPN2F9AwAXQt6/o9j73I18F0gUH1btW
         O+P2m+xXaZ5FhIfPzZ8d0l8k4do8rh9fHK11h5H2pb9igqCEWjnhti8EuxTVygU5ClDe
         +bI4z26QYTkBMYQ5pqFzkRLmWZTlVzyBD72i3qaksJsZAPnjSzxmoLy79dV5gUhl9xgu
         vdrmZ5JTSucTpYdLXiSfCw+NEG+g8KignL3s76MMhwgsxkHv6Aku6uRUYY2YaTkHs0eh
         ISGh/yO3RfqgP3wTkwjAZ1Fp431/NGtSullEm9VBaKsuw5SF8/PFdRSSUhazuq7zKoBN
         qiQg==
X-Gm-Message-State: AOJu0YxxAYLJxBx9TDfifpXhfpq4Ya+iW0c4qEU774ovfox5UX0lt78i
	KdsYmLmJ4MLDaV9FFeDyCJUAeQ==
X-Google-Smtp-Source: AGHT+IG/WGxpvGREvrXBuOJjwOgK3X/z7+Um3ekxoELlMVLqyywHQeQ7S80IRt40ldOt+Chf9dKILA==
X-Received: by 2002:a05:6e02:388a:b0:35c:5131:cc9f with SMTP id cn10-20020a056e02388a00b0035c5131cc9fmr13225931ilb.23.1701095560675;
        Mon, 27 Nov 2023 06:32:40 -0800 (PST)
Received: from ?IPV6:2605:a601:adae:4500:2dd6:4d2f:2741:8d95? ([2605:a601:adae:4500:2dd6:4d2f:2741:8d95])
        by smtp.gmail.com with ESMTPSA id l15-20020a056e020e4f00b0035b0b56e0e1sm1987657ilk.53.2023.11.27.06.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 06:32:40 -0800 (PST)
Message-ID: <2de6d526-918b-44f6-b26a-a0f30c42c5b3@sifive.com>
Date: Mon, 27 Nov 2023 08:32:39 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] RISC-V: Expose Ssdtso via hwprobe API
Content-Language: en-US
To: Christoph Muellner <christoph.muellner@vrull.eu>
References: <20231124072142.2786653-1-christoph.muellner@vrull.eu>
 <20231124072142.2786653-3-christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Anup Patel <apatel@ventanamicro.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Andrew Jones <ajones@ventanamicro.com>, Guo Ren <guoren@kernel.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Conor Dooley <conor.dooley@microchip.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>, Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
 Daniel Lustig <dlustig@nvidia.com>, Peter Zijlstra <peterz@infradead.org>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231124072142.2786653-3-christoph.muellner@vrull.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Christoph,

On 2023-11-24 1:21 AM, Christoph Muellner wrote:
> From: Christoph Müllner <christoph.muellner@vrull.eu>
> 
> This patch adds Ssdtso to the list of extensions which
> are announced to user-space using te hwprobe API.
> 
> Signed-off-by: Christoph Müllner <christoph.muellner@vrull.eu>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 3 +++
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_riscv.c         | 1 +
>  3 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/riscv/hwprobe.rst
> index 7b2384de471f..8de3349e0ca2 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -80,6 +80,9 @@ The following keys are defined:
>    * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Zicboz extension is supported, as
>         ratified in commit 3dd606f ("Create cmobase-v1.0.pdf") of riscv-CMOs.
>  
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZICBOZ`: The Ssdtso extension is supported, as

Should be RISCV_HWPROBE_EXT_SSDTSO.

Regards,
Samuel

> +       in version v1.0-draft2 of the corresponding extension.
> +
>  * :c:macro:`RISCV_HWPROBE_KEY_CPUPERF_0`: A bitmask that contains performance
>    information about the selected set of processors.
>  
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/uapi/asm/hwprobe.h
> index b659ffcfcdb4..ed450c64e6b2 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -30,6 +30,7 @@ struct riscv_hwprobe {
>  #define		RISCV_HWPROBE_EXT_ZBB		(1 << 4)
>  #define		RISCV_HWPROBE_EXT_ZBS		(1 << 5)
>  #define		RISCV_HWPROBE_EXT_ZICBOZ	(1 << 6)
> +#define		RISCV_HWPROBE_EXT_SSDTSO	(1 << 7)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0	5
>  #define		RISCV_HWPROBE_MISALIGNED_UNKNOWN	(0 << 0)
>  #define		RISCV_HWPROBE_MISALIGNED_EMULATED	(1 << 0)
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index c712037dbe10..c654f43b9699 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -162,6 +162,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair,
>  		EXT_KEY(ZBB);
>  		EXT_KEY(ZBS);
>  		EXT_KEY(ZICBOZ);
> +		EXT_KEY(SSDTSO);
>  #undef EXT_KEY
>  	}
>  


