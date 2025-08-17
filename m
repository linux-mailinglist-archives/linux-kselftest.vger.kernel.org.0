Return-Path: <linux-kselftest+bounces-39168-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69E0B2923F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 10:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1C31890A8C
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Aug 2025 08:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7070B20C000;
	Sun, 17 Aug 2025 08:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l3PmP9kP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26667081F;
	Sun, 17 Aug 2025 08:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755419462; cv=none; b=ibAy610CIF+zoLuLZFX5Qa6GQMwvlp0AYgqjWfMVTjKoHtO1APq+UyiE3ySGb9Am950IdrM/6JeGUdmNSZTaufikm745AkWL5n8zi3IzE7Ewe+UUiUksl834gPH1KVUZuXq7cBhAfrf74kMa/2yGRoOpCJAN6lnqMjjhV/fBNyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755419462; c=relaxed/simple;
	bh=aXDOIfl6Yp/gQN+k8xyuM5d5hOup3DJ04o2A9M+e3ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIwny4+a/sFqpCHnU9XXNUQvGm0sSp9RHy16SsAAzUYyuLP42FPtN/5DaCTAArvGL6Dn+MFZNZpQiWbjoeUHW8ycIfqsU04s+28+OyUCdD4sXqjicMTn3YbeYzuxXlQGPPGQijyBFXKm6ONQ0HyR7r2jtp2OqlGLmZQC0Ad4nOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l3PmP9kP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755419453;
	bh=aXDOIfl6Yp/gQN+k8xyuM5d5hOup3DJ04o2A9M+e3ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l3PmP9kPr7gF2QOPiPA8AiC2+g8PJ3dAtUdsd5f3cblloU3KVAQgBImUbBBoeoWho
	 x6eISNL3jSxlMeW3KnPoALGFiNWobM64rGWMmffRohZprQ2BFcXnDKyXj/T16Ip65y
	 TB3MWozHemok/0+0SSEdERd4b3kwPDV0MIvZkWv8=
Date: Sun, 17 Aug 2025 10:30:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] selftests/nolibc: don't pass CC to toplevel Makefile
Message-ID: <ebb84a9c-8771-4791-8a81-b615cecec7c3@t-8ch.de>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
 <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
 <20250721025627.GB1886@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250721025627.GB1886@1wt.eu>

Hi Willy,

On 2025-07-21 04:56:27+0200, Willy Tarreau wrote:
> On Sat, Jul 19, 2025 at 05:38:28PM +0200, Thomas Weißschuh wrote:
> > The toplevel Makefile is capable of calculating CC from CROSS_COMPILE
> > and/or ARCH.
> > 
> > Stop passing the unnecessary variable.
> (...) 
> >  # Execute the toplevel kernel Makefile
> > -KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
> > +KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
> 
> Here the goal was not to help the toplevel Makefile figure CC, but rather
> to permit the user to override it, and it's also listed in "make help",
> and even used in cc-option.
> 
> I understnad that you're trying to avoid forcing CC to clang when
> building, but in this case, what will CROSS_COMPILE contain ?  My
> guess is that you intend to make CROSS_COMPILE point to the gcc-based
> toolchain, and have CC point to clang for userland only. Is this the
> case ?

Correct.

> I think I'd be fine with this, but then we need to make it
> explicit in the help message and fix the current one, possibly just
> with this:
> 
> -	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
> +	@echo "  nolibc-test       build the executable (uses \$$CC)"

I don't think this is correct. $CC itself depends on $CROSS_COMPILE
through tools/scripts/Makefile.include.

> 	@echo "  libc-test         build an executable using the compiler's default libc instead"
> 	@echo "  run-user          runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
> 	@echo "  initramfs.cpio    prepare the initramfs archive with nolibc-test"
> 	@echo "  initramfs         prepare the initramfs tree with nolibc-test"
>  	@echo "  defconfig         create a fresh new default config (uses \$$XARCH)"
> -	@echo "  kernel            (re)build the kernel (uses \$$XARCH)"
> +	@echo "  kernel            (re)build the kernel (uses \$$XARCH, \$$CROSS_COMPILE)"

I'll fold this into the last commit of the series.


Thomas

