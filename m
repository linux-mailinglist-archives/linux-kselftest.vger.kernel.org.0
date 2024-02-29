Return-Path: <linux-kselftest+bounces-5670-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2079786D449
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 21:34:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C841D289F5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE101428EA;
	Thu, 29 Feb 2024 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwJQeXTg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925321428E9;
	Thu, 29 Feb 2024 20:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238866; cv=none; b=i9b7zWHolHnJKw+K0LPCPIiL/55BQh2SFadqGmHtXoiD70L8rv4Eleqt3elyAb/hj3W2TPY1S0hvIuC44ytgck7Tm/H+jAFhHJiCqK5HNbAZBzMaxkASzYbC5XbVtAKV26NG10qwDGk1d/M/7UiAJ++LiFFJjx1vDalB1mNJQ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238866; c=relaxed/simple;
	bh=/qMOZjK4wOU66llXQWpikqHl04X9ZcNrBvWKO/NBqYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krO0HSXrsTHccqADX407yIVaXwnkE/bCL7D5yWSZFx49+ayKe6pMnosXs0N0PPDcMPilsVyJ3NdjkI+T8xMZ+r+299OjGkQ5uP40NDFU92xue2Tf9NdJb4h7IQyFebkg/6LslG3WH5GvxJqTALr0eLpJs8KIytCSVmx9FCOrWgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwJQeXTg; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7beda6a274bso56162039f.2;
        Thu, 29 Feb 2024 12:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709238863; x=1709843663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uWyCbx/KnUHajBSclYbeo2RRj4QEB1MMvqG8/oUha1A=;
        b=fwJQeXTg/ThrAr1XoDCl0JKncohRKtEBiy6fEngFlueulvd4bBTSudnOnziiifLcpe
         L18k8f3kfpUWapD8Z/Grd+beC8H+fnTAySeZQMbIs7NPQqV43eXVBFeGn3e1JKHdZx+B
         YdB/VMT/asvQUCi42wwrS22okJ3PxQBiDDRK3wJ+pBVd0qnojQ8ciDHycKY4yBL0b5te
         fOVLG7v2Xwy3ZIRmKG2PQhLmjA9fEZHcE1ndEhvEg7AA53eUdebaoEA5bgedZ/SbBbVy
         45q5+oJfr1cwbuOhgZroEv3hCOkGREvBY7GJjh27yj4oocANev6fP+YoK3aFHumz0KIQ
         i1SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238863; x=1709843663;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWyCbx/KnUHajBSclYbeo2RRj4QEB1MMvqG8/oUha1A=;
        b=ZGpICdHLb83nG2g0/MRz658nzZBqFxm2y2kbWk4Qz1+rNCNq9gPtReEOsthu0HQCj/
         SuQokAe1kvLcETJXtUOhpxSVqgJMl9IZ0z73CNJqm2OnbG/IkEzCdpflDZ9vYJQ7RKv0
         Qfs3qHutKeXRZMc8wXRYSboQF+/7Rw2ubgtYqARCz2DjDPlS62874MW5/jhyOvnx7vTg
         yukRJ7UUy2v+nr0F4K0P+RyghduhjVJTFa21NBNTqZkUhPmOozcp+CQOcEbWLDtBqjgw
         oCobcI/Qqwi3KsKsjv+FRkcog+sdyEIOuAyiVVbydW9KvFn2D7LO+9mVb10Au0J+625F
         iJAA==
X-Forwarded-Encrypted: i=1; AJvYcCUPNanlLunQ0cQs9AwYANwsqGQf7D7MOPM4/rxsJ9UFINGdY8S84oyQx8coimDbM9SbAeAhRRwhS0nevaZNLtjN+RzXq0k8wOe87gGdMj97Pc+UvKZBGiYoxmD7ekdHtli/7QrrEFm46UPKZI/s2PSaQE/kGFqqS5Uuu0Hghzl6SI5eJAIB
X-Gm-Message-State: AOJu0YyFClFbC656RUYW9ZcazTrCaHNtQpBFpwq0ol52mmYVEs3k5Ujx
	/CeoSDsAQx3H1kZiwtIIX0ZCLpxj8f06lygtu3nYQ4JlqUzx7k7y
X-Google-Smtp-Source: AGHT+IEiAApsVihXRSxIc8hc0cSvprBrtWT8BW9l2wSnEkIraPiFiEUorC/zL7B+dTpU6MDQy1A/xw==
X-Received: by 2002:a05:6602:3fc5:b0:7c7:f06c:eeff with SMTP id fc5-20020a0566023fc500b007c7f06ceeffmr81949iob.16.1709238862775;
        Thu, 29 Feb 2024 12:34:22 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bp11-20020a056638440b00b004744c109a60sm463991jab.122.2024.02.29.12.34.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:34:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <228845bb-1a90-42eb-b2d7-47007734535e@roeck-us.net>
Date: Thu, 29 Feb 2024 12:34:20 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lock warnings in dev_addr_lists test
Content-Language: en-US
To: David Gow <davidgow@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendanhiggins@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <48c4d3db-66d5-4a9a-ab9e-9036db7222dc@roeck-us.net>
 <CABVgOSnpOzOr3VuKZc3okhJqf1yvsEe56YPdWn15Ag_RDEZi8Q@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CABVgOSnpOzOr3VuKZc3okhJqf1yvsEe56YPdWn15Ag_RDEZi8Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 00:10, David Gow wrote:
> On Thu, 29 Feb 2024 at 03:45, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> when running the dev_addr_lists unit test with lock debugging enabled,
>> I always get the following lockdep warning.
>>
>> [    7.031327] ====================================
>> [    7.031393] WARNING: kunit_try_catch/1886 still has locks held!
>> [    7.031478] 6.8.0-rc6-00053-g0fec7343edb5-dirty #1 Tainted: G        W        N
>> [    7.031728] ------------------------------------
>> [    7.031816] 1 lock held by kunit_try_catch/1886:
>> [    7.031896]  #0: ffffffff8ed35008 (rtnl_mutex){+.+.}-{3:3}, at: dev_addr_test_init+0x6a/0x100
>>
>> Instrumentation shows that dev_addr_test_exit() is called, but only
>> after the warning fires.
>>
>> Is this a problem with kunit tests or a problem with this specific test ?
> 
> A bit of both, I think. KUnit test cleanup is not guaranteed to run in
> the same thread as the test, so that definitely is triggering lockdep
> warnings.
> 
> On the other hand, we really should make this particular case work in
> KUnit. Ideally test cleanup will happen on the test thread first, and
> only fall back to another test if the test thread otherwise aborted.
> 
> So, this is probably something we won't be able to fix if the test
> fails, but it definitely shouldn't be happening here where it passes.
> I'll look into fixing that.
> 

Other tests seem to have similar problems with locking:

[   25.762445]         # Subtest: drm_vc4_test_pv_muxing
[   25.845857] [drm] Initialized vc4 0.0.0 20140616 for drm_vc4_test_pv_muxing.drm-kunit-mock-device on minor 0
[   25.859603]
[   25.859867] ====================================
[   25.860085] WARNING: kunit_try_catch/1729 still has locks held!
[   25.860354] 6.8.0-rc6-00066-g1c8c39f56e47-dirty #1 Tainted: G        W        N
[   25.860675] ------------------------------------
[   25.860918] 2 locks held by kunit_try_catch/1729:
[   25.865468]  #0: ffff17e04945d850 (crtc_ww_class_acquire){+.+.}-{0:0}, at: drm_kunit_helper_acquire_ctx_alloc+0x44/0xd4
[   25.866383]  #1: ffff17e047042518 (crtc_ww_class_mutex){+.+.}-{3:3}, at: modeset_lock.part.0+0x134/0x1d0

Guenter


