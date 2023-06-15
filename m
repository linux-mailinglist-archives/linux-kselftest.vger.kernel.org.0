Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 115487311FE
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jun 2023 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239514AbjFOIVI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Jun 2023 04:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbjFOIUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Jun 2023 04:20:54 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7421213F;
        Thu, 15 Jun 2023 01:20:43 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bd744ffc263so1466018276.3;
        Thu, 15 Jun 2023 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686817243; x=1689409243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+g1EITlpyKqSTNS66gSjpFolTiPe57pV55f5skYdlk=;
        b=kPeNuOVaNVXIRJd9crDCP1FTb0Cs/gxo20VHoVU4zinJgQfhdUGCgvHLXIPjx1LkuZ
         z+CfqoYGkCRbgxUN/NrL5KQJrFtiPy688H6ADOssoN/n2PJETlRRloSpDPBwiwMJC/6I
         n+sYBQZVxD/d+cSSusltZZKQJAIFMi34CGp/7nl1oy0pkKZ9cgvXms2FipS/uiXuff0o
         8DP5XrYfJdVnVQkNxwL0ATqkUF9qYv9HQ1zS704VUtL7OJoqcRiWpdkLacb7ozdwAQC7
         jMdMhTtSWkbaxmuMQ0ki2G1meDzNUUBojElAgOpJa+pqDtGwWv81D68MJQkzRC4mSg8M
         B8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817243; x=1689409243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+g1EITlpyKqSTNS66gSjpFolTiPe57pV55f5skYdlk=;
        b=NTv/8U92Yn5eGtvLfQjURynS1yPjk97+BXtgh547fqMflS6PY4EEw+U1BtiKPprnNY
         5g0Q6Z/kWopjtYfuSqpNLcOhK+pdqwFA1A4NEGMWQamqsR7rzbsMfmR+frQOoKvc+Fhi
         0we4t7IELMXrdwcUUlFD6emsXMN+a+AFmosK9ELdhvqE1SCj8AHzthMeTm8q7uMPohp4
         MneYQvN1wl+RtXzD/4LsxJUQ1yST/kVosb7X36DhDHfoyW+sYh822yQMlG6TBacnECQ8
         awr0sWrlyWr3RMX4DPOJX2RoCV/Lw9bvGNDqyQnqA9KBzBntw3JbkIC6q8XHswoiziB9
         jKjQ==
X-Gm-Message-State: AC+VfDwGr3ORxY7xEupoD1j1SJi33mmNMrFLNuUH/CoS5FfBZaJ42Vb+
        qDFlMxdkSXpLF5YdkszwkgB4Jxh9ZvO4nPDVAtQ=
X-Google-Smtp-Source: ACHHUZ5wZcHqgLWPneYowEPyb/vMtXfLcl6iVcQDr0Pg9watznu/kRbkN+YQH+842S1lRXtj9sJTCQXadFTZxb4w2rE=
X-Received: by 2002:a25:240d:0:b0:bd5:4e6d:9159 with SMTP id
 k13-20020a25240d000000b00bd54e6d9159mr4103388ybk.17.1686817242809; Thu, 15
 Jun 2023 01:20:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230614180837.630180-1-ojeda@kernel.org> <ZIps86MbJF/iGIzd@boqun-archlinux>
In-Reply-To: <ZIps86MbJF/iGIzd@boqun-archlinux>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 15 Jun 2023 10:20:31 +0200
Message-ID: <CANiq72kHEddR-D17Ykr3xtU20rDJn517fqHRUX+-kWHjYqu9PA@mail.gmail.com>
Subject: Re: [PATCH 0/6] KUnit integration for Rust doctests
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
        Philip Li <philip.li@intel.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 15, 2023 at 3:44=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Great work! I've played this for a while, and it's really useful ;-)

Thanks!

> The assertion warning only says line 35 but which file? Yes, the
> ".._sync_lock_spinlock_rs" name does provide the lead, however since we
> generate the test code, so we actually know the line # for each real
> test body, so I come up a way to give us the following:
>
>         [..] # rust_doctest_kernel_sync_lock_spinlock_rs_0: ASSERTION FAI=
LED at rust/kernel/sync/lock/spinlock.rs:61
>         [..] Expected e.c =3D=3D 11 to be true, but is false
>         [..] [FAILED] rust_doctest_kernel_sync_lock_spinlock_rs_0
>
> Thoughts?

Sounds good to me. However, David/Philip, is this OK or do you really
need/use the actual/compiled source file there? If you don't need it,
does it need to exist / be a real file at least? If the latter answer
is a "yes", which I guess it may be likely, then:

> +        let src_file =3D format!("rust/kernel/{}", file.replace("_rs", "=
.rs").replace("_", "/"));

This would not work for files with a `_` in their name, like
`locked_by.rs`. I guess we could still find the real filename based on
that information walking the dir, which is another hack I recall
considering at some point.

Otherwise, if "fake" filenames in the line above are OK for
David/Philip (I suspect they may want to open them for reporting?),
then I guess the `file` one may be good enough and eventually we
should get `rustdoc` to give us the proper metadata anyway.

Cheers,
Miguel
