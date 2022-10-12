Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054625FC899
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Oct 2022 17:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiJLPoI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Oct 2022 11:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLPoH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Oct 2022 11:44:07 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4EACAE52;
        Wed, 12 Oct 2022 08:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665589446; x=1697125446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XqAPHLBdMzTuuEY80fpMDDr2gQi/t6fzUUh5xjTnGyM=;
  b=JFQX0sabYdWaSWayxLe2Alhse/m+F9765VsnP4tgfIo/6yCAjTBfIcWO
   fPuNof3FFdPYtypKRBURPRqexvxXoVCHe0yvfP+FsxCQfR1qA77r7ZG53
   26/PlaxLOBOaDWGIy1IHt/Z5NqFe5E8VpiaDQdI/SE6x/RBwv1s5/10iE
   OPdabFVPHkndVKBwCR2wRdUIREppWTWO5PagUkRFR6X+QgzeGq3Qzl71A
   SLTbN0GZRMYE8AVHb3ywGcEX7SYdXG5xQ6nezSdU5vOwdm3Ysf64qKYy8
   szlKfRNLvk1KJ1YvEKbHcC0RStWBDa7WqLO0vGMCjAZv9E/usS+tnWs0X
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="391132231"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="391132231"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:44:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10498"; a="695518334"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="695518334"
Received: from jbrolli1-mobl.amr.corp.intel.com (HELO [10.212.174.189]) ([10.212.174.189])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 08:44:04 -0700
Message-ID: <6759025f-fc08-74f0-efd7-2331110dec0c@linux.intel.com>
Date:   Wed, 12 Oct 2022 08:44:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v14 1/3] x86/tdx: Make __tdx_module_call() usable in
 driver module
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
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
References: <20220928215535.26527-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220928215535.26527-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Y0aUb3n7ouaeAt2a@zn.tnic>
 <acc212d6-782b-a398-825a-212849beba00@linux.intel.com>
 <Y0bOtzlrkKzHmQVZ@zn.tnic>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <Y0bOtzlrkKzHmQVZ@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/12/22 7:27 AM, Borislav Petkov wrote:
> On Wed, Oct 12, 2022 at 06:35:56AM -0700, Sathyanarayanan Kuppuswamy wrote:
>> So we should create a new wrapper for this use case or use
> 
> Yes, you got it - a new wrapper pls.

Ok. I will add a new wrapper to get the TDREPORT. 

+/*

+ * Add a wrapper for TDG.MR.REPORT TDCALL. It is used in TDX guest

+ * driver module to get the TDREPORT.

+ */

+long tdx_mcall_get_report(void *reportdata, void *tdreport, u8 subtype)

+{

+       if (subtype || !reportdata || !tdreport)

+               return -EINVAL;

+

+       /*

+        * Generate TDREPORT using "TDG.MR.REPORT" TDCALL.

+        *

+        * Get the TDREPORT using REPORTDATA as input. Refer to

+        * section 22.3.3 TDG.MR.REPORT leaf in the TDX Module 1.0

+        * specification for detailed information.

+        */

+       return __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),

+                       virt_to_phys(reportdata), subtype, 0, NULL);

+}

+EXPORT_SYMBOL_GPL(tdx_mcall_get_report);



> 
> Thx.
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
