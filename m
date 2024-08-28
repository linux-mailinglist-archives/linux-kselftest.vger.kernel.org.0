Return-Path: <linux-kselftest+bounces-16565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F18962DE7
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 18:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7EA1C23C41
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 16:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB8C1A38CD;
	Wed, 28 Aug 2024 16:54:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF09154C0C
	for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2024 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864057; cv=none; b=M2xuStnS+8OZVsJHPg2KaLNWqe/f0nwYRr0IHmuPGMXL+NkCDy4y/aL7wCSgURjKpXsiId8MDKeiOwcrXhgLqckMNNW3BhrhoQGZzWSnV+Qm8gJcCU+JqFUJtsIAabn/UkXj3FXI3iviXrA4EXFy9+foLXq6RMiU1vIty3unDx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864057; c=relaxed/simple;
	bh=OWSWS8E99AdPqzxcHlZVoi8wyO1k4UOIfJwrQfCRlYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+/6bJaydPxGoHAIrL/SlKeuOBAzVBBZvwJNSgUT2ZW5wGj5RHOVA3Z9qckcfQJmaPjMFvXaUtvSB+JiRNgGcM1tN5vownGxNkgf5MvVdtGuopX21vUsJfsNgv3Pq0AkuWmSVwsVt3Rr7FGWl+wjFJq8b7EpmSq1ceqyjc7R91E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wv9VX5GFGz9sSC;
	Wed, 28 Aug 2024 18:54:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pGlZh_vARYLc; Wed, 28 Aug 2024 18:54:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wv9VX4WZLz9sS8;
	Wed, 28 Aug 2024 18:54:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8BF658B78F;
	Wed, 28 Aug 2024 18:54:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 3uwrguhjylF0; Wed, 28 Aug 2024 18:54:12 +0200 (CEST)
Received: from [192.168.234.6] (unknown [192.168.234.6])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4B9248B764;
	Wed, 28 Aug 2024 18:54:12 +0200 (CEST)
Message-ID: <5102deef-663d-46ea-890a-6efc8e451f68@csgroup.eu>
Date: Wed, 28 Aug 2024 18:54:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/vDSO: open code basic chacha instead of linking
 to libsodium
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "xry111@xry111.site" <xry111@xry111.site>,
 "adhemerval.zanella@linaro.org" <adhemerval.zanella@linaro.org>
References: <20240828135510.3414909-1-Jason@zx2c4.com>
 <64761aa8-123b-4eeb-890a-855d0a0f8755@cs-soprasteria.com>
 <Zs844SsY-zP2kSTc@zx2c4.com>
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <Zs844SsY-zP2kSTc@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 28/08/2024 à 16:49, Jason A. Donenfeld a écrit :
> Hi Christophe,
> 
> On Wed, Aug 28, 2024 at 4:38 PM LEROY Christophe <christophe.leroy2@cs-soprasteria.com> wrote:
>> -               key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7]
>> +               le32toh(key[0]), le32toh(key[1]), le32toh(key[2]), le32toh(key[3]),
>> +               le32toh(key[4]), le32toh(key[5]), le32toh(key[6]), le32toh(key[7])
> 
> Are you sure about that?

I'm sure it is needed to get the same behaviour as before.

> 
> So I don't see any endianness conversion happening with the key bytes.
> They're memcpy'd from rng output bytes directly into native endian u32
> words.
> 
> You may have an objection to this. But the goal of the vDSO code is to
> match the kernel's algorithm 1:1 without deviations. To that end, I
> suspect this patch actually improves the unit test to ensure that.
> 
> With regards to your objection, though, if you feel strongly enough
> about it, I suppose that's something you could attempt to change
> throughout, with one commit that touches random.c and the vDSO code. I'm
> not sure whether or not I'd go along with that yet, but if it were to
> happen, I think that's the way to do it. For now, though, the goal is
> for the vDSO algorithm to copy the kernel algorithm.
> 
> Do you agree that this patch helps the vDSO algorithm copy the kernel
> algorithm better? Genuinely asking, because maybe I got it all backwards
> somehow.
> 

As I said several times, I was a bit puzzled by the fact that I had to 
read key words in reversed byte order when I implemented the powerpc 
chacha20. This was needed to get the selftest succeed. So if doing it 
the new way makes it closer to the kernel implementation, I'm 100% fine 
with it, it will also slightly simplify powerpc chacha20 vDSO function.

The only thing is that you must describe this behaviour change in your 
commit message, you can't just let people believe it is a one-to-one 
replacement of the previous test implementation that used Sodium.

Christophe

