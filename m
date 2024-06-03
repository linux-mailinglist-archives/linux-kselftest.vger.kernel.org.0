Return-Path: <linux-kselftest+bounces-11096-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 014398D7BD2
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 08:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1A0D282CC8
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Jun 2024 06:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0812D057;
	Mon,  3 Jun 2024 06:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ooq/Yzsq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14433BB24;
	Mon,  3 Jun 2024 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717396937; cv=none; b=pn9xKecEzRgysId7MKrKxhvzolF3XjRnZ4HpkRIy6+HmjsdNBvyEYDCYCK8G58TnDDeADbgjv7dPHIc5kt1bF3PHLHsUnzAoy5poM9ziyNunvV6joaB7tydezX5RQKaWvHEZnaXM1tvJyJRhUnMHfPZ3ZLmsT6e/uWMhL0+2eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717396937; c=relaxed/simple;
	bh=v2BsmmHhSga2JSNupjuKacxr8Tj3Xu00xalQSDY1tes=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rzvBnZa2v2Wn9NDKhlahizVGJX0YjyeZyjx0tUR06ZZ3X/EjTtBHnHZznnTV0x14HWD1hKv1y3RSwhq7c0Yx1eq0y6TA0OER0BMG2LIqqTB+oeU+iffXmO4PZWPke4DF1/JfklFsBVgoLlpMxbc5ne0Qv7c8chByM8ikPHkqlds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ooq/Yzsq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717396936; x=1748932936;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=v2BsmmHhSga2JSNupjuKacxr8Tj3Xu00xalQSDY1tes=;
  b=Ooq/YzsqPAqoHmESygrv4WoDEtZJRs4/tWVd4of2rsFHhR1c+kjwm9pC
   j9eGPjnoFqZXBH6b3x7HxspU/bMS8mEw/KAgYxXLliyZpXHenq79oXOJn
   D/rz3hh1+QTRasEJviE8OX+x6UZ6Xd/14m3nh1ozQ2xFavwTjtrZaGM6z
   Li+L0xD/Ic6Nj3q/zgyPB9AFlbyfSAftP7UEflm/mISAD1/JA+3LpiYeA
   OdSTCMWKoJulUA0S0Q2Zp/Y1ivMEIBxRQqUxUOMj1sN3vN0X9TQE24VkS
   yYsO6rr7w+8g3ayX23mxt2Po2nwGOyio6TWlwnvfHEipzA48A+kmGwbd+
   w==;
X-CSE-ConnectionGUID: 7tlacnIUQYa9l9oPT+6ivg==
X-CSE-MsgGUID: tgtOVGXaTw2QTtudSLQE2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11091"; a="14101240"
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="14101240"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:42:15 -0700
X-CSE-ConnectionGUID: RZsgW1MLTCOhr0vOpBaDJA==
X-CSE-MsgGUID: MIgSmXdxTxKTJat0m9wcyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,210,1712646000"; 
   d="scan'208";a="36862542"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.161])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 23:42:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 3 Jun 2024 09:42:08 +0300 (EEST)
To: Reinette Chatre <reinette.chatre@intel.com>
cc: linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
    Babu Moger <babu.moger@amd.com>, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Fenghua Yu <fenghua.yu@intel.com>, 
    Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v5 13/16] selftests/resctrl: Convert ctrlgrp & mongrp to
 pointers
In-Reply-To: <1fa7f60d-6feb-4b99-bc3b-3dcdd22515f5@intel.com>
Message-ID: <9cd4bda2-92ba-d958-d9c6-1c255f3d62db@linux.intel.com>
References: <20240531131142.1716-1-ilpo.jarvinen@linux.intel.com> <20240531131142.1716-14-ilpo.jarvinen@linux.intel.com> <1fa7f60d-6feb-4b99-bc3b-3dcdd22515f5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1320720624-1717396928=:1529"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1320720624-1717396928=:1529
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 31 May 2024, Reinette Chatre wrote:
> On 5/31/24 6:11 AM, Ilpo J=C3=A4rvinen wrote:
> > The struct resctrl_val_param has control and monitor groups as char
> > arrays but they are not supposed to be mutated within resctrl_val().
> >=20
> > Convert the ctrlgrp and mongrp char array within resctrl_val_param to
> > plain const char pointers and adjust the strlen() based checks to
> > check NULL instead.
> >=20
> > Convert !grp_name check in create_grp() into internal sanity check by
> > returning error if the caller asked to create a group but doesn't
> > provide a name for the group. The existing code already abides this by
> > only calling create_grp() if mongrp is non-NULL so the error should
> > never be returned with the current selftests (ctrlgrp is never NULL).
>=20
> This paragraph is no longer relevant and can be dropped.

Thanks for catching this. I'm absolutely sure I had this open one in=20
my editor and removed it but it seems I did not, no idea what happened.

--=20
 i.

--8323328-1320720624-1717396928=:1529--

