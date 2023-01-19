Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF618674B1A
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jan 2023 05:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbjATEod (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Jan 2023 23:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjATEoD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Jan 2023 23:44:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00344C41EB;
        Thu, 19 Jan 2023 20:39:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7CCFB825CD;
        Thu, 19 Jan 2023 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2300FC433EF;
        Thu, 19 Jan 2023 16:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674144782;
        bh=18e5lp84Zk7SqTfdeOyVaqyHOLN3jaGqpXDYk8bKFAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xDqz0xJdJpZuaM0NDJe4/QsaIx77l972UgqDtJCMiY/as4fdFBHnBIUmn/9ebE6+1
         RUr7I/dUGRhhINc4Q0sydGeV6Uzfdu/amUJEMAuhbRIVK+Q31Abm8x9JNqzYeVSo2H
         lVerdipM/i49DaI2TGRZOBev9YzOmCiZSMwiWnOk=
Date:   Thu, 19 Jan 2023 17:12:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Igor Seletskiy <i@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y8lsCzWJv73sBeyj@kroah.com>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
 <Y7bg5sxEZDIaGoXK@kroah.com>
 <Y7dypc4sFcmYlXQQ@ziqianlu-desk2>
 <Y7kqx5cBCVojq6QJ@kroah.com>
 <Y7vEg/VHWsp86B6r@ziqianlu-desk2>
 <Y8eCA7hdde07a4gz@ziqianlu-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8eCA7hdde07a4gz@ziqianlu-desk2>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 18, 2023 at 01:22:11PM +0800, Aaron Lu wrote:
> Hi Greg,
> 
> On Mon, Jan 09, 2023 at 03:38:43PM +0800, Aaron Lu wrote:
> > On Sat, Jan 07, 2023 at 09:18:15AM +0100, Greg KH wrote:
> > > On Fri, Jan 06, 2023 at 09:00:21AM +0800, Aaron Lu wrote:
> > > > If you do not trust what I've done is what I've claimed, now the
> > > > original author Pavel Boldin has given the patch a "LGTM" tag, does that
> > > > address your concern?
> > > 
> > > I don't see that anywhere on lore.kernel.org, have a link to it?
> > 
> > It appears Pavel Boldin's last reply didn't make it to lore for some
> > reason but I saw him kindly replying again and I suppose you should
> > have received it.
> > 
> > But just in case, the link for Pavel's new reply is here:
> > https://lore.kernel.org/lkml/CABohvEPWBHmrRpZcQejTkZ+CYtYCyu6rFMd4doNn_CMk35um+g@mail.gmail.com/
> 
> Now with the original author Pavel Boldin's "LGTM", do you think this
> patch is OK to you or you still insist something else? Please kindly
> let me know, thanks.

I do not see any sort of tag sent by Pavel (hint, you can NOT make one
up yourself) to indicate that they agree with this.

Also, the amount of gyrations you all went through just to keep an
Intel lawyer's name out of the changelog is insane and means that I was
right to push for this.  I still want it now, just because :)

thanks,

greg k-h
