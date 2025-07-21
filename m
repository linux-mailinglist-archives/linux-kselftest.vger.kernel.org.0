Return-Path: <linux-kselftest+bounces-37733-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A119B0BB3B
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 05:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CAFA7A4BFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 03:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70ECE185E7F;
	Mon, 21 Jul 2025 03:10:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A35383;
	Mon, 21 Jul 2025 03:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753067409; cv=none; b=XHhwuexkezscccVzUYNwfXoYaRkJRM8+0Zk0TVokfZxpDtOJBHXdtVkhlI+UUvjm+DSXNsvpdNdw4/LnrELeokJdrL5M56M0WkqyTL0Zthjmvkikg7hH+vu/Zohwtiuz6uuAdwoGWtzf92JbFypSgsOb1FE7SVqIYZAjbCNXx3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753067409; c=relaxed/simple;
	bh=Y5iIhCMrdBbYkERV51HLzsVIZEpCxV1d0E49bh0P7PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QPFC6bipEK48vPMBQMmyRS+ndLbUwXLHOdiohDFiVYdUHUn1XBWbBSd3dPv0cfyVs6YPeVy44X+cwqlpCPkQwIzUwxnSVsEAKiAKMJz1O0hmRQndTSP1Tr1bOC5ISrwA0YW7vV+npsISZpXwjkg2ai1g/u/4MUvTuD5Laat8a8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 56L2uRVW001989;
	Mon, 21 Jul 2025 04:56:27 +0200
Date: Mon, 21 Jul 2025 04:56:27 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 2/3] selftests/nolibc: don't pass CC to toplevel Makefile
Message-ID: <20250721025627.GB1886@1wt.eu>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
 <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Sat, Jul 19, 2025 at 05:38:28PM +0200, Thomas Weißschuh wrote:
> The toplevel Makefile is capable of calculating CC from CROSS_COMPILE
> and/or ARCH.
> 
> Stop passing the unnecessary variable.
(...) 
>  # Execute the toplevel kernel Makefile
> -KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
> +KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)

Here the goal was not to help the toplevel Makefile figure CC, but rather
to permit the user to override it, and it's also listed in "make help",
and even used in cc-option.

I understnad that you're trying to avoid forcing CC to clang when
building, but in this case, what will CROSS_COMPILE contain ?  My
guess is that you intend to make CROSS_COMPILE point to the gcc-based
toolchain, and have CC point to clang for userland only. Is this the
case ? I think I'd be fine with this, but then we need to make it
explicit in the help message and fix the current one, possibly just
with this:

-	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  nolibc-test       build the executable (uses \$$CC)"
	@echo "  libc-test         build an executable using the compiler's default libc instead"
	@echo "  run-user          runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
	@echo "  initramfs.cpio    prepare the initramfs archive with nolibc-test"
	@echo "  initramfs         prepare the initramfs tree with nolibc-test"
 	@echo "  defconfig         create a fresh new default config (uses \$$XARCH)"
-	@echo "  kernel            (re)build the kernel (uses \$$XARCH)"
+	@echo "  kernel            (re)build the kernel (uses \$$XARCH, \$$CROSS_COMPILE)"

Thanks,
Willy

