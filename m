Return-Path: <linux-kselftest+bounces-45155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B01C4215F
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 01:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 489C91897EBC
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 00:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0E204C36;
	Sat,  8 Nov 2025 00:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BHbRrzGJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8608225D6;
	Sat,  8 Nov 2025 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560050; cv=none; b=Y5juCGiJsjg0Kd/VKexZSOS/jjO/pH6Yi4715pHe5boyizxKuWfC7Mji1aR5cxKVe2+yTnxeVkwv1bRVbOXzSMAaGGWjgdiCRQZwJKPu7iWAm94eCX6E6wlmXoxEjuyuc/X4aGeRtyDPM7KGs+8p9aSrxApjhc9wkHFN5ngteEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560050; c=relaxed/simple;
	bh=ElqxjwMWZGyiH+CRJO/vCPV13ZXbTcu15nvD5XAzWQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DR0w+UHJFQKdBrAYdi2XtDxe8myCB3HEoVubkFZdCfSa8aUHT0bUhXKE/EI823KaajD3MAwXKo03yxZFtJuiCJ+wbPdkRMHQ0beTtFEBhONq1KNUAzV/UXg4QnaIAhbZfW3FLnxNqqGEc8WF11gaCs2KnrP6M94Wp6ynMZdCn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=BHbRrzGJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E74C113D0;
	Sat,  8 Nov 2025 00:00:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BHbRrzGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762560044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9aw3k91pDoBMTIya0ydY2C08rTpxsNiCITG8XwHmzjw=;
	b=BHbRrzGJePBy8TS0S5VXpw/OFjO5vpbdNASLPsgISoMNLpHlakF/SIAX1rTfU1HEsKdDFf
	eIdEf0TZUWWWGhFbwQZtaagtlMoxYYRnZSpFO/+kThrLew7t8YruZeFh0DwCwEUcu01hwS
	PPP3PgJwBoPMnJKLgkcEexv7TqxvNIw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4e65cb42 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 8 Nov 2025 00:00:44 +0000 (UTC)
Date: Sat, 8 Nov 2025 01:00:35 +0100
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
Subject: Re: [PATCH v5 16/34] random: vDSO: trim vDSO includes
Message-ID: <aQ6II2SiLMzTkAWX@zx2c4.com>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-16-97ff2b6542f7@linutronix.de>
 <aQ6FcWxZFD80yWye@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ6FcWxZFD80yWye@zx2c4.com>

On Sat, Nov 08, 2025 at 12:49:05AM +0100, Jason A. Donenfeld wrote:
> On Thu, Nov 06, 2025 at 11:02:09AM +0100, Thomas Weißschuh wrote:
> > These includes are not used, remove them.
> > 
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > Tested-by: Andreas Larsson <andreas@gaisler.com>
> > Reviewed-by: Andreas Larsson <andreas@gaisler.com>
> > ---
> >  drivers/char/random.c | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/drivers/char/random.c b/drivers/char/random.c
> > index b8b24b6ed3fe436c8102968392278d5cb5544f06..3860ddd9527930780d5c13cd4742fbc3c27acc42 100644
> > --- a/drivers/char/random.c
> > +++ b/drivers/char/random.c
> > @@ -57,9 +57,7 @@
> >  #include <crypto/chacha.h>
> >  #include <crypto/blake2s.h>
> >  #ifdef CONFIG_VDSO_GETRANDOM
> > -#include <vdso/getrandom.h>
> >  #include <vdso/datapage.h>
> > -#include <vdso/vsyscall.h>
> >  #endif
> >  #include <asm/archrandom.h>
> >  #include <asm/processor.h>
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Sorry, it's been a long day. I meant:

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

