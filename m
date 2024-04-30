Return-Path: <linux-kselftest+bounces-9098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 411A28B66D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 02:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD481F21AE6
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 00:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78870623;
	Tue, 30 Apr 2024 00:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYBFM52m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A1136C
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 00:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714436274; cv=none; b=di7j8uBLV/mkweaMk7h4gnZaPvWiIYDUMt8RF10K+AYbwzpHDfGXwjBZ3tCaJDCgYcQr36TbgtekFjfI4D8+JeansGK8tZRmjcujhU+VvRJK6duL31KvXFkb3u1VWZEoB2wLXyHjrM3XFZNOTIT9puAeNlpRR1RCYxqpdVUHbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714436274; c=relaxed/simple;
	bh=zcQMVubjuiX7aI5h+1mB/JKiS+LzDcsoiUn13gUVidY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1Ga2T5YXV8qKFSn8IqEsW39TfDboFsf+yrDZ85/oIWQ96daznXyq5+DvS7gs1olblDuOiFIteJyOu/VSVqs3rRwBAft8F1yCrSjsCPwVQpyIhdLcTOkCAZDcBjeTWRlhIolJtyE8VKeOdtCTMMAFvQQDfjQQuaanzIfnSkQ+OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYBFM52m; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36b08fc1913so16869715ab.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Apr 2024 17:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714436272; x=1715041072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wwskn8wHob0aiuWt7oahW5gvmqR22bCIIQzL1vy/1Vk=;
        b=GYBFM52mYo4rUUhrbqS72PIED0GdN96iqGCW5qV0jQnzygTu0HoHRU7Oe+vwvshR4m
         EKO5HRvAqB/i6lMdQCoE0ygVYOCW+MXgiL7KA/SwPiOKYPPbqLq+8HTjPS6hzwJ87p9l
         j+YmjA6DG3T3OeF2UN1nVhqUzAsiQgyHUCnO1V9zdxjP2BQr9RV9Lf95E/U5y4FAbRZz
         C6kNpv38xs+FDteyqvJger+FB12Txei3DDkRU3ZT1Rf4I/kYlZNBNS1ay7UP6fjqfRn5
         48fpt9p2nK1Nnky35V5FkahTvfsqYsx04hEfpks5R9q5LRvJDcT9FC7JCr1zKQ+S87cJ
         SwCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714436272; x=1715041072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wwskn8wHob0aiuWt7oahW5gvmqR22bCIIQzL1vy/1Vk=;
        b=s3P5cjYOBcSQEZ029t5hdiC5+P1N5zAgbq4/uJx+SU6HmhPWcXMzrXgjY/NDS/a3JD
         ctXziw6hdEc0pNQXAfV26ngSMkKp4APh1lXmhjjQ/rpJvNfOi6gGahsAvhZ0r3LIOxt5
         VO9MPkP1HA/2t0GgSGUYngTSUjJ2uQKeMJmvmFXM8FhHB3VLW/m3fu8raJYusJN6E6R7
         p9M8w2GEFXTxGLJkKXbC9/VbyihXEp9VmjA4Ddi1vVzXhDma79+z7Y1gvJc+GaSiPHXx
         WiYtbSo1dfBPN7ZwUJCuh7h2mvGNwLJ4crPnKZQX43w2dqvoR2vxueBdxDCVW9NZN3tU
         EQ4Q==
X-Forwarded-Encrypted: i=1; AJvYcCW2b7/9xxbnFRqiSsHQMarVYnyHdfTtoyYVnrYgrebnUzZKnCWkotmLKuM0I8t60KF3yM/unXEM0vbR4cqvHT4WikrcEF64qMYfRESTamJH
X-Gm-Message-State: AOJu0Yxothol+TimzSGhERR1TC2i1V3I1ed3LRDR9TV3j1Ldz7OMbb4o
	r9t8BmIv+w30WssOM5k0Y1ZwrZ5XNalz+wsLJw/LeOdSZLxg+vn1aBn7uzPiKQ==
X-Google-Smtp-Source: AGHT+IH9ZpHbIbR+PH37031tfohQuWl2RhYefdfEjAqVtOPnbjU6itGtSPkwvvkahLjNm79OM9oG9g==
X-Received: by 2002:a05:6e02:1aa3:b0:36c:442f:9590 with SMTP id l3-20020a056e021aa300b0036c442f9590mr1155822ilv.13.1714436272103;
        Mon, 29 Apr 2024 17:17:52 -0700 (PDT)
Received: from google.com (195.121.66.34.bc.googleusercontent.com. [34.66.121.195])
        by smtp.gmail.com with ESMTPSA id bv7-20020a056638448700b004874ea2e03csm2369644jab.124.2024.04.29.17.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 17:17:51 -0700 (PDT)
Date: Tue, 30 Apr 2024 00:17:46 +0000
From: Justin Stitt <justinstitt@google.com>
To: Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, "H. Peter Anvin" <hpa@linux.intel.com>, 
	Andy Lutomirski <luto@mit.edu>, linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	llvm@lists.linux.dev
Subject: Re: [PATCH] selftests/vDSO: Fix assignment in condition without
 parentheses
Message-ID: <mwrlqn2ddkepz6ayksk562uloq3ksejf3vu4i5xaoz2xnj6cl6@mwuquhhp3lwj>
References: <20240429203441.143607-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429203441.143607-1-edliaw@google.com>

On Mon, Apr 29, 2024 at 08:34:36PM +0000, Edward Liaw wrote:
> Fixes clang compiler warnings by adding parentheses:
> 
> parse_vdso.c:65:9: warning: using the result of an assignment as a condition without parentheses [-Wparentheses]
>                 if (g = h & 0xf0000000)
>                     ~~^~~~~~~~~~~~~~~~
> parse_vdso.c:65:9: note: place parentheses around the assignment to silence this warning
>                 if (g = h & 0xf0000000)
>                       ^
>                     (                 )
> parse_vdso.c:65:9: note: use '==' to turn this assignment into an equality comparison
>                 if (g = h & 0xf0000000)
>                       ^
>                       ==
> 
> Fixes: 98eedc3a9dbf ("Document the vDSO and add a reference parser")
> Signed-off-by: Edward Liaw <edliaw@google.com>

For readability's sake, I tend to prefer just taking the assignment out
of the if statement:

g = h & 0xf0000000;
then testing it:
if (g) ...

but as it stands it's fine and the warning goes away.

Reviewed-by: Justin Stitt <justinstitt@google.com>
> ---
>  tools/testing/selftests/vDSO/parse_vdso.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
> index 413f75620a35..b9cf771006da 100644
> --- a/tools/testing/selftests/vDSO/parse_vdso.c
> +++ b/tools/testing/selftests/vDSO/parse_vdso.c
> @@ -62,7 +62,7 @@ static unsigned long elf_hash(const unsigned char *name)
>  	while (*name)
>  	{
>  		h = (h << 4) + *name++;
> -		if (g = h & 0xf0000000)
> +		if ((g = h & 0xf0000000))
>  			h ^= g >> 24;
>  		h &= ~g;
>  	}
> -- 
> 2.44.0.769.g3c40516874-goog
> 

