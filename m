Return-Path: <linux-kselftest+bounces-25511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E86CA24839
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC881888C42
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E5113D619;
	Sat,  1 Feb 2025 10:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fPWvnw/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB6A935;
	Sat,  1 Feb 2025 10:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738405061; cv=none; b=R5D2jhdfqmG58kJRh1pPmHjgb4k/efFLkHNr7nEf26pevv1YJJHiopcjbO4TiaxzB/M3C1kAUMY7f3oQZ0gchPQzXmHpbyplM0K9hJQYO5Z+tpCYpgEMzzpTfpoFtqKSLTixSIFwNTOxYVQ+vl78Rsfwy1fHVnkkmQbPaEC9Bpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738405061; c=relaxed/simple;
	bh=NHljcI2F57mmoG1PxvZFvu26mCW48Mnq1S82OK+pn9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYn0a+Sv8/UTActLQQfX8bhfVAwxWarl7J6pf1rUV5KFMqSj2rec8jLNBHMrHzh78BupcXAMbeEKSDjmOJGLFW49Kg+jPzYDlB1WtDEW25z/Wm5w/KbpGrNM26Mee5M4iNJObDpFFZapj0UhZXFYL5/mjeg8ckQrGAN8tjKSOTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fPWvnw/O; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738405048;
	bh=NHljcI2F57mmoG1PxvZFvu26mCW48Mnq1S82OK+pn9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fPWvnw/OsVZqRzT82MXmQXpFNExVIL/0r5TPOAt5Z2L+MDSq7uj0YcsFXsACby5wd
	 osU08Vk0KmW6+PKjz6MU1xt//mDKMbbZq+NLV65Giuw0axBTLujhehCKbq/pd7bdD9
	 STtkz/as3sYINQXiZkk4F1CvM4o77fKjCCqTWp3o=
Date: Sat, 1 Feb 2025 11:17:28 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] selftests/nolibc: drop custom EXTRACONFIG
 functionality
Message-ID: <3f06ca01-68a3-41ca-9bfb-3f37f2173951@t-8ch.de>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
 <20250123-nolibc-config-v2-1-5701c35995d6@weissschuh.net>
 <20250201101305.GD5849@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250201101305.GD5849@1wt.eu>

On 2025-02-01 11:13:05+0100, Willy Tarreau wrote:
> On Thu, Jan 23, 2025 at 08:37:37AM +0100, Thomas Weißschuh wrote:
> > kbuild already contains logic to merge predefines snippets into a
> > defconfig file. This already works nicely with the current "defconfig"
> > target. Make use of the snippet and drop the custom logic.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > ---
> >  tools/testing/selftests/nolibc/Makefile | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > index 7d14a7c0cb62608f328b251495264517d333db2e..ba044c8a042ce345ff90bdd35569de4b5acd117d 100644
> > --- a/tools/testing/selftests/nolibc/Makefile
> > +++ b/tools/testing/selftests/nolibc/Makefile
> > @@ -82,7 +82,7 @@ DEFCONFIG_x86        = defconfig
> >  DEFCONFIG_arm64      = defconfig
> >  DEFCONFIG_arm        = multi_v7_defconfig
> >  DEFCONFIG_mips32le   = malta_defconfig
> > -DEFCONFIG_mips32be   = malta_defconfig
> > +DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
> >  DEFCONFIG_ppc        = pmac32_defconfig
> >  DEFCONFIG_ppc64      = powernv_be_defconfig
> >  DEFCONFIG_ppc64le    = powernv_defconfig
> > @@ -93,9 +93,6 @@ DEFCONFIG_s390       = defconfig
> >  DEFCONFIG_loongarch  = defconfig
> >  DEFCONFIG            = $(DEFCONFIG_$(XARCH))
> >  
> > -EXTRACONFIG_mips32be = -d CONFIG_CPU_LITTLE_ENDIAN -e CONFIG_CPU_BIG_ENDIAN
> > -EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
> > -
> >  # optional tests to run (default = all)
> >  TEST =
> >  
> > @@ -265,10 +262,6 @@ initramfs: nolibc-test
> >  
> >  defconfig:
> >  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > -	$(Q)if [ -n "$(EXTRACONFIG)" ]; then \
> > -		$(srctree)/scripts/config --file $(objtree)/.config $(EXTRACONFIG); \
> > -		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig < /dev/null; \
> > -	fi
> 
> OK it's no longer needed thanks to your change above, but to we really
> want to get rid of that feature allowing anyone to add their own extra
> config ? I'm not sure. For example maybe the current build script helps
> on bare metal, when trying to add support for new archs or other features
> not yet in defconfig ? We could leave EXTRACONFIG_* empty by default and
> user-defined, as I don't feel like it blocks anything to keep it.

Makes sense, let's keep it.
It's currently not possible for kbuild to pick up config snippets
outside of a few special locations.

I'll fix this up locally and apply the series directly.


Thomas

