Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D617117AB
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 May 2023 21:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjEYTv4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 May 2023 15:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241954AbjEYTvz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 May 2023 15:51:55 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2F0D8
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 12:51:35 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-56187339d6eso1769717b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 25 May 2023 12:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1685044295; x=1687636295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQtVi/2EvKDxLlI3bV7/HKRrNErdeyi9JL2Y1lgW7U0=;
        b=Swg9j2dX6OFqvp/TbbvMAvLSnvq4lrSFepdc7WisPr485X0zxndyAOTcnYAWuQlJnD
         PWBVlHe9ycm6hZ1quoMvEnRLVj6JFbsPmhJaylAoUIIUCaxFkkFWYjRngOn75C4lG5dq
         0rT6q9ds9flykVL2GXwJMgoWlC05gr+EpUapg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685044295; x=1687636295;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQtVi/2EvKDxLlI3bV7/HKRrNErdeyi9JL2Y1lgW7U0=;
        b=YJgfQuChKv4Oeh5gAeYP2wq1xXWO/HnMUzXZTAKy+53pbL/Xmsy5+9vqXK6/6vFKEN
         zf37G84hZbsPB2f6fP0KBCTdhNw+9z73nxQhg2DGDlqRaMKLsoZiimV5LbNjnOInGui1
         Ld/uEO7RXUcropmTED0glQBW5qN30owEIecDLnyXxfzSY//DmASjtwOYKUiayyUziiZo
         PgwIvCsWc2E+7tx/Crq/Gw3T9D3Jz7acUn8+6Y1RCeP/dSQxT9nbPBDtVKkNmgY+W04P
         rbdLc5w3FrCB/AXf8lkc9RWkqpgFyHCfRqwUYhNs2dLYC1rMDhttTlYfJRdsgDDsK0c/
         ujFQ==
X-Gm-Message-State: AC+VfDwbpEbkFNp8ASv7aryr9am4sYGgA9EoNqt0UfPMFTFy11d7kmud
        uAzqY7DfET3Ka8Hkohiq93/uoIL2pDzeNg/Sc6auFw==
X-Google-Smtp-Source: ACHHUZ48YLnlxKAvKA5r3j7SV3FxQvvF2F8Z3cb2tPTI6RLteNgzhMgofaL8DiLyWzreAJOpz+qbXIlc7eGttaRZhwI=
X-Received: by 2002:a81:6bd6:0:b0:564:dd8d:b0d0 with SMTP id
 g205-20020a816bd6000000b00564dd8db0d0mr774098ywc.22.1685044294749; Thu, 25
 May 2023 12:51:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230524153239.3036507-1-joel@joelfernandes.org>
 <20230524153239.3036507-2-joel@joelfernandes.org> <CAHk-=wiNUe7YjK9fmZk+2ZQhjLH-64WrkwnXO9813_iLuaFXuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiNUe7YjK9fmZk+2ZQhjLH-64WrkwnXO9813_iLuaFXuQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 25 May 2023 15:51:23 -0400
Message-ID: <CAEXW_YQO5-=4HRiZFiJ7ZsAHSLFEhHP29czqODFkH5mmVeqjZQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Shuah Khan <shuah@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Kirill A Shutemov <kirill@shutemov.name>,
        "Liam R. Howlett" <liam.howlett@oracle.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>
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

Hi Linus,

On Wed, May 24, 2023 at 7:23=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. I'm still quite unhappy about your can_align_down().
>
> On Wed, May 24, 2023 at 8:32=E2=80=AFAM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > +       /* If the masked address is within vma, we cannot align the add=
ress down. */
> > +       if (vma->vm_start <=3D addr_masked)
> > +               return false;
>
> I don't think this test is right.
>
> The test should not be "is the mapping still there at the point we
> aligned down to".
>
> No, the test should be whether there is any part of the mapping below
> the point we're starting with:
>
>         if (vma->vm_start < addr_to_align)
>                 return false;
>
> because we can do the "expand the move down" *only* if it's the
> beginning of the vma (because otherwise we'd be moving part of the vma
> that precedes the address!)

You are right, I missed that. Funny I did think about this case you
mentioned. I will fix it in the next revision, thanks.

> (Alternatively, just make that "<" be "!=3D" - we're basically saying
> that we can expand moving ptes to a pmd boundary *only* if this vma
> starts at that point. No?).

Yes, I prefer the "!=3D" check. I will use that.

>
> > +       cur =3D find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
> > +       if (!cur || cur !=3D vma || !prev)
> > +               return false;
>
> I've mentioned this test before, and I still find it actively misleading.
>
> First off, the "!cur || cur !=3D vma" test is clearly redundant. We know
> 'vma' isn't NULL (we just dereferenced it!). So "cur !=3D vma" already
> includes the "!cur" test.
>
> So that "!cur" part of the test simply *cannot* be sensible.

Ok, I agree with you now.

> And the "!prev" test still makes no sense to me. You tried to explain
> it to me earlier, and I clearly didn't get it. It seems actively
> wrong. I still think "!prev" should return true.

Yes, ok. Sounds good.

> You seemed to think that "!prev" couldn';t actually happen and would
> be a sign of some VM problem, but that doesn't make any sense to me.
> Of course !prev can happen - if "vma" is the first vma in the VM and
> there is no previous.
>
> It may be *rare*, but I still don't understand why you'd make that
> "there is no vma below us" mean "we cannot expand the move below us
> because there's something there".
>
> So I continue to think that this test should just be
>
>         if (WARN_ON_ONCE(cur !=3D vma))
>                 return false;

I agree with this now.

>
> because if it ever returns something that *isn't* the same as vma,
> then we do indeed have serious problems. But that WARN_ON_ONCE() shows
> that that's a "cannot happen" thing, not some kind of "if this happens
> than don't do it" test.
>
> and then the *real* test  for "can we align down" should just be
>
>         return !prev || prev->vm_end <=3D addr_masked;

Agreed, that's cleaner.

> Because while I think your code _works_, it really doesn't seem to
> make much sense as it stands in your patch. The tests are actively
> misleading. No?

True, your approach makes me want to improve on writing cleaner code
than being excessively paranoid. So thank you for that.

These patches have been tricky to get right so thank you for your
continued input and quick feedback.

I will add a test for the case you mentioned above where the address
to realign wasn't in the VMA's beginning.

thanks,

- Joel
