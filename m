Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C2EA7CC3CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Oct 2023 14:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234991AbjJQM5I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 08:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbjJQM4p (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 08:56:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FFE10DE;
        Tue, 17 Oct 2023 05:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TjP165kdnXnZeWEs6lPqJmTemVZVmWMQm34b8bWqLdI=; b=ltmteh5Hzny7tVZzXlOFG8QS/p
        3YJ7eG9UUk08wyDbfGAQhMuh2NIvNEbkORJg36P/Z7x/CSuUN8nmmbED0vYf4sl03v59vYlxP/X56
        2IZmlUzb6CRzr140Z+kAr+DxyJ17yI+1JpUe3xicV5+2NDhzq5HzvC/R6iouB6ETf/v1gXWHAIFCH
        eVGww/Mle6QpVDNH85gRMu4l6/FE6AUSDZ+f+b0HK1tDYdEsZFCwvS6bG5VLA5xOUHXHLu+N5j9U9
        5nBRieVWKifUAdaMytJ9HB7s5/cAbKTWuOuMvWb5e3CAuDCvwAIXQKJMb3syDXVkZ15gMj+ez9pPd
        w5et+yUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qsjcJ-00CQmQ-7n; Tue, 17 Oct 2023 12:56:11 +0000
Date:   Tue, 17 Oct 2023 13:56:11 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Jeff Xu <jeffxu@google.com>
Cc:     jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, torvalds@linux-foundation.org,
        lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com,
        namit@vmware.com, peterx@redhat.com, peterz@infradead.org,
        ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz,
        xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com,
        dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
Message-ID: <ZS6Ea4/KI0mKiRMv@casper.infradead.org>
References: <20231016143828.647848-1-jeffxu@chromium.org>
 <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CALmYWFu58LYuSn8DqiU8NjPJzTQuLXu4mg7dHaP1ZW2z3jaaXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALmYWFu58LYuSn8DqiU8NjPJzTQuLXu4mg7dHaP1ZW2z3jaaXQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 17, 2023 at 01:34:35AM -0700, Jeff Xu wrote:
> > > types: bit mask to specify which syscall to seal, currently they are:
> > > MM_SEAL_MSEAL 0x1
> > > MM_SEAL_MPROTECT 0x2
> > > MM_SEAL_MUNMAP 0x4
> > > MM_SEAL_MMAP 0x8
> > > MM_SEAL_MREMAP 0x10
> >
> > I don't understand why we want this level of granularity.  The OpenBSD
> > and XNU examples just say "This must be immutable*".  For values of
> > immutable that allow downgrading access (eg RW to RO or RX to RO),
> > but not upgrading access (RW->RX, RO->*, RX->RW).
> >
> > > Each bit represents sealing for one specific syscall type, e.g.
> > > MM_SEAL_MPROTECT will deny mprotect syscall. The consideration of bitmask
> > > is that the API is extendable, i.e. when needed, the sealing can be
> > > extended to madvise, mlock, etc. Backward compatibility is also easy.
> >
> > Honestly, it feels too flexible.  Why not just two flags to mprotect()
> > -- PROT_IMMUTABLE and PROT_DOWNGRADABLE.  I can see a use for that --
> > maybe for some things we want to be able to downgrade and for other
> > things, we don't.
> >
> Having a seal type per syscall type helps to add the feature incrementally.
> Applications also know exactly what is sealed.

You're trying to portray a disadvantage as an advantage,  This is the
seccomp disease, only worse because you're trying to deny individual
syscalls instead of building up a list of permitted syscalls.  If we
introduce a new syscall tomorrow which can affect VMAs, we'll then
make it the application's fault for not disabling that new syscall.
That's terrible design!

> I'm not against types such as IMMUTABLE and DOWNGRADEABLE, if we
> can define what it seals precisely. As Jann pointed out, there have
> other scenarios that potentially affect IMMUTABLE. Implementing all thoses
> will take time. And if we missed a case, we could introduce backward
> compatibility issues to the application. Bitmask will solve this nicely, i.e.
> application will need to apply the newly added sealing type explicitly.

It is your job to do this.  You seem to have taken the attitude that you
will give the Chrome team exactly what they asked for instead of trying
to understand their requirements and give them what they need.

And don't send a v2 before discussion of v1 has come to an end.  It
uselessly fragments the discussion.
