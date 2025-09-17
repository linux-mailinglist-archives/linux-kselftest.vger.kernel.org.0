Return-Path: <linux-kselftest+bounces-41740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFACB80F64
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5BFA7A750B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2D34BA4B;
	Wed, 17 Sep 2025 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TgrRAWqJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B734BA2E;
	Wed, 17 Sep 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126257; cv=none; b=dZi3UjX1ayZYDNsogaQD+wc0/iGLzNft6N6velZd07L/VA6KdM2jQdzek7+uiwjFtWY2JTxTYeHPuv/8k6RQpru3JvJbfReHkyEEWKCWf4K0HbrnipGY2KnRuHOs0uveMMWqkqzTmoEZrRzX0jfBK5wAQjU3HIhi9yKsA0aDhBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126257; c=relaxed/simple;
	bh=ee0Fihprx00Irt1b2uNyIYyx46h/WRE1AhiXBYr0/Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuM3y4hz39vJAmqKHcsArJbLqCXB7N/C3DEfnEmIPHM7mbGs6lV5JZQA+wqg5RPtQs8DlFuGPwQY5QKzbWMs2op0N4YLsx+jP4vHqzz5bHnamc8N3cvQDewHOxVzojeLv2T8iCaHBiVamNjRoFypVL9BHcR5bzdB18GN4+2krnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TgrRAWqJ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1758126253;
	bh=ee0Fihprx00Irt1b2uNyIYyx46h/WRE1AhiXBYr0/Xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TgrRAWqJvWypJvGtCRQDXPQqq59D7Dqxb2bVm70spnRUbnCk6qdM9RrExj3dlcXNW
	 CSmuaEmg5E2735yhs5qryPq4U2Yd4DwpC3uEjUv4Aqp1SpSjl3QH6pgEnNg670qpbl
	 UYGnzvDBOu5eSd/CGusWWHOEUdGQs0d5diZ18l+E=
Date: Wed, 17 Sep 2025 18:24:13 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Kees Cook <kees@kernel.org>, Eric Biederman <ebiederm@xmission.com>, 
	Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Willy Tarreau <w@1wt.eu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 16/16] selftests: vDSO: vdso_standalone_test_x86:
 Switch to nolibc
Message-ID: <1f64966f-ef7a-474a-9641-561b6b7cb0d2@t-8ch.de>
References: <20250226-parse_vdso-nolibc-v2-0-28e14e031ed8@linutronix.de>
 <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
 <20250917153209.GA2023406@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250917153209.GA2023406@nvidia.com>

Hi Jason,

On 2025-09-17 12:32:09-0300, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 12:44:55PM +0100, Thomas Weißschuh wrote:
> 
> > -$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
> > -$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=-nostdlib -fno-asynchronous-unwind-tables -fno-stack-protector
> > +$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c | headers
> > +$(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=$(CFLAGS_NOLIBC) $(CFLAGS)
> 
> This addition of "| headers" breaks O=build builds. ie this:
> 
> $ make O=build-x86 allnoconfig -s -j 14
> $ make O=build-x86 -s -j 14
> $ make O=build-x86 kselftest-all -s -j 16 &> /dev/null || true
> $ make O=build-x86 -s -j 14
> 
> Fails with:
> 
> ***
> *** The source tree is not clean, please run 'make mrproper'
> *** in /home/jgg/oss/wip/kselftests_dirty
> ***
> 
> Because the build now spews stuff outside the build directory that it
> should not do.. Bisection points to this patch and removing the "|
> headers" makes it stop doing that..

Sorry for the breakage and thanks for the report.

> Any idea how to fix it?

Care to try this:

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 530390033929..a448fae57831 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -228,7 +228,10 @@ $(OUTPUT)/%:%.S
        $(LINK.S) $^ $(LDLIBS) -o $@
 endif

+# Extract the expected header directory
+khdr_output := $(patsubst %/usr/include,%,$(filter %/usr/include,$(KHDR_INCLUDES)))
+
 headers:
-       $(Q)$(MAKE) -C $(top_srcdir) headers
+       $(Q)$(MAKE) -f $(top_srcdir)/Makefile -C $(khdr_output) headers

 .PHONY: run_tests all clean install emit_tests gen_mods_dir clean_mods_dir headers


Thomas

