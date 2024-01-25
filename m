Return-Path: <linux-kselftest+bounces-3563-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DB583C144
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 12:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7933E1F2BEAE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 11:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0FB2CCBA;
	Thu, 25 Jan 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ihl++4Vx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CCB2C6A1;
	Thu, 25 Jan 2024 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706183221; cv=none; b=E5ijn7w4oLhgz6FMBvU/2A4mR1IjrbN2LuPq8IQ+97z1a+1LzcALNI9/kOZrq3+HEnKvBPpeKDSzeps/lV2CDUjFZZEYqtBB+w0ztiHClsVzWtshhsTHXZg9kc1IhMq5jb6Ursk5hD0MNyD7aVg3OeGP864UqjDV7Dl3Bt31XQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706183221; c=relaxed/simple;
	bh=/qY8+GO9uXyETM6l1xdCOFxzv90yJYBZM6zC5WJjGNs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=u1mFInHS+XZuAN4ME189quwPsof5GqeJdYkuY2S2ieVfTsgZb/Q8Xeidsh/e75obxc56RIQ/2KtAQ4/wXkhr9XYkqgtXUeUmDvC3KbDGU3MVit4SGJivXeLYJCR5d1q4Y1Bcz82XoIFQnTsSJ6ary8QGr6WCbRVz9+iVMQGs9Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ihl++4Vx; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706183220; x=1737719220;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/qY8+GO9uXyETM6l1xdCOFxzv90yJYBZM6zC5WJjGNs=;
  b=Ihl++4Vx3Fm6mMjrC9ZIUx+0xKLMki7gAhTj/aY5BRqkeEhVfJZcbrwL
   DkernGUZjYmVSi7NcNRE3KnEIcuTPFkIUV4jkuawguctHbSGpOQ45eB1p
   9gu9/5n9c3WenGSMW15aEUA6HRpDtnXzAsdkkeCE2omQRr/v1c58IazF+
   6iY0oXpcHl3/9WDaH1LUDGUpOl7oC2lI4CPU7ONS/q7PsRkC5kVO97wsI
   HXWeZaJTIS8xiZIIsydCW+dUo70NTZy/R3vN2Nk8fzm3eFHyez0lETJ74
   bu2fUsZ0tE8ZnN6iwLkrjt+STikPAoLohJLUv0YNUsacuc3QIp7tXbbjq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20687227"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20687227"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:46:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2228958"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.252.55])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 03:46:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 25 Jan 2024 13:46:51 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Reinette Chatre <reinette.chatre@intel.com>, shuah@kernel.org, 
    fenghua.yu@intel.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/5] selftests/resctrl: Split
 validate_resctrl_feature_request()
In-Reply-To: <415cc65c113143c833ca2eaacd3a03c285c2e841.1706180726.git.maciej.wieczor-retman@intel.com>
Message-ID: <62310cc5-7756-61a2-9529-8ae0fc247c21@linux.intel.com>
References: <cover.1706180726.git.maciej.wieczor-retman@intel.com> <415cc65c113143c833ca2eaacd3a03c285c2e841.1706180726.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Jan 2024, Maciej Wieczor-Retman wrote:

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
> Changelog v3:
> - Move new function to a separate patch. (Reinette)
> - Rewrite resctrl_mon_feature_exists() only for L3_MON.
> 
> Changelog v2:
> - Add this patch.
> 
>  tools/testing/selftests/resctrl/cmt_test.c  |  4 +--
>  tools/testing/selftests/resctrl/mba_test.c  |  4 +--
>  tools/testing/selftests/resctrl/mbm_test.c  |  6 ++--
>  tools/testing/selftests/resctrl/resctrl.h   |  3 +-
>  tools/testing/selftests/resctrl/resctrlfs.c | 33 +++++++++++++--------
>  5 files changed, 30 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
> index dd5ca343c469..428de9df81c8 100644
> --- a/tools/testing/selftests/resctrl/cmt_test.c
> +++ b/tools/testing/selftests/resctrl/cmt_test.c
> @@ -169,8 +169,8 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool cmt_feature_check(const struct resctrl_test *test)
>  {
> -	return test_resource_feature_check(test) &&
> -	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
> +	return resctrl_mon_feature_exists("llc_occupancy") &&
> +	       resctrl_resource_exists("L3");
>  }
>  
>  struct resctrl_test cmt_test = {
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index da256d2dbe5c..e22285b80e37 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -170,8 +170,8 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool mba_feature_check(const struct resctrl_test *test)
>  {
> -	return test_resource_feature_check(test) &&
> -	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
> +	return resctrl_resource_exists(test->resource) &&

I don't understand what's the advantage of converting away from 
test_resource_feature_check() in CMT and MBA case?

> +	       resctrl_mon_feature_exists("mbm_local_bytes");
>  }

> @@ -756,7 +765,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
>  
>  bool test_resource_feature_check(const struct resctrl_test *test)
>  {
> -	return validate_resctrl_feature_request(test->resource, NULL);
> +	return resctrl_resource_exists(test->resource);

...The replacement in MBA open coded test_resource_feature_check() 100% 
and CMT even replaces the test->resource with the string matching to 
what's in test->resource?


-- 
 i.


