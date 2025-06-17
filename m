Return-Path: <linux-kselftest+bounces-35185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 75094ADC3D9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 997B11893A2D
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC5928F933;
	Tue, 17 Jun 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="riuj8blw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3dlU8pnc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AC028ECCD;
	Tue, 17 Jun 2025 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750147151; cv=none; b=nzpRFkFMYZeWjba0C+U4Z6ghAmg6I3+O5CV9E/IwckRdRoQBIA8Sit6QF8uYgfbty+FUoGhVMM/8cCxQFP3Nqc96Ja/V4QaRJgCWtheMuqTp+FttPXept50jd4G35EjqNpzkFw5mKvqeyPFkYhGicPkXT3ZJrmAlv/fJkgAqL6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750147151; c=relaxed/simple;
	bh=NIgJ6S2IMm67sNgLluaxm/t93R9SpN5EK5tTKzscYko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rg8UqNTLUtGw/5zPkUs1SpKD2yxfxptljTPMIbHfOgIUbBzA1fj9ASL6FfJCkH6m9EtZ5o71AeT1Bbn8b9ecoV5Qa9keC+5QdC19TTKDdqC+hKVgZj0sMFhnmGwwdkl6ryuyUx56+8NpSfL1EfAF1yylnBVCSwqAvnu02gPaQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=riuj8blw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3dlU8pnc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:59:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750147148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj2LJB5Pz+vjWi8da/Iv2JkklxNhs1V6axP5pIrqxJM=;
	b=riuj8blwvDOsP6wUDdP3Ci9HXHbVoAlg32Weak2qNVuiCsD1ol6m/pAdmc6Wz+nOKmmqKg
	3IeYSlbgY2321vJgf0z88CN2TJeN2qF5hfUcRL4jBlVM2dUs3HE7qD16NAvAmHP/2Q0Tiu
	Bv4zf2GgxWNfyv3tMCpI3wG2QM2gYLo0w2MiidaFYgj1M6iVe1g6wxrJ1VTkOJvr9Jf1rH
	cXvYeuXURM43LbebVBKLsOIftA5ESr5OIcgKGY3NSdHi38sICPCCjfkEXkqUUNYg//cVI+
	+91Qelw5eKrsAUCwxPXvtbH9iLIk+rBeQm+lUtOKp6N02yrLbZppHMyNUJ3vEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750147148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hj2LJB5Pz+vjWi8da/Iv2JkklxNhs1V6axP5pIrqxJM=;
	b=3dlU8pncy0paXbKmJi5ztkGhzw3FggNzV5ZHCn4tYoW6SfRQ/nfHyS2G+ZITRQ05Cj+PIu
	F15f2+z9rzshWKDQ==
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
Subject: Re: [PATCH v3 04/16] kbuild: userprogs: add nolibc support
Message-ID: <20250617095102-d3df1c46-3d51-4f77-af0a-8299f5e71ad9@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-4-55e3d148cbc6@linutronix.de>
 <CAK7LNAQUN3hWYh_1=LMzVp1Ddbq3W=yGHZ5__LbcfBajfuhscg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQUN3hWYh_1=LMzVp1Ddbq3W=yGHZ5__LbcfBajfuhscg@mail.gmail.com>

On Tue, Jun 17, 2025 at 12:35:07AM +0900, Masahiro Yamada wrote:
> On Wed, Jun 11, 2025 at 4:38 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Userprogs are built with the regular kernel compiler $CC.
> > A kernel compiler does not necessarily contain a libc which is required
> > for a normal userspace application.
> > However the kernel tree does contain a minimal libc implementation
> > "nolibc" which can be used to build userspace applications.
> >
> > Introduce support to build userprogs against nolibc instead of the
> > default libc of the compiler, which may not exist.
> >
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> >
> > ---
> > This could probably be moved out of the generic kbuild makefiles.
> > I think the ergonimics would suffer and this functionality could be
> > used by other users of userprogs.
> >
> > Also this does currently not support out-of-tree builds.
> > For that tools/include/nolibc/*.h and usr/include/*.h would need to be
> > installed into the build directory.

<snip>

> > --- a/scripts/Makefile.userprogs
> > +++ b/scripts/Makefile.userprogs
> > @@ -16,10 +16,17 @@ user-csingle        := $(addprefix $(obj)/, $(user-csingle))
> >  user-cmulti    := $(addprefix $(obj)/, $(user-cmulti))
> >  user-cobjs     := $(addprefix $(obj)/, $(user-cobjs))
> >
> > +user_nolibc_ccflags := -nostdlib -nostdinc -static -fno-ident -fno-asynchronous-unwind-tables \
> > +                     -ffreestanding -fno-stack-protector \
> > +                     -isystem $(objtree)/usr/include -include $(srctree)/tools/include/nolibc/nolibc.h -isystem $(srctree)/tools/include/nolibc/
> 
> The tools/ directory is a different world, and Kbuild scripts do not know
> anything about it.

Ack.

How does this statement affect the next patch which creates
tools/include/nolibc/Kconfig.nolibc ?
Is it fine to create the Kconfig file in tools/ or should I move it?
I do want to maintain this file as part of nolibc and not KUnit.
The possibilities I see are init/Kconfig.nolibc or lib/Kconfig.nolibc.

> And, you do not need to implement this in scripts/Makefile.userprogs
> because you can move this to lib/kunit/Makefile.kunit-uapi or somewhere.

Understood. This is not unexpected, as hinted in the commit message.

> > +user_nolibc_ldflags := -nostdlib -nostdinc -static
> > +
> >  user_ccflags   = -Wp,-MMD,$(depfile) $(KBUILD_USERCFLAGS) $(userccflags) \
> > -                       $($(target-stem)-userccflags)
> > -user_ldflags   = $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags)
> > -user_ldlibs    = $(userldlibs) $($(target-stem)-userldlibs)
> > +                       $($(target-stem)-userccflags) $(if $($(target-stem)-nolibc),$(user_nolibc_ccflags))
> > +user_ldflags   = $(KBUILD_USERLDFLAGS) $(userldflags) $($(target-stem)-userldflags) \
> > +                       $(if $($(target-stem)-nolibc),$(user_nolibc_ldflags))
> > +user_ldlibs    = $(userldlibs) $($(target-stem)-userldlibs) \
> > +                       $(if $($(target-stem)-nolibc),$(user_nolibc_ldlibs))
> >
> >  # Create an executable from a single .c file
> >  quiet_cmd_user_cc_c = CC [U]  $@


Thomas

