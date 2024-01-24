Return-Path: <linux-kselftest+bounces-3483-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB10483B2A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 20:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF951F21F21
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D8C133423;
	Wed, 24 Jan 2024 19:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W+5AyxDN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02C133414
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 19:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126383; cv=none; b=ll8f87V+N0gXwksfpkAxaqh6LgzfnNwAMyqHIlMI8NZoiXL8u+hgqYa6pwll9pBc7jMVG3SPmz0oWdQjDgosWdMQKvSRyHHXLmLTN/MgcB1X91UV9s+C6i0yt2GyqJucvRj0wgC8U1ABP4BX6LStNQ50wxMqbjjZ0TEQ685JxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126383; c=relaxed/simple;
	bh=odGmuukyp0U9l8zW6CMAJDMbPK6fIBGHu3vXlhB3P3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nSGKZ+B1AlRxLcpia1KXPlXmy3D0sBm04TKKbUIYwfyCzHF1gpy9tEm78SCsqKDsL5L8yFpBcKjH+m7daUdcYkcwP4ZecYOrWL/84e/fH9EoOV3umqcFDSu7n+TnfhbsqUIhgLnZNCGC6uKdN0q1LnTAD++aDg0Q6mAtyz2V+9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=W+5AyxDN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40eac352733so40604005e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 11:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706126380; x=1706731180; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MZl4ftythRmcKvCOQh5pb6PiHGn+zNx3H9rMz7CH72o=;
        b=W+5AyxDNY+eIvQZlCcP7wXZCVFSCqq4YZaIBlA4p6hl+N9V5viTWpR+lUwff+yVMD5
         F2e9m22RVX8PRnJiTnaVIIOgSf0esYrDjrjBo5OGLY/g78YfiXLhqlsDo+0L3fweecOe
         7g6q4oPvQ3eWX+xCFHIToBG6CpzbG69lipvT8CcFZuFlM/jMrk5wDeRQbgKkVaJu3Eul
         J2WKVqxORI4RT9DkkLwCRRR/0FmWSjTuFWLyUVXyxe3VzwU+EXEzjxjQxuzUo4xgVxSL
         bWaJktZIlVV79v/hXEr+wqSn+NYi4not6C6ucAsn00S7DvQUc7NJ9CVAG1D7vI1gqmwJ
         5QMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126380; x=1706731180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MZl4ftythRmcKvCOQh5pb6PiHGn+zNx3H9rMz7CH72o=;
        b=FdNUGy8yiRjfKxHgNpkbnNXLtlhHyeWSyKyT+5OzklL+Q/NTRnZN/8LCiSQr5mRb0D
         lDANQIh9gHw5OICRscgqF2j5GsEQVAgePSZMUFnO+4YlldZVexPQpmuemoLes2tWMb5+
         VdcvxatrBNGuEjHYwfNo2UaWUEoDHaLwCA+gkvF+/sUO/kB0AqfISNpLvMw/eAoA4Owi
         n81Anhe9sUHcQlgsVR2LzdzX+Px+j+ae8H1GNWhgsmlgfGFC3a60riIB/8h4HKHFf+Zg
         D8niQtwVMzjiv8bxrY3D+VOLxKfuJ/b2FEC/au31J4+oci884fHml8avVu398FFWom3C
         xudA==
X-Gm-Message-State: AOJu0YwSsKCidYRYscmNdDBAI8cJJSpY9KE6S7maO7VnZjDON/qKS2FA
	p3c/8mit6OXWyOrNofgexNNvNgoVGQ4qob9YDn9RnwIboNqzRC6u8cB/5V4vxQ==
X-Google-Smtp-Source: AGHT+IFblEqtJKfuFSJ6K/tCJGIVNQ3uYWz2CRDr5fMA3jsSGReNr698pKiQM+BTV1fNHCydek0KDg==
X-Received: by 2002:a05:600c:314e:b0:40e:b93c:b5f8 with SMTP id h14-20020a05600c314e00b0040eb93cb5f8mr1423543wmo.107.1706126379803;
        Wed, 24 Jan 2024 11:59:39 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id bi17-20020a05600c3d9100b0040e418494absm99661wmb.46.2024.01.24.11.59.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:59:39 -0800 (PST)
Message-ID: <3fe0cb4a-9dbe-409a-b856-9b32824583fe@arista.com>
Date: Wed, 24 Jan 2024 19:59:32 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] selftests/net: A couple of typos fixes in
 key-management test
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Dmitry Safonov <0x7f454c46@gmail.com>,
 Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
 <20240118085129.6313054b@kernel.org>
 <358faa27-3ea3-4e63-a76f-7b5deeed756d@arista.com>
 <20240118091327.173f3cb0@kernel.org>
 <a9a5378d-c908-4a83-a63d-3e9928733a3d@arista.com>
 <20240124071229.6a7262cc@kernel.org>
 <1ad64e3d-5252-4aaf-82be-5162edd1e781@arista.com>
 <20240124110431.3c3eba9a@kernel.org>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240124110431.3c3eba9a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 19:04, Jakub Kicinski wrote:
> On Wed, 24 Jan 2024 17:46:10 +0000 Dmitry Safonov wrote:
>>>> Thanks!
>>>>
>>>> I'll send a patch for it in version 2 (as I anyway need to address
>>>> Simon's feedback).  
>>>
>>> Hi Dmitry!
>>>
>>> I put TCP_AO and VETH in the config and the tests seem to fail with  
>>
>> Thanks for wiring it up and for https://netdev.bots.linux.dev/status.html!
>>
>>> selftests: net/tcp_ao: rst_ipv4
>>> not ok 1 # error 834[lib/kconfig.c:143] Failed to initialize kconfig 2: No such file or directory
>>> # Planned tests != run tests (0 != 1)
>>> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:1  
>>
>> Hehe, yeah I wanted to detect kernels with !CONFIG_TCP_AO, to SKIP the
>> test, rather than FAIL it, which this lib/kconfig.c does.
>> But from a glance, I think it's failing in your run because there are
>> checks with and without TCP_AO, but I didn't think of checking for
>> the hashing algorithms support.
>>
>> I think what happens is has_tcp_ao():
>> : strcpy(tmp.alg_name, "hmac(sha1)");
>> ...
>> : if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0)
>>
>> Could you check that what I suppose is failing, is actually failing?
>> [dima@Mindolluin linux-master]$ grep -e '\<CONFIG_CRYPTO_SHA1\>' -e
>> '\<CONFIG_CRYPTO_HMAC\>' .config
>> CONFIG_CRYPTO_HMAC=y
>> CONFIG_CRYPTO_SHA1=y
> 
> FWIW the config used is uploaded with the results. If you click on 
> the remote it should take you to a location like this:
> 
> https://netdev-2.bots.linux.dev/vmksft-tcp-ao/results/435369/
> 
> and there should be a config file in there. 
> 
>> If that's the case, I'll  add the detection for hashing algorithms to
>> lib/kconfig.c (together with a patch for
>> tools/testing/selftests/net/config).
>> And also heads up for key-management.c - that tries a bunch of hashing
>> algorithms to check that the work and that the key rotation between
>> different algorithms works:
>>
>> : const char *test_algos[] = {
>> : 	"cmac(aes128)",
>> : 	"hmac(sha1)", "hmac(sha512)", "hmac(sha384)", "hmac(sha256)",
>> : 	"hmac(sha224)", "hmac(sha3-512)",
>> : 	/* only if !CONFIG_FIPS */
>> : #define TEST_NON_FIPS_ALGOS	2
>> : 	"hmac(rmd160)", "hmac(md5)"
>> : };
> 
> I was stuck in a meeting and I started playing around with the options 
> for TCP-AO :)

Haha, the same: 3 hour-long meetings for today :-/

> I added these options now:
> 
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_SHA1=y
> CONFIG_CRYPTO_RMD160=y
> CONFIG_IPV6=y
> CONFIG_TCP_AO=y
> CONFIG_TCP_MD5SIG=y
> CONFIG_VETH=m
> 
> And it looks much better! There are still some failures:
> 
> https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-01-24--18-00&executor=vmksft-tcp-ao

Wow! Nice, thank you!

> 
> I added VRF so that should hopefully take care of the MD5 skips
> on the next run. But the failures of the rst-ip* tests don't look 
> like an obvious config problem.

Yep, I'll look into this this week.

Thanks,
            Dmitry


