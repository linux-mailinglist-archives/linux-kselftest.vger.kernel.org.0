Return-Path: <linux-kselftest+bounces-3467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C08A83B104
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 19:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8939FB2256D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jan 2024 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D30585C6C;
	Wed, 24 Jan 2024 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kWaJ5OPD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838981AA5
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706118381; cv=none; b=oLIZC5/+zMjQfcSeaczkTqT23U2iQ7lXRvoF5XRJhtQxejA+9E/NuGscJqP++VIu2aDe709Ig6amx4VqOCOCkw056p2zK3zrpxPvuXzXDz3EOxMWzDY3L42OMPd3IUGFLwqn55zU0SentOCI3S7MgVBKB+HgMPHPekXSj0tWmzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706118381; c=relaxed/simple;
	bh=rx8lKKZcE3A1/FLTzYEVMlsLvAtjy/Y784aKerx64Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2Af3gMYe8+kOzL6BlkUx9AIIW36mmkhEngIiqVp3vxuIoheWYPoVQq5yVRd9QZhy/1ETAYZmFtm1uKlOkp+xmwhCuF3+qffsF6H4vUNxLTF3D8Oof5EtMOUjSs8ObPZy+jHSzkZc64NcLjZGHHqPdQ4LBaQK4dCHurafN94Ra8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=kWaJ5OPD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40ebf373130so20699165e9.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jan 2024 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706118377; x=1706723177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVCU/WWHCSDI7BYE4p1QCv3tn8rHzFU9AC6i2z5h3qE=;
        b=kWaJ5OPD8SWrPQNFWepde48nJ3rr7QNB5TTRhyPau0Hzz3/iFmfcn/mMWPVy3JYDuh
         iD4mCt7zW3M0UUHhr7sbRct9Aekarntzc/UlEMInZtHgjzDFgf0diskPME6cctQasXx/
         6uBZ2JQVnXqqTurTCZuJzDM7HIbkzfnZ5YlyF+McBEWroB7biM2kGvHsDRleO1wqVksJ
         kS0B/jzLusmgcckI258iJU4zv2OA9AVrTVFap/AkaSORK6ORhWWXS0QwwvNbJcnlS0jd
         9oGnpqK2Ab9/vgveCStQia7rNnorHnGfFZej9cAPccihoG62wgkbA3bQLIFGKmw+lY0a
         j5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706118377; x=1706723177;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVCU/WWHCSDI7BYE4p1QCv3tn8rHzFU9AC6i2z5h3qE=;
        b=uGiYmwab6L7hAy2CrE9fc8Zom4V5JXJ+6BzyU5HM/s1TG/O13iC3q+v1V7H6Hyi/nD
         KhJMF9KnuQhMsnsGpZJObZSXK72AxAdeW31oKbGZJlft6nXF55dhR0ugbPrCac2tC6YL
         rxiCxZTENVH1rkF5y4dCMavbyhctScLhhgGhDt3WjSMCZC+2cYNCU9OfQV1pkQNPIPds
         0tPKnQ+HN5Q3izgfk+lw0GqvPubr/aEZA5FMjtkCcG3ifXDE293iBWioVQJg/mf4eEPU
         qmPU/nwKheCnAC2rS0lKaLxIXKrsBWDdv1DTJm70+JEDJjA5ceOJwJexmyZWcKi+pmHJ
         GVQw==
X-Gm-Message-State: AOJu0Yx9yJY+o3YjyOYpOkoa53U+XpWD+YOZLpphR3Y8GlNFpHDdkH/+
	rAIYZhivoVqTnqUdSBaH2nEnXBQp7yr0c0pI8P8ZLaUWrxa3k96X5rGuIH8B0a2DEgFG1EQy2AM
	=
X-Google-Smtp-Source: AGHT+IEkmMRSyW5Nf156YVrdFBl3DnSZXbv256Xf9R4g4JKrV5a1JNhJ61YPNG9vJ0fA/sMCWjitww==
X-Received: by 2002:a05:600c:4e49:b0:40e:c59d:95ef with SMTP id e9-20020a05600c4e4900b0040ec59d95efmr833207wmq.149.1706118377430;
        Wed, 24 Jan 2024 09:46:17 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040e6b0a1bc1sm356339wmb.12.2024.01.24.09.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 09:46:16 -0800 (PST)
Message-ID: <1ad64e3d-5252-4aaf-82be-5162edd1e781@arista.com>
Date: Wed, 24 Jan 2024 17:46:10 +0000
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
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240124071229.6a7262cc@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 1/24/24 15:12, Jakub Kicinski wrote:
> On Fri, 19 Jan 2024 18:39:14 +0000 Dmitry Safonov wrote:
>>> You probably want something smaller to be honest.
>>> tools/testing/selftests/net/config has a lot of stuff in it 
>>> and it's actually missing a lot more. I'm working thru adding
>>> the missing options to tools/testing/selftests/net/config 
>>> right now so far I got:  
>>
>> Thanks!
>>
>> I'll send a patch for it in version 2 (as I anyway need to address
>> Simon's feedback).
> 
> Hi Dmitry!
> 
> I put TCP_AO and VETH in the config and the tests seem to fail with

Thanks for wiring it up and for https://netdev.bots.linux.dev/status.html!

> selftests: net/tcp_ao: rst_ipv4
> not ok 1 # error 834[lib/kconfig.c:143] Failed to initialize kconfig 2: No such file or directory
> # Planned tests != run tests (0 != 1)
> # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:0 error:1

Hehe, yeah I wanted to detect kernels with !CONFIG_TCP_AO, to SKIP the
test, rather than FAIL it, which this lib/kconfig.c does.
But from a glance, I think it's failing in your run because there are
checks with and without TCP_AO, but I didn't think of checking for
the hashing algorithms support.

I think what happens is has_tcp_ao():
: strcpy(tmp.alg_name, "hmac(sha1)");
...
: if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0)

Could you check that what I suppose is failing, is actually failing?
[dima@Mindolluin linux-master]$ grep -e '\<CONFIG_CRYPTO_SHA1\>' -e
'\<CONFIG_CRYPTO_HMAC\>' .config
CONFIG_CRYPTO_HMAC=y
CONFIG_CRYPTO_SHA1=y

If that's the case, I'll  add the detection for hashing algorithms to
lib/kconfig.c (together with a patch for
tools/testing/selftests/net/config).
And also heads up for key-management.c - that tries a bunch of hashing
algorithms to check that the work and that the key rotation between
different algorithms works:

: const char *test_algos[] = {
: 	"cmac(aes128)",
: 	"hmac(sha1)", "hmac(sha512)", "hmac(sha384)", "hmac(sha256)",
: 	"hmac(sha224)", "hmac(sha3-512)",
: 	/* only if !CONFIG_FIPS */
: #define TEST_NON_FIPS_ALGOS	2
: 	"hmac(rmd160)", "hmac(md5)"
: };


> The script does:
> 
> target=net/tcp_ao
> make mrproper
> 
> vng -v -b -f tools/testing/selftests/$target
> # build the scripts
> make headers
> make -C tools/testing/selftests/$target
> 
> vng -v -r arch/x86/boot/bzImage --user root
> # inside the VM
> make -C tools/testing/selftests TARGETS=$target run_tests

Thanks,
            Dmitry


