Return-Path: <linux-kselftest+bounces-3139-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E818301FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 10:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73773B23382
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jan 2024 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA50134AC;
	Wed, 17 Jan 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="R4pE6w3u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3E1118D
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 09:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705482990; cv=none; b=TwsNBtdRThNBZbGb2GwlysC/CYqAGnOLfMnfE0u54kUXKcX2WhZ/G0z8isxmktiRMPMRu8tfOwbBPILlFr8wED2ui+noTfe0zK1jo/oNqzzdr6vCZemyipepJbno/1RTP0agidq6K1xcX6ixUmi5mDdIz889mss8e7B5UZb5Kww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705482990; c=relaxed/simple;
	bh=YGUj50R76Uz0Vc6/+Mu7lNbEJ7PAT1Cch4LPlu2YJ70=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=dQNx2ivevG+H1Sximo2CeF5WnbIUQavJfez6Ga64/rNDCLrjuBgC+qyJ51u46xZjVlM71tVZKo7KxSpcpUxlX52e/ByZEMjHRDDxPw+GNG3d8pedppTtJoHNswsOtXtQkF/W23Uy8Fc8IbafyzVxYyQYm5h/KThdad+hn7stmEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=R4pE6w3u; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e87d07c07so9060265e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Jan 2024 01:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1705482987; x=1706087787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IsdAvf8hxCZPrunA4Y1YJj8dzQfMO9GuW6K07QeXqBc=;
        b=R4pE6w3u82TX7pUJbpMBbofPshzOQec3yYVUTIPSp91Ia5tc6ODhcLFcjvDiO+FYTK
         LH/kZqof5FKED7RCWOwbGinSnbOvj1IvZ+rDSXUU8LJplYLPAcgDyLbUND6U0rM+9zdW
         vZo1NgZTuet+73qMKGogxTILY8TpQ3IfC0ZVThVR/osK1HJstYxlAclhK5uGURmv7mNK
         eFDVoqcQzHBgVDfOCXpB2u18TIid4HTc9G8zGeFegXcOEQ/6MSyVHoxe8vUtiuKHoC/h
         WWVCYVazdqmFAGiubl4UR5cgoJV3P8wNzrD9/0aswwFd5iOLVBreCLtlpCe0bYv6UsWt
         FdYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705482987; x=1706087787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsdAvf8hxCZPrunA4Y1YJj8dzQfMO9GuW6K07QeXqBc=;
        b=kwER3B2upI4scZKCYIUF4p7ygkKolxyOglo6wM2I1n49gtsMQLh0iu7Y3ar4s6pgfm
         DRjBF59AGrHLzhsVnEipkUR+oUcEwGm95DOdmqqofPK9Cj7aawuSQ7CT25Fc+iSca69c
         V/+NZSlkGWK9anJyGHUVLznc4Nl2oes0j1olKScIB3wKe9ZdkpQZCa/DZe8wuE3m3AiI
         NxIJ+S/9OVcu2aA3/4dafdaYYNwF2tz/2EM1I0ap51KqeMGsrXGAW16xiMsk+UMynmvp
         nssCYHaVDE1BkhPP54XsIu3DnMNuYTvOmQOHqfJRtDnliUsHxJJXybRMV93T5xf7wF72
         p3sw==
X-Gm-Message-State: AOJu0YwBY/7j0uz5Vu2ulBcmbp6MTd4vesjOydF5MfQ4pt2ve7mG/Yy5
	rg1/2cHok2P7DE9DavLf3YYDRngL810kqQ==
X-Google-Smtp-Source: AGHT+IElDHZcHY6KtbxrcIOLwAyWKlUemsAhPHr/51sSMy0a2ZcI/YvCUrgFo//DPT5UsYvBbPwa+g==
X-Received: by 2002:a7b:ce8c:0:b0:40e:499a:6734 with SMTP id q12-20020a7bce8c000000b0040e499a6734mr4782442wmj.60.1705482987285;
        Wed, 17 Jan 2024 01:16:27 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id je6-20020a05600c1f8600b0040d8d11bf63sm21911921wmb.41.2024.01.17.01.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 01:16:26 -0800 (PST)
Date: Wed, 17 Jan 2024 10:16:26 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: shuah@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, xiao.w.wang@intel.com, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, xuzhipeng.1973@bytedance.com
Subject: Re: [PATCH] RISC-V: selftests: fix cbo.c compilation error
Message-ID: <20240117-274e425c51d0deaeca80857d@orel>
References: <20240117082514.42967-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117082514.42967-1-cuiyunhui@bytedance.com>

On Wed, Jan 17, 2024 at 04:25:14PM +0800, Yunhui Cui wrote:
> When compiling with -O0, the following error will occur:
> cbo.c: In function 'cbo_insn':
> cbo.c:43:9: warning: 'asm' operand 1 probably does not match constraints
>    43 |         asm volatile(
>       |         ^~~
> cbo.c:43:9: warning: 'asm' operand 2 probably does not match constraints
> cbo.c:43:9: error: impossible constraint in 'asm'
> 
> Add __attribute__((optimize("O"))) to fix.
> 
> Fixes: a29e2a48afe3 ("RISC-V: selftests: Add CBO tests")
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> Suggested-by: Zhipeng Xu <xuzhipeng.1973@bytedance.com>
> ---
>  tools/testing/selftests/riscv/hwprobe/cbo.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
> index 50a2cc8aef38..ff1d8e843d70 100644
> --- a/tools/testing/selftests/riscv/hwprobe/cbo.c
> +++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
> @@ -36,7 +36,7 @@ static void sigill_handler(int sig, siginfo_t *info, void *context)
>  	regs[0] += 4;
>  }
>  
> -static void cbo_insn(char *base, int fn)
> +static __always_inline void cbo_insn(char *base, int fn)
>  {
>  	uint32_t insn = MK_CBO(fn);
>  
> @@ -47,10 +47,11 @@ static void cbo_insn(char *base, int fn)
>  	: : "r" (base), "i" (fn), "i" (insn) : "a0", "a1", "memory");
>  }
>  
> -static void cbo_inval(char *base) { cbo_insn(base, 0); }
> -static void cbo_clean(char *base) { cbo_insn(base, 1); }
> -static void cbo_flush(char *base) { cbo_insn(base, 2); }
> -static void cbo_zero(char *base)  { cbo_insn(base, 4); }
> +#define OPTIMIZE __attribute__((optimize("O")))
> +OPTIMIZE static void cbo_inval(char *base) { cbo_insn(base, 0); }
> +OPTIMIZE static void cbo_clean(char *base) { cbo_insn(base, 1); }
> +OPTIMIZE static void cbo_flush(char *base) { cbo_insn(base, 2); }
> +OPTIMIZE static void cbo_zero(char *base)  { cbo_insn(base, 4); }
>  
>  static void test_no_zicbom(void *arg)
>  {
> -- 
> 2.20.1
>

Hi Yunhui,

Thanks for the bug report, but this isn't the right fix. The real problem
is that I didn't ensure operands 1 and 2 match their constraints, just as
the warning you discovered says. To do that, I should have made cbo_insn()
a macro and not used the local variable, i.e. ensure 'fn' and 'insn' are
indeed constants derived from the 0,1,2,4 constants.

I'll send a patch with your reported-by.

Thanks,
drew

