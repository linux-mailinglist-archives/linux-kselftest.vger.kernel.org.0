Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67E9953B9F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 15:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiFBNkQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 09:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233407AbiFBNkP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 09:40:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA41A1F0A71;
        Thu,  2 Jun 2022 06:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cYfEvCQT+uciRQa6krW9NS+mCqa1kfyLmC48zuNRnoY=; b=Xan9o4ckQ1TkMX1sXOlS09b4fc
        YlC+sT3AQvMozlpPmNIgq9TukbWZrGOdiJ1mYFW8t/I7pLpOJiK/S+l7G/GIyFCL67jw05ciLA579
        G2HfufNdHsQoC3UydGUucTfoPlPpSsMB9tBaIhvBkg1HKPDD/+qQYWZ9Krrpu8D1qkyeJOpgFmpZL
        XF3iEs0T686Y1oGblFPmjG3PGompJN08kWUZKgmVwFE0Lfb2cpiTN9YEIt6l9MzTWhQKoGT/brBRg
        dTMgnGYiXxBubIRXodZDq43TFhSJNNwtlQAAhtT9f7AdISeyg1PBsh71MGnec5RmEvEno0TDkVLl7
        hTrr7yoQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwl3E-007Avw-95; Thu, 02 Jun 2022 13:39:48 +0000
Date:   Thu, 2 Jun 2022 14:39:48 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team <kernel-team@android.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
Message-ID: <Ypi9pOXfuyPJ24pe@casper.infradead.org>
References: <20220531223100.510392-1-surenb@google.com>
 <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
 <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 01, 2022 at 02:47:41PM -0700, Suren Baghdasaryan wrote:
> > Unclear why this patch fiddles with the mm_struct locking in this
> > fashion - changelogging that would have been helpful.
> 
> Yeah, I should have clarified this in the description. Everything up
> to unmap_vmas() can be done under mmap_read_lock and that way
> oom-reaper and process_mrelease can do the unmapping in parallel with
> exit_mmap. That's the reason we take mmap_read_lock, unmap the vmas,
> mark the mm with MMF_OOM_SKIP and take the mmap_write_lock to execute
> free_pgtables. I think maple trees do not change that except there is
> no mm->mmap anymore, so the line at the end of exit_mmap where we
> reset mm->mmap to NULL can be removed (I show that line below).

I don't understand why we _want_ unmapping to proceed in parallel?  Is it
so urgent to unmap these page tables that we need two processes doing
it at the same time?  And doesn't that just change the contention from
visible (contention on a lock) to invisible (contention on cachelines)?

