Return-Path: <linux-kselftest+bounces-5793-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339E86F334
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 01:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0B9B23768
	for <lists+linux-kselftest@lfdr.de>; Sun,  3 Mar 2024 00:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC4565C;
	Sun,  3 Mar 2024 00:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d8uKepr1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60D063A;
	Sun,  3 Mar 2024 00:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709424096; cv=none; b=NXVMot2yWfZfsj++idc4tC2RMYY5PCdpfWy7KLL/QdZddj3u+se5dUxDXUS+siIb/XJY9WkAdNlSSDdE7BBOD5xPmOjoZMLqs6JS26Sfw8049Yn/Po9qnmmaZ/0EYTbhfZs0Yrd+65jcEoGFA9III5QygFCyzdsDCrF/u2uYtWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709424096; c=relaxed/simple;
	bh=9Lv2JIlrEK7ISwNL1lIjOiH9V4PIOwaJ2IrJ7e9d/6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7/FtHv5E1sskbaYe6UUrygJZwPLqvTBJD+cHhZnTkyXdrtrvkvnFNKuUIN9Ob7bFIkNv80tqonQOj5HbvOIIEwoMFa7FZAEGYntWNw178okgTxeUAzCAYNGddMA0dVe/wgElOcwvlT7OCgAaAq9HKKgLPQ3Xz2vy7GPYVFUE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d8uKepr1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=+aCuWJupLOSBvXZ0Gqv1AfJ8CcEKqmKcXL3V2MU5aTk=; b=d8uKepr1Y9jfM0QamhrwgEl1k9
	W/c5LBCk8dnhi6V7AgrsiTI5agLEqtyhEovG9WaxiD6nMO1orH8h+spv/dYO8TXTFKaM1ra6NVM3z
	/uBemi+3Y3nqWlYqq7YM3VZOakq1XLpnDQTHpkrGBj2bd6Kwqvq9QD5pWH4h6gyRG0E6ELSpOafQS
	XlS4elHdFbb9GQJEszeTJULt8iuyjWz99fqqfi/ziJI/1hqcJ9ibLmdjj66+eqkbBRXIOOkdAJrNJ
	kGyHF0FCLj9yWYR8JgkE/c+yOVrHaXOWtkiWhCSkrADZAtHBOdk+jsSK53dgT1tEen6N21ws6sKXg
	YbmrVAxA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rgZIJ-00000004hUf-0Qa7;
	Sun, 03 Mar 2024 00:01:31 +0000
Message-ID: <269232e6-41c9-4aa1-9320-662beabcd69b@infradead.org>
Date: Sat, 2 Mar 2024 16:01:30 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] kci-gitlab: Introducing GitLab-CI Pipeline for Kernel
 Testing
Content-Language: en-US
To: Guenter Roeck <groeck@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Helen Koike <helen.koike@collabora.com>,
 linuxtv-ci@linuxtv.org, dave.pigott@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
 pawiecz@collabora.com, tales.aparecida@gmail.com, workflows@vger.kernel.org,
 kernelci@lists.linux.dev, skhan@linuxfoundation.org,
 kunit-dev@googlegroups.com, nfraprado@collabora.com, davidgow@google.com,
 cocci@inria.fr, Julia.Lawall@inria.fr, laura.nao@collabora.com,
 ricardo.canuelo@collabora.com, kernel@collabora.com,
 gregkh@linuxfoundation.org
References: <20240228225527.1052240-1-helen.koike@collabora.com>
 <20240228225527.1052240-2-helen.koike@collabora.com>
 <20240229-dancing-laughing-groundhog-d85161@houat>
 <5d7ed81b-37f9-48e9-ab7e-484b74ca886c@gmail.com>
 <CAHk-=wixVy3WYvjbt43ZSrCqPDsS76QJQSkXFbbPsAOs1MCSAQ@mail.gmail.com>
 <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CABXOdTeT2ip1uS2EG2w8pW7254Tnd=ZDNz-KC61-G-yqDTVgJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/2/24 14:10, Guenter Roeck wrote:
> On Thu, Feb 29, 2024 at 12:21 PM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
>>
>> On Thu, 29 Feb 2024 at 01:23, Nikolai Kondrashov <spbnick@gmail.com> wrote:
>>>
>>> However, I think a better approach would be *not* to add the .gitlab-ci.yaml
>>> file in the root of the source tree, but instead change the very same repo
>>> setting to point to a particular entry YAML, *inside* the repo (somewhere
>>> under "ci" directory) instead.
>>
>> I really don't want some kind of top-level CI for the base kernel project.
>>
>> We already have the situation that the drm people have their own ci
>> model. II'm ok with that, partly because then at least the maintainers
>> of that subsystem can agree on the rules for that one subsystem.
>>
>> I'm not at all interested in having something that people will then
>> either fight about, or - more likely - ignore, at the top level
>> because there isn't some global agreement about what the rules are.
>>
>> For example, even just running checkpatch is often a stylistic thing,
>> and not everybody agrees about all the checkpatch warnings.
>>
> 
> While checkpatch is indeed of arguable value, I think it would help a
> lot not having to bother about the persistent _build_ failures on
> 32-bit systems. You mentioned the fancy drm CI system above, but they
> don't run tests and not even test builds on 32-bit targets, which has
> repeatedly caused (and currently does cause) build failures in drm
> code when trying to build, say, arm:allmodconfig in linux-next. Most
> trivial build failures in linux-next (and, yes, sometimes mainline)
> could be prevented with a simple generic CI.

Yes, definitely. Thanks for bringing that up.

> Sure, argue against checkpatch as much as you like, but the code
> should at least _build_, and it should not be necessary for random
> people to report build failures to the submitters.

I do 110 randconfig builds nightly (10 each of 11 $ARCH/$BITS).
That's about all the horsepower that I have. and I am not a CI.  :)

So I see quite a bit of what you are saying. It seems that Arnd is
in the same boat.

-- 
#Randy

