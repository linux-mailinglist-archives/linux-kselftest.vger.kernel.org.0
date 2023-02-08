Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4993E68F052
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Feb 2023 15:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjBHOFf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Feb 2023 09:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjBHOFX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Feb 2023 09:05:23 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AA145BDF;
        Wed,  8 Feb 2023 06:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675865117; x=1707401117;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=XmGzZhXPepON125DcD74aqMImYN6xSf3KTV3TFcSd1c=;
  b=K6Q9chhVkFKsXoHZItmN70cxQH5yvo6HYbn2ramnoSJf/+yokJ2+LVQV
   d/doZmJWU2HQHi6VXYuLakWM5cz2sNrdVZJvAowrOjIMlf5xBx0ZCPg4d
   N8Uvy+6GsXPYPPpiEksyXk4Mx/g5ucpHsknoJCMKjGakDzA2xi3XZjkFH
   Wkixb1nw64acXXAMN1PXL3sUGxqMxXf1tai25syKQ8HSXUMUQ4YRR+d0H
   8ukxw9UxbLHXzlDtmPmdhn3gQEH/5bkmCCz4di2lFmZtVPosXaFbR0Dzt
   A9Um1b90LPrMrgE9nE4/p1KndxZ6U2rI8o5F7cxUp4EfQ+NDvbT59YV3S
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="331930886"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="331930886"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 06:04:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="660657667"
X-IronPort-AV: E=Sophos;i="5.97,280,1669104000"; 
   d="scan'208";a="660657667"
Received: from jstelter-mobl.ger.corp.intel.com ([10.252.38.39])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 06:04:29 -0800
Date:   Wed, 8 Feb 2023 16:04:27 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org
cc:     LKML <linux-kernel@vger.kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 3/4] selftests/resctrl: Change name from CBM_MASK_PATH
 to INFO_PATH
In-Reply-To: <20230208094026.22529-4-ilpo.jarvinen@linux.intel.com>
Message-ID: <2078baac-27ea-096-3a13-b88fe10aa78@linux.intel.com>
References: <20230208094026.22529-1-ilpo.jarvinen@linux.intel.com> <20230208094026.22529-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1222304298-1675858401=:1843"
Content-ID: <fe477438-ca74-4ef3-b1f8-6dd8b61b1fec@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1222304298-1675858401=:1843
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <82134ad4-63e-60d-eaf4-11a6338ef031@linux.intel.com>

On Wed, 8 Feb 2023, Ilpo Järvinen wrote:

> From: "Signed-off-by: Fenghua Yu" <fenghua.yu@intel.com>

I seem to have managed to do a little copy paste error there. I can 
resubmit the series if needed.

-- 
 i.

> CBM_MASK_PATH is actually the path to resctrl/info, so change the macro
> name to correctly indicate what it represents.
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrl.h   | 2 +-
>  tools/testing/selftests/resctrl/resctrlfs.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
> index f0ded31fb3c7..4f0976f12634 100644
> --- a/tools/testing/selftests/resctrl/resctrl.h
> +++ b/tools/testing/selftests/resctrl/resctrl.h
> @@ -28,7 +28,7 @@
>  #define MB			(1024 * 1024)
>  #define RESCTRL_PATH		"/sys/fs/resctrl"
>  #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
> -#define CBM_MASK_PATH		"/sys/fs/resctrl/info"
> +#define INFO_PATH		"/sys/fs/resctrl/info"
>  #define L3_PATH			"/sys/fs/resctrl/info/L3"
>  #define MB_PATH			"/sys/fs/resctrl/info/MB"
>  #define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 6f543e470ad4..cc6cf49e3129 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -210,7 +210,7 @@ int get_cbm_mask(char *cache_type, char *cbm_mask)
>  	if (!cbm_mask)
>  		return -1;
>  
> -	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
> +	sprintf(cbm_mask_path, "%s/%s/cbm_mask", INFO_PATH, cache_type);
>  
>  	fp = fopen(cbm_mask_path, "r");
>  	if (!fp) {
> 
--8323329-1222304298-1675858401=:1843--
