Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFC59CC0E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Aug 2022 01:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbiHVXUz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 19:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiHVXUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 19:20:54 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC074C611
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 16:20:54 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id 67so12845991vsv.2
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 16:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=mBK6+o6j2+LotCf9yizAJHX+fJSdClQm/ts8RAL5b8U=;
        b=sqD+PAPbDVU9CLXulqfqsL3lHh3OuDUG94kxY4GfaAGOv0bWY0XrU48QjChcINwFtf
         salod/xp4xKGuALe3sFKfA9Bj0ArmA16BjiA2XMNitS1fl0IUaRnIuXKsMwMuckTUdVG
         RChpp9PDTMb4WwKcwizkIwdIhteub8KOQsqNx7Ue78k59/Gb4okiIcbNqtNW27NiuZdX
         Vt7+OnUE9E8XMjHf/KC5y4a4Hly+6TTcA8h2zmcXcV5nsgQ/1SOe9UR2m6ShM9IHqUPY
         7NK0E7YlzRPj/fYfFRfMff+NihzP43hxumJ6cEEL8iGvXKK/OGdf4N549ralRG1mt8U+
         9vlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=mBK6+o6j2+LotCf9yizAJHX+fJSdClQm/ts8RAL5b8U=;
        b=JRKOJ69M/ZtmZSeSpHSLkg6kzeJq4g7eujyRj4pKhI1R31xp3vXewL4hbLYlEewF9q
         nTP/kGVjEjfq0HQWWO9ajVYTc5eWSFH0b1345Jc43cv8kuELrNovQajgJh2OTNflb1Kr
         gaQCzz6DfzNguzjv3p/Bny6hftUnVYLWQMqHPcv5VNMSqfoAw6wThxryQpYfPeDImQ/C
         faNEJ/oMIYpIg7t4bWDEEwjkeLRf+XNemiKnOM88YU/rU/2c3oYr6Uqhg/YSwKvQ43lY
         Wj5tqGwPz0dkT5KHIgZCz0vsWFI0rL8auBQVJf0W2bKuBmfU/H0H8K3MYFBVODLyZTAZ
         i7zA==
X-Gm-Message-State: ACgBeo00BwmR06udmSZTLdp4Z5FZ/7OLDwP2DOPVS9IHmL7/q1MlNvqp
        RyGL1sRR6V31KP6D7RlnXt/A8iTW62Yr18tIdaSu5Q==
X-Google-Smtp-Source: AA6agR5sKW4nrM3CN3TZoWhDbp0nd4726mDl9MWrNuIWkNfHs3XGmx2OlWmpPeTyS5Xs7YN96PqFfc2LP10bn8wnLA8=
X-Received: by 2002:a67:d504:0:b0:390:3c26:7aa2 with SMTP id
 l4-20020a67d504000000b003903c267aa2mr5290241vsj.15.1661210453110; Mon, 22 Aug
 2022 16:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com> <20220531223100.510392-2-surenb@google.com>
 <20220822152119.96d40c884078229ee3e6b25e@linux-foundation.org>
 <CAOUHufbysRjhX_AiFirjvWCR129t4_bELd1wFQG+fBsZpzhgYw@mail.gmail.com>
 <20220822154822.366a9e4527b748cf99d98637@linux-foundation.org>
 <CAOUHufa1zc3fMWsyyz1uB6_gsgVPk1Hw_T31WzWK58QVgsQSAQ@mail.gmail.com> <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
In-Reply-To: <20220822161603.9e19edfe2daaea3bf591910a@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 22 Aug 2022 17:20:17 -0600
Message-ID: <CAOUHufbyWwkOAJTD4G82sLcwE_33Yy=s4Q+gGBujwXvEBZ8iqA@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/2] mm: delete unused MMF_OOM_VICTIM flag
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>, brauner@kernel.org,
        Christoph Hellwig <hch@infradead.org>, oleg@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, shuah@kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
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

On Mon, Aug 22, 2022 at 5:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Mon, 22 Aug 2022 16:59:29 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > > > @@ -4109,7 +4109,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned
> > > > long start, unsigned long end,
> > > >
> > > >                 walk_pmd_range(&val, addr, next, args);
> > > >
> > > > -               if (mm_is_oom_victim(args->mm))
> > > > +               if (test_bit(MMF_OOM_REAP_QUEUED, &args->mm->flags))
> > > >                         return 1;
> > > >
> > > >                 /* a racy check to curtail the waiting time */
> > >
> > > Oh.  Why?  What does this change do?
> >
> > The MMF_OOM_REAP_QUEUED flag is similar to the deleted MMF_OOM_VICTIM
> > flag, but it's set at a later stage during an OOM kill.
> >
> > When either is set, the OOM reaper is probably already freeing the
> > memory of this mm_struct, or at least it's going to. So there is no
> > need to dwell on it in the reclaim path, hence not about correctness.
>
> Thanks.  That sounds worthy of some code comments?

Will do. Thanks.
