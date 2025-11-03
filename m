Return-Path: <linux-kselftest+bounces-44654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A824C2CEA6
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 16:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 26B00345992
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 15:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B58F3148AB;
	Mon,  3 Nov 2025 15:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oCOt/yZx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="78T2WGDD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA87313E1E;
	Mon,  3 Nov 2025 15:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185247; cv=none; b=azX56O/DX5Wwzzer35NkUiQbTrPFMnnD2rjb7cRsvVjzJWs50i/vjmTyVJMeCpbZqjkxrXZAuDhAbkRjQ4xFuKvvHiyABzNlkyhJGt3RHTZljTzk+N4q0K10odig2XTwKnqAUd0AwL4SZRUDVdYUYkBK5hMFIzSo9lt/2I1nYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185247; c=relaxed/simple;
	bh=CUq91iZmfL7ybTUefBGhpSJkzjoCZzGhB9SDveH9kI0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=giFjwlah9iEzyh4KuWQbjCQZ1OR9vfI50u4sVk8zlPWO2I+1U7jl8409jFINtKRPlsEGLZ8UnXebpe4HzpOIsh8pld6H2JWEVi2rweAE0s/nnapnjTT33a1pdcK0EHJvf16yq0OWkhKCZGPKHYEnLSVLeffzWkvUE50gMrmsh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oCOt/yZx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=78T2WGDD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762185242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txiU9nH6NDUg7uu142wjzcZ60uFEUV73O7o0Rd7dqYU=;
	b=oCOt/yZx3kUvthyRmlZKqoqG4xaLxSanrqzjBuSuGMhK0ADOJIdwmXrgK+thqnkfGMOwZF
	biLdv5N50vZ7OQA9Wz1K+4DGiXnSE0ull+3W6DDwqsKRe7jGwo3hQ9O7xz3mEtCN5xYo6h
	oKBGIuzKxH13tMYYNk49J/fJ7dT9o6meaxM7EmmMHbxFgmenNBMJ4E4mcrA2csMybSs7Iy
	QoraOgR92lpDiilGZjyWrtNCDF7HVmygpfE3Pa7vyhH+DYWdwEfqljn3eAqtC/kr7T45il
	JZvVcxk08oTaX6KlR5tuWm+xg4CmWAC/CmBVVN36FauRUSGSCVviTzGlT01EIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762185242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=txiU9nH6NDUg7uu142wjzcZ60uFEUV73O7o0Rd7dqYU=;
	b=78T2WGDDnkw1/Y9Zii0VTpZZRyUxTVak/Sn/59YxAiAkUqWJQ/81eLe+PFGzq/g7O/QzM+
	rkRtAnHeFhncC/CA==
To: Mark Brown <broonie@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Arnd Bergmann <arnd@arndb.de>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Nick
 Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Shuah Khan <shuah@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Russell King
 <linux@armlinux.org.uk>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Shannon Nelson
 <sln@onemain.com>, linux-kernel@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 23/35] vdso/datastore: Map pages through struct page
In-Reply-To: <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
References: <20251014-vdso-sparc64-generic-2-v4-0-e0607bf49dea@linutronix.de>
 <20251014-vdso-sparc64-generic-2-v4-23-e0607bf49dea@linutronix.de>
 <aQjJNmwniQwwjeBR@finisterre.sirena.org.uk>
Date: Mon, 03 Nov 2025 16:54:01 +0100
Message-ID: <87bjljw1ra.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 03 2025 at 15:24, Mark Brown wrote:
> On Tue, Oct 14, 2025 at 08:49:09AM +0200, Thomas Wei=C3=9Fschuh wrote:
>
>> An upcoming change will allocate the datapages dynamically instead of as
>> part of the kernel image. Such pages can only be mapped through
>> 'struct page' and not through PFNs.
>
> I'm seeing some boot failures on some arm64 platforms in -next which are
> bisecting to this patch in -next.  Unfortunately the diagnostics aren't
> super useful, we seem to just stop making progress in userspace with no
> obvious output.  One sample log from the FVP is:
>
>    https://lava.sirena.org.uk/scheduler/job/2036229#L1268
>
> which isn't super instructive.  Not all platforms seem to be affected,
> I've seen this on at least the Arm FVP, Orion O6 and Libretech Renegade
> Elite.  The diagnostics aren't very clear here but given that I'm seeing
> the same issue and bisect result on multiple platforms it seemed worth
> mentioning.  Some platforms do seem fine.

Can you try

    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso

which is rc1 based and only contains the VDSO changes. That might give
us a better hint.

Thanks,

        tglx

