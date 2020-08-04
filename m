Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4F23BB23
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 15:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHDNZk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728419AbgHDNZ1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 09:25:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D026C06174A;
        Tue,  4 Aug 2020 06:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ey6gOzQW7qkYrkGPNCRXw13EnycFk1/ExnTO9ySv+ao=; b=kdP9moyvhKotGxsGs3ud6CrK+C
        F68D1NJpJD69Xd4nD50xvXZSv9JbdEfKoM36v3Yxr8CYIdoliwHD2LUNXC0+Vaj/DoZV+DNp4R7hT
        pBkJ6IWSHjUERcNNKspiTvwg819ydcytVWnJFstoJ2COGk/hdxxa7/++qWDDvhzVn5goAuB9jaGxz
        MkZP3ZNmLUv4vgfuIK+q8qGylerjGw8ApEVM7Uc94yrHVH9fRQpa5U3RoVXMlbN//m1m737Y6xJaK
        6TWeKYTjacuU4uCc6fslXcEMhyauTVUJe+3gIOlPkcKeggVGcLJkoXI9JyF+QZJm1AcA7LHqIZfw0
        gE9RqyEw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2wwQ-0006if-TC; Tue, 04 Aug 2020 13:25:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BC18304E03;
        Tue,  4 Aug 2020 15:25:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2DC352B622ED0; Tue,  4 Aug 2020 15:25:17 +0200 (CEST)
Date:   Tue, 4 Aug 2020 15:25:17 +0200
From:   peterz@infradead.org
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org, irogers@google.com,
        mingo@kernel.org
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
Message-ID: <20200804132517.GK2657@hirez.programming.kicks-ass.net>
References: <20200729201146.537433-1-vitor@massaru.org>
 <20200729203908.GD2655@hirez.programming.kicks-ass.net>
 <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADQ6JjW-=SNjV-abGpGA9NfHD4yGG_bD5FmvW99W-Vo06twkbw@mail.gmail.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 06:57:17PM -0300, Vitor Massaru Iha wrote:

> The results can be seen this way:
> 
> This is an excerpt from the test.log with the result in TAP format:
> [snip]
> ok 5 - example
>     # Subtest: min-heap
>     1..6
>     ok 1 - test_heapify_all_true
>     ok 2 - test_heapify_all_false
>     ok 3 - test_heap_push_true
>     ok 4 - test_heap_push_false
>     ok 5 - test_heap_pop_push_true
>     ok 6 - test_heap_pop_push_false
> [snip]
> 
> And this from kunit-tool:
> [snip]
> [18:43:32] ============================================================
> [18:43:32] ======== [PASSED] min-heap ========
> [18:43:32] [PASSED] test_heapify_all_true
> [18:43:32] [PASSED] test_heapify_all_false
> [18:43:32] [PASSED] test_heap_push_true
> [18:43:32] [PASSED] test_heap_push_false
> [18:43:32] [PASSED] test_heap_pop_push_true
> [18:43:32] [PASSED] test_heap_pop_push_false
> [18:43:32] ============================================================
> [18:43:32] Testing complete. 20 tests run. 0 failed. 0 crashed.
> [18:43:32] Elapsed time: 9.758s total, 0.001s configuring, 6.012s
> building, 0.000s running
> [snip]

I don't care or care to use either; what does dmesg do? It used to be
that just building the self-tests was sufficient and any error would
show in dmesg when you boot the machine.

But if I now have to use some damn tool, this is a regression.
