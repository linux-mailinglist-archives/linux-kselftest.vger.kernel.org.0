Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832E250B3E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Apr 2022 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388699AbiDVJVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 05:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446019AbiDVJUx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 05:20:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6FB53E2C;
        Fri, 22 Apr 2022 02:17:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF75460FC1;
        Fri, 22 Apr 2022 09:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3C4C385A0;
        Fri, 22 Apr 2022 09:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650619055;
        bh=iqCW7A6ZXIeIMzwpuEVmkMyobtqwXfhGzomkPzFjfhA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oNyJNZZ2f5Ve8HItc27uvfdt3nih+W6bsvDgzMBWo8zE92p1KCOXIFpmCO/yk2svr
         NeDzJCdc/qS4/GEQCLNaC9yLTLv2myCkq8pA6wY7MRjfLUhE+PZAbAuXFBLSCVxlXm
         CyRy3JBcN7xJlS+MYxgOyE0/32HEGtb5gyyXHiIPp7zqEmay59irQ+/qwVPebIvhKw
         wLH5/fYjGIZA4J0flSM8YFy/Ba90ANoJMHpN+m4mE//7t/a8QDB84F8f3IPqJm1SEf
         e98HDEpi+VxXtnkRYp9kVWhyH7KvTSLoalr8WdYtDVGQ49RXSKdArdPp7mHvir2tjJ
         RtA1svfSZCzqg==
Date:   Fri, 22 Apr 2022 12:16:19 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Shanahan, Mark" <mark.shanahan@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "Huang, Kai" <kai.huang@intel.com>,
        "Zhang, Cathy" <cathy.zhang@intel.com>,
        "Xing, Cedric" <cedric.xing@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 00/31] x86/sgx and selftests/sgx: Support SGX2
Message-ID: <YmJyYwp9UHRLWaTw@kernel.org>
References: <cover.1649878359.git.reinette.chatre@intel.com>
 <2f4338f37943c2b067db16ae65c9af665d3b51d9.camel@kernel.org>
 <9fbf26c8-5808-20c5-8653-d4f36bf398a4@intel.com>
 <42a52a6018e8dadb4c3eebefaae4dab31c0d5721.camel@kernel.org>
 <DM8PR11MB5591BBA189BC4EA5CFE2C7EAF6EF9@DM8PR11MB5591.namprd11.prod.outlook.com>
 <54f053d8bb6b72725b2351fc2016d20b65cebbf1.camel@kernel.org>
 <DM8PR11MB559180D1BA05B0E77D354467F6F49@DM8PR11MB5591.namprd11.prod.outlook.com>
 <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a94e4098-f5c1-f9ff-fab0-c2e5210cf188@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 21, 2022 at 08:29:31PM -0700, Reinette Chatre wrote:
> Hi Vijay and Mark,
> 
> On 4/21/2022 4:46 PM, Dhanraj, Vijay wrote:
> > Hi All,
> > 
> > I evaluated V4 patch changes with Gramine and ran into an issue when trying to set EPC page permission to PROT_NONE. It looks like with V3 patch series a change was introduced which requires kernel to have at least R permission when calling RESTRICT IOCTL. This change was done under the assumption that EPCM requires at least R permission for EMODPE/EACCEPT to succeed. But when testing with V2 version, EACCEPT worked fine with page permission set to PROT_NONE. 
> > 
> > Thanks to @Shanahan, Mark for confirming that EPCM does not need to have R value to allow EACCEPT or EMODPE. Given this, can we please revert this change?
> > 
> 
> Thank you very much for pointing this out. I can revert the change
> to what was done in V2 where the only check is to ensure that W requires R.
> This is a requirement of EMODPR. Could you please check if this snippet
> results in things working for you again?
> 
> ---8<---
> diff --git a/arch/x86/kernel/cpu/sgx/ioctl.c b/arch/x86/kernel/cpu/sgx/ioctl.c
> index 83674d054c13..7c7c8a61196e 100644
> --- a/arch/x86/kernel/cpu/sgx/ioctl.c
> +++ b/arch/x86/kernel/cpu/sgx/ioctl.c
> @@ -855,12 +855,8 @@ static long sgx_ioc_enclave_restrict_permissions(struct sgx_encl *encl,
>  	if (params.permissions & ~SGX_SECINFO_PERMISSION_MASK)
>  		return -EINVAL;
>  
> -	/*
> -	 * Read access is required for the enclave to be able to use the page.
> -	 * SGX instructions like ENCLU[EMODPE] and ENCLU[EACCEPT] require
> -	 * read access.
> -	 */
> -	if (!(params.permissions & SGX_SECINFO_R))
> +	if ((params.permissions & SGX_SECINFO_W) &&
> +	    !(params.permissions & SGX_SECINFO_R))
>  		return -EINVAL;
>  
>  	if (params.result || params.count)

Just adding that it's fine for me to revert this.

BR, Jarkko
