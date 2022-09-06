Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751955ADD65
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 04:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiIFCeA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 22:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiIFCd6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 22:33:58 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDBA6B8F7;
        Mon,  5 Sep 2022 19:33:57 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z72so7883007iof.12;
        Mon, 05 Sep 2022 19:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=pzWkviLiyP7+AvZHEuuHIl7H6QCMlZET2vIM//Hw/N4=;
        b=OEnj2EUS5rA60Hck0t+m22Z32Zk7/RqXNxu0xBlXzGAK1Uj1jvylTAMNRCLWvBtyC4
         oTt4HYZvfmv8K/PLRjUZUWHZlD4eBAHR9EX4FQ2rjkFxPJPQFcNSaUEhKzWE64kadAqA
         bmzld3jWov0YtVJ4zP6cgAGdcVVcA/lAYR485GnOlCtYvyXq/36aYJFUYjzbBmycWgR0
         kK1WD/ApBm4DOg681fTICFFdZ/BKPPcMyW60cocFIYhqzggLQ7PqbmcrXdiv/RMIrejm
         FFUv5c8gvPQAI7yaU7vXjABwnczJVgpFKsEhopQl+Loe5/8UK1bK9bBc+9LBXorz/mnt
         TORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pzWkviLiyP7+AvZHEuuHIl7H6QCMlZET2vIM//Hw/N4=;
        b=Vbz1XzvtFFONbxJJB7sYErAOHsIXSNjoa0jMlIkRNaoPMmF5mGZTLmK6oZGz2pp+CC
         4b3wURCr+6DtjkqORqbeOOo4TjzhU+QFhOzW7lkmJ8+0ujYp5btiKNduVHDuLHAHu1zV
         diQyLIcLQ0bK2tytY3b2dfeF0BA3vEPOz0aKpsnHmxJ+du4TTb5dzN5cypz5Zw/piph8
         owmdGR5zyinB97HDPI5HpzIm9t7yEIJQ6Jui2kOBdwDq1hI20FAjZ6681YgOPEFUaRbI
         scnd7hFiATxK6hNHHcVXK1TqzVOuRyOVRLE4bC7pmHpnKNbJ57zNFVxbMBNRGt7PFVlO
         5+nA==
X-Gm-Message-State: ACgBeo3I5VDBOu/dhmlsnCdg0EfKHK2xhkgc54A5C5zmmrU05yJzpET7
        t4pALXdcx9ogeoPJnTlBpZ3157TxFRgfTvZH2lGm29eGd2g=
X-Google-Smtp-Source: AA6agR66aEKv92gUxUN2bgVUtBnJmMpf9wBd9vRPEuHyPMOyAAlTQVgq5S8qKe6sVX9yX077zcQXCJZr1DpRsBrFZag=
X-Received: by 2002:a05:6602:2e94:b0:689:bae1:1b42 with SMTP id
 m20-20020a0566022e9400b00689bae11b42mr23885240iow.168.1662431636250; Mon, 05
 Sep 2022 19:33:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-4-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-4-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 04:33:20 +0200
Message-ID: <CAP01T76PqKVf1f-jo=U6V1tj4DdT1STa1dkfe2gSOuiCVuZjOw@mail.gmail.com>
Subject: Re: [PATCH v16 03/12] btf: Allow dynamic pointer parameters in kfuncs
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
> Allow dynamic pointers (struct bpf_dynptr_kern *) to be specified as
> parameters in kfuncs. Also, ensure that dynamic pointers passed as argument
> are valid and initialized, are a pointer to the stack, and of the type
> local. More dynamic pointer types can be supported in the future.
>
> To properly detect whether a parameter is of the desired type, introduce
> the stringify_struct() macro to compare the returned structure name with
> the desired name. In addition, protect against structure renames, by
> halting the build with BUILD_BUG_ON(), so that developers have to revisit
> the code.
>
> To check if a dynamic pointer passed to the kfunc is valid and initialized,
> and if its type is local, export the existing functions
> is_dynptr_reg_valid_init() and is_dynptr_type_expected().
>
> Cc: Joanne Koong <joannelkoong@gmail.com>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  include/linux/bpf_verifier.h |  5 +++++
>  include/linux/btf.h          |  9 +++++++++
>  kernel/bpf/btf.c             | 33 +++++++++++++++++++++++++++++++++
>  kernel/bpf/verifier.c        | 10 +++++-----
>  4 files changed, 52 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1fdddbf3546b..dd58dfccd025 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -571,6 +571,11 @@ int check_kfunc_mem_size_reg(struct bpf_verifier_env *env, struct bpf_reg_state
>                              u32 regno);
>  int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_state *reg,
>                    u32 regno, u32 mem_size);
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +                             struct bpf_reg_state *reg);
> +bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> +                            struct bpf_reg_state *reg,
> +                            enum bpf_arg_type arg_type);
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
> index e49b3b6d48ad..4266bff5fada 100644
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
> +                                * Also permit initialized local dynamic pointers.
>                                  */
>                                 if (!btf_type_is_scalar(ref_t) &&
>                                     !__btf_type_is_scalar_struct(log, btf, ref_t, 0) &&
> +                                   !arg_dynptr &&
>                                     (arg_mem_size ? !btf_type_is_void(ref_t) : 1)) {
>                                         bpf_log(log,
>                                                 "arg#%d pointer type %s %s must point to %sscalar, or struct with scalar\n",
> @@ -6378,6 +6383,34 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
>                                         return -EINVAL;
>                                 }
>
> +                               if (arg_dynptr) {
> +                                       if (reg->type != PTR_TO_STACK) {
> +                                               bpf_log(log, "arg#%d pointer type %s %s not to stack\n",
> +                                                       i, btf_type_str(ref_t),
> +                                                       ref_tname);
> +                                               return -EINVAL;
> +                                       }
> +
> +                                       if (!is_dynptr_reg_valid_init(env, reg)) {
> +                                               bpf_log(log,
> +                                                       "arg#%d pointer type %s %s must be valid and initialized\n",
> +                                                       i, btf_type_str(ref_t),
> +                                                       ref_tname);
> +                                               return -EINVAL;
> +                                       }
> +
> +                                       if (!is_dynptr_type_expected(env, reg,
> +                                                       ARG_PTR_TO_DYNPTR | DYNPTR_TYPE_LOCAL)) {
> +                                               bpf_log(log,
> +                                                       "arg#%d pointer type %s %s points to unsupported dynamic pointer type\n",
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
> index 10b3c0a81d09..8f02729074c6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -779,8 +779,8 @@ static bool is_dynptr_reg_valid_uninit(struct bpf_verifier_env *env, struct bpf_
>         return true;
>  }
>
> -static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> -                                    struct bpf_reg_state *reg)
> +bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
> +                             struct bpf_reg_state *reg)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         int spi = get_spi(reg->off);
> @@ -799,9 +799,9 @@ static bool is_dynptr_reg_valid_init(struct bpf_verifier_env *env,
>         return true;
>  }
>
> -static bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> -                                   struct bpf_reg_state *reg,
> -                                   enum bpf_arg_type arg_type)
> +bool is_dynptr_type_expected(struct bpf_verifier_env *env,
> +                            struct bpf_reg_state *reg,
> +                            enum bpf_arg_type arg_type)
>  {
>         struct bpf_func_state *state = func(env, reg);
>         enum bpf_dynptr_type dynptr_type;
> --
> 2.25.1
>
