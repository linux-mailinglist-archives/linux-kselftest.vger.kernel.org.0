Return-Path: <linux-kselftest+bounces-44296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 527E2C1B90D
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 16:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9857D5620DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Oct 2025 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6602DE70B;
	Wed, 29 Oct 2025 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="VMBlA123"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4725785A;
	Wed, 29 Oct 2025 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746843; cv=none; b=sQd+eQnzb/BEJTlcDJQfDIxzN2XFSvztWhyP9FJPl7yPypTwkCxNS3D6ywpqdIArnlp/jtZInD3I5t7vM2KlM27e1qzpesxfAGPnWLpxdgaEpUUuJ6HwU8afKypueIkKxD5sY6aibfATiYv0PeGoDuP6kkLPb/RF2mEFshnGoK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746843; c=relaxed/simple;
	bh=jbDiRc1txlZTTk//UC1k3FW4pC0DVEyDhtcenS6QTzU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bkllNIFWieXV5qX7WMvYC9aQByp+xIX6Ag6jE6NFavcJGxWHQHVA35z4wXOWkBjppfggBkq5oAFr2w6qOnIXxDqGbPRY1nvhzzO8d8FlghGeRnEmzJh7nJNOFcXcbmzPfAakiHK5uGtnpaLMXICQE260P1m9FrM/0wDxhn0Im84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=VMBlA123; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=jbDiRc1txlZTTk//UC1k3FW4pC0DVEyDhtcenS6QTzU=;
	t=1761746841; x=1762956441; b=VMBlA123oYDK6lnjS3/iOydwhEBhwAbGjDABq1MXLNLkVhX
	i1C1XzHUmg3JumW6kuyvgYXnlKLq3fKX/zzKkFCNEZBzFUpi1kxq65iwg5oOhhipUwoooEr3pW2Pv
	nyUVMn6N9QqjqPdyrWpEJyhBen1qHmQ6Qv8Z0/ZjMO26jI1UVSKVffgi0wjCwf8q7t82mEVoevCkd
	Ier5OEwm7kJX/Kekr2AhT7waitdg3Tqr8+Ouz6PjN+vCkxZhF7SPG3Vkba+hb0Ov7qnbyh8irp9SS
	J0C9l79vPNMUzFTV/W4qweSXz5Dm81+aS8ck46OWscqRdcdV1DpdbOWBC8+RTIfw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vE6pV-0000000EkWX-0O7N;
	Wed, 29 Oct 2025 15:07:13 +0100
Message-ID: <516b490d30be6d0676ffe3be5942954bc3c08a39.camel@sipsolutions.net>
Subject: Re: [PATCH v3 09/12] um: use nolibc for the --showconfig
 implementation
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>, 
	linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>, Arnaldo
 Carvalho de Melo	 <acme@redhat.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org
Date: Wed, 29 Oct 2025 15:07:12 +0100
In-Reply-To: <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
References: <aNaNtI+mbyc4zgFy@rli9-mobl>
	 <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi Thomas,

On Mon, 2025-10-20 at 17:21 +0300, Thomas Wei=C3=9Fschuh wrote:
> Hi Benjamin,
>=20
> Sep 26, 2025 15:57:43 kernel test robot <lkp@intel.com>:
>=20
> > kernel test robot noticed the following build warnings:
> >=20
> > [auto build test WARNING on uml/next]
> > [also build test WARNING on uml/fixes shuah-kselftest/next shuah-
> > kselftest/fixes linus/master v6.17-rc7 next-20250925]
> > [If your patch is applied to the wrong git tree, kindly drop us a
> > note.
> > And when submitting patch, we suggest to use '--base' as documented
> > in
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >=20
> > url:=C2=A0=C2=A0=C2=A0
> > https://github.com/intel-lab-lkp/linux/commits/Benjamin-Berg/tools-comp=
iler-h-fix-__used-definition/20250924-222547
> > base:=C2=A0=C2=A0
> > https://git.kernel.org/pub/scm/linux/kernel/git/uml/linux=C2=A0next
> > patch link:=C2=A0=C2=A0=C2=A0
> > https://lore.kernel.org/r/20250924142059.527768-10-benjamin%40sipsoluti=
ons.net
> > patch subject: [PATCH v3 09/12] um: use nolibc for the --showconfig
> > implementation
> > :::::: branch date: 2 days ago
> > :::::: commit date: 2 days ago
> > config: um-randconfig-r111-20250926
> > (https://download.01.org/0day-ci/archive/20250926/202509261452.g5pe
> > aXCc-lkp@intel.com/config)
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > reproduce (this is a W=3D1 build):
> > (https://download.01.org/0day-ci/archive/20250926/202509261452.g5pe
> > aXCc-lkp@intel.com/reproduce)
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a
> > new version of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Closes:
> > > https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
> >=20
> > sparse warnings: (new ones prefixed by >>)
> > =C2=A0=C2=A0 command-line: note: in included file (through
> > tools/include/nolibc/nolibc.h, tools/include/nolibc/stddef.h,
> > arch/um/include/shared/user.h, builtin):
> > > > tools/include/nolibc/sys.h:109:29: sparse: sparse: Using plain
> > > > integer as NULL pointer
> > =C2=A0=C2=A0unistd.h:70:30: sparse: sparse: Using plain integer as NULL
> > pointer
> > =C2=A0=C2=A0 tools/include/nolibc/unistd.h:70:33: sparse: sparse: Using=
 plain
> > integer as NULL pointer
>=20
> Do you intend to work on your UML with nolibc patches this cycle?
> If not I would fix these sparse warnings in the nolibc tree and also
> apply your nolibc patches.

We are not in a hurry for the UML part and while it shouldn't be too
much work, I obviously didn't get around to it in the last week.

So, feel free to pull the patches in via your tree. Then I'll submit
the UML part again in the next cycle.

Benjamin

