Return-Path: <linux-kselftest+bounces-41016-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 653FDB4A19F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 07:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C58B4E5AEB
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 05:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5ECF2F0689;
	Tue,  9 Sep 2025 05:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKM8MK4o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MiFReSeQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7A318A93F;
	Tue,  9 Sep 2025 05:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757397212; cv=none; b=ix0eRDbD/XdSN3IJjSZgNIooTZ0nw7/WXnnOBz+RPoRsOb22TmrmUsgsL8D5NCmClZ6f6raIdxdq9soI+Oy6fjcTz1v1KnS+eqmPuu2r3ibaV9Pv1JLTQsBw6d9LHmSkuHdiH/8IReU5SlcMq+X2MYDE+wHrdMt9+hrsDE+aAHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757397212; c=relaxed/simple;
	bh=AH7v/0EMREj922mMNOjOXhivnD3q+LJG1JYeVGydfOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQGQZB+nxFrYl4saKaVMp83WvZxE29kHxsel23iWgEoChSTe+b07NVbJpj80p5/A3WgtMX5pDLHIvdFiZSQUVVyauia+0P9+V8w2T6BODFSiBwL+tj9kHcWy5DUOt9PdFrcPYZH4sNTxWdE0qth5NvWxVkR87MTEIXH4k53cB/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKM8MK4o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MiFReSeQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 9 Sep 2025 07:53:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757397209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u00qc8KQ1fNjSOxfylahcZ76XCno456ST8BNeP1JmBk=;
	b=UKM8MK4oRVUXEfIjcDVB8+cH6+CfiI/NaIvZ4Ve2TPXRCjT1zeHfosMQu4vnyyL8R1vJx0
	pV2PPnRH98NbCI/ubyQUb/Ov7UIn46Kxd+FJrarPdwcsw60GJYhNYMcwL/sy2ay5MwnHJn
	lwUxh/fOCEIfSGuS+3anuJN0dQbyqUPXPaYEVw40OGWEsMpZNkXyyU0DM4qARccbwRjiu4
	h35DJfZhBOK0DbsYQq7Jbg3jyEd2qlagCukcP90QpgRcekKbrCvLH5BEn3R6jRRQN0lsDK
	QIkKG+ctFf6T2F9XHNee871Dl6Cci3dsca/1ilwD8roubGzVbeo8oPWi1KBq4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757397209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u00qc8KQ1fNjSOxfylahcZ76XCno456ST8BNeP1JmBk=;
	b=MiFReSeQzj5xuUjXwcvDyrcy105eFS0rlpYVpeWoy5EL4sFqX//SkSGbWku5LEOyuHvSdH
	XoaERlptfblKgLDA==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, 
	David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-um@lists.infradead.org
Subject: Re: [PATCH RESEND v2] kunit: Enable PCI on UML without triggering
 WARN()
Message-ID: <20250909075052-54454a48-3576-4d39-ae67-a04ee4616734@linutronix.de>
References: <20250908-kunit-uml-pci-v2-1-d8eba5f73c9d@linutronix.de>
 <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdX6raywNiuDG0zzYQu35YpfSHoE4KSsJLcDfeSqZAac+Q@mail.gmail.com>

Hi Geert,

On Mon, Sep 08, 2025 at 06:53:30PM +0200, Geert Uytterhoeven wrote:
> On Mon, 8 Sept 2025 at 09:04, Thomas Weiﬂschuh
> <thomas.weissschuh@linutronix.de> wrote:
> > Various KUnit tests require PCI infrastructure to work. All normal
> > platforms enable PCI by default, but UML does not. Enabling PCI from
> > .kunitconfig files is problematic as it would not be portable. So in
> > commit 6fc3a8636a7b ("kunit: tool: Enable virtio/PCI by default on UML")
> > PCI was enabled by way of CONFIG_UML_PCI_OVER_VIRTIO=y. However
> > CONFIG_UML_PCI_OVER_VIRTIO requires additional configuration of
> > CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID or will otherwise trigger a WARN() in
> > virtio_pcidev_init(). However there is no one correct value for
> > UML_PCI_OVER_VIRTIO_DEVICE_ID which could be used by default.
> >
> > This warning is confusing when debugging test failures.
> >
> > On the other hand, the functionality of CONFIG_UML_PCI_OVER_VIRTIO is not
> > used at all, given that it is completely non-functional as indicated by
> > the WARN() in question. Instead it is only used as a way to enable
> > CONFIG_UML_PCI which itself is not directly configurable.
> >
> > Instead of going through CONFIG_UML_PCI_OVER_VIRTIO, introduce a custom
> > configuration option which enables CONFIG_UML_PCI without triggering
> > warnings or building dead code.
> >
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > Reviewed-by: Johannes Berg <johannes@sipsolutions.net>
> 
> Thanks for your patch!
> 
> > --- a/lib/kunit/Kconfig
> > +++ b/lib/kunit/Kconfig
> > @@ -106,4 +106,11 @@ config KUNIT_DEFAULT_TIMEOUT
> >           If unsure, the default timeout of 300 seconds is suitable for most
> >           cases.
> >
> > +config KUNIT_UML_PCI
> 
> Where is the consumer of this symbol?

There is none. The relevant part is that it selects UML_PCI which on its own is
not user-visible. Directly enabling UML_PCI wihtout any drivers only makes
sense in the context of KUnit.

> > +       bool "KUnit UML PCI Support"
> > +       depends on UML
> > +       select UML_PCI
> > +       help
> > +         Enables the PCI subsystem on UML for use by KUnit tests.
> > +
> >  endif # KUNIT
> > diff --git a/tools/testing/kunit/configs/arch_uml.config b/tools/testing/kunit/configs/arch_uml.config
> > index 54ad8972681a2cc724e6122b19407188910b9025..28edf816aa70e6f408d9486efff8898df79ee090 100644
> > --- a/tools/testing/kunit/configs/arch_uml.config
> > +++ b/tools/testing/kunit/configs/arch_uml.config
> > @@ -1,8 +1,7 @@
> >  # Config options which are added to UML builds by default
> >
> > -# Enable virtio/pci, as a lot of tests require it.
> > -CONFIG_VIRTIO_UML=y
> > -CONFIG_UML_PCI_OVER_VIRTIO=y
> > +# Enable pci, as a lot of tests require it.
> > +CONFIG_KUNIT_UML_PCI=y
> >
> >  # Enable FORTIFY_SOURCE for wider checking.
> >  CONFIG_FORTIFY_SOURCE=y

