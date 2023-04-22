Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553A46EB731
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Apr 2023 05:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDVDrl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Apr 2023 23:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVDrk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Apr 2023 23:47:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402A51FF1;
        Fri, 21 Apr 2023 20:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682135259; x=1713671259;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSLCXbVVatEMzVoM1qtANKX2CM4Zh2BjCrV2sdtYG+A=;
  b=iD5+UXhKmDeKAg+w1kvAo+ygMMs6+bqp2gXf4Fc/mS3Ne+07VQCqt+SM
   8+C4fqEpiTMV7KNv7bwaoYXvFYikA08A7Q9DFa1KMKAtXDvDbMd0ovvMw
   bOq8B0zUbRVQ345T+uROD5yCRFQvzNlAb8yZ9yZkFnG7MvPhFvu2tQ7Cu
   ueSJ0fb7kwzT8JGRxzssGgAe7dwZtGRO5W06XLapi93OcrRRZ85mIXRmY
   1tGscbZeAadSbz/1+b2AHwygAj0vR2dBwnb3sO3K84yQ3A4+DXAeYIuLH
   bttyddSKwizWP2pevWZLaVoxKZoFGWlMWo/TASgSen+CyTDfpKG7rju5j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="343610975"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="343610975"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2023 20:47:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10687"; a="816640029"
X-IronPort-AV: E=Sophos;i="5.99,216,1677571200"; 
   d="scan'208";a="816640029"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2023 20:47:34 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pq4Dl-000h2s-1a;
        Sat, 22 Apr 2023 03:47:33 +0000
Date:   Sat, 22 Apr 2023 11:47:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rae Moar <rmoar@google.com>, frowand.list@gmail.com,
        davidgow@google.com, skhan@linuxfoundation.org,
        keescook@chromium.org, Tim.Bird@sony.com, brendanhiggins@google.com
Cc:     oe-kbuild-all@lists.linux.dev, corbet@lwn.net,
        guillaume.tucker@collabora.com, dlatypov@google.com,
        kernelci@lists.linux.dev, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Subject: Re: [KTAP V2 PATCH] ktap_v2: add test metadata
Message-ID: <202304221132.H0D5OLHS-lkp@intel.com>
References: <20230420205734.1288498-1-rmoar@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420205734.1288498-1-rmoar@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Rae,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 906f02e42adfbd5ae70d328ee71656ecb602aaf5]

url:    https://github.com/intel-lab-lkp/linux/commits/Rae-Moar/ktap_v2-add-test-metadata/20230421-045838
base:   906f02e42adfbd5ae70d328ee71656ecb602aaf5
patch link:    https://lore.kernel.org/r/20230420205734.1288498-1-rmoar%40google.com
patch subject: [KTAP V2 PATCH] ktap_v2: add test metadata
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/9a01de0a8d8f9f09023184d9df00aa98a559c871
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Rae-Moar/ktap_v2-add-test-metadata/20230421-045838
        git checkout 9a01de0a8d8f9f09023184d9df00aa98a559c871
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304221132.H0D5OLHS-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/dev-tools/ktap.rst:184: WARNING: Unexpected indentation.
>> Documentation/dev-tools/ktap.rst:185: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +184 Documentation/dev-tools/ktap.rst

   181	
   182	There are a few currently recognized metadata types:
   183	- "# Subtest: <test_name>" to indicate test name (name must match
 > 184	  corresponding result line)
 > 185	- "# Attributes: <attributes list>" to indicate test attributes (list
   186	  separated by commas)
   187	- "# File: <file_path>" to indicate file used in testing
   188	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
