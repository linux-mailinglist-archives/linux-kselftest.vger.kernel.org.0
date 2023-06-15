Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53117313AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 11:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbjFOJXk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 05:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjFOJXi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 05:23:38 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ED42130;
        Thu, 15 Jun 2023 02:23:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75d46c7cd6cso268304885a.3;
        Thu, 15 Jun 2023 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686821016; x=1689413016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGOHFXjoBS2ub7744MFzAfGB3y1RlKfr94cgOk8utvg=;
        b=bQPiUW2V/29fzHAWymvAuQKmj6vXfz5zArXjocuKNgdfoFxWwTMHtWWS1g/dPGmOk9
         gdnCT1uCVb+1TPiOdR0qq9Xp55gm3Kw4HgkiENLdyJ7Em6K1KJ56gxXpvgsUQyLNq9hH
         iRHuY2mIidQd/qDJsBLM0FfcS3GxlHfjBgvZa/zwYlokG3p8IZ9nGTQi/FWiMwiarjy3
         rjXZVu71fjJjFrKCb9n7BsQc+43Pj4ZMEH0O1Kb23mLVDUQz36LbEcCldXeIWmrYPNp4
         rNR5x2LPD5WKSr8vCsvMUGSl3NUds51A18JWFiHz6B0U1hBuYdtMcdL11Jg3SHP+d5SN
         hUCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686821016; x=1689413016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGOHFXjoBS2ub7744MFzAfGB3y1RlKfr94cgOk8utvg=;
        b=DfiI4ibTkC5j4MBf2+6Okb1E26d4j+sQcxQ16PZgg4i+9ZjDiRXu2gARnqpWl7gf7R
         yl8rzMBcmoO9ZdoSgmGSCpM7EOSAY6ByAJ9ZukZQ+oV4NoyyPICynTsNWJLzMhLbrO3Z
         FkRZgMVkU883nwe6LEoJAQFkBKOmV4jmV1n5GySs1YeTGF542euLkioNrmja6pYDy2ZD
         YkxSJEdsW9MIxe8c6aob1+gigew9PVPiiVswg7uxj+0sDC7Y2xCCaGn4oZMHfuuM9X0n
         SAtuqLcXfnKFKtb3xPNZsILyFjC8P3x4L+RIin4hClOSUvgFAjOPbbZjdBXQeXuBXfdv
         0scQ==
X-Gm-Message-State: AC+VfDxcpZ18cP534HkisP1HbHft0KUMQnq+eHOv0SERNRqdab+fQm3V
        7AbZo0aIgruDjUF51mNszbt/KBnUEdNcTVmimyc=
X-Google-Smtp-Source: ACHHUZ5Xi1q7Qr8BpQtJ7QY25OlQp8ICSTCgK7JFeKCy6nELV0YWKp8eHxludT1KOtcxg84RnehJIFUxL8ijvgsUqx8=
X-Received: by 2002:a05:622a:589:b0:3f9:d70f:ff6b with SMTP id
 c9-20020a05622a058900b003f9d70fff6bmr5547763qtb.56.1686821015825; Thu, 15 Jun
 2023 02:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-6-ojeda@kernel.org>
 <49dad8fe-c509-6c43-559e-13a82563d3d0@gmail.com>
In-Reply-To: <49dad8fe-c509-6c43-559e-13a82563d3d0@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 15 Jun 2023 11:23:24 +0200
Message-ID: <CANiq72mq4wYJ77qDKYWTO=FkA1AYat2rJd63Gps9aUrP82c9dQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>, David Gow <davidgow@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 15, 2023 at 5:52=E2=80=AFAM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> I can't remember that if this panic it will mention the path on it.
> Though if it does, then use something more explicit than
> `.unwrap()`.

It doesn't print it, and I am happy to make things more explicit, but
in which case(s) do you see it failing?

> Please do not use unwrap here, one can easily create a path that
> it's not compliant under `rust/test/doctests/kernel` and get no
> clue about where this script has failed. Use `.expect()` or
> something else instead.

The folder is removed every time, so that should not happen I think.
Yes, you can still hack things and call the script manually, but I
wouldn't call that "easily".

Nevertheless, I am happy to change it if we think there is a risk,
e.g. `rustdoc` changing the pattern (though we pin the version so
far).

Thanks for taking a look Martin!

Cheers,
Miguel
