Return-Path: <linux-kselftest+bounces-13369-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B57D92B9D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024561C21F98
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F234D15A85B;
	Tue,  9 Jul 2024 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIikM0H5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A67615A842;
	Tue,  9 Jul 2024 12:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720529152; cv=none; b=hc1V7wj7aoDtnm+yplgp3MoOWu+sBRsDDcuqKUOn31QBj5moQXosPUOt0mQTtDyxTC3Hkn4WDADH7vWDynK/ky44VJTUXKGM3zo2IGxO7LXy5ERY6WCabBposX1KX2MuJcZXjxMQ0gRz7P1lb/wN9tmmNmxNrzVhe1VWU5hbJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720529152; c=relaxed/simple;
	bh=O9QjD7xyf7LdxqfElfMDNMZgFewgPFqt+hOvv1SP8XI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OtY/plGUApt6O/OeZFvTDUJHmHgx2Navn5u8nhPYzfYCoZaSOGfyPP/D4SQ3v8hYi//OZvdtMiU2PgYxVJQiSDEddfS7ltEWKVlLApEq+j3OyLMdpBptNDXThZComdjiFhBCa3l9j/ilOoKB1t53D66NH8O5f+yUzMR+Jjvs8FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIikM0H5; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1fbc3a9d23bso1289325ad.1;
        Tue, 09 Jul 2024 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720529151; x=1721133951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PTkMABYzGdhSQd9C4loTDYzycJLf8ODZaPM06fmE3pI=;
        b=IIikM0H5UrtnuFPA57JXL9YMX2Bnr2fr/uNixCz7mgKWxo4c3iJagAhzt/gKN57Eqs
         6haXH8/2RRmAUA9n8rMSBZO/c8rlXiW7vQOkfd3AwVGgf+xg04xRjfc5PFyj51GvefET
         7bog2suMhMQdpkZzFW/fvsznuqSonGboPW6gRidgIHfbBQQ+ibfM/zZ+AIm5xNtaBIHG
         sL+F1wIF7qVmLxKCAWYNfG8khXcYWdaEE2HCk/+OszhjJonOUJ+Cp2LWMYMv0ANgkRAY
         Yh87bKeiawkMVnhAYaBOHgGbFMtj6Fj83OXeKkzeHYsN1NY/qJAl+q6byVKkQkUPjsaX
         yAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720529151; x=1721133951;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PTkMABYzGdhSQd9C4loTDYzycJLf8ODZaPM06fmE3pI=;
        b=N9kFDzpzym0l9lrm1o33e/GJCxpTFlFk3RA0e6h85iik7C6wPJw4+ExvfbTiFQLZvC
         JKiTZUYwxDMYrE6tWgKWmrDy8AjH36COoVw6EFwKD1d4ghnOHXnDrNItIzTEA7XyXId3
         nX/GsiJFmXP9kdLij0/OZWzt8Zvo0c9Fa5wpDTmIw+0qxKkk4cWw56Xk4M9fxXvXXu+J
         SzojyJRzrURqHrv7F/I4BI9y1ehe1G4Zba2zNWoJ1vErt4RKLZkINZkmlMW7E0VwSVR+
         oQb4+FN/B2NWSS3pA1UIs8mBRPQ0Y31P5TpIGExFy4RVKyn7vDVa1Hfzoef2ERMnCLHb
         Fcnw==
X-Forwarded-Encrypted: i=1; AJvYcCW2ip2Y0EKRmjMFirZE+AoAc17O6qOZYuqmLjctwPNhDYj0OswSwbAGkHRwQcEG2wOkoyKLTrKq9+yR62jMEjbQhKnxfUT/1So0ge77qnupeW1R8wfrBe56BgR4iiILOXjr8Y+PuHnHcZPasp9C1/4b/5Vz3J+tokG+h/GLJqvOrl4q3WVNnJDUhcBasfwft15XSMK0FZDwFD1ZCzlzkePpVin8mPL6YuV/ZHnq0neQRt30F/gXy2bM9vbku7k60dRHfBlMySA7zY489ghHP45u
X-Gm-Message-State: AOJu0YzkXgpFE1ya4w+TRtgsyJtaDYqaKHq9sFmd3nY7CH9aYS4jlHpI
	rQepCXr68VpiZkK8vHEjratWhBucyviYngOyphhEogdQ0DS1hhXh
X-Google-Smtp-Source: AGHT+IFOaJNRaCw0x5duAR8ySF29N2zLhsw5jMvf8ySrYnWHRx3vmy5Ah54KY0oG4A60mrkmNodEQw==
X-Received: by 2002:a05:6a20:734b:b0:1be:caf6:66e5 with SMTP id adf61e73a8af0-1c29820d407mr2618980637.6.1720529150564;
        Tue, 09 Jul 2024 05:45:50 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6acf9a3sm15241475ad.255.2024.07.09.05.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jul 2024 05:45:49 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <44535d2d-c95d-4673-b845-032669cf7abf@gmail.com>
Date: Tue, 9 Jul 2024 20:45:38 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: defconfig: drop RT_GROUP_SCHED=y from
 bcm2855/tegra/omap2plus
To: Stefan Wahren <wahrenst@gmx.net>, Kevin Hilman <khilman@kernel.org>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>,
 Icenowy Zheng <uwu@icenowy.me>, =?UTF-8?Q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>, Sven Joachim
 <svenjoac@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Anup Patel <anup@brainfault.org>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Rich Felker <dalias@libc.org>,
 Russell King <linux@armlinux.org.uk>, Tony Lindgren <tony@atomide.com>,
 Guo Ren <guoren@kernel.org>, linux-tegra@vger.kernel.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-riscv@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-omap@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
 linux-sh@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-mips@vger.kernel.org, loongarch@lists.linux.dev,
 Mykola Lysenko <mykolal@fb.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Paul Walmsley <paul.walmsley@sifive.com>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-rpi-kernel@lists.infradead.org, WANG Xuerui <kernel@xen0n.name>
References: <20240530111947.549474-8-CoelacanthusHex@gmail.com>
 <20240530111947.549474-14-CoelacanthusHex@gmail.com>
 <7hv81f78cy.fsf@baylibre.com> <6b7cfe69-4f72-490f-8e86-5343bd244a2d@gmx.net>
Content-Language: en-GB-large
In-Reply-To: <6b7cfe69-4f72-490f-8e86-5343bd244a2d@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-07-09 20:26, Stefan Wahren wrote:
> Hi Celeste,
> 
> there is a typo in the subject line
> 
> s/bcm2855/bcm2835

Will be included in next version.

> 
> Am 09.07.24 um 01:49 schrieb Kevin Hilman:
>> Celeste Liu <coelacanthushex@gmail.com> writes:
>>
>>> Commit 673ce00c5d6c ("ARM: omap2plus_defconfig: Add support for distros
>>> with systemd") said it's because of recommendation from systemd. But
>>> systemd changed their recommendation later.[1]
>>>
>>> For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarchy it
>>> needs an RT budget assigned, otherwise the processes in it will not be able to
>>> get RT at all. The problem with RT group scheduling is that it requires the
>>> budget assigned but there's no way we could assign a default budget, since the
>>> values to assign are both upper and lower time limits, are absolute, and need to
>>> be sum up to < 1 for each individal cgroup. That means we cannot really come up
>>> with values that would work by default in the general case.[2]
>>>
>>> For cgroup v2, it's almost unusable as well. If it turned on, the cpu controller
>>> can only be enabled when all RT processes are in the root cgroup. But it will
>>> lose the benefits of cgroup v2 if all RT process were placed in the same cgroup.
>>>
>>> Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn't
>>> support it.
>>>
>>> [1]: https://github.com/systemd/systemd/commit/f4e74be1856b3ac058acbf1be321c31d5299f69f
>>> [2]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700
>>>
>>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>>> ---
>>>   arch/arm/configs/bcm2835_defconfig   | 1 -
>>>   arch/arm/configs/omap2plus_defconfig | 1 -
>>>   arch/arm/configs/tegra_defconfig     | 1 -
>> For omap2plus_defconfig:
>>
>> Acked-by: Kevin Hilman <khilman@baylibre.com>
>>
>>
> For bcm2835_defconfig:
> 
> Tested-by: Stefan Wahren <wahrenst@gmx.net>


