Return-Path: <linux-kselftest+bounces-34295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD7ACDA50
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 10:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E6D1895D73
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 08:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4B28C2D4;
	Wed,  4 Jun 2025 08:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOay6inI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE9528B7E1;
	Wed,  4 Jun 2025 08:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027187; cv=none; b=GhgUiB8ZtX9ICkyeDAfmn2usM4+A4Evbhg+9pHj5wokBnD3XJN7IFuneChFxIhDKobJwsknrTl98W2/Dv8818hQGj8Miava9doBZf9XnGCTP1dUpUhIk6LmLCc/40kURr/ie8zX6V5P8Cui2t290CNoM8E7eUZ+vnKEyg8kAlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027187; c=relaxed/simple;
	bh=2mLmpUCes52p/QBWu3WTp8hFc3VJZP5x4b4BAFPXNKY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rY2lqk9q3b+fUU8kOTWyljtvsfgtl4VLDblrQaEQIIkRbLVXksv1LYGLU+J33WiKYB9GSaJYWWthn6PjNTUuhfnchizkogOjjIYmBj9uI5twCvh/iIWUIp9mBdEzTOsxORiBJrZsZaG6CZgOrVYc4LADVcA5Ivc0lNcXSLxXoaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOay6inI; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-442ea341570so45716745e9.1;
        Wed, 04 Jun 2025 01:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749027184; x=1749631984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLM7LBm37WJqJap/lEtkbB8hYDWJRhXgHcZgsy5d+m4=;
        b=YOay6inIoT0QwFwhuzoxbwrzFx++4aOIj3vOTISw9Di/bpbCKYHgF7xqjIQHn/wtSG
         JvY6NOK52rSEEayfHhvhrrQka6pSKNF5QMsHxfUvHZt5etEB0xzq91NucAMLoM9+XLy1
         8X+IptqV9wvIyhkO17Wr5wabQnTwBmMD8vT/E5xtHGr/5vXxzvhozZ2ifGioq+ocIMT+
         9082T8Sgj5P4OWVR7NoZ5w3Lhmq50JEN+bZcnTCXaeJ92psskQc/HiNxTqKwA9ujGrzU
         hzWJhcA1zKcn+v6wO+hlxx8wQ7j3opxN+32Qdxha5shZZOa4b3fkQ6PPjEowIWGPGDK6
         Ysbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027184; x=1749631984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLM7LBm37WJqJap/lEtkbB8hYDWJRhXgHcZgsy5d+m4=;
        b=o6cWS/6duHdeHfawoPa6MhVUJwmaeSnNwrekzIdkYhZRjcaolS75OQ12v1IxBpdTIa
         p4JST7FPhG92YfSIEudsVkKSXhupQa4iNL9oz88PztqzljLHp9o7TSnScRolb7lMwBF1
         L7r8KlmJzb9wwA6jSCRtd7TTKldVN5sOFL/Eqxr9HD+OGYGQYug1UmOBtFqzXRwOjutw
         N2ewpD3fP2uBreCYmUig2w8ptjO1P1tTtKL3TLkK+Mce9xc2NCHfsGayYTrhqKRpYmYN
         S/+pDNMEKLr5WZ/NVE/Bhs3FFbG5MUCaaV7vrKJVRdqi1D+/UJSNjiYo0y5OCl1SfXEv
         OidQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDbs48AQoZz+xJm08FsXmLI2/bnzczks/tg5Ia87lIO9MCMOhwG8Gc7WddSzuSR2GCHRA=@vger.kernel.org, AJvYcCVTQM6QnpwFKKyWxTdOJMPB6u8ss2nnpd5k1qgc9IarSfcxcHvZOXUIJgmPf1bLL3BdWW6WdlgPhUlDGJTTrFPD@vger.kernel.org, AJvYcCWANMLzCCHUFuh18syVHGcisPVtqW8W9rn7lui7Jm722koca1Hv38zRXS+eRjQ0UjvJGIHI5rE5Sr/K+WSC@vger.kernel.org
X-Gm-Message-State: AOJu0YwAoOXyYFAy9MRx52vMOUd8TI+weseNvaAT/YeciGVW1uFlq0WZ
	dsFd6r7o5ha8F21y9UbIToRCr8ccPqrAN6qDJAqe4P43bIwv5kTGN06A
X-Gm-Gg: ASbGncsM6qao3Q4SbZi15+XXTac6UUtSGpIKYhsveIjtwRTlwWyr/iymShGhqrHvxUT
	MlNh+sKAOZo7FG3PyeXAxJF+5mHKrfO97okgL/KAHOTnKJVt+0njk8gGLu+9ziCVBrrKi3soipw
	TRfyzah87BgAjrFZTeGh7sUmDcyRkdm7jmVbxML9GvTDehGEfQFf+DE2uq7UeG31zkQtA2VZLcV
	ba0wuO7p8Vz1D6jF+1FdOz2gG49kTZTf/WabaQcCRV+1zpgecUXG8/miYQePZT5OTAZc0PKvCjK
	/qnqwPaMfysXZxt7VJKxpcekeWTYkXn2BpRHvEI=
X-Google-Smtp-Source: AGHT+IEimdhpyVCbWCs8OZcEOw5A8tU+m2ddmRqylRHVPijI8dxrP/UOu9X8Wnc/BPaO81v0RDpm7w==
X-Received: by 2002:a05:600c:6749:b0:43c:f6c6:578c with SMTP id 5b1f17b1804b1-451f0ab417fmr15621325e9.15.1749027183601;
        Wed, 04 Jun 2025 01:53:03 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fa2566sm186916685e9.13.2025.06.04.01.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:53:03 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 4 Jun 2025 10:53:00 +0200
To: Rong Tao <rtoax@foxmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, rongtao@cestc.cn,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Amery Hung <ameryhung@gmail.com>,
	Juntong Deng <juntong.deng@outlook.com>,
	Oleg Nesterov <oleg@redhat.com>,
	"open list:BPF [SELFTESTS] (Test Runners & Infrastructure)" <bpf@vger.kernel.org>,
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix compile error of
 bin_attribute::read/write()
Message-ID: <aEAJbBH00yL2iTgn@krava>
References: <tencent_A6502A28AF21A3CA88B106F3421159869708@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A6502A28AF21A3CA88B106F3421159869708@qq.com>

On Wed, Jun 04, 2025 at 01:53:22PM +0800, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
> 
> Since commit 97d06802d10a ("sysfs: constify bin_attribute argument of
> bin_attribute::read/write()"), make bin_attribute parameter of
> bin_attribute::read/write() const.

hi,
there's already fix for this in bpf/master

thanks,
jirka

> 
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/bpf/test_kmods/bpf_testmod.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> index e6c248e3ae54..e9e918cdf31f 100644
> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
> @@ -385,7 +385,7 @@ int bpf_testmod_fentry_ok;
>  
>  noinline ssize_t
>  bpf_testmod_test_read(struct file *file, struct kobject *kobj,
> -		      struct bin_attribute *bin_attr,
> +		      const struct bin_attribute *bin_attr,
>  		      char *buf, loff_t off, size_t len)
>  {
>  	struct bpf_testmod_test_read_ctx ctx = {
> @@ -465,7 +465,7 @@ ALLOW_ERROR_INJECTION(bpf_testmod_test_read, ERRNO);
>  
>  noinline ssize_t
>  bpf_testmod_test_write(struct file *file, struct kobject *kobj,
> -		      struct bin_attribute *bin_attr,
> +		      const struct bin_attribute *bin_attr,
>  		      char *buf, loff_t off, size_t len)
>  {
>  	struct bpf_testmod_test_write_ctx ctx = {
> @@ -567,7 +567,7 @@ static void testmod_unregister_uprobe(void)
>  
>  static ssize_t
>  bpf_testmod_uprobe_write(struct file *file, struct kobject *kobj,
> -			 struct bin_attribute *bin_attr,
> +			 const struct bin_attribute *bin_attr,
>  			 char *buf, loff_t off, size_t len)
>  {
>  	unsigned long offset = 0;
> -- 
> 2.49.0
> 

