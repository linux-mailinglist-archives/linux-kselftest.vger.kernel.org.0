Return-Path: <linux-kselftest+bounces-22386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A71089D47A6
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 07:38:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB01F21A62
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 06:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D171C9B67;
	Thu, 21 Nov 2024 06:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tup/CgMr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA521C4A3C;
	Thu, 21 Nov 2024 06:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732171108; cv=none; b=nN16fpdGftgSAs7bhlzVbQW+zfAdzQ5GRvbS2E6Ot7kuYlAELnDaVhFmIcgahk3UCdhmbxxHuMuhFn3VbyNhZGh3vD3II+OBrMtKbDcgE6cWmWnT71Q7hUjgmOUyP2TGzRjj0FUVC5UBGwgLTJHVJsBysmz7pcZEiY5zoZ/eVyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732171108; c=relaxed/simple;
	bh=u8feEyqexppjlae/GbKD9ygY4w89F+NohiFM3+a3grw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=hHLiyyOIE7T3+xB3mXh0xus4YlarAU+Z718wieaK0irJXQ5Kq97wkpkYVhpguhjv7GQ1b3YaWZjNpN1CmJyHTCIgyQp/XWF/rE9EyZ/3osxXBheIxZZKod1PQzm1w7QIGRAwAQ77KdC9L3L5KXgxUVfqcjhm3zs/zbW941elpmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tup/CgMr; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724d23df764so93843b3a.1;
        Wed, 20 Nov 2024 22:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732171106; x=1732775906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVhGB+uhK4i7clXBCrnAFu8xplWivYQ5CRd7LNvitZE=;
        b=Tup/CgMrZtx6Zvij04D9KFNYopjZYdH3nAvROmQeVgQ92QgYEco1/UN/uZy342c9zx
         x0FviRz7oEIzZLnMekPKTOSC5YNgmWFGkw3xwrzqnFD30zYFfhZnJMWhkYWrvjeWXKao
         74Pgyspa1Iga7HJ4RVAI2ijzKJ6C89+hmu25O6I097b1XL/wsWiDw1oCiVdIqC2xwVix
         04o5QlUV0NkKSunNRjPQjlAWX1mZC3OItgUm6ahoxAJr7MSI46w6ldbNw9odJ2s2r/VB
         tQvKorldB8Zh+EXlKfXTVSG57LCIpIO+ffwqfIcZaLke8ys0h6WyAdk4/SmFa4NMDNa8
         WdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732171106; x=1732775906;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yVhGB+uhK4i7clXBCrnAFu8xplWivYQ5CRd7LNvitZE=;
        b=bt9KhZlgX9+ZB8dTs0SX0xO9yBKhmKuxhxwmIM8701QqFl6rW11Udj5pu3DOtGNdpX
         B9fZ4+5enkx7VZ1IhTBuhysophwiGzT+X4b4IOlvaBwXyhu5Fd23cm3bxkd+XrISbDxu
         y2rZsQEYpjylBp6jrUn/ey1N+Tm581Yf23sJ79ZSGuvqnvSm52uTRgM04IkrQBx6p3Zw
         kK+KEa2vpwIr8rCHgu8TlnLTDBUHC3bNdmDSpgSvJectM3ovmdCQIoISpgHeYBMZqSP1
         wnCim+JjG/v/hQUhvfnYidTMD9oMwqjFPOvBtcoFQ14nNPAU1BfK+VbRWJtT+WMyPyvX
         hQFg==
X-Forwarded-Encrypted: i=1; AJvYcCVnj/rbbrbUcv7sN+tV8Rn4gSWAOoKsdIqjiJZqiD5l1TckBfnUX92HQtzdex8KKwWJF4z18mwMAk+UCDk=@vger.kernel.org, AJvYcCWXSbgPISgp1hVDjLd/kAFYAPIMjcG43E7WOZWqDRKaZdugAIBpXx1ydflRORGCD09vZlybTtcdcyV7yQ//H41t@vger.kernel.org
X-Gm-Message-State: AOJu0Yw14pm9O7pNxbbJE9KJDbuVQBs5wcyMkcQYKF3gZI3SuZKNnkAR
	8pN5VxUvVFofev9HiRZFAL1KVtl26g/UCqjm+4He1m0ALC6JmfYKAxIVOw==
X-Gm-Gg: ASbGncuHW1RChy8H7EVy/kWQ/cYdrJRzq6ygYMQmP1i2oJlX8yyA1VvzHbCQswpankV
	vQnVQuG4PD93oEe/ARvehsgpvgx61CPq/qLqqGjSvpnLyP4TbmtTI/XP58accvqu4JWlrmT7p6z
	sln3Y6LdSWwtH8oGk8+iGwAfUK3WWDR/WXY1sXtPZD3kqG8GYG4kCVZHTgmI4VCTbiBuMVoxH3Q
	VmnV45CtgkRmysROBzXCmwGdGbeHyzbS/ySOGbLwKA/KfRta/Q=
X-Google-Smtp-Source: AGHT+IFY90NoJv1XxElOiRWRnX47j8HegmgYtWeza+AkhFrK3qwrcxG1yRoT1C9s1mGFMNPvmL/n5g==
X-Received: by 2002:a05:6a00:acf:b0:720:2e44:8781 with SMTP id d2e1a72fcca58-724becb775bmr6019934b3a.11.1732171105841;
        Wed, 20 Nov 2024 22:38:25 -0800 (PST)
Received: from localhost ([98.97.39.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724bef8da5csm2812081b3a.130.2024.11.20.22.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 22:38:25 -0800 (PST)
Date: Wed, 20 Nov 2024 22:38:24 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: guanjing <guanjing@cmss.chinamobile.com>, 
 andrii@kernel.org, 
 eddyz87@gmail.com, 
 mykolal@fb.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@linux.dev, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org
Cc: bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 guanjing <guanjing@cmss.chinamobile.com>
Message-ID: <673ed56061103_157a208bc@john.notmuch>
In-Reply-To: <20241117102857.198803-1-guanjing@cmss.chinamobile.com>
References: <20241117102857.198803-1-guanjing@cmss.chinamobile.com>
Subject: RE: [PATCH v1] selftests/bpf: Fix unnecessary conversion to bool in
 'run_subtest'
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

guanjing wrote:
> Fixes the following coccicheck:
> 
> tools/testing/selftests/bpf/test_loader.c:1033:64-69: WARNING: conversion to bool not needed here
> 
> Fixes: 80a4129fcf20 ("selftests/bpf: Add unit tests for bpf_arena_alloc/free_pages")
> Signed-off-by: guanjing <guanjing@cmss.chinamobile.com>
> ---

I'll argue this is bpf-next and no need for a fixes tag here.

>  tools/testing/selftests/bpf/test_loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
> index 3e9b009580d4..400f56f81272 100644
> --- a/tools/testing/selftests/bpf/test_loader.c
> +++ b/tools/testing/selftests/bpf/test_loader.c
> @@ -1030,7 +1030,7 @@ void run_subtest(struct test_loader *tester,
>  		}
>  
>  		do_prog_test_run(bpf_program__fd(tprog), &retval,
> -				 bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL ? true : false);
> +				 bpf_program__type(tprog) == BPF_PROG_TYPE_SYSCALL);
>  		if (retval != subspec->retval && subspec->retval != POINTER_VALUE) {
>  			PRINT_FAIL("Unexpected retval: %d != %d\n", retval, subspec->retval);
>  			goto tobj_cleanup;
> -- 
> 2.33.0
> 
> 
> 



