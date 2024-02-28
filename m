Return-Path: <linux-kselftest+bounces-5539-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C886B370
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 16:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F3E7B23382
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Feb 2024 15:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4361815D5A4;
	Wed, 28 Feb 2024 15:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NCC5zxGP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45083152E14;
	Wed, 28 Feb 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134849; cv=none; b=HGQeHUTE1Pgl5Eb7MT0cDFEOuiykMy/d+qQBODMUxzaLFn+X45qP18/TOiIO4sYfzWpcxyEurIq4Eq7qHBy80jZppI5icONSjCMInCrPT6f0Dktyo9Zt4k566MPl3D9lvtE6sHEGyp78TdGgsKKLoL5n5I3NNaTAhl4yn+Dxoec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134849; c=relaxed/simple;
	bh=2IYPJcQeiiqLb8GQ5Y15ULpr+TeJHmKTDRpQbYJcgZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hY1PV9cJtpsY40M/gEjLFKQNFVhPlJ2vUTlpsFIkLHP4w4urQz5xdbtuoiIPoLNDj/m8r2SKuqA87bC52FYDTDzZblKGBY9PYqgOzp7D5pSA5UDkJtVp6s+pJxdE+/rhHLzSpI/xJV9FAeLfAzDzDtSrr8u7YXb+4ZvT3rp1MPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NCC5zxGP; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c78573f31aso263616539f.3;
        Wed, 28 Feb 2024 07:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709134846; x=1709739646; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq4bTZFqY8eleGsJN4GFni/OSPgsFi5dlmOPB1MRAMY=;
        b=NCC5zxGPKCcBpwfiFqZNazmo8Kuuca+9pKj0nEKo7NNtExT6Z6tj6Po0HsyaE2Rut+
         R20mSjTf+AV7h5o8cYSfIFm45+yGX68u/JiB+FuBD7B0BMscQupXk8AsFpW8oy3mslwQ
         DGm8JeXnCuhrPDVWKDB9217I270rr1OfJh/eCBfASUdA/Qj0tKYb2Imf1/r04sUnaAn0
         iqR3yWsMhNf90qSF2YlxIXnkNgg1aN/62/gueQTyftJVqjVdozaa7Ww0YJFal1jOEmxe
         7hKS7f2iy/WK4dk6aviqqtLhZwBtFKhV6ZDHuQz5m8DPQ7jIWfLLRBoxORVddJKOXYEt
         R75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134846; x=1709739646;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zq4bTZFqY8eleGsJN4GFni/OSPgsFi5dlmOPB1MRAMY=;
        b=C8ofN/dWSJjBbSIRG2MfMHkBoR2MA7RrTZE5tEBy6ZVmY5Y+mjUsWRb+XW/fLcbekw
         yXfgpSAdClxmvdWQVL/6oupxJAHnlmra3AZyjt86fe4BEHYcNln6kwG0CQB7+pzT+QvC
         S8dpz0fDSMOGkUnL8n0EJnATZeCiA5x2ShDTcNCuFtDxl/SrfngMEc3eaRAoB8SlJhiK
         c9b1jtP3rLHg3rOrlY53Mr71tEoNe/lLIm3rnFd5TIF6nPg+cnKF72LlpQkHVBGoCc2l
         hA1vKn/dJG5gHqcvsng59qxZUZ+xRy7GsrjsFKyxex48K+gEIBPnJK80mjSNlAlt6bmB
         A3Zw==
X-Forwarded-Encrypted: i=1; AJvYcCUV48K/YIDVRntMuOZjMqz7WXKK7JXOnow3okAXYqkb/GrghTxhbDNllJACL+0dGzJU7ZpL6nOksGhYXmJnRY1iQbSYqKueLIIPg5PBnYwMgsYVqtH6w0VpbFc5cCgPQEkZRAtBPiRV4v83eFi1Oj+XBvkKVKxpBzMDWS7ca3d+IVzpL0DjSKXsMBIS
X-Gm-Message-State: AOJu0Yxt6GAvWR21dkXPlrPb/zyX84K0UwVnqFaW2L1/gyU8kPwrzas4
	O2o0UMzQK2BvKU+Pnmi59tUVn/nSDAQepRCqLtf42PvIZO4JKLr+
X-Google-Smtp-Source: AGHT+IFvWKJD0KAXhUqDALxP1/GQroxKNWcCYaVu9B8M4z95YMsdiyrvAAwIdZj59E7ayUrlfa5H1Q==
X-Received: by 2002:a92:d80f:0:b0:365:29e4:d963 with SMTP id y15-20020a92d80f000000b0036529e4d963mr12080575ilm.30.1709134846407;
        Wed, 28 Feb 2024 07:40:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cv3-20020a056e023b8300b00365ab9e9799sm999015ilb.79.2024.02.28.07.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 07:40:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e9112858-76b8-4b91-88b1-b5694cda3350@roeck-us.net>
Date: Wed, 28 Feb 2024 07:40:43 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Charlie Jenkins <charlie@rivosinc.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 David Laight <David.Laight@aculab.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Parisc List <linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Palmer Dabbelt <palmer@rivosinc.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 KUnit Development <kunit-dev@googlegroups.com>
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
 <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
 <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/24 02:15, Geert Uytterhoeven wrote:
> CC testing
> 
> On Wed, Feb 28, 2024 at 8:59 AM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 2/27/24 23:25, Christophe Leroy wrote:
>> [ ... ]
>>>>
>>>> This test case is supposed to be as true to the "general case" as
>>>> possible, so I have aligned the data along 14 + NET_IP_ALIGN. On ARM
>>>> this will be a 16-byte boundary since NET_IP_ALIGN is 2. A driver that
>>>> does not follow this may not be appropriately tested by this test case,
>>>> but anyone is welcome to submit additional test cases that address this
>>>> additional alignment concern.
>>>
>>> But then this test case is becoming less and less true to the "general
>>> case" with this patch, whereas your initial implementation was almost
>>> perfect as it was covering most cases, a lot more than what we get with
>>> that patch applied.
>>>
>> NP with me if that is where people want to go. I'll simply disable checksum
>> tests on all architectures which don't support unaligned accesses (so far
>> it looks like that is only arm with thumb instructions, and possibly nios2).
>> I personally find that less desirable and would have preferred a second
>> configurable set of tests for unaligned accesses, but I have no problem
>> with it.
> 
> IMHO the tests should validate the expected functionality.  If a test
> fails, either functionality is missing or behaves wrong, or the test
> is wrong.
> 
> What is the point of writing tests for a core functionality like network
> checksumming that do not match the expected functionality?
> 

Tough one. I can't enable CONFIG_NET_TEST on nios2, parisc, and arm with THUMB
enabled due to crashes or hangs in gso tests. I accept that. Downside is that I
have to disable CONFIG_NET_TEST on those architectures/platforms entirely,
meaning a whole class of tests are missing for those architectures. I would
prefer to have a configuration option such as CONFIG_NET_GSO_TEST to let me
disable the problematic tests for the affected platforms so I can run all
the other network unit tests. Yes, obviously something is wrong either with
the affected tests or with the implementation of the tested functionality
on the affected systems, but that could be handled separately if a separate
configuration option existed, and new regressions in other tests on the affected
architectures could be identified as they happen.

This case is similar. I'd prefer to have a separate configuration option,
say, CONFIG_CHECKSUM_MISALIGNED_KUNIT, which I can disable to be able to
run the common checksum tests on platforms / architectures which don't
support unaligned accesses.

However, as I said, if the community wants to take a harsh stance, I have no
problem with just disabling groups of tests entirely on platforms which have
a problem with part of it.

Guenter


