Return-Path: <linux-kselftest+bounces-16536-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BA962625
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 13:36:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D6428220E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 11:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457E16CD2A;
	Wed, 28 Aug 2024 11:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pKfSIyCn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917E15957D;
	Wed, 28 Aug 2024 11:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724844967; cv=none; b=sRZbs5cFMEv86bARfuuMUsscdbgiMYx7MoFQ7pSuwf8XkwwYEQxwUbXlaPcfJJnYF8zJUhSZB5vlFUvLorPmrgQLSNZedBptWzXvulR0U25GWwL2Zh/FYQ7zwmedMYLw0QLH0HavjsO1DAdlKA2f0zpyfvWthoc3xa6uooQ3aSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724844967; c=relaxed/simple;
	bh=MCX8KbsK5VIxrU/S+71wstTVdHgKSX2vfDlE+H6TXds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lg137s0TJpqdBi/Bh8TwWZJ7CzC9/hRmO/wYSXBlYiucVugE3loEsymuegLs0y830yEbxYFEdfX1ZpH2V6AT3WO6gqeaECYVYAfw3WeEcinL73oFJpp66rsadP9rTqMstCFjF6BOb6m0Xu3fLooTeBOeyDHJ29YnkKioSfcMl6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=pKfSIyCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87737C98ECC;
	Wed, 28 Aug 2024 11:36:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="pKfSIyCn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724844963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cLAo5gHHcmsu8sLuh4KjlSFYke2JQqCM5R6rEMln4U=;
	b=pKfSIyCnSkeyDjQPIhtTOMpBEItpbkMJXA92xNABSqzabCNC47+FJQfR2ozwxnhbQy3DKl
	XMWWZYm4uFKSfGx1P32BjX3PIsAGSEbSQRGYWvZH9oplcykdn85qa33DxdsLHTW6dMrwyd
	rtsMdo9s4GIyWFqFn1zhRrKGHrYlO68=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 82d6876f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Aug 2024 11:36:03 +0000 (UTC)
Date: Wed, 28 Aug 2024 13:36:03 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
Message-ID: <Zs8Lo9IM9zO0iwXd@zx2c4.com>
References: <Zs3blfx1inX_FQLR@zx2c4.com>
 <019268d4-c177-49e7-aab3-b8fa431905ca@cs-soprasteria.com>
 <Zs3fhiSlXg2aCGa8@zx2c4.com>
 <e9a2257f1447ce11e1f22e9a3c64d4b18aa428e1.camel@xry111.site>
 <0730ca3a-e158-44ea-bb9e-1a7716b45360@csgroup.eu>
 <Zs3qEMQOv5MAipox@zx2c4.com>
 <0b540679ec8cfccec75aeb3463810924f6ff71e6.camel@xry111.site>
 <Zs3sVv43djP3W2yc@zx2c4.com>
 <d1707f9c173f80588c2917f6289c1394802d6229.camel@xry111.site>
 <CAHmME9rpVOy7wteac6BS9N++rsEELA98QR-LEjWLD8MjSLoJvA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9rpVOy7wteac6BS9N++rsEELA98QR-LEjWLD8MjSLoJvA@mail.gmail.com>

On Tue, Aug 27, 2024 at 05:29:56PM +0200, Jason A. Donenfeld wrote:
> On Tue, Aug 27, 2024 at 5:29 PM Xi Ruoyao <xry111@xry111.site> wrote:
> > Or, I can add $(KHDR_INCLUDES) but also keep
> > -isystem $(top_srcdir)/include/uapi, so "make -C tools/testing/selftests
> > TARGETS=vDSO" will still (happens to) work on x86 and ppc (without
> > headers in kernel-tree/usr).
> 
> Oh, the porquenolosdos solution. That sounds good to me.


Does the below work for you?

From 0a769491e0193cdf9728a23d02be5e6be975b513 Mon Sep 17 00:00:00 2001
From: Xi Ruoyao <xry111@xry111.site>
Date: Wed, 28 Aug 2024 13:29:57 +0200
Subject: [PATCH] selftests/vDSO: use KHDR_INCLUDES to locate UAPI headers for
 vdso_test_getrandom

Building test_vdso_getrandom currently leads to following issue:

    In file included from /home/xry111/git-repos/linux/tools/include/linux/compiler_types.h:36,
                     from /home/xry111/git-repos/linux/include/uapi/linux/stddef.h:5,
                     from /home/xry111/git-repos/linux/include/uapi/linux/posix_types.h:5,
                     from /usr/include/asm/sigcontext.h:12,
                     from /usr/include/bits/sigcontext.h:30,
                     from /usr/include/signal.h:301,
                     from vdso_test_getrandom.c:14:
    /home/xry111/git-repos/linux/tools/include/linux/compiler-gcc.h:3:2: error: #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
        3 | #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
          |  ^~~~~

It's because the compiler_types.h inclusion in
include/uapi/linux/stddef.h is expected to be removed by the
header_install.sh script, as compiler_types.h shouldn't be used from
user space.

Add KHDR_INCLUDES before the existing include/uapi inclusion so that
usr/include takes precedence if it's populated.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/testing/selftests/vDSO/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index d1452c7d6d4f..13a626ef64f7 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -39,6 +39,7 @@ $(OUTPUT)/vdso_test_correctness: LDFLAGS += -ldl

 $(OUTPUT)/vdso_test_getrandom: parse_vdso.c
 $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
+					 $(KHDR_INCLUDES) \
                                          -isystem $(top_srcdir)/include/uapi

 $(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(ARCH)/vdso/vgetrandom-chacha.S
--
2.46.0



