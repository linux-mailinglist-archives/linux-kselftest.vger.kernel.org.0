Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F47495A93
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jan 2022 08:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378920AbiAUHV7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 21 Jan 2022 02:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349069AbiAUHV5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 21 Jan 2022 02:21:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9280C061401
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:21:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id f202-20020a1c1fd3000000b0034dd403f4fbso16904491wmf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jan 2022 23:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3CrLAhHri6cW7ge5sJ5mw2A/ImHNlJKr/VuNGqWz4kw=;
        b=m5S5VWVhb+cg0vapaRftt4gkZ1W0KfvP07ZZ1t0HTKbr9d+dFs2IgWRGb6TbEK2e1L
         zUzxbtW1kQO6YAfwDI+xp8libeaa23DDtRwFC6WT0jCuv2u/lq2waA/MpljtzyHALje4
         mTvAjdLHL2cs7nuhbt0GJKTLZVaXT4loISsejC0yURPHQxdBAnqxaOe1FDvmc44UFRnt
         a6Yoitgr8DYqw1bosKyXya7LAZQFUq4gcPyjoHo3GI751r7QufdK8u+ECHuqJMHdZM9c
         U99OeA2cvsBp5/m645kRNB0gNGNdee0l99CLSjsQsETTPZK6sm1IfuENFbpngA9yfNTt
         0WNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3CrLAhHri6cW7ge5sJ5mw2A/ImHNlJKr/VuNGqWz4kw=;
        b=Ekw+rdxXWQI/x7QqECk2ozmJP4IIKZRUVtQllA30INu0LAvcC41Z2xM1DuIdS+xAv/
         BXFYg3m7sbCxqjxmIbywoaVe3ib1/QHuxoFi5kscG0yzLoHJOlPNycks2rUhlNxZqahI
         Q7SWiNv5ioO9sEThJPy7b76CwUAdm4rveAs8dGnMNm+cq141dmI1fdMQOlvvXy5wBtHV
         afAwxVd/g3tJ4bk+Qwi+gipeizEYG89I6K2r5M/PuUSNK0rO6I1hIPQgptpOZhnjZSkB
         TOSGh3naj/3J+KA+qqhqC+bFK7xDxCaS4koeute/ST3TDF6sU49WMi+p0VPazTgerxoz
         5HKA==
X-Gm-Message-State: AOAM530RMokQ6tdg45arze9r0XrYYS+zU9zudFjYZx6Zg1vrWyL2qvQz
        qL+9f98bNG+vlRmfYTmo2zgJAoOzj/sl/oFkpimhmA==
X-Google-Smtp-Source: ABdhPJwohDIXrdLpuEbLWAz2ODrca7mxD95P2+aqpcfyNr9ZWv0FukkVThQIUPjiU3jxvkcYy2vI4hqAU2aiLr1aXBI=
X-Received: by 2002:a5d:6d85:: with SMTP id l5mr2682374wrs.447.1642749715107;
 Thu, 20 Jan 2022 23:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20220118223506.1701553-1-dlatypov@google.com> <20220118223506.1701553-3-dlatypov@google.com>
In-Reply-To: <20220118223506.1701553-3-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 21 Jan 2022 15:21:42 +0800
Message-ID: <CABVgOSmZuOgMMEQqzQDo=mdtBmnZZEkXohBzViJQw3bdxnzheA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: drop unused intermediate macros for ptr
 inequality checks
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jan 19, 2022 at 6:35 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> We have the intermediate macros for KUNIT_EXPECT_PTR_GT() and friends,
> but these macros don't exist.
>
> I can see niche usecases for these macros existing, but since we've been
> fine without them for so long, let's drop this dead code.
>
> Users can instead cast the pointers and use the other GT/LT macros.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Agreed: while I can sort-of see why one might want to use something
like this for bounds checking, casting to an integer is definitely
acceptable (and we've got things like KASAN and fortify-source for
many bounds-checking cases anyway).

Also, many languages explicitly treat pointers as not being comparable
this way anyway, and rely on casting to integer, which is a trend
worth following, I think.

Reviewed-by: David Gow <davidgow@google.com>

Cheers,
-- David


>  include/kunit/test.h | 60 --------------------------------------------
>  1 file changed, 60 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index b032dd6816d2..c021945a75e3 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1044,21 +1044,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_LT_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_LT_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_LE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_LE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1069,21 +1054,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_LE_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_LE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_GT_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_GT_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1094,21 +1064,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_GT_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_GT_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_GE_MSG_ASSERTION(test, assert_type, left, right, fmt, ...)\
>         KUNIT_BASE_GE_MSG_ASSERTION(test,                                      \
>                                     kunit_binary_assert,                       \
> @@ -1119,21 +1074,6 @@ do {                                                                            \
>                                     fmt,                                       \
>                                     ##__VA_ARGS__)
>
> -#define KUNIT_BINARY_PTR_GE_MSG_ASSERTION(test,                                       \
> -                                         assert_type,                         \
> -                                         left,                                \
> -                                         right,                               \
> -                                         fmt,                                 \
> -                                         ...)                                 \
> -       KUNIT_BASE_GE_MSG_ASSERTION(test,                                      \
> -                                   kunit_binary_ptr_assert,                   \
> -                                   KUNIT_INIT_BINARY_PTR_ASSERT_STRUCT,       \
> -                                   assert_type,                               \
> -                                   left,                                      \
> -                                   right,                                     \
> -                                   fmt,                                       \
> -                                   ##__VA_ARGS__)
> -
>  #define KUNIT_BINARY_STR_ASSERTION(test,                                      \
>                                    assert_type,                                \
>                                    left,                                       \
> --
> 2.34.1.703.g22d0c6ccf7-goog
>
> --
> You received this message because you are subscribed to the Google Groups "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kunit-dev/20220118223506.1701553-3-dlatypov%40google.com.
