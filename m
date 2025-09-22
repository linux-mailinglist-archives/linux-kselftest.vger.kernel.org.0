Return-Path: <linux-kselftest+bounces-42043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC605B8ECF6
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 04:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 847AC179B74
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Sep 2025 02:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E812318DB37;
	Mon, 22 Sep 2025 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgX4zQG9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4A31547CC;
	Mon, 22 Sep 2025 02:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509062; cv=none; b=mWJrCsJOt6QXCtileceQF5DJDYMRj2OUFSmDFzTZU1sNuD8DeHAPLxMWuQpHpqlqJjuGz8JnrqUcYK8SXaQJwfiC69VA7vIMrndBcEe9Q4tzb7n2fnxEndZUXjXmjact64HY5ZZfTpdEcRUJGB2/PYV4HvXiqDjCGHmkgKuXfrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509062; c=relaxed/simple;
	bh=i9vAa0AsWTqSQzz6uFyc7VXVf8ZJ7QlTL9Ja3Bg/hgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CdIJ5aJruR1KvkHWp2rUC+G2S2acSkJxfzI4WMKFqw6vWPGXZJKlIiv62I51RV+RCJCEmS1ho++emt2wbeezj6q+Ic7frlAduMghisDFoBslumYZtqm9ZCMz2nzHm5pZkfNH83vCrBPjultrSFCN0z0yYYr3m5woCZtWY2s8FUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgX4zQG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F6C4CEE7;
	Mon, 22 Sep 2025 02:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758509061;
	bh=i9vAa0AsWTqSQzz6uFyc7VXVf8ZJ7QlTL9Ja3Bg/hgg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kgX4zQG9Ggek7o49bHXrtRIo5kLI9byQA1VGrO0g2NhIfgF+O7g3DmNB4VQlWu1RU
	 rvn5Ng1I/gwc6uqXQlAM/GSftBSoRv2cs1GgW98+sggq0LEaVHB/4xzRlQDOEBTq1V
	 1JYbrUBIXkWzk+Fxrb0Sh9GHTmuk2EE+mV4Erfh9IKaJWfsdSPKF2RmfatCJ5ey+OJ
	 pKeM2giE9tz2rFVxxjrnv7iaAggC9I9+OA/rkyeZeNdXzU1EZLtTCagulCOYZflJrI
	 fxVswkLQWeowr2MiQl8Ix33L2RboXxqNbIRe1zX9vbj1iHayNHW05Rw5FrDBFRHP5w
	 e32O7vOprApgQ==
From: Michael Ellerman <mpe@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>, Thomas =?utf-8?Q?Wei?=
 =?utf-8?Q?=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nick
 Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King
 <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle
 <svens@linux.ibm.com>, Nagarathnam Muthusamy
 <nagarathnam.muthusamy@oracle.com>, Shannon Nelson <sln@onemain.com>,
 Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 07/36] powerpc/vdso: Explicitly include
 asm/cputable.h and asm/feature-fixups.h
In-Reply-To: <41d100c5-4706-400e-a61a-46b068f1bc74@csgroup.eu>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de>
 <20250917-vdso-sparc64-generic-2-v3-7-3679b1bc8ee8@linutronix.de>
 <41d100c5-4706-400e-a61a-46b068f1bc74@csgroup.eu>
Date: Mon, 22 Sep 2025 12:44:18 +1000
Message-ID: <m1348fmcjh.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 17/09/2025 =C3=A0 16:00, Thomas Wei=C3=9Fschuh a =C3=A9crit=C2=A0:
>> The usage of ASM_FTR_IFCLR(CPU_TR_ARCH_31) requires asm/cputable.h and
>> asm/feature-fixups.h. Currently these headers are included transitively,
>> but that transitive inclusion is about to go away.
>
> Hum ...
>
> That was unexpectedly added by commit 9c7bfc2dc21e ("powerpc/64s: Make=20
> POWER10 and later use pause_short in cpu_relax loops")
>
> In theory, vdso/ headers shouldn't include any headers outside of vdso/

Oops, looks like that was my fault.

It's expected that there can be feature fixups needed in the VDSO,
vdso_feature_fixups() handles them, so that's OK. But the headers
pulling from outside vdso is a pity.

Still this patch is fine as-is.

cheers

