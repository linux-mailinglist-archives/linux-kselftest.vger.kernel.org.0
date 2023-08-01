Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239776B7E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjHAOoq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 10:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjHAOoq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 10:44:46 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B08B1BC3;
        Tue,  1 Aug 2023 07:44:45 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c5f98fc4237so4687844276.2;
        Tue, 01 Aug 2023 07:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690901084; x=1691505884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXgNoIC2PvO/RdQx7w9iCucEs/VxyEwm+OaXP/sJCPQ=;
        b=VFMh5LS5z3t+hG68vt3INAW1bmqD8uEWGh7LMqvkYjF7v6fZ/vZkLNxUe9mYT6pjMm
         65JazsVmxiH3X6IUyXQFHXLVz1mH5F9dIW1GbdgUBwb00JFth2efdOU1NR0w5eWdYAbk
         8ObzV3Kxly5ZAa4OdMnlE63neLzSJNFjgC2BEhwZ+VvaplEEoAq9BndXYlcuCt02GY2O
         dIA1d7QrDoL+fMV2YirfEhivh/yO2ytwgD9bMR+qpktysNaz9wuFliMgI2WtaFFTvffP
         so94wlh17sCKXLmDLTg085cPWzJwdjluHA9d4clhAb0ERK26knfENhZXdyArYbUvkQoT
         2dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690901084; x=1691505884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dXgNoIC2PvO/RdQx7w9iCucEs/VxyEwm+OaXP/sJCPQ=;
        b=EswM2fgvEh/JA3eAaUC1r/Etp1zki3Q0/MiUV5FiWBRerFch+oG/Ma8v8P9Y4Q2G7S
         kkvW2pvYpym8ZFMUVlWz1QLjLhW2zo+GAOXuv6CTYrQNTZnk3OgqmUQFS1XImJ3zcGty
         +HBLdToCZjw8ttRLuSjigTo4Y1fQ4c7rcAU2wCDfVqEXoWFOtdWprFgx7T8zD1VK8mEt
         rF7tGLjKas8wpKXryrJnwTvYiqOpXtJ8Zf1tJE+s462r9YPyszZZrzsnLHQuelCFnaja
         VZoNLpAZJY2AvG7Mvbl5jUVQ9ecTbCu7G8ddh3gYDEKqdtGm8vJB9o/m+BCp8kZXtldp
         L8rg==
X-Gm-Message-State: ABy/qLa47cDlQiEqL1OKN2KvlzQFXqM30Pt93RwMeTVwoxBkjqrIRUyW
        cJH6UZDcXcTa9XOSI3G039AmHVGwT6lVVOqlqqA=
X-Google-Smtp-Source: APBJJlExxDX5gr6eVov8kBtquPdrHK2sGfm+MVVQv8plpRunt/LlfvnCesz2qwdIPlnPHM7oEiSeFP7KKO48sgLUTNE=
X-Received: by 2002:a25:ac9b:0:b0:d15:bd9f:cac0 with SMTP id
 x27-20020a25ac9b000000b00d15bd9fcac0mr9856536ybi.39.1690901084347; Tue, 01
 Aug 2023 07:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230720-rustbind-v1-0-c80db349e3b5@google.com> <20230720-rustbind-v1-2-c80db349e3b5@google.com>
In-Reply-To: <20230720-rustbind-v1-2-c80db349e3b5@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 1 Aug 2023 16:44:32 +0200
Message-ID: <CANiq72mJjB_ubHx-y316o7b0KNjdHOrA9Wz0ievRvoTi1jVR5A@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: macros: add macro to easily run KUnit tests
To:     David Gow <davidgow@google.com>,
        =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 20, 2023 at 8:40=E2=80=AFAM David Gow <davidgow@google.com> wro=
te:
>
> The only difference with user-space tests is that instead of using
> `#[cfg(test)]`, `#[kunit_tests(kunit_test_suit_name)]` is used.

I may be missing something, but this does not appear to map the
`assert*!`s to the KUnit APIs, is that correct? (i.e. like we do for
`rustdoc`-tests).

I made an assertion fail, and it seems to use the standard library
macros, thus panicking and ending up in `BUG()` (rather than a failed
test):

    rust_kernel: panicked at 'assertion failed: `(left =3D=3D right)`
      left: `true`,
     right: `false`', rust/kernel/kunit.rs:329:1
    ------------[ cut here ]------------
    kernel BUG at rust/helpers.c:34!

Then the test times out eventually and things break:

        # rust_test_kunit_kunit_tests: try timed out
    ------------[ cut here ]------------
    refcount_t: addition on 0; use-after-free.

> +    // Add `#[cfg(CONFIG_KUNIT)]` before the module declaration.
> +    let config_kunit =3D "#[cfg(CONFIG_KUNIT)]".to_owned().parse().unwra=
p();
> +    tokens.insert(
> +        0,
> +        TokenTree::Group(Group::new(Delimiter::None, config_kunit)),
> +    );

I wonder about compile-time here with this approach. As far as I
understand, having the `cfg` explicitly outside the proc macro would
avoid invoking it.

Do we know the potential compile-time impact, especially when we will
have many tests?
ventually it would be ideal to have an approach closer to the
`rustdoc` one, where the compiler finds the tests for us and we
generate the needed code in the build system, i.e. outside a proc
macro.

Cheers,
Miguel
