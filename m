Return-Path: <linux-kselftest+bounces-43554-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD93BF1D05
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 16:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39479405C11
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 14:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5312F6938;
	Mon, 20 Oct 2025 14:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="QaQdlt4X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0730215B;
	Mon, 20 Oct 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970130; cv=none; b=Mj1ywGd67or5GesWxEjfgfnHd6BC8jEShpzV09TQxPkmMSSEXW5sdrzMoqHC7VLd5PmNJrtlCqu++cGXlxVwFL7XMSF+Tv9ICgaEgM1cIWHs3+Qb76L5ApjYC2Ta6mc4QKc9rh7zM3LQRbKvOa0SXdBvX+a8Rs3KgwJjiG8/dN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970130; c=relaxed/simple;
	bh=eVXqdZWOtZ7txBWnH50nnMS7XqFYpHtuEUVHW4IWcvc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=c23ZWrxWu1E2HYKXqCV2w1vevhN7BV+ERu4CBx7lK1UE9bvCB35dk7bo8aJ22zjgfbcy/yNpCumBFVzpi8l9aNesb5PX5ENXHbz8CarHRaeQBJuSfKo/Yy409xfjE3gfwYPEKd4CIS50OKF03oVz/GS0seawVJZwkHsAStcI1BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=QaQdlt4X; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1760970120;
	bh=eVXqdZWOtZ7txBWnH50nnMS7XqFYpHtuEUVHW4IWcvc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QaQdlt4XnQ8bxCpMVnwjRx90bajlP0wfryt4Gbw7RtcN+WcMPM1zMP1VeLsgpwjA3
	 zgy7qZNFc2U7x3kknp6brY8sa0gtQQ7haUGK4WV+m9q/1BSq7JZ/ucq1O6i4LRuM5Y
	 BB9um2wxslxBhnvVPm3c1K7gp9lSJMJH0RNh/Gpg=
Date: Mon, 20 Oct 2025 17:21:56 +0300 (GMT+03:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, Willy Tarreau <w@1wt.eu>,
	linux-kselftest@vger.kernel.org, kernel test robot <lkp@intel.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Benjamin Berg <benjamin.berg@intel.com>
Message-ID: <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>
In-Reply-To: <aNaNtI+mbyc4zgFy@rli9-mobl>
References: <aNaNtI+mbyc4zgFy@rli9-mobl>
Subject: Re: [PATCH v3 09/12] um: use nolibc for the --showconfig
 implementation
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <99359472-8b1e-4d51-adb8-5b16f1f90a9f@weissschuh.net>

Hi Benjamin,

Sep 26, 2025 15:57:43 kernel test robot <lkp@intel.com>:

> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on uml/next]
> [also build test WARNING on uml/fixes shuah-kselftest/next shuah-kselftes=
t/fixes linus/master v6.17-rc7 next-20250925]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:=C2=A0=C2=A0=C2=A0 https://github.com/intel-lab-lkp/linux/commits/Ben=
jamin-Berg/tools-compiler-h-fix-__used-definition/20250924-222547
> base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/uml/lin=
ux next
> patch link:=C2=A0=C2=A0=C2=A0 https://lore.kernel.org/r/20250924142059.52=
7768-10-benjamin%40sipsolutions.net
> patch subject: [PATCH v3 09/12] um: use nolibc for the --showconfig imple=
mentation
> :::::: branch date: 2 days ago
> :::::: commit date: 2 days ago
> config: um-randconfig-r111-20250926 (https://download.01.org/0day-ci/arch=
ive/20250926/202509261452.g5peaXCc-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250926/202509261452.g5peaXCc-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> =C2=A0=C2=A0 command-line: note: in included file (through tools/include/=
nolibc/nolibc.h, tools/include/nolibc/stddef.h, arch/um/include/shared/user=
.h, builtin):
>>> tools/include/nolibc/sys.h:109:29: sparse: sparse: Using plain integer =
as NULL pointer
> =C2=A0=C2=A0unistd.h:70:30: sparse: sparse: Using plain integer as NULL p=
ointer
> =C2=A0=C2=A0 tools/include/nolibc/unistd.h:70:33: sparse: sparse: Using p=
lain integer as NULL pointer

Do you intend to work on your UML with nolibc patches this cycle?
If not I would fix these sparse warnings in the nolibc tree and also apply =
your nolibc patches.


Thomas

