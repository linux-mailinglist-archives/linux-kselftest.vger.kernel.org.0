Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8465EF98
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jan 2023 16:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjAEPC0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Jan 2023 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbjAEOih (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Jan 2023 09:38:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A14659331;
        Thu,  5 Jan 2023 06:38:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DE046B81AF8;
        Thu,  5 Jan 2023 14:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF626C433EF;
        Thu,  5 Jan 2023 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672929513;
        bh=G5YNmA8ky3bK+urw6zEhSYdIXfh6FrcGi/1KX+rdWGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWHP6ROg0Nu4Xd0xp5ri7h/b9Bo/9GbbKJJZMbaVpxT6mhqpUGovDYnqHKgClMOh3
         OuOzM7RDmqzmPgev4zlXYBXr0fuRCb5/7n1bkmBN58NFTU4QixQFCXupvOQMTfA7YT
         ZPHYSCAKK8B+Bjzux3Z7pyB2yiFeJXhj/KCvfvXc=
Date:   Thu, 5 Jan 2023 15:38:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Raphael S. Carvalho" <raphaelsc@scylladb.com>
Cc:     Aaron Lu <aaron.lu@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        Pavel Boldin <pboldin@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7bg5sxEZDIaGoXK@kroah.com>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
 <Y7bT0OL8RAWkCu0Z@kroah.com>
 <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKhLTr1a+fTs2KyT3fm9yMxfjNwW_yLV7vRjrUXdNx8gfg8LqA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 05, 2023 at 11:11:15AM -0300, Raphael S. Carvalho wrote:
> On Thu, Jan 5, 2023 at 10:42 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Thu, Jan 05, 2023 at 08:35:05PM +0800, Aaron Lu wrote:
> > > To capture potential programming errors like mistakenly setting Global
> > > bit on kernel page table entries, a selftest for meltdown is added.
> > >
> > > This selftest is based on Pavel Boldin's work at:
> > > https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c
> > >
> > > In addition to the existing test of reading kernel variable
> > > saved_command_line from user space, one more test of reading user local
> > > variable through kernel direct map address is added. For the existing
> > > test(reading saved_command_line) to report a failure, both the high kernel
> > > mapping and low kernel mapping have to be in leaked state; For the added
> > > test(read local var), only low kernel mapping leak is enough to trigger
> > > a test fail, so both tests are useful.
> > >
> > > Test results of 10 runs:
> > >
> > > On v6.1-rc8 with nopti kernel cmdline option:
> > >
> > > host              test_out_rate_1    test_out_rate_2
> > > lkp-bdw-de1            50%               100%
> > > lkp-hsw-d01            70%               100%
> > > lkp-hsw-d02             0%                80%
> > > lkp-hsw-d03            60%               100%
> > > lkp-hsw-d04            20%               100%
> > > lkp-hsw-d05            60%               100%
> > > lkp-ivb-d01             0%                70%
> > > lkp-kbl-d01           100%               100%
> > > lkp-skl-d02           100%                90%
> > > lkp-skl-d03            90%               100%
> > > lkp-skl-d05            60%               100%
> > > kbl-vm                100%                80%
> > > 2 other machines have 0% rate for both tests.
> > >
> > > bdw=broadwell, hsw=haswell, ivb=ivybridge, etc.
> > >
> > > test_out_rate_1: test reports fail rate for the test of reading
> > > saved_command_line from user space;
> > > test_out_rate_2: test reports fail rate for the test of reading user
> > > local variable through kernel direct map address in user space.
> > >
> > > On v5.19 without nopti cmdline option:
> > > host              test_out_rate_2
> > > lkp-bdw-de1            80%
> > > lkp-hsw-4ex1           50%
> > > lkp-hsw-d01            30%
> > > lkp-hsw-d03            10%
> > > lkp-hsw-d04            10%
> > > lkp-kbl-d01            10%
> > > kbl-vm                 80%
> > > 7 other machines have 0% rate for test2.
> > >
> > > Also tested on an i386 VM with 512M memory and the test out rate is 100%
> > > when adding nopti to kernel cmdline with v6.1-rc8.
> > >
> > > Main changes I made from Pavel Boldin's meltdown test are:
> > > - Replace rdtscll() and clflush() with kernel's implementation;
> > > - Reimplement find_symbol_in_file() to avoid bringing in LTP's library
> > >   functions;
> > > - Coding style changes: placing the function return type in the same
> > >   line of the function.
> > >
> > > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> > > ---
> > > Notable changes from RFC v3:
> > > - Drop RFC tag;
> > > - Change the base code from zlib licensed one to GPL licensed one.
> >
> > Sorry, but this still gets my NAK for the issues raised in previous
> > reviews that are not addressed here for some reason :(
> 
> Greg, the selftest is no longer based on
> https://github.com/IAIK/meltdown/blob/master/LICENSE, which is
> originally zlib licensed. In this version, Aaron is basing the test on
> https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c,
> which is indeed licensed with: GPL-2.0-or-later

That's not what the submission looks like, it looks a lot like the last
one from the first defines and variables...

But hey, what do I know, I'm not a lawyer which is why I keep insisting
that one from Intel actually read over this submission and sign-off on
it to verify that they agree with all of this.

thanks,

greg k-h
