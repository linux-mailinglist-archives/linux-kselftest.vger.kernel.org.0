Return-Path: <linux-kselftest+bounces-4142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5FC849A99
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 13:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4C11C20DDC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Feb 2024 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF991BC37;
	Mon,  5 Feb 2024 12:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jBSfJBxR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A641BC31;
	Mon,  5 Feb 2024 12:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707136900; cv=none; b=g9tyknqmqWGzGMrEEoSDYYC5dNeIrgwUKheB1IX03zBFs4wlS2tXPCRYFvhNp1/7QUg1iiFsKmuPD7A3dPnoqS3ngQ6lSlSQBXU12JTfTt0ab9VMaZfVOQya3kdkxI0TuaLAW3CknJ2rDvDlCr9EHarOX0tmqeB8MR7BecSLmJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707136900; c=relaxed/simple;
	bh=Kl+5KCmX8M7WabogHGRVyda0jOyd6xLIsooNnB7kZoY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=EZuYaa8phbkYEhoXFLpo/WY7ZMpwTraFceEHwOlXeIzLH94fo53JKbH9nmLriFZCGMZNg+bYw79KanDxpnSzYCI6GwXJ6LwOE0XSR7ycYAHU/Er3lO1LahJ3dVamx0KdjGqi3aHyn8u7fqParzyZL9Kx1deprgBDRy36J+Al0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jBSfJBxR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707136898; x=1738672898;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Kl+5KCmX8M7WabogHGRVyda0jOyd6xLIsooNnB7kZoY=;
  b=jBSfJBxRQm9Cs+A4xwUombsF1onrxQu1RfwhovKt46/Ux6PwzckymzfU
   1/pAahESRhnUTB5zGtA1VV9Q8TCZiJMjMtzeL11l0vCxV/pXwugMd+oDI
   PVUxM6T4V3MgYaSqBzEown6Jc5C/EtjyFgfXazEynPbExd4wAn3Jg806e
   ddel+XuBEjSpMlxJi3BVl3oWuHrTe4Rxzn43cJ73udb8G4R2QfeMPYSKp
   lx23Bdk16trrMsxQmKMN2GEYGjIx979lEkdA9dAns98KS/Upek7kLdkB2
   sfhxkz0bAY8wefXWJ650uzxPVpDb2LP3uGGZGvSM68OYG30sQ5EdLc4h3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11159970"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11159970"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:41:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1003532"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.35.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 04:41:35 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 5 Feb 2024 14:41:30 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
In-Reply-To: <e4b1887682e8262a3416dbd7bc63695af0d63ee0.1707130307.git.maciej.wieczor-retman@intel.com>
Message-ID: <65652533-8333-064a-c446-95232c7da76c@linux.intel.com>
References: <cover.1707130307.git.maciej.wieczor-retman@intel.com> <e4b1887682e8262a3416dbd7bc63695af0d63ee0.1707130307.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 5 Feb 2024, Maciej Wieczor-Retman wrote:

> validate_resctrl_feature_request() is used to test both if a resource is
> present in the info directory, and if a passed monitoring feature is
> present in the mon_features file.
> 
> Refactor validate_resctrl_feature_request() into two smaller functions
> that each accomplish one check to give feature checking more
> granularity:
> - Resource directory presence in the /sys/fs/resctrl/info directory.
> - Feature name presence in the /sys/fs/resctrl/info/L3_MON/mon_features
>   file.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Roll back to using test_resource_feature_check() for CMT and MBA.
>   (Ilpo).
> 
> Changelog v3:
> - Move new function to a separate patch. (Reinette)
> - Rewrite resctrl_mon_feature_exists() only for L3_MON.
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/cmt_test.c  |  2 +-
>  tools/testing/selftests/resctrl/mba_test.c  |  2 +-
>  tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
>  tools/testing/selftests/resctrl/resctrl.h   |  3 +-
>  tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
>  5 files changed, 28 insertions(+), 18 deletions(-)
> 

> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index dd5ca343c469..c1157917a814 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -170,7 +170,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>  static bool cmt_feature_check(const struct resctrl_test *test)
>  {
>  	return test_resource_feature_check(test) &&
> -	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
> +	       resctrl_resource_exists("L3");

This not correctly transformed.

> +/*
> + * resctrl_mon_feature_exists - Check if requested monitoring L3_MON feature is valid.
> + * @feature:	Required monitor feature (in mon_features file).
> + *
> + * Return: True if the feature is supported, else false.
> + */
> +bool resctrl_mon_feature_exists(const char *feature)
> +{
> +	char *res;
> +	FILE *inf;
> +
>  	if (!feature)
> -		return true;
> +		return false;
>  
> -	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
> -	inf = fopen(res_path, "r");
> +	inf = fopen("/sys/fs/resctrl/info/L3_MON/mon_features", "r");

This became less generic? Could there be other MON resource besides L3 
one? Perhaps there aren't today but why remove the ability give it as a 
parameter?


-- 
 i.


