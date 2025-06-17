Return-Path: <linux-kselftest+bounces-35183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C461ADC3B6
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 09:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDA91733A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D68328C5CB;
	Tue, 17 Jun 2025 07:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pBHIXIA2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xRnqx39l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F61514F6;
	Tue, 17 Jun 2025 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750146666; cv=none; b=hOtPZeNnB4oMuUgpdHW8vU6EH5FJ2CraroOooucn0nVXCUvUs02LAxH8ywj+BmkTutaJKWtO1IPzNmR2Y4sQcRmKf6Rx3Oi3tRWRLS04wiJnZFp3jAHaC2hP0GxIlzy40LRRbbtMyOOlD5beI8lkoIVAvsaRQ9e3OIAKqZ1k/Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750146666; c=relaxed/simple;
	bh=3R2Ct9P8uSiWej39XY31EtkiX1q4iVyamAFGh/y8KTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r2CQoX22eBjGK7Kmalo15hMrcvAiOBTSUkL0uEbrBrIfJWoRXlPKkarWes61GOM5Wevac2gmX61g31uOyP4D2WJtuf5e5M0u/VVeZfdpox1Qjoen/Vd77SqcrduzpHtIlBnSnPvlRVBu9iAyaG7mqDjVvFaIFBq6uPW2B/nhYms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pBHIXIA2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xRnqx39l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 09:50:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750146659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jjhcx//IthYr9wU93G8syVel3LsyenN2WbCDiVNpHY=;
	b=pBHIXIA2nUIPMhiTRpILN2iiHLnKHbbNOTd5eK+f4jnkTY+5JJ+Pli9LRwvybuZ1QZG1A9
	cC+UAO4NUUvP56+oDc8fS6rJ2ph99eF4qymy3EvZsgZ1p3Ng8XXI9Rj5j/V9BIc7GFDgGs
	duA6fGScmpCs0+tI57iR2FcX/aKxnly843Fkpo327i3ERWN7/Rim0zmnJauu1JQz3ohnsu
	RYruqZ2USvkZYHksf1WvQU7oV2YQ2PHzeYj6c8k8pFvW3XVYpXyM0maj7YyUP9UxF06+9u
	YtpfrAP3/nIKC8l6cbCdMzKliKKXGUSrissi1upq4pYYDdmXpzAF5OuREbbchw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750146659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Jjhcx//IthYr9wU93G8syVel3LsyenN2WbCDiVNpHY=;
	b=xRnqx39lvyi7u9ydJO6RVHBz2TCIhyj7pF1uF1yldbEVwrjwDqsDwva3GHf7laAkyuCP4h
	ZO5ooLUM92HS36Dw==
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
Subject: Re: [PATCH v3 07/16] kbuild: introduce blob framework
Message-ID: <20250617094327-373f046c-4010-4939-bd07-51365b665cdd@linutronix.de>
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de>
 <20250611-kunit-kselftests-v3-7-55e3d148cbc6@linutronix.de>
 <CAK7LNARYXKq9KyCczcY_VjwQG3QWEufV1McayHDnavvuU+JEhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARYXKq9KyCczcY_VjwQG3QWEufV1McayHDnavvuU+JEhQ@mail.gmail.com>

On Tue, Jun 17, 2025 at 12:38:21AM +0900, Masahiro Yamada wrote:
> On Wed, Jun 11, 2025 at 4:38 PM Thomas Weißschuh
> <thomas.weissschuh@linutronix.de> wrote:
> >
> > Various subsystems embed non-code build artifacts into the kernel,
> > for example the initramfs, /proc/config.gz, vDSO image, etc.
> > Currently each user has their own implementation for that.
> >
> > Add a common "blob" framework to provide this functionality.
> > It provides standard kbuild and C APIs to embed and later access non-code
> > build artifacts into the kernel image or modules.
> >
> > Reviewed-by: Nicolas Schier <n.schier@avm.de>
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 
> Kbuild provides only a small set of syntaxes, yet it's flexible enough
> to allow each Makefile to implement what it needs.
> I aim to keep Kbuild scripts as simple as possible and avoid over-engineering.
> 
> Instead, you can implement this in lib/kunit/Makefile.kunit-uapi or somewhere.
> That way, I do not have to be worried about what you do.

The goal was to have a framework that can be used independently of KUnit,
for the usecases listed in the commit message (and a few unlisted ones).
But I can go with a more specific solution, too.

> Also, your separate blob approach looks questionable to me.

> In your approach, the blob (kunit-example-uapi.blob.o)
> and the entry point (kunit-example-test.o) can be separate modules.

Indeed, however I don't see the issue for this specific point.

> The entry point would be a small amount of boilerplate.
> I would keep the user-program blob and its entry point in the same C file.

A Makefile dependency between the C file and blob payload is also necessary.

> (and I may consider writing a macro for populating a blob + knit entry)

That is what I had in during my early development,
and I guess I'll go with it again.


Thomas

