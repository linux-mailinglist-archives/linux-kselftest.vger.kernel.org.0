Return-Path: <linux-kselftest+bounces-23964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8F4A03100
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 21:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF7F18861B4
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 20:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0EF1DDC23;
	Mon,  6 Jan 2025 20:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="mEEnhgAg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238B21D799D;
	Mon,  6 Jan 2025 20:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736193730; cv=none; b=q5sQ8hZr2wDIF5DH/+cNphT0NQic6n7pfgf7/UxQfikuwmbtGK2OK+loPXaWVDXWJ0ZXmhuSM/PMKTNC+FGSW47ZZ83vAfpNyswYrSejgtSXlNYnagJjqcPjwXwIRrSgOp6zoppwQFSOsLEXXAIdqStE80mszY470RfCrBZfBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736193730; c=relaxed/simple;
	bh=i7lYJ2kykzc4phY6koOuwCBelowLWmkT/0HUFMVGhkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/HR7Pkj93UOqMkGeLeCJWL+Evj8NhpyerjKT8T4A+aOtNWanqhfRpJbvuXU3KWrmhPoKYHx2l5Q/laCsZ07B7UI8ZjuhGmysZIPewL1wM+wpPkcPsYvMyKAvhpmDMh4GjBsB41z+e6b7MHkzYC16P3Gzkvcq2Bd2iLr7EjJaak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=mEEnhgAg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1736193717;
	bh=i7lYJ2kykzc4phY6koOuwCBelowLWmkT/0HUFMVGhkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEEnhgAgvZXgiiLpaY3zx9HhWMi5b2JNbB7YJ2Gwq5JEtv1z6KV7V2ppJxNgDn0Nd
	 c56aVkxBoCpxTN7tT/bBXgGBBKrID9c+mYxltqED+0luPex5YQDj2fj31S1fqtj4Jv
	 GKqXJTKKeDNJ0IWKOQMqvUs96QIXOf/66SCu+IfM=
Date: Mon, 6 Jan 2025 21:01:55 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: start qemu with 1 GiB of memory
Message-ID: <f1e98283-459e-478c-85fd-e4015e13b8d9@t-8ch.de>
References: <20241007-nolibc-qemu-mem-v1-1-c1c2f9acd0f8@linutronix.de>
 <333c5179-64f8-43bb-8b34-eaeb912b40f0@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <333c5179-64f8-43bb-8b34-eaeb912b40f0@linuxfoundation.org>

On 2025-01-06 10:51:52-0700, Shuah Khan wrote:
> On 10/7/24 02:10, Thomas Weißschuh wrote:
> > Recently the loongarch defconfig stopped working with the default 128 MiB
> > of memory. The VM just spins infinitively.
> > Increasing the available memory to 1 GiB, similar to s390, fixes the
> > issue. To avoid having to do this for each architecture on its own,
> > proactively apply to all architectures.
> > 
> > Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> > ---
> >   tools/testing/selftests/nolibc/Makefile | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 8de98ea7af8071caa0597aa7b86d91a2d1d50e68..e92e0b88586111072a0e043cb15f3b59cf42c3a6 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -130,9 +130,9 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
> >   QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >   QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >   QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> > -QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> > +QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> >   QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
> > -QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
> > +QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
> >   # OUTPUT is only set when run from the main makefile, otherwise
> >   # it defaults to this nolibc directory.
> > 
> > ---
> > base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> > change-id: 20241007-nolibc-qemu-mem-5ed605520472
> > 
> > Best regards,
> 
> Did we take care of this one? Apologies if I didn't. We can include
> this in 6.14 pr.

This is already in mainline.


Thomas

