Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9408878DBC1
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbjH3Shg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243872AbjH3MCi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 08:02:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A21B0;
        Wed, 30 Aug 2023 05:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693396955; x=1724932955;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1degSlUV8LRbIbk2hC2XASw2C2v2cLyXXAVR2XjG63I=;
  b=HL2zdzEHWGjDIniG24gabe3BKC2YJy7bvTOZTRJbKv05PErp7k293Esh
   1Gyx/B+xd9H2uvDPrKClCc/MUOvHCVdYJ6NLwq+Rt62vAriws7r0ezI49
   6TU5cnC92H1kiav1C/FdxciO1NqxOB1ciP5kEwAY0ADQMSCrnSXuFYvuC
   DNU1sVLcG5mcOGpkdwkA9BcbDxDiQytMemzFw5O1xpWA0L+fNGiiOcIGw
   ri9qJLHiJ0AU9+5k8XI06ZkFdNAs6XbnZRYOO11MmZAbjCOfzP/cJHMSb
   P4eTtgwv9qN7dACPmUvgXZa4bAVkefm53X1i9/T9DLE9jiQXLpTnMWCWy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="375577493"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="375577493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:02:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="774093734"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="774093734"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.251.213.104])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:02:19 -0700
Date:   Wed, 30 Aug 2023 15:02:17 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@linux.intel.com, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/6] selftests/sigaltstack: Fix wrong format specifier
In-Reply-To: <613189f12a8c15df7dc725e4b7ed66ffa4b30fb5.1693216959.git.maciej.wieczor-retman@intel.com>
Message-ID: <46e34e14-165-348f-aefd-372afe2e492@linux.intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com> <613189f12a8c15df7dc725e4b7ed66ffa4b30fb5.1693216959.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-454672902-1693396941=:1710"
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

--8323329-454672902-1693396941=:1710
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:

> The format specifier inside ksft printing function expects a long
> unsigned int but the passed variable is of unsigned int type.
> 
> Fix the format specifier so it matches the passed variable.
> 
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/sigaltstack/sas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
> index 98d37cb744fb..07227fab1cc9 100644
> --- a/tools/testing/selftests/sigaltstack/sas.c
> +++ b/tools/testing/selftests/sigaltstack/sas.c
> @@ -111,7 +111,7 @@ int main(void)
>  
>  	/* Make sure more than the required minimum. */
>  	stack_size = getauxval(AT_MINSIGSTKSZ) + SIGSTKSZ;
> -	ksft_print_msg("[NOTE]\tthe stack size is %lu\n", stack_size);
> +	ksft_print_msg("[NOTE]\tthe stack size is %u\n", stack_size);
>  
>  	ksft_print_header();
>  	ksft_set_plan(3);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-454672902-1693396941=:1710--
