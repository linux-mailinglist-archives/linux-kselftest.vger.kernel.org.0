Return-Path: <linux-kselftest+bounces-2692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C768264AA
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00A36B21143
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Jan 2024 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7472C134BA;
	Sun,  7 Jan 2024 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="j8kxmGcf";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="eS5//H02"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A2134CB;
	Sun,  7 Jan 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alu.unizg.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alu.unizg.hr
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id 3C5436017E;
	Sun,  7 Jan 2024 16:22:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640940; bh=4VScd3SKktXVRNK8bEiQlJVTk6Q2TgicT0Kv2F9OPZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j8kxmGcfIcLOJGlEWOmE4Hhl9y5B7XeBslbq/W4sOz4fDwiSXZfgwOJ7duVKm79WQ
	 t00ACqJFtCFLTFG2FNwnwqdxfNQgP2byi1lUrzzpuGFV6OsxBk0Rh5YU/k01+D6tsO
	 5+Xh/U+2H3doHz5SFfiPKsOVxOp+mtd4DGGU1Cxt8/KRpa0G6W2gzAtqnxieGpH1w7
	 aqKBon2CbuKCsafa7GkcwXwnQNfozxqKBck3qv3TB5mqvjNdyVu2V3iE143nBexXOf
	 IRkVRPcFLzJPAguG7iSpccfJhb6Cmls4v70zhmCL9T+RchPMAb1fQEoRVKwiHhKSCd
	 uuM1NS1DHaKsg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pw0gCxwYNRI5; Sun,  7 Jan 2024 16:22:18 +0100 (CET)
Received: from [192.168.6.51] (unknown [95.168.121.73])
	by domac.alu.hr (Postfix) with ESMTPSA id 1438960171;
	Sun,  7 Jan 2024 16:22:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1704640938; bh=4VScd3SKktXVRNK8bEiQlJVTk6Q2TgicT0Kv2F9OPZ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eS5//H02PSLeKUXsq0X+3cKS6ngCLB0V+rOtKApc4O7DK8WVFpVVClIrVjUay8rbx
	 3QvjF7tc8+A5qyLgHf72vDnVJmKqI4KH5GPKQyP5OOT6BhjVA4ChSAqjLN6v+BnSNy
	 s/W9juwRuap8aiat/xdHaqpHUucvZnniMdH4aNfwnNwvhqwmsxaIvddF9DqQhoEGoH
	 kGwv0U+C8DDrOpSwe3wvydnIvpSBBgEj2AwF7YLDMpR3MP7hm42wtroANmHC7Kfc4V
	 I4rmv5FXXMBBbupGscCvbfEiyNLgdIub076vZmdA+pebhtuzGdd9EjyVTzEcvIkj/H
	 zyI4hzDuKOsLg==
Message-ID: <b91e4879-e8e6-433b-9859-2a74ee38d199@alu.unizg.hr>
Date: Sun, 7 Jan 2024 16:22:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] selftests: net: increase timeout value for tests
Content-Language: en-US, hr
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 David Ahern <dsahern@kernel.org>
References: <20240107003929.891669-1-mirsad.todorovac@alu.unizg.hr>
 <ZZqd8PqvHlYCqbMX@Laptop-X1>
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <ZZqd8PqvHlYCqbMX@Laptop-X1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07. 01. 2024. 13:49, Hangbin Liu wrote:
> On Sun, Jan 07, 2024 at 01:39:29AM +0100, Mirsad Todorovac wrote:
>> In particular, fcnal-test.sh timed out on slower hardware after
>> some new permutations of tests were added.
>>
>> This single test ran for almost an hour instead of the expected
>> 25 min (1500s). 75 minutes should suffice for most systems.
>>
>> Cc: David Ahern <dsahern@kernel.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Eric Dumazet <edumazet@google.com>
>> Cc: Jakub Kicinski <kuba@kernel.org>
>> Cc: Paolo Abeni <pabeni@redhat.com>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: netdev@vger.kernel.org
>> Cc: linux-kselftest@vger.kernel.org
>> Signed-off-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>>  tools/testing/selftests/net/settings | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/net/settings b/tools/testing/selftests/net/settings
>> index dfc27cdc6c05..ed8418e8217a 100644
>> --- a/tools/testing/selftests/net/settings
>> +++ b/tools/testing/selftests/net/settings
>> @@ -1 +1 @@
>> -timeout=1500
>> +timeout=4500
>> -- 
>> 2.40.1
>>
> 
> FYI, the net-next patch 779283b7770f ("selftests/net: convert fcnal-test.sh
> to run it in unique namespace") has extended the timeout to 3600s.
> 
> Thanks
> Hangbin

Copy that.

Haven't checked the net-next tree, sorry.

As your patch is prior art, then this commit is duplicate work.

Haven't yet found howto follow all the next-trees required to fix selftests,
though :-/ 

Best regards,
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


