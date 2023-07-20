Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B8975AB8F
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 11:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbjGTJ7f (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 05:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjGTJ7e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 05:59:34 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89B6BB;
        Thu, 20 Jul 2023 02:59:33 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-cc7863e7b82so565549276.0;
        Thu, 20 Jul 2023 02:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689847173; x=1690451973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKuuwxkODmr9Zm8vKZysQKHD2KRDyuArZZruCry8jeM=;
        b=pznHFrr9YJM+RHqmlxyNJKXxI4h342lvODnvMjAwuIofkBABz6uKv0WMDFNup1Hdc5
         5jGNH94K9B+Rdq7apgK9JIPzNCMfE47B4efwzN1blJcyOvW5k+w7RNxm6GsYvCBiz6eE
         ru6042+DSrI4b2jXhoy+5yFR82uGwSOZQg3nZ7WW22sD0VRAT6YotZm0b3UrbqB56Lo5
         7Tl9NAu2AU2ZXHdBK8cc3AZn9EkoMqZBp07R2tX17t6r08TDzyqbPk/NYWnRyWZ2OZHf
         peAvgMcRRPDWHOXzDrVsjhQOT6RITDpkkWGFJ2yn7YiDlfV31DI5tSHrEQIezLGG95Qu
         C3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689847173; x=1690451973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKuuwxkODmr9Zm8vKZysQKHD2KRDyuArZZruCry8jeM=;
        b=FJJj1eZjfStGVzhG+avLcbKY1x9ji5+oFmK6O9bneBzOBEik+3cOKNlSI8Apnnspa4
         2wzi4YrXeABQWJhK9bpxc9x9gjNmEud30GsA3BwkgqcEEoGV79rdlrpedIWA21W4WCU+
         1tN8j+HJR21Om8i9ZQ3EVRic/myUOmQPoYeBqSlMSLGkUxbDQyez3rZYHCwKGpgMc20+
         i2Ai3W1I3K4knx4liOqnPX4AOKTDAR8X7FFj6gOTIWPAefYwWrNlpPR5BH8qb6fV+q+5
         6V3tShxlQFg4zkyCLOcmL8YiM+NitYBJ4ueIY4UeVO+vKAtglIXXdy6vli7S5IZABs1l
         Qf0w==
X-Gm-Message-State: ABy/qLbFRgh7TAz69fEOaoVzPkk59QemeuodlcYMBc+9tqIAns7VSDAv
        1fyFLPVo885Lrpz3ksWW/DoWW2NKw0v28TnAgG2Ha1ZR
X-Google-Smtp-Source: APBJJlFkbKzQpdC8KXGZW/X7uIsPXOLOYb3PRWFlS+ylspA7+yj85YcX50IxoR5pIDz0zccZqnOiHBLqWmdgKO1t4Ag=
X-Received: by 2002:a5b:3ce:0:b0:c60:1036:2082 with SMTP id
 t14-20020a5b03ce000000b00c6010362082mr4195170ybp.22.1689847172885; Thu, 20
 Jul 2023 02:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230718052752.1045248-1-ojeda@kernel.org> <20230718052752.1045248-7-ojeda@kernel.org>
 <CABVgOSnCY66C5wza-ZXb8c8UHg8ydbFv4U_7A14UU_gXeESKZg@mail.gmail.com>
 <CANiq72m08qGAa7k37A0rQNf7vvBc1o8JjSY8jNd+m2XzVOT9rw@mail.gmail.com> <CABVgOSnL0Kiv1Mo6feCLYVq6bGUjxN3gUVrW4ZKD4Fh1wUhWrQ@mail.gmail.com>
In-Reply-To: <CABVgOSnL0Kiv1Mo6feCLYVq6bGUjxN3gUVrW4ZKD4Fh1wUhWrQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jul 2023 11:59:21 +0200
Message-ID: <CANiq72nSy2r-sv_4EFJUsFB67WOiMTeaMoER0wKQBRtVx7jzNA@mail.gmail.com>
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

On Thu, Jul 20, 2023 at 8:37=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> We merged this as-is, and I've sent out a fixup patch here:
> https://lore.kernel.org/linux-kselftest/20230720062939.2411889-1-davidgow=
@google.com/T/#u

Thanks!

> I wasn't able to find any issues with changing the indentation, but
> let me know if there's some tool which complains about seeing tabs in
> .rs files we need to worry about.

Given it is inside a literal, I would expect it to work (I replied in
the thread).

Cheers,
Miguel
