Return-Path: <linux-kselftest+bounces-32272-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAB6AA7E7F
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 06:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 811785A5002
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 May 2025 04:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA2C818FC84;
	Sat,  3 May 2025 04:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="cJ2OMijK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B1F190679
	for <linux-kselftest@vger.kernel.org>; Sat,  3 May 2025 04:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746247789; cv=none; b=Vjd7S1l+Eic+nEDgNjPjVpgqNxcRLw9y/f1EW9cYowuAV4uEIZuKuqRuKs+rtpgimYQnxmhiB8UBBf/phzFJzAKJ8b3OXduRyiaZ3zvBucMSlp8r1o/0FIkCk24sMB3tEokpegVqU4G+x6hmn6Wql5kYfp4kUqiKGSMFqkh5NxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746247789; c=relaxed/simple;
	bh=qINhvPGtkjwbD1XO9IedTb3hhyXkB8xiUTTzbJgKbAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSxNrbuWVLYVv164oD/0ZiZWJenrnKb88YY4D1JA68SzUbImwuXTEwo3v00CVOI+yfjgJLXNv3THJ0RCaveP9b1dNlk3radSJbb2AHwOpUsaSp+Z9P762JTnmyTMZPGZ4JCCeV9BpAmq4slsL1OWKGSiWqaQhHdUkqO6Kyht7fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=cJ2OMijK; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30155bbbed9so2369644a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 02 May 2025 21:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746247787; x=1746852587; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wl5agjkb1P+kav+Vmwr0UdlPpR+PcrKakR6MDznA3nI=;
        b=cJ2OMijKZalh4jMw2mGKEmftxTmfLHmcD3nFsksSSm4hIovdGe8+bRd1QLO3DUWANv
         lyIG8gQNvOCkGDepWjPgfeRfaXNL+sRqGCjDx5kaR2LYw8qAselkiB0iYrhfZ4HURX2x
         bqSZ2oitFUKhlJcOQVxczwijbz16f6IcwqQjpzNpqqzl6CC4+WkZblrFrWosEaXov4kr
         B+6ytvvbNqikOlSLiDE8cspEWYNNu+twH3oclZkoqhQdHBD7on64w+8PWXgvttHsSDfp
         AfkZ4BN1B169UQQKQqNROpxq/tS7Nkf1WlnDKxpabOSl2NXhM0c/85NPBjb8UW477Gnx
         V4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746247787; x=1746852587;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wl5agjkb1P+kav+Vmwr0UdlPpR+PcrKakR6MDznA3nI=;
        b=MJUf7YCOSCqUNY1lkGuxqEeZguYe17VnJU0QrtvvXy4qrCI67Fx/lgv2EY4cOKeBqU
         WnUvO1ZYwT6rqyr9EWRN9NtDaRII+Q5PowQB2Xq37J1A4GmO49gDys+L+zUAhhi7oThY
         RrHhVJuzhHBGSRR5auuEjRHM32kEn8hk3TaeaSgEiph328KVEQkWkpwBSjmOvJ2frbDY
         GCXx9z0pUhp/sYJwzXlFN4sxWhEig71BHCNPQOrc6b7qSqPGdvOvTbxDVlYQUqcnmrdo
         heSuJQFpymsOyU8AqYM+AriIh0s8mNSLDDM+1ifVlxszd9eUvnOMG9AnZ+lFABfWFoS3
         AQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIwIx4nFWM/M/UQqf8ZAs8teLbA/ztnraWlYd1QDaAixVVlrfJQHxWgvNlB83lP2mIVOdS17G75B5DVjKvf80=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFccVEeliYECoh3syv0w/LyJl/085Or0SK2payQSamBt1KjVcN
	lsljtODv8DRDJCDtIhg6xbgO9bE6ijFYf82/KJjb6ioqOrARbUwVB4AZHo1gehE=
X-Gm-Gg: ASbGncvQUzl4vrcTQMd7eMMTlo5k+a+ES4iie8OioUwn9GgcWwsHK75L2LuX6J6hlZz
	x08PTixNXGwOpZiyq/MmL4D5ae7N+zq+Fqnlbop9rg6q8jCEorEjhZ/Ob7I8C7kVRmfjoviS4JF
	fyKyxXJ1bHtYGlntx2NPI26cBDdUh8/82yRNOYA90XhYangb6bUeBNThiElE/DJyNuevdAsMeD3
	IqLAzfKCphzRNcowTzu581bl4/rqVoxXD93BJWTMCjIjLXKJ23oODYTOOE86Lr5JmyLwLIwJZDu
	gA6F6/t0vvZnLZKTxTwOVLU9hSRzkzGFeo2AYpl/U+nm/pg=
X-Google-Smtp-Source: AGHT+IEIzIAeqtdis6UacAFn64Fv8eM8Hzn7Knzhq5lJqvY9BqLX+h7uHFxCni/M+uWzqyRsBEN3Sg==
X-Received: by 2002:a17:90a:c88f:b0:2fa:228d:5af2 with SMTP id 98e67ed59e1d1-30a4e5c1f10mr8128638a91.15.1746247787424;
        Fri, 02 May 2025 21:49:47 -0700 (PDT)
Received: from [192.168.1.21] ([97.126.136.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a4b21514fsm3802943a91.14.2025.05.02.21.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 21:49:47 -0700 (PDT)
Message-ID: <9f944c15-5f61-403f-95cd-540fa9c0b783@davidwei.uk>
Date: Fri, 2 May 2025 21:49:46 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] selftests: drv: net: fix test failure on ipv6 sys
To: Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 ap420073@gmail.com, linux-kselftest@vger.kernel.org
References: <20250503013518.1722913-1-mohsin.bashr@gmail.com>
 <20250503013518.1722913-2-mohsin.bashr@gmail.com>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20250503013518.1722913-2-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 18:35, Mohsin Bashir wrote:
> The `get_interface_info` call has ip version hard-coded which leads to
> failures on an IPV6 system. The NetDrvEnv class already gathers
> information about remote interface, so instead of fixing the local
> implementation switch to using cfg.remote_ifname.
> 
> Before:
> ./drivers/net/ping.py
> Traceback (most recent call last):
>    File "/new_tests/./drivers/net/ping.py", line 217, in <module>
>      main()
>    File "/new_tests/./drivers/net/ping.py", line 204, in main
>      get_interface_info(cfg)
>    File "/new_tests/./drivers/net/ping.py", line 128, in get_interface_info
>      raise KsftFailEx('Can not get remote interface')
> net.lib.py.ksft.KsftFailEx: Can not get remote interface
> 
> After:
> ./drivers/net/ping.py
> TAP version 13
> 1..6
> ok 1 ping.test_default # SKIP Test requires IPv4 connectivity
> ok 2 ping.test_xdp_generic_sb # SKIP Test requires IPv4 connectivity
> ok 3 ping.test_xdp_generic_mb # SKIP Test requires IPv4 connectivity
> ok 4 ping.test_xdp_native_sb # SKIP Test requires IPv4 connectivity
> ok 5 ping.test_xdp_native_mb # SKIP Test requires IPv4 connectivity
> ok 6 ping.test_xdp_offload # SKIP device does not support offloaded XDP
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:6 error:0
> 
> Fixes: 75cc19c8ff89 ("selftests: drv-net: add xdp cases for ping.py")
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>

Unrelated to this patch, but there is an ip() helper already. Can it be
used instead of cmd() with shell=True?

Reviewed-by: David Wei <dw@davidwei.uk>

