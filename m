Return-Path: <linux-kselftest+bounces-8902-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB738B310B
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 09:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B1492814BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 07:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD8413AA56;
	Fri, 26 Apr 2024 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMnTjxKx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9551567F;
	Fri, 26 Apr 2024 07:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714115208; cv=none; b=leC0RVPtS/1bdnLe0G0UN/2MDsv1c69EVvaVeRh6GQlee/bH90Rg9Vpvkq5fpICw0vNwt/WDds1tplMaC2PyoAqJKpa7brrK96uXg7nIaPjvRkQFHiaTiawMKDEXjgrXToJJzp5nZ6hxMEzQY/s+PL9IzMgaQi5Nol5908D5Olk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714115208; c=relaxed/simple;
	bh=4Sa4RA3LJOfxMjyEzrT/NkrXuslTZWrRzLjfnRdCUCU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZxjpmLDWfTUE5Wu7Apl1DL4DZ5XXTc47vL7QDWGvEjeN4NNhaJgNvArPVCWfz5AWDwMhcivvFTulptG7h8GAkQvIcWUk08DMmlvxRvbrgbFJBcNx2PI7w50VmhDIvAL/ZdKRf10QCG1knLUB1fn/aYVjb9eSJxC1JphWC1Ooy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMnTjxKx; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714115207; x=1745651207;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=4Sa4RA3LJOfxMjyEzrT/NkrXuslTZWrRzLjfnRdCUCU=;
  b=OMnTjxKx4E0Nbgl3Ai87u24px7E2Xc/gk+2rY0xRfzrm5X0YaUQ7I+aV
   f65HANIHg/D6A+aAMkk7cyJxdqYI8XM0gi61IzLMSUiNvHvuhtt2bKzG0
   nmMqfVI03uk5vHLpaT4INjsyruqFlp5kgMgl0rs3Big3451vKRPhGLwL+
   lnvqwsLSXqMOhUaPvxoFocVkTghEP/sCV440vVO4vszfIkTm26ILmVlj0
   GoslbCVuY0ZVSQSchP5W8DzeumqfmuYXWy+LpRKvmH9Fy9ZNPUZUNCYuR
   lU/P8Z82hVg++EBo03a5knS/UhIXtpIVuqyJ48GQrslDcN4Pqo19yzzYH
   Q==;
X-CSE-ConnectionGUID: 5a2kPsKGQLSvQ3Ol3XRgWA==
X-CSE-MsgGUID: vRfQQX1tQDWcXSFZ9hJGMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11055"; a="10056330"
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="10056330"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 00:06:46 -0700
X-CSE-ConnectionGUID: zK4kFKwARTa21PKdeB+cCg==
X-CSE-MsgGUID: 6IeqhcPeR8Cvw6LQ2Xrg9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,231,1708416000"; 
   d="scan'208";a="48575584"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.43])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 00:06:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 26 Apr 2024 10:06:38 +0300 (EEST)
To: Babu Moger <babu.moger@amd.com>
cc: fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>, 
    shuah@kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-kselftest@vger.kernel.org, 
    =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= <maciej.wieczor-retman@intel.com>, 
    peternewman@google.com, eranian@google.com
Subject: Re: [PATCH v2 4/4] selftests/resctrl: Enable MBA/MBA tests on AMD
In-Reply-To: <e3bf1fbbe3ab2d9c2dc1d9669a791de140dea248.1714073751.git.babu.moger@amd.com>
Message-ID: <911547f7-e952-f771-867a-57c1de738c39@linux.intel.com>
References: <cover.1708637563.git.babu.moger@amd.com> <cover.1714073751.git.babu.moger@amd.com> <e3bf1fbbe3ab2d9c2dc1d9669a791de140dea248.1714073751.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 25 Apr 2024, Babu Moger wrote:

> Enable MBA/MBM tests if UMC (Unified Memory Controller) support is
> available on the system. Tests will be skipped otherwise.
> 
> Update noncont_cat_run_test to check for vendor. AMD supports
> non contiguous CBM masks but does not report it via CPUID.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  tools/testing/selftests/resctrl/cat_test.c | 2 +-
>  tools/testing/selftests/resctrl/mba_test.c | 1 -
>  tools/testing/selftests/resctrl/mbm_test.c | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 4cb991be8e31..b682eaf65bfd 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -314,7 +314,7 @@ static int noncont_cat_run_test(const struct resctrl_test *test,
>  	else
>  		return -EINVAL;
>  
> -	if (sparse_masks != ((ecx >> 3) & 1)) {
> +	if ((get_vendor() == ARCH_INTEL) && sparse_masks != ((ecx >> 3) & 1)) {

This looks independent change to me which should be put into own patch.

-- 
 i.

>  		ksft_print_msg("CPUID output doesn't match 'sparse_masks' file content!\n");
>  		return 1;
>  	}
> diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
> index 7946e32e85c8..353054724fa7 100644
> --- a/tools/testing/selftests/resctrl/mba_test.c
> +++ b/tools/testing/selftests/resctrl/mba_test.c
> @@ -177,7 +177,6 @@ static bool mba_feature_check(const struct resctrl_test *test)
>  struct resctrl_test mba_test = {
>  	.name = "MBA",
>  	.resource = "MB",
> -	.vendor_specific = ARCH_INTEL,
>  	.feature_check = mba_feature_check,
>  	.run_test = mba_run_test,
>  };
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d67ffa3ec63a..f2223315b5b8 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -147,7 +147,6 @@ static bool mbm_feature_check(const struct resctrl_test *test)
>  struct resctrl_test mbm_test = {
>  	.name = "MBM",
>  	.resource = "MB",
> -	.vendor_specific = ARCH_INTEL,
>  	.feature_check = mbm_feature_check,
>  	.run_test = mbm_run_test,
>  };
> 

