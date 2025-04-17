Return-Path: <linux-kselftest+bounces-31046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE13A91BBC
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 14:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ABC83AE951
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Apr 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7C419004B;
	Thu, 17 Apr 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZOso7Pl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEAF322E;
	Thu, 17 Apr 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744892159; cv=none; b=b6IOEJZQOcaHitQkAQWQuDoLR4nu/KmQdC9HUFB7o/L3NBqlVathvZk7QGeo0qNsAOH8XKKv6+U/f/5Dp/C4OQkHtOCsdtOOdP89m3RRoOEzQBQOH4tQpQyfBRTYAc/YDd4F3mGP/dE2YzkUqnKKZkY9KjYZkr1AisV82wPH6bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744892159; c=relaxed/simple;
	bh=/touNEg3wjqxZZrko58aIkqU4PlLZuskeKvYOEX9psw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAN1X3AKXYoKYWec4Y24gTsWt/737ffq5xiJlZFWMiiRlN/4kMwyumS0yUDv+DNziLbbqJ2t0BdFT6VFIBkDaqNyTR81P6YsvEzCGLhme3NQonF2GIXZOzlD2KZ/iptVZEt4/tD4eNg/kEsJmBHzwpEnMVhrtBwWF7O2Ee+b/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZOso7Pl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-acae7e7587dso107034966b.2;
        Thu, 17 Apr 2025 05:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744892156; x=1745496956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OUJ14Q/wp8t71IM3YE/NevYBGnSm24K1weaRXQsU0zY=;
        b=EZOso7PlWlSf07rxXEGtKLJl7ZawNEUGuPsBZUZYDbfHNccBXFNBSBdgkOTpoM3psT
         SPiPvk10QeBoTREm8osekIqo+xjmewgtkVUnP4PUNbU4bo37dCGXQsJxpsGQDdNQDI7R
         IWAdf0wHeL2MCzbiDIH8pLiVOzu/9JoIbppsZvUgXvjiP9MuhL8lAXtdLTNHnQU3xVV8
         RKbYiVVFks4v7bxfnQ9pN51a8ckzt/In9xLmugcZZOjcqIwmLBTBo1yzPjHQ5/OTWdLv
         mtuRlbP9zATG9v70nd4uxnM/+oVSWIq1pEhV5e+NJ4PBpldbO2o1q0UOfGqC860SBQ1M
         6A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744892156; x=1745496956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUJ14Q/wp8t71IM3YE/NevYBGnSm24K1weaRXQsU0zY=;
        b=sI642Y1LFAUzQ3rcsaImSjz/7J/tfmjksPsON+4RL58sEZ7D6du7YJLVco77mpdC1U
         5vZPr0nNXWamc10GOmHQuE0LaTxvKO0cuThNqeMiuXCAYY7jdw88lQGDzqFUBoemxywJ
         kAeQOJ4DXtJpm8UEPREJpCBxbTRTorOJN/QzNSbYn35JOr5SwOw6pOmTuy2wi/5bHNlB
         ZkR/Cv+QxCyFJqBP0zHM/oMVGhXC7cusC/UsQUfWPaq08kl+rRbY1HCGMJTpMO0AoOej
         ihvOHyUwTwtH1rklzd0ppNpEcocskHzB8T4tsEJrmbYFmpEQuGpL4CntocwszDEgBIJt
         uImg==
X-Forwarded-Encrypted: i=1; AJvYcCUdP3OXvL2JP5loNHhwTXHBovfExvtkyu7molmMxBYuc+qImghFEHjDrE1dsc5GE3fz1kY=@vger.kernel.org, AJvYcCV3IIQLGGa2/sOpTatbymy7/nCRVcC89tx5kTCp7KaKWxiFOc33RrR0pjrn+lPzhFqBF5z5UmSnA7hlVC9vCOOZ@vger.kernel.org, AJvYcCXAgFt6N7Hx44+p4A/F6kq6fnOM4yBIoiC2KPXhusY4uGHRQaaPDxKgYC/onc6gPQ3D9nCAHm08PCaZcMp+@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx/1L1197NNUVR2gkevoWNNiAxhaqkwuW7W2xqCiBy82VYmLa6
	ius7Kysl9mzF56QRskn4fHcgxJNroPZnziT/ittgkwkN3ERCj8Vz8QxZTg==
X-Gm-Gg: ASbGnctRtxKypUiL/D4hYGOZ6LArETBD54a5HfhhKXRCOAmEyrAot4Dh+a28DOkgL0r
	Du9CbEmQ7zV/GCb6hhIPo1FAcjiXZMrTE3XhI2ZzWnDWEQxu0kM5tIs75t8bFEXHRde2yc68V7x
	JT1r4eLLJrc4ApEY6fTIYdxidzwaagbPAojHv6V7uWHmpoA5A34myz9mlqsrd3rc/exHfIZlHeU
	Necq0Qo59YldSsT6CAIYGhLpa8xxqSEjnqWWRiF6QtbtY1XtHZ5DxfVwhsQeogpAyhpUm6aH40I
	X5Amf7v67l5xYMVDK0XXqzr+xk342RV4
X-Google-Smtp-Source: AGHT+IE7/vNmio6sAeclOjmWpSweu38zWJ6HuV1eNkFF8HpE1SRATrqkyDEsyNNg156IK3QR0LONPg==
X-Received: by 2002:a17:906:49b:b0:acb:4e0c:23ed with SMTP id a640c23a62f3a-acb4e0c2616mr294067266b.14.1744892155924;
        Thu, 17 Apr 2025 05:15:55 -0700 (PDT)
Received: from krava ([2a00:102a:400b:c830:675c:d00d:19b9:1f1c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f069174sm9865882a12.37.2025.04.17.05.15.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 05:15:55 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 17 Apr 2025 14:15:51 +0200
To: KaFai Wan <mannkafai@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mykolal@fb.com,
	shuah@kernel.org, memxor@gmail.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kafai.wan@hotmail.com, leon.hwang@linux.dev
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Allow access to const void pointer
 arguments in tracing programs
Message-ID: <aADw97YoFMGPGnJJ@krava>
References: <20250416161756.1079178-1-kafai.wan@hotmail.com>
 <20250416161756.1079178-2-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416161756.1079178-2-kafai.wan@hotmail.com>

On Thu, Apr 17, 2025 at 12:17:55AM +0800, KaFai Wan wrote:
> Adding support to access arguments with const void pointer arguments
> in tracing programs.
> 
> Currently we allow tracing programs to access void pointers. If we try to
> access argument which is pointer to const void like 2nd argument in kfree,
> verifier will fail to load the program with;
> 
> 0: R1=ctx() R10=fp0
> ; asm volatile ("r2 = *(u64 *)(r1 + 8); ");
> 0: (79) r2 = *(u64 *)(r1 +8)
> func 'kfree' arg1 type UNKNOWN is not a struct
> 
> Changing the is_int_ptr to void and generic integer check and renaming
> it to is_void_or_int_ptr.
> 
> Cc: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
> ---
>  kernel/bpf/btf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16ba36f34dfa..0b1724453b75 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6383,12 +6383,12 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
>  		return prog->aux->attach_btf;
>  }
>  
> -static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
> +static bool is_void_or_int_ptr(struct btf *btf, const struct btf_type *t)
>  {
>  	/* skip modifiers */
>  	t = btf_type_skip_modifiers(btf, t->type, NULL);
>  
> -	return btf_type_is_int(t);
> +	return btf_type_is_void(t) || btf_type_is_int(t);
>  }
>  
>  static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
> @@ -6783,7 +6783,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		 */
>  		return true;

could we remove the above check then? 

        if (t->type == 0)
                /* This is a pointer to void.
                 * It is the same as scalar from the verifier safety pov.
                 * No further pointer walking is allowed.
                 */
                return true;

jirka

>  
> -	if (is_int_ptr(btf, t))
> +	if (is_void_or_int_ptr(btf, t))
>  		return true;
>  
>  	/* this is a pointer to another type */
> -- 
> 2.43.0
> 

