Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2306556922A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Jul 2022 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbiGFSug (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Jul 2022 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbiGFSuf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Jul 2022 14:50:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC8223161;
        Wed,  6 Jul 2022 11:50:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 90DD0B81BF1;
        Wed,  6 Jul 2022 18:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C2EFC341C8;
        Wed,  6 Jul 2022 18:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1657133432;
        bh=F0/XVKDg3YIqGzbpwY8z/7I/yJ1VvZPV4zJoaMEXJZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dL7SYbgE8qHk3Il2TkQbLtQ2BF9Tkfy7gnziK5j4rWO1QLPZdvwaVcHl6qVpsOGRo
         m1LXPIUwMRYr3WFU/Pm9W8idoEAa+EZn0nonlho2ljY5HyF1R2RgnpPe5izc/+zA/x
         3+rPQSyAKABfLW2UFY2RJ016Wc0/+XrzU7B9pTCE=
Date:   Wed, 6 Jul 2022 11:50:31 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nico Pache <npache@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/vm: enable running select groups of tests
Message-Id: <20220706115031.3c312d9268bf87287be0b8f9@linux-foundation.org>
In-Reply-To: <CAA1CXcAFyMLBEi87A0+pBbUKtzfEeE-5uyqPugmHLmzgH8=w8w@mail.gmail.com>
References: <20220705185605.3889110-1-jsavitz@redhat.com>
        <20220705133456.d5572b2e36ebb36188369988@linux-foundation.org>
        <CAA1CXcAFyMLBEi87A0+pBbUKtzfEeE-5uyqPugmHLmzgH8=w8w@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, 6 Jul 2022 14:38:03 -0400 Nico Pache <npache@redhat.com> wrote:

> On Tue, Jul 5, 2022 at 4:35 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Tue,  5 Jul 2022 14:56:05 -0400 Joel Savitz <jsavitz@redhat.com> wrote:
> >
> > > Add the ability to run one or more groups of vm tests (specified
> > > by the environment variable TEST_ITEMS). Preserve existing default
> > > behavior of running all tests when TEST_ITEMS is empty or "default".
> >
> Hi Andrew,
> 
> > What is the reason for this?  What's the use case?
> 
> The current design of vm selftests is all-or-none. We'd like to be
> able to selectively run these tests (We settled for selective groups
> of tests rather than individual tests).
> 
> The main reason for doing this is our efforts to expand RedHats MM CI
> testing. There are two use cases for these changes that relate to our
> reasoning:
> 1) Our current CI has overlapping tests between LTP and vm selftests,
> so we'd like a way to prevent running the same test in two places.
> 2) We'd like the ability to skip a test if it is determined to be
> unstable or requires certain hardware requirements.
> 
> By adding this functionality we are really expanding what we are able
> to do with the stock vm-selftests.

OK, please let's get this info into the changelog - it's the most
important part.

> > And why via the environment rather than via commandline args?
> Just a design choice I suppose. I'm sure Joel would be willing to
> implement it as a cmdline arg if you'd prefer that approach.

I think that would be best.
