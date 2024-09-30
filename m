Return-Path: <linux-kselftest+bounces-18559-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B19898EA
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 03:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D447D1F21644
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 01:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA49137E;
	Mon, 30 Sep 2024 01:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b="OJYj6KNr";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="na5HGljU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5312923BE
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 01:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727659129; cv=none; b=IOI0QbP6SuTjO/jYkI2r6Mei+Cm9/tzOLtYL8uHX6riSdOny+L0MXlD9Bm4LI7uTHtMQ/RScQNVfX7RUoBrUNySQs3mpd0qz9TIjS3qpebzW5hQfD7w6KTDcBkdOh4UTmPGSGlhQcRdYTAScG6qNOTXP2jRuwspL7vnh/PdAGaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727659129; c=relaxed/simple;
	bh=UoGYMF3MIQIIbCmjHuxkNo9cQNcfEJ4+tK9H/0Ah4Qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bffJhgrnN0Cfikwqw2iRAzrQW6YNzCFeQGP0ejTq9/KyFovWqA4jV+k/krJm/mla6XVH/m3UR+kiotGBk9HOzsQLwRMYflICe7fxSm7JTHYGGRIV2JErLbmSJHBMD5ZoPEWNYu5KZjOMZwOOwZxvGKJIPOc5mMKoGB/+eFRELi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev; spf=pass smtp.mailfrom=lkcamp.dev; dkim=pass (2048-bit key) header.d=lkcamp.dev header.i=@lkcamp.dev header.b=OJYj6KNr; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=na5HGljU; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lkcamp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lkcamp.dev
DKIM-Signature: a=rsa-sha256; b=OJYj6KNrugyBLKFx1+CjyhQ/sXMtv88UX1AMwVCKCm6JVd6ks+hoQR+r16CL1MfRBVORoMoO9RIF9Vd5ZDn4LGI69XMgvm7S7JXd2/cEuWh+bonHb0iXHcop/eNjt7BldE62A8PXaO3GH6OE5AsHzMUSRXKy6M6E/TfLU8ICp29cMsIrwoSb2AayHKrRkfIQqr3GESJCDXx5Fg0SLVko6FZkm8KK+tShM1k4aKGwQ7IM4jLfXTnU01lfVewjLA2ojYJjYygqSCt2TMk2xSPrNhdtSySr1VwZE/dv0SMic943My5HGi3hvlR41lpQ9N8LjcNwZckqtPjvYu6vDz6oxA==; s=purelymail1; d=lkcamp.dev; v=1; bh=UoGYMF3MIQIIbCmjHuxkNo9cQNcfEJ4+tK9H/0Ah4Qc=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=na5HGljU8ildFIXXp5wa6hZWU/0ai5GaXobOBdKAgkdQ0tRPWQi3dJRcyOs/RReyFW4K7rg7zUiThqsV8cwMPTsS/YmrNKwpR/1x2n50CXyKzUi9A9/ZE6gPLu0XlvEZweipy76egrYLnywb7c8OuXhvuHVvSHJ80IeXFM6R/Pnl79XjzeyQ1AgmeEzrOD1StIDIBup3xcZPXtO0AOjinXKg1H67OVM+PU2d1Sxr0QlZGGunwR40Hi3WeCTF2W/hUCrTygW54WJmOreDGXvUTeHjRUNYDIjJN83aj09XPdNCjIsDJLh72slDIN4F4Q1KzlUSjUa59x/DXCB0Lab9Og==; s=purelymail1; d=purelymail.com; v=1; bh=UoGYMF3MIQIIbCmjHuxkNo9cQNcfEJ4+tK9H/0Ah4Qc=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 40580:7130:null:purelymail
X-Pm-Original-To: linux-kselftest@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2015297320;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Mon, 30 Sep 2024 01:18:30 +0000 (UTC)
Message-ID: <1ca713fc-2675-4154-ad46-a3fe11839148@lkcamp.dev>
Date: Sun, 29 Sep 2024 22:18:26 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] Add KUnit tests for lib/crc16.c
To: David Laight <David.Laight@ACULAB.COM>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 "~lkcamp/patches@lists.sr.ht" <~lkcamp/patches@lists.sr.ht>
References: <20240922232643.535329-1-vpeixoto@lkcamp.dev>
 <51c4ba25f9284a749b451ca203fcc124@AcuMS.aculab.com>
Content-Language: en-US
From: Vinicius Peixoto <vpeixoto@lkcamp.dev>
In-Reply-To: <51c4ba25f9284a749b451ca203fcc124@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi David,

On 9/25/24 08:26, David Laight wrote:
> From: Vinicius Peixoto
>> Sent: 23 September 2024 00:27
>>
>> Hi all,
>>
>> This patch was developed during a hackathon organized by LKCAMP [1],
>> with the objective of writing KUnit tests, both to introduce people to
>> the kernel development process and to learn about different subsystems
>> (with the positive side effect of improving the kernel test coverage, of
>> course).
>>
>> We noticed there were tests for CRC32 in lib/crc32test.c and thought it
>> would be nice to have something similar for CRC16, since it seems to be
>> widely used in network drivers (as well as in some ext4 code).
>>
>> Although this patch turned out quite big, most of the LOCs come from
>> tables containing randomly-generated test data that we use to validate
>> the kernel's implementation of CRC-16.
>>
>> We would really appreciate any feedback/suggestions on how to improve
>> this. Thanks! :-)
> 
> Would is be better to use a trivial PRNG to generate repeatable 'random enough'
> data, rather than having a large static array?

That's fair, the big static arrays are indeed very unwieldy. I reworked 
it to use next_pseudo_random32 (from include/linux/prandom.h) to fill 
the tables with pseudorandom data before running the tests, and will 
send a v2 soon.

The LOC count is a lot smaller, although it is still using static tables 
to store the data and the tests (I thought it would be simpler than 
allocating them at runtime). Do you think this is acceptable?

> As a matter of interest, how in crc16 implemented (I know I could look).
> The code version:
> 
> uint32_t
> crc_step(uint32_t crc, uint32_t byte_val)
> {
>      uint32_t t = crc ^ (byte_val & 0xff);
>      t = (t ^ t << 4) & 0xff;
>      return crc >> 8 ^ t << 8 ^ t << 3 ^ t >> 4;
> }
> 
> may well be faster than a lookup table version.
> Especially on modern multi-issue cpu and/or for small buffers where the lookup
> table won't necessarily be resident in the D-cache.

lib/crc16.c does use a lookup table. I haven't had the time to run 
benchmarks testing whether this version is faster, but I'm curious as 
well, so I'll look into it.

Thanks,
Vinicius

> 
> It is slightly slower than the table lookup on the simple Nios-II cpu.
> But we use a custom instruction to do it in one clock.
> 
> 	David
> 
>>
>> Vinicius Peixoto (1):
>>    lib/crc16_kunit.c: add KUnit tests for crc16
>>
>>   lib/Kconfig.debug |   8 +
>>   lib/Makefile      |   1 +
>>   lib/crc16_kunit.c | 715 ++++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 724 insertions(+)
>>   create mode 100644 lib/crc16_kunit.c
>>
>> --
>> 2.43.0
>>
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)


