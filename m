Return-Path: <linux-kselftest+bounces-5031-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB27485BDA2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 14:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872DB2834C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 13:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A0A6A348;
	Tue, 20 Feb 2024 13:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIbJoLjV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FB26A33D;
	Tue, 20 Feb 2024 13:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436964; cv=none; b=AgTvMLNRq6vjExJlOurF+rO+hudUuX77HuVibM+W4eTPQXUIwcjrEzuk8indlYf7CMokSZYwnp0Y2Q1K2olYKmqK/jse+XDjKkeg2GFQBJkQ8dh+joetUhLyIxZAlJz/E5S+F8t6qieFWPRDBcuje2Etcs6njLN498TVrBMsFpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436964; c=relaxed/simple;
	bh=Ry+oD2aeuZyQ8lyL2bZUi5BX0g4Xx7EQvo1e3TAbr5I=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bZ715y9vvNBIRx2MSUbljDwfDsBWXI9cgY7dVDyoSuJFdr7eF0l66ZwHKyuv9Z4n3Vk3+Sj/2OmY/c5yieV9ewDaCYPgUMT/OddbG67H14yqSiQgybP0hM7OMnUWPi0ihgJO3XLIrGCYVXCmKSp6AYHxOCqp1ejZhnMOWAmDncc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIbJoLjV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708436963; x=1739972963;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ry+oD2aeuZyQ8lyL2bZUi5BX0g4Xx7EQvo1e3TAbr5I=;
  b=UIbJoLjVjDTpeyUpxqpnIJvR9ehj/PFG2YqFBYHTw4MNNP/LEtF+pxZc
   ugQ09kJ2deJlr4y6PFdpGNnuAfQfu9d7PbuWnCHiRP59yN2prrDBPyRas
   DZobRPOWwgZ2IxNVJcNZnzJOuqKwPiBNPcOC1aBPSUjsrkrLd536zAPES
   ehNFNL62o7o6yEIylj3uW8308x9DxZSj2TYUvKYmw4kcJyWvlvmO1p5f6
   YjTem/IZApjVhiGSRh6N+2CXvXSm7dTqB2eVLgmAESFaRg3gVsgLKh+Pq
   a2jy6uZn7xuHmhU0oFwugi9P8Rxu4KqM3RbXuTOk2qg83tNRJ3g2SD5iT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="24995632"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="24995632"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:49:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4940842"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.249.21])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 05:49:21 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 Feb 2024 15:49:16 +0200 (EET)
To: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc: Fenghua Yu <fenghua.yu@intel.com>, 
    Reinette Chatre <reinette.chatre@intel.com>, Shuah Khan <shuah@kernel.org>, 
    LKML <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests/resctrl: Move cleanups out of individual
 tests
In-Reply-To: <63b9763211c2954f0ef517a817b3bf0c482df8cd.1708434017.git.maciej.wieczor-retman@intel.com>
Message-ID: <f08dafda-c8a5-324a-464c-5b84d779c4ad@linux.intel.com>
References: <cover.1708434017.git.maciej.wieczor-retman@intel.com> <63b9763211c2954f0ef517a817b3bf0c482df8cd.1708434017.git.maciej.wieczor-retman@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 20 Feb 2024, Maciej Wieczor-Retman wrote:

> Every test calls its cleanup function at the end of it's test function.
> After the cleanup function pointer is added to the test framework this
> can be simplified to executing the callback function at the end of the
> generic test running function.
> 
> Make test cleanup functions static and call them from the end of
> run_single_test() from the resctrl_test's cleanup function pointer.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c      | 4 +---
>  tools/testing/selftests/resctrl/cmt_test.c      | 3 +--
>  tools/testing/selftests/resctrl/mba_test.c      | 4 +---
>  tools/testing/selftests/resctrl/mbm_test.c      | 4 +---
>  tools/testing/selftests/resctrl/resctrl.h       | 4 ----
>  tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
>  6 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 2d2f69d3e5b7..ad5ebce65c07 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -128,7 +128,7 @@ static int check_results(struct resctrl_val_param *param, const char *cache_type
>  	return fail;
>  }
>  
> -void cat_test_cleanup(void)
> +static void cat_test_cleanup(void)
>  {
>  	remove(RESULT_FILE_NAME);
>  }
> @@ -289,8 +289,6 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  	ret = check_results(&param, test->resource,
>  			    cache_total_size, full_cache_mask, start_mask);
>  out:
> -	cat_test_cleanup();
> -

Any goto out can now become return ret; and the out label be then removed.


-- 
 i.


