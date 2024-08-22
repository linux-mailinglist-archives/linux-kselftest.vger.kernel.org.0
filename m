Return-Path: <linux-kselftest+bounces-16020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C46795AF7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 09:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1021C230E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 07:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8548153565;
	Thu, 22 Aug 2024 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PtHo5gPp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7151531F8;
	Thu, 22 Aug 2024 07:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312477; cv=none; b=GbiIy5eh5IzggcYF2Pgm/8enPLQGZuIj3RfJ3QPUEhZl9hbuT4qhEeYkkSZ0yFh/0T8OQHU29xPD95FiTqjyzg+Pt6n+4GDDEqg27TjEKI2Bb9dlWjSqp3oybf/Kh5OHrOtGJzOvin77N2jAyndGuQAh/0MvfgRW4tlLbGeextQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312477; c=relaxed/simple;
	bh=5mwuj+VBs0qp1O3ouX4dSJkK50NaE/7bMjElULSBQgY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=untFx1fDmbnlbBI23KSd6MzcUvnjKC/CULnnelQRxPfNLeihzZI/mg6d0IZAzrLdfOWJPlpNTHFtNX8Nr3n80tzcJHjiwYR3fIZDO9TWUpujkQLzFF+/kQOuksnSAND15V4bEL14PO1gmMy1TQC9kEN7vM0XPB5ErVIx0AaM/J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PtHo5gPp; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724312476; x=1755848476;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5mwuj+VBs0qp1O3ouX4dSJkK50NaE/7bMjElULSBQgY=;
  b=PtHo5gPpZjOW1fD5qdD0nTp7lv0hGPIl5dCwroyvT9sFLf66EcmfJdIm
   gVCC+FXFmzKjUbz2k3JPrz8+5dVjlOfk9Uu7C2EJ1X6F422JWgOgQld+a
   nkeIUmkNNmn65xdTfXF2+CIAn5/cV5BuT60J+wog4FWFTuJg9I1UxVPE+
   ph3qh00oEeLQcfP6QOWLDSNWrCYNoJKR+8N7SOZcRd3mqITb1ty7b21Q9
   Smfys0h9XOo2w6VHVpRrH2F2HmUqQwCiH2SgYm2T10t5Rwlh2h3Xmn+KP
   Si3nNbWwZ0sjYSbKf3Nfz7/gUPcN9RJ/wbemVjIpubLQiW+2XJGb/B3xS
   Q==;
X-CSE-ConnectionGUID: Xb0CG+8uQ5Gic5zTw6aF4g==
X-CSE-MsgGUID: rj4HlvboSZm8tyuhynx1dQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22580052"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="22580052"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:41:15 -0700
X-CSE-ConnectionGUID: Y4RnIK7FTpePYd6RGbc7ng==
X-CSE-MsgGUID: XRSu0+RKSoKgOV5BhpsSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="61506163"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.82])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 00:41:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 22 Aug 2024 10:41:08 +0300 (EEST)
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
cc: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
    Reinette Chatre <reinette.chatre@intel.com>, 
    linux-kselftest@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
    Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 0/3] selftests: Fix cpuid / vendor checking build
 issues
In-Reply-To: <7f4d4d41-e59d-4574-99e7-4dba69929954@collabora.com>
Message-ID: <975d32d5-9a86-1a31-984e-a31dc0353123@linux.intel.com>
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com> <88575c79-b6be-42d2-b863-d57f83f8c99c@linuxfoundation.org> <7f4d4d41-e59d-4574-99e7-4dba69929954@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1725946267-1724312468=:1015"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1725946267-1724312468=:1015
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 22 Aug 2024, Muhammad Usama Anjum wrote:

> On 8/21/24 11:30 AM, Shuah Khan wrote:
> > On 8/13/24 04:45, Ilpo J=C3=A4rvinen wrote:
> >> First, generalize resctrl selftest non-contiguous CAT check to not
> >> assume non-AMD vendor implies Intel. Second, improve kselftest common
> >> parts and resctrl selftest such that the use of __cpuid_count() does
> >> not lead into a build failure (happens at least on ARM).
> >>
> >> The last patch might still require some work on which symbol the
> >> conditional in kselftest.h is implemented. I could not find any
> >> pre-existing one that could be used. Perhaps somebody who's more
> >> familiar with the kselftest build system has a better suggestion on
> >> which symbol the logic should be based at?
> >>
> >> Ilpo J=C3=A4rvinen (3):
> >> =C2=A0=C2=A0 selftests/resctrl: Generalize non-contiguous CAT check
> >> =C2=A0=C2=A0 selftests/resctrl: Always initialize ecx to avoid build w=
arnings
> >> =C2=A0=C2=A0 [RFC] kselftest: Provide __cpuid_count() stub on non-x86 =
archs
> >>
> >> =C2=A0 tools/testing/selftests/kselftest.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 6 +++++
> >> =C2=A0 tools/testing/selftests/lib.mk=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ++++
> >> =C2=A0 tools/testing/selftests/resctrl/cat_test.c | 28 +++++++++++++--=
-------
> >> =C2=A0 3 files changed, 27 insertions(+), 11 deletions(-)
> >>
> >=20
> > These changes look good to me. Can you send the RFC patch without the
> > RFC tag
> > for me to pull in? I don't apply RFC patches.
> >=20
> > Usama, does this fix the problem you are seeing?
>
> Yeah, build errors are resolved.

Great, thanks for testing!

I'll send v2 with RFC removed soon.

> > Hi Reinette - do these look okay to you? Can you give me an ack if they=
 do?
> >=20
> > thanks,
> > -- Shuah
> >=20
>=20

--=20
 i.

--8323328-1725946267-1724312468=:1015--

