Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB0D75B7F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 21:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjGTT2e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 15:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjGTT2d (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 15:28:33 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C89171D;
        Thu, 20 Jul 2023 12:28:31 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ccc462deca6so1088066276.0;
        Thu, 20 Jul 2023 12:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689881311; x=1690486111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdN8o7AJTx4ZATKNIUy6cq4O3obHD+O4FpBvaPeeNBs=;
        b=Gw9eQqRzINgLnQlR1OAcLm0s4xv3PRM9IQQTuTOs3vfoDQti8YZaQybqCpUz9PZyLJ
         YKzaf6cxIPayhBM9MYu5OL2eNNzIVOIfkDY76CwVV7G6sOgH37XBvSbKs+cEcQIvm1Jb
         UvF+52jNxhfdkAyfwFGGlDm0N2laruZFfOeBFXJUXgbRq9nVPshzAPCTXAoOtA9CZkwy
         vyJH+bpbtVblvu43x3YNXH8CCGF9iGwkBV9jSKi72nacUOz4cPzAm6vBDeIo0lfI/L7l
         1suntjO3PBXS+bPoa5gYCjW+w5osQt8tcuDtme++Ujb5t5oSaLkLpyeBDoFalts8pR1D
         cx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881311; x=1690486111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdN8o7AJTx4ZATKNIUy6cq4O3obHD+O4FpBvaPeeNBs=;
        b=YWtuTfeS4hx/wzJYU/HTYt6M1aS34RzrqeeKFyMcxxMgDhHtJQ182I+pFIaCe6ms7R
         m7QMcGyeFN0eUmXE/UXrM7y/KWhs8rqHeDbwJOfXGNSINRm7HlCAde4aXPvN07TyTFXa
         bLJb99Ukht5PVBf1xgOp+WcwMwlyqlK/yINt+ctaPsjUe5+glHK1EL+qiu8O9LQpAyX8
         E+gLEwZgAVb/4uNfjMUJeKR2SsRahx3g3UydMVqPwfQW0wDh4USFso5Sr01ayZmnbgil
         8Cer7cNO1xI3NmFc7E6z7lINJJohB8iukQ9A6HAFRdNIZ7BjcBIfjuJJXOr2ftENVLXV
         ruyQ==
X-Gm-Message-State: ABy/qLaj3KZNfotwEha58oaqXp+jLlz0Kl8KFdFwppcUq+5b/Bgc9Kab
        x5WDLK2ZUo0w9Ynyq32cpe/TVZ+JQ3dWSv+BgmE=
X-Google-Smtp-Source: APBJJlHGQI9NwyazTFrofqytPGXoMkCuinDMKCYH6DzuorpDpZgCO6qQGnkNna3kmYEdn+EHW9YFBkfnAyUjoTpPxkM=
X-Received: by 2002:a25:4052:0:b0:cfd:58aa:b36e with SMTP id
 n79-20020a254052000000b00cfd58aab36emr2782026yba.9.1689881311057; Thu, 20 Jul
 2023 12:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230718052752.1045248-1-ojeda@kernel.org> <ZLbTRZMjcFNAamit@boqun-archlinux>
In-Reply-To: <ZLbTRZMjcFNAamit@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Jul 2023 21:28:20 +0200
Message-ID: <CANiq72n5NOVxP37QFXDkOBZTzhGt6EREBruqUyhiqxGUrrC_CQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] KUnit integration for Rust doctests
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
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

On Tue, Jul 18, 2023 at 8:00=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> I've applied the series and run the following command:
>
>         ./tools/testing/kunit/kunit.py run --make_options LLVM=3D1 --arch=
 x86_64 --kconfig_add CONFIG_RUST=3Dy
>
> everything works as expected, and I also tried modifying one of the
> `assert!` to trigger it, all looks good to me. Feel free to add:
>
> Tested-by: Boqun Feng <boqun.feng@gmail.com>

Thanks a lot for trying it, Boqun!

David/Shuah: I noticed this "Tested-by" tag is not in the applied
commits. If you happen to rebase, it would be nice to pick it up.
Thanks!

Cheers,
Miguel
