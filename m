Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF4352B331E
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Nov 2020 10:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgKOI67 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Nov 2020 03:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgKOI6e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Nov 2020 03:58:34 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE06C0613D2
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Nov 2020 00:58:33 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id i18so12989927ots.0
        for <linux-kselftest@vger.kernel.org>; Sun, 15 Nov 2020 00:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOfon08D4Z8QqvBeUPGRpAKg2puT4+gjjSEjZd3iW9U=;
        b=wKSPTVfFPmI7y0+3EK74LC5ZHIYhP+UsyUVeT4mOjbN3rjOPwenhkD76d8kMEmEwTU
         fZ9IU5vPB0KFoFeB5wj8Kwb1ZgcDdj0IIMztyZkcDYdQJ6bGROofOV56xq3/Zf9U6kp9
         WFrdoQ05yQLtZcgF7N0+cn02+xpeEtjRitJCPap8GmhYRoJIJ/QBfIGxMQLpEMwsTu7e
         DGMUk1Qc1Q8WXsdtBli++0Z27BrxaduSAculqD4fx8QQRvN1Uw2zvzK6A/9qkiyMXRxo
         0axZhijITMHaydwtu9To8uf/nfQhFCmp/+DyEVZCkAGfC9xva7++5Z7zOY8NecyA+rxt
         M+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOfon08D4Z8QqvBeUPGRpAKg2puT4+gjjSEjZd3iW9U=;
        b=GRKXh31/BTlsmTOgNZJ7khN7uP76TLq2gZc/ZniyIEey5KIYWx6hQIcCN7hw1c1CjK
         BHGGADzWWpokZMjs+6OmgQcWxaFbE0Ob8z7EcBWscMYDxPFVuQJ8b5RFZt+tSznFp9m3
         2ySOssH4sbN7oAxiHeDtGshnfxFE3SkNsX2TKfpOq/k1l4xjSqF+ZtrAd1FGXTAPu3X8
         v4iozpu3UYikrrh1HnCMvfv3gpdM08chrpbOXPjW5Zl4bkh5C7LPM7u7C+nBC8FowLG2
         Ugc0yFT7sEAwEvQ9+r8pOemYm/idN4QKU/y6R4ojQ448p39q39/aNUK9kFx2+dPj4BGY
         ulHg==
X-Gm-Message-State: AOAM532oBzAqkMm6jEYySd76afuzrQ5VsmbYE5XMH1hCEQaSj+w4TUJ+
        XNd4gDIv54uLYdsHYc1lV+fQpVJJe1gfQJ1cuBsqyw==
X-Google-Smtp-Source: ABdhPJzeDiymHRksn52ZIlUX8jqRL3oxfopfmqdADwje3rGNKDhpfM9140ry6nmookbuB0Eot4/zWYcFlJqq0rK/ijs=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr6656603oth.251.1605430712516;
 Sun, 15 Nov 2020 00:58:32 -0800 (PST)
MIME-Version: 1.0
References: <20201114123648.97857-1-98.arpi@gmail.com>
In-Reply-To: <20201114123648.97857-1-98.arpi@gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Sun, 15 Nov 2020 09:58:21 +0100
Message-ID: <CANpmjNNsVxGiGWeij-EsDUpc_fBBYg7iBynis1tQKwh8ks5jQw@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] kunit: Support for Parameterized Testing
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Tim Bird <Tim.Bird@sony.com>, David Gow <davidgow@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, 14 Nov 2020 at 13:38, Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> Implementation of support for parameterized testing in KUnit. This
> approach requires the creation of a test case using the
> KUNIT_CASE_PARAM() macro that accepts a generator function as input.
>
> This generator function should return the next parameter given the
> previous parameter in parameterized tests. It also provides a macro to
> generate common-case generators based on arrays. Generators may also
> optionally provide a human-readable description of parameters, which is
> displayed where available.
>
> Note, currently the result of each parameter run is displayed in
> diagnostic lines, and only the overall test case output summarizes
> TAP-compliant success or failure of all parameter runs. In future, when
> supported by kunit-tool, these can be turned into subsubtest outputs.
>
> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> Co-developed-by: Marco Elver <elver@google.com>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> Changes v6->v7:
> - Clarify commit message.
> - Introduce ability to optionally generate descriptions for parameters;
>   if no description is provided, we'll still print 'param-N'.
> - Change diagnostic line format to:
>         # <test-case-name>: <ok|not ok> N - [<param description>]
>
> Changes v5->v6:
> - Fix alignment to maintain consistency
>
> Changes v4->v5:
> - Update kernel-doc comments.
> - Use const void* for generator return and prev value types.
> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> - Rework parameterized test case execution strategy: each parameter is executed
>   as if it was its own test case, with its own test initialization and cleanup
>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>   protocol once we have already started execution. Instead, log the result of
>   each parameter run as a diagnostic comment.
>
> Changes v3->v4:
> - Rename kunit variables
> - Rename generator function helper macro
> - Add documentation for generator approach
> - Display test case name in case of failure along with param index
>
> Changes v2->v3:
> - Modifictaion of generator macro and method
>
> Changes v1->v2:
> - Use of a generator method to access test case parameters
> Changes v6->v7:
> - Clarify commit message.
> - Introduce ability to optionally generate descriptions for parameters;
>   if no description is provided, we'll still print 'param-N'.
> - Change diagnostic line format to:
>         # <test-case-name>: <ok|not ok> N - [<param description>]
> - Before execution of parameterized test case, count number of
>   parameters and display number of parameters. Currently also as a
>   diagnostic line, but this may be used in future to generate a subsubtest
>   plan. A requirement of this change is that generators must generate a
>   deterministic number of parameters.
>
> Changes v5->v6:
> - Fix alignment to maintain consistency
>
> Changes v4->v5:
> - Update kernel-doc comments.
> - Use const void* for generator return and prev value types.
> - Add kernel-doc comment for KUNIT_ARRAY_PARAM.
> - Rework parameterized test case execution strategy: each parameter is executed
>   as if it was its own test case, with its own test initialization and cleanup
>   (init and exit are called, etc.). However, we cannot add new test cases per TAP
>   protocol once we have already started execution. Instead, log the result of
>   each parameter run as a diagnostic comment.
>
> Changes v3->v4:
> - Rename kunit variables
> - Rename generator function helper macro
> - Add documentation for generator approach
> - Display test case name in case of failure along with param index
>
> Changes v2->v3:
> - Modifictaion of generator macro and method
>
> Changes v1->v2:
> - Use of a generator method to access test case parameters
>
>  include/kunit/test.h | 51 ++++++++++++++++++++++++++++++++++++++
>  lib/kunit/test.c     | 59 ++++++++++++++++++++++++++++++++++----------
>  2 files changed, 97 insertions(+), 13 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index db1b0ae666c4..cf5f33b1c890 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -94,6 +94,9 @@ struct kunit;
>  /* Size of log associated with test. */
>  #define KUNIT_LOG_SIZE 512
>
> +/* Maximum size of parameter description string. */
> +#define KUNIT_PARAM_DESC_SIZE 64

I think we need to make this larger, perhaps 128. I just noticed a few
of the inode-test strings are >64 chars (and it should probably also
use strncpy() to copy to description, which is my bad).

>  /*
>   * TAP specifies subtest stream indentation of 4 spaces, 8 spaces for a
>   * sub-subtest.  See the "Subtests" section in
> @@ -107,6 +110,7 @@ struct kunit;
[...]
> +/**
> + * KUNIT_ARRAY_PARAM() - Define test parameter generator from an array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: array of test parameters.
> + * @get_desc: function to convert param to description; NULL to use default
> + *
> + * Define function @name_gen_params which uses @array to generate parameters.
> + */
> +#define KUNIT_ARRAY_PARAM(name, array, get_desc)                                               \
> +       static const void *name##_gen_params(const void *prev, char *desc)                      \
> +       {                                                                                       \
> +               typeof((array)[0]) * __next = prev ? ((typeof(__next)) prev) + 1 : (array);     \

Why did you reintroduce a space between * and __next? AFAIK, this
should follow the same style as the rest of the kernel, and it should
just be 'thetype *ptr'.

> +               if (__next - (array) < ARRAY_SIZE((array))) {                                   \
> +                       void (*__get_desc)(typeof(__next), char *) = get_desc;                  \
> +                       if (__get_desc)                                                         \
> +                               __get_desc(__next, desc);                                       \
> +                       return __next;                                                          \
> +               }                                                                               \
> +               return NULL;                                                                    \
> +       }
> +

Thanks,
-- Marco
