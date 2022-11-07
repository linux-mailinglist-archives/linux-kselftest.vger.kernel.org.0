Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8B961EB90
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 08:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiKGHRk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 02:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbiKGHRZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 02:17:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9E013DC1;
        Sun,  6 Nov 2022 23:16:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0629C60EF5;
        Mon,  7 Nov 2022 07:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4A8C433C1;
        Mon,  7 Nov 2022 07:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667805368;
        bh=6o+ij8HzFHZTDLoPetlk1sVAlITTr+Mf+bJTqZ37038=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6YyHP20mAGxAt4xEmyMqKjb3M8ftsIA9RxPlyRWroCUJRW0KnOD91xMCIW0ZfGHv
         np7qkgxHemArgBEIBpvxY8S+wOnhl1HQDAe6dmDXYBZ1IfRufkBgQRyVVWc8fQgwdI
         9jIuHjlKNBRB9Xuf0Kd/VReaM4mbCFLCbBBvJgfQ=
Date:   Mon, 7 Nov 2022 08:16:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        "Yin, Fengwei" <fengwei.yin@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y2iwtXiWHUqPBXMK@kroah.com>
References: <Y1kwa0ZLI9xbEaHx@ziqianlu-desk1>
 <Y2eKO48Tv+UD0IpV@ziqianlu-desk1>
 <Y2eaEG5IX+tk4wuA@kroah.com>
 <Y2htPReffG50xnu8@ziqianlu-desk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2htPReffG50xnu8@ziqianlu-desk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 07, 2022 at 10:28:13AM +0800, Aaron Lu wrote:
> Hi Greg,
> 
> Thanks for taking a look.
> 
> On Sun, Nov 06, 2022 at 12:27:12PM +0100, Greg KH wrote:
> > On Sun, Nov 06, 2022 at 06:19:39PM +0800, Aaron Lu wrote:
> > > To capture potential programming errors like mistakenly setting Global
> > > bit on kernel page table entries, a selftest for meltdown is added.
> > > 
> > > This selftest is based on https://github.com/IAIK/meltdown. What this
> > > test does is to firstly set a predefined string at a random user address
> > > and then with pagemap, get the physical address of this string. Finally,
> > > try to fetch the data using kernel's directmap address for this physical
> > > address to see if user space can use kernel's page table.
> > 
> > As this is based on someone else's code, what happened to the proper
> > credit for them as the author and copyright owner?
> 
> Should I list the contributors in the patch header comment section?
> Something like this:
> 
> The original code is contributed by:
> $ git shortlog -sne --all
>     24  Michael Schwarz <michael.schwarz91@gmail.com>
>     23  Michael Schwarz <michael.schwarz@student.tugraz.at>
>      9  Pavel Boldin <boldin.pavel@gmail.com>
>      6  Daniel Gruss <lava@gruss.cc>
>      3  Daniel Gruss <daniel.gruss@iaik.tugraz.at>
>      3  Jared Deckard <jdeckard@equityins.net>
>      3  Moritz Lipp <github@mlq.me>
>      2  Matteo Croce <mcroce@redhat.com>
>      2  Raphael Carvalho <raphael.scarv@gmail.com>
>      2  asgh <asgh@users.noreply.github.com>
>      1  Eduardo Marques <eduardorbmarques@gmail.com>
>      1  Egor Vorontsov <sdoregor@sdore.me>
>      1  Jakub Wilk <jwilk@jwilk.net>
>      1  Jason Davies <jason@jasondavies.com>
>      1  Lukasz Gryglicki <lukaszgryglicki@o2.pl>
>      1  Michael Schwarz <michael.schwarz@iaik.tugraz.at>
>      1  Raphael S. Carvalho <raphaelsc@scylladb.com>
>      1  Steven <steven@ceriously.com>
>      1  Vamsi Krishna <vamsi3@outlook.com>
>      1  pierwill <19642016+pierwill@users.noreply.github.com>
>      1  ysiyer <yegnesh.s.iyer@intel.com>
> 
> As for copyright, the only copyright I can find in the referenced repo
> is in the LICENSE file and it is: Copyright (c) 2018 meltdown, I'm not
> sure if I'm allowed to add copyright statement for others.

Again, please work with your lawyers so that they can give you the
correct legal advice, one that they are comfortable having a patch with
a signed-off-by from an Intel employee to have.

So next time you submit this, please have an Intel lawyer on the
signed-off-by chain so that we know it is meeting their rules.

thanks,

greg k-h
