Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B737878DBAF
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Aug 2023 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238144AbjH3ShZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Aug 2023 14:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244050AbjH3MZT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Aug 2023 08:25:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDFDCC9;
        Wed, 30 Aug 2023 05:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693398315; x=1724934315;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=RYiqbz2oNOXYCRbRHLw0Mth3jZcI49jOAKwuZbR4ScU=;
  b=lZEirFI/yZO7FOYmno5MxS9usmpUVYtWxYPbdvvM75bR2emAQLn2ZjEZ
   6eke76e4IWFfJk70/3h9KnZdv7+yYcF9XBEvpv/jn5wNiPmMu5QozMuqa
   VpWXe+XaAF/u0/28kAdxe9y+AHsc8DhPaoc+abhKiTn99X2lDaEcYqGrJ
   T7vQcR9/05mlNd0xmmv8pAiffTsQzwqZhi3EOX9Rsdqv1uVdixdN2yg83
   m4YV2ml0PcmXUCUENyo3w4Q14mAyCC4wZ8qwVIKmKYA+V/u/uCueAgFQW
   7xZMcr87bRm2S52M2C5aHk1mZ0Kl1upS4A2RX2SokJwtH0BzNL8aTUMyF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="441991263"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="441991263"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="912770436"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="912770436"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.251.213.104])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 05:25:12 -0700
Date:   Wed, 30 Aug 2023 15:25:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>,
        Wieczor-Retman@linux.intel.com, linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] selftests/openat2: Fix wrong format specifier
In-Reply-To: <d71aa14c2a136d9faa7743b6bde414495f4b763c.1693216959.git.maciej.wieczor-retman@intel.com>
Message-ID: <d5f8dad8-51f-be61-79bb-c2747d192a@linux.intel.com>
References: <cover.1693216959.git.maciej.wieczor-retman@intel.com> <d71aa14c2a136d9faa7743b6bde414495f4b763c.1693216959.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-446756136-1693398314=:1710"
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

--8323329-446756136-1693398314=:1710
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Mon, 28 Aug 2023, Wieczor-Retman, Maciej wrote:

> Ksft_print_msg() inside test_openat2_flags() uses the wrong format
> specifier for printing test.how->flags variable.
> 
> Change the format specifier to %llX so it matches the printed variable.
> 
> Signed-off-by: Wieczor-Retman, Maciej <maciej.wieczor-retman@intel.com>
> ---
>  tools/testing/selftests/openat2/openat2_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
> index 7fb902099de4..9024754530b2 100644
> --- a/tools/testing/selftests/openat2/openat2_test.c
> +++ b/tools/testing/selftests/openat2/openat2_test.c
> @@ -300,7 +300,7 @@ void test_openat2_flags(void)
>  
>  			ksft_print_msg("openat2 unexpectedly returned ");
>  			if (fdpath)
> -				ksft_print_msg("%d['%s'] with %X (!= %X)\n",
> +				ksft_print_msg("%d['%s'] with %X (!= %llX)\n",
>  					       fd, fdpath, fdflags,
>  					       test->how.flags);
>  			else
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-446756136-1693398314=:1710--
