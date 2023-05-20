Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764AB70A4D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 05:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjETDRv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 23:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjETDRu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 23:17:50 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6399EEA
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 20:17:49 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-561c1436c75so59898037b3.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 20:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684552668; x=1687144668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpCD1jtGuwu5J2PBZwRsJvmd7HPbIcqI3mtODbtvJa0=;
        b=LaVArUpzA/aA+gVeXaGSxBECo4G2Rf7ssuzQXn5M3i/GNDUeu1d28yPSn79uqV2+1I
         ZtLg1ix+cxOKdOR6y8PgUXNwkh7syZACcYLC1OtxJKfpzhiepiW8ZvsNFA8hp9VHwywt
         mh+HdkRD4FGGt2auwIsvwUuul9lqfSewlhzs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684552668; x=1687144668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpCD1jtGuwu5J2PBZwRsJvmd7HPbIcqI3mtODbtvJa0=;
        b=QJ+y3JigJkvzJXo5hsWcUknqcisQcT1VnbGNFxxm92sFlC8t25Dw0NtnWQgj9FMhLI
         GfaEvsYiMUAGg56kdiFDkGgYCyjEMND6WfJGUOLA4OPCuS5Eb+SAUtAvvf5o3p4foKxV
         i9zPA3cDZQSIlnVujYwIuE4ovk/ycK3ETBfDU0ymIIXlwmHNEplWc/l55mqRHicv3uTM
         QnQ5NwT5EC2XU5v1MkJWaCMv+pajHG03iZA44a2BR6yatgyt9cCpt199dQkktiIgLA6c
         c/5QwpCRTWPdC9ESCTzAsarpLenhrZBqN0kSy3M8m4PySRuW+m8XaMS52qsRnpCyFDER
         5ZYw==
X-Gm-Message-State: AC+VfDyMAJkVrBsSXymSXhFl+Sgd8UTF9mKUZmX6ZXntgvMOqcCUDgDW
        yWyHiUlUDQnNrrnQOpI1/G64kW5roG7ilnueY24vfQ==
X-Google-Smtp-Source: ACHHUZ5tsf7hnMvLWVbHF1KHd68Wkr8LFV0a3I7RI0M0+ZPAQAzMG2ULQkC55IlU0+khIkjwG5XVm7xTlZnvP6FWyVA=
X-Received: by 2002:a81:840a:0:b0:561:eb35:a660 with SMTP id
 u10-20020a81840a000000b00561eb35a660mr3941669ywf.1.1684552668397; Fri, 19 May
 2023 20:17:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com> <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
In-Reply-To: <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 May 2023 23:17:37 -0400
Message-ID: <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Linus,

On Fri, May 19, 2023 at 10:34=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, May 19, 2023 at 3:52=E2=80=AFPM Joel Fernandes <joel@joelfernande=
s.org> wrote:
> > >
> > > I *suspect* that the test is literally just for the stack movement
> > > case by execve, where it catches the case where we're doing the
> > > movement entirely within the one vma we set up.
> >
> > Yes that's right, the test is only for the stack movement case. For
> > the regular mremap case, I don't think there is a way for it to
> > trigger.
>
> So I feel the test is simply redundant.
>
> For the regular mremap case, it never triggers.

Unfortunately, I just found that mremap-ing a range purely within a
VMA can actually cause the old and new VMA passed to
move_page_tables() to be the same.

I added a printk to the beginning of move_page_tables that prints all the a=
rgs:
printk("move_page_tables(vma=3D(%lx,%lx), old_addr=3D%lx,
new_vma=3D(%lx,%lx), new_addr=3D%lx, len=3D%lx)\n", vma->vm_start,
vma->vm_end, old_addr, new_vma->vm_start, new_vma->vm_end, new_addr,
len);

Then I wrote a simple test to move 1MB purely within a 10MB range and
I found on running the test that the old and new vma passed to
move_page_tables() are exactly the same.

[   19.697596] move_page_tables(vma=3D(7f1f985f7000,7f1f98ff7000),
old_addr=3D7f1f987f7000, new_vma=3D(7f1f985f7000,7f1f98ff7000),
new_addr=3D7f1f98af7000, len=3D100000)

That is a bit counter intuitive as I really thought we'd be splitting
the VMAs with such a move. Any idea what am I missing?

Also, such a usecase will break with my patch as we may accidentally
overwrite parts of a range that were not part of the mremap request.
Maybe I should just turn off the optimization if vma =3D=3D new_vma,
however that will also turn it off for the stack move so then maybe
another way is to special case stack moves in move_page_tables().

So this means I have to go back to the drawing board a bit on this
patch, and also add more tests in mremap_test.c to test such
within-VMA moving. I believe there are no such existing tests... More
work to do for me. :-)

> And for the stack movement case by execve, I don't think it matters if
> you just were to change the logic of the subsequent checks a bit.
>
> In particular, you do this:
>
>         /* If the masked address is within vma, there is no prev
> mapping of concern. */
>         if (vma->vm_start <=3D addr_masked)
>                 return false;
>
>         /*
>          * Attempt to find vma before prev that contains the address.
>          * On any issue, assume the address is within a previous mapping.
>          * @mmap write lock is held here, so the lookup is safe.
>          */
>         cur =3D find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
>         if (!cur || cur !=3D vma || !prev)
>                 return true;
>         /* The masked address fell within a previous mapping. */
>         if (prev->vm_end > addr_masked)
>                 return true;
>
>         return false;
>
> And I think that
>
>         if (!cur || cur !=3D vma || !prev)
>                 return true;
>
> is actively wrong, because if there is no 'prev', then you should return =
false.

During my tests, I observed that there was always an existing,
unrelated memory mapping present prior to the new memory region
allocated by mmap. Based on this observation, I concluded that if
there is no previous mapping (i.e., if prev is NULL), it indicates a
potential issue with find_vma_prev(). Therefore, I designed this
function to return here indicating that the masked address is not
suitable for optimization, whenever prev is NULL.

That's obviously confusing so I'll try to rewrite this part of the
patch a bit better with appropriate comments.

> So I *think* all of the above could just be replaced with this instead:
>
>         find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
>         return prev && prev->vm_end  > addr_masked;
>
> because only if we have a 'prev', and the prev is into that masked
> address, do we need to avoid doing the masking.
>
> With that simplified test, do you even care about that whole "the
> masked address was already in the vma"? Not that I can see.
>
> And we don't even care about the return value of 'find_vma_prev()',
> because it had better be 'vma'. We're giving it 'vma->vm_start' as an
> address, for chrissake!
>
> So if you *really* wanted to, you could do something like
>
>         cur =3D find_vma_prev(..);
>         if (WARN_ON_ONCE(cut !=3D vma))
>                 return true;
>
> but even that WARN_ON_ONCE() seems pretty bogus. If it triggers, we
> have some serious corruption going on.
>
> So I stil find that whole "vma->vm_start <=3D addr_masked" test a bit
> confusing, since it seems entirely redundant.
>
> Is it just because you wanted to avoid calling "find_vma_prev()" at
> all? Maybe just say that in the comment.

Yes exactly, I did not want to run find_vma_prev() unnecessarily. I
will add such clarifications in the comments.

Thanks for all the comments so far, I will continue to work on this.

 - Joel
