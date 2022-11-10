Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CD662455A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Nov 2022 16:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKJPRP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 10:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKJPRO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 10:17:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F8012615
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 07:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668093380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Tpp7Gwy/r5e/+H+feiypkA92ize6X+nNHLC4UW2XS1E=;
        b=cgYz6Fo4B/XRxPLRghdrEyT7yCc34qyFRqr0N1ZXw2DZ0rz9WxzcUQBL2k7pupuXo2WdE8
        pYH8ppwcMFP3TS77zKSGkmfV5NYOjQhPS+kOQ7rQaXOieBUpL7EZFO/jwje+2nfqd2gkW7
        7hcJre6TQoGkvDTc9Z2WcKtmjbG8PLk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-138-h28TWhiMOxGbow6m0MWXzQ-1; Thu, 10 Nov 2022 10:16:18 -0500
X-MC-Unique: h28TWhiMOxGbow6m0MWXzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DEBA73C0F446;
        Thu, 10 Nov 2022 15:16:17 +0000 (UTC)
Received: from fedora (unknown [10.22.8.196])
        by smtp.corp.redhat.com (Postfix) with SMTP id F1282112131B;
        Thu, 10 Nov 2022 15:16:12 +0000 (UTC)
Date:   Thu, 10 Nov 2022 12:16:11 -0300
From:   Wander Lairson Costa <wander@redhat.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v17 1/3] x86/tdx: Add a wrapper to get TDREPORT from the
 TDX Module
Message-ID: <20221110151611.shrdumi2t5a3obns@fedora>
References: <20221104032355.227814-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20221104032355.227814-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104032355.227814-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 03, 2022 at 08:23:53PM -0700, Kuppuswamy Sathyanarayanan wrote:
> To support TDX attestation, the TDX guest driver exposes an IOCTL
> interface to allow userspace to get the TDREPORT from the TDX module
> via TDG.MR.TDREPORT TDCALL.
> 
> In order to get the TDREPORT in the TDX guest driver, instead of using
> a low level function like __tdx_module_call(), add a
> tdx_mcall_get_report() wrapper function to handle it.
> 
> This is a preparatory patch for adding attestation support.
> 
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v16
>  * Added invalid operand error code support.
>  * Removed subtype param in tdx_mcall_get_report().
> 
> Changes since v15:
>  * None
> 
> Changes since v14:
>  * Instead of exporting __tdx_module_call(), added a new wrapper.
>  * Rebased on top of v6.1-rc1
> 
>  arch/x86/coco/tdx/tdx.c    | 38 ++++++++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/tdx.h |  2 ++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 928dcf7a20d9..17cf2e9d5849 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -5,6 +5,8 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
>  
>  #include <linux/cpufeature.h>
> +#include <linux/export.h>
> +#include <linux/io.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
> @@ -15,6 +17,7 @@
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
>  #define TDX_GET_VEINFO			3
> +#define TDX_GET_REPORT			4
>  #define TDX_ACCEPT_PAGE			6
>  
>  /* TDX hypercall Leaf IDs */
> @@ -34,6 +37,10 @@
>  #define VE_GET_PORT_NUM(e)	((e) >> 16)
>  #define VE_IS_IO_STRING(e)	((e) & BIT(4))
>  
> +/* TDX Module call error codes */
> +#define TDCALL_RETURN_CODE(a)	((a) >> 32)
> +#define TDCALL_INVALID_OPERAND	0xc0000100
> +
>  /*
>   * Wrapper for standard use of __tdx_hypercall with no output aside from
>   * return code.
> @@ -98,6 +105,37 @@ static inline void tdx_module_call(u64 fn, u64 rcx, u64 rdx, u64 r8, u64 r9,
>  		panic("TDCALL %lld failed (Buggy TDX module!)\n", fn);
>  }
>  
> +/**
> + * tdx_mcall_get_report() - Wrapper for TDG.MR.REPORT TDCALL.
> + * @reportdata: Address of the input buffer which contains
> + *              user-defined REPORTDATA to be included into
> + *              TDREPORT.
> + * @tdreport: Address of the output buffer to store TDREPORT.
> + *
> + * Generate TDREPORT using "TDG.MR.REPORT" TDCALL. Refer to section
> + * titled "TDG.MR.REPORT leaf" in the TDX Module 1.0 specification
> + * for detailed information. It is used in the TDX guest driver
> + * module to get the TDREPORT.
> + *
> + * Return 0 on success, -EINVAL for invalid operands, or -EIO on
> + * other TDCALL failures.
> + */
> +int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport)
> +{
> +	u64 ret;
> +
> +	ret = __tdx_module_call(TDX_GET_REPORT, virt_to_phys(tdreport),
> +				virt_to_phys(reportdata), 0, 0, NULL);
> +	if (ret) {
> +		if (TDCALL_RETURN_CODE(ret) == TDCALL_INVALID_OPERAND)
> +			return -EINVAL;
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tdx_mcall_get_report);
> +
>  static u64 get_cc_mask(void)
>  {
>  	struct tdx_module_output out;
> diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
> index 020c81a7c729..eef9c0b7880e 100644
> --- a/arch/x86/include/asm/tdx.h
> +++ b/arch/x86/include/asm/tdx.h
> @@ -67,6 +67,8 @@ void tdx_safe_halt(void);
>  
>  bool tdx_early_handle_ve(struct pt_regs *regs);
>  
> +int tdx_mcall_get_report(u8 *reportdata, u8 *tdreport);
> +
>  #else
>  
>  static inline void tdx_early_init(void) { };
> -- 
> 2.34.1
> 
> 

Acked-by: Wander Lairson Costa <wander@redhat.com>

