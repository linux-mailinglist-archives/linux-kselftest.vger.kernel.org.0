Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4364A785BE3
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Aug 2023 17:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbjHWPTx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Aug 2023 11:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbjHWPTt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Aug 2023 11:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A440B1705
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 08:19:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1412664BB
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Aug 2023 15:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB41C433C8;
        Wed, 23 Aug 2023 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692803950;
        bh=/lRkxZVmgwENJ8PjOX7zjmXu9KZ1iUIojKKx7yG8BJA=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Jsf87sIOL7sjF+DKcL+wTib4EeZ6FNZ2kiQ9WNuSWqy0f3eOpZSN7K3I2rIAUChHE
         OnQlX12Tqq71y35i5V17QzLKyr+jY59zecNb1RKMAYiyj49PEGO3AaBQM3STm+R1YV
         kbMVzYogylAy6q82FqMsUzTuFf6Xdwb2LnaVT/Wk=
Date:   Wed, 23 Aug 2023 17:19:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wolfram Sang <wsa@kernel.org>, linux-kselftest@vger.kernel.org
Subject: Re: Repo for tests which fail currently?
Message-ID: <2023082315-estate-sushi-6150@gregkh>
References: <ZOXxSA1UKBkU/ou4@ninjato>
 <2023082335-retail-gallows-1fdc@gregkh>
 <ZOYgLVsehrfID2GZ@shikoro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOYgLVsehrfID2GZ@shikoro>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 23, 2023 at 05:05:17PM +0200, Wolfram Sang wrote:
> Hi Greg,
> 
> > Why not just add them to the kernel tree, with ksft_test_result_skip()
> > being the result for now while they still fail, and then when the kernel
> > code is fixed up, change that back to the correct
> > ksft_test_result_error() call instead?
> 
> Well, I don't want the tests to be skipped, I want them to be run :) So,
> they will indicate that someone is working on the issue when they turn
> from red to yellow / green. I expect the issues to be all over the place
> and I don't want to monitor all that manually.

The test will run, it will report failed, but then be allowed to "SKIP"
to keep the build clean.

> But since I do want them in the kernel tree and kselftest already has
> some nice infrastructure (like required config options), I wondered
> about a seperate directory, like "kfailtest". These tests are not run by
> default but whenever an issue from there gets fixed, an inverted /
> improved test can go to the proper kselftest folder. A bit like the
> staging folder where items are expected to move out. Except, here not
> the tests are ugly only their result is.
> 
> Maybe I'll start with this direction and see how it goes...

Try it and see.  Worst case, submit all your tests, have them all fail,
and then fix the kernel code :)

thanks,

greg k-h
