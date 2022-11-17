Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73C262D34D
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Nov 2022 07:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiKQGKv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Nov 2022 01:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKQGKt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Nov 2022 01:10:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BC92F3AE;
        Wed, 16 Nov 2022 22:10:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D2162096;
        Thu, 17 Nov 2022 06:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80292C433D7;
        Thu, 17 Nov 2022 06:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668665447;
        bh=clQORkhLNYIC9GSub946JG/6IiYx/JhvOScsW7imFRM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yC/sTLAgIfmisBNzDHAtarf8sUgYS47jKA0hTKSmFD0htT/aZXt6Y88dMcE2T3Y7l
         NTgo0ReISdWn6OemxaRi812zX7DOO5J2H224QN8FGVGh/eX5nuLZrjWjloAqLs5FcZ
         7nkIeDC9IxLQr4ysf02OUt0V6yWJgEosh7w+opqk=
Date:   Thu, 17 Nov 2022 07:10:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y3XQZFyiXYc9mJ1Y@kroah.com>
References: <Y3L2Jx3Kx9q8Dv55@ziqianlu-desk1>
 <Y3M3sZSARXxLTKao@kroah.com>
 <f8c3da3a-4d19-60c6-66d3-afd0d56ef102@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8c3da3a-4d19-60c6-66d3-afd0d56ef102@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 16, 2022 at 02:57:22PM -0800, Dave Hansen wrote:
> On 11/14/22 22:54, Greg KH wrote:
> > On Tue, Nov 15, 2022 at 10:15:03AM +0800, Aaron Lu wrote:
> >> I came to the conclusion that this work is OK to submit with all of the
> >> steps I listed above (copyright notices, license terms and relicensing)
> >> by strictly following all of the processes required by my employer.
> >>
> >> This does not include a Signed-off-by from a corporate attorney.
> > Please get that, as that is what I asked for in order for us to be able
> > to accept this type of change.
> 
> Hi Greg,
> 
> Can you share any more of what triggered this new requirement?

You are taking source from a non-Intel developer under a different
license and adding copyright and different license information to it.
Because of all of that, I have the requirement that I want to know that
Intel legal has vetted all of this and agrees with the conclusions that
you all are stating.

This isn't a new type of requirement, I make this request to many other
companies that do things that are not "normal" when it comes to licenses
and copyrights so as to ensure that all is ok.

thanks,

greg k-h
