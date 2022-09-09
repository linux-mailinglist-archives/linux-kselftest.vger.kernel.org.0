Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9EB5B2E15
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Sep 2022 07:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIIF0X (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Sep 2022 01:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiIIF0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Sep 2022 01:26:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C78F125B12;
        Thu,  8 Sep 2022 22:26:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 229A7B81AD8;
        Fri,  9 Sep 2022 05:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB1EC433D6;
        Fri,  9 Sep 2022 05:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662701178;
        bh=Xym8nFLz1doYxhLivSjmjBENQn3h/0+1UGRP2640huo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNeBCKbkMaomtUhQZrSHqUijbnZ4bdUQ8JbJpI71pv04FLfRVOledJg1Eu2ph9zkO
         jxVwGxIkiYn2Oy0bhQVHmSZF6uXOWky7R4ztux5+XhyicxCbYSkOKqgTTlV/eJUyLA
         WEghLPcljutHXFUM5WW8nTb32hxhPHYCfGwI+9XM=
Date:   Fri, 9 Sep 2022 07:26:16 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Message-ID: <YxrOeGqOrmsUNZ/6@kroah.com>
References: <20220908002723.923241-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20220908002723.923241-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <Yxl+PE4A+WUfQ7bl@kroah.com>
 <6cf407ed-95c7-0db4-d581-b85efad13239@linux.intel.com>
 <ac10ec37-91c8-031e-b3d3-843eaf28f0ee@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac10ec37-91c8-031e-b3d3-843eaf28f0ee@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 08, 2022 at 01:36:00PM -0700, Dave Hansen wrote:
> On 9/8/22 12:07, Sathyanarayanan Kuppuswamy wrote:
> > On 9/7/22 10:31 PM, Greg Kroah-Hartman wrote:
> >> On Wed, Sep 07, 2022 at 05:27:20PM -0700, Kuppuswamy Sathyanarayanan wrote:
> >>> +	/*
> >>> +	 * Per TDX Module 1.0 specification, section titled
> >>> +	 * "TDG.MR.REPORT", REPORTDATA length is fixed as
> >>> +	 * TDX_REPORTDATA_LEN, TDREPORT length is fixed as
> >>> +	 * TDX_REPORT_LEN, and TDREPORT subtype is fixed as
> >>> +	 * 0. Also check for valid user pointers.
> >>> +	 */
> >>> +	if (!req.reportdata || !req.tdreport || req.subtype ||
> >>> +		req.rpd_len != TDX_REPORTDATA_LEN ||
> >>> +		req.tdr_len != TDX_REPORT_LEN)
> >>> +		return -EINVAL;
> >> You never verify that your reserved[7] fields are actually set to 0,
> >> which means you can never use them in the future :(
> > Currently, we don't use those fields in our code. Why do we have to
> > make sure they are set to zero?
> 
> Yes.
> 
> > Can't we add checks when we really use them in future?
> 
> No.
> 
> This has been a hard learned lesson both by people writing software and
> designing hardware interfaces: if you _let_ folks pass garbage you have
> to _keep_ letting them pass garbage forever.  It becomes part of the ABI.
> 
> I'm sorry you missed the memo on this one.  But, this is one million
> percent a best practice across the industry.  Please do it.

And it's documented in the Documentation/ directory as a requirement to
do as well, the memo shouldn't have been missed :(
