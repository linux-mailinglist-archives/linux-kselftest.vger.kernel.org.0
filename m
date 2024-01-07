Return-Path: <linux-kselftest+bounces-2684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FEE826272
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 01:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70D95B21B3A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 00:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F9219A;
	Sun,  7 Jan 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="fv+9twWf";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="kKaEzs/r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77393137F;
	Sun,  7 Jan 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 2D8E16017E;
	Sun,  7 Jan 2024 01:11:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704586285; bh=io6bVbjfD9MLx3dCArThBXRDeqsxHoH4H3cJLntGxTs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=fv+9twWfnSR6B7G1e3KF79xVVuX4TvE+nDFKj8/5udkS8uvlUHVGgNaxvsv7pL7Vp
	 CZO7GynaY9cISXI4JyNr2azRBqGcIFF/MdYq1aYl3TmSDJu6Ghr+22Rg9SyDS41Quq
	 aXswChLOKEUC3M6e0lJ1Yd5C2Ny1D4lfFLU2TMgQC8z0Z8BvJA9pEJEkcq1iNLrxe4
	 mPMHPqFxvraKmMapMb92sBNKV4DSDVapiDKK7Jij27OFvGkf/clBbs6BbAihzhhMJd
	 p6GUDVGKuLRITBe77FhJSQJ31aWpH1GlFelA1zl0Fmg3wNjFJN7ydoCjS2KGrCG7Sx
	 QMPHm5xZEEhww==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bzMzb-QkuWYS; Sun,  7 Jan 2024 01:11:23 +0100 (CET)
Received: from [192.168.92.51] (unknown [95.168.116.36])
	by domac.alu.hr (Postfix) with ESMTPSA id 3153C60171;
	Sun,  7 Jan 2024 01:11:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704586283; bh=io6bVbjfD9MLx3dCArThBXRDeqsxHoH4H3cJLntGxTs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=kKaEzs/rckAz7btXlgiVUlTnJ2tV90ms5iFXuyZCwQ2lZDRg1rVcpHSJz4jA2PoNY
	 2MK0S4dU1qcZX87/XSnjrkgki/IqdkpXIe4tcRML/cEnW8UioAHzuzMYB/2vu6639S
	 TRBFEgcbqowQ80PS/7BIMn0kY95d5X4uYEte+ZpEAjR5WApDQzuKtmLvL+ABIhI0YB
	 oVGIe6FcwKUaS8TN80nqxRI92UyDMaq9qbPvnhEBmVYu339lvydG+NFnsxwKWsbxY/
	 KU5Vh40o2wVtQKKW7VxAFFwOKcZG/dHvYwOJF/g8H3J1g2F0JQLuUcGIlbEFVeKjYM
	 yGO4ba71wOUCA==
Message-ID: <acce064f-23c1-4f32-b9d8-d8c47d81fdb2@alu.unizg.hr>
Date: Sun, 7 Jan 2024 01:11:21 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: selftest: net: fcnal-test.sh TIMEOUT
Content-Language: en-US, hr
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: David Ahern <dsahern@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <0b9a2827-c9c5-41d6-a4f1-dbd91262c474@alu.unizg.hr>
 <e0a52f62-3ea8-48c4-a5c4-307f7642cd45@kernel.org>
 <5f46cd87-ecad-4cad-bb03-b5bf22dff3b7@alu.unizg.hr>
In-Reply-To: <5f46cd87-ecad-4cad-bb03-b5bf22dff3b7@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 06. 01. 2024. 22:02, Mirsad Todorovac wrote:
> On 06. 01. 2024. 17:16, David Ahern wrote:
>> On 1/5/24 2:41 AM, Mirsad Todorovac wrote:
>>> diff --git a/tools/testing/selftests/net/settings
>>> b/tools/testing/selftests/net/settings index dfc27cdc6c05..ed8418e8217a
>>> 100644 --- a/tools/testing/selftests/net/settings +++
>>> b/tools/testing/selftests/net/settings @@ -1 +1 @@ -timeout=1500
>>> +timeout=3600
>>
>> bumping the timeout is fine to me. that script is running a lot of
>> permutations.
> 
> Well, aren't bugs best discovered if all cases or permutations are tested?
> 
> I recall some cases with Giullaume and Ido fixing them the last Summer or so.

Hi, David,

I apologise for my poor understanding of American English phrases.

If increasing the timeout value is OK with you, will you guys do it
or should I submit the formal patch?

Thank you,
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


