Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC66F59F391
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Aug 2022 08:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbiHXGWW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 02:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234976AbiHXGWU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 02:22:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04BD74369;
        Tue, 23 Aug 2022 23:22:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A0DF5B822DF;
        Wed, 24 Aug 2022 06:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21E6C433C1;
        Wed, 24 Aug 2022 06:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661322137;
        bh=MYjRFOzykWU4kB11CjnKF1aMAQUHKau4D0BfKC6M+4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bct2qLW7uslz+3YYfM0fh0QW9VkMkAvCSPk4DVlQBwkIOiLLxWcoF0n3NwQb4/EaQ
         Sm0KKn8eHd4jxmc6FgKx8qL2BiQj6UoVumxcUaP72p6rvHFVti4cuihtRjjKC+nAeG
         Sa9wjKwDuS58gO/DRCpTCI411Xlj6i34GTG0NhrA=
Date:   Wed, 24 Aug 2022 08:22:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Delgadillo <adelg@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Dylan Hatch <dylanbhatch@google.com>,
        Sasha Levin <sashalevin@google.com>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH] selftests: Add a taint selftest
Message-ID: <YwXDljUktgWqkl75@kroah.com>
References: <20220823211958.2519055-1-adelg@google.com>
 <YwWx07EbaB90jDUN@kroah.com>
 <CAEHm+vHHRLW1c2fhrgCx0Nh63udxMLCSwone-JTm22o2Q37abA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEHm+vHHRLW1c2fhrgCx0Nh63udxMLCSwone-JTm22o2Q37abA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 23, 2022 at 10:50:33PM -0700, Andrew Delgadillo wrote:
> On Tue, Aug 23, 2022 at 10:06 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Aug 23, 2022 at 09:19:58PM +0000, Andrew Delgadilo wrote:
> > > From: Andrew Delgadillo <adelg@google.com>
> > >
> > > When testing a kernel, one of the earliest signals one can get is if a
> > > kernel has become tainted. For example, an organization might be
> > > interested in mass testing commits on their hardware. An obvious first
> > > step would be to make sure every commit boots, and a next step would be
> > > to make sure there are no warnings/crashes/lockups, hence the utility of
> > > a taint test.
> >
> > What's wrong with the tools/debugging/kernel-chktaint script?
> >
> > Why do we need another "get what the taint status is" program?
> 
> The main functionality that this selftests has that kernel-chktaint
> does not is that it exits with a non-zero status code if the kernel is
> tainted. kernel-chktaint outputs information to stdout based on the
> taint status, but will always exit 0.

Great, then change that, don't create a whole new script :)

> The issue with this is that it cannot be plugged into a test runner
> that checks the exit code of a test script. In other words, if I
> wanted to plug it into git bisect, I would have to wrap
> kernel-chktaint in a command that transformed the output to an exit
> code. Sure that is doable, but it is not as simple as it could be.
> 
> More concretely, I am setting kselftest runs against kernel commits
> (with a harness that logs kselftest runs into some other
> infrastructure), and such a test that is missing is a kselftest that
> checks the kernel's taint status. One could argue that one should just
> create a kselftest target that calls into kernel-chktaint and parse
> the output there to determine what the exit status is, but that seems
> fragile as a change in the underlying script could break it. For
> example, if I want to test for taint #18, and I am grepping for the
> string " * an in-kernel test has been run (#18)", I will actually get
> a false positive because the underlying script does not check for
> taint #18. Contrived example yes, but I think it shows that textual
> grepping for errors is error prone (as an aside, I'll send a patch to
> update the script to check for the new taint bit).

Then modify the existing script to handle your use case, let's not have
duplicate ones in the tree.

thanks,

greg k-h
