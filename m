Return-Path: <linux-kselftest+bounces-26553-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AC1A341DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 15:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD145162C5D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Feb 2025 14:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D6281363;
	Thu, 13 Feb 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NWbFa13t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD43D281343;
	Thu, 13 Feb 2025 14:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456780; cv=none; b=LkiBwk0kvQ/zCJqQKLUoF7rwFbwH/6eTialtmxvFNENpZajVr5uDimKVfpLKfe6k3DkZglHFqK25o2QupoWgNExU3cMUkKyv+LqZ7qda4iQ8ge7JKFWu1cN7DmafDelwodOrqM9dyeewIb2LDkqQmOH2h5ZYRYPDgv+ltaQJqpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456780; c=relaxed/simple;
	bh=bsl36szvy9nKL3yIEKuviz5lJs1Th85tPgkSBBzwg4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLVf6hMfW/hUns8/dHLXMxpfaD4wGQOxj1rtfQPdh7Hj0CsQkWoj5L659NaxmT2JghnofYbOF3O4fa7eJ93T2KS0sM4N+mWxsRDABLRDfVdDb4Brsojbeff+LVbfScIR3kNBF3KCTmlgNxrNW91KyHYQFED0xIvS6vw2IQDu3NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NWbFa13t; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7c056512facso12372385a.2;
        Thu, 13 Feb 2025 06:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739456776; x=1740061576; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yV3OUmxBEMt+DI9TBgHjK6W2vVBWBY0CKoBLi+dPpw=;
        b=NWbFa13tWPkZOdvDUUzSC5Zi7J4z9UEfBkaNU2OzTJmy3t+z0no91v6XG1pfkuJwy7
         TzF5VXFwXH19JsLODvPIAeE8Bsop8/dwI4KMlk/9gcXaoog8hd1/zjC+eN542h+etijq
         JtstOxlXthB73TYh58wqUPRUoDla0P3SsOPuvAhW4iS1lvCaw+RtPX3RAeYDrsFbCiEH
         60M3vzq97cVW6H4enHbr6rV6pQjm8cl/LReg/aJ/uQNDieYxJJUkdU7tDfoHsjv6vvuu
         Ft83/XN/QVArTZsyv45Ress5RH9b8cFrY9/Dlajv6yZ/l5ew6b2K4HERVPiYY252bXCs
         3K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456776; x=1740061576;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yV3OUmxBEMt+DI9TBgHjK6W2vVBWBY0CKoBLi+dPpw=;
        b=gv4GGCX25wVT/0BFKi7b1z6szN1W5iR0rtuUCSTBMru5nB22RmErutk8J3Sn51J/Bk
         nMFXtP2dxrrA7dZ8RfFotVEw6LZ5UEdPNut4qiipES2P/60ibzIf8OaZQhasCyt925QG
         SPY3+liENpcfq6J7Re2SWG2gcYT7y/jwXzDpUCpNTEHOg9KGyKoRFbt8TsHKhchNhTsf
         XmPn7KK/mB0IjX1Ir5hySGYRd/0IUQcCHP3xpWnU84fI1cj8X13obLX1zWRzvPsgp/R0
         jRmcZeRogmbRkGVGY4dY5OPrLVUZNPM0S9iWMeIQlvcsGQZQTi9EadZBxu0eiynH+wu2
         Aw5w==
X-Forwarded-Encrypted: i=1; AJvYcCU7tWVbrvJYpI+v7rj5fqtq7BW9kT+MgdLll+g6i7B/XzrtEgxZKFlAx7O5xYnvkUwo9FNqXpQIExKffoE/NNBn@vger.kernel.org, AJvYcCUNg0rDY5VMvkYHNx/S/FworKHqzDcub7Irt6k4D7uY8QawWKXICY7a8IKRZMbFIndxrHf67SorIjkDW9s=@vger.kernel.org, AJvYcCXMh2FaaDKnuLkGlf0UsRKUJADmx7aW0yWPPjY5zjwgTYKvvNB86v6/Dy/TT/8Vt5NjSks5pEE4@vger.kernel.org
X-Gm-Message-State: AOJu0Yzri1d6n0+hsRrVR2izv7nACxsCabxzgn6xhLg6fITQkItCVWYu
	/8CDcdjvJyQRMm4nbJ6jhuwWYdHS6hmt2rgt0VPjDG6eXG0i5j1x
X-Gm-Gg: ASbGncuf7lNtZBXXyDq7FV/khlIGh4+vcRA+WNg70x7XN8dWiR/yXjoyo6a/aipB6Mu
	kFJicLM/cY3B3T556Zpq7MRELV1ZlIlX4q9x904Qa3FeSI2LZcxyzzpxSEOeaFf+0bQcln4x4N6
	8I8pbX4SzVE8yaP3tMOfmshE4CzwaZwu/b+L5Op5U1E5PHUZerIngsOnu0LCT8IFonaJfuxXqgD
	YVNyA++PFqvFXxX5gS1Dkulc6BSULzvsqQ1EI4plWDYe+vKAbVo3k/08WwkHSyFGJqGhLUSr6rQ
	hVzsVG6/2ypa5DafWO/L85l9WJ5kkpS4JUqQGXWkX+muEZD2rsSN3mZO+XTEHMReKRs=
X-Google-Smtp-Source: AGHT+IE6DYJdHVlRXn35uoxkVbWsFnt3UaddizuTuydiIll1KUpO1LGzexLI9ylAX1yTeI/rRXD55g==
X-Received: by 2002:a05:620a:1a83:b0:7c0:7aff:f0b3 with SMTP id af79cd13be357-7c07afff237mr175231285a.14.1739456776423;
        Thu, 13 Feb 2025 06:26:16 -0800 (PST)
Received: from [192.168.1.201] (pool-108-28-192-105.washdc.fios.verizon.net. [108.28.192.105])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c07c5f3a4dsm94830685a.2.2025.02.13.06.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 06:26:16 -0800 (PST)
Message-ID: <2dc054c7-c596-b283-b26a-86c52e48efe0@gmail.com>
Date: Thu, 13 Feb 2025 09:26:14 -0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH net-next v19 00/26] Introducing OpenVPN Data Channel
 Offload
Content-Language: en-US
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 steffen.klassert@secunet.com, antony.antony@secunet.com,
 willemdebruijn.kernel@gmail.com, David Ahern <dsahern@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250211-b4-ovpn-v19-0-86d5daf2a47a@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antonio,

On 2/10/25 19:39, Antonio Quartulli wrote:
> NOTE: TCP tests are still showing the following warning while running
> iperf.
> I have analysed the report several times, but it definitely looks like
> a false positive to me, so nothing to worry about.
> 
> Basically the lockdep engine gets confused thinking that we are
> acquiring the lock twice on the same sock, but actually:
> 1) the kernel is first locking the 'iperf' (user) TCP socket;
> 2) ovpn is later locking the underlying TCP trasport socket.
> 
> So there is NO risk of deadlock (and indeed nothing hangs), but I
> couldn't find a way to make the warning go away.

I think you can use a "nested" lock to avoid this. See e.g. commit
86a41ea9fd79 ("l2tp: fix lockdep splat") for an example.

--Sean

[1] https://www.kernel.org/doc/html/latest/locking/lockdep-design.html#exception-nested-data-dependencies-leading-to-nested-locking

