Return-Path: <linux-kselftest+bounces-44055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECAEC0A05D
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 23:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0DB54E20BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Oct 2025 21:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A426CE2D;
	Sat, 25 Oct 2025 21:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZEX4CE+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C3125D540
	for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 21:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761427097; cv=none; b=A02a6vwnimbumle4NnzhCNgaM61Gz92xboo9Rk5ztxElnX8qczxPX/mq330w7pbcghTPADV83vy5Rm81uc+Pps8Py887g/KE77q1fhPm1C+QiytnKgTcfZrIhdOjg+c5ijgbrc4UKCa0NDP08wLZBkh9DoLWkDoOQPSCAH4YHyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761427097; c=relaxed/simple;
	bh=3bsFJNE4DE47AGrHwWCWsH5kkVM8VML79+gkO8TWy4Y=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eFp/V65fd49E4B79zIllR0J9/H5xmFCQiFYiw4i20e4UyVhVkn5JP/qrf+22E2cvj6IAe7qqNQ6vEndhHYzfOQE2TqMGDQv3qJnpS1YRyT/JTPt9JDzWFhQ2srvL4G7Q8GQMcodMa/l0Zp4KDMVuIpYzm7dPng+sqB/ptqI3/Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZEX4CE+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so5512575e9.2
        for <linux-kselftest@vger.kernel.org>; Sat, 25 Oct 2025 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761427093; x=1762031893; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3c1WBcRxq8wi3EgsqQk7zV+qxOcJsiv7FtZH/pCDIvU=;
        b=mZEX4CE+Evz7rK6n13uoO+oaBt/vTGBXt6fMM7JWaD83VHSqUwqR8XS9AA/Ol8qIhc
         4GcmTV3pvquzRxqc2hPUKAsiT8jDcLxBsbBTf1V+HLskARyMqjmeRWROkDCf5VoRc/NT
         gyE6puY26dU+BDRxJriQfusveL7gHfG2lAMSWoa5CRsbQkDUAzZOrYpQVvfW6TxlfLWF
         39Vex8olo0zFL91ltxC3ncEYXDLSlumoL0JPGv/gIEyNz33LJ0mtUnZwEKVTG64JNkgi
         DnjcdRQlnJdypsllSllkeo+c/+PV7PDeQGXB+ZEfNKr+oRJi45h5FF6zKVY2ngPbqoDt
         dscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761427093; x=1762031893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3c1WBcRxq8wi3EgsqQk7zV+qxOcJsiv7FtZH/pCDIvU=;
        b=Mgcr3de6v53TlPaZfxLu/8DD70WefHnwIaUoYEdxqZKv36BflmGCW4BFHwaQYtt32Z
         hUEDDZRrJWIBhtlE2BIq2R1bEY5fsA51E3Ylm27p7VliNFjJHrGsZO2EWAAMP2YAQ68S
         4psPCYA7yNIDfur+Wib/CgYsiH+Ve3Tyx0ng5sION4CmwpdGoUBKec7eSePwRxAaFsx7
         P7GrqsqkpuSVIfenB6F8YRVlob2ln2au7e8f1LSF9IZxD0sKVb+W4csQRGldRt4gaS0/
         lgR7BqtB2NuTfnr65d+twjx1PDatQ1htIQN1QQqkDpbIw+fUYqwcZHErhG5lKRcw0ycQ
         RNfw==
X-Forwarded-Encrypted: i=1; AJvYcCUA76flUy8gxiRV+AGzXWNM64Y1Hp17jLi1M38CVkErcypnsAXvdb5sACVM0ye4IpU9QPbB3ZGJBNskDNKD+vA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw96wuf/fnEteKRlPb/pKji12JL7H8oZky4x7s0rqeazSNMuH4V
	VBVS3bof/a+l7hUYxGGEG5pbB2W/eWTZ4WXLmev9rSeqBAV/0LR3PFHB
X-Gm-Gg: ASbGncveWNMBxzS7b/0jbB4xb11zsOHXYHy5eg8rQqV6na+wq52/8anfsZzqyzVxEMx
	4zQPRArFXgSV9+HsZShrqFYq1MToQFxaOwoTT2GWxJTiKpp/O5fdwL7/mMoBIYKrXTAHSzrAIO1
	myV8xUzRxTRwuFX+9uemXZqanwcSYtZVFIdriJ2c6bT8YUvn01Cx3BDgWkzbDGp38RR9C3gLt1o
	MkaL49MsOo0zV97Yh3bHbB5zSOjbd3P/lV7uWYie6E1jK3k8EG4p+ynIFKVR7WOsWIvozdyNxUl
	KeKb4cXrUVrRDCgf3x60wxQKGY5cWFWveSLxiOJunUx/nDPW+mKwGW8CPm/qqI3QJ0gnGTLRvEt
	2uaOYUU6pTaNQpyCPzqMBIAkyXu+79sSVKEA6EFn4iMhMtDSR99n+TPw0uDd+IwM5UU3ikLGbdg
	U=
X-Google-Smtp-Source: AGHT+IEKmGV6iwycAf4O/Au0c79Uf5s26+e12RwvflkfNHz45yscxbt7voylHffu4v/BbZtKilFDgg==
X-Received: by 2002:a05:600c:64c3:b0:477:ad4:4920 with SMTP id 5b1f17b1804b1-4770ad449b4mr8309285e9.10.1761427093382;
        Sat, 25 Oct 2025 14:18:13 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952db964sm5427322f8f.33.2025.10.25.14.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:18:12 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 25 Oct 2025 23:18:11 +0200
To: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	khalid@kernel.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] selftests/seccomp: fix pointer type mismatch in UPROBE
 test
Message-ID: <aP0-k3vlEEWNUtF8@krava>
References: <20251025184903.154755-2-nirbhay.lkd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251025184903.154755-2-nirbhay.lkd@gmail.com>

On Sun, Oct 26, 2025 at 12:19:04AM +0530, Nirbhay Sharma wrote:
> Fix compilation error in UPROBE_setup caused by pointer type mismatch
> in ternary expression. The probed_uretprobe and probed_uprobe function
> pointers have different type attributes (__attribute__((nocf_check))),

just probed_uprobe right?

> which causes the conditional operator to fail with:
> 
>   seccomp_bpf.c:5175:74: error: pointer type mismatch in conditional
>   expression [-Wincompatible-pointer-types]

curious what compiler do you see that with? gcc-15 is silent,
the change looks good to me

thanks,
jirka


> 
> Cast both function pointers to 'const void *' to match the expected
> parameter type of get_uprobe_offset(), resolving the type mismatch
> while preserving the function selection logic.
> 
> Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 874f17763536..e13ffe18ef95 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -5172,7 +5172,8 @@ FIXTURE_SETUP(UPROBE)
>  		ASSERT_GE(bit, 0);
>  	}
>  
> -	offset = get_uprobe_offset(variant->uretprobe ? probed_uretprobe : probed_uprobe);
> +	offset = get_uprobe_offset(variant->uretprobe ?
> +		(const void *)probed_uretprobe : (const void *)probed_uprobe);
>  	ASSERT_GE(offset, 0);
>  
>  	if (variant->uretprobe)
> -- 
> 2.48.1
> 
> 

