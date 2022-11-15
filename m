Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DA8628E72
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 01:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiKOAd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 19:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiKOAd4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 19:33:56 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB78E8B;
        Mon, 14 Nov 2022 16:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668472435; x=1700008435;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+daAp9yRKxqxVx9ONETlA94YpPq9DtiM593w7JnMP9c=;
  b=PAaNe4pe90IngdGUGMxIhlzddRSMi+AW6mEOp77pZE9ll+Be33X5OtPk
   Vkt3JAFBaQ2k+9aelnAKVbdaMKNLdqhzYXJ2TOHyFJAnfNqQ5MG13s5Cf
   J8nUqybrZPjr3onoDDc6XrVEYjY/Twgi1zhEmgOLTzxcfXQPJMfxivxiX
   zvBhkEiAm76HiLX1chyzTrrK4Rg3BWSbyDFfrUMQNDncguoRKd5Fh5bsO
   nU+DrBxG0OFGrt/sB9W6TJA057HyRAiXQcIkQOav8cIVG9CAI5OyoBVjd
   iS39Jf1rr5W1myf2IUanKs99R9v+XEdWQSKye/jGcijV1pXpnZ3jpjrFG
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="310829560"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="310829560"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:33:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="616534852"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="616534852"
Received: from mmullick-mobl.amr.corp.intel.com (HELO [10.251.23.100]) ([10.251.23.100])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:33:53 -0800
Message-ID: <8d5f8a74-f864-3cd9-dac2-7650d83a8b90@linux.intel.com>
Date:   Mon, 14 Nov 2022 16:33:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.2.2
Subject: Re: [PATCH v17 1/3] x86/tdx: Add a wrapper to get TDREPORT from the
 TDX Module
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221104032355.227814-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <115a87d7-144a-2828-8e4f-9c1f156b73ae@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <115a87d7-144a-2828-8e4f-9c1f156b73ae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Dave,

On 11/11/22 10:35 AM, Dave Hansen wrote:
> This is *NOT* "a wrapper to get TDREPORT from the TDX Module", this is
> at best "a wrapper to get TDREPORT sub type 0 from the TDX Module".

In both the commit log and the comments, I can highlight the "subtype 0"
information. Will that work for you, or do you prefer that this wrapper
take the "subtype" option as argument and we pass 0 for the subtype value
from the TDX guest driver?

> 
> It also occurs to me that "sub type 0" could use an actual name.  Could
> we give it one, please?

Although the subtype option is mentioned in the TDX Module spec, it is not
currently used (it expects this value to be zero), and the spec also does
not explain why this option is required. According to TDX architects, this
option was primarily added to handle any future requirements that may arise
that require additional information to be added to the TDREPORT. However,
they do not currently have any valid use cases for it. So the current
version can only be described as "Type-0." Once a new use case for Subtype 1
is defined, we may be able to come up with a suitable name. Are you okay
with calling it "Type-0" for the time being?

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
