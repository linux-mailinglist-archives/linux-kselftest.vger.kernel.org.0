Return-Path: <linux-kselftest+bounces-46061-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 102C8C72436
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 06:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C298434F8B3
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD55F2FFDFB;
	Thu, 20 Nov 2025 05:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="Eok4QOlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F219F30102F
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763617234; cv=none; b=OVAYLhEiY/enX3ldn8TPGkCPnqtXNf6JqMhFl86t1Yp3bGnKgmAxWmjmytZ9aJRHSN6jKT14YBqAWm65NFsG8k2enjplnwMJo2RZD/gHbWAz2wjyufozONJ1dZpi2ylQ2+YZeuQhbRwS/qIHdcCGaTgEDDzYKoA5npxznIt0U2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763617234; c=relaxed/simple;
	bh=AS2zQnqedhL3ve94IZZQDSA5cCEKJhL2aq0tdbw1za4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aj7ZAWV/FhsSmbPhPU/7k5fSWDHLW7sYGLsdkzQ/mZ7QnisqBru5vHDPFiJTNtaLpdj+GZumo7B8zBwc0bkbxZ6YSHzjYrUGgwzMXxOoMEXy/75iX8CnEnzi4OV3jspjIOWUlxGQtyq3zCVUritcLwo+WG/HzrZ4UsXU8+qTrW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=Eok4QOlZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6419b7b4b80so596688a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 21:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1763617231; x=1764222031; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dK/TZoBnuzuAgeT3RH6Vn9CDIGfrgo8wHcMBTPkWjc=;
        b=Eok4QOlZM89ZvwKeYGw6H0fKOiUqDDyxqjYjicxGL+F99rkl24kZnCxn1H4FGhNTm7
         hZ2F2gDHE/c2zcIBhOBrKK3vGgAUYSoSbhBfv/BIIE2okQIai90y1YUCjbz4heXC09CZ
         Yi7SqxyaRDAmzkHU9e89HuXt54BsNPXXOiX6K2ZZvSYkwDIvHkni/9Wc3VK6I6zJC8hO
         5xOsqkojHkaCd6wxXnBVy/GlIuhL+p95x9wTLh9H2Be0/F9eZXN3RQEorGXopY1Ia0k4
         4dr1j6nb55JN8MgGaiZ9r/EeHm/oCFQFEX8OmYvMmg3aMbuc/fJQE8jO7m9i85iDxMxg
         0eHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763617231; x=1764222031;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7dK/TZoBnuzuAgeT3RH6Vn9CDIGfrgo8wHcMBTPkWjc=;
        b=wQWkuLKJxPl0fLGJjIGshUmJiuGQWd1y8IxJSXC8eB/IZ/2CBglBDrAQGNidG2mFHv
         QW7ka4OWvRxFzzbjmkhgWBXchRplxLe8709BQ45wWsXM3xcoKaJ8Q8PsGwE35HBD9ifL
         0Bu5Hk1fF/HDEm6chx9/4f45wxq3+ppfsAFU65CkfJu/mejXXjqWzzUMKmuNtcs0b6Oz
         vJ1mf99H9PxEQeGm4Rrn845OF5i7vJsu6IofiZjF5iiYy67qPYd7Q5BB17hu6m4AnWUp
         fpS9KHTq89pmZVBbe6F3Tl21KqevE9dQHdldBRPvCMjw4XbkkzyxSpKZGX1zDXSYPig6
         X1qg==
X-Forwarded-Encrypted: i=1; AJvYcCXKwYt5X22lNb3BcCsuVV4ZxciEnFPgNfPp2+YINTYVrOt/prKOqnE41FYENzxVA76+zij8HdjGYAZQzhAUgDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlT3c7eacNx7GqF+FnIjgslRAtQrFHvu0ak/ze3OoXhcTjt295
	Hs1XYbF5Vu5Fp0Gs4+RfyeTtIv3w6ujwk7oPHwGCzMj9I4UBcu7eik2UwknSeTdNf5HlHr1VLwi
	d6ZVc8FEYwOGEoYWkF20oQviS5D/AhMZrae6hngsZTQ==
X-Gm-Gg: ASbGncuO6Etvpy+lygI11VyRgahdRg063Bvap5/UOz2re/iiCOGivdDc3EQmiJAGZqt
	uqYBlOsUP4kVjAhJPEuIfxNXB878uMjdge3YacvP12VeiNZaD65E7KXG5VRyOUgU3Q8U9CwF05B
	RcFKc293KqFbbkRWXIEkc7GlMHmEvox5LIZZOiqiv7Tvlpa43mSOKidSOBbptD4WzyCnNXgYxpk
	to+yCwLnk+FH4U7fA1/azz1ZOrqleBEM+6RLbA1KnPsx/4G+i0eXfXLm00aXpKmPd4Khg==
X-Google-Smtp-Source: AGHT+IFd4ZD8LO3gWA0tYoGo49H3rk4bG8UV2Nu8f5cyi48eyODapZFusRvqrzWLi1Ytu9FzHhwORQyO09cagbntAK0=
X-Received: by 2002:a17:907:7f01:b0:b73:70db:49ab with SMTP id
 a640c23a62f3a-b76553fa23bmr176598566b.35.1763617231293; Wed, 19 Nov 2025
 21:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119105216.1675608-1-zhangguopeng@kylinos.cn>
 <20251119122758.85610-1-ioworker0@gmail.com> <2c276ed9-626f-4bae-9d42-727dd176ec74@kylinos.cn>
In-Reply-To: <2c276ed9-626f-4bae-9d42-727dd176ec74@kylinos.cn>
From: Leon Huang Fu <leon.huangfu@shopee.com>
Date: Thu, 20 Nov 2025 13:39:53 +0800
X-Gm-Features: AWmQ_bmEoAEKzhLFdmzN3VkYMFPpl9dZhwR3SWWzVK97oW1lQq-769I_C_Td8qw
Message-ID: <CAPV86rqXrf027nLZocq2Acqf5T=YJY2Uj3MD1OrGG7DAUqkxzA@mail.gmail.com>
Subject: Re: [PATCH] selftests: cgroup: make test_memcg_sock robust against
 delayed sock stats
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Lance Yang <ioworker0@gmail.com>, hannes@cmpxchg.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	mkoutny@suse.com, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, shuah@kernel.org, tj@kernel.org, 
	Lance Yang <lance.yang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 10:12 AM Guopeng Zhang <zhangguopeng@kylinos.cn> wr=
ote:
>
>
>On 11/19/25 20:27, Lance Yang wrote:
>> From: Lance Yang <lance.yang@linux.dev>
>>
>>
>> On Wed, 19 Nov 2025 18:52:16 +0800, Guopeng Zhang wrote:
>>> test_memcg_sock() currently requires that memory.stat's "sock " counter
>>> is exactly zero immediately after the TCP server exits. On a busy syste=
m
>>> this assumption is too strict:
>>>
>>>   - Socket memory may be freed with a small delay (e.g. RCU callbacks).
>>>   - memcg statistics are updated asynchronously via the rstat flushing
>>>     worker, so the "sock " value in memory.stat can stay non-zero for a
>>>     short period of time even after all socket memory has been uncharge=
d.
>>>
>>> As a result, test_memcg_sock() can intermittently fail even though sock=
et
>>> memory accounting is working correctly.
>>>
>>> Make the test more robust by polling memory.stat for the "sock " counte=
r
>>> and allowing it some time to drop to zero instead of checking it only
>>> once. If the counter does not become zero within the timeout, the test
>>> still fails as before.
>>>
>>> On my test system, running test_memcontrol 50 times produced:
>>>
>>>   - Before this patch:  6/50 runs passed.
>>>   - After this patch:  50/50 runs passed.
>Hi Lance,
>
>Thanks a lot for your review and helpful comments!
>>
>>Good catch! Thanks!
>>
>> With more CPU cores, updates may be distributed across cores, making it
>> slower to reach the per-CPU flush threshold, IIUC :)
>>
>Yes, that matches what I=E2=80=99ve seen as well =E2=80=94 on larger syste=
ms it indeed
>takes longer for the stats to converge due to per-CPU distribution and
>the flush threshold.

Me too.

I previously proposed a potential solution to explicitly flush stats via
a new interface, "memory.stat_refresh" [1]. However, improving the
existing flush mechanism would likely be a better long-term direction.

Links:
[1] https://lore.kernel.org/linux-mm/20251110101948.19277-1-leon.huangfu@sh=
opee.com/

Thanks,
Leon

[...]

