Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91C5B1411
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Sep 2022 07:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiIHFbW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Sep 2022 01:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiIHFbV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Sep 2022 01:31:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D409B6B642;
        Wed,  7 Sep 2022 22:31:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C577B81F05;
        Thu,  8 Sep 2022 05:31:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F29C433D6;
        Thu,  8 Sep 2022 05:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662615078;
        bh=993P6P5uXUu3gMFdwZ6bKw95vMR8jDKZUPI8ijKD64Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LPmK5FNxEtNNpbGCkMIWknBOvFfca0Gn5VRehRES829d1issxJtdRujj/76bPTft5
         pF1+HRBk3NDLgnNDUNlCBHGRvKHftiyeRfbtYsujNgab7cjrtSZbMdk6TQb8jpzCU0
         YSliZe8vhr/40UEXi2AbPhsCUt23CANxyFm/oH0o=
Date:   Thu, 8 Sep 2022 07:31:40 +0200
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
Subject: Re: [PATCH v12 1/3] x86/tdx: Add TDX Guest attestation interface
 driver
Message-ID: <Yxl+PE4A+WUfQ7bl@kroah.com>
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-2-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908002723.923241-2-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 07, 2022 at 05:27:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
> +	/*
> +	 * Per TDX Module 1.0 specification, section titled
> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
> +	 * 0. Also check for valid user pointers.
> +	 */
> +	if (!req.reportdata || !req.tdreport || req.subtype ||
> +		req.rpd_len != TDX_REPORTDATA_LEN ||
> +		req.tdr_len != TDX_REPORT_LEN)
> +		return -EINVAL;

You never verify that your reserved[7] fields are actually set to 0,
which means you can never use them in the future :(

Please fix that up, thanks.

greg k-h
