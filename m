Return-Path: <linux-kselftest+bounces-26352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53867A309D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 12:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94D0E1626F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4811F9AB6;
	Tue, 11 Feb 2025 11:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZTNGrui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA961F9A9C
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 11:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739272772; cv=none; b=FaYSB9MRrqqv6lTiCJsXc94uqftsROS+39xTzui0BX2HhWMWBVLoApvE8NPuOGYd/GzoNMC4mYZdMBGH5Fpo6GVuJ70ZZfO3zoBXk3CesskiKo6JJdU5K6VGefJpeVIB4xsqjWdjTW9k//g/nR/ekLcwj9cEX4i+0F/x5hEJIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739272772; c=relaxed/simple;
	bh=A6kDijY1CxU3jwpKODbbC8vCmkKQJjjacTCdiLn75Lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDDPTWO4tp8LnZhpaTsiVSMXdLCpD1kNNopjrB30sd3VEi4BQg2XvKnudp6n5/wYEaBieBBovQY7Zq+D+Mno41WH0+UV78539jj0X+/B2Oo0Y/BlCyr5bSWdq66yR+2Iy0Tc5zQKKUru7Kmte8WrhvqSvzlJ4dztSk4/o2RHfYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZTNGrui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739272769;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mKKlOAHFJNzqARLCniSKjEWDKr2MGQlvqNtXg2rOPEI=;
	b=DZTNGruizautB6a7PHPwXoJQ8Jz5A0PLuL6uG05O9qaPQ71pTlaBw1yNWX8KBTeP3RZ0Ys
	0gMFEo/NUgsqT4McL2+4RE9ftJWoviw8WNsRV+xmFzweQS/epn+Rp0XwQm4dVYj9bNTqO1
	8SN3sgPPn8CXt5bS/iKV4Lm03xwPSAg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-X1nB6LZEN6yzjiHDLP2tmQ-1; Tue, 11 Feb 2025 06:19:27 -0500
X-MC-Unique: X1nB6LZEN6yzjiHDLP2tmQ-1
X-Mimecast-MFC-AGG-ID: X1nB6LZEN6yzjiHDLP2tmQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393535043bso14950135e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 03:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739272767; x=1739877567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKKlOAHFJNzqARLCniSKjEWDKr2MGQlvqNtXg2rOPEI=;
        b=UQ8UK1jtt00mwx+GfF3802ruu18Ud2ZWz7E88p7CHlTE3T0sTpwSuLiNpTUryRNF9S
         fuTn5oevwLjYG+AY261ClUbk03Lj5ut6Fw4Co/ujECAN47qYK5a7nfrOR3BK/2DpSCc3
         +q6UKMkn5FUQ7X+N86WXkYO8unslbG3Izyy0QfnqFtfBNKiNKNMKog5eNJhHKQlSDDaI
         iWJBS7uTeElPgL8xgc4Och4IeRPsCnAP36zSHjtrIXjNLl7wU7WZyMz1QL5eXtG+RE87
         xIFv0qSjS+m/gXjYxwf8eDkpM45PyN8jXYzNQB0ahn+Dl7huBG5ebs0Dry8OYfmjelhv
         KFyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpOpQQgzhNGUNcaEhCPEXJieUni4rK/rJ3QrN35N98J1a7B9zmYCPtE/N+aALFXmwQp0awmVbM/IvIztfhOtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqvJesO6Sc30Sv8R/RhxFW3SqjEHmapY2ptZdRjOGVfw3Hs5S+
	eI9+1Rh0w8gMmX7BjKQmXfeHx5R/Q6nnMI6+DDTjWsMXjESiUKLyN7On7R8rAUTYDgRvW57pEaZ
	0T5vVaymrv4W+t47kjkZdv9JNI8CxvAXEsEIUlF9WBVZlS4URrit3k6D/XMWvWxLzKA==
X-Gm-Gg: ASbGncu1m++ugGQHCxcQ2Fb5HcsAPkR6w8ljNYpnOCDSvN5qCj1oEiUoP8ckCG1E4X1
	hE64xrRmSIwMe3mNuHx+3OaVMO+F/obEDBzluaUbcBRthjvJj84RETsvJEpeufBjbM/ghmLnxEf
	mzovoaunMilLO0celzMbjKqwsSud7mWkuPXNmGD/MVPdViSgmKbPoJ1wiQJwetWBMgVy7NxMWme
	262szHTybOdqsQ3iH2Na4QRqwYTxTVAj2IbKMr9If6TWSR8YggNWwvSX79/YJF/jzbEr3rNabQe
	Gs+KbNw5wsJeHlAIAUppnAP6OhymNCHlUr4=
X-Received: by 2002:a7b:cd17:0:b0:439:33ac:ba49 with SMTP id 5b1f17b1804b1-4394ceaf87fmr25597385e9.1.1739272766794;
        Tue, 11 Feb 2025 03:19:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJz9n+AsvlWqCu6BA+8Vdyt20fjJ6R8Eet6qzeh2S/tTdd/2jLdGSZwJRO0O1iAJUykgpigQ==
X-Received: by 2002:a7b:cd17:0:b0:439:33ac:ba49 with SMTP id 5b1f17b1804b1-4394ceaf87fmr25597135e9.1.1739272766384;
        Tue, 11 Feb 2025 03:19:26 -0800 (PST)
Received: from [192.168.88.253] (146-241-31-160.dyn.eolo.it. [146.241.31.160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4394f3b8846sm9865315e9.1.2025.02.11.03.19.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 03:19:26 -0800 (PST)
Message-ID: <72634e76-7bb2-48d5-ab21-9d5e86adee9c@redhat.com>
Date: Tue, 11 Feb 2025 12:19:24 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] selftests: net: Add support for testing
 SO_RCVMARK and SO_RCVPRIORITY
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>, netdev@vger.kernel.org
Cc: fejes@inf.elte.hu, edumazet@google.com, kuba@kernel.org,
 willemb@google.com, idosch@idosch.org, horms@kernel.org,
 davem@davemloft.net, shuah@kernel.org, linux-kselftest@vger.kernel.org
References: <20250210192216.37756-1-annaemesenyiri@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250210192216.37756-1-annaemesenyiri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/10/25 8:22 PM, Anna Emese Nyiri wrote:
> Introduce tests to verify the correct functionality of the SO_RCVMARK and 
> SO_RCVPRIORITY socket options.
> 
> Key changes include:
> 
> - so_rcv_listener.c: Implements a receiver application to test the correct 
> behavior of the SO_RCVMARK and SO_RCVPRIORITY options.
> - test_so_rcv.sh: Provides a shell script to automate testing for these options.
> - Makefile: Integrates test_so_rcv.sh into the kernel selftests.
> 
> v2:
> 
> - Add the C part to TEST_GEN_PROGS and .gitignore.
> - Modify buffer space and add IPv6 testing option
> in so_rcv_listener.c.
> - Add IPv6 testing, remove unnecessary comment,
> add kselftest exit codes, run both binaries in a namespace,
> and add sleep in test_so_rcv.sh.
> The sleep was added to ensure that the listener process has
> enough time to start before the sender attempts to connect.
> - Rebased on net-next.
> 
> v1:
> 
> https://lore.kernel.org/netdev/20250129143601.16035-2-annaemesenyiri@gmail.com/

Unfortunately the added self-test does not run successfully in the CI:

https://netdev-3.bots.linux.dev/vmksft-net/results/987742/117-so-rcv-listener/stdout

Please have a look at:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

to test the change locally in a CI-like way.

Cheers,

Paolo


