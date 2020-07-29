Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B521232651
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jul 2020 22:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbgG2UjU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Jul 2020 16:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG2UjT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Jul 2020 16:39:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87631C061794;
        Wed, 29 Jul 2020 13:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5Qs3p6P4FMzOMl5aW3FKm/tj+DXE8Wr/ANqUkYSmnxo=; b=Uaia+u2ySpbc2h1Ps6QsIoNc4p
        jSX+q1S6Vuha5uj+6BOSmzBjVaLlLpVyA4bKQfJyjhtt+LOVevmfaCrMIjB5lOmwXfGsuQAoKbmZH
        5sGGvNXTp/raCi/HqwvMSfcn2rG/NPsoV482CScDRYydGZ8Dfqk/QFg+7FLfrY78GhPpH9e3mlacA
        X0Qbf3j1EzEP8zTY7EmVZ6uxsHYkigr4enOa1pITW8HB3zk1X4OiLfPB5CucQfIqmoEBL+V92zpO/
        CZZ2VsrRocPPhFROKYJekMt+zw4QHnFCH8E7+EregovfsE+um4XCVi07pWZn+RYlSImNThJySzJEw
        RJGyNquA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0sr2-0007I0-GB; Wed, 29 Jul 2020 20:39:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFD8D304D28;
        Wed, 29 Jul 2020 22:39:08 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B6947200D4162; Wed, 29 Jul 2020 22:39:08 +0200 (CEST)
Date:   Wed, 29 Jul 2020 22:39:08 +0200
From:   peterz@infradead.org
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org, irogers@google.com,
        mingo@kernel.org
Subject: Re: [PATCH] lib: kunit: add test_min_heap test conversion to KUnit
Message-ID: <20200729203908.GD2655@hirez.programming.kicks-ass.net>
References: <20200729201146.537433-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729201146.537433-1-vitor@massaru.org>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 29, 2020 at 05:11:46PM -0300, Vitor Massaru Iha wrote:
> This adds the conversion of the runtime tests of test_min_heap,
> from `lib/test_min_heap.c` to KUnit tests.
> 
> Please apply this commit first (linux-kselftest/kunit-fixes):
> 3f37d14b8a3152441f36b6bc74000996679f0998 kunit: kunit_config: Fix parsing of CONFIG options with space
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  lib/Kconfig.debug                         |  29 ++++--
>  lib/Makefile                              |   2 +-
>  lib/{test_min_heap.c => min_heap_kunit.c} | 117 ++++++++++++----------
>  3 files changed, 83 insertions(+), 65 deletions(-)
>  rename lib/{test_min_heap.c => min_heap_kunit.c} (60%)

So where's the win? What's KUnit, why should I care and more lines.
