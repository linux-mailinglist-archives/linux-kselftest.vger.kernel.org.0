Return-Path: <linux-kselftest+bounces-10937-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 113A78D5213
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 21:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4349A1C22CA4
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 May 2024 19:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470206BFA8;
	Thu, 30 May 2024 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTfwsmWE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5309D6A8DC
	for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 19:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717096056; cv=none; b=Ju2cP9mEmyzfR3AdJlKmvyJ9EVTaJGkQOjIGXj2sH3lZCcFmz+Enq0p78CeSlQ73Bc7feASkEWxf52Km2f2Jx2qx7gmzeGKMAgm8eN+87xsokSZ0u7oXxYFg98+O7E373HW0Olpn67Sp0E/P8RGFq/9+zclPuj7zzzgIgsF9p1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717096056; c=relaxed/simple;
	bh=imZhQcOLo/A57RIklfhNXDPLYJZwF4mjSMXlBfn4bjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T+ZIusAq2vbuxPoNPtKIgyuLRMknbxiIy2gySpA6X8rHuYzcokhV3Kjh/43a2Hc60RV3TGGmRHSe6FbJGwJm91E+qUTK02WNYPdoA/rJ/qD5gEvsLzvGKn9ylGRJrLoZfkk7yhrq1UZ0Gc0HUS5JKGNyd2T+GGfPKb42g8SOKOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTfwsmWE; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3745eb24ffaso799335ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 May 2024 12:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717096052; x=1717700852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+bUYnIhpz2h+On3VZsj3Zd6/727awMN92YMgceCOy3k=;
        b=QTfwsmWEN4YXPGyWZyNfv8HoVgJhfzs9XxySraioDrTV7REQ8szrv/Y3wp95Ghij0x
         c1mBg+fHrBzs0sX6viDhM+XerI2Ku40nZO3P4FIZnu8cObFx15MSp0/8Klgad1ogZypd
         7Obwi9vsXY8i2DSCI/65bVKu1Orzqhp4ll32E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717096052; x=1717700852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bUYnIhpz2h+On3VZsj3Zd6/727awMN92YMgceCOy3k=;
        b=loWpDn7fUSHV1Go1C1SdorxP4FpvYFctR9QeVITVVIKv90no5hSouJjDL44i7k8vUl
         8jdab3yKhveEtrNfIWT5Y/rDtG7tF6eMOmFDoBq1MVKT0qFqpHAtbRLuac4tLMff0F39
         Xn8qOYcthhmlIoFDZmTeV0WdGSx7GcfW4ocHx9j8KSdqbPOae5ouXIFEQ0ieqIaqNjIL
         vaYv5H5rMiqGV06nPURSpjL7E6eRG6UAZkflCTm8Ioo0L+QdagV/SQQSz2dw75o70KE+
         QAqG6w957uosD+zbT7c205++ZIX6pbUHyt7Xq1F+0Q54Ko6d6KWS5W/COwKoqGvyc/Os
         6AbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrdWcDI1E3cm+m9a6U8gucpAc42nasJQ/BajhhW7PHZz5BBGq/6oZBaEoWinFyATcXnf+FHuKc5zL30aPgqANOmf6mwvLrtIfE4ECrbZmX
X-Gm-Message-State: AOJu0YyIc+KK3DUSjZwvUKQo5SxyJVkQtz5tQcc48mfIHB06wq+1YI5B
	Kk8qS92JhZ1CQ77+w2aiU0t74ByfagLp3IQyjAh7QaEMKnyEgcNUFzlo1gZJWs4=
X-Google-Smtp-Source: AGHT+IF9l7LBfGVRaO1lXseUgLjeTwRtLuQbVpQCUEF4bDP7enC9s+0s5gWCrSJYh2zfm16q0xSmUQ==
X-Received: by 2002:a5d:8601:0:b0:7d9:eeb8:ddeb with SMTP id ca18e2360f4ac-7eaf5d91d5fmr333582139f.2.1717096052448;
        Thu, 30 May 2024 12:07:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b48764e4b8sm67181173.35.2024.05.30.12.07.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 12:07:32 -0700 (PDT)
Message-ID: <dd3f1b86-504e-4b65-b45f-2e36fc55f179@linuxfoundation.org>
Date: Thu, 30 May 2024 13:07:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/futex: pass _GNU_SOURCE without a value
 to the compiler
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Edward Liaw <edliaw@google.com>,
 =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
 "Nysal Jan K . A" <nysal@linux.ibm.com>, Mark Brown <broonie@kernel.org>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240529022938.129624-1-jhubbard@nvidia.com>
 <20240529022938.129624-4-jhubbard@nvidia.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529022938.129624-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/28/24 20:29, John Hubbard wrote:
> It's slightly better to set _GNU_SOURCE in the source code, but if one
> must do it via the compiler invocation, then the best way to do so is
> this:
> 
>      $(CC) -D_GNU_SOURCE=
> 
> ...because otherwise, if this form is used:
> 
>      $(CC) -D_GNU_SOURCE
> 
> ...then that leads the compiler to set a value, as if you had passed in:
> 
>      $(CC) -D_GNU_SOURCE=1
> 
> That, in turn, leads to warnings under both gcc and clang, like this:
> 
>      futex_requeue_pi.c:20: warning: "_GNU_SOURCE" redefined
> 
> Fix this by using the "-D_GNU_SOURCE=" form.
> 
> Reviewed-by: Edward Liaw <edliaw@google.com>
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>   tools/testing/selftests/futex/functional/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
> index a392d0917b4e..994fa3468f17 100644
> --- a/tools/testing/selftests/futex/functional/Makefile
> +++ b/tools/testing/selftests/futex/functional/Makefile
> @@ -1,6 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0
>   INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
> -CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE -pthread $(INCLUDES) $(KHDR_INCLUDES)
> +CFLAGS := $(CFLAGS) -g -O2 -Wall -D_GNU_SOURCE= -pthread $(INCLUDES) $(KHDR_INCLUDES)
>   LDLIBS := -lpthread -lrt
>   
>   LOCAL_HDRS := \

This looks fine. Applied now to linux-kselftest fixes branch

thanks,
-- Shuah

