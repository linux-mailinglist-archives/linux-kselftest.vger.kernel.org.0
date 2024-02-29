Return-Path: <linux-kselftest+bounces-5667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D02786D419
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 21:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEAB1C20D60
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 20:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAC513F42C;
	Thu, 29 Feb 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxHDIHcl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9BE2E410;
	Thu, 29 Feb 2024 20:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238154; cv=none; b=mRkEYglSUPqrs74IvIsPi+Sx+qia0gf/6S7fm6vgholFV7IBcIqmjeBJjct3abHdtKXdKucnEsURwrJwo/EAkw68D0OK81f8yn8YrbPKAkFj0PX6mLTVOxSjEY9vLiPpraNNMZlUdAnTpwR8tgadCRK3sLQ4Zh5mY7b3jwQfj0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238154; c=relaxed/simple;
	bh=y4yZzfmObu3if3o5OVkpvSi1I0Su6j5M4Vm897qE7H8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZX/Le4WXBvYN61BgmD77hVQB+yqiFE64ErcbVbIGq/5SwIW/OQVlCuj5NM2NOiM5i4T5vSjFxW+WKonM7b1UBn0YNXGKjdHC8R2oP6j12Ar9vPzmhHnvtrjTkoiTNRB2HYgjlj4MlviCOYAvzqON0mbm9P9hh+zXEmHkoDesoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxHDIHcl; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7c7770fd687so72336339f.3;
        Thu, 29 Feb 2024 12:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709238152; x=1709842952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=DiQEUxWPorvEFhlZl/UzCLiVJ40S44pM/WUqOSrDV2I=;
        b=GxHDIHcl72HnfkuFDFEy5gK7vKxDgHArDrF3bFOVy16QYo+d07qs3kKWXK1QUvQ99L
         S5vqX1Ob5p1p0dUOIEJ4tNSFu52ZY8Skh4ronhkKzVKIdDc71s4pM/PSgwxWnNWzPcpk
         J35s999WlQWNFj4D6oa6gPiau9/GfNibPjaL3/0fMUIwwD31yh74j3mu6rTtZyE3lHu/
         l5pwG99o5NGtFO7DM1IxioJDQ9GGLXbN+wxD+9iP7ylUTZNj6Ss2rznYvUPR16UpEZL6
         k7y0L8YlR5EAF5ILUXx4oLkjJJv0ei+JP+/ktUnoLEbw02n8J+EUd72/OajxuZtmLiTF
         2WRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238152; x=1709842952;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DiQEUxWPorvEFhlZl/UzCLiVJ40S44pM/WUqOSrDV2I=;
        b=FLs472FGLNF68990GyOu80XN/0fPMHuZnZ7ToYYGGv0focddekA1WpKioq4UhKInLM
         abrM5PSr39ACx3r/HzTxino8oWdCYb2lMW1WeUGql1BqAMfxtGTKV/DRI0cQfXst2x/N
         EOvYWeU+vY8GH1n0oH21dcFHBIafpBAeQSoxjkF+srtVi+0+hzYzL54+4DRxxRTB/3ZO
         xROPvBJrHdLo3uAt0Fyi4fLSibrcdgIvNLvfU9bqzQD7JgS+0CngdkokWsDNOasPXN8m
         OcM707u32VYnI56FDqd0DDBPcWjRQWTuI8PoqOGI1Jb2GQz7URQC1sDXxCiBUa0sGy/E
         wyOg==
X-Forwarded-Encrypted: i=1; AJvYcCUkMZw1HidzBT4r3UdcKY64FBuQuJqcot1F/iGu8AOcpZTbAytBQXqvX9+RSBI2lkcGRCHtVeM/YO5y8THliDFd9VNSZ7hdaHMb8bbciZfH6qwxrtP6V003ixjNSLUm89Q7cSLc1Y2zJYDwUGCpppy5kpXCCerOL2S7z8sl5GcuvEuNoxuuyaQHPwq/
X-Gm-Message-State: AOJu0YwyEzcF55gnW1dv6F1dfm/AoTIi0HLmqRv1a09uht1OGpRSzJvd
	yKYEUHXUvJ1w5iS2cfKD3SMk40y1wTJyWsz9Did4tyym6/bA2LeE
X-Google-Smtp-Source: AGHT+IEYHL0HoEr8EMQXwGkytuWtT6PcVOkjYRqPrG7RLwGReCeAW3Om2cnYSzjMZHFDguscX5bpWg==
X-Received: by 2002:a6b:3e45:0:b0:7c8:af2:7a8a with SMTP id l66-20020a6b3e45000000b007c80af27a8amr37321ioa.20.1709238152184;
        Thu, 29 Feb 2024 12:22:32 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fo1-20020a056638648100b0047462f8adfdsm471249jab.138.2024.02.29.12.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:22:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <015563c8-8075-4a7e-bf33-74333aaca648@roeck-us.net>
Date: Thu, 29 Feb 2024 12:22:29 -0800
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
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
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
References: <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com>
 <Zd0b8SDT8hrG/0yW@ghost> <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
 <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
 <CAMuHMdW-sUYr8_y6av9Dbtz6JJAxBUsiTGZcK2QYEHo0x1z44w@mail.gmail.com>
 <e9112858-76b8-4b91-88b1-b5694cda3350@roeck-us.net> <ZeDdOH0zBY8qKrVH@ghost>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZeDdOH0zBY8qKrVH@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 11:38, Charlie Jenkins wrote:
[ ... ]
>> Tough one. I can't enable CONFIG_NET_TEST on nios2, parisc, and arm with THUMB
>> enabled due to crashes or hangs in gso tests. I accept that. Downside is that I
>> have to disable CONFIG_NET_TEST on those architectures/platforms entirely,
>> meaning a whole class of tests are missing for those architectures. I would
>> prefer to have a configuration option such as CONFIG_NET_GSO_TEST to let me
>> disable the problematic tests for the affected platforms so I can run all
>> the other network unit tests. Yes, obviously something is wrong either with
>> the affected tests or with the implementation of the tested functionality
>> on the affected systems, but that could be handled separately if a separate
>> configuration option existed, and new regressions in other tests on the affected
>> architectures could be identified as they happen.
> 
> I think I got confused here, is this an issue with the tests included in
> this patch or is it unrelated?
> 

Unrelated. It was intended to be an example of another set of tests which
suffer from a similar problem (crash on certain architectures if enabled).
Sorry for the confusion.

Guenter


