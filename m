Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61D82730A68
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 00:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233333AbjFNWJp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 14 Jun 2023 18:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjFNWJo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Jun 2023 18:09:44 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FEB1A1;
        Wed, 14 Jun 2023 15:09:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-bc492cb6475so1132416276.2;
        Wed, 14 Jun 2023 15:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686780582; x=1689372582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxCYYqgD5haUCkeC5DXhN+uLq5/abXQjgXDwO+5hkwc=;
        b=dT92Uk2SGyIBASdn2lfY84qqz+cSYS7DEvwolim1KJ8NqEiRlMaf1uBLM07S7UDzZ9
         uk6HN3gXsTCujof6V+SQ1/Bl9SqtIB9ZpOiLjEGQSDaKbgB61qVRT2dwKZ9oXuiSWSjg
         6xMvZNJuUxLs1vEaz33tbMB3hxiBKlS4jJ2jCVfSm8Jcj2+T++v1CSo6VtmQSo2y+yfu
         lXnrSLtbB0dCwiw2twlcqaOJywLugz/d62mngkgHiJGB4WNogu5g8ZFV1e3D01bxUxrB
         lGvak+5Ctw+fJY7TSslNIB20RU3R40WYKl4YxNjs+vwTheNvj8jmcMWPmMumtRbIFSO/
         AnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686780582; x=1689372582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxCYYqgD5haUCkeC5DXhN+uLq5/abXQjgXDwO+5hkwc=;
        b=NFKO28xKfbl3Uf+P4LoE0BhQ6WgkvRx2N3B+6pP1Tio9TFe7CSpNNspCPuf51Vu8Kt
         Um/MgXEifOJxLf0mNDBuNNY5119Fa3CHy+yqsWOPq7XqSmsY2ffWmMN8hKFC9A4VR+GY
         HKNkv8zoz0ekNytN9A9rz6a6NE4SfMwmnq6Bz4zlyMl8SVvdD4k1OpyHOHR7qYnHaIEh
         ZTnmUtggKc5qCSbSK8M8tir2z43mKbWOG/KUjI0Xxxw4CzBXkx8QFlwV9g9tctxjQVz7
         TybPYrOI4Ugxw57Qqbp6WCBsBTEjfLtJ3TIzQ8FkX4khFYwXEZLgIOykXbmYM2B/1Buq
         Ov8g==
X-Gm-Message-State: AC+VfDy3GrEA9qF2Wo58T1hFDJiv+30hREp0oikE5ImNHdES4AJnl9jb
        F6EYigZi4+WCfhHSW++AG2BEBvtAwccww5lADwc=
X-Google-Smtp-Source: ACHHUZ5Ki7h45tEWuN2EE3YC5f6+IiHoRICcZpFhSuZgR2mQeCO1yeN+ZS7sLNMFWqW3qJyi2KZE+OGtbEesC1AoGK0=
X-Received: by 2002:a25:9343:0:b0:bca:bc83:d315 with SMTP id
 g3-20020a259343000000b00bcabc83d315mr2765786ybo.48.1686780581786; Wed, 14 Jun
 2023 15:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <20230614180837.630180-6-ojeda@kernel.org>
In-Reply-To: <20230614180837.630180-6-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 15 Jun 2023 00:09:30 +0200
Message-ID: <CANiq72mM+=XBWXBqrgkBcSwR2GtC=PX5WwTB8+-Tm0wVOMtgPg@mail.gmail.com>
Subject: Re: [PATCH 5/6] rust: support running Rust documentation tests as
 KUnit ones
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     David Gow <davidgow@google.com>,
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 14, 2023 at 8:09=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> +/// Prints a KUnit error.

Nit: this should be "info" instead.

By the way, we may want to have "raw" `pr_*!` macros without the
module prefix for cases like this in the future, in `print.rs`. But,
for the moment, I added these two ad-hoc ones here.

Cheers,
Miguel
