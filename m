Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15BD5ADD60
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 04:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbiIFCdD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 22:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIFCdC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 22:33:02 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5368C255B9;
        Mon,  5 Sep 2022 19:33:01 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id e7so5339005ilc.5;
        Mon, 05 Sep 2022 19:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4qDNF8dPhMwbDSHgKTnXc7ZrRTg2DhtHWLkSBAhsVwg=;
        b=Vua1s6fm20ZKL/f8WgybLoA/y7enupNXOWshqQCGGsvq+XBEusMdJNVTI+cqVMT96N
         CsE0++wzyFpJNReS81/SPKo66yJxQJyoGN6NBLClMnVTBo4uaz1nVZ1kML/h+8TJy7pA
         3Me0UvTqeaSVZP/f9ggOwAbseA1dGGiT1Hhi2+adXCkHPy2g8N/YGDeaJENR8tzCM/rV
         1zm1znSgFI9RcOZIm4LZrk13BPO4fbynuFgNmePzSyLBaZvNYgus1M07sge5BzHW/XLJ
         P2Vwgun8ufixAdU7ip1g2bYKGLutSzwohuvcrZYghumJaHCCUggGGdVw+1LsCEs5Atxy
         xo8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4qDNF8dPhMwbDSHgKTnXc7ZrRTg2DhtHWLkSBAhsVwg=;
        b=io9ZDYKWMaPjblEsOnNEx3pI2tRF/HFMRF1Gn3zdf8sQX+l+8cBPSChk8xjYcVOgJr
         S/o5UjVdDLcI8GdBwwDHoG91Xv435D7yagBy+uX4v/lDmv9Zwg9JQ/AzqwY/0XsGYTFo
         30qWoj+kJjgc5u6XoXPeakA0FxVS2sl2M8FuJCQ0q8enFmEYq5E8vUYiwS/GeW2yfhA8
         yHGkA9Wdz+ci/DmN7wZYTko5YFvmBnWnccxrVv9RbPhnE5soHl4gQWP3zjAYvOODKzqx
         QWaft4Hr6wI2irTcaVCTCHVMdQnaTDggsqyJDW1lajs5Jf4Idh6AeUTlk0+WmP/aUytM
         ql9Q==
X-Gm-Message-State: ACgBeo0ukoqlwJE7dwi5Z2wWi+uk5TCPClzypXEQ5FviUN6gxlXnecnu
        L8FfNE9ZDndgSAjns5bhs49X3XJhwP5sVdahwOI=
X-Google-Smtp-Source: AA6agR4Q3qEu6Nh67A8tibtWLaSlV3Vzqb58cgujGaSTS4Q1s1VFdS2cnLx4oTRqXRLsbiwhZZPjv6yTUAaYJbFxBr0=
X-Received: by 2002:a05:6e02:190a:b0:2ee:9e75:ae4b with SMTP id
 w10-20020a056e02190a00b002ee9e75ae4bmr9141148ilu.219.1662431580497; Mon, 05
 Sep 2022 19:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-3-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 04:32:24 +0200
Message-ID: <CAP01T75KbEOuzcyiTqzDMa7tqtSzY5c0r2jMPJXgniWndEKRpg@mail.gmail.com>
Subject: Re: [PATCH v16 02/12] bpf: Move dynptr type check to is_dynptr_type_expected()
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
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>,
        Joanne Koong <joannelkoong@gmail.com>
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

On Mon, 5 Sept 2022 at 16:34, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Move dynptr type check to is_dynptr_type_expected() from
> is_dynptr_reg_valid_init(), so that callers can better determine the cause
> of a negative result (dynamic pointer not valid/initialized, dynamic
> pointer of the wrong type). It will be useful for example for BTF, to
> restrict which dynamic pointer types can be passed to kfuncs, as initially
> only the local type will be supported.
>
> Also, splitting makes the code more readable, since checking the dynamic
> pointer type is not necessarily related to validity and initialization.
>
> Split the validity/initialization and dynamic pointer type check also in
> the verifier, and adjust the expected error message in the test (a test for
> an unexpected dynptr type passed to a helper cannot be added due to missing
> suitable helpers, but this case has been tested manually).
>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

I'm not sure the split is _really_ needed, but I don't feel strongly
about it and defer to Joanne and others.
Otherwise,
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  kernel/bpf/verifier.c                         | 35 ++++++++++++++-----
>  .../testing/selftests/bpf/prog_tests/dynptr.c |  2 +-
>  2 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 068b20ed34d2..10b3c0a81d09 100644
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
> +       enum bpf_dynptr_type dynptr_type;
> +       int spi = get_spi(reg->off);
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
