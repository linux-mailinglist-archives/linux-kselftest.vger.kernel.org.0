Return-Path: <linux-kselftest+bounces-26348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F0DA30938
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C633A47B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 10:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216951F3D31;
	Tue, 11 Feb 2025 10:56:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457251F193C;
	Tue, 11 Feb 2025 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739271398; cv=none; b=eXF1tYMTXFzFBwchsqRJtQKjG4QpoJ8tNYtIN1b/ciz2EiKpVlME3eb+yh+gfS0DeMwya0Ej4MtI0EVu0T49I1fY9PpBgcA4+6Dxrp+ZH3LjBtsEcmR51BEMn68OG4wHSByZIfYcebl22MK7fZ/arc2V+MCuFx1IjuRgYIeUmGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739271398; c=relaxed/simple;
	bh=3rEaIwGr0IJXL2qhfiPf6ofu0wVASditL9M/DYf/cr0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=fzGslzcuY+4+yzzs1K1ha2bra41SI7KnIvP9CiAhRL05bIa5rTaVbuvsxvcf1yz1ReJ6ZQkyH8Nnj/V2E278RvE3x3UmBEKXBiF5bUcb0GHOPxTnwMZEoB8pHuKNxrmFb+HCer8IRTWvq6Jd7wpi+m4gAoWGoonVg+pp0Rw5SZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=fjasle.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.52.1)
	(envelope-from <n.schier@avm.de>)
	id 67ab2b6b-72a9-7f0000032729-7f00000191e0-1
	for <multiple-recipients>; Tue, 11 Feb 2025 11:50:19 +0100
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 11 Feb 2025 11:50:19 +0100 (CET)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 22A86807B2;
	Tue, 11 Feb 2025 11:50:19 +0100 (CET)
Received: from l-nschier-z2.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:7792::1])
	by buildd.core.avm.de (Postfix) with ESMTP id 130D418B43E;
	Tue, 11 Feb 2025 11:50:19 +0100 (CET)
Received: from nicolas by l-nschier-z2.ads.avm.de with local (Exim 4.98)
	(envelope-from <n.schier@avm.de>)
	id 1thnqM-000000058pF-29Ha;
	Tue, 11 Feb 2025 11:50:18 +0100
Date: Tue, 11 Feb 2025 11:50:18 +0100
From: Nicolas Schier <nicolas@fjasle.eu>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Nathan Chancellor <nathan@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Nicolas Schier <nicolas@fjasle.eu>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Subject: Re: [PATCH v1] kbuild: Allow building of samples with UML
Message-ID: <20250211-efficient-pink-dolphin-dcfd4d@l-nschier-z2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATuekKKAtp7W+vzwEmaPW52YzPzqTfrJNKpXPV1kGhR8g@mail.gmail.com>
X-purgate-ID: 149429::1739271019-CC7B9F3E-2FB39A69/0/0
X-purgate-type: clean
X-purgate-size: 2663
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Tue, Feb 11, 2025 at 06:44:30PM +0900, Masahiro Yamada wrote:
> On Wed, Dec 18, 2024 at 8:51 PM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > It's useful to build samples/* with UML and the only blocker is the
> > artificial incompatibility with CONFIG_HEADERS_INSTALL.
> >
> > Allow the headers_install target with ARCH=um, which then allow building
> > samples (and tests using them) with UML too:
> >
> >   printf 'CONFIG_SAMPLES=y\nCONFIG_HEADERS_INSTALL=y\nCONFIG_SAMPLE_LANDLOCK=y\n' >.config
> >   make ARCH=um olddefconfig headers_install
> >   make ARCH=um samples/landlock/
> >
> > Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> > Cc: Johannes Berg <johannes@sipsolutions.net>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Nicolas Schier <nicolas@fjasle.eu>
> > Cc: Richard Weinberger <richard@nod.at>
> > Fixes: 1b620d539ccc ("kbuild: disable header exports for UML in a straightforward way")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  Makefile          | 1 -
> >  lib/Kconfig.debug | 1 -
> >  2 files changed, 2 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index e5b8a8832c0c..6e2cce16a2a3 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1355,7 +1355,6 @@ hdr-inst := -f $(srctree)/scripts/Makefile.headersinst obj
> >
> >  PHONY += headers
> >  headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts
> > -       $(if $(filter um, $(SRCARCH)), $(error Headers not exportable for UML))
> >         $(Q)$(MAKE) $(hdr-inst)=include/uapi
> >         $(Q)$(MAKE) $(hdr-inst)=arch/$(SRCARCH)/include/uapi
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index f3d723705879..fac1208f48e4 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -473,7 +473,6 @@ config READABLE_ASM
> >
> >  config HEADERS_INSTALL
> >         bool "Install uapi headers to usr/include"
> > -       depends on !UML
> >         help
> >           This option will install uapi headers (headers exported to user-space)
> >           into the usr/include directory for use during the kernel build.
> > --
> > 2.47.1
> >
> 
> This patch was not even compile-tested.
> 
> Apply this patch.
> Enable CONFIG_HEADERS_INSTALL and CONFIG_UAPI_HEADERS_TEST.
> "make ARCH=um" and see the errors.
> 
> The reason is obvious, UML is a kernel. No such userspace.

oh, I sorry.  I should have seen that when reviewing, but confused
myself as I missed the UAPI_HEADERS_TEST and just looked at a
"successful" run of 'make headers_install'.

Kind regards,
Nicolas

