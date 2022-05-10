Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94399522162
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 18:35:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbiEJQjW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 12:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244941AbiEJQjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 12:39:21 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D6FC2A4A16
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:35:21 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id x17so11182846ybj.3
        for <linux-kselftest@vger.kernel.org>; Tue, 10 May 2022 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PHyk6KxcWFuGsfBMCjMvRxqt94J8O6q+Cwc7jfhdMJk=;
        b=La2oft9h//4R7NqvABzmLzI24UNpXxonVaHdkSWY3twz6H0Y9sPpY85ie6wF+7yAer
         el6asuMYV9LYEDtIHuNlUjqpPhdUe4BY7enwH08fIwoE+8ta5ybTub7FzYKweCdK92pe
         iCK+SwuUga7+6KC/E8MDCPWI9ZsIBwZg1F1VIBWRCBEYpdAQEPwXieo5JlZvfz4OjrGq
         1/oys/C9twZpgnzlmD3QA7rKVETM+O4aWxKK50mwnTb+6qDnUm2jqDoIdEoxYbxv4MIO
         BQRCLGMjiT4wjyUshj2uFRw4PeH1iDXnVhXJTcIyvRHWWqYd/xykqO86bbSV8COo2rwn
         J3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PHyk6KxcWFuGsfBMCjMvRxqt94J8O6q+Cwc7jfhdMJk=;
        b=7ahXLuwl2rctwV95ZM3kj/MGPCh5f0M6JDI3/dkV2Iku2TdmKjTiDrkBBS73VQCrCa
         VUqRTGwo0QjLSYpqzUY706mWknXa367UmVGCcKwo/Drz9RY8UTq0JNe9dEFcz9LGxh8U
         FAFyQgGnKRhG4z89O2na7JRY2v60xTQpVYc2zE/bbzWusTRyRHXX4YyXJgRYCQKk+HMV
         VMPcrPJNOvDfnBux++5oBUKL/UBCKQ0IVEw+ragL+yXD1dkBTbvkOhzbbKu6e/BQxxOp
         2zL8e2Tj0SauuiCg+PwsPB+EJjW7jbbN66/OP0Su/nDD01eoG2CtghBSf9h3HDYibbwI
         TULA==
X-Gm-Message-State: AOAM530hN00OWWQWP0lkQU/Gvb2RW27OjEzUDFCPOL1rDmOavP+UMkcR
        2xgLMorwOXdxzPjTOR0IwAO9JADNertO6XHPBxJvyQ==
X-Google-Smtp-Source: ABdhPJzj9Ho7O1Hcx2a5+H/jratEJHay76ufapGe+gaVObbXYcEszYLH+XiZziFHLLNdOO3QjGUeT5y2pZslUkhvPxM=
X-Received: by 2002:a25:d55:0:b0:648:7008:61e0 with SMTP id
 82-20020a250d55000000b00648700861e0mr18392484ybn.282.1652200520221; Tue, 10
 May 2022 09:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220510030014.3842475-1-surenb@google.com> <20220510030014.3842475-2-surenb@google.com>
 <3e847a15-e8c0-41fd-9518-2ae3d4a39092@linuxfoundation.org>
In-Reply-To: <3e847a15-e8c0-41fd-9518-2ae3d4a39092@linuxfoundation.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 10 May 2022 09:35:09 -0700
Message-ID: <CAJuCfpHBURZCSq_bLpL5qsssUd1qEMK76K-5MwrdQvdW-pzaUg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: drop oom code from exit_mmap
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, May 10, 2022 at 8:46 AM Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> On 5/9/22 9:00 PM, Suren Baghdasaryan wrote:
> > With the oom-killer being able to operate on locked pages, exit_mmap
> > does not need to ensure that oom_reap_task_mm is done before it can
> > proceed. Instead it can rely on mmap_lock write lock to prevent
> > oom-killer from operating on the vma tree while it's freeing page
> > tables. exit_mmap can hold mmap_lock read lock when unmapping vmas
> > and then take mmap_lock write lock before freeing page tables.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >   include/linux/oom.h |  2 --
> >   mm/mmap.c           | 25 ++++++-------------------
> >   mm/oom_kill.c       |  2 +-
> >   3 files changed, 7 insertions(+), 22 deletions(-)
> >
>
> How does this improve the test? Include the information on why this
> change is needed as opposed describing what this does?

It doesn't improve the test. I used the test to verify this change and
wanted to keep them together so that others have an easy way to
exercise the same code path. That's the only relation between the test
and this cleanup. I'll split them into separate patchsets to avoid
further confusion.

>
> thanks,
> -- Shuah
