Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C7675798E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjGRKul (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjGRKuk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 06:50:40 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B36294;
        Tue, 18 Jul 2023 03:50:39 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bff89873d34so4219213276.2;
        Tue, 18 Jul 2023 03:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689677438; x=1692269438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sTu0pAKim/A7bk9vOOQJzSwY4RU25mujed63Z040/Wc=;
        b=M5N/eMDG1/kcW3eSG03fAOT6edP/BE9g4cI4JE49bCv1y57yRaoC68wX4AyPNN7x5h
         Ys1FUc72GHCNLVGQgsM0T75veXDpw8SFoi2C9z+BhOLD0+whFqCWE7/D/IN446FyuNRf
         sV6+rhj+XJ+cf8bkYuSqvTC8o09vR/llHnqUTGCJE+JMYxmkVwBYTGBcli9aL6pZukzk
         wt1VnsRfDzBXVvIgccrUNLasqjlOjwknb3C+3UzBRm43Z5LGnrWY2l/LUSEYVUDn/iBx
         NbXNZimTB7Ng71gyXAzE8SVGSAjraxBtDkKhTlxhk6frz5QHC+kRPnt3l8XOUa8xMm6t
         5GhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689677438; x=1692269438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sTu0pAKim/A7bk9vOOQJzSwY4RU25mujed63Z040/Wc=;
        b=YNuB49feZqXfdBdVVhVbGSm+H1toyP/IbG7XoD1M95MVpRaT4LRMQUJG0zX0BojuLr
         uhve7MhA2n+OHtYQvCBDdAt7OOO1gFohrpdE8G8eNLuNLkm1r8fKd24+YqAd1R+/wLsc
         DJ1ODZv2x5Vks1dzPfMKduHvb+vmhuwFeiJCLudC5kTUy3ad4R4ta0ZlXe+bxfDbmcjt
         4tznaBqPiB2wgy3o3ZEmE/4t+9/chWrChcEdrzzDg2h83vjQXlpngyIAm//AJi9vn15P
         UJduiSws/FbNAGa6VwuVD1D39bHbNSi2R1nxExiYRw1F64L49mrZ2WEVpL+XnTQg+yQk
         rBDQ==
X-Gm-Message-State: ABy/qLbLuGpiii1mGGsIifyt2IFplIqHxMdQrwobZB6iu8icybURFDM1
        UQSM1HfjYqpVJJeBCjABRWa8fBmbD1WPXR3mNdg=
X-Google-Smtp-Source: APBJJlGNcgDopzSyU763xeq2Rqhv/iipQR9HeEhrKycYfBFUkhb9gOIE0XtXjI2boC04P9ttrOhZdAw7klVYgvj9JGY=
X-Received: by 2002:a25:a4c4:0:b0:ce4:5f48:a24d with SMTP id
 g62-20020a25a4c4000000b00ce45f48a24dmr2543364ybi.5.1689677438709; Tue, 18 Jul
 2023 03:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230718052752.1045248-1-ojeda@kernel.org> <20230718052752.1045248-7-ojeda@kernel.org>
 <CABVgOSnCY66C5wza-ZXb8c8UHg8ydbFv4U_7A14UU_gXeESKZg@mail.gmail.com>
In-Reply-To: <CABVgOSnCY66C5wza-ZXb8c8UHg8ydbFv4U_7A14UU_gXeESKZg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 18 Jul 2023 12:50:27 +0200
Message-ID: <CANiq72m08qGAa7k37A0rQNf7vvBc1o8JjSY8jNd+m2XzVOT9rw@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] rust: support running Rust documentation tests as
 KUnit ones
To:     David Gow <davidgow@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 18, 2023 at 10:17=E2=80=AFAM David Gow <davidgow@google.com> wr=
ote:
>
> This is looking good and working well here.
>
> One super-minor thought below (the generated C file seems to be using
> 4-space indentation, not tabs), but it's not something that worries me
> enough to hold the patch up if there are no other issues.

Good eye! Of course, please feel free to change it when applying
(though from a quick grep I don't see "[ ... ]" comments in commits in
the KUnit tree). I am also happy to send a v3.

Cheers,
Miguel
