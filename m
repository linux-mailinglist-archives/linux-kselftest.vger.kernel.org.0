Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B197D98AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Oct 2023 14:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345913AbjJ0Mn3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 08:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345927AbjJ0Mn2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 08:43:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2EABF;
        Fri, 27 Oct 2023 05:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698410605; x=1729946605;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rkxLKXX3snELVl5yABYiGXuIXx2/oJVoYCNcagoyfXA=;
  b=UFErpLb2ztpIT8XPS0lSlHsTrQfm7sBUZkJRHDwJrjmnd4TW1hzwVHpQ
   97zRh2OeOC+H544yjuPqoLhnTwkCmPKDXdgYT7v5sABPKouNfRtwFshph
   p29S3qkUeTzyQj9as/g5jJZQFy6b1r5TUD3RofxdrwL63S4QLk3nufieH
   3uydnOkzsvz+uXdv5pHXF+wCRSS5689QH1XwvrRsuyWcHKYW9gBPJLgP/
   8/zF8gjAfkHA2XMu5iCBHP/LMbgRxixcmlsWPAwbtt8A/sPn7r33CrlAI
   jB6ITGO03ZcnttJ+iEWKGfDhh0d6XaWAN0ndM79Ra+4Ysj2Rj3wukUMD5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="387582611"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="387582611"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="823091"
Received: from scoltan-mobl.ger.corp.intel.com ([10.252.33.159])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 05:43:11 -0700
Date:   Fri, 27 Oct 2023 15:43:20 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
cc:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/24] selftests/resctrl: Create struct for input
 parameter
In-Reply-To: <sjug356qdmnz4wdhzw4v4pa5vndibo52ght2vtz7gzhk5elgem@hi5eyxepp3bl>
Message-ID: <98b446f6-cf96-b1d6-b499-61a654ecb6@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com> <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com> <sjug356qdmnz4wdhzw4v4pa5vndibo52ght2vtz7gzhk5elgem@hi5eyxepp3bl>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-447580575-1698410604=:2740"
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

--8323329-447580575-1698410604=:2740
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Fri, 27 Oct 2023, Maciej Wieczór-Retman wrote:

> On 2023-10-24 at 12:26:27 +0300, Ilpo Järvinen wrote:
> >resctrl_tests reads a set of parameters and passes them individually
> >for each tests. The way the parameters passed varies between tests.
> 
> "the parameters passed" -> "the parameters are passed"?

I ended up rewriting this sentence completely to make it more obvious 
it's about call signature variations.

> >Add struct input_params to hold are input parameters. It can be easily
> 
> "to hold are input parameters" -> "to hold input parameters"?

I intended to write "to hold all input parameters".

-- 
 i.

--8323329-447580575-1698410604=:2740--
