Return-Path: <linux-kselftest+bounces-42167-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A337B98C1D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 10:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAC42A5B77
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Sep 2025 08:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C71927FD7C;
	Wed, 24 Sep 2025 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="31Omeb15";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9aMu2nr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E2D44C63;
	Wed, 24 Sep 2025 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758701266; cv=none; b=hsw4IzJrTARJ9trTGUqxU8Qao+JVlCMVkeiHqC3NSAKWR1iHr3HNMHVUD+6MhhVLSZC6AgEHFnGGlIQjoNgyTKb6juOqgnHu+ATr/ufn1jV7Q8G++EBDr7vPcWCAy6AgpkmOIDLeG6TrYU8ZKTdohWL+3O/923CTmjlCiOiryuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758701266; c=relaxed/simple;
	bh=QgLVMteIPJ+pMUDeTmzYpa0Om88x4SzL6ygbBAQMfig=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Df5c11VGFLTUyE2PZuFOLwh0Ghy5w2sC4ERpH5geAsRV+3ofUqKfuWcjMouJUz+ctjJGz4TJXswO+o15SsIyE0REumaiiWTopvZ+ysgsI9EgYcSyjfflaZo68Dorz9sVwqYmsyHokTbaxlXS5ZVQs3g+aPmHZfwBijTIgIbbRck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=31Omeb15; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9aMu2nr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 24 Sep 2025 10:07:36 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758701262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgLVMteIPJ+pMUDeTmzYpa0Om88x4SzL6ygbBAQMfig=;
	b=31Omeb15YqChHkBBrePL7NG3JD983FRx11Q5uWT/69RIupuUYdoTYmGARAlJia6NlrrGQN
	5bccvQRhu9NcTZtmvjlgyrvdEj5A1CDs8zthnojoVFXb7nQgs5SpXbO8rV9L4e+rwnpaCO
	ua2jL9ZurCRzeQvEx0XtMCN7QuKSfAfEmHL2Y+sW7stPznDDzQHvTqbRTdGYko3+/T12ye
	j1+Ro5mKKD/7GFoBxJzLa4UvxffzbMiluz2XiPl0kMDb4Rznzr4zg9+LVFIMxv9nAN+P3+
	XSkEVbGVGFCipqBlQpFNsRbuwLO+4Us4XFeGg8YiuoKCqT4LwQxWTqtgvVs2Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758701262;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QgLVMteIPJ+pMUDeTmzYpa0Om88x4SzL6ygbBAQMfig=;
	b=n9aMu2nrfU7/A2LOU0ndnoE+3K8jSV2X1C4MQa1OTm1DcYDn9hSt6n0FuxlpuJtK/TUJKn
	tCL0hbarV8eUGJBg==
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
Message-ID: <bea9cc5c-7fc6-4c87-ab78-8232b2bee4dc@linutronix.de>
In-Reply-To: <60a0af09cc1a5de3b33b9606ed07ae91b42c5432.camel@physik.fu-berlin.de>
References: <20250917-vdso-sparc64-generic-2-v3-0-3679b1bc8ee8@linutronix.de> <9a122c6cf3e2e0e61a62b0512eb97804acebeee9.camel@physik.fu-berlin.de> <48fd164e-959b-4263-b3c7-cef5771aa40a@linutronix.de> <60a0af09cc1a5de3b33b9606ed07ae91b42c5432.camel@physik.fu-berlin.de>
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
X-Correlation-ID: <bea9cc5c-7fc6-4c87-ab78-8232b2bee4dc@linutronix.de>

Sep 24, 2025 09:40:47 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.=
de>:

> Hi Thomas,
>
> On Sat, 2025-09-20 at 16:37 +0200, Thomas Wei=C3=9Fschuh wrote:
>>> Could you share a version of the series based on top of 6.17.0-rcN for
>>> testing purposes? I would like to test the series on a Sun Netra 240
>>> which is based on the UltraSPARC IIIi.
>>
>> Here is the git branch based on rc4:
>> https://git.kernel.org/pub/scm/linux/kernel/git/thomas.weissschuh/linux.=
git/log/?h=3Db4/vdso-sparc64-generic-2
>>
>> Does that work for you?
>
> I'm getting merge conflicts with "vdso/datastore: Allocate data pages dyn=
amically" and
> "vdso/datapage: Remove inclusion of gettimeofday.h".
>
> Can these be skipped?

No, these are important.

What are you trying to merge?
I can probably give you a merge.


Thomas

