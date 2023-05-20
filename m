Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A369770A503
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 05:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjETD5E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 23:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjETD5D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 23:57:03 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785941B0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 20:57:02 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba1815e12efso3546741276.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 20:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1684555021; x=1687147021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k48QyU7lF8u1l7ywe+luULWJLH7q4GBm+Nfjv/qBk0s=;
        b=Uvv7TmePr330Eu7MGfoPqtTuWruLmLIq1IBdIV4uYhFpKrim+1cUl2g4w+n8Ma6NxX
         YpIBLKAMud1MQuhqfUg2cwekk4NdPJkpuTqDOD9IENpHtR1JK2kZ6Y5s5Wu/OiFKM/ps
         4cfPf4dwFrs5IvWVznM8yRp5EdKHjiHXYN1D8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684555021; x=1687147021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k48QyU7lF8u1l7ywe+luULWJLH7q4GBm+Nfjv/qBk0s=;
        b=Sa9oCmzXwYiNEYpz2nn5510aD+RfLA/vvHmuKbK4+uQo0Ao766VyWIB5Y17INIGEeB
         0RII+F3fkopwVjP92plDDuewYJokGcgXIGf2gXBBsLvgcBTQZoMBZs8AEmYyy0aZoZlc
         f+rmbpoZENOihmsAeiwPFP25tirYeOMLNtk54bmnDGlJnTxZtUX3WVffWOImfBoJIMzh
         2PzkFZLrxjGTcBAtZsmBFaEG2SgwL+/DdyaKUB1zX/9jbVhgFF9o2NxasgYB3s0z/aZu
         dawSG2OH5vqYYIT5XaKfYxKUvcBCP8xmErwaw+mziXTaRXZiIZuolk37zz2syVADZ+FY
         BTdw==
X-Gm-Message-State: AC+VfDywhqJ7xzFy+NtqmfTGI/zlvqn1FMYjrviwE851wGYDmCYy2iP2
        xANu0hHCqxlCMhgdPGrEcxhqyaRgUbCd7jZ8al1PeA==
X-Google-Smtp-Source: ACHHUZ5TESjAYLMyKkTXEwDGBwMPceDrtDjcUJRXQ3cm+D8ZoLt30E5SfCHCAJ5Qm2cec08U4VoOZF0NGTmZ61Dt6Cc=
X-Received: by 2002:a25:b088:0:b0:ba6:dd3a:1c4b with SMTP id
 f8-20020a25b088000000b00ba6dd3a1c4bmr3610614ybj.65.1684555021630; Fri, 19 May
 2023 20:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com> <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
In-Reply-To: <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 19 May 2023 23:56:50 -0400
Message-ID: <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 11:17=E2=80=AFPM Joel Fernandes <joel@joelfernandes=
.org> wrote:
>
> Hi Linus,
>
> On Fri, May 19, 2023 at 10:34=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Fri, May 19, 2023 at 3:52=E2=80=AFPM Joel Fernandes <joel@joelfernan=
des.org> wrote:
> > > >
> > > > I *suspect* that the test is literally just for the stack movement
> > > > case by execve, where it catches the case where we're doing the
> > > > movement entirely within the one vma we set up.
> > >
> > > Yes that's right, the test is only for the stack movement case. For
> > > the regular mremap case, I don't think there is a way for it to
> > > trigger.
> >
> > So I feel the test is simply redundant.
> >
> > For the regular mremap case, it never triggers.
>
> Unfortunately, I just found that mremap-ing a range purely within a
> VMA can actually cause the old and new VMA passed to
> move_page_tables() to be the same.
>
> I added a printk to the beginning of move_page_tables that prints all the=
 args:
> printk("move_page_tables(vma=3D(%lx,%lx), old_addr=3D%lx,
> new_vma=3D(%lx,%lx), new_addr=3D%lx, len=3D%lx)\n", vma->vm_start,
> vma->vm_end, old_addr, new_vma->vm_start, new_vma->vm_end, new_addr,
> len);
>
> Then I wrote a simple test to move 1MB purely within a 10MB range and
> I found on running the test that the old and new vma passed to
> move_page_tables() are exactly the same.
>
> [   19.697596] move_page_tables(vma=3D(7f1f985f7000,7f1f98ff7000),
> old_addr=3D7f1f987f7000, new_vma=3D(7f1f985f7000,7f1f98ff7000),
> new_addr=3D7f1f98af7000, len=3D100000)
>
> That is a bit counter intuitive as I really thought we'd be splitting
> the VMAs with such a move. Any idea what am I missing?
>
> Also, such a usecase will break with my patch as we may accidentally
> overwrite parts of a range that were not part of the mremap request.
> Maybe I should just turn off the optimization if vma =3D=3D new_vma,
> however that will also turn it off for the stack move so then maybe
> another way is to special case stack moves in move_page_tables().
>
> So this means I have to go back to the drawing board a bit on this
> patch, and also add more tests in mremap_test.c to test such
> within-VMA moving. I believe there are no such existing tests... More
> work to do for me. :-)

I also realize that I don't really need to check whether the masked
source address falls under a VMA neighboring to that of the source's.
I only need to do so for the destination. And for the destination
masked address, I need to forbid the optimization if after masking,
the destination addr will fall within *any* mapping whether it is its
own or a neighbor one. Since we cannot afford to corrupt those. I
believe that will also take care of both the intra-VMA moves as well
as the stack usecase. And also cut down one of the two find_vma_prev()
calls.

I will rewrite the patch to address these soon. Thanks for patience
and all the comments,

Thanks!

 - Joel
