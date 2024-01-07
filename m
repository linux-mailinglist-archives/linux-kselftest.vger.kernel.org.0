Return-Path: <linux-kselftest+bounces-2697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A05682650E
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 17:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D9CD1F2165B
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E31E13AE0;
	Sun,  7 Jan 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="LlK3CcnI";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="INyv2SkI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6297513ADB;
	Sun,  7 Jan 2024 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 2E4C96017E;
	Sun,  7 Jan 2024 17:21:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704644464; bh=MMADYUgUtx/GtzC1SV4l8PB3GSRejcIo1JrQv03N/20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LlK3CcnIOMFypVQhOKTNqHzNc9sRgOiAVBcR9hX76Jxx2O5meAKGIpb40FJv6MKNL
	 R+Hao27kCh9Ves60Ai6LrncTc0fqMK1433s7sf21O2wAy8sbf3Xu8eAzyuV11apbIk
	 YSNPvN5ioHefHYFKj3pMcf4qhhz5vUe96bx8p9gk+CF+xvaIHq265HqM5mSHxM4nE2
	 ZpYd5WVzc1U0FHwR6zePZPruXjp2LfKIW3RH/pb0KPSVLH1r9S0YpmpSXZ5M5GmxwF
	 wamdtTtCCyRd/l+gfQg0T1OsTuD3LFrUIN0yuY8Gmst+PVJDAmbKkWVBfF2L1lZfpN
	 Dfe5ZGNJZQoNQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1uqqC2Ckj3wx; Sun,  7 Jan 2024 17:21:01 +0100 (CET)
Received: from [192.168.6.51] (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 2E7CB60171;
	Sun,  7 Jan 2024 17:21:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704644461; bh=MMADYUgUtx/GtzC1SV4l8PB3GSRejcIo1JrQv03N/20=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=INyv2SkI8oeHUWDzPa7cvsMFr5gPHYwLRK+57wmeYhintD0iVI8PNG5nmRCGvhYTM
	 T4jlx+Pzv+mIvsp7/hLYMkLiQ4g+GMov56pcncvAAbHfuRqNseOvAuxb0yMBDbxivY
	 7lhovzMp3A08ooj9gPoGr/N1yCxBMctamuag03gkghy9sJJ/UUc0L65pgPfssdesdu
	 e024PZuXtUCx1EUzutUw4bmbP5brzoSBAv+u1JpyzF26iza7kSPK16BECSz8K5E0vU
	 hbMWQ7BGbCCUPzX7AJSbPiEgh+vdCqKl2qdaHdx2rR03PhhLmYj5JnyxnQYFnYhPYP
	 jC9bQnaPl34HQ==
Message-ID: <34121d01-34dd-4c29-b31e-91f3e8ea15bc@alu.unizg.hr>
Date: Sun, 7 Jan 2024 17:21:00 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] ksellftest: alsa: Fix the printf format specifier
 to unsigned int
Content-Language: en-US, hr
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 linux-sound@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Shuah Khan <shuah@kernel.org>
References: <20240107151218.933806-1-mirsad.todorovac@alu.unizg.hr>
 <20240107151218.933806-4-mirsad.todorovac@alu.unizg.hr>
 <ZZrEXSU3Bx85rSGo@finisterre.sirena.org.uk>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZZrEXSU3Bx85rSGo@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07. 01. 2024. 16:33, Mark Brown wrote:
> On Sun, Jan 07, 2024 at 04:12:20PM +0100, Mirsad Todorovac wrote:
> 
>> mixer-test.c:350:80: warning: format ‘%ld’ expects argument of type ‘long int’, \
>> 			      but argument 5 has type ‘unsigned int’ [-Wformat=]
> 
> If this is the issue then...
> 
>> -			ksft_print_msg("%s.%d value %ld more than item count %ld\n",
>> +			ksft_print_msg("%s.%d value %ld more than item count %d\n",
>>  				       ctl->name, index, int_val,
>>  				       snd_ctl_elem_info_get_items(ctl->info));
> 
> ...why are we not using an unsigned format specifier here?  I am very
> suprised this doesn't continue to warn.

I double-checked and there is no warning, but I will fix it as you
suggested.

> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.

I am just looking at the `git log --oneline tools/testing/selftests/alsa`
and I can't seem to get inspiration.

I guess I can keep the Acked-by tags. Will the patchwork find the tag in
the v1 patch set?

Sorry for the lag in [PATCH v1 4/4]. I thought I pressed submit, but I
obviously did not.

Thanks,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"


