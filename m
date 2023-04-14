Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF5D6E234B
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Apr 2023 14:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDNMcE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Apr 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDNMcC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Apr 2023 08:32:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E3319A8;
        Fri, 14 Apr 2023 05:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681475521; x=1713011521;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=DtfG+JYEslO+lbslUcYDrV41Boe8ZOwviHVMmeg2SyY=;
  b=am4f4qulZiqAN9mzyoBo26KFCwZeSMtsikG6QDJPffxE5UG7utZPMgwH
   sp8vOOEoECMwNFjh99IPz8dk75iGcyeOc2iSGdcHnQtMycpQastd6DE83
   wKf48SBPARg7WuouZ3+1JM0EA6/K+DXo28lbikNKzHjlh2dkwanIdRJHg
   WgQQ+e5Vd91brkeX/wadTllanJLaWdZ6tcU0gJHOlZw0/lqdDl+nKd/fW
   dIVYqTTTIcFe/cauTxx9AZtCG+ty7ozjnP1kVAhaBttZp6ZfDM14Ma3bN
   pKe960k3lbJV01X9x2I18Chjrul7Gl0KNLzvxSTcsM4xHPbXz5WJLa1+1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="344451286"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="344451286"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 05:32:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="833535318"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="833535318"
Received: from smiokx-mobl.amr.corp.intel.com ([10.252.57.49])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 05:31:58 -0700
Date:   Fri, 14 Apr 2023 15:31:55 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 1/6] selftests/resctrl: Fix set up schemata with 100%
 allocation on first run in MBM test
In-Reply-To: <20230413072259.2089348-2-tan.shaopeng@jp.fujitsu.com>
Message-ID: <bb65cce8-54d7-68c5-ef19-3364ec95392a@linux.intel.com>
References: <20230413072259.2089348-1-tan.shaopeng@jp.fujitsu.com> <20230413072259.2089348-2-tan.shaopeng@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1398643149-1681475520=:2245"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1398643149-1681475520=:2245
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Thu, 13 Apr 2023, Shaopeng Tan wrote:

> There is a comment "Set up shemata with 100% allocation on the first run"

s/shemata/schemata/

> in function mbm_setup(), but there is an increment bug and the condition
> "num_of_runs == 0" will never be met and write_schemata() will never be
> called to set schemata to 100%. Even if write_schemata() is called in MBM
> test, since it is not supported for MBM test it does not set the schemata.
> This is currently fine because resctrl_val_parm->mum_resctrlfs is always 1
> and umount/mount will be run in each test to set the schemata to 100%.
> 
> To support the usage when MBM test does not unmount/remount resctrl
> filesystem before the test starts, fix to call write_schemata() and
> set schemata properly when the function is called for the first time.
> 
> Also, remove static local variable 'num_of_runs' because this is not
> needed as there is resctrl_val_param->num_of_runs which should be used
> instead like in cat_setup().
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> ---
>  tools/testing/selftests/resctrl/mbm_test.c  | 13 +++++++------
>  tools/testing/selftests/resctrl/resctrlfs.c |  4 +++-
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
> index c9dfa54af42f..9b591c35310f 100644
> --- a/tools/testing/selftests/resctrl/mbm_test.c
> +++ b/tools/testing/selftests/resctrl/mbm_test.c
> @@ -89,23 +89,24 @@ static int check_results(int span)
>  static int mbm_setup(int num, ...)
>  {
>  	struct resctrl_val_param *p;
> -	static int num_of_runs;
>  	va_list param;
>  	int ret = 0;
>  
> -	/* Run NUM_OF_RUNS times */
> -	if (num_of_runs++ >= NUM_OF_RUNS)
> -		return END_OF_TESTS;
> -
>  	va_start(param, num);
>  	p = va_arg(param, struct resctrl_val_param *);
>  	va_end(param);
>  
> +	/* Run NUM_OF_RUNS times */
> +	if (p->num_of_runs >= NUM_OF_RUNS)
> +		return -1;

This is not rebased correctly, negative return values mean now errors.
To complete tests "normally", return END_OF_TESTS. Please see commit 
fa10366cc6f4 ("selftests/resctrl: Allow ->setup() to return errors") for 
future information.

With the forementioned problems fixed:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

> +
>  	/* Set up shemata with 100% allocation on the first run. */
> -	if (num_of_runs == 0)
> +	if (p->num_of_runs == 0)
>  		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
>  				     p->resctrl_val);
>  
> +	p->num_of_runs++;
> +
>  	return ret;
>  }
>  
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index cc6cf49e3129..b31b1d9e41d1 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -498,6 +498,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  	FILE *fp;
>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
> +	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
>  	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
>  	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>  		return -ENOENT;
> @@ -523,7 +524,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
>  		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> -	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
> +	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
> +	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
>  		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
>  
>  	fp = fopen(controlgroup, "w");
> 

--8323329-1398643149-1681475520=:2245--
