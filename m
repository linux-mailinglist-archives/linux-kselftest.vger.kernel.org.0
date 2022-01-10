Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC8048A305
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 23:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241891AbiAJWfU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 17:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241251AbiAJWfU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 17:35:20 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1AEC06173F
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:35:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z22so14571922edd.12
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Jan 2022 14:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIoaAe6wgJZd3qm1nF2dHAaaGlyYQh1CajnW5xdMA2w=;
        b=OckSHyXrNtkIKrrYwTqW69ql0bJSf9I72ojuSbCBY96noWyMXs+zYDzhAXBdDnch5J
         zP8Xn3oOj6Q8/vxJ6/OlCNGg+YwBtwfbZvjWAlORdCtkbpV25m1FQt1601KXJpJhQKe8
         D4X6yiORsfEcilXX4JGXNiZgplzxJiWxWCPTKwV/Jfdpq7rN1VgqUKhB0mwLgWvDgA05
         69DpC3dhYQ5DY4cM5YQjFbQbNNuS53gkXzi8qlTNlZDN2y/qTlNY9cDcmDs6gcMPeXJ6
         S0IhjEPrf5LNDz6TBZ2utYIk6kFSBSdIcaNIToR0534KfnFa8Oi8yljJH/ZFB4P9KzYg
         iPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIoaAe6wgJZd3qm1nF2dHAaaGlyYQh1CajnW5xdMA2w=;
        b=sFQbwML/lzv5WnkN1vYB1tkOHKM+EPKyaFM63vU6V4eXSf7dHfBfxAtyrEkNa8ekAm
         ylLAmAJONCUko9lKCdf5aanahzu3T6x9ngRL/MGsOg/ZcB4pnOyUrjdGO1YJEz57FB9j
         aLfHEIwxOhIC/wmMp6bS8pOScZEc8bwgx3fMpZCyDWUcNz7KyqNuaI4cjipCrW9l8LfZ
         QRtwymsy9b0QPnHQY5ADnrk/+7hpE8K/Ym/+lIY8uCDV6g+xqXN6Ekf/GumshiQM/8/x
         71selHWGViOBDmgjwkpafFZn5y17DumSnAA9mrEePos4Wj4KaYCsFxZpnGv8iqKV05Vw
         nutw==
X-Gm-Message-State: AOAM532I4F918ZZqPS9UJi2gK9x4ji87YtlwC9CITh3DqLCOpHYOyvol
        IE2RlAoP/bruYr5HjiIsfs/0pH14LcHAvwRDKpmQPA==
X-Google-Smtp-Source: ABdhPJyxvooGDQ3H+6iiSy4C4myE9fXj/RhizZEtbCeeJjgd5ehOfgdErTm+SeXlIzyQt7r+9HW1/MlKvb+vYjQKREI=
X-Received: by 2002:a17:906:9b92:: with SMTP id dd18mr1388666ejc.425.1641854118098;
 Mon, 10 Jan 2022 14:35:18 -0800 (PST)
MIME-Version: 1.0
References: <20220108012304.1049587-1-dlatypov@google.com> <20220108012304.1049587-5-dlatypov@google.com>
 <CAFd5g47r8aQBWPtt6ffHokqqN2sMi10p1Q5QA3xGVLTVDQh98Q@mail.gmail.com>
In-Reply-To: <CAFd5g47r8aQBWPtt6ffHokqqN2sMi10p1Q5QA3xGVLTVDQh98Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Mon, 10 Jan 2022 14:35:06 -0800
Message-ID: <CAGS_qxqnxzm1+45Mbufsz51mkz0_2PUt0eQiviwdGEV0+=ywKg@mail.gmail.com>
Subject: Re: [PATCH 4/6] kunit: factor out kunit_base_assert_format() call
 into kunit_fail()
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jan 10, 2022 at 2:32 PM 'Brendan Higgins' via KUnit
Development <kunit-dev@googlegroups.com> wrote:
>
> On Fri, Jan 7, 2022 at 8:23 PM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > We call this function first thing for all the assertion `format()`
> > functions.
> > This is the part that prints the file and line number and assertion type
> > (EXPECTATION, ASSERTION).
> >
> > Having it as part of the format functions lets us have the flexibility
> > to not print that information (or print it differently) for new
> > assertion types, but I think this we don't need that.
>
> nit: drop the "this".
>
> > And in the future, we'd like to consider factoring that data (file,
> > line#, type) out of the kunit_assert struct and into a `static`
> > variable, as Linus suggested [1], so we'd need to extract it anyways.
> >
> > [1] https://groups.google.com/g/kunit-dev/c/i3fZXgvBrfA/m/VULQg1z6BAAJ
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
> >  lib/kunit/assert.c | 6 ------
> >  lib/kunit/test.c   | 1 +
> >  2 files changed, 1 insertion(+), 6 deletions(-)
> >
> > diff --git a/lib/kunit/assert.c b/lib/kunit/assert.c
> > index b972bda61c0c..4d9a1295efc7 100644
> > --- a/lib/kunit/assert.c
> > +++ b/lib/kunit/assert.c
> > @@ -40,7 +40,6 @@ EXPORT_SYMBOL_GPL(kunit_assert_print_msg);
> >  void kunit_fail_assert_format(const struct kunit_assert *assert,
> >                               struct string_stream *stream)
> >  {
> > -       kunit_base_assert_format(assert, stream);
> >         string_stream_add(stream, "%pV", &assert->message);
> >  }
> >  EXPORT_SYMBOL_GPL(kunit_fail_assert_format);
> > @@ -52,7 +51,6 @@ void kunit_unary_assert_format(const struct kunit_assert *assert,
> >
> >         unary_assert = container_of(assert, struct kunit_unary_assert, assert);
> >
> > -       kunit_base_assert_format(assert, stream);
> >         if (unary_assert->expected_true)
> >                 string_stream_add(stream,
> >                                   KUNIT_SUBTEST_INDENT "Expected %s to be true, but is false\n",
> > @@ -73,7 +71,6 @@ void kunit_ptr_not_err_assert_format(const struct kunit_assert *assert,
> >         ptr_assert = container_of(assert, struct kunit_ptr_not_err_assert,
> >                                   assert);
> >
> > -       kunit_base_assert_format(assert, stream);
> >         if (!ptr_assert->value) {
> >                 string_stream_add(stream,
> >                                   KUNIT_SUBTEST_INDENT "Expected %s is not null, but is\n",
> > @@ -119,7 +116,6 @@ void kunit_binary_assert_format(const struct kunit_assert *assert,
> >         binary_assert = container_of(assert, struct kunit_binary_assert,
> >                                      assert);
> >
> > -       kunit_base_assert_format(assert, stream);
> >         string_stream_add(stream,
> >                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> >                           binary_assert->left_text,
> > @@ -147,7 +143,6 @@ void kunit_binary_ptr_assert_format(const struct kunit_assert *assert,
> >         binary_assert = container_of(assert, struct kunit_binary_ptr_assert,
> >                                      assert);
> >
> > -       kunit_base_assert_format(assert, stream);
> >         string_stream_add(stream,
> >                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> >                           binary_assert->left_text,
> > @@ -187,7 +182,6 @@ void kunit_binary_str_assert_format(const struct kunit_assert *assert,
> >         binary_assert = container_of(assert, struct kunit_binary_str_assert,
> >                                      assert);
> >
> > -       kunit_base_assert_format(assert, stream);
> >         string_stream_add(stream,
> >                           KUNIT_SUBTEST_INDENT "Expected %s %s %s, but\n",
> >                           binary_assert->left_text,
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 5ad671745483..735c1b67d843 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -255,6 +255,7 @@ static void kunit_fail(struct kunit *test, struct kunit_assert *assert)
> >                 return;
> >         }
> >
> > +       kunit_base_assert_format(assert, stream);
>
> I think my thinking in having this function called by the other assert
> functions was to take advantage of inheritance. I was treating
> kunit_base_assert_format as the parent method that other methods were
> inheriting from, so I wanted to have them inherit some of the common
> behavior by calling the original function.
>
> If you decide to make this change, I think it would be a good idea to
> change the name of kunit_base_assert_format to not mislead to this
> effect.

The child patch renames it to kunit_assert_prologue().
I can rename it in this change if you prefer.

I had just initially left it with the same name to keep this diff a
bit smaller and more focused.
But now you point it out, I think it would be cleaner to rename it here.

>
> >         assert->format(assert, stream);
> >
> >         kunit_print_string_stream(test, stream);
> > --
> > 2.34.1.575.g55b058a8bb-goog
> >
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/CAFd5g47r8aQBWPtt6ffHokqqN2sMi10p1Q5QA3xGVLTVDQh98Q%40mail.gmail.com.
