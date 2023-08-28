Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7C78AD2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Aug 2023 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjH1KqW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Aug 2023 06:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjH1Kp5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Aug 2023 06:45:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2A2129;
        Mon, 28 Aug 2023 03:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219537; x=1724755537;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q+69r2rmzIAKl6Xe5yxs+Dm5CM3wtqRPBtFXdywLmek=;
  b=oCsOKz54Iw5/oMNN5a0EsvVJIfZ65teOz6w7LJsqU7ih6EUG2Kt+B2fN
   dTxObBm/6RxOesJWmJVenOaWwPL7keLuWocWcpRjfKBxTU8+CxDB2JeDe
   52+ANwO6uUL1jF8NPRQNB/hMe9T97jdVEHOt+VCEk0LUTx6Cvt1ZXlxJH
   bj4QnknQGk44y1O5Y6zP50ozqRTDJpH/J8EnQgPik2kCA+bZ4mPRMmJU7
   lPsCF03H1LWY+1aq7s67wZHXnUrBOsrvOSjZNnHj+AOR3hEEAqNj0DwLu
   sI3JncVwLORQCFoVj5alPuACblqf2l6OpdLN+I7brQKtJe1HB29/MajKf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="354593634"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="354593634"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:45:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="852798278"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="852798278"
Received: from gliakhov-mobl.ger.corp.intel.com ([10.251.214.48])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:45:10 -0700
Date:   Mon, 28 Aug 2023 13:43:05 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        fenghua.yu@intel.com, Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [PATCH v2 1/2] selftests/resctrl: Fix schemata write error
 check
In-Reply-To: <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
Message-ID: <ba3f3a7c-fe41-20b8-6999-492718d7a83a@linux.intel.com>
References: <cover.1693213468.git.maciej.wieczor-retman@intel.com> <6c263fdd2b09060e667d179be13ce8f989821673.1693213468.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:

> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to some constraints defined by what a particular CPU supports.
> Some example of constraints are max length or having contiguous bits.
> The driver should properly return errors when any rule concerning
> bitmask format is broken.
> 
> Resctrl FS returns error codes from fprintf() only when fclose() is
> called. Current error checking scheme allows invalid bitmasks to be
> written into schemata file and the selftest doesn't notice because the
> fclose() error code isn't checked.
> 
> Substitute fopen(), flose() and fprintf() with open(), close() and
> write() to avoid error code buffering between fprintf() and fclose().
> 
> Add newline to the end of the schema string so it satisfies rdt
> schemata writing requirements.
> 
> Remove newline character from the schemat string after writing it to
> the schemata file so it prints correctly before function return.
> 
> Pass the string generated with strerror() to the "reason" buffer so
> the error message is more verbose. Extend "reason" buffer so it can hold
> longer messages.
> 
> Changelog v2:
> - Rewrite patch message.
> - Double "reason" buffer size to fit longer error explanation.
> - Redo file interactions with syscalls instead of stdio functions.
> 
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/resctrl/resctrlfs.c | 24 +++++++++++----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index bd36ee206602..0f9644e5a25e 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -488,9 +488,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   */
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  {
> -	char controlgroup[1024], schema[1024], reason[64];
> -	int resource_id, ret = 0;
> -	FILE *fp;
> +	char controlgroup[1024], schema[1024], reason[128];
> +	int resource_id, fp, ret = 0;

fp -> fd to follow the usual convention.

>  
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
> @@ -518,27 +517,30 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> +		snprintf(schema, sizeof(schema), "%s%d%c%s\n", "L3:",
> +			 resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> +		snprintf(schema, sizeof(schema), "%s%d%c%s\n", "MB:",
> +			 resource_id, '=', schemata);
>  
> -	fp = fopen(controlgroup, "w");
> +	fp = open(controlgroup, O_WRONLY);
>  	if (!fp) {
>  		sprintf(reason, "Failed to open control group");
>  		ret = -1;
>  
>  		goto out;
>  	}
> -
> -	if (fprintf(fp, "%s\n", schema) < 0) {
> -		sprintf(reason, "Failed to write schemata in control group");
> -		fclose(fp);
> +	if (write(fp, schema, strlen(schema)) < 0) {

snprintf() returns you the length, just store the return value and there's 
no need to calculate it here.

> +		snprintf(reason, sizeof(reason),
> +			 "write() failed : %s", strerror(errno));
> +		close(fp);
>  		ret = -1;
>  
>  		goto out;
>  	}
> -	fclose(fp);
> +	close(fp);
> +	schema[strcspn(schema, "\n")] = 0;

Here too you can use the known length/index instead of strcspr().


-- 
 i.

