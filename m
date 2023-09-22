Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490597AAF92
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Sep 2023 12:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjIVKdM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Sep 2023 06:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbjIVKdK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Sep 2023 06:33:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9344180;
        Fri, 22 Sep 2023 03:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695378784; x=1726914784;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=SyfnY6W14HGgwMDg7wokjZ8/hcSfGXMKBGRrnXyYHJw=;
  b=n7uSUCWVK6dJt2g0d0cTHbckbpiS7V3yU/BcnVpG/LN1ufcd0Vb28nOF
   OGj6mi/35xj3kJcNLz0HHYZ3/2+ZlPigmwprxd6Ih6l1920W/LmEhLmIl
   rXuhSAn0MURz2fDRw7lPTk5+PfjZkVk7cWkIfhBiZGdJzuLoc2z/pVrDc
   KKoCx5X4IN5vOi/2wG7bA/eIiRlGs3ZfqJ4nOmyojQClR6Y/goY6kmSB8
   9Q1uFR+hAExU66weJVzT0NjVYDWZOe+ZR2iIEYK6aoa6nTfV7fcr4qcVN
   gpw1W9xGGj6/uAQpIXlPMS8/T/Uek8qT6agrAd4fEsyC80sIz/v0BXo2i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="380695477"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="380695477"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 03:30:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="921110159"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="921110159"
Received: from rblanarx-mobl.ger.corp.intel.com ([10.252.52.48])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 03:30:49 -0700
Date:   Fri, 22 Sep 2023 13:30:46 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 1/2] selftests/resctrl: Fix schemata write error
 check
In-Reply-To: <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
Message-ID: <8cae9816-15a7-b9df-7f41-9ea4a125c0b7@linux.intel.com>
References: <cover.1695369120.git.maciej.wieczor-retman@intel.com> <5e17ed39ffb8d6bd530c057aa04e3ffb997573a9.1695369120.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-428847694-1695378428=:1840"
Content-ID: <5f8cfbd2-7587-81d-9d96-b45675339813@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-428847694-1695378428=:1840
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <d7393897-f1d0-7a4f-40c8-33cc47f7d0a7@linux.intel.com>

On Fri, 22 Sep 2023, Maciej Wieczor-Retman wrote:

> Writing bitmasks to the schemata can fail when the bitmask doesn't
> adhere to constraints defined by what a particular CPU supports.
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
> Remove newline character from the schema string after writing it to
> the schemata file so it prints correctly before function return.
> 
> Pass the string generated with strerror() to the "reason" buffer so
> the error message is more verbose. Extend "reason" buffer so it can hold
> longer messages.
> 
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v4:
> - Unify error checking between open() and write(). (Reinette)
> - Add fcntl.h for glibc backward compatiblitiy. (Reinette)
> 
> Changelog v3:
> - Rename fp to fd. (Ilpo)
> - Remove strlen, strcspn and just use the snprintf value instead. (Ilpo)
> 
> Changelog v2:
> - Rewrite patch message.
> - Double "reason" buffer size to fit longer error explanation.
> - Redo file interactions with syscalls instead of stdio functions.
> 
>  tools/testing/selftests/resctrl/resctrlfs.c | 30 ++++++++++++---------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
> index 3a8111362d26..edc8fc6e44b0 100644
> --- a/tools/testing/selftests/resctrl/resctrlfs.c
> +++ b/tools/testing/selftests/resctrl/resctrlfs.c
> @@ -8,6 +8,7 @@
>   *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
>   *    Fenghua Yu <fenghua.yu@intel.com>
>   */
> +#include <fcntl.h>
>  #include <limits.h>
>  
>  #include "resctrl.h"
> @@ -490,9 +491,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
>   */
>  int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  {
> -	char controlgroup[1024], schema[1024], reason[64];
> -	int resource_id, ret = 0;
> -	FILE *fp;
> +	char controlgroup[1024], schema[1024], reason[128];
> +	int resource_id, fd, schema_len = -1, ret = 0;
>
>  	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
>  	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
> @@ -520,27 +520,31 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
>  
>  	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
>  	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
> -		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "L3:", resource_id, '=', schemata);
>  	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
>  	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
> -		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
> +		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
> +				      "MB:", resource_id, '=', schemata);
>  
> -	fp = fopen(controlgroup, "w");
> -	if (!fp) {
> -		sprintf(reason, "Failed to open control group");
> +	fd = open(controlgroup, O_WRONLY);
> +	if (!fd) {
> +		snprintf(reason, sizeof(reason),
> +			 "open() failed : %s", strerror(errno));
>  		ret = -1;
>  
>  		goto out;
>  	}
> -
> -	if (fprintf(fp, "%s\n", schema) < 0) {
> -		sprintf(reason, "Failed to write schemata in control group");
> -		fclose(fp);
> +	if (write(fd, schema, schema_len) < 0) {
> +		snprintf(reason, sizeof(reason),
> +			 "write() failed : %s", strerror(errno));
> +		close(fd);
>  		ret = -1;
>  
>  		goto out;
>  	}
> -	fclose(fp);
> +	close(fd);
> +	schema[schema_len - 1] = 0;
>  
>  out:
>  	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
> 

Thanks for fixing this.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-428847694-1695378428=:1840--
