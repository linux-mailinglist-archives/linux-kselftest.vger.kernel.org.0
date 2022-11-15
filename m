Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9412F628EB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Nov 2022 01:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiKOAyl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 19:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKOAyk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 19:54:40 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B07C71006B;
        Mon, 14 Nov 2022 16:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668473678; x=1700009678;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kA5X1C/b7QXdk/50t6gc7C4T1GjsJcCu92tMYvGFEO8=;
  b=N83GavVhJNqO/izjE/Ih+mUdWFYELqLv5slGNw85eiX+G/0TXgH1d0d6
   tAr/bPUTtjLDGcdtS9vV7vPU9g0dHHzYDWqv7f+UYTkACQ/HasvVjU09V
   /5jZEkIiynWaMV0qeF7mUqTzj2Zf7bkKimXVn5MhxGeGGQXv4lGzx9wy6
   dFC2gcwWu3bwb1tttvtG78te5Z8iNw1Mbw5d87D4010/8TLaEu97iTgzd
   S7uGDpMIje3iHhnB/ZTcSmDvuDentuWExpzOmKsv46OY3Fa9lgDzGGZ1s
   ybi29srzmh1Z7lX6AmGrJF4IJP/ptnFKBlhhlyifzx7qaAOtNQXI0y0DT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="291836289"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="291836289"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:54:38 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="669885890"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="669885890"
Received: from satyanay-mobl1.amr.corp.intel.com (HELO [10.209.114.162]) ([10.209.114.162])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 16:54:36 -0800
Message-ID: <e7147e03-705e-d2a8-9c9c-b4243ed5b451@intel.com>
Date:   Mon, 14 Nov 2022 16:54:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v17 1/3] x86/tdx: Add a wrapper to get TDREPORT from the
 TDX Module
Content-Language: en-US
To:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
 <8d5f8a74-f864-3cd9-dac2-7650d83a8b90@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <8d5f8a74-f864-3cd9-dac2-7650d83a8b90@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/14/22 16:33, Sathyanarayanan Kuppuswamy wrote:
> On 11/11/22 10:35 AM, Dave Hansen wrote:
>> This is *NOT* "a wrapper to get TDREPORT from the TDX Module", this is
>> at best "a wrapper to get TDREPORT sub type 0 from the TDX Module".
> 
> In both the commit log and the comments, I can highlight the "subtype 0"
> information. Will that work for you, or do you prefer that this wrapper
> take the "subtype" option as argument and we pass 0 for the subtype value
> from the TDX guest driver?

I actually think it's a *lot* more clear if the User<->Kernel ABI just
takes the subtype.  But, I also heard Greg's concerns about making the
ABI _too_ open-ended.

So, I really don't care.  Just make it clear that, as is, this ABI is
not the "TDREPORT ABI".

>> It also occurs to me that "sub type 0" could use an actual name.  Could
>> we give it one, please?
> 
> Although the subtype option is mentioned in the TDX Module spec, it is not
> currently used (it expects this value to be zero), and the spec also does
> not explain why this option is required. According to TDX architects, this
> option was primarily added to handle any future requirements that may arise
> that require additional information to be added to the TDREPORT. However,
> they do not currently have any valid use cases for it. So the current
> version can only be described as "Type-0." Once a new use case for Subtype 1
> is defined, we may be able to come up with a suitable name. Are you okay
> with calling it "Type-0" for the time being?

That sounds like a cop out to me.  I'd really appreciate some effort on
your part to look deeply into the problem.

The blob that the kernel is passing back and forth here _has_ content.
I guess it's somewhat hard to name because it's got a bunch of inputs
(ATTRIBUTES, XFAM, MRTD, MRCONFIGID, MROWNER, MROWNERCONFIG and RTMRs)
and a fixed hash algorithm (SHA-384).

Any time that those inputs change or, for instance, the hash algorithm
changes, it would need a new subtype.  Right?

I guess we can't call "subtype 0" TDREPORT_SHA384 because "subtype 1"
might still use SHA-384, but have the set of inputs change.

But, it'll also get maddeningly inconsistent if we have a "TDREPORT"
ioctl() that does "subtype 0" and "TDREPORT1" that does "subtype 1".

So, let's at *least* call this thing "TDREPORT0" in the ABI, along with
a description of why we're numbering it that way as opposed to taking
'subtype' as a numeric ioctl() argument.

Any better ideas?
