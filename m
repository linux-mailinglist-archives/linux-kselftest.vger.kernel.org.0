Return-Path: <linux-kselftest+bounces-42000-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36172B8CA62
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 16:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF35D7E58B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 14:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD80D26E16F;
	Sat, 20 Sep 2025 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IuOAYaht";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LiyXhnJE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C169F183CC3;
	Sat, 20 Sep 2025 14:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758379062; cv=none; b=AwGgvVPaKJUfHrlvIXECAV81UuEsGWIyLHeje5XxXnUIRBk4HIASB4A1/HoMXZxp/SDBZPdDP0zmsZbkfG3v3CNmcIV+QgC3GOhik1onfJjbef4by+jpx/6tiApeORYUxIZI+kgP1dKrA7ezCvmva4mf7SLiTVOPNakJacuMzz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758379062; c=relaxed/simple;
	bh=zl7kC1EIRM1bovNYL1w209PeOAD8n12bCeV2ctXIJKA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=TRoYLu4UAKY5N66jitA5cMA+18o1feD19y4vSBMEYjTvL+PJrfjApdRtnnG2181++k7sk0Bz4hj+OF6w9gWF3YjCqcaTKCKjWPLjUXclGfvhGoA4pT5aEwByj7T+IpKxxqhEqHQ4sUfWpxfCPlAJ+F7e4knUlboiInc+nhWBfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IuOAYaht; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LiyXhnJE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:37:31 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758379058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl7kC1EIRM1bovNYL1w209PeOAD8n12bCeV2ctXIJKA=;
	b=IuOAYaht68bYkyaAnw8mBbLpF0dn3cHPZYb3bHY/9Qnt9yej59kdqYZJUWNbDzZGSJ3TIy
	vjrvCVj7pN9urWJ8vbE7f5Y7s06j1F7C25eooUUWlI/++co+NpbE+0c3O9gU8JhqiQ4SOp
	nEr9GIBlux69WP9tMhPFg67LTHmTvdVHi2p9ozbkfo80InufXiIgLtH8e3RsPcupcPYRP2
	nssGv7o6Yg5ve4IE1rmDb+lFxtqdTCMXnzYxTXl6UFFDzvLF6IKJDyxsjpNQs2JoC30EGY
	l4VSzJrhtm6l5eUJHa5gMp4mr91o6zftCBBdh0zhww52FxDcaykrwIYDsaTHpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758379058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zl7kC1EIRM1bovNYL1w209PeOAD8n12bCeV2ctXIJKA=;
	b=LiyXhnJEAMLAmv3dP0IXuri7G82RDp9AQI+GKRfiI7mQ/gNlgkAkJhXcdz7geMJwt+zvtQ
	OagdT5Ug6EumENCg==
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org, Arnd Bergmann <arnd@kernel.org>
Message-ID: <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de>
In-Reply-To: <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de> <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v3 00/36] sparc64: vdso: Switch to the generic vDSO
 library
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de>

Sep 20, 2025 15:25:11 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.=
de>:

> On Wed, 2025-09-17 at 16:00 +0200, Thomas Wei=C3=9Fschuh wrote:
>> The generic vDSO provides a lot common functionality shared between
>> different architectures. SPARC is the last architecture not using it,
>> preventing some necessary code cleanup.
>>
>> Make use of the generic infrastructure.
>>
>> Follow-up to and replacement for Arnd's SPARC vDSO removal patches:
>> https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
>>
>> Tested on a Niagara T4 and QEMU.
>>
>> This has a semantic conflict with my series "vdso: Reject absolute
>> relocations during build". The last patch of this series expects all use=
rs
>> of the generic vDSO library to use the vdsocheck tool.
>> This is not the case (yet) for SPARC64. I do have the patches for the
>> integration, the specifics will depend on which series is applied first.
>>
>> Based on tip/timers/vdso.
>
> Could you share a version of the series based on top of 6.17.0-rcN for
> testing purposes? I would like to test the series on a Sun Netra 240
> which is based on the UltraSPARC IIIi.

Here is the git branch based on rc4:
https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.git=
/log/?h=3Db4/vdso-sparc64-generic-2

Does that work for you?

Thanks for testing!

Thomas

