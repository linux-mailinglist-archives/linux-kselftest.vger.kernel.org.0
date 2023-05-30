Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 629A0715A3E
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 11:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjE3Jdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 05:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjE3JdY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 05:33:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77F8F9;
        Tue, 30 May 2023 02:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685439202; x=1716975202;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05BdlmfEmHrP3826u78d0bwZDk474BhNjCAib6bQs+I=;
  b=MXBWCNv+l+yblVqIRbS2NBlrfpfT5P32BnnL4Yq2o3ULNTnxc/FeISQ7
   eRpvcGLXA92nzKak3iXjAdktj5T/O7iZs+a/ZgrQI8tbYY0GC/fwyO41t
   OmGBSpv8LpwUZWJgi6+IpN+ZhWh01DzeEDYmgDlCHxbiw+FW/kU67HQe8
   DJ49Tr7EZ3lNwJJAwj3eWCvrJzs02Wh70OooH2/MJMZx62lLhp6t5IoRv
   NmMsbZ4jsVlAHNP45XRMVYThKXN1U4qbbBA7KEVSTJz5hNr8aTddxI7f5
   0Z9J0K0vqACr6J8OeMfqDHbcgLM1pn17xGZ3MgUeOU4lNuX/vD143jijm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="354877280"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="354877280"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 02:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="656775530"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="656775530"
Received: from lkp-server01.sh.intel.com (HELO fd90924b3b99) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 May 2023 02:33:19 -0700
Received: from kbuild by fd90924b3b99 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q3vjC-0000Fi-0P;
        Tue, 30 May 2023 09:33:18 +0000
Date:   Tue, 30 May 2023 17:32:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     jeffxu@chromium.org, dave.hansen@intel.com, luto@kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jannh@google.com, sroettger@google.com
Cc:     oe-kbuild-all@lists.linux.dev, akpm@linux-foundation.org,
        jeffxu@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v1 4/6] PKEY:selftest pkey_enforce_api for mprotect
Message-ID: <202305301758.ddYd6um5-lkp@intel.com>
References: <20230519011915.846407-5-jeffxu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519011915.846407-5-jeffxu@chromium.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab]

url:    https://github.com/intel-lab-lkp/linux/commits/jeffxu-chromium-org/PKEY-Introduce-PKEY_ENFORCE_API-flag/20230519-093355
base:   ba0ad6ed89fd5dada3b7b65ef2b08e95d449d4ab
patch link:    https://lore.kernel.org/r/20230519011915.846407-5-jeffxu%40chromium.org
patch subject: [PATCH v1 4/6] PKEY:selftest pkey_enforce_api for mprotect
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce:
        # https://github.com/intel-lab-lkp/linux/commit/ee635a3d72bf9f400d3542d27d1df9d2813640dc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review jeffxu-chromium-org/PKEY-Introduce-PKEY_ENFORCE_API-flag/20230519-093355
        git checkout ee635a3d72bf9f400d3542d27d1df9d2813640dc
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202305301758.ddYd6um5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from pkey_enforce_api.c:72:
   pkey-x86.h: In function 'expect_fault_on_read_execonly_key':
>> pkey-x86.h:165:13: warning: variable 'ptr_contents' set but not used [-Wunused-but-set-variable]
     165 |         int ptr_contents;
         |             ^~~~~~~~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
