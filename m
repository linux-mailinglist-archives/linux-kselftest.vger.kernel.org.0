Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2F708AB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 May 2023 23:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjERVni (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 May 2023 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjERVnh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 May 2023 17:43:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D97B180;
        Thu, 18 May 2023 14:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684446216; x=1715982216;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FCvlPDXlcdJACB4EQCU/Yj0sO6IJ/Dvvnamlu77Mjcs=;
  b=LdaN1Y/g2IGsYIw63zwoBXhpb38rbFb4rd4FdtM9PqsU0Wcowg73HMrW
   6Glzmj2qvI6B8aSSWFTUVVPOz5YBZeqPeArRp7oQBJ/hYSIvNO0SaGFXW
   85ZgK38oQoqM+S1C5/h17NEcA+CbkStTwn/RLAXRnfoOPb/yhNP25wbGI
   He3hhQEJpAaE6lUCfmhKoUEaYNcQ/Kt5JR1TTtVK5RyoU5pvduOOYWgwe
   wko3GW70SMSyYcsDOJv0ockAGMV4Zdea2mYYOiJlDfa2wOQ08Fr4wtbXY
   DNFudSLusn0S6eRN4wV4yrmBh0HnPFAJIw8HGPbLYOq8/WV9mIZvfeXqm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="354547437"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="354547437"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:43:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="948850882"
X-IronPort-AV: E=Sophos;i="6.00,175,1681196400"; 
   d="scan'208";a="948850882"
Received: from nroy-mobl1.amr.corp.intel.com (HELO [10.209.81.123]) ([10.209.81.123])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2023 14:43:26 -0700
Message-ID: <6dbbc3da-78c9-8101-d52a-0be47da9d67e@intel.com>
Date:   Thu, 18 May 2023 14:43:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/6] PKEY: Add arch_check_pkey_enforce_api()
Content-Language: en-US
To:     jeffxu@chromium.org, luto@kernel.org, jorgelo@chromium.org,
        keescook@chromium.org, groeck@chromium.org, jannh@google.com,
        sroettger@google.com
Cc:     akpm@linux-foundation.org, jeffxu@google.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230515130553.2311248-1-jeffxu@chromium.org>
 <20230515130553.2311248-3-jeffxu@chromium.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230515130553.2311248-3-jeffxu@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 5/15/23 06:05, jeffxu@chromium.org wrote:
> +static inline int __arch_check_vma_pkey_for_write(struct vm_area_struct *vma)
> +{
> +	int pkey = vma_pkey(vma);
> +
> +	if (mm_pkey_enforce_api(vma->vm_mm, pkey)) {
> +		if (!__pkru_allows_write(read_pkru(), pkey))
> +			return -EACCES;
> +	}
> +
> +	return 0;
> +}

Please think very carefully about what I'm about to say:

What connects vma->vm_mm to read_pkru() here?

Now think about what happens when we have kthread_use_mm() or a ptrace()
doing get_task_mm() and working on another process's mm or VMA.

Look at arch_vma_access_permitted() and notice how it avoids read_pkru()
for 'foreign' aka. 'remote' accesses:

> static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
>                 bool write, bool execute, bool foreign)
> {
...
>         if (foreign || vma_is_foreign(vma))
>                 return true;
>         return // check read_pkru()
> }

In other words, it lets all remote accesses right through.  That's
because there is *NOTHING* that fundamentally and tightly connects the
PKRU value in this context to the VMA or the context that initiated this
operation.

If your security model depends on PKRU protection, this 'remote'
disconnection is problematic.  The PKRU enforcement inside the kernel is
best-effort.  That usually doesn't map into the security space very well.

Do you have a solid handle on all call paths that will reach
__arch_check_vma_pkey_for_write() and can you ensure they are all
non-remote?
