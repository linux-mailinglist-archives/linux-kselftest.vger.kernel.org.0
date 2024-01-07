Return-Path: <linux-kselftest+bounces-2705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E138265A3
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 19:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46EE8281B71
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 18:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A983410A0A;
	Sun,  7 Jan 2024 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="ClM4duYN";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="dqzbqbxK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EAB10A17;
	Sun,  7 Jan 2024 18:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 8828C6017E;
	Sun,  7 Jan 2024 19:43:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704652994; bh=/8k/gc+e92RynLmS4ARbFS1DT+RhiG7LkYKs7/Pc1mA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ClM4duYNYMFqf4Q3i2yLrMFwWEeU8yXR1xMqFJRl85c/R7ikosiVfKJRJIwtYjMeS
	 v4aw6FyrYVnmIWZBvVlEXEhf+4BlgFXpxV18IowwMz8TCBrNFWUr2v26TpGS6WoGTU
	 2KKbF62OUHLwxR+PKrVjb9mQESwt66SJBwbh/PG1IMEasARyqx7TWzPqG8K3GUJ42z
	 FS2KJaam0sN6IOJlNBdotF5aO8qeOxnSPqN0v4RHkbqruDli9GTB+ONL3FjqCo67cA
	 6AkmjKE9T9ydwYm48RJx4ZhVwGPTi34uY8IMrNhrEOU+ZLDNnDJPvW2QEC5+g+x7dn
	 ty+kh7uhH9jUQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UCwbCgsSh47H; Sun,  7 Jan 2024 19:43:12 +0100 (CET)
Received: from [192.168.6.51] (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id B8F5860171;
	Sun,  7 Jan 2024 19:43:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704652992; bh=/8k/gc+e92RynLmS4ARbFS1DT+RhiG7LkYKs7/Pc1mA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dqzbqbxKp39R5QruQR03NEzBNXfSwudlJ6oXbzfhTO0Q7WMi1rlpcfHvZLnXnl4bz
	 46gn7DsFOotpCzZJzs/ttqAMVJkBoC7k9Ep9Ci1uGgEUIqarawJQDbpCuTQo+VTeQu
	 g0W36mF4F9QRe6C1v+Mo0r1G7KCOBAoCx99uetqWpFnnksjkEg+sj5Hynt4mhbiWrJ
	 qigcMCd+GpJqBVXL6ujpjFcUeVeW9gfiqMmVpSOQevR40vdMNZpvRtNJFciB8PeiNd
	 ltL0Ut1DyKIKI7yUbAGeHnjyiyUeF+ruu0uDNVhaMtdpZ2zsgR9y4M8Gr5viq5GMHJ
	 dqhiDFg7yYHcw==
Message-ID: <c6cb8004-23e8-4f37-ac49-0ed6b5c66b2f@alu.unizg.hr>
Date: Sun, 7 Jan 2024 19:43:10 +0100
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
 <34121d01-34dd-4c29-b31e-91f3e8ea15bc@alu.unizg.hr>
 <ZZrqE4iCRMqTX/3v@finisterre.sirena.org.uk>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZZrqE4iCRMqTX/3v@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07. 01. 2024. 19:14, Mark Brown wrote:
> On Sun, Jan 07, 2024 at 05:21:00PM +0100, Mirsad Todorovac wrote:
> 
>> I guess I can keep the Acked-by tags. Will the patchwork find the tag in
>> the v1 patch set?
> 
> No, you need to include it.

Great. Sent v2 for review.

I heard that there is a rule "one version per day or when confirmed"?

Nevertheless, these are minor fixes in the error reporting logic (though
no change is small enough to bee taken lightly), so I am sending now
because I don't know about the load tomorrow.

Please find v2 of the patch set on the LKML.

Kept two ACKs (code unchnaged), two left to review.

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


