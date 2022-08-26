Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFDF65A3080
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 22:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344914AbiHZUh2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 16:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245076AbiHZUhY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 16:37:24 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF17AC88BF;
        Fri, 26 Aug 2022 13:37:22 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l16so1197630ilj.2;
        Fri, 26 Aug 2022 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=WEfgf2R2DJCDs4AKod2m6jqCNNrqV7+4FPWOEmxw+3A=;
        b=g8/kHbdWdljV6lk39scxyK+hjzhO3FYwd+XGwNJZSS856AA3+YYk0umH9HZ2LQ6uB1
         WgVaK5PwdsQ4LiW812qON8c6Lx5eUGHVubtjTD5u0hDQtXh16kAo3KEv1zlgaCOhhzBZ
         aw+xNrIqGMF7r6CEzA/j3mIJI+hnI/gvDWIiajFuVI5BoTQmSIXCljz9nWGiyN6lZRCx
         PIWXK/Bv8B/IzdU7tOFT+Sa/UEuD/mkg/t5lEi7aD5ZXABQsnwjdWJiRy6BhYpIDgfZN
         4TtcQHkXszBxP8tDrpf76uB+CXJzfS+TItNBtHR77cghkhpqhqwF+Hm8dER/JoTWsIYS
         IpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=WEfgf2R2DJCDs4AKod2m6jqCNNrqV7+4FPWOEmxw+3A=;
        b=A40NbiAGR/Uo1y4UkgWTgeONHF4uPBZPyv5QDDiaiP/CRD/vrwVLtQyxF6h8S37EbP
         3NIbaCqNaqBQxVG5OtGUggzqQAmIP2YV7Cw1zRWlLB+7rtIOvFDRZmlhxzd/2GJ+0RQh
         hlDNHXMJIzDiqGPRL1cU3zBhyEe24WsDLmWxEZ5sAfaZL05mXtI8iIOzoO6bBLlaguBx
         f16gBU8igqrGeZX2DVIS6fPMAAsviTKiVvoUxrwVbd8TU4ee9VCmBQXROuTKqB0ssX4e
         PW0r2m+rUV5Vx6/WD9/hvJnCR0cR5yGb3lh/i2FW1pu28Ty6SKFyLOUz4nyGhOxM0pXG
         DQHg==
X-Gm-Message-State: ACgBeo0Q3n7uSbbnHuTKlV5dpiCqh9VzwcYPMpCMKWTZUnfu6s2qPnRr
        Bwfk6ZAgn/cUYHA7M3ivlm4N4ivU34NHPOq64EY=
X-Google-Smtp-Source: AA6agR4OuuzyTi2F9/KR+kfMeIwGonZgjsgtKhvQSq79lYto57sei+AOJAhU1Hd0a9qqnDRUs5bZS+vBJFX5D/QZkG4=
X-Received: by 2002:a92:ca4e:0:b0:2ea:3f77:a85 with SMTP id
 q14-20020a92ca4e000000b002ea3f770a85mr4787935ilo.219.1661546241807; Fri, 26
 Aug 2022 13:37:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220823150035.711534-1-roberto.sassu@huaweicloud.com> <20220823150035.711534-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220823150035.711534-3-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Fri, 26 Aug 2022 22:36:46 +0200
Message-ID: <CAP01T75rQZvnk8y+AJr9KDjra1JO8=Q_kuD5TnxJ+4dp455Gyg@mail.gmail.com>
Subject: Re: [PATCH v13 02/10] btf: Handle dynamic pointer parameter in kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        corbet@lwn.net, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        bpf@vger.kernel.org, linux-doc@vger.kernel.org,
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

On Tue, 23 Aug 2022 at 19:27, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Allow the bpf_dynptr_kern parameter to be specified in kfuncs. Also, ensure
> that the dynamic pointer is valid and initialized.
>
> To properly detect whether a parameter is of the desired type, introduce
> the stringify_struct() macro to compare the returned structure name with
> the desired name. In addition, protect against structure renames, by
> halting the build with BUILD_BUG_ON(), so that developers have to revisit
> the code.
>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf_verifier.h |  3 +++
>  include/linux/btf.h          |  9 +++++++++
>  kernel/bpf/btf.c             | 18 ++++++++++++++++++
>  kernel/bpf/verifier.c        |  4 ++--
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 2e3bad8640dc..55876fbdbae2 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -560,6 +560,9 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>                              u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                    u32 regno, u32 mem_size);
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +                             struct bpf_reg_state *reg,
> +                             enum bpf_arg_type arg_type);
>
>  /* this lives here instead of in bpf.h because it needs to dereference tgt_prog */
>  static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index ad93c2d9cc1c..f546d368ac5d 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -52,6 +52,15 @@
>  #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>  #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
>
> +/*
> + * Return the name of the passed struct, if exists, or halt the build if for
> + * example the structure gets renamed. In this way, developers have to revisit
> + * the code using that structure name, and update it accordingly.
> + */
> +#define stringify_struct(x)                    \
> +       ({ BUILD_BUG_ON(sizeof(struct x) < 0);  \
> +          __stringify(x); })
> +
>  struct btf;
>  struct btf_member;
>  struct btf_type;
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index e49b3b6d48ad..26cb548420af 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6362,15 +6362,20 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>
>                         if (is_kfunc) {
>                                 bool arg_mem_size = i + 1 < nargs && is_kfunc_arg_mem_size(btf, &args[i + 1], &regs[regno + 1]);
> +                               bool arg_dynptr = btf_type_is_struct(ref_t) &&
> +                                                 !strcmp(ref_tname,
> +                                                         stringify_struct(bpf_dynptr_kern));
>
>                                 /* Permit pointer to mem, but only when argument
>                                  * type is pointer to scalar, or struct composed
>                                  * (recursively) of scalars.
>                                  * When arg_mem_size is true, the pointer can be
>                                  * void *.
> +                                * Also permit initialized dynamic pointers.
>                                  */
>                                 if (!btf_type_is_scalar(ref_t) &&
>                                     !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> +                                   !arg_dynptr &&
>                                     (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
>                                         bpf_log(log,
>                                                 "arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> @@ -6378,6 +6383,19 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                         return -EINVAL;
>                                 }
>
> +                               if (arg_dynptr) {
> +                                       if (!is_dynptr_reg_valid_init(env, reg,
> +                                                       ARG_PTR_TO_DYNPTR)) {

Do you intend to really accept all kinds of dynptr here? In the future
we will get more, and by default ARG_PTR_TO_DYNPTR accepts all, so it
seems better to start with a small strict subset.

Secondly, you need to also check whether reg is a PTR_TO_STACK inside
this arg_dynptr branch. It is incorrect to call
is_dynptr_reg_valid_init for any other type of register. It would also
be nice to include some tests for that.



> +                                               bpf_log(log,
> +                                                       "arg#%d pointer type %s %s must be initialized\n",
> +                                                       i, btf_type_str(ref_t),
> +                                                       ref_tname);
> +                                               return -EINVAL;
> +                                       }
> +
> +                                       continue;
> +                               }
> +
>                                 /* Check for mem, len pair */
>                                 if (arg_mem_size) {
>                                         if (check_kfunc_mem_size_reg(env, &regs[regno + 1], regno + 1)) {
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2c1f8069f7b7..aa834e7bb296 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         return true;
>  }
>
> -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> -                                    enum bpf_arg_type arg_type)
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
> +                             enum bpf_arg_type arg_type)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         int spi = get_spi(reg->off);
> --
> 2.25.1
>
