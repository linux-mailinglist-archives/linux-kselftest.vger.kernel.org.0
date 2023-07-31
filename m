Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1246769597
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 14:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjGaMH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 08:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjGaMHz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 08:07:55 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CDA10DF;
        Mon, 31 Jul 2023 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690805275; x=1722341275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gTwSW5Pi476YcxNfncRebsXRrqRzP0HUL96D8nDTvMw=;
  b=SPNSoy4XGadNl2dhVquzBqmy75S1LFJAXeJKrLfcs06TP1+iuimqP2+f
   HST5rF1M6eznCRVuReAZ04wmUleFSBKSHSQkbgzbQDE/o9y8R5Ne5Z1bH
   zZQyVg60XRe98gofIbnoQjTygqwKBjqWMXI8A2BaUM6JeqCMLaM89E+/m
   s2COu3BNxV/xK9JtVIWImViVv9beJJYn0zA16BkViZloZoqsle/VoUQIp
   EcfLJzsqYFPMX7FCIVPSWUzj6/6Bhe7RmsA9tFPpff/v9Ppo8UKplLwAA
   GaOV7UhczFOAsPOeZgr6bKRtPChR0wPtLbP3tRoeURsj63pXHgr2rYZi/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="455375338"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="455375338"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="798223224"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="798223224"
Received: from jkrzyszt-mobl2.ger.corp.intel.com ([10.213.1.128])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 05:07:51 -0700
From:   Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, igt-dev@lists.freedesktop.org,
        intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kunit: Allow kunit test modules to use test filtering
Date:   Mon, 31 Jul 2023 14:07:49 +0200
Message-ID: <1971193.8hb0ThOEGa@jkrzyszt-mobl2.ger.corp.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <202307311645.CdN0xKiF-lkp@intel.com>
References: <20230731054552.2145292-8-janusz.krzysztofik@linux.intel.com>
 <202307311645.CdN0xKiF-lkp@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Monday, 31 July 2023 10:39:03 CEST kernel test robot wrote:
> >> ERROR: modpost: "glob_match" [lib/kunit/kunit.ko] undefined!

Caused by CONFIG_GLOB possibly not selected when building kunit as a module  
(it was selected via another, unrelated setting in my test .config).

Please expect v3 with that fixed.

Thanks,
Janusz


