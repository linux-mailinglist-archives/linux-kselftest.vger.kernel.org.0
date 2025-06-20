Return-Path: <linux-kselftest+bounces-35434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74CB8AE1C71
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40997AA34F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 13:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DB628DEFA;
	Fri, 20 Jun 2025 13:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uek3h/ox";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hj9fDcoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15128B40A;
	Fri, 20 Jun 2025 13:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427028; cv=none; b=AsHTYPIlWOvGK/vUkm+arasoQHVGnKpQTFTO1rrjm1foEybNa99nDovPdxge+h77qYLIyrPJUzj1BBQQPraaBxajLdhhml4GjtdARpXUTLvXilKD8kO5W/4qvsUCveNb/eP/NNzD4gsfX0PhcKC8rl2GmoHM8e4KIsaBRDKNWM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427028; c=relaxed/simple;
	bh=kE6T0xVo349h12vhdsOptOJ59XBo3V1Vl/qYHwIDF5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBh1ZJcprnri825iPoPDufSVmoS6ATFS5ctV+lMHH6NGRvnuOZS79GDIdr6md+T1FL4EkZnhWzqCdtiNIc/N6ReElBsFA7rUwuIimXcnPcyYQ3sqIBR5MDo0xNQiteeaCiLihubUmcv38gtyxOB4xngbQLFOnNoI9VNSOTZIxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uek3h/ox; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hj9fDcoQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 20 Jun 2025 15:43:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750427024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e5LiVdLYV1MWzKzm2m1QtrQk2Nr/rVHB48W5asO8Cg=;
	b=Uek3h/ox5BdHyjedKfonkpQexvpQ9o7KIUuDiu7fe3874JF9ZCdFhjafKo2geauJlK8u0N
	5St4VbJtIg8TijyGaDbDPyFiiiPNuR6uTpnJHYZGQQdTJVrwuBzSOlxXHy83CoTYg5zrmi
	UHVRZc9YwXxrYARSdqnBI1nyTX1KRtp0+s8naFhXeR0NQdiFnJy+YG02GPyU6IZWToqS30
	HGdped6jS8ckUjTlEUMAmyV1Y1AZDt74DxeulpgQufmVZbFR1HIbdXMVcy1VHfruB7+W8z
	ia6+enwyHC3umAf6Vv69ImHbaKaq4TCnZo0sSY8v4qt5x+esnqoXl2CGYOVlWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750427024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6e5LiVdLYV1MWzKzm2m1QtrQk2Nr/rVHB48W5asO8Cg=;
	b=hj9fDcoQDkyXcjztkkuYK+FdVDHyH2XXIcdl+2TM6PadC4dD9JUEMU+mDkWDXpM8kEkwz0
	BIGtpZnNbb1N+6Cg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: David Gow <davidgow@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, workflows@vger.kernel.org
Subject: Re: [PATCH v3 13/16] kunit: Introduce UAPI testing framework
Message-ID: <20250620152344-fadbb8ae-0a86-4938-b05d-00da66fc05c5@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-13-55e3d148cbc6@linutronix.de>
 <CABVgOSmdcOZ0+-k=SM4LibOVMKtcbF27p6N40kuDX_axTPZ=QQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOSmdcOZ0+-k=SM4LibOVMKtcbF27p6N40kuDX_axTPZ=QQ@mail.gmail.com>

On Fri, Jun 20, 2025 at 05:47:39PM +0800, David Gow wrote:
> On Wed, 11 Jun 2025 at 15:38, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Enable running UAPI tests as part of kunit.
> > The selftests are embedded into the kernel image and their output is
> > forwarded to kunit for unified reporting.
> >
> > The implementation reuses parts of usermode drivers and usermode
> > helpers. However these frameworks are not used directly as they make it
> > impossible to retrieve a thread's exit code.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> >
> > ---
> 
> It feels to me like there are three features hidden in here:
> - KUnit helpers for manipulating vfs files
> - A way of having KUnit tests run userspace helpers
> - The full framework for writing/running whole tests in userspace.
> 
> It's really the first two which excite me personally most -- as they
> give us a sort-of inverse to the kselftest "helper module" paradigm --
> so we can test things which are impossible to test from within
> kernelspace.

For me it is only the third feature that I really care about right now.
But I do expect users for the first two to pop up at some point and these are
obviously valid usecases.

> So maybe those APIs should be exposed separately (so a
> test can be written mostly in kernel-space using the KUnit framework
> APIs, and just call out to a helper where needed). But I'm happy for
> them to stay private functions until we have a test which actually
> needs them.

Agreed, let's expose it when there are users.

> > Currently this depends on CONFIG_KUNIT=y as it uses some non-exported
> > symbols around process management.
> 
> That's fine for now, IMHO, but will make it difficult to use this on,
> e.g., Red Hat setups, where CONFIG_KUNIT=m. Hopefully we can resolve
> this by exporting some of the symbols?

I'll try to use the new EXPORT_SYMBOL_GPL_FOR_MODULES() on these symbols and
see what the maintainers say about it.

> In general, I'm happy with the implementation here. The fs stuff
> probably needs a closer look from someone who knows the vfs better
> than me, though.
> 
> Nevertheless,
> Reviewed-by: David Gow <davidgow@google.com>

Thanks

> 
> Cheers,
> -- David
> 
> > ---
> >  Documentation/dev-tools/kunit/api/index.rst |   5 +
> >  Documentation/dev-tools/kunit/api/uapi.rst  |  12 ++
> >  include/kunit/uapi.h                        |  24 +++
> >  lib/kunit/Kconfig                           |  10 +
> >  lib/kunit/Makefile                          |   2 +
> >  lib/kunit/uapi.c                            | 287 ++++++++++++++++++++++++++++
> >  6 files changed, 340 insertions(+)

<snip>

