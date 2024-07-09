Return-Path: <linux-kselftest+bounces-13368-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23892B96A
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 14:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C18BD1C21EF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCFE158D72;
	Tue,  9 Jul 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="iNEPb9BL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F33155A25;
	Tue,  9 Jul 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528071; cv=none; b=nD9bvEJAotJsFppV+EXyLLZVtM/ezDG22Vj9RbwAd2LU8pLwj07zDnenaIH9mVTqZ5xswRBCq/cMCIymQRcOS6bOtgyJjuZm/dgzSLA3Ofq2KGk/jp1vzIfnsuY4SbpQPaGBCMxcf2N+W9fS1tfuK5NjNyGNcfMZxYbU6MzPY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528071; c=relaxed/simple;
	bh=rddHFdPI15PpKIujuf5oEVmDeSmCYfLpJ11QyQ+fRY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjAKTB6HYRpKXoSsHgagJhAHjELkiG8BB2y0T9oZrWa/gH0SI5+fvRW4le8JL3BIawyl3te82GdzHxrhWvkvaLKXcsb6KO1GL1KYvUcUMQVedJDSIHgd9KHIJiGVr6lVGF4rAKFJYDyrzTBZKWAK36wApdKgFlGN17qvjeAagzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=iNEPb9BL; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1720527976; x=1721132776; i=wahrenst@gmx.net;
	bh=cCtoGEQ65O0NQHMFrW3/EWkn5s4oTQM/d6IPIcz9pxI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=iNEPb9BLGGngXSVlaV2Y5yqu2HXBUZ6ee4wlyeD4jUnl2jxZ3ROfuIaToeyDEeaM
	 ChamxzSRAioqbTQp8qQsUWRZx6LYO2U4TDkJ2WguyL4GeMnS/G2WPcVCWu60zPjyP
	 Vh4/Emn2CN8ZA9ZeReLL81xDo9eDREYSO5sUWQ54kuTiOBFZDGu7jfGWwBGdQDeDh
	 P0LxqK8Qz8LN6ipLHH2iWKLgibppHN4KyaWtS/AgeoRMD1HZazIRu9s+vhbCnSVFp
	 ziqSVnQ3zw9fnW13Q/cp2MCcrQip9PwUViOvp5M446wjyEbd+U4sBFRiCJlvYbaYo
	 HGiM5AnAtFWbi3GPFw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVN6t-1sqlVn12E3-00Oj39; Tue, 09
 Jul 2024 14:26:16 +0200
Message-ID: <6b7cfe69-4f72-490f-8e86-5343bd244a2d@gmx.net>
Date: Tue, 9 Jul 2024 14:26:08 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] arm: defconfig: drop RT_GROUP_SCHED=y from
 bcm2855/tegra/omap2plus
To: Kevin Hilman <khilman@kernel.org>, Celeste Liu
 <coelacanthushex@gmail.com>,
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
 <7hv81f78cy.fsf@baylibre.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <7hv81f78cy.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:Ej+PAwp/ZJkhkceEoIwv6AInmRQiACjrvJFoir5Nuj9E1MJRvQA
 hCU1+y5KPH/WQUoUAj38tdnqg1TsI3WE3557l+L+5Zlw+pyx5u7oihbFKJ0II0kgo4eAkC9
 Qtrhsw6GW7j6n1LaLGg2lE46GZtD/AMneN85Q7N1yqHtfnzmF3zlp8522hgdV6zM7JOCk4j
 tUDmMBQyL0KKRh3tZUkgw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CY3hoQ/VQPY=;5QGFpAHuDX4v0nW4bbrXMcvM2hK
 vYnqvDsWKbcvHPlHjyAu1B7NjXCCKdEydnIkCb02e/O9SFu11zoROqN2443E6DETn+pRJ/ATw
 uC75juahlmOdRef/GIWmgUOF89ZxlNpamUGSRJMbcc/7acV3tyktqOTmeJxlUGm/SM9VqT22Y
 KZP+hHsXJbOD66Y88uvexJJ/bXGM6qzGenJ/FFefNIFQvSg81Mdj0TsYkE44jjuXFP6HOzvR7
 sfK3tUSSa+VOVUCpuVLM/CT9tqP1ebBVbGW8i2F2iJ7ZCF+Abffzz7W0YklTXbVDGZYVtqr6B
 wU4xb4LGpbV+YuwE/Z6CVBsgXktSUuccyUQNSue62AT4J9eibvy9Fg2PZvseBR0pFd8th3MdM
 uAJzeRXqbTBGFlDwJkm836FDmGIeSgXZqToBqD7eb9BKLbEvtEApMusg+8DNNanWvdGfsZqB/
 c/331otTYafTSC5+1UB2wPRsM9VvslvEU1EfZiIJBv2wiWFvAvSrsHoi5ueZYYmqPhfLTCaxF
 IDCbOQZKrbP/vbwSNwJZjo5ew3oOyDqL/o6yn4+Zp6zOM7nXI1D3bvIrxJCrK5gBDnttyqe/E
 bmiYbnssNvUEE7+bNEQ/MPt7xIsDe1kHCOeyFM5/vQeRHncgpuJ10i2uKdpGevOSohr3ghao6
 9oj5jIeHgymEcQEZGDQeesjnPjhwreNbaW2YOd8FW1J8+MQKDdmNUo+Lo/iNHgTBrMtuB3Qil
 xzpqw3ifkOFSoOTrRRPfJ7EZGae7oJ7+jq0FHgCMSeUnAXDBRyAAVyYmc+ks93Us7II8klNBI
 aa5PFxwJb0lP/7+bdAbJrFmCfqj7iq087cOKXyG81KDIw=

Hi Celeste,

there is a typo in the subject line

s/bcm2855/bcm2835

Am 09.07.24 um 01:49 schrieb Kevin Hilman:
> Celeste Liu <coelacanthushex@gmail.com> writes:
>
>> Commit 673ce00c5d6c ("ARM: omap2plus_defconfig: Add support for distros
>> with systemd") said it's because of recommendation from systemd. But
>> systemd changed their recommendation later.[1]
>>
>> For cgroup v1, if turned on, and there's any cgroup in the "cpu" hierarchy it
>> needs an RT budget assigned, otherwise the processes in it will not be able to
>> get RT at all. The problem with RT group scheduling is that it requires the
>> budget assigned but there's no way we could assign a default budget, since the
>> values to assign are both upper and lower time limits, are absolute, and need to
>> be sum up to < 1 for each individal cgroup. That means we cannot really come up
>> with values that would work by default in the general case.[2]
>>
>> For cgroup v2, it's almost unusable as well. If it turned on, the cpu controller
>> can only be enabled when all RT processes are in the root cgroup. But it will
>> lose the benefits of cgroup v2 if all RT process were placed in the same cgroup.
>>
>> Red Hat, Gentoo, Arch Linux and Debian all disable it. systemd also doesn't
>> support it.
>>
>> [1]: https://github.com/systemd/systemd/commit/f4e74be1856b3ac058acbf1be321c31d5299f69f
>> [2]: https://bugzilla.redhat.com/show_bug.cgi?id=1229700
>>
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> ---
>>   arch/arm/configs/bcm2835_defconfig   | 1 -
>>   arch/arm/configs/omap2plus_defconfig | 1 -
>>   arch/arm/configs/tegra_defconfig     | 1 -
> For omap2plus_defconfig:
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
>
>
For bcm2835_defconfig:

Tested-by: Stefan Wahren <wahrenst@gmx.net>

