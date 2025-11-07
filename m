Return-Path: <linux-kselftest+bounces-45151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F7BC41F90
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 00:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CE654E3823
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 23:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED482314B93;
	Fri,  7 Nov 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dDXksjjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD90D312820;
	Fri,  7 Nov 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762558649; cv=none; b=Cr3rnVE7fPPpQFQaOrjapfWqAY712bNJdSMcBnz/LTuU/1R1ZmZwQpzP6HfOzElnN+snIKSw1dQlxe68gOtRc++aCHpmmj2eM/LmO8j3QlTsPZhk8mE0qjAp0h2xWGy8eVP1i4gixNAmMzOCDnCYSCfoaemZp4cQQhpmhM8i/ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762558649; c=relaxed/simple;
	bh=D0NNPWpR++qrShSzv1aC4sQ1DTsXVkK4wHvcpIxLu9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOSEGr4m/VklWJj30ChyexnOYL/yDVZm1C+S2k0ZdP5uY0lNcjRLLjI3D2ISExrt+srQtH80IetUXo/Bw1snV4ijxEufAxVXoqnpWv/Lcl431/vlrnqM39LyeoKHdxEsncBEA8lgdmAS5aZEZLhfEPB0SuBspdxj5FxLZh8GiBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=dDXksjjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCA4C16AAE;
	Fri,  7 Nov 2025 23:37:26 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dDXksjjD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762558644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dKdfc/nifvizPXu6zHyg6q4B2C0WsM/OrjAHPKMoa1E=;
	b=dDXksjjDOnQQAvQYvE1Q2Si/elVheo7rfOJrlpPYzvIjolTh+DWB3ui0oD+WvKtYKtV2Ww
	zVuEO6gqpBzF/6r8WDKVuMQ5M4RaIZEHQGhw8I82WVPVMX5+Ds9rkaDFEbCvWTMYH6NMS3
	UtGxV+9w1jkJbyFOAxboRQuCCIQq60I=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b0f7e3ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Nov 2025 23:37:24 +0000 (UTC)
Date: Sat, 8 Nov 2025 00:37:15 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 17/34] random: vDSO: remove ifdeffery
Message-ID: <aQ6Cq_5kiIXllEoS@zx2c4.com>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-17-97ff2b6542f7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-17-97ff2b6542f7@linutronix.de>

On Thu, Nov 06, 2025 at 11:02:10AM +0100, Thomas Weißschuh wrote:
> -#endif
> +	if (IS_ENABLED(CONFIG_VDSO_GETRANDOM))
> +		smp_store_release((unsigned long *)&vdso_k_rng_data->generation, next_gen + 1);
> +

This is possible because vdso_k_rng_data is now defined in the C source
on all platforms and under all configurations, even if
!CONFIG_VDSO_GETRANDOM means it's null? Whereas before, some config's
headers didn't have this at all, so the #ifdef was necessary?

If so, can you mention this in the commit message?

Jason

