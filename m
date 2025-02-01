Return-Path: <linux-kselftest+bounces-25513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B4EA2483F
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 11:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4F2E1887762
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Feb 2025 10:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA0514A4DD;
	Sat,  1 Feb 2025 10:20:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655701459FD;
	Sat,  1 Feb 2025 10:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738405231; cv=none; b=ZTPu2ck8n/xyDhBymoZSK9e9ISPgISb1vkxYvg6CT1Mm6t5E0D+Mz/3LYoAQ0awlXge3BVl3v9zC03s/tPsyhaTaeuFJ44LdDp80gxFL65TP2fNDx3G0chxL8QJ/fPI4cY95mWP0CtchfPA48bhmxnZ0Y1LiDfuKf5o81TYYSAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738405231; c=relaxed/simple;
	bh=tUEaZBK1Fv6jgwdMcbeELrgHTRfiKEeZV2xaBHrfsi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+5OJFchADyOWxau3VzMjqRLoSsnaUiGWwGmF7CbW4GS4ooBKhw9oWY43E0FaNXPkTZ/9LqkecNNtqTYh6k26eScmBqpo2+gWTKuE2Fp1y3GYYVYtqsrkkxx0vjufakK45QPLhel2oeo2S0Pxy/lpuUTJpPhM5EsN/ZfgJ/DT6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 511AKPfC006655;
	Sat, 1 Feb 2025 11:20:25 +0100
Date: Sat, 1 Feb 2025 11:20:25 +0100
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] selftests/nolibc: drop custom EXTRACONFIG
 functionality
Message-ID: <20250201102025.GG5849@1wt.eu>
References: <20250123-nolibc-config-v2-0-5701c35995d6@weissschuh.net>
 <20250123-nolibc-config-v2-1-5701c35995d6@weissschuh.net>
 <20250201101305.GD5849@1wt.eu>
 <3f06ca01-68a3-41ca-9bfb-3f37f2173951@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3f06ca01-68a3-41ca-9bfb-3f37f2173951@t-8ch.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Feb 01, 2025 at 11:17:28AM +0100, Thomas Weiﬂschuh wrote:
> On 2025-02-01 11:13:05+0100, Willy Tarreau wrote:
> > On Thu, Jan 23, 2025 at 08:37:37AM +0100, Thomas Weiﬂschuh wrote:
> > > kbuild already contains logic to merge predefines snippets into a
> > > defconfig file. This already works nicely with the current "defconfig"
> > > target. Make use of the snippet and drop the custom logic.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> > > ---
> > >  tools/testing/selftests/nolibc/Makefile | 9 +--------
> > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > 
> > > diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
> > > index 7d14a7c0cb62608f328b251495264517d333db2e..ba044c8a042ce345ff90bdd35569de4b5acd117d 100644
> > > --- a/tools/testing/selftests/nolibc/Makefile
> > > +++ b/tools/testing/selftests/nolibc/Makefile
> > > @@ -82,7 +82,7 @@ DEFCONFIG_x86        = defconfig
> > >  DEFCONFIG_arm64      = defconfig
> > >  DEFCONFIG_arm        = multi_v7_defconfig
> > >  DEFCONFIG_mips32le   = malta_defconfig
> > > -DEFCONFIG_mips32be   = malta_defconfig
> > > +DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
> > >  DEFCONFIG_ppc        = pmac32_defconfig
> > >  DEFCONFIG_ppc64      = powernv_be_defconfig
> > >  DEFCONFIG_ppc64le    = powernv_defconfig
> > > @@ -93,9 +93,6 @@ DEFCONFIG_s390       = defconfig
> > >  DEFCONFIG_loongarch  = defconfig
> > >  DEFCONFIG            = $(DEFCONFIG_$(XARCH))
> > >  
> > > -EXTRACONFIG_mips32be = -d CONFIG_CPU_LITTLE_ENDIAN -e CONFIG_CPU_BIG_ENDIAN
> > > -EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
> > > -
> > >  # optional tests to run (default = all)
> > >  TEST =
> > >  
> > > @@ -265,10 +262,6 @@ initramfs: nolibc-test
> > >  
> > >  defconfig:
> > >  	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
> > > -	$(Q)if [ -n "$(EXTRACONFIG)" ]; then \
> > > -		$(srctree)/scripts/config --file $(objtree)/.config $(EXTRACONFIG); \
> > > -		$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) olddefconfig < /dev/null; \
> > > -	fi
> > 
> > OK it's no longer needed thanks to your change above, but to we really
> > want to get rid of that feature allowing anyone to add their own extra
> > config ? I'm not sure. For example maybe the current build script helps
> > on bare metal, when trying to add support for new archs or other features
> > not yet in defconfig ? We could leave EXTRACONFIG_* empty by default and
> > user-defined, as I don't feel like it blocks anything to keep it.
> 
> Makes sense, let's keep it.
> It's currently not possible for kbuild to pick up config snippets
> outside of a few special locations.

Yes but when facing difficulties, users can be creative (e.g. inject
semi-colon and commands in EXTRACONFIG ;-)).

> I'll fix this up locally and apply the series directly.

Thank you!
Willy

