Return-Path: <linux-kselftest+bounces-4849-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66687857B75
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 12:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FDCC1C214A3
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 11:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5931F69D20;
	Fri, 16 Feb 2024 11:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1o7RWRQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3A69D1A;
	Fri, 16 Feb 2024 11:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082478; cv=none; b=PH+e0lwr+dc+8byIfk6CFmR2s1GHjh1gE4ll5w+nJyDdoDC8zG1+rYkDeKb3EuxIgN1rjlnqB1OLm8crXWCEB2mAY35lGAu0iKLNv0B6ZfpgdnyFuEh4aob51b/RdINcw9uLkoj86Odgc47aLuIZLBiwxl+vI3xbBb7HMc2oRY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082478; c=relaxed/simple;
	bh=VtsIdRkQYCHsC/bIz/ZZnstS2P6Z1i6oil26Gz4lv2Y=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k6ptWx27Gf5jFYu3FuUYrB+qvR8EngaGoC4Y5xDegvKOj+5Y2CZS57lgeNM8pYjtUwXnzep9H59ozhxOHPJwU2HF32lk6qWLhcwShmHmMG7Fil8lP0icKEU9yxs43L2UB4nSyXhjmsXogBKC6R39xtE9cQSMc1ElEhyUEq8D4AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1o7RWRQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708082477; x=1739618477;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VtsIdRkQYCHsC/bIz/ZZnstS2P6Z1i6oil26Gz4lv2Y=;
  b=H1o7RWRQagwBr/oYHU3GxakWDOd4oOEsj8GLC3Q1oHvhT6ob6s4D6GdQ
   CZXb9tHMIkNirclMYohU/JQxWQqlrOYoOS7iVQMyr/nb6qpbRT0Wi6UgS
   0tCREamJqRh3GdfXu/su9Y1qFXNMaIzO/SgjrtefyHQT+6wK6bKM7nvAx
   urr/7/Uk/pzhrEbXRWQK/c7Ahz2X8a7y+cmm70LWxQhkgGZCHaoEIqRxm
   /hG0q1GZbE8s5meaA4NKRpp7Tt6Rd3A2f4g7vD2h5mAjlFgbVy7EyASf7
   fKKdndP50m/rUTnCDeRmLmYxYYa9lYdwGxJr82JiRiKafMUMN84J0+/e/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13311331"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="13311331"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:21:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="4107588"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.248.234])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 03:21:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 16 Feb 2024 13:21:08 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org, 
    fenghua.yu@intel.com, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
In-Reply-To: <79e6f4b5bcaf36214289e56167fe1d5657cb4d24.1708072203.git.maciej.wieczor-retman@intel.com>
Message-ID: <9d0a0e6e-f5eb-24ef-5343-df859935cd31@linux.intel.com>
References: <cover.1708072203.git.maciej.wieczor-retman@intel.com> <79e6f4b5bcaf36214289e56167fe1d5657cb4d24.1708072203.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-587715575-1708082468=:1097"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-587715575-1708082468=:1097
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 16 Feb 2024, Maciej Wieczor-Retman wrote:

> validate_resctrl_feature_request() is used to test both if a resource is
> present in the info directory, and if a passed monitoring feature is
> present in the mon_features file.
>=20
> Refactor validate_resctrl_feature_request() into two smaller functions
> that each accomplish one check to give feature checking more
> granularity:
> - Resource directory presence in the /sys/fs/resctrl/info directory.
> - Feature name presence in the /sys/fs/resctrl/info/<RESOURCE>/mon_featur=
es
>   file.
>=20
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-587715575-1708082468=:1097--

