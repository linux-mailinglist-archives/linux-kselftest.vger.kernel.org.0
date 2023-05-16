Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F793705B12
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 01:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjEPXOt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 May 2023 19:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjEPXOt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 May 2023 19:14:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658DB49DB;
        Tue, 16 May 2023 16:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684278888; x=1715814888;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JCw5VDXXb5Zk0n4g9fN35Q/ecw5PPviAKCFFmpEcKTs=;
  b=NdglkvaXRyGZP2tYkouuhQj2/jqf7Owaeu8tyl2OILy04B76yppM4ggb
   DIemWnRsqt5jDmPpmVfeGorAXCXu/aKBklklRdOobagAdIuAjI+9OaqSs
   MTxMtUNpnwu2b6tLH7vVNsIpJgLl1xVA3NuKAKGB7soLTxQl/Tn0v6a4H
   L8rrp8mJsCXL1NY6M7oKvZshfMZ9lxKgjfq0g6N2Fy8ETK5Ag6HmZcHF0
   qOjthJmVrAGYc+3VbJglabyXyXOMlTD5Q++k5KHra2esp0JkxyiDXbHgE
   qQt7yX6xZckkmzo4e7gSzuBYGLYe1nCYMO5i6YgmpfFoKws6P5gmR4G3j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="415019732"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="415019732"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:14:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10712"; a="679039950"
X-IronPort-AV: E=Sophos;i="5.99,280,1677571200"; 
   d="scan'208";a="679039950"
Received: from mtpanu-mobl1.amr.corp.intel.com (HELO [10.212.203.6]) ([10.212.203.6])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2023 16:14:47 -0700
Message-ID: <6cb7df56-0479-30be-5389-b4b819572deb@intel.com>
Date:   Tue, 16 May 2023 16:14:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] PKEY: Introduce PKEY_ENFORCE_API flag
Content-Language: en-US
To:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-2-jeffxu@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230515130553.2311248-2-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 06:05, jeffxu@chromium.org wrote:
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -20,7 +20,7 @@ int __execute_only_pkey(struct mm_struct *mm)
>  	/* Do we need to assign a pkey for mm's execute-only maps? */
>  	if (execute_only_pkey == -1) {
>  		/* Go allocate one to use, which might fail */
> -		execute_only_pkey = mm_pkey_alloc(mm);
> +		execute_only_pkey = mm_pkey_alloc(mm, 0);
>  		if (execute_only_pkey < 0)
>  			return -1;
>  		need_to_set_mm_pkey = true;

In your threat model, what mechanism prevents the attacker from
modifying executable mappings?

I was trying to figure out if the implicit execute-only pkey should have
the PKEY_ENFORCE_API bit set.  I think that in particular would probably
cause some kind of ABI breakage, but it still reminded me that I have an
incomplete picture of the threat model.
