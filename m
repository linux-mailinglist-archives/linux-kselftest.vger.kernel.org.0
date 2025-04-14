Return-Path: <linux-kselftest+bounces-30664-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCDDA87DC1
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCDB016EA5B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 10:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1258B25A2BB;
	Mon, 14 Apr 2025 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fa1H9Uou"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1161AAC9;
	Mon, 14 Apr 2025 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626913; cv=none; b=EuH/eHbcVR9jo2VGjiut6U0MvN0TNYkSrWm2uHu2LtXJ6QkD3Bjv/RkcmJkU/vOosBRI0GwfvCQWNrEi36fUi2FC9Kw1cCY3YvfbCyYu9J2BEqAnjmLQ+CBIEkxlgG0QrgBpvCCnWvEwkDlVi5PMe1xjgU5uj/S4GBw96s8l2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626913; c=relaxed/simple;
	bh=isBHQQS1YcINTLDnycm1hsfDzJEWsC2mn2TVJdwdBkY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpUI+LaKJegAknaidkus1cwn2JYidB300m/gcOxC8dpvHqulUENUKRulOInfOzckIaTRotCvOdHsOErWi+2gRdrpkw9k7abBstDda8r3huKV9SfGSHGwsCi9qT6S1Yte8V7E9qM00hpkrmwiWb5uk6CMXMQg3prkN0ORnbbDA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fa1H9Uou; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39149bccb69so4069728f8f.2;
        Mon, 14 Apr 2025 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744626909; x=1745231709; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Z2BPWgjrdlwWu/KjJQ/Eda2Yqq0Z2jaRi9fA/ZNEYc=;
        b=fa1H9Uoub65tpsettYv6l9KubWVybn12Mk4lzu5Lqj5wSpiqXb33314xb5fMgIcsDH
         0VIEQKiqV8g/ZGyqAPHWg9S1PWX7ze/PuUfecBjdlUYoHj4e692EEOT+XOLmXX2ChknZ
         OEIZpIc5efW9NqxCsCaluHisjqtvz6nsYzUmB8Uxx9LqdgzYEJHfLeEa0T8UvgdPBMtx
         BZ/bAFXkMDhkRyQpKVKI57X5o6TcBUlmiPCteTVJnyPcXaEwqr7QlWjJDz3v/vk3yeqE
         eJPyNect0+H0bgav7i7k6u2pFGOg9E1clvNVffbNyP6f1diZmVDzYHKySXKggi6SWRhu
         9jCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744626909; x=1745231709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z2BPWgjrdlwWu/KjJQ/Eda2Yqq0Z2jaRi9fA/ZNEYc=;
        b=qGxXAUpMJpSfERGqKfCfOfU1orcOM+if8wivlvc9MRCRwCWhzqD8LRwaIRZWvjyRIm
         67c4ZT+JYBzlQ5yeyrh+Ujpkeg1mp42mDLlpViUvlTvDxN1Fyi2Cjt5WMQHZK2gvHeJi
         BVkmMWpwCS9OQK4P2w7Tfe0pD3bHz6YRX8TtCk/Zr98cROmujJ6vuZ7lPFqlU6lUxOc3
         tBq1aWQr/LgsScWR+IZyqA/8Wqdo7CnD3UZe033LWYoO7anT/A16hMIl1f14Tq92EW+Q
         1YI1MrBlacyEPVOEXe+6tfcAq02WHcI2TrOzNNXc122eDskxf9fBSwq2eR7e9hgy2Uv5
         8sAg==
X-Forwarded-Encrypted: i=1; AJvYcCWHM/RwYjYZtZ7xTfQcir0lfeRnw8jJ+zphScu9scsMua0eAmy/2SLFBJ/gonvlcSZs//Kdk9dF43ue535N@vger.kernel.org, AJvYcCWsulVQcrnHf2axfuT8/S+vjYotbQDlvmmd2UmHvJbxOSKBitSfmgSeVbSJ0cc/XV/p008ePIpuXgImW0uZc/1U@vger.kernel.org, AJvYcCX7AHpxmzZ+4MmS33dSdnDNtNujaAoPWByLaIm6rZRNUhAB1Nuu1+nh6rQqgaLYkLKYSBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCg1mu676aFxOJ9kIFo6HRtxhCajQ66Ul2BwIHFJwa82ylxXT2
	3AW97zkrfRga1b57EQKG6CNEXWqg8IyjeqxxYuUMGDgc/mZ/fibB
X-Gm-Gg: ASbGncvrTDGzPTzImQ5E5TRoiFAuMOsSuJmJjZTwuUofr459VjS7vAlqLJ8NICkb88h
	9+yRmAQdfx2bV/dtcMUhiB6ZV8xVLQOJoPx8ZRycsSxrxSqR9qmAevdezR0GYogbb0tvMxiNvlR
	WVkAt9UZU2K809GhV4sSucbFtBoHAD9cDu22WHbLjZT5WxvIelJ9HDdmtFeok4V1Jk+gdcXAVUD
	qCkEEPmukRt3VC/rLOVM02h97wcLE+iMy/nIw7eZA2aAJ6KEH1xBySPq/qhecUwIbqcYgSGuHVy
	XSIJQSD011DqZLH4jz7POgUCRwkG47j1UrVjcADq8w==
X-Google-Smtp-Source: AGHT+IGBHhOZ7C4XqIjtcsjl6B6jQw71+8cadwiqWO6xd5ELBt2rrEvAYRUg3Q+wx/FyAmra6Xc1Sg==
X-Received: by 2002:a5d:5f52:0:b0:38d:badf:9df5 with SMTP id ffacd0b85a97d-39ea51f46dfmr8136245f8f.17.1744626909219;
        Mon, 14 Apr 2025 03:35:09 -0700 (PDT)
Received: from krava ([2a00:102a:4007:73e1:1681:405:90b2:869b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39ed1652a91sm5580205f8f.75.2025.04.14.03.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 03:35:08 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 14 Apr 2025 12:35:05 +0200
To: KaFai Wan <mannkafai@gmail.com>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	mykolal@fb.com, shuah@kernel.org, memxor@gmail.com,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kafai.wan@hotmail.com,
	leon.hwang@linux.dev
Subject: Re: [PATCH bpf-next 1/2] bpf: Allow access to const void pointer
 arguments in tracing programs
Message-ID: <Z_zk2ZaG5fRRFQio@krava>
References: <20250412170626.3638516-1-kafai.wan@hotmail.com>
 <20250412170626.3638516-2-kafai.wan@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412170626.3638516-2-kafai.wan@hotmail.com>

On Sun, Apr 13, 2025 at 01:06:25AM +0800, KaFai Wan wrote:
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
> Adding is_void_ptr to generic void  pointer check.
> 
> Cc: Leon Hwang <leon.hwang@linux.dev>
> Signed-off-by: KaFai Wan <kafai.wan@hotmail.com>
> ---
>  kernel/bpf/btf.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 16ba36f34dfa..e11d3afd0562 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6383,6 +6383,14 @@ struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog)
>  		return prog->aux->attach_btf;
>  }
>  
> +static bool is_void_ptr(struct btf *btf, const struct btf_type *t)
> +{
> +	/* skip modifiers */
> +	t = btf_type_skip_modifiers(btf, t->type, NULL);
> +
> +	return t->type == 0;

I think you can use btf_type_is_void in here

> +}
> +
>  static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
>  {
>  	/* skip modifiers */
> @@ -6776,7 +6784,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
>  		}
>  	}
>  
> -	if (t->type == 0)
> +	if (is_void_ptr(btf, t))

lgtm,

nit, the is_void_ptr name suggest there's also ptr check in the helper function,
which is not the case. I understand it follows is_int_ptr name, but perhaps we
could rename both helpers to is_void and is_int ... feel free to ignore ;-)

jirka


>  		/* This is a pointer to void.
>  		 * It is the same as scalar from the verifier safety pov.
>  		 * No further pointer walking is allowed.
> -- 
> 2.43.0
> 

