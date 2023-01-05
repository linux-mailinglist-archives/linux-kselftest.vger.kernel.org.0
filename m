Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5A465ED7F
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Jan 2023 14:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232763AbjAENmr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Jan 2023 08:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbjAENmp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Jan 2023 08:42:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEEB32E98;
        Thu,  5 Jan 2023 05:42:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 682B561A51;
        Thu,  5 Jan 2023 13:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8E7C433EF;
        Thu,  5 Jan 2023 13:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672926163;
        bh=WCsf7zNWTsY5rzmNTg49RZ9NN7AfHsfscrxnvj1ve2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fyMcZw0N2f3qCyF37HHD+GWeKIYKOIy0KFGZJmK48Ssm5OfRvMHrAdh2JVOhi6JVz
         JVuK0Q92l/hidrl1dXZtBMD6mVVOjqSLhCEqngi1F03HvLkk7RrgXUvFLdjGnlQd+K
         MT+AZCaqJk48fpqHbCIM6w2QJhOt/VTzFLBuIo6k=
Date:   Thu, 5 Jan 2023 14:42:40 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aaron Lu <aaron.lu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Pavel Boldin <pboldin@cloudlinux.com>,
        Pavel Boldin <boldin.pavel@gmail.com>,
        "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
        Moritz Lipp <github@mlq.me>,
        Daniel Gruss <daniel.gruss@iaik.tugraz.at>,
        Michael Schwarz <michael.schwarz91@gmail.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftest/x86/meltdown: Add a selftest for meltdown
Message-ID: <Y7bT0OL8RAWkCu0Z@kroah.com>
References: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7bD+R/cxZ4p/nWe@ziqianlu-desk1>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 05, 2023 at 08:35:05PM +0800, Aaron Lu wrote:
> To capture potential programming errors like mistakenly setting Global
> bit on kernel page table entries, a selftest for meltdown is added.
> 
> This selftest is based on Pavel Boldin's work at:
> https://github.com/linux-test-project/ltp/blob/master/testcases/cve/meltdown.c
> 
> In addition to the existing test of reading kernel variable
> saved_command_line from user space, one more test of reading user local
> variable through kernel direct map address is added. For the existing
> test(reading saved_command_line) to report a failure, both the high kernel
> mapping and low kernel mapping have to be in leaked state; For the added
> test(read local var), only low kernel mapping leak is enough to trigger
> a test fail, so both tests are useful.
> 
> Test results of 10 runs:
> 
> On v6.1-rc8 with nopti kernel cmdline option:
> 
> host              test_out_rate_1    test_out_rate_2
> lkp-bdw-de1            50%               100%
> lkp-hsw-d01            70%               100%
> lkp-hsw-d02             0%                80%
> lkp-hsw-d03            60%               100%
> lkp-hsw-d04            20%               100%
> lkp-hsw-d05            60%               100%
> lkp-ivb-d01             0%                70%
> lkp-kbl-d01           100%               100%
> lkp-skl-d02           100%                90%
> lkp-skl-d03            90%               100%
> lkp-skl-d05            60%               100%
> kbl-vm                100%                80%
> 2 other machines have 0% rate for both tests.
> 
> bdw=broadwell, hsw=haswell, ivb=ivybridge, etc.
> 
> test_out_rate_1: test reports fail rate for the test of reading
> saved_command_line from user space;
> test_out_rate_2: test reports fail rate for the test of reading user
> local variable through kernel direct map address in user space.
> 
> On v5.19 without nopti cmdline option:
> host              test_out_rate_2
> lkp-bdw-de1            80%
> lkp-hsw-4ex1           50%
> lkp-hsw-d01            30%
> lkp-hsw-d03            10%
> lkp-hsw-d04            10%
> lkp-kbl-d01            10%
> kbl-vm                 80%
> 7 other machines have 0% rate for test2.
> 
> Also tested on an i386 VM with 512M memory and the test out rate is 100%
> when adding nopti to kernel cmdline with v6.1-rc8.
> 
> Main changes I made from Pavel Boldin's meltdown test are:
> - Replace rdtscll() and clflush() with kernel's implementation;
> - Reimplement find_symbol_in_file() to avoid bringing in LTP's library
>   functions;
> - Coding style changes: placing the function return type in the same
>   line of the function.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> ---
> Notable changes from RFC v3:
> - Drop RFC tag;
> - Change the base code from zlib licensed one to GPL licensed one.

Sorry, but this still gets my NAK for the issues raised in previous
reviews that are not addressed here for some reason :(

greg k-h
