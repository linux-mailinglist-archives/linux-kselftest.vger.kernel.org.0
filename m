Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A7870A50A
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 May 2023 06:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbjETEBa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 20 May 2023 00:01:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjETEB3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 20 May 2023 00:01:29 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55D4101
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 21:01:26 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-96f818c48fbso159246666b.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 21:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684555285; x=1687147285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lN4GcKWsmyboezh08Qy1RSmzm/C0mfuVswPHh8pOik=;
        b=Kv53BeTFEZHZQ98XRbtqJGJY6VylYmltuMB3sLBIyvaCn5XmG9yIrcvo9EzzZduAz6
         vZQDXB1xtWsj244raYyXfV4uJ5Jaf1HcC/m3/aUrNVoUw2faRqJ2OfXiMw5CGIcLUycv
         4i8XpMSJXIaNnKRKqpgHcHprDvBWEk3NOv+Ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684555285; x=1687147285;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lN4GcKWsmyboezh08Qy1RSmzm/C0mfuVswPHh8pOik=;
        b=Q9KsV3ht8JtlmoEWTcP5ka0KTAx5WPGvQwxa75ARQOkpFukB3mS3es/PpEl9ENDZnQ
         I6J5RX3xbadyKIvgZTGen5M8DF2mbEWYI+gffAJD4jJF3SUc6dCc/pNGA/Nem1YMVXwP
         BknXyyymTHgQT+g0pEmDgTT3Jo07hw5NKpCNvbLeuKvEoMhx3cAu50IndtXtN9EkxI6E
         odqoXqJSOUo/MGMQidbiFirnENqfJ96sx+p8tdsIgdRf37bjoznZ6GGHxQXmRjZvCpih
         pHidcvZYbLd+vVVY903DXHB0DtDKbPURjWC7ZRap4ReAguvBZKw3T6t5AH4j+zdzBhTs
         YN9Q==
X-Gm-Message-State: AC+VfDyPYA1JFb1F4XAzOdpNJoNZ6kT1fmA2/lhkKADJ6HlgFyQwfBi2
        hOhWPM1pJax1bNh6yBblrMbzwLJOflx9k9fYG0ZmD82t
X-Google-Smtp-Source: ACHHUZ73YKNjG91IsIw/N83Mlft4dXkNnIxT6kFuIg9KhOBNQQvjakPn23VjNvuOBIaci7JRAdZFZQ==
X-Received: by 2002:a17:906:80cf:b0:965:6199:cf60 with SMTP id a15-20020a17090680cf00b009656199cf60mr3337929ejx.42.1684555285249;
        Fri, 19 May 2023 21:01:25 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id lt12-20020a170906fa8c00b0095fbb1b72c2sm356519ejb.63.2023.05.19.21.01.24
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 21:01:24 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-510dabb3989so6170281a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 21:01:24 -0700 (PDT)
X-Received: by 2002:a17:906:858d:b0:959:6fb2:1c3b with SMTP id
 v13-20020a170906858d00b009596fb21c3bmr3193781ejx.39.1684555284253; Fri, 19
 May 2023 21:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230519190934.339332-1-joel@joelfernandes.org>
 <20230519190934.339332-2-joel@joelfernandes.org> <CAHk-=whoajP4bZMbZC_VYmBhmhCpXsBesszwWUH0i6SpK_dAtw@mail.gmail.com>
 <CAEXW_YQ4wdGVa5M6jZfi5d-pdJOp1Nu7qTBvWYS=255AnYWZCw@mail.gmail.com>
 <CAHk-=wj9j+puqhe+E-AcG5j-5nP_tQ7DmAcb=Cb6v7n4mpxXjQ@mail.gmail.com>
 <CAEXW_YT1qr9F1QaABthUx6qxWPYYom-oW7XMVExzrHLWdhUGKg@mail.gmail.com> <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTqjGG4Y06brQthe4UMqprTJm=xk=P7i5gTpm2rZRZkXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 21:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
Message-ID: <CAHk-=wh3tjw+MNxe6zuixtD=D8bXYHWs9h3Y++r5ObTcSvz6+A@mail.gmail.com>
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

On Fri, May 19, 2023 at 8:57=E2=80=AFPM Joel Fernandes <joel@joelfernandes.=
org> wrote:
>
> I also realize that I don't really need to check whether the masked
> source address falls under a VMA neighboring to that of the source's.

I don't think that's true.

You can't start randomly moving other source vma's that may have other cont=
ents.

               Linus
