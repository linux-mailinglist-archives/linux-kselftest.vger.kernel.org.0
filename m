Return-Path: <linux-kselftest+bounces-3826-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F63843F1E
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 13:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FB729269C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE7E76905;
	Wed, 31 Jan 2024 12:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQeIH0ar"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36646768FA;
	Wed, 31 Jan 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706702708; cv=none; b=cbXyy9W8/UJkpUugCDcABSeDA7qIJd9MjO6t3n7qPzmkdq/+F4X2YpU+bZ64qSJK7tYotw0j2bL+plwWmxV2zcf4bCXbyrKGTvXJnxux0Few4B37Lx4Ubh3PEcFTrnpRFPHU+mxZHd75tA8qCdK0w1EXzECjZXPpPPpATBfXcPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706702708; c=relaxed/simple;
	bh=C4+J0LK2uGlnop8N8+yJQ1nCoUA+KOAPfCeSlARfKYU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Tq1pWmB0msIhR+Y6Rdz200JY+QeTzabtA/Su5R97imUkNsA6nKepbR7B5M8SE21X97tzjFdhYv8LTB7UG3YWARiahYloOw49KeMJnJEtggBT8QCYBjMcbantp7AgJz4q8aAsfcSJyvVCQYpSFs9GDLxqqv0WHHWh+erOjsFnkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQeIH0ar; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706702707; x=1738238707;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C4+J0LK2uGlnop8N8+yJQ1nCoUA+KOAPfCeSlARfKYU=;
  b=hQeIH0arMlLFVtsHsLx6Ucc9MDMfnXm3etK2rSlN0Afh6si4iyt6zkAa
   SFDkrvSWoz539x5SSjGv4ciXzCLvJ76kNUPOFZ2U7RsNs1dMYRG9SZ601
   bKf7K+A+/zAO2PZkb2hiulELLttQKR1BBxk21SaVvQcTuapOJuosxSa2I
   YUzK6YgWZ+m7kMexxpHmNTSLlCgWXBZtJlo93R3IYozywk2eG20kZQr+u
   OnIKrPxdppBWAo12Ulov+zUQ4YlOIFrcMzGIF/+DEHMbHiSWQMTcLuKkN
   LP3XPUA35foO9cva2oW5XDFcziY8Aqdc6t9DDXkZ4O9Hu7vsL6QihYCCB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10965154"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="10965154"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 04:05:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738074974"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="738074974"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.167])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 04:05:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Jan 2024 14:04:57 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, fenghua.yu@intel.com, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 2/5] selftests/resctrl: Add helpers for the non-contiguous
 test
In-Reply-To: <tck7kcpjdch3a3qkkwusft5zwptlhtmicx53zjcqk3x42w5p55@pf6vrmnh7deo>
Message-ID: <6259e494-bab3-0aeb-0bf6-e4e384f8f0b0@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com> <85b1efc3ddd698b3ac81aa72a6dc987ee17da3e2.1706180726.git.maciej.wieczor-retman@intel.com> <ea9b0e06-c07e-eb4b-9e7d-ed20419b677d@linux.intel.com> <611fd2b6-d9ec-42f0-9711-b1398fc02842@intel.com>
 <tck7kcpjdch3a3qkkwusft5zwptlhtmicx53zjcqk3x42w5p55@pf6vrmnh7deo>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1725428063-1706702697=:1077"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1725428063-1706702697=:1077
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 31 Jan 2024, Maciej Wieczor-Retman wrote:
> On 2024-01-26 at 10:58:04 -0800, Reinette Chatre wrote:
> >On 1/25/2024 4:14 AM, Ilpo J=E4rvinen wrote:
> >> On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:
> >
> >>> +=09fp =3D fopen(file_path, "r");
> >>> +=09if (!fp) {
> >>> +=09=09snprintf(reason, sizeof(reason), "Error in opening %s file\n",=
 filename);
> >>> +=09=09ksft_perror(reason);
> >>=20
> >> Was this the conclusion of the kstf_perror() discussion with Reinette?=
 I=20
> >> expected a bit different outcome when I stopped following it...
> >>=20
> >> In any case, it would be nice though if ksft_perror() (or some kselfte=
st.h=20
> >> function yet to be added with a different name) would accept full prin=
tf=20
> >> interface and just add the errno string into the end of the string so =
one=20
> >> would not need to build constructs like this at all.
> >>=20
> >> It will require a bit of macro trickery into kselftest.h. I don't know=
 how=20
> >> it should handle the case where somebody just passes a char pointer to=
 it,=20
> >> not a string literal, but I guess it would just throw an error while=
=20
> >> compiling if somebody tries to do that as the macro string literal=20
> >> concatenation could not build useful/compilable token.
> >>=20
> >> It would make these prints informative enough to become actually usefu=
l=20
> >> without needed to resort to preparing the string in advance which seem=
s
> >> to be required almost every single case with the current interface.
> >
> >I think this can be accomplished with a new:
> >=09void  ksft_vprint_msg(const char *msg, va_list args)
> >
> >... but ksft_perror() does conform to perror() and I expect that having =
one
> >support variable number of arguments while the other does to cause confu=
sion.
> >
> >To support variable number of arguments with errno I'd propose just to u=
se
> >ksft_print_msg() with strerror(errno), errno as the arguments (or even %=
m
> >that that errno handling within ksft_print_msg() aims to support). This =
does
> >indeed seem to be the custom in other tests.
>=20
> Does something like this look okay?
>=20
> =09fp =3D fopen(file_path, "r");
> =09if (!fp) {
> =09=09ksft_print_msg("Error in opening %s\n: %m\n", file_path);
> =09=09return -1;
> =09}
>=20
> The '%m' seems to work fine but doesn't print errno's number code. Do you=
 want
> me to add errno after '%m' so it is the same as ksft_perror()? I looked t=
hrough
> some other tests where '%m' is used, and only few ones add errno with '%d=
'.

I think %m is enough.

--=20
 i.

--8323328-1725428063-1706702697=:1077--

