Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EE55B399E
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 15:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiIINuo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 09:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiIINul (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 09:50:41 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558B64DB11;
        Fri,  9 Sep 2022 06:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662731408; x=1694267408;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Q7qJIucIZ1FP/A6YhsrnSAedQ0f+a9S5E9nD3L97gk8=;
  b=GcN+Ew7UQMDt4EoNsOKyJx1pMLDnZlLjjBwqhV9Eqdb4WZ+JSw1PIwiL
   KlQh+fCz66Zcjaq1VdJ6uQLNiiR+5DjCj9eIYTJMZJWtgQrOosl+hRDj+
   ySNOatnH5xO/WJ24oFrez0dyppE3elT1+cXQ8bRMkdfyXiC8hboY45CbA
   ym7kM/Q/5Budl8jt5bcJJzY062BEjRTmz+7y307WNrZhTy86ARSnDTmSb
   AvAzlAfV3ARsoPIkXUh62bqos/7NfjuBjokEfcvrYLI+44hphkDeWLLgZ
   QwXT5kEtutzJMV+kH3euVS2BXyaFTDC/OzCCCt9iaRUrlADTE5AMWvmR+
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="298815111"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298815111"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:49:58 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="615273507"
Received: from omeier-mobl1.ger.corp.intel.com (HELO [10.209.54.138]) ([10.209.54.138])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 06:49:57 -0700
Message-ID: <bd3988e8-dc15-9a81-1de4-560e86d36398@intel.com>
Date:   Fri, 9 Sep 2022 06:49:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v12 2/3] selftests: tdx: Test TDX attestation GetReport
 support
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-3-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxn5VDzJMUxSKz0Z@fedora>
 <e4b6f718-d671-72b3-4c4d-4338feba80a1@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <e4b6f718-d671-72b3-4c4d-4338feba80a1@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 9/8/22 18:55, Sathyanarayanan Kuppuswamy wrote:
> +#ifdef DEBUG
> +#define pr_debug(...) printf(__VA_ARGS__)
> +#else
> +#define pr_debug(...) _no_printf(__VA_ARGS__)
> +#endif

If you're going this way, please put this in common selftest code.
Don't force every single test to duplicate it.

But, seriously, this is all insanity.  Fixing the whole "oh, but DEBUG
might not be defined" thing is not exactly rocket science.  Just do this
in your test header or .c file:

#ifndef DEBUG
#define DEBUG 0
#endif

Then you can do:

	if (DEBUG)
		foo();

all day long.

Or, not.  I honestly don't think this is worth even mucking with in the
first place.
