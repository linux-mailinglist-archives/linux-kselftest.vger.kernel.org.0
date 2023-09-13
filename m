Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFBF79E645
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 13:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbjIMLNA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Sep 2023 07:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240185AbjIMLMo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Sep 2023 07:12:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0C4269E;
        Wed, 13 Sep 2023 04:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694603515; x=1726139515;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=VHUWoD/roHyj/qGPGu4h28TjTTN+mTvBmIXq8WsKj3s=;
  b=SS7wly06czLFDVyX0y3+f6EAx3RHWrdjUbZAGKrJhJitlOVpBOlsZP8r
   Q24Y/s0lYZYWiStcFy9Q/+GGWNRfHAwy8KvxG15Uw0RP5225/O9M/e+rE
   vAJSjPJnSKyBDqdH2cSskffFZCawGbgSD+AeaNxOSRioeXaAuyNXdgDpM
   E0MPVaNoUGso4SHPKCrkLWSBh2BS/OCWeeta2vxlrYzpFyOroQsUANngs
   2AyqgnPURwApbumb7dGNygc623C0kwEQyCSp7qsLucRwrEk2Lx2dhd5pS
   PYq05Hoh8l7MvR0QXRHm05ONXJiJm0TyAcp0c7KUWvYGpGvSaS+1iqpVr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="377542830"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377542830"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:11:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="779153211"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="779153211"
Received: from pakurapo-mobl3.ger.corp.intel.com ([10.249.45.213])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 04:11:52 -0700
Date:   Wed, 13 Sep 2023 14:11:49 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
cc:     Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?ISO-8859-15?Q?Maciej_Wiecz=F3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests/resctrl: Remove duplicate feature check
 from CMT test
In-Reply-To: <40ba8890-32d1-e440-29fd-b8f8db69acc5@intel.com>
Message-ID: <80695068-4a6-b8e9-107f-8d29ab3543be@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com> <20230911111930.16088-3-ilpo.jarvinen@linux.intel.com> <40ba8890-32d1-e440-29fd-b8f8db69acc5@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1605740400-1694603126=:1849"
Content-ID: <6ca3d189-89cb-9f2-1b72-3c212a2531aa@linux.intel.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1605740400-1694603126=:1849
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b25a55e8-9e13-4346-c9b4-9dc2c98a98@linux.intel.com>

On Tue, 12 Sep 2023, Reinette Chatre wrote:
> On 9/11/2023 4:19 AM, Ilpo Järvinen wrote:
> > The test runner run_cmt_test() in resctrl_tests.c checks for CMT
> > feature and does not run cmt_resctrl_val() if CMT is not supported.
> > Then cmt_resctrl_val() also check is CMT is supported.
> > 
> > Remove the duplicated feature check for CMT from cmt_resctrl_val().
> > 
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> > Cc: <stable@vger.kernel.org>
> 
> This does not look like stable material to me. 

I know but when constructing this series I had 2 options:

Either convert also this when changing validate_resctrl_feature_request() 
or remove this call entirely.

Given it's duplicate of the other CMT check, I chose to just remove it 
(which I'd do anyway). As patch 4/5 requires 3/5 which in turn requires 
this, this has to go stable if 4/5 goes too.

-- 
 i.
--8323329-1605740400-1694603126=:1849--
