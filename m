Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD4162B344
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 07:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbiKPG0A (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 01:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiKPGZx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 01:25:53 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A452C1D0EA;
        Tue, 15 Nov 2022 22:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668579952; x=1700115952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fB7JiWADb0P2b2t+ebguTg5N8FbI6r37biHOj8DMLS4=;
  b=eAGBzGmHzssbMdcUjYIAK92rlUAlDUhb9OfIuq8VVlgMSnHQlWojwbsN
   /l13RAwojlJyqAzAEzkcDLfwTtLhIXBECS9P1UFf9jdKIs3DxnRUVtTmS
   QUNLhAfJ3F1hgvH3wImdxQCXG3iVeMoTIwWFGk4UgsxI3jrsSRHnUOiJd
   Zn6/my6nK547++Q652G8diqR7rwsY8jrj7fM33GdvU+wYkl9Hs5LrGNBM
   kdugl48pY4st2giPyGbkfnkEg1cVH9RfDxlNFLMdZSnJt0aq7p9HkIx3X
   8AyxHZDcLhdYfw/6N17dppYI31daktXzAQ9qtDeKtR2SEn3htTB88draj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="311170456"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="311170456"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:25:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="641508622"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="641508622"
Received: from gsavithr-mobl.amr.corp.intel.com (HELO [10.209.85.47]) ([10.209.85.47])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 22:25:51 -0800
Message-ID: <556a2475-f0e1-d1cf-1c46-bbe052e5ef40@linux.intel.com>
Date:   Tue, 15 Nov 2022 22:25:50 -0800
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
 <8d5f8a74-f864-3cd9-dac2-7650d83a8b90@linux.intel.com>
 <e7147e03-705e-d2a8-9c9c-b4243ed5b451@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <e7147e03-705e-d2a8-9c9c-b4243ed5b451@intel.com>
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

On 11/14/22 4:54 PM, Dave Hansen wrote:
>> In both the commit log and the comments, I can highlight the "subtype 0"
>> information. Will that work for you, or do you prefer that this wrapper
>> take the "subtype" option as argument and we pass 0 for the subtype value
>> from the TDX guest driver?
> I actually think it's a *lot* more clear if the User<->Kernel ABI just
> takes the subtype.  But, I also heard Greg's concerns about making the
> ABI _too_ open-ended.
> 
> So, I really don't care.  Just make it clear that, as is, this ABI is
> not the "TDREPORT ABI".
> 

Are you fine with the following version?

+/* TDX Module call error codes */
+#define TDCALL_RETURN_CODE(a)  ((a) >> 32)
+#define TDCALL_INVALID_OPERAND 0xc0000100
+
+#define TDREPORT_SUBTYPE_0     0
+ 
+/**
+ * tdx_mcall_get_report0() - Wrapper to get TDREPORT0 (a.k.a. TDREPORT
+ *                           subtype 0) using TDG.MR.REPORT TDCALL.
+ * @reportdata: Address of the input buffer which contains user-defined
+ *              REPORTDATA to be included into TDREPORT.
+ * @tdreport: Address of the output buffer to store TDREPORT.
+ *
+ * Refer to section titled "TDG.MR.REPORT leaf" in the TDX Module
+ * v1.0 specification for more information on TDG.MR.REPORT TDCALL.
+ * It is used in the TDX guest driver module to get the TDREPORT0.
+ *
+ * Return 0 on success, -EINVAL for invalid operands, or -EIO on
+ * other TDCALL failures.
+ */
+int tdx_mcall_get_report0(u8 *reportdata, u8 *tdreport)
+{
+       u64 ret;
+
+       ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
+                               virt_to_phys(reportdata), TDREPORT_SUBTYPE_0,
+                               0, NULL);
+       if (ret) {
+               if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
+                       return -EINVAL;
+               return -EIO;
+       }
+
+       return 0;
+}
+EXPORT_SYMBOL_GPL(tdx_mcall_get_report0);


-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
