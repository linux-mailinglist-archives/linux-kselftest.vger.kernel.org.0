Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4FE7CD617
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 10:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjJRIKW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Oct 2023 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjJRIKV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Oct 2023 04:10:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA22BC;
        Wed, 18 Oct 2023 01:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697616619; x=1729152619;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WbhQp5DnI6x50yIcBVCU/80yZlcZEbcu2Qwlg67e8/A=;
  b=DWh954AdZtBZQmb+1flcxl7Zg0StmZjnA7z2VE3hDdq6O0PK+LZT4XuP
   SMFUPCjxRgdnPkE7YTzWvToGjJ/j3WVDUsoo3MqFt0SHpPpXxuAg/rpma
   kDMX/tQIaer2Ubi/aoHY7TlaxRZbM2K1rRSSQvy0Yb1/qw0cs9swE9iZv
   RlQGWhugQ6+GhtomhKaJtbq7pGNZBz4n7Wibk9DzP6Gi3awJ6nB5+xvLj
   cxHfj0XyVsTHUysUKjzb32KNIxI7VrsVVqfnQ5ZBJd5SivEyJB90AteVK
   /4cBgIS80R7E7nXeLvnV1NjS1feVRY6I0pX5oWcRzxpdClqs/NrwO7OVr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="383187249"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="383187249"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 01:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="930078661"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="930078661"
Received: from gruberda-mobl1.ger.corp.intel.com ([10.252.62.52])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2023 01:10:17 -0700
Date:   Wed, 18 Oct 2023 11:10:10 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
cc:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v2 1/1] selftests/resctrl: Fix MBM test failure when MBA
 unavailable
In-Reply-To: <20231018075526.2251-1-ilpo.jarvinen@linux.intel.com>
Message-ID: <9965dc22-16fb-cadc-2b5f-ff7c2c91a173@linux.intel.com>
References: <20231018075526.2251-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-507791766-1697616245=:2178"
Content-ID: <5e4e6ac6-c2de-5f27-ba81-3db64b19e1aa@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-507791766-1697616245=:2178
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <185dd7a9-fe4a-b473-2e4a-41be8a2027e8@linux.intel.com>

On Wed, 18 Oct 2023, Ilpo Järvinen wrote:

> Commit 20d96b25cc4c ("selftests/resctrl: Fix schemata write error
> check") exposed a problem in feature detection logic in MBM selftest.
> If schemata does not support MB:x=x entries, the schemata write to
> initialize 100% memory bandwidth allocation in mbm_setup() will now
> fail with -EINVAL due to the error handling corrected by the commit
> 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check").
> That commit just uncovers the failed write, it is not wrong itself.
> 
> If MB:x=x is not supported by schemata, it is safe to assume 100%
> memory bandwidth is always set. Therefore, the previously ignored error
> does not make the MBM test itself wrong.
> 
> Restore the previous behavior of MBM test by checking MB support before
> attempting to write it into schemata which results in behavior
> equivalent to ignoring the write error.
> 
> Fixes: 20d96b25cc4c ("selftests/resctrl: Fix schemata write error check")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> ---

It seems it's too early morning for me so I entirely forgot to describe 
the changes I made... doh. So here it is (nothing earth-shattering here 
really):

v2:
- Make checkpatch --strict happy.
  - Remove () that --strict called "extra".
  - Duplicate the referenced commit description in the changelog
    to follow the commit formatting guidelines.
  - Alter the wording at one of the references into the commit 
    20d96b25cc4c in order to avoid having to copy the description
    there too.
- Added Reinette's rev-by.

-- 
 i.


>  tools/testing/selftests/resctrl/mbm_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index d3c0d30c676a..741533f2b075 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -95,7 +95,7 @@ static int mbm_setup(struct resctrl_val_param *p)
>  		return END_OF_TESTS;
>  
>  	/* Set up shemata with 100% allocation on the first run. */
> -	if (p->num_of_runs == 0)
> +	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
>  		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
>  				     p->resctrl_val);
>  
> 
--8323329-507791766-1697616245=:2178--
