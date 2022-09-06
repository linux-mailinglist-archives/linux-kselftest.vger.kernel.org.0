Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8015ADD7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 04:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbiIFCno (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 22:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFCnn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 22:43:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F496BCC0;
        Mon,  5 Sep 2022 19:43:42 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l16so5364710ilj.2;
        Mon, 05 Sep 2022 19:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=wgLGzQzsX5u+qNh7hTHS3TJVfMcZwoAmQlDKyi6wq0A=;
        b=f4hPdwjSqJnykFP6ZO34vOa4/QPtZxn7WU2m1i7iFVMrlXYxVfJLR/9jIvAJhhbD05
         PU/6p34QCJGf8n8EBrGkySdhMRvlURVaHzieNN6gwbf2TUw6IOwpsmdycs8xW/nVQ1Sl
         YVJH0Wh1+5Q0JsMqU5WN6MCUYB5TDqtMoLJ+Qp50rlxPNm0QL7Ga7hcTLi3sL4yCqDii
         HOuyACXl9jJc7+bNRVCL3Vz2wPm+6vfP017OO5U6hY4BGx+9FsjbzMDwooDtOlsSn1oh
         sQg8vmFSXnybhCv5AVp0+BEoqcEYg9sx/XXmTALaHfxBCWz2hX9pXpVNv3hGK4/iK7Hk
         vGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=wgLGzQzsX5u+qNh7hTHS3TJVfMcZwoAmQlDKyi6wq0A=;
        b=kh9o0ZtFwEZKxV7dQa2CUT7P4BNHweJZFaYQARksav+80nzY/apigjjBQOcIetusZP
         FdqBEzh9653hUdbYooydLqR5BIFYgXje1FGzfV7kbjjra0KxQ4fvkyI9caajaibr++Nl
         0Ld2RZVhi40MKbacp/4jmTBcQ8V6fl6zkiwvB6PYPA4npguzXt0f1ISaMugrBfohjKSt
         c5ZUphEGLdUj2xno28NpB0I4jud1Qu2KUw1IZrKVQRw6Q2Lj7mrr/FHfpzCL4YniSF1c
         8BD28qLhJX6NpGMDI63yZs8X77oDxYduIWcXY4Doe9lKGmh5eivnGukDVS4+5EeHomep
         6DLA==
X-Gm-Message-State: ACgBeo3j0KIR1rBa6t1npRvIXlyg+hdElJ2U3kR/DHK81UNj/xUVizUN
        VxmVr6GiZonmz3D8y7+/j5bq6TfX99wmCX04xJ0=
X-Google-Smtp-Source: AA6agR72UeEy2tVs39Z0Xhnog8rrYKEnkOjMOOSFxQVK+0nQjBsQtxVRcnBYX9g+tIm2Qbwe1P4cr9vWza9W7Wnlclg=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr15035792ila.164.1662432221426; Mon, 05
 Sep 2022 19:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-7-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-7-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 04:43:05 +0200
Message-ID: <CAP01T74HKXuf9Aig4v3zsL1rwQAGRpUtTiaN2djWsMiJmaqF_A@mail.gmail.com>
Subject: Re: [PATCH v16 06/12] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
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
        deso@posteo.net, Roberto Sassu <roberto.sassu@huawei.com>
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

On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
> kfuncs, to respectively search a key with a given key handle serial number
> and flags, obtain a key from a pre-determined ID defined in
> include/linux/verification.h, and cleanup.
>
> Introduce system_keyring_id_check() to validate the keyring ID parameter of
> bpf_lookup_system_key().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

With a small nit below,
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  include/linux/bpf.h          |   8 +++
>  include/linux/verification.h |   8 +++
>  kernel/trace/bpf_trace.c     | 135 +++++++++++++++++++++++++++++++++++
>  3 files changed, 151 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 9dbd7c3f8929..f3db614aece6 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2595,4 +2595,12 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
>  static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
>  #endif /* CONFIG_BPF_LSM */
>
> +struct key;
> +
> +#ifdef CONFIG_KEYS
> +struct bpf_key {
> +       struct key *key;
> +       bool has_ref;
> +};
> +#endif /* CONFIG_KEYS */
>  #endif /* _LINUX_BPF_H */
> diff --git a/include/linux/verification.h b/include/linux/verification.h
> index a655923335ae..f34e50ebcf60 100644
> --- a/include/linux/verification.h
> +++ b/include/linux/verification.h
> @@ -17,6 +17,14 @@
>  #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
>  #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
>
> +static inline int system_keyring_id_check(u64 id)
> +{
> +       if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
>  /*
>   * The use to which an asymmetric key is being put.
>   */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..7a7023704ac2 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -20,6 +20,8 @@
>  #include <linux/fprobe.h>
>  #include <linux/bsearch.h>
>  #include <linux/sort.h>
> +#include <linux/key.h>
> +#include <linux/verification.h>
>
>  #include <net/bpf_sk_storage.h>
>
> @@ -1181,6 +1183,139 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
>         .arg1_type      = ARG_PTR_TO_CTX,
>  };
>
> +#ifdef CONFIG_KEYS
> +__diag_push();
> +__diag_ignore_all("-Wmissing-prototypes",
> +                 "kfuncs which will be used in BPF programs");
> +
> +/**
> + * bpf_lookup_user_key - lookup a key by its serial
> + * @serial: key handle serial number
> + * @flags: lookup-specific flags
> + *
> + * Search a key with a given *serial* and the provided *flags*.
> + * If found, increment the reference count of the key by one, and
> + * return it in the bpf_key structure.
> + *
> + * The bpf_key structure must be passed to bpf_key_put() when done
> + * with it, so that the key reference count is decremented and the
> + * bpf_key structure is freed.
> + *
> + * Permission checks are deferred to the time the key is used by
> + * one of the available key-specific kfuncs.
> + *
> + * Set *flags* with KEY_LOOKUP_CREATE, to attempt creating a requested
> + * special keyring (e.g. session keyring), if it doesn't yet exist.
> + * Set *flags* with KEY_LOOKUP_PARTIAL, to lookup a key without waiting
> + * for the key construction, and to retrieve uninstantiated keys (keys
> + * without data attached to them).
> + *
> + * Return: a bpf_key pointer with a valid key pointer if the key is found, a
> + *         NULL pointer otherwise.
> + */
> +struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> +{
> +       key_ref_t key_ref;
> +       struct bpf_key *bkey;
> +
> +       if (flags & ~KEY_LOOKUP_ALL)
> +               return NULL;
> +
> +       /*
> +        * Permission check is deferred until the key is used, as the
> +        * intent of the caller is unknown here.
> +        */
> +       key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
> +       if (IS_ERR(key_ref))
> +               return NULL;
> +
> +       bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);

Since this function (due to lookup_user_key) is sleepable, do we
really need GFP_ATOMIC here?

> +       if (!bkey) {
> +               key_put(key_ref_to_ptr(key_ref));
> +               return NULL;
> +       }
> +
> +       bkey->key = key_ref_to_ptr(key_ref);
> +       bkey->has_ref = true;
> +
> +       return bkey;
> +}
> +
> +/**
> + * bpf_lookup_system_key - lookup a key by a system-defined ID
> + * @id: key ID
> + *
> + * Obtain a bpf_key structure with a key pointer set to the passed key ID.
> + * The key pointer is marked as invalid, to prevent bpf_key_put() from
> + * attempting to decrement the key reference count on that pointer. The key
> + * pointer set in such way is currently understood only by
> + * verify_pkcs7_signature().
> + *
> + * Set *id* to one of the values defined in include/linux/verification.h:
> + * 0 for the primary keyring (immutable keyring of system keys);
> + * VERIFY_USE_SECONDARY_KEYRING for both the primary and secondary keyring
> + * (where keys can be added only if they are vouched for by existing keys
> + * in those keyrings); VERIFY_USE_PLATFORM_KEYRING for the platform
> + * keyring (primarily used by the integrity subsystem to verify a kexec'ed
> + * kerned image and, possibly, the initramfs signature).
> + *
> + * Return: a bpf_key pointer with an invalid key pointer set from the
> + *         pre-determined ID on success, a NULL pointer otherwise
> + */
> +struct bpf_key *bpf_lookup_system_key(u64 id)
> +{
> +       struct bpf_key *bkey;
> +
> +       if (system_keyring_id_check(id) < 0)
> +               return NULL;
> +
> +       bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
> +       if (!bkey)
> +               return NULL;
> +
> +       bkey->key = (struct key *)(unsigned long)id;
> +       bkey->has_ref = false;
> +
> +       return bkey;
> +}
> +
> +/**
> + * bpf_key_put - decrement key reference count if key is valid and free bpf_key
> + * @bkey: bpf_key structure
> + *
> + * Decrement the reference count of the key inside *bkey*, if the pointer
> + * is valid, and free *bkey*.
> + */
> +void bpf_key_put(struct bpf_key *bkey)
> +{
> +       if (bkey->has_ref)
> +               key_put(bkey->key);
> +
> +       kfree(bkey);
> +}
> +
> +__diag_pop();
> +
> +BTF_SET8_START(key_sig_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
> +BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
> +BTF_SET8_END(key_sig_kfunc_set)
> +
> +static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
> +       .owner = THIS_MODULE,
> +       .set = &key_sig_kfunc_set,
> +};
> +
> +static int __init bpf_key_sig_kfuncs_init(void)
> +{
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                        &bpf_key_sig_kfunc_set);
> +}
> +
> +late_initcall(bpf_key_sig_kfuncs_init);
> +#endif /* CONFIG_KEYS */
> +
>  static const struct bpf_func_proto *
>  bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> --
> 2.25.1
>
