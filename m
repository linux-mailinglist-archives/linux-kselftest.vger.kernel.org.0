Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A6D253BB53
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jun 2022 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiFBPDG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Jun 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbiFBPDF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Jun 2022 11:03:05 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9038C9C2E3
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Jun 2022 08:03:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p13so8801206ybm.1
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Jun 2022 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VrpT+1Lsi6jca7SxhpmDUEdjKT7O5trvRYqg6tF6OAU=;
        b=bMFgFjuZwiNL3X7wdkEkTZzHCUQm9i5bLn6Ex5kneLO2hUl4jOJQTYYjA+UutVaAID
         anUZF4jOLMaIGArGNX7y1nBf3KiSy0BoWQfnYS2smhON95cGRc/KiLZ3abUysz/NECfr
         QThUVZC4mwvj/1YMiVQVTS174pcrAgpYJvpaXAI7mI4t+orRJkwY36K819fBIpJoUvQM
         d5ukoDbpt0eQL9AfJMo4CwS9jmMbWGkphsXf672XfKgmFWEq2eaUnIS5SQR6+4II/Snn
         8oin9q+XSMa1+8WxFOK2/txLuyDzemw7aTER9kKtqhL8R2drfXTGvJynpjU3BAm5srCR
         7Xhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VrpT+1Lsi6jca7SxhpmDUEdjKT7O5trvRYqg6tF6OAU=;
        b=z2Bs2ZnwA2f/7Nd6ayq+rqy78RJxIol0cIwsV3PC7WgOZQtesDGhDHWpEuGW27vRtb
         H7vhX3u1PzNuNza36LeG4d1TmqU4If6pp5NhNjPkqHobFDDZIPW6u/vBmJ3gKKYVRUAy
         PdQhvl2O4daWP5UgDuQ+yrQ7PX7LznI4yzb8zSLkR17QhSG445ooVBaZjQ9zhafUf6tj
         szKQ/+FFCd37Iv01/xFK124GDPwU9qSDwaJRWE7Nl4nKhUqPKwJiQ7uOZH6dYpj2tOs/
         qDfEyX3/iGI+eaajUuCPfedUc1CxaytzEj1Z415E2PxK3M5mdjfCOLNfic7uJej6b16l
         iZ9g==
X-Gm-Message-State: AOAM532Yz57B0YKCXCWX+qFsJB3UPNxCb2OgrukHy/ZHE3H4YHlvqPWs
        lr9TbLpDzOqr1jF2T6syoOCbRVaiQOLREdVOVX4M+Q==
X-Google-Smtp-Source: ABdhPJwN5nVrGFtyA2hSIkpqsP/GYytTm6u1LFXXIJlIvve3dP28aJBB1N7bZsSiCcqwiuDKTw3A65nKpXG5EtlHRjc=
X-Received: by 2002:a25:2ad8:0:b0:65d:22a5:f19e with SMTP id
 q207-20020a252ad8000000b0065d22a5f19emr5587363ybq.426.1654182183552; Thu, 02
 Jun 2022 08:03:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220531223100.510392-1-surenb@google.com> <20220601143638.9e78c470d2c980053cc8059a@linux-foundation.org>
 <CAJuCfpHcPhDYTpLj8Vo+W9Q6KkWdT_BOTaEfJW6_PDCPx5kD-A@mail.gmail.com> <Ypi9pOXfuyPJ24pe@casper.infradead.org>
In-Reply-To: <Ypi9pOXfuyPJ24pe@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 2 Jun 2022 08:02:52 -0700
Message-ID: <CAJuCfpFYXVVUPH1emd=90S_y8n7t7zq+muYyfvp-rVdECORR4g@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 1/2] mm: drop oom code from exit_mmap
To:     Matthew Wilcox <willy@infradead.org>
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

On Thu, Jun 2, 2022 at 6:39 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jun 01, 2022 at 02:47:41PM -0700, Suren Baghdasaryan wrote:
> > > Unclear why this patch fiddles with the mm_struct locking in this
> > > fashion - changelogging that would have been helpful.
> >
> > Yeah, I should have clarified this in the description. Everything up
> > to unmap_vmas() can be done under mmap_read_lock and that way
> > oom-reaper and process_mrelease can do the unmapping in parallel with
> > exit_mmap. That's the reason we take mmap_read_lock, unmap the vmas,
> > mark the mm with MMF_OOM_SKIP and take the mmap_write_lock to execute
> > free_pgtables. I think maple trees do not change that except there is
> > no mm->mmap anymore, so the line at the end of exit_mmap where we
> > reset mm->mmap to NULL can be removed (I show that line below).
>
> I don't understand why we _want_ unmapping to proceed in parallel?  Is it
> so urgent to unmap these page tables that we need two processes doing
> it at the same time?  And doesn't that just change the contention from
> visible (contention on a lock) to invisible (contention on cachelines)?

It's important for process_madvise() syscall not to be blocked by a
potentially lower priority task doing exit_mmap. I've seen such
priority inversion happening when the dying process is running on a
little core taking its time while a high-priority task is waiting in
the syscall while there is no reason for them to block each other.

>
