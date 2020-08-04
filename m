Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86D3D23BBF4
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbgHDOYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 10:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728903AbgHDOX6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 10:23:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80364C06174A;
        Tue,  4 Aug 2020 07:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=k3hHT8hBP3vIg+5n2HC1ywURgKIRKUgYzqnMS2vhhdM=; b=YaID0GqXpy1LpLRHHrlA5ZgUdz
        YRGNR6WocYcAEBMUYF6t2biBQQZsEFcHxoQjE9fZYjLOXGJvpnh17wTBwaWVviPibgVhjtzD1VpNl
        CXYJfWd6M0ExGPid892N2ilOazv9V15LYR0KDCJcB58l52fAtPISo6oZohbygZn1JD6R8o3EvvKJ0
        Mht2Ln7RQbdCwW6RIIT8QRChYwE6jcSTh01gvuhnDUVvaKgrbVrfETGDK9EsEGiZovSfSYX3GVzmO
        shjByq9fco8EqvTIr1/L1omF4lOkIZVQX82BF7paNS2+MsJFJuBPh/3IvmeI8gWNmTqqKPz4bK0qP
        LEmOq8jQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2xr0-0004yR-9p; Tue, 04 Aug 2020 14:23:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F2F730477A;
        Tue,  4 Aug 2020 16:23:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 281592B7C12A3; Tue,  4 Aug 2020 16:23:44 +0200 (CEST)
Date:   Tue, 4 Aug 2020 16:23:44 +0200
From:   peterz@infradead.org
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Ian Rogers <irogers@google.com>, mingo@kernel.org
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
Message-ID: <20200804142344.GM2674@hirez.programming.kicks-ass.net>
References: <20200729201146.537433-1-vitor@massaru.org>
 <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
 <20200804132517.GK2657@hirez.programming.kicks-ass.net>
 <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ6JjWzze-VAmg_b9EkS4iVySt5pw8V4FSxYpDFAj8jvBxuGA@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 04, 2020 at 10:46:21AM -0300, Vitor Massaru Iha wrote:
> On Tue, Aug 4, 2020 at 10:25 AM <peterz@infradead.org> wrote:
> > On Wed, Jul 29, 2020 at 06:57:17PM -0300, Vitor Massaru Iha wrote:
> >
> > > The results can be seen this way:
> > >
> > > This is an excerpt from the test.log with the result in TAP format:
> > > [snip]
> > > ok 5 - example
> > >     # Subtest: min-heap
> > >     1..6
> > >     ok 1 - test_heapify_all_true
> > >     ok 2 - test_heapify_all_false
> > >     ok 3 - test_heap_push_true
> > >     ok 4 - test_heap_push_false
> > >     ok 5 - test_heap_pop_push_true
> > >     ok 6 - test_heap_pop_push_false
> > > [snip]

So ^ is TAP format?

> > I don't care or care to use either; what does dmesg do? It used to be
> > that just building the self-tests was sufficient and any error would
> > show in dmesg when you boot the machine.
> >
> > But if I now have to use some damn tool, this is a regression.
> 
> If you don't want to, you don't need to use the kunit-tool. If you
> compile the tests as builtin and run the Kernel on your machine
> the test result will be shown in dmesg in TAP format.

That's seems a lot more verbose than it is now. I've recently even done
a bunch of tests that don't print anything on success, dmesg is clutter
enough already.
