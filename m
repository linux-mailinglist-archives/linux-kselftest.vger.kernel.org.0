Return-Path: <linux-kselftest+bounces-25218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C94AA1D246
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 09:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E36B188217B
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 08:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7341684B0;
	Mon, 27 Jan 2025 08:20:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA63E158536;
	Mon, 27 Jan 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737966007; cv=none; b=E31XdNBYAPq7ivxrXWMG2PJwZL8al1ehWfWdJr2h5P/hJuHX6KoOLQZdiGHm5k3dFeTAtLNvWL2dj0mo+9/UD1Z/b3eSki2kojbA4EVatKIWjLD6MDXq1025zfQ6YqvEGKiwdvyrJpQF/0NIz2pRR0DBR9g6yDQ6trMb167IfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737966007; c=relaxed/simple;
	bh=bPZrzL8F/X/6LY7LtJeduI/HHZBw9qT9omhJf48ztqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvahShZn6qkr3qVZaD7pgZD2rVLB4P0QycQqIY66MGR33IssCesWYqw7mjN/JYXrFo4AtqTLXMlaySLRFw67dQ72bW1spMryXfbfbMSDx1+IpzUMXpnnTUO5NKaaQgReyNY14iSnD5aoPEKGtwnbCJnkX9z3xgjppmjHbDy1qHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4YhLWP1zgQz9sS8;
	Mon, 27 Jan 2025 09:02:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F2OxG-fQcyBS; Mon, 27 Jan 2025 09:02:57 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4YhLWP1DBFz9sS7;
	Mon, 27 Jan 2025 09:02:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 194E38B764;
	Mon, 27 Jan 2025 09:02:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id yuRUAW82lOiU; Mon, 27 Jan 2025 09:02:57 +0100 (CET)
Received: from [192.168.235.99] (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A9D078B763;
	Mon, 27 Jan 2025 09:02:56 +0100 (CET)
Message-ID: <d85f9c94-249a-4847-a323-2f547fe60732@csgroup.eu>
Date: Mon, 27 Jan 2025 09:02:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: Fix undefined CLONE_NEWTIME by including
To: Purva Yeshi <purvayeshi550@gmail.com>, skhan@linuxfoundation.org
Cc: shuah@kernel.org, Jason@zx2c4.com, liaoyu15@huawei.com,
 broonie@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250126105932.63762-1-purvayeshi550@gmail.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20250126105932.63762-1-purvayeshi550@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 26/01/2025 à 11:59, Purva Yeshi a écrit :
> [Vous ne recevez pas souvent de courriers de purvayeshi550@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> Fix the build failure caused by the undefined `CLONE_NEWTIME`.
> Include the `linux/sched.h` header file where the function is defined to
> ensure successful compilation of the selftests.

This is supposed to be already fixed by commit 34d5b600172b ("selftests: 
vDSO: Explicitly include sched.h")

Can you explain what is the exact problem still ? And why linux/sched.h ?

Did you properly build kernel headers before building selftests ?


> 
> Signed-off-by: Purva Yeshi <purvayeshi550@gmail.com>
> ---
>   tools/testing/selftests/vDSO/vdso_test_getrandom.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index 95057f7567db..b2c9cf15878b 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -29,6 +29,8 @@
>   #include "vdso_config.h"
>   #include "vdso_call.h"
> 
> +#include <linux/sched.h>
> +
>   #ifndef timespecsub
>   #define        timespecsub(tsp, usp, vsp)                                      \
>          do {                                                            \
> --
> 2.34.1
> 


