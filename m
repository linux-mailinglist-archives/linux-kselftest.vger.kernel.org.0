Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53605B9955
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Sep 2022 13:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiIOLI6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Sep 2022 07:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOLI5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Sep 2022 07:08:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB83D9A953;
        Thu, 15 Sep 2022 04:08:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 374A0B81FB1;
        Thu, 15 Sep 2022 11:08:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7413BC433C1;
        Thu, 15 Sep 2022 11:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663240134;
        bh=X2hjnjeX49SebaaaihSZE19uspJmmj2lwVirIDzCF7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boJ7wi+9tDgG0wTR1Qga6ltlyFe0JxieAebGeG3fD/VJAJEQC22qH+AyaZwlVQ+Ls
         jKaAYOJO2r8e7nmsnFrKkkFeEbHWT0j/bPIWLhhgnPZZ9jr+OOc5+XqgQfmcE7kj8i
         yn3QOmPtbgta0EkCGoup4tnfwSGTyyxZ1rKgrEuU=
Date:   Thu, 15 Sep 2022 13:09:19 +0200
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
Message-ID: <YyMH37G2CTuVCbLM@kroah.com>
References: <20220909192708.1113126-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220909192708.1113126-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 09, 2022 at 12:27:06PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +static int __init tdx_guest_init(void)
> +{
> +	int ret;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
> +		return -EIO;
> +
> +	ret = misc_register(&tdx_misc_dev);
> +	if (ret) {
> +		pr_err("misc device registration failed\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +device_initcall(tdx_guest_init)

As mentioned elsewhere, make this a normal module_init() format and only
load the module if the hardware is present.  Don't just always be
built/loaded, that's not ok.

thanks,

greg k-h
