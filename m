Return-Path: <linux-kselftest+bounces-11024-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FFF8D65AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40201283F11
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 May 2024 15:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB5F763FC;
	Fri, 31 May 2024 15:26:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99941612EB;
	Fri, 31 May 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717169173; cv=none; b=V1AQDgUo0YYgPmkPXJPGQHFBGic6XuxMuDp61MtNOrPxjitbv5+d0P4N5ySBS2pg89C04sBe4FT3EZ855Ej5/qOYtqRWOIjaEfmy5JF4ZauCyYtSZvrdGiVGGRwvHd60Dj/suHsf7bxYfnErnxtMsQ2qANFtsSyhV6mGeCtHssA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717169173; c=relaxed/simple;
	bh=BIUy3OU4Yr8ghwL4539bzD9yt6/hC9ctf51iLpzRrKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CgfAFqQY2BDlFTFHhi2tlUhS1FokH6o4CeyTciHXnnL9AkBQl+wHEpHk7u8RuN61PYs7yPI+sBJluC6qQolDz56IM/J63gap3aws8xCAW0h/E+KVLXn7Q1s/sZXnmOVU8Y+ogfu1a/EVUoAn60Forq5KQ3vPu9MPv/efHLklyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.3] (g258.RadioFreeInternet.molgen.mpg.de [141.14.13.3])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 12F0661E5FE01;
	Fri, 31 May 2024 17:25:47 +0200 (CEST)
Message-ID: <cc00000d-302c-441e-9d65-9e75463db443@molgen.mpg.de>
Date: Fri, 31 May 2024 17:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: testing/selftests/alsa/mixer-test: 10 failures on Dell XPS 13
 9360
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1d44be36-9bb9-4d82-8953-5ae2a4f09405@molgen.mpg.de>
 <87cyp280yw.wl-tiwai@suse.de>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <87cyp280yw.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Takashi,


Thank you very much for your reply.

Am 31.05.24 um 17:17 schrieb Takashi Iwai:
> On Fri, 31 May 2024 07:50:33 +0200, Paul Menzel wrote:

>> Running the ALSA kselftests with Linux 6.10-rc1, `mixer-test` shows
>> ten failures:
>>
>>      # Totals: pass:24 fail:0 xfail:0 xpass:0 skip:11 error:0
>>
>> These are:
>>
>>      not ok 5 write_invalid.0.40
>>      not ok 11 write_valid.0.39
>>      not ok 18 write_valid.0.38
>>      not ok 25 write_valid.0.37
>>      not ok 201 write_invalid.0.12
>>      not ok 208 write_invalid.0.11
>>      not ok 264 write_invalid.0.3
>>      not ok 271 write_invalid.0.2
>>      not ok 278 write_invalid.0.1
>>      not ok 285 write_invalid.0.0
> 
> Through a quick look, those are no real "failures".  It'd be more
> preferable if the driver returns an error for invalid values, but
> currently it's up to drivers how to deal with them, and some accept as
> is but with correction of the values internally.  They are shown as
> "skips" in the summary above you showed, after all.

Sorry, somehow I copied the wrong line. The attachment actually contains:

     # Totals: pass:217 fail:10 xfail:0 xpass:0 skip:60 error:0

So it seems to be shown as failure.

> A more strict check can be enabled by a kconfig option
> CONFIG_SND_CTL_INPUT_VALIDATION=y generically.

Thank you. I am going to test that out.


Kind regards,

Paul

