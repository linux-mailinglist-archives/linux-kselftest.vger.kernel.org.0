Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73F97B3ACC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Sep 2023 21:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232748AbjI2TwL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Sep 2023 15:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2TwL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Sep 2023 15:52:11 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FF7B4
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Sep 2023 12:52:09 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-405459d9a96so15655e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Sep 2023 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696017127; x=1696621927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PXOi0jNCwNMzaxq46SNP4Ur9k7LhJwFcidUSRjcN2eY=;
        b=Mj3QlDbCGMlh0zARL4ap45kRfmEFcStYxmrM4qiLDT4ChOwKOrwsELWsiRUnOHhJ1Q
         WXVcHq3OChC9n+1+4nwvrnwN7JzOae+6/WjS5WDlfXVU4HKgob2kg28OMWP8NPt+Ql8c
         ZPaM2fTuuLlNElBuS93rlLEvdDVF1fljB/juJi6wVLPYzBcOOTLKe7LdWhdm1gBpHGoB
         vB9WnAVPooH3/GFO6eN7JgRnN0MTSyhQCNcmi7nf8freCKNYjb4axni5LGdVTVjv5WPO
         0D9QPJl2jG1+vdBIQ0RmoobLd32O9Vm2uFoGAVnORCPMu9PHAveVDdhgYjEaC7fxINjY
         bSEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696017127; x=1696621927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PXOi0jNCwNMzaxq46SNP4Ur9k7LhJwFcidUSRjcN2eY=;
        b=UaLjU0y3T6OmuxAKw4GPXuVtfXXdKiJAeDehRs+zokMXJfScWigB1YdxN8gk6kXJnk
         VvqNzUqLZXwb8GU6w1PaRCc5amZrnLXiuaZwlmzTzHM4whosor3m3aYAN1sVkBGPvZS/
         0mkAqXrjdrUq0SIWuXVoiImV4Z5oR5JuRwLAOOQ5IZ6R/X+kld2zfWi1axn9j/w2XzCL
         Q5jJDqS7CwqIxkPc2KzQ6oemMW8zbconBuZOWcY4K9UrjPWJr2Ay6ZTY1aT2Qx3JO2AD
         /2dj+Rhzyd8hwNM4ULMhMjYZ3etHhQ6lzR4QrZpn+JfOuPpjtQbKqSehxixqYs8go5R6
         dNHg==
X-Gm-Message-State: AOJu0YwNgoz3AFd1pl8xhm+k92PwUWs90GuDSwsr1/dzUG3lDXzLu08Z
        9q/C1UB7Cc7nMwlSQZWK9DTKPVI10UGgJIs7sGkkdQ==
X-Google-Smtp-Source: AGHT+IEuNhHaGMduL1j67W7E3OGVlPti6UorYJJ0SdITW+h1wnv+J5hFrhT/L4DEAVDxjDDTMdC3xaBmi9jcFxz2FoU=
X-Received: by 2002:a05:600c:601c:b0:404:74f8:f47c with SMTP id
 az28-20020a05600c601c00b0040474f8f47cmr1612wmb.5.1696017127354; Fri, 29 Sep
 2023 12:52:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230926220208.1423-1-michal.wajdeczko@intel.com> <20230926220208.1423-2-michal.wajdeczko@intel.com>
In-Reply-To: <20230926220208.1423-2-michal.wajdeczko@intel.com>
From:   Rae Moar <rmoar@google.com>
Date:   Fri, 29 Sep 2023 15:51:55 -0400
Message-ID: <CA+GJov48shBap0xh9auT14UUaxmYjsEfwqmftD8ZzpAR=dk+Mg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: Allow to filter entries from zero terminated arrays
To:     Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Sep 26, 2023 at 6:02=E2=80=AFPM Michal Wajdeczko
<michal.wajdeczko@intel.com> wrote:
>
> In some cases we may want to generate params based on existing
> zero terminated array, but with some entries filtered out.
> Extend macro KUNIT_ZERO_ARRAY_PARAM to accept filter function
> and provide example how to use it.

Hello!

I definitely understand the use case of wanting to filter params.
However, since this is a static filter, it seems this could be done in
the test file and rather than implemented as a new KUnit feature.

I would be interested to see David's thoughts on this. If we do decide
to implement this as a KUnit feature, I would also prefer if the
filtering ability is available for both the zero-terminated param
arrays and normal param arrays.

Otherwise I just have one comment below. Let me know what you think.

Thanks!
-Rae

>
> $ ./tools/testing/kunit/kunit.py run \
>     --kunitconfig ./lib/kunit/.kunitconfig *.example_params*
>
> [ ] Starting KUnit Kernel (1/1)...
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D example  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D example_par=
ams_test  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] [SKIPPED] example value 0
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] example_params=
_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D example_par=
ams_test  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] [SKIPPED] example value 3
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] example_params=
_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D example_par=
ams_test  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] [PASSED] example value 2
> [ ] [PASSED] example value 1
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASSED] example_params=
_test =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D [PASS=
ED] example =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [ ] Testing complete. Ran 9 tests: passed: 6, skipped: 3
>
> Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Rae Moar <rmoar@google.com>
> ---
>  include/kunit/test.h           | 19 +++++++++++++++++--
>  lib/kunit/kunit-example-test.c |  9 +++++++++
>  2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/include/kunit/test.h b/include/kunit/test.h
> index 280113ceb6a6..8a87d1ce37e0 100644
> --- a/include/kunit/test.h
> +++ b/include/kunit/test.h
> @@ -1515,20 +1515,24 @@ do {                                             =
                              \
>         }
>
>  /**
> - * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zer=
o terminated array.
> + * KUNIT_FILTERED_ZERO_ARRAY_PARAM() - Define test parameter generator f=
rom a zero terminated array.
>   * @name:  prefix for the test parameter generator function.
>   * @array: zero terminated array of test parameters.
>   * @get_desc: function to convert param to description; NULL to use defa=
ult
> + * @filter: function to filter out unwanted params (like duplicates); ca=
n be NULL
>   *
>   * Define function @name_gen_params which uses zero terminated @array to=
 generate parameters.
>   */
> -#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)                   =
                       \
> +#define KUNIT_FILTERED_ZERO_ARRAY_PARAM(name, array, get_desc, filter)  =
                       \
>         static const void *name##_gen_params(const void *prev, char *desc=
)                      \
>         {                                                                =
                       \
>                 typeof((array)[0]) *__prev =3D prev;                     =
                         \
>                 typeof(__prev) __next =3D __prev ? __prev + 1 : (array); =
                         \
>                 void (*__get_desc)(typeof(__next), char *) =3D get_desc; =
                         \
> +               bool (*__filter)(typeof(__prev), typeof(__next)) =3D filt=
er;                      \
>                 for (; memchr_inv(__next, 0, sizeof(*__next)); __prev =3D=
 __next++) {             \
> +                       if (__filter && !__filter(__prev, __next))       =
                       \
> +                               continue;                                =
                       \
>                         if (__get_desc)                                  =
                       \
>                                 __get_desc(__next, desc);                =
                       \
>                         return __next;                                   =
                       \
> @@ -1536,6 +1540,17 @@ do {                                              =
                              \
>                 return NULL;                                             =
                       \
>         }
>
> +/**
> + * KUNIT_ZERO_ARRAY_PARAM() - Define test parameter generator from a zer=
o terminated array.
> + * @name:  prefix for the test parameter generator function.
> + * @array: zero terminated array of test parameters.
> + * @get_desc: function to convert param to description; NULL to use defa=
ult
> + *
> + * Define function @name_gen_params which uses zero terminated @array to=
 generate parameters.
> + */
> +#define KUNIT_ZERO_ARRAY_PARAM(name, array, get_desc)  \
> +       KUNIT_FILTERED_ZERO_ARRAY_PARAM(name, array, get_desc, NULL)
> +
>  // TODO(dlatypov@google.com): consider eventually migrating users to exp=
licitly
>  // include resource.h themselves if they need it.
>  #include <kunit/resource.h>
> diff --git a/lib/kunit/kunit-example-test.c b/lib/kunit/kunit-example-tes=
t.c
> index ad9ebcfd513e..a3268754392c 100644
> --- a/lib/kunit/kunit-example-test.c
> +++ b/lib/kunit/kunit-example-test.c
> @@ -201,8 +201,16 @@ static void example_param_get_desc(const struct exam=
ple_param *p, char *desc)
>         snprintf(desc, KUNIT_PARAM_DESC_SIZE, "example value %d", p->valu=
e);
>  }
>
> +static bool example_param_filter(const struct example_param *prev,
> +                                const struct example_param *next)
> +{
> +       return next->value < 3;
> +}
> +
>  KUNIT_ARRAY_PARAM(example, example_params_array, example_param_get_desc)=
;
>  KUNIT_ZERO_ARRAY_PARAM(example_zero, example_params_array, example_param=
_get_desc);
> +KUNIT_FILTERED_ZERO_ARRAY_PARAM(example_filter, example_params_array, ex=
ample_param_get_desc,
> +                               example_param_filter);
>
>  /*
>   * This test shows the use of params.
> @@ -248,6 +256,7 @@ static struct kunit_case example_test_cases[] =3D {
>         KUNIT_CASE(example_static_stub_test),
>         KUNIT_CASE_PARAM(example_params_test, example_gen_params),
>         KUNIT_CASE_PARAM(example_params_test, example_zero_gen_params),
> +       KUNIT_CASE_PARAM(example_params_test, example_filter_gen_params),

Similar to last patch, I would probably prefer the test names to
differ slightly for the three param tests.

>         KUNIT_CASE_SLOW(example_slow_test),
>         {}
>  };
> --
> 2.25.1
>
> --
> You received this message because you are subscribed to the Google Groups=
 "KUnit Development" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kunit-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/kunit-dev/20230926220208.1423-2-michal.wajdeczko%40intel.com.
