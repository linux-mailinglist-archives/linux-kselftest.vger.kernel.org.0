Return-Path: <linux-kselftest+bounces-29912-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B59A7559E
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 10:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CFC97A6130
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Mar 2025 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52041AB50D;
	Sat, 29 Mar 2025 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NT7Nzq/c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B363597B;
	Sat, 29 Mar 2025 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743241911; cv=none; b=Yg0rMuAjIK37V4bhYGl2M0ldPSIS9ZHQheC07WK2NUGVlJto61KkRoUmopahMiSzpApphHiLR1Dj8F3sQ8TSgHjCkCUvxZIUC/BOEYanZRwDtA+0MGlRHSikz719ZDgwi6p8/KW6506sUb4QnEffzbojHlt2zSvghRjjryD2SVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743241911; c=relaxed/simple;
	bh=emnL5YrggIqYqC8E+OKm6HsIBhJSJimByrZY+7rtUkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLBTilzrj6GW9/rDrcNbkoPJdtxD5j9cjzSAUA/inwM76RUtj/BmdfiFiByb1tKN8lLSLzqGjb7lbCbo1yZ3g5oY9Qz4kMGBc7oEw+RKlq7etGP1uwodIhDLA7MR9u/g/ch1juqTsyHdqNDrYIw6hmRVZhWYDXfwXuiGdDj9JH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=NT7Nzq/c; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1743241907;
	bh=emnL5YrggIqYqC8E+OKm6HsIBhJSJimByrZY+7rtUkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NT7Nzq/cc/96FJDVDFFIzPg1/I+8zS4JgseMhhrn6m3g+LgBIt7jrCLWiDFv7JDdL
	 y0Wj4Ddp0Ll4jmZA6YfQTeVcI/3W+YYGkw9VLQ+nyKPh1U73PmjGRrp8ZerC2oGyUi
	 zzcoILwQ8zZFq7H66I6+aqsljNms334iBgLMZF6U=
Date: Sat, 29 Mar 2025 10:51:47 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Maciej W. Rozycki" <macro@orcam.me.uk>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/nolibc: MIPS: entrypoint cleanups and
 N32/N64 ABIs
Message-ID: <7fef431b-1b68-4967-8f8a-d2b49e403578@t-8ch.de>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
 <20250326205434.bPx_kVUx@breakpoint.cc>
 <60e78caf-49e5-42ad-900c-9813518d838b@t-8ch.de>
 <20250326220430._IkF6-zy@breakpoint.cc>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250326220430._IkF6-zy@breakpoint.cc>

On 2025-03-26 23:04:30+0100, Sebastian Andrzej Siewior wrote:
> On 2025-03-26 22:51:54 [+0100], Thomas Weißschuh wrote:
> > > mips32le works as-is.
> > > For mips64le I had to s/-march=mips64r6/-march=mips64r2 to match the
> > > ABI. Which makes me wonder: Why do do we need to pass -march here and
> > > can't rely on toolchain defaults?
> > 
> > The goal here is to have an as-wide-as-possible test matrix for
> > nolibc-test, which will mostly be running on QEMU anyways.
> > Also we need to run the correct QEMU user variant; by fixing the
> > architecture this is easy to do.
> 
> I would prefer to make distro users as in real hardware first class
> citizen and not QEMU users. If you run qemu you can specify the ABI
> anyway.

Does the following work for you when running kust "make nolibc-test"?

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 58bcbbd029bc..27d5ceb20858 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -174,10 +174,13 @@ CFLAGS_s390x = -m64
 CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
+ifeq ($(origin XARCH),command line)
+CFLAGS_ARCH = $(CFLAGS_$(XARCH))
+endif
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
                $(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
-               $(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
+               $(CFLAGS_ARCH) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=

 LIBGCC := -lgcc
@@ -232,7 +235,7 @@ all: run

 sysroot: sysroot/$(ARCH)/include

-sysroot/$(ARCH)/include: | defconfig
+sysroot/$(ARCH)/include:
        $(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
        $(QUIET_MKDIR)mkdir -p sysroot
        $(Q)$(MAKE) -C $(srctree) outputmakefile

