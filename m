Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD55A8597
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbiHaS2y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 14:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbiHaS2Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 14:28:16 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A9FBCCC6;
        Wed, 31 Aug 2022 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661970242; x=1693506242;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wXM2hIDhlZVfZnXfi1q7P4cdxCTlqnnAsMQBb9mpon4=;
  b=Zh5QJFrbuzP0UEXKMISBw2lcXRy3b6nm+/VSRmVSw7PN2AZ1HNbs6ISW
   NwzyLK44Gv8hFf5Z2R8VGqHC9kwVQaH7Xmak65Wt+a70oPyNMeIJ5Tq+u
   O3BGmbOGno6N5s3PFEGuGFyWNsC0v+bMjHfqUk2+Pdj/IkNp7mgkO5FGO
   QtIbXH2jx9S91M5kN6ysZfCWbmaBkU8ZltBvJEKCrX1yK1zNpX0cgEDkG
   c/B8FG3sPt9NoQ43ag1EcRXVzySl/bj9blIkXHqD8Z1ixpKDKX0onczdL
   ZwS56YYsZI0JFQ8ErbOuPkhTfhNDv21elm1kXhwXMshMpuv5EKt/lDAwc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="357232666"
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="357232666"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:23:56 -0700
X-IronPort-AV: E=Sophos;i="5.93,278,1654585200"; 
   d="scan'208";a="612187466"
Received: from nkrobins-mobl2.amr.corp.intel.com (HELO [10.212.220.19]) ([10.212.220.19])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 11:23:56 -0700
Message-ID: <e870df49-77ed-3222-086d-ae929107f33b@intel.com>
Date:   Wed, 31 Aug 2022 11:23:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking
 allocation errors
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>, linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
 <20220830031206.13449-7-jarkko@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20220830031206.13449-7-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/29/22 20:12, Jarkko Sakkinen wrote:
> diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
> new file mode 100644
> index 000000000000..9268d50dea29
> --- /dev/null
> +++ b/tools/testing/selftests/sgx/alloc-error.bt
> @@ -0,0 +1,7 @@
> +kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
> +		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
> +}
> +
> +kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
> +		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
> +}

I guess this doesn't _hurt_, but it's also not exactly the easiest way
to get this done.  You need a whole bpf toolchain.  You could also just do:

	perf probe 'sgx_encl_page_alloc%return $retval'

Even *that* can be replicated in a few scant lines of shell code echoing
into /sys/kernel/debug/tracing.
