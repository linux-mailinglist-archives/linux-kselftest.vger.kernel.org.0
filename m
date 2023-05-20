Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE8270A4A5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 04:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjETCei (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 22:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjETCeh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 22:34:37 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE63DB4
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 19:34:35 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-965b5f3b9ffso306196266b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 19:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684550074; x=1687142074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh6ejcxyOpbBR//bKhui3rhhiC+Sm3sNdu/qK016ndc=;
        b=OQcKi5k5k9XXumfuSZD9JCNyPj5HBzWl3UfJjcJuClfHqKpP+G1rT6ZRN1ecmI3Sfd
         3m6aWD1GKngDr7LJ7oqhRdVD6wem5B4GEAScIexykGLVZGIvvyo1AnnWJD1vfru0XHq+
         nDIDC+61tqhMHE02wGw2CseqYoe2EObBVNvA8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684550074; x=1687142074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh6ejcxyOpbBR//bKhui3rhhiC+Sm3sNdu/qK016ndc=;
        b=AUOIQbPyA2S+Jk8DhiGa69bGC2W9joKhnVy5PF5SqhdxiE7wZTkq1Rq8VA/nUn2dzk
         Pxo7nJJThzptCmq014rsvehf7E3N9u5WdBvmj9QZKPYowzvwdbuvyShWUfoO/7M+y425
         Jt5jJNCR8FoFLFvPsFWzJBOoYtWnxBV+U7zu+9v7hjL7TEjtRD6TP5aqpiBZEIkfMgXR
         3r4Jn2R4QMVfz4VdFeHT1DhEpqN3yvyvfkeRlaffdiGngnnMKeL4146RwBRx/Elx31TY
         rGRKtc9iC28QIUlNkzaFg68ZMFJQcOG7LefInyKGDIxLT60suQPKFytRyTo7OGQZgypS
         yJtw==
X-Gm-Message-State: AC+VfDwzdDIr/zt0LNKO9fo47uoNQZStif9Rg+AGw4FeUfJI49/eTTJP
        biesxQAHEa26MVm3Cx3jbVQ9lTv/t0n47cZUysm6YYJw
X-Google-Smtp-Source: ACHHUZ5UFjcfqwx4ttGBgGdLk3uKAEDPA3EyxnrZMlVvxBrf+3rQA5kVbMM0fe2KRuexDxiimRCl3Q==
X-Received: by 2002:a17:907:6d26:b0:966:5fac:2e52 with SMTP id sa38-20020a1709076d2600b009665fac2e52mr3808508ejc.9.1684550074264;
        Fri, 19 May 2023 19:34:34 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id e18-20020a1709062c1200b0096b524b160asm282384ejh.82.2023.05.19.19.34.32
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 19:34:32 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-95fde138693so304417366b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 19:34:32 -0700 (PDT)
X-Received: by 2002:a17:907:6e25:b0:96a:a76c:41d5 with SMTP id
 sd37-20020a1709076e2500b0096aa76c41d5mr3159482ejc.12.1684550072290; Fri, 19
 May 2023 19:34:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
In-Reply-To: <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 19:34:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
Message-ID: <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     Joel Fernandes <joel@joelfernandes.org>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, May 19, 2023 at 3:52=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
> >
> > I *suspect* that the test is literally just for the stack movement
> > case by execve, where it catches the case where we're doing the
> > movement entirely within the one vma we set up.
>
> Yes that's right, the test is only for the stack movement case. For
> the regular mremap case, I don't think there is a way for it to
> trigger.

So I feel the test is simply redundant.

For the regular mremap case, it never triggers.

And for the stack movement case by execve, I don't think it matters if
you just were to change the logic of the subsequent checks a bit.

In particular, you do this:

        /* If the masked address is within vma, there is no prev
mapping of concern. */
        if (vma->vm_start <=3D addr_masked)
                return false;

        /*
         * Attempt to find vma before prev that contains the address.
         * On any issue, assume the address is within a previous mapping.
         * @mmap write lock is held here, so the lookup is safe.
         */
        cur =3D find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
        if (!cur || cur !=3D vma || !prev)
                return true;

        /* The masked address fell within a previous mapping. */
        if (prev->vm_end > addr_masked)
                return true;

        return false;

And I think that

        if (!cur || cur !=3D vma || !prev)
                return true;

is actively wrong, because if there is no 'prev', then you should return fa=
lse.

So I *think* all of the above could just be replaced with this instead:

        find_vma_prev(vma->vm_mm, vma->vm_start, &prev);
        return prev && prev->vm_end  > addr_masked;

because only if we have a 'prev', and the prev is into that masked
address, do we need to avoid doing the masking.

With that simplified test, do you even care about that whole "the
masked address was already in the vma"? Not that I can see.

And we don't even care about the return value of 'find_vma_prev()',
because it had better be 'vma'. We're giving it 'vma->vm_start' as an
address, for chrissake!

So if you *really* wanted to, you could do something like

        cur =3D find_vma_prev(..);
        if (WARN_ON_ONCE(cut !=3D vma))
                return true;

but even that WARN_ON_ONCE() seems pretty bogus. If it triggers, we
have some serious corruption going on.

So I stil find that whole "vma->vm_start <=3D addr_masked" test a bit
confusing, since it seems entirely redundant.

Is it just because you wanted to avoid calling "find_vma_prev()" at
all? Maybe just say that in the comment.

                  Linus
