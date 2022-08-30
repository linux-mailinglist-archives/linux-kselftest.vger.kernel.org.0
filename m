Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD115A68AE
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 18:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiH3QrE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Aug 2022 12:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiH3QrB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Aug 2022 12:47:01 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350FB654D;
        Tue, 30 Aug 2022 09:46:53 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r4so14978309edi.8;
        Tue, 30 Aug 2022 09:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1AFNZlzSZWcJdvdgruC16P+i1WUA5VJSb9W5RFFvucA=;
        b=hMFE98nV+X9JQJiBf12uyzGf/BQr/ijcGk+8ElRrwVaOXjvyT7/FpAqdjSUiQtO0kc
         NWJfEPRsnVPRj/VviMCoTYRkObelu28uFnJIZrgASCkr5cfe0jFOJlDMAm/rSj11S4o5
         D3EYd17vDD8TfRIJa1fdFcneMVZMJDY7Iv7DreaTOazf4UkNggzUftnjErfkrZvyJWIQ
         WuOqwkZ/20XubWwTe6HitbUv2O8JPsJkecqmJulgtG/tDewU3LYm5B3Ckm1Wir7LwkFe
         mJxyjeFWzwEMqKNiQpeHRmjzaO7RhRhf6GvE1JPe4Yja0/qtnT9XuZuEAtz/jGsOneW7
         OJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1AFNZlzSZWcJdvdgruC16P+i1WUA5VJSb9W5RFFvucA=;
        b=V9waGUy1QjFI9Ymzls2OqvMAs1F/vx+nTZKgiN8RVEnBB+rirWCWwREI8Lnd5ubI52
         pHhKgooWrDVDUzk/fgmHEl6z0KEl4/g2TteNAetbWa2Bi+FKMoQ/fawJdNR1qN93Ma6+
         ZmrJivLbOBwWYxr2H61nQ/xf8UbHqOcdRSh0NtMWPAg6dgODWrTohZ8ZsIOoMzD0JW4P
         5K4O9N/6kOWV33KyOR+1KZbZpuaFlEShCOrL/VI1JVFgk6oOTn0v8y5zD/KBjAJE57/6
         6BOMdKJpAf/HlotYj8XVnQWdMRWh05EjUZbYp4r1XBouqK6rrG44rOf0O5ByJVUcfRhz
         kBmg==
X-Gm-Message-State: ACgBeo3H9dxdF3aZHPCsA9d35Oa/PEjruVrUBZqlgJiZODHdCJrkl/e9
        UC9cXQdPuIFHUI4ekLL83Sge1MG/pfgalzbJveo=
X-Google-Smtp-Source: AA6agR6zCvjUuBANcNe0mySzUsgSK/SNXbtQUEhStfMzOX91Gs6XvPn4gSOPAnZR3ZLFJFG1aUZzJb1GFKYF5/6XJVo=
X-Received: by 2002:a05:6402:1e8c:b0:448:8776:d813 with SMTP id
 f12-20020a0564021e8c00b004488776d813mr7041452edf.15.1661878012245; Tue, 30
 Aug 2022 09:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220830161716.754078-1-roberto.sassu@huaweicloud.com> <20220830161716.754078-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220830161716.754078-3-roberto.sassu@huaweicloud.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Tue, 30 Aug 2022 09:46:41 -0700
Message-ID: <CAJnrk1bL2MSN81ORrkm9JcFQh3qsJ1jVGXEycSjyhk+Jv_Bz2Q@mail.gmail.com>
Subject: Re: [PATCH v14 02/12] bpf: Move dynptr type check to is_dynptr_type_expected()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org, bpf@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 30, 2022 at 9:18 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Move dynptr type check to is_dynptr_type_expected() from
> is_dynptr_reg_valid_init(), so that callers can better determine the cause
> of a negative result (dynamic pointer not valid/initialized, dynamic
> pointer of the wrong type).
>
> Also, splitting makes the code more readable, since checking the dynamic
> pointer type is not necessarily related to validity and initialization.

I think it'd be helpful to also include that btf will be using these
functions, which seems like the main motivation behind why this change
is needed.

>
> Split the validity/initialization and dynamic pointer type check also in
> the verifier, and adjust the expected error message in the test (a test for
> an unexpected dynptr type passed to a helper cannot be added due to missing
> suitable helpers, but this case has been tested manually).

The bpf_ringbuf_submit_dynptr() and bpf_ringbuf_discard_dynptr()
helpers take in only ringbuf-type dynptrs, so either of these would
work for testing the case where an incorrect dynptr type is passed in
:)

>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  kernel/bpf/verifier.c                         | 35 ++++++++++++++-----
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +-
>  2 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0194a36d0b36..1b913db252a3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         return true;
>  }
>
> -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -                                    enum bpf_arg_type arg_type)
> +static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +                                    struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         int spi = get_spi(reg->off);
> @@ -796,11 +796,24 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_re
>                         return false;
>         }
>
> +       return true;
> +}
> +
> +static bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> +                                   struct bpf_reg_state *reg,
> +                                   enum bpf_arg_type arg_type)
> +{
> +       struct bpf_func_state *state = func(env, reg);
> +       int spi = get_spi(reg->off);
> +       enum bpf_dynptr_type dynptr_type;

nit: the above 2 lines should be swapped to maintain reverse christmas
tree order of declarations

> +
>         /* ARG_PTR_TO_DYNPTR takes any type of dynptr */
>         if (arg_type == ARG_PTR_TO_DYNPTR)
>                 return true;
>
> -       return state->stack[spi].spilled_ptr.dynptr.type == arg_to_dynptr_type(arg_type);
> +       dynptr_type = arg_to_dynptr_type(arg_type);
> +
> +       return state->stack[spi].spilled_ptr.dynptr.type == dynptr_type;
>  }
>
>  /* The reg state of a pointer or a bounded scalar was saved when
> @@ -6050,21 +6063,27 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>                         }
>
>                         meta->uninit_dynptr_regno = regno;
> -               } else if (!is_dynptr_reg_valid_init(env, reg, arg_type)) {
> +               } else if (!is_dynptr_reg_valid_init(env, reg)) {
> +                       verbose(env,
> +                               "Expected an initialized dynptr as arg #%d\n",
> +                               arg + 1);
> +                       return -EINVAL;
> +               } else if (!is_dynptr_type_expected(env, reg, arg_type)) {
>                         const char *err_extra = "";
>
>                         switch (arg_type & DYNPTR_TYPE_FLAG_MASK) {
>                         case DYNPTR_TYPE_LOCAL:
> -                               err_extra = "local ";
> +                               err_extra = "local";
>                                 break;
>                         case DYNPTR_TYPE_RINGBUF:
> -                               err_extra = "ringbuf ";
> +                               err_extra = "ringbuf";
>                                 break;
>                         default:
> +                               err_extra = "<unknown>";
>                                 break;
>                         }
> -
> -                       verbose(env, "Expected an initialized %sdynptr as arg #%d\n",
> +                       verbose(env,
> +                               "Expected a dynptr of type %s as arg #%d\n",
>                                 err_extra, arg + 1);
>                         return -EINVAL;
>                 }
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> index bcf80b9f7c27..8fc4e6c02bfd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -30,7 +30,7 @@ static struct {
>         {"invalid_helper2", "Expected an initialized dynptr as arg #3"},
>         {"invalid_write1", "Expected an initialized dynptr as arg #1"},
>         {"invalid_write2", "Expected an initialized dynptr as arg #3"},
> -       {"invalid_write3", "Expected an initialized ringbuf dynptr as arg #1"},
> +       {"invalid_write3", "Expected an initialized dynptr as arg #1"},
>         {"invalid_write4", "arg 1 is an unacquired reference"},
>         {"invalid_read1", "invalid read from stack"},
>         {"invalid_read2", "cannot pass in dynptr at an offset"},
> --
> 2.25.1
>
