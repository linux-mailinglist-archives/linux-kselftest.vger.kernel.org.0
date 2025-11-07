Return-Path: <linux-kselftest+bounces-45154-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BCBC42141
	for <lists+linux-kselftest@lfdr.de>; Sat, 08 Nov 2025 01:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B16E13B3E52
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Nov 2025 00:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF571CFBA;
	Sat,  8 Nov 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H96zqhXk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB0434D3A9;
	Sat,  8 Nov 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762560010; cv=none; b=IFeShLuEKP9DDlEEa22r1Mk7bD4KcQJIaOL1GXP1LSpBk8BswaNs1q/dhjaW6oEZf2bShG7l09v/J0GfJKfChgO9LebDKB8S8n7SehhejemxUkM1BHz10olxLCQIC0Xk2dhipBN3EZ13sf+2oJG9gz5QeUSw6A89cH9S34qCpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762560010; c=relaxed/simple;
	bh=FbPpUZRRiTUk7aS2WD5kUL3VjesACtpeQQ8M/w0uLTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfcsDHxZD7c8nMv/X2xwWzHawna5bCR0TndNR3d4e70vRDvX123l9uuYRMZC6OVDXWjmdXMh/RU+fKfL9AE+jiZOYLBDRt0fPLXSDemeqQbrAT5eTnAWdLTW/XE6t/vXnLI/IRlpqLGVCAj2LszW/7ADgp8W3Ptr5zJPtQPx5rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=H96zqhXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46376C116C6;
	Sat,  8 Nov 2025 00:00:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="H96zqhXk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1762560005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WAt2mksIHtC2i3o7CYlpSBU3PXZGrY2JGGi82ePiq/o=;
	b=H96zqhXkDo4gtPRqIDbomfHlsEt58bmjDC9hORkl3+Uf3rlIqKHoWZF7k8bawyuKSfjc4F
	6SdNQzMkcOaNm0QO7ERowScfGbY4T+jBI/abIAjlG4SZsbzeyLCDScM+Bl4teQMOzApifz
	J0y3YrBXb5TY4FRstgnJygjeq5VD3zI=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ad6f9df5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 8 Nov 2025 00:00:05 +0000 (UTC)
Date: Sat, 8 Nov 2025 00:59:56 +0100
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Nick Alcock <nick.alcock@oracle.com>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Shuah Khan <shuah@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Russell King <linux@armlinux.org.uk>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Shannon Nelson <sln@onemain.com>, linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 11/34] random: vDSO: Add explicit includes
Message-ID: <aQ6H_GJynrCLCJwY@zx2c4.com>
References: <20251106-vdso-sparc64-generic-2-v5-0-97ff2b6542f7@linutronix.de>
 <20251106-vdso-sparc64-generic-2-v5-11-97ff2b6542f7@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251106-vdso-sparc64-generic-2-v5-11-97ff2b6542f7@linutronix.de>

On Thu, Nov 06, 2025 at 11:02:04AM +0100, Thomas Weißschuh wrote:
> Various used symbols are only visible through transitive includes.
> These transitive includes are about to go away.
> 
> Explicitly include the necessary headers.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Andreas Larsson <andreas@gaisler.com>
> Reviewed-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  lib/vdso/getrandom.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
> index 440f8a6203a69a6462aafee4ad8d5670cef6a353..7e29005aa208b498b68f16d3df80b048dce8ee21 100644
> --- a/lib/vdso/getrandom.c
> +++ b/lib/vdso/getrandom.c
> @@ -7,8 +7,11 @@
>  #include <linux/minmax.h>
>  #include <vdso/datapage.h>
>  #include <vdso/getrandom.h>
> +#include <vdso/limits.h>
>  #include <vdso/unaligned.h>
> +#include <asm/barrier.h>
>  #include <asm/vdso/getrandom.h>
> +#include <uapi/linux/errno.h>
>  #include <uapi/linux/mman.h>
>  #include <uapi/linux/random.h>

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>

