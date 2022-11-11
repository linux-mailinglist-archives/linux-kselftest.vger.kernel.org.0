Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CFF62615E
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 19:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiKKShD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Nov 2022 13:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiKKSgR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Nov 2022 13:36:17 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87E63C6E2;
        Fri, 11 Nov 2022 10:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668191776; x=1699727776;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DOqa2OpJY5tyQ1/WvvYGJT74fyO9+N43ECB9nwSEed8=;
  b=j82PPNe0a1cWIKPNO8kW7lPEH4nxz+YFy4c3j6TRa4YDOsTIVROEYMcA
   WRcZ1VqJnUeNyyyOGrI3u4z5GyYDRh5m1D1lXKlubHszvol3VHzzjPGjX
   gAxuuQvkatrjYrl/n4t8X7ShCdwwbOfAblMzDQarDTczUPc06OgPu6KeZ
   EFDCHHQ7lxVcM++Jeh+AsQ1Hi599Mr1NQ0w2D2WFHuZ36Y6zK1eWu4K2K
   KT9ZKTwjxpwFIxAy6zAzBNQtFBlYSCsKZJm8j6eZmenuQEch/musc5omj
   rOAPwyQJd/DstLofi5pBFbi6TSb4I4qpFINEaH6aU+WjI085n9jsGSTlu
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="312795369"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="312795369"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:56 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10528"; a="670819245"
X-IronPort-AV: E=Sophos;i="5.96,157,1665471600"; 
   d="scan'208";a="670819245"
Received: from nmpoonaw-mobl1.amr.corp.intel.com (HELO [10.252.134.46]) ([10.252.134.46])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 10:35:55 -0800
Message-ID: <115a87d7-144a-2828-8e4f-9c1f156b73ae@intel.com>
Date:   Fri, 11 Nov 2022 10:35:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v17 1/3] x86/tdx: Add a wrapper to get TDREPORT from the
 TDX Module
Content-Language: en-US
To:     Kuppuswamy Sathyanarayanan 
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
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221104032355.227814-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/3/22 20:23, Kuppuswamy Sathyanarayanan wrote:
> To support TDX attestation, the TDX guest driver exposes an IOCTL
> interface to allow userspace to get the TDREPORT from the TDX module
> via TDG.MR.TDREPORT TDCALL.

This all acts and is named like this is *THE* way to do a TD report.
This is the only type of TD report.

Is it?

If so, why is there a subtype in the TDX module ABI?  It's easy to miss
in the kernel code, btw:

> +int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport)
> +{
> +	u64 ret;
> +
> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> +				virt_to_phys(reportdata), 0, 0, NULL);

					     subtype here ^

mixed in next to another magic 0.

> +	if (ret) {
> +		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
> +			return -EINVAL;
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tdx_mcall_get_report);

What happens to this interface when subtype 1 is added?

TDX_CMD_GET_REPORT can only get subtype 0.  So, we'll have, what, a new
ioctl()?  TDX_CMD_GET_REPORT_SUBTYPE1?

This is why I was pushing for a more generic ABI that would actually
work for more than one subtype.  Other folks thought that was a bad
idea.  I can live with that.  But, what I can't live with is just
pretending that this is the one and only forever "tdreport" interface.

This is *NOT* "a wrapper to get TDREPORT from the TDX Module", this is
at best "a wrapper to get TDREPORT sub type 0 from the TDX Module".

It also occurs to me that "sub type 0" could use an actual name.  Could
we give it one, please?

