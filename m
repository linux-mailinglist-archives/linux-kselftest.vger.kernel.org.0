Return-Path: <linux-kselftest+bounces-35181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4782ADC38F
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C94813A81D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CDE28D8EF;
	Tue, 17 Jun 2025 07:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LQqR6ibE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHtGhuDp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9C7289803;
	Tue, 17 Jun 2025 07:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750145955; cv=none; b=TjXaIInNeAChWc1ptTG7ZULLuhezTwZgTSF2tCJs390jYF+KKZoihDcjzeYJX6djgoP2Bo5lMnFvzcQfjVyubE7s2mKgmDay2cCJDGAs+xpBi+Cux4Z/EXrehfNSCwQ5q8NBqJYo9qVENaT7kiOIp3K3LQ/A/tY1Jt2ibuBsa5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750145955; c=relaxed/simple;
	bh=ZqChbIHl8eFApjqdf88u+0LzeRDCHv9CNT33A4cC8W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwT+UoRo/7MM9Fc16UCySaqh78fOrAaIbkuzMOwSS1OHZ4wnx+yAuI8VQJDLiXoHsR74YtVeIGdrOAdWaFmqORqbCEK7esakg6oXGpMUdgd2RNqIjJOd330oc0ax4TtZU0oHo8wfW1s0dj/hiM6HMmAjXAecGT05/jwehJDLEA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LQqR6ibE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHtGhuDp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:39:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750145952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUjG6+JFxLZDStRNnT8ioKp8RqTOmg0bGcH75TxHJOo=;
	b=LQqR6ibEuyBEC7uwHHtnbVzvvooJNrTvO3oXqLrInJhDVXhZtr/gNdtPqVlrTxlenvdbRZ
	RnHN7iVlyBuYyZiSaE1AIArJAPtizX2fRnqAhJe6uiUXXlFZOQ729I9/gS4GVU7O7ePnd6
	Brh+HSm4WXshRLvZoWd5xxBzlMQKduMd/6lGt5nw6MqflQ2v4FTgWVregP7xTNLP+Yuzc+
	ybhMgXXRgjtX5mfxmcebXoLmfXe1IgbHqGynqe6AGe/XwzUdMLF35HWuR/RCpmEnyerE6H
	aO31q/Nd9xiou/f5+oOoRBHfBajKMQfD+n3V5gkOUNEUDwQTphRJe5Pr2eYMig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750145952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AUjG6+JFxLZDStRNnT8ioKp8RqTOmg0bGcH75TxHJOo=;
	b=FHtGhuDpN/5Xuy91ovmc3tSQjnTi2R4gYX20+L0rJCOATaiEhbU7vlEdMIy3pGCokkZDf5
	Tyyjyt1nxeTJX1Ag==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Willy Tarreau <w@1wt.eu>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH v3 02/16] kbuild: userprogs: also inherit byte order and
 ABI from kernel
Message-ID: <20250617093523-e7f54d95-96d0-4411-92d6-dd80fe84ee98@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-2-55e3d148cbc6@linutronix.de>
 <CAK7LNATuk_tpDAq07e5oSU4FptRO_88Oxh2=W=3YmBotbGuU5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATuk_tpDAq07e5oSU4FptRO_88Oxh2=W=3YmBotbGuU5g@mail.gmail.com>

On Mon, Jun 16, 2025 at 11:49:41PM +0900, Masahiro Yamada wrote:
> On Wed, Jun 11, 2025 at 4:38 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Make sure the byte order and ABI of the userprogs matches the one of the
> > kernel, similar to how the bit size is handled.
> > Otherwise the userprogs may not be executable.
> > This happens for example on powerpc little endian, or riscv32.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  Makefile | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5610e45a2807dfa257f4 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
> >  LDFLAGS_vmlinux        += --emit-relocs --discard-none
> >  endif
> >
> > -# Align the bit size of userspace programs with the kernel
> > -USERFLAGS_FROM_KERNEL := -m32 -m64 --target=%
> > +# Align the bit size, byte order and architecture of userspace programs with the kernel
> > +USERFLAGS_FROM_KERNEL := -m32 -m64 -mlittle-endian -mbig-endian --target=% -march=% -mabi=%
> >  KBUILD_USERCFLAGS  += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
> >  KBUILD_USERLDFLAGS += $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPFLAGS) $(KBUILD_CFLAGS))
> 
> 
> Why didn't you do like this?
> 
> USERFLAGS_FROM_KERNEL := $(filter -m32 -m64 -mlittle-endian
> -mbig-endian --target=% -march=% -mabi=%, $(KBUILD_CPPFLAGS)
> $(KBUILD_CFLAGS))
> KBUILD_USERCFLAGS  += $(USERFLAGS_FROM_KERNEL)
> KBUILD_USERLDFLAGS += $(USERFLAGS_FROM_KERNEL)

The idea was to keep the USERFLAGS_FROM_KERNEL line free of clutter, as it is
probably going to change more often. To improve reviewability and gain some
available horizontal space in case it should be needed at some point.

If you prefer the other layout I'll be happy to switch it around.


Thomas

