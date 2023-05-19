Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8E709FD0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 21:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjESTVz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 15:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjESTVy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 15:21:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3FF114
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:21:52 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50c8d87c775so5329588a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684524110; x=1687116110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3UOfbb4Sozljqzvq4nyP3R59tkdsUwJloQlEWrn99E=;
        b=TufFSf/w57t3rdGZZ9k6NrvIRRg0IOJU214TyZ65AkRlDZn5JY0ZSEgAy6ko17UGvN
         hORZlxyJMmAIdywEHHMZYr/bOWwvfL83yYW425at2d5hb1512YCLonwpz23h4NT6OyPZ
         qloGnG+htrWYlevBiv+vP5NSrMJ5r7DnNDAk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684524110; x=1687116110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3UOfbb4Sozljqzvq4nyP3R59tkdsUwJloQlEWrn99E=;
        b=KA55h5nUPSBzLYiwqUfGj//kFwGbS6CSu6/2oKltb9HOHUPrHEcLpxN8/Lhf5yDBd5
         8AtObddh92dH8Bpkm8LpELF+68BoYsKRekZs0bAO/mI+ubTIs1FV34RMRHILMehsPwRB
         tOpcJ+V8cpAgAsb8KvPCRcmQZH4EAx/ucg3gAPunR5LJpV6tT4p42iU9xNj2PVInbGhG
         AUUMCOg1iHba86c+BSwzNV4/DtR1G98EdN93kcI39MVQ5HC68s/vT1LTEo4yXPttU4Er
         w9BCtVu92XaRRiJ99m/4oASsGBx1vNma8PcckWRIRfSqqn+uBXw1dwoeqkmhX3B8FbUk
         2gjA==
X-Gm-Message-State: AC+VfDySXDEnWL8Dof/1TD4L59/zysdpBPWr+6q/Dp2bHVOK5Fv2N90h
        deWA9CoWnYYqbnIp2lWh7j76FFctBCd06xppUUqlkLl6
X-Google-Smtp-Source: ACHHUZ7CONg4YrXYMedITy+zLePv5NfiqFezuVGc5orSyiwpk3ToMalq5Q1iTIIsVVHa9ni21ia3fQ==
X-Received: by 2002:a17:907:7246:b0:96a:ee54:9f20 with SMTP id ds6-20020a170907724600b0096aee549f20mr3060327ejc.37.1684524110154;
        Fri, 19 May 2023 12:21:50 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906845400b0096f7b7b6f11sm680519ejy.106.2023.05.19.12.21.49
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 12:21:49 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-510ea8d0bb5so3123982a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 12:21:49 -0700 (PDT)
X-Received: by 2002:a17:907:26ca:b0:962:46d7:c8fc with SMTP id
 bp10-20020a17090726ca00b0096246d7c8fcmr2445592ejc.21.1684524109262; Fri, 19
 May 2023 12:21:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org> <20230519190934.339332-2-joel@joelfernandes.org>
In-Reply-To: <20230519190934.339332-2-joel@joelfernandes.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 12:21:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
Message-ID: <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm/mremap: Optimize the start addresses in move_page_tables()
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
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

On Fri, May 19, 2023 at 12:09=E2=80=AFPM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> +static bool check_addr_in_prev(struct vm_area_struct *vma, unsigned long=
 addr,
> +                              unsigned long mask)
> +{
> +       int addr_masked =3D addr & mask;
> +       struct vm_area_struct *prev =3D NULL, *cur =3D NULL;
> +
> +       /* If the masked address is within vma, there is no prev mapping =
of concern. */
> +       if (vma->vm_start <=3D addr_masked)
> +               return false;

Hmm.

I should have caught this last time, but I didn't.

That test smells bad to me. Or maybe it's just the comment.

I *suspect* that the test is literally just for the stack movement
case by execve, where it catches the case where we're doing the
movement entirely within the one vma we set up.

But in the *general* case I think the above is horribly wrong: if you
want to move pages within an existing mapping, the page moving code
can't just randomly say "I'll expand the area you wanted to move".

Again, in that general mremap() case (as opposed to the special stack
moving case for execve), I *think* that the caller has already split
the vma's at the point of the move, and this test simply cannot ever
trigger.

So I think the _code_ works, but I think the comment in particular is
questionable, and I'm a bit surprised about the code too,. because I
thought execve() only expanded to exactly the moving area.

End result: I think the patch on the whole looks nice, and smaller
than I expected. I also suspect it works in practice, but I'd like
that test clarified. Does it *actually* trigger for the stack moving
case? Because I think it must (never* trigger for the mremap case?

And maybe I'm the one confused here, and all I really need is an
explanation with small words and simple grammar starting with "No,
Linus, this is for case xyz"

                  Linus
