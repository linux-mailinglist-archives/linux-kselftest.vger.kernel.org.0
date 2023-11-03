Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19D47E0357
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Nov 2023 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376427AbjKCNIe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 3 Nov 2023 09:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKCNId (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 3 Nov 2023 09:08:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31911111;
        Fri,  3 Nov 2023 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FVKgUj0uIHkMY78KC2G3LoMl8HM52HmVt0kx80HproA=; b=bbOoB+IOaYQ7ibWjfJ0UuoeNc9
        tqG6JFZK+5q/P5hbo3bF24UolPUzIHBjInC9ad/2V4q8sMTi2PeKiAhIdoE9tUgBfF5ejOLGmQOKL
        hvPT68kZzruopT6g92dRJ5stja0/mnoWKg+4ykIFhdh9d8RqtBG/8vQJuqJQgYrIUGwo7FCBqRmZy
        mqx61wXt+mhGOh1n7qXCNtAMTvA0zFrFszr00Nt31MdL4IvEOR0aBFlY2eJKmiNBNzcMl2OLnjkw9
        fIqyiGQBItdk26uVw/BtIObjQK9Rp2+QIvDlZW3bBuEOiI8KvUXjQVJ4Qenhu4xziGBXDI96ri8cM
        Zk5Ib0xQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qytuI-005WWa-EH; Fri, 03 Nov 2023 13:08:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id C451D30027B; Fri,  3 Nov 2023 14:08:14 +0100 (CET)
Date:   Fri, 3 Nov 2023 14:08:14 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Message-ID: <20231103130814.GC8262@noisy.programming.kicks-ass.net>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
 <20231103124606.GB8262@noisy.programming.kicks-ass.net>
 <15ff806d-59ab-46ab-8891-05ab917a1528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15ff806d-59ab-46ab-8891-05ab917a1528@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 03, 2023 at 01:59:28PM +0100, David Hildenbrand wrote:

> Okay. the question is if your workflow can be easily adjusted, or if we can
> improve that header handling as a whole.

So on IRC the following was suggested:

  make O=defconfig-build headers ; make O=defconfig-build -C tools/testing/selftests/x86

But that makes absolutely no sense to me; because the headers and
selftests are not .config dependent. Furthermore I don't want them in a
kernel build dir.

> The problem I had with this recently: just because we did a "make headers"
> once in a git tree doesn't mean that it is still up-to-date.
> 
> So once some selftest changes showed up that require newer headers, building
> the selftests again fails without a hint that another round of "make
> headers" would be required.

Yeah, so I've been adding #ifndef guards all over the place for decades
and that just works. You need it in normal userspace too.

This super reliance on the very latestesetst headers is just a total
pain.
