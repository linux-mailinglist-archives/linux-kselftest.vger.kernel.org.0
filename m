Return-Path: <linux-kselftest+bounces-2764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC75828D4B
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 20:23:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA0F2862A0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4C23D0D0;
	Tue,  9 Jan 2024 19:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="NNW4P0j0";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="WfvsBawM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EBC3C694;
	Tue,  9 Jan 2024 19:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 3A2C360177;
	Tue,  9 Jan 2024 20:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704828217; bh=Y42GFyRmBuoPGe7vrd1pFvKR4nPAFlTjEu6yMmACWMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NNW4P0j0tjh5YVjXiM7hl7aw1XnMcLEB9FfoKb9OKCf9HLcJlyVg2Bgmjy1pt30mf
	 xKEx/p//SmZn7CfFvAd1xHbsCEfipYvUB7IziFxdDfT8TUiGIYd9VyWM9UbrImhLvc
	 VmJ2As9DBXOtGEMdbZaK8GBFYal6f4TMF1jeQeqIfW6W+CnXxVDQKiC//skxkvccR9
	 ybMjpT+xzh2GDsh9E4nEwnUurPB2QqJjHYJLppiGeZV5JMIzKqDOBo3aDBXD44/maI
	 guHifM9mQnHiTQeUOfKlmpx+9aZMheabiqg7msFn9aPCz8jlsUD7YoP8UkhcpKvLRX
	 isfO9ZpfllsjQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hy5WhOkhQeps; Tue,  9 Jan 2024 20:23:35 +0100 (CET)
Received: from [192.168.239.51] (unknown [95.168.105.29])
	by domac.alu.hr (Postfix) with ESMTPSA id 7E10960171;
	Tue,  9 Jan 2024 20:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704828215; bh=Y42GFyRmBuoPGe7vrd1pFvKR4nPAFlTjEu6yMmACWMk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WfvsBawM++od7CGSyM2LakCZVm9nXUPx07XHmbDwGPaE9ITsvnQOneOBXOnL7B1+Z
	 Gd2BZz6/BQ3b6ubVaUdjpUPt8fn9wITqVp9xNRSrk4IzI7jhqU+lCfrMrYdYAwhIxl
	 O9eApr+5RZDQLwWadDfQymoqZhnUtJb1hu1fzEVlQ39IQfiLnUe/4DdkNADtRTCSvD
	 33jXdCuKVxB8lL7jHNoNyKf/rj4NmLWfpPXFghCPfsThDm9T+TRerazFBAqHJSJsJU
	 itmOOeyZa8KXqtysYAcMgzv0HKJnI14Sex+jPmKsOihF2naMal9Ox6ZBE+A3XSMGWh
	 6HugKS2lNrGkw==
Message-ID: <056c0162-10cd-4402-999a-02dec87b34ad@alu.unizg.hr>
Date: Tue, 9 Jan 2024 20:23:33 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] kselftest: alsa: Fix a couple of format specifiers
 and function parameters
Content-Language: en-US
To: Takashi Iwai <tiwai@suse.de>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Shuah Khan <shuah@kernel.org>
References: <20240107173704.937824-1-mirsad.todorovac@alu.unizg.hr>
 <87le8yr3rf.wl-tiwai@suse.de>
From: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Autocrypt: addr=mirsad.todorovac@alu.unizg.hr; keydata=
 xjMEYp0QmBYJKwYBBAHaRw8BAQdAI14D1/OE3jLBYycg8HaOJOYrvEaox0abFZtJf3vagyLN
 Nk1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgPG1pcnNhZC50b2Rvcm92YWNAYWx1LnVuaXpnLmhy
 PsKPBBMWCAA3FiEEdCs8n09L2Xwp/ytk6p9/SWOJhIAFAmKdEJgFCQ0oaIACGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRDqn39JY4mEgIf/AP9hx09nve6VH6D/F3m5jRT5m1lzt5YzSMpxLGGU
 vGlI4QEAvOvGI6gPCQMhuQQrOfRr1CnnTXeaXHhlp9GaZEW45QzOOARinRCZEgorBgEEAZdV
 AQUBAQdAqJ1CxZGdTsiS0cqW3AvoufnWUIC/h3W2rpJ+HUxm61QDAQgHwn4EGBYIACYWIQR0
 KzyfT0vZfCn/K2Tqn39JY4mEgAUCYp0QmQUJDShogAIbDAAKCRDqn39JY4mEgIMnAQDPKMJJ
 fs8+QnWS2xx299NkVTRsZwfg54z9NIvH5L3HiAD9FT3zfHfvQxIViWEzcj0q+FLWoRkOh02P
 Ny0lWTyFlgc=
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <87le8yr3rf.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/9/2024 3:16 PM, Takashi Iwai wrote:
> On Sun, 07 Jan 2024 18:37:00 +0100,
> Mirsad Todorovac wrote:
>>
>> Minor fixes of compiler warnings and one bug in the number of parameters which
>> would not crash the test but it is better fixed for correctness sake.
>>
>> As the general climate in the Linux kernel community is to fix all compiler
>> warnings, this could be on the right track, even if only in the testing suite.
>>
>> Changelog:
>>
>> v1 -> v2:
>> - Compared to v1, commit subject lines have been adjusted to reflect the style
>>    of the subsystem, as suggested by Mark.
>> - 1/4 was already acked and unchanged (adjusted the subject line as suggested)
>>    (code unchanged)
>> - 2/4 was acked with suggestion to adjust the subject line (done).
>>    (code unchanged)
>> - 3/4 The format specifier was changed from %d to %u as suggested.
>> - The 4/4 submitted for review (in the v1 it was delayed by an omission).
>>    (code unchanged)
>>
>> Mirsad Todorovac (4):
>>    kselftest/alsa - mixer-test: fix the number of parameters to
>>      ksft_exit_fail_msg()
>>    kselftest/alsa - mixer-test: Fix the print format specifier warning
>>    kselftest/alsa - mixer-test: Fix the print format specifier warning
>>    kselftest/alsa - conf: Stringify the printed errno in sysfs_get()
> 
> Applied all patches now.  Thanks.
> 
> 
> Takashi

No, thanks to you for your patient work. I realise that there are roughly
2,000 patch emails each day.

This might seem like sugarcoating, but I realise the developers are under
a great stress having to evaluate such number of patches each day. The kernel
is now close to 35+ Mlines and I do not underestimate this work.

I'm nowhere close to understanding all subsystems, but I recognise the need
to be disciplined to make the maintainer's job easier and feasible in the
long run.

The time invested in the Linux kernel and operating system is a gift that
keeps on giving :-)

Regards,
Mirsad


-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355

