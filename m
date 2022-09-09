Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05415B4006
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 21:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIITnp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbiIITnM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 15:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC81449D7;
        Fri,  9 Sep 2022 12:40:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7885620C1;
        Fri,  9 Sep 2022 19:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94399C433D6;
        Fri,  9 Sep 2022 19:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662752370;
        bh=w3RATERBI8o3N5jpx3l9Wbk3iWTEUT4ylmzwazWbrtg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ppZ5fUuoYTJjVinFMs6u8JwXKHnIgvIX6e6vkx9vbD7W4ccAQaefphDa0wB1cfhyt
         1uZNBymtBLjJ7SZHt0J6tRcfGHx20laCmj8uRscvAjkacSONpqrDlFeyugC5uBCT+8
         qR7ocuAWlkQrCuPbZZdnLj+snZV2JBNr9tlgxATE=
Date:   Fri, 9 Sep 2022 21:39:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Shuah Khan <shuah@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        Isaku Yamahata <isaku.yamahata@gmail.com>,
        marcelo.cerri@canonical.com, tim.gardner@canonical.com,
        khalid.elmously@canonical.com, philip.cox@canonical.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v13 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <YxuWiAUnvXEcsyhj@kroah.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 09, 2022 at 12:27:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Attestation is used to verify the TDX guest trustworthiness to other
> entities before provisioning secrets to the guest. For example, a key
> server may request for attestation before releasing the encryption keys
> to mount the encrypted rootfs or secondary drive.
> 
> During the TDX guest launch, the initial contents (including the
> firmware image) and configuration of the guest are recorded by the
> Intel TDX module in build time measurement register (MRTD). After TDX
> guest is created, run-time measurement registers (RTMRs) can be used by
> the guest software to extend the measurements. TDX supports 4 RTMR
> registers, and TDG.MR.RTMR.EXTEND TDCALL is used to update the RTMR
> registers securely. RTMRs are mainly used to record measurements
> related to sections like the kernel image, command line parameters,
> initrd, ACPI tables, firmware data, configuration firmware volume (CFV)
> of TDVF, etc. For complete details, please refer to TDX Virtual
> Firmware design specification, sec titled "TD Measurement".
> 
> At TDX guest runtime, the Intel TDX module reuses the Intel SGX
> attestation infrastructure to provide support for attesting to these
> measurements as described below.
> 
> The attestation process consists of two steps: TDREPORT generation and
> Quote generation.
> 
> TDREPORT (TDREPORT_STRUCT) is a fixed-size data structure generated by
> the TDX module which contains guest-specific information (such as build
> and boot measurements), platform security version, and the MAC to
> protect the integrity of the TDREPORT. The guest kernel uses
> TDCALL[TDG.MR.REPORT] to get the TDREPORT from the TDX module. A
> user-provided 64-Byte REPORTDATA is used as input and included in the
> TDREPORT. Typically it can be some nonce provided by attestation
> service so the TDREPORT can be verified uniquely. More details about
> the TDREPORT can be found in Intel TDX Module specification, section
> titled "TDG.MR.REPORT Leaf".
> 
> TDREPORT by design can only be verified on the local platform as the
> MAC key is bound to the platform. To support remote verification of
> the TDREPORT, TDX leverages Intel SGX Quote Enclave (QE) to verify
> the TDREPORT locally and convert it to a remote verifiable Quote.
> 
> After getting the TDREPORT, the second step of the attestation process
> is to send it to the QE to generate the Quote. TDX doesn't support SGX
> inside the guest, so the QE can be deployed in the host, or in another
> legacy VM with SGX support. QE checks the integrity of TDREPORT and if
> it is valid, a certified quote signing key is used to sign the Quote.
> How to send the TDREPORT to QE and receive the Quote is implementation
> and deployment specific.
> 
> Implement a basic guest misc driver to allow userspace to get the
> TDREPORT. After getting TDREPORT, the userspace attestation software
> can choose whatever communication channel available (i.e. vsock or
> hypercall) to send the TDREPORT to QE and receive the Quote.
> 
> Also note that explicit access permissions are not enforced in this
> driver because the quote and measurements are not a secret. However
> the access permissions of the device node can be used to set any
> desired access policy. The udev default is usually root access
> only.
> 
> Operations like getting TDREPORT or Quote generation involves sending
> a blob of data as input and getting another blob of data as output. It
> was considered to use a sysfs interface for this, but it doesn't fit
> well into the standard sysfs model for configuring values. It would be
> possible to do read/write on files, but it would need multiple file
> descriptors, which would be somewhat messy. IOCTLs seems to be the best
> fitting and simplest model for this use case. This is similar to AMD
> SEV platform, which also uses IOCTL interface to support attestation.
> 
> Any distribution enabling TDX is also expected to need attestation. So
> enable it by default with TDX guest support.
> 
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Acked-by: Kai Huang <kai.huang@intel.com>
> Acked-by: Wander Lairson Costa <wander@redhat.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
> 
> Changes since v12:
>  * Added check to ensure reserved entries are set as 0.
> 
> Changes since v11:
>  * Renamed DRIVER_NAME to TDX_GUEST_DEVICE and moved it to
>    arch/x86/include/uapi/asm/tdx.h.
>  * Fixed default error number in tdx_guest_ioctl().
>  * Moved tdx_misc_dev definition out of tdx_guest_init() as
>    per Greg's suggestion.
>  * Reordered struct tdx_report_req to avoid holes and added
>    required padding.
> 
> Changes since v10:
>  * Replaced TD/TD Guest usage with TDX Guest or Guest.
>  * Removed unnecessary comments.
>  * Added more validation to user input in tdx_get_report().
>  * Used u64_to_user_ptr when reading user u64 pointers.
>  * Fixed commit log as per review comments.
> 
> Changes since v9:
>  * Dropped the cover letter. Since this patch set only adds
>    TDREPORT support, the commit log itself has all the required details.
>  * Dropped the Quote support and event IRQ support as per Dave's
>    review suggestion.
>  * Dropped attest.c and moved its contents to tdx.c
>  * Updated commit log and comments to reflect latest changes.
> 
> Changes since v8:
>  * Please refer to https://lore.kernel.org/all/ \
>    20220728034420.648314-1-sathyanarayanan.kuppuswamy@linux.intel.com/
> 
>  arch/x86/coco/tdx/tdx.c         | 115 ++++++++++++++++++++++++++++++++
>  arch/x86/include/uapi/asm/tdx.h |  56 ++++++++++++++++
>  2 files changed, 171 insertions(+)
>  create mode 100644 arch/x86/include/uapi/asm/tdx.h
> 
> diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
> index 928dcf7a20d9..8b5c59110321 100644
> --- a/arch/x86/coco/tdx/tdx.c
> +++ b/arch/x86/coco/tdx/tdx.c
> @@ -5,16 +5,21 @@
>  #define pr_fmt(fmt)     "tdx: " fmt
>  
>  #include <linux/cpufeature.h>
> +#include <linux/miscdevice.h>
> +#include <linux/mm.h>
> +#include <linux/io.h>
>  #include <asm/coco.h>
>  #include <asm/tdx.h>
>  #include <asm/vmx.h>
>  #include <asm/insn.h>
>  #include <asm/insn-eval.h>
>  #include <asm/pgtable.h>
> +#include <uapi/asm/tdx.h>
>  
>  /* TDX module Call Leaf IDs */
>  #define TDX_GET_INFO			1
>  #define TDX_GET_VEINFO			3
> +#define TDX_GET_REPORT			4
>  #define TDX_ACCEPT_PAGE			6
>  
>  /* TDX hypercall Leaf IDs */
> @@ -775,3 +780,113 @@ void __init tdx_early_init(void)
>  
>  	pr_info("Guest detected\n");
>  }
> +
> +static long tdx_get_report(void __user *argp)
> +{
> +	u8 *reportdata, *tdreport;
> +	struct tdx_report_req req;
> +	u8 reserved[7] = {0};

Where is the magic "7" coming from?

> +	long ret;
> +
> +	if (copy_from_user(&req, argp, sizeof(req)))
> +		return -EFAULT;
> +
> +	/*
> +	 * Per TDX Module 1.0 specification, section titled
> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
> +	 * 0. Also check for valid user pointers and make sure
> +	 * reserved entries values are zero.
> +	 */
> +	if (!req.reportdata || !req.tdreport || req.subtype ||
> +		req.rpd_len != TDX_REPORTDATA_LEN ||
> +		req.tdr_len != TDX_REPORT_LEN ||
> +		memcmp(req.reserved, reserved, 7))

Again, magic number?

thanks,

greg k-h
