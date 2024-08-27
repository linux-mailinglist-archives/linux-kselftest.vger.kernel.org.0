Return-Path: <linux-kselftest+bounces-16403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7F8960CD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 16:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5FA1B23F04
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 13:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944AB1C32F0;
	Tue, 27 Aug 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="POqPmC88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD173466;
	Tue, 27 Aug 2024 13:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767134; cv=none; b=HogBytRL6uRRrvhV4JGHIeI3Q5WievgZV4wPzmZjxE6Atf61MsLVy6HpYo2iL8Ut9cSPodbj4J565CXC7iWNRwJxz6Igkv1h8wSLgO1BstZdg80MPkm76qV/yyrfg2bZzLp6oFKcsDT+6WiE3uY6JUwbcGFwCnb7AfMhK+RVANo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767134; c=relaxed/simple;
	bh=0vFesti6TbpapVrIw+Z8tJU5VGesZxv+nnMd+vyZhP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiWMBcAWNBgQEmORLOXUQygzK6+37HF6yOhqAcYxWIOG3b2fXv0njaiAUhjTLPbB7xGiXSMOj4TEj9PAf4ESN8rql/2YC9RPKYEOqb6kyRPDIhTWCICQXvXNth8jXWaK1r4qXNp00zsQ7JxTBuOmxSs2xUsOJnuZV5Rk/0fKwNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=POqPmC88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED63C61041;
	Tue, 27 Aug 2024 13:58:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="POqPmC88"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1724767131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2fg1XuQIh0IzuwIEGB5O3oiw1CTBEBdzBCBh6pElOTA=;
	b=POqPmC88ZJjBe1PsJuQkVq+zZRDmmtMw3VkE3poc21jvLfFgDhDd1k5AQAXDMV5MaZM6j1
	+QsTHOaWsILA3hylAxLS8ZrNtnGnDRRbc5zXDKIBMym2Inff0pX1KnvbmbTGsa/rx8QOyA
	BPKm73NFCjXSCdOjkbBNot0k7DXrNpw=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 1fcd2d69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Aug 2024 13:58:51 +0000 (UTC)
Date: Tue, 27 Aug 2024 15:58:45 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
	linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
	Jinyang He <hejinyang@loongson.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>, Arnd Bergmann <arnd@arndb.de>,
	christophe.leroy@csgroup.eu, tglx@linutronix.de,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 3/4] selftests/vDSO: Use KHDR_INCLUDES to locate UAPI
 headers for vdso_test_getrandom
Message-ID: <Zs3blfx1inX_FQLR@zx2c4.com>
References: <20240827132018.88854-1-xry111@xry111.site>
 <20240827132018.88854-4-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240827132018.88854-4-xry111@xry111.site>

On Tue, Aug 27, 2024 at 09:20:16PM +0800, Xi Ruoyao wrote:
> Building test_vdso_getrandom currently leads to following issue:
> 
>     In file included from /home/xry111/git-repos/linux/tools/include/linux/compiler_types.h:36,
>                      from /home/xry111/git-repos/linux/include/uapi/linux/stddef.h:5,
>                      from /home/xry111/git-repos/linux/include/uapi/linux/posix_types.h:5,
>                      from /usr/include/asm/sigcontext.h:12,
>                      from /usr/include/bits/sigcontext.h:30,
>                      from /usr/include/signal.h:301,
>                      from vdso_test_getrandom.c:14:
>     /home/xry111/git-repos/linux/tools/include/linux/compiler-gcc.h:3:2: error: #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
>         3 | #error "Please don't include <linux/compiler-gcc.h> directly, include <linux/compiler.h> instead."
>           |  ^~~~~
> 
> It's because the compiler_types.h inclusion in
> include/uapi/linux/stddef.h is expected to be removed by the
> header_install.sh script, as compiler_types.h shouldn't be used from the
> user space.
 
Hmm. If I run this on my current 6.10-based system, I get:

$ make
  CC       vdso_standalone_test_x86
  CC       vdso_test_getrandom
vdso_test_getrandom.c:43:41: error: field ‘params’ has incomplete type
   43 |         struct vgetrandom_opaque_params params;
      |                                         ^~~~~~

Because KHDR_INCLUDES is /usr/include instead.

Christophe, any suggestions on this one? And any idea why loongarch is
hitting it, but not x86 or ppc?

Jason

