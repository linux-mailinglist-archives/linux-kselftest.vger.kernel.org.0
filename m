Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D599502B56
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Apr 2022 15:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354157AbiDON5w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Apr 2022 09:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354196AbiDON5a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Apr 2022 09:57:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256305581;
        Fri, 15 Apr 2022 06:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650030901; x=1681566901;
  h=to:cc:subject:references:date:mime-version:
   content-transfer-encoding:from:message-id:in-reply-to;
  bh=rnIvYvNkZSMlVf1curZVeeehjye1dFlSwJzy1pjQQ4A=;
  b=LjIollzPWpojXfctNvSRs6aV5pa/IfK37H8+wQunCeuBb3S3LNhHUNys
   Vb1V19gjb3qJuhMjht+TvRW1k+1W6ni+ozPPfv7MENW0VDTCzfOLGJ1XN
   0c33Cgg8mp+a6baHdh+VvH8whbLybODaU0mpFRET/zXMtOks3ARkXKThp
   ZUbJNH0z92TgI6Hvizf+h7a7DfXht2kD9kcg05bdjZjLb0SwgTR76N8jY
   yPR8bodq0IqoX7D1dns3jcm+A/St50DMzX600LOyjAEbY5SA8X4A9EBQA
   aEpmP/GZo2zfhZa4DZw3ZJAMfnYo6i/54KY7Tjaf3iN8PDSVZxnioLsrY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250454121"
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="250454121"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 06:55:00 -0700
X-IronPort-AV: E=Sophos;i="5.90,262,1643702400"; 
   d="scan'208";a="662093589"
Received: from fkchan-mobl1.amr.corp.intel.com (HELO hhuan26-mobl1.mshome.net) ([10.212.59.147])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 15 Apr 2022 06:54:58 -0700
Content-Type: text/plain; charset=iso-8859-15; format=flowed; delsp=yes
To:     "Jarkko Sakkinen" <jarkko@kernel.org>, dave.hansen@linux.intel.com,
        tglx@linutronix.de, bp@alien8.de, luto@kernel.org,
        mingo@redhat.com, linux-sgx@vger.kernel.org, x86@kernel.org,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        "Reinette Chatre" <reinette.chatre@intel.com>
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 14/31] x86/sgx: Support VA page allocation without
 reclaiming
References: <cover.1649878359.git.reinette.chatre@intel.com> <0ab32196f5056b25c34fb89fcc4dc28a5d875d2e.1649878359.git.reinette.chatre@intel.com> <bf2fcc93babdbf541fffc6cc5f5756f391773a75.camel@kernel.org> <767b99c5-f28e-4b8f-5147-6e1d290ca5c6@intel.com>
Date:   Fri, 15 Apr 2022 08:54:53 -0500
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From:   "Haitao Huang" <haitao.huang@linux.intel.com>
Organization: Intel Corp
Message-ID: <op.1kn59r1bwjvjmi@hhuan26-mobl1.mshome.net>
In-Reply-To: <767b99c5-f28e-4b8f-5147-6e1d290ca5c6@intel.com>
User-Agent: Opera Mail/1.0 (Win32)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 14 Apr 2022 11:30:34 -0500, Reinette Chatre  
<reinette.chatre@intel.com> wrote:

> Hi Jarkko,
>
> On 4/14/2022 4:18 AM, Jarkko Sakkinen wrote:
>> On Wed, 2022-04-13 at 14:10 -0700, Reinette Chatre wrote:
>>> struct sgx_encl should be protected with the mutex
>>> sgx_encl->lock. One exception is sgx_encl->page_cnt that
>>> is incremented (in sgx_encl_grow()) when an enclave page
>>> is added to the enclave. The reason the mutex is not held
>>> is to allow the reclaimer to be called directly if there are
>>> no EPC pages (in support of a new VA page) available at the time.
>>>
>>> Incrementing sgx_encl->page_cnt without sgc_encl->lock held
>>> is currently (before SGX2) safe from concurrent updates because
>>> all paths in which sgx_encl_grow() is called occur before
>>> enclave initialization and are protected with an atomic
>>> operation on SGX_ENCL_IOCTL.
>>>
>>> SGX2 includes support for dynamically adding pages after
>>> enclave initialization where the protection of SGX_ENCL_IOCTL
>>> is not available.
>>>
>>> Make direct reclaim of EPC pages optional when new VA pages
>>> are added to the enclave. Essentially the existing "reclaim"
>>> flag used when regular EPC pages are added to an enclave
>>> becomes available to the caller when used to allocate VA pages
>>> instead of always being "true".
>>>
>>> When adding pages without invoking the reclaimer it is possible
>>> to do so with sgx_encl->lock held, gaining its protection against
>>> concurrent updates to sgx_encl->page_cnt after enclave
>>> initialization.
>>>
>>> No functional change.
>>>
>>> Reported-by: Haitao Huang <haitao.huang@intel.com>
>>> Tested-by: Haitao Huang <haitao.huang@intel.com>
>>> Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>
> Thank you.
>
>>
>> Nit: I don't think tested-by is in the right patch here. Maybe
>> Haitao's tested-by should be moved into patch that actually adds
>> support for EAUG? Not something I would NAK this patch, just
>> wondering...
>
> Yes, that is a good point. While this is the bulk of the fix where
> the new API is introduced, the test is only applicable when this API
> is used and that is in "x86/sgx: Support adding of pages to an
> initialized enclave". I will move the "Tested-by" to that patch.
>

You can also add my Tested-by for patches adding the new IOCTLs.
Our team and I have tested EAUG on #PF,  modifying types and permissions  
with Intel SGX SDK/PSW.
Thanks
Haitao
