Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39C3E5909A7
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 02:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234234AbiHLAuI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 11 Aug 2022 20:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHLAuH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 11 Aug 2022 20:50:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D89A1D7C
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 17:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61066B82334
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 00:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF5A7C4314D
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Aug 2022 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660265402;
        bh=TIQaOoU+pLAcFRM/R/Q7m46Yb2W9R3osC1QlkuW063k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=URY0PFSv7C3hE/WIg4QU8bzDezkTOv83QB3CiMgs+LML6iEIoYcMg36OVjUqnnWVI
         0ghOaTkKL55lSk42Joaft22pc0ntcOaqkO6iIbBI5zel88mS/oRZVAvQIMtIQ/g2Po
         NjMTU2wTpDgwsvTGdKmhEQxZzE8oYozher1EbwMCKxvVyKB7xZ/xZ1m1bdsPIR72qy
         8WL3Zt/TN+tNA+vxRG0fahkeXhIP3+mS56FH3pgZIr4g2ySh4H8MW8e7tqVnE6Hx/h
         GnFIa2plJqjWT3eFdXu1jslf1NZ4zrZqz5lWkJHTIOy9F6h57JNpQyqV6oMcVGaURx
         FG4aEHHVv9hlg==
Received: by mail-yb1-f169.google.com with SMTP id b144so4159323yba.13
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Aug 2022 17:50:02 -0700 (PDT)
X-Gm-Message-State: ACgBeo2kZtPTU3sZ45/b8AQUxNGZ07RGa6gfpPK1UFowMh1pdnTpRMvG
        yzJqEdCn189/ecNWcdyWr85nyRh8/uYNkgaZOSM07Q==
X-Google-Smtp-Source: AA6agR6kD2Pf7FsSFzR6yThkj/UDKvSltMp+bydiWpPs5ohsMOEy7LVYTUeT9gRNRB1PF59zUTpEDQuTixZiBY5yMQI=
X-Received: by 2002:a25:780e:0:b0:671:3386:8129 with SMTP id
 t14-20020a25780e000000b0067133868129mr1834812ybc.404.1660265391258; Thu, 11
 Aug 2022 17:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220810165932.2143413-1-roberto.sassu@huawei.com> <20220810165932.2143413-6-roberto.sassu@huawei.com>
In-Reply-To: <20220810165932.2143413-6-roberto.sassu@huawei.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Fri, 12 Aug 2022 02:49:40 +0200
X-Gmail-Original-Message-ID: <CACYkzJ718fr2TsvX0JPhTRiMQH8=HwaxLShrETLvrhPUy2p8OQ@mail.gmail.com>
Message-ID: <CACYkzJ718fr2TsvX0JPhTRiMQH8=HwaxLShrETLvrhPUy2p8OQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, corbet@lwn.net, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, linux-doc@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 10, 2022 at 7:01 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> Add the bpf_lookup_user_key(), bpf_lookup_system_key() and bpf_key_put()
> kfuncs, to respectively search a key with a given serial and flags, obtain

nit: "with a given key handle serial number"

> a key from a pre-determined ID defined in include/linux/verification.h, and
> cleanup.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  include/linux/bpf.h      |   6 ++
>  kernel/trace/bpf_trace.c | 146 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 152 insertions(+)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a82f8c559ae2..d415e5e97551 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2573,4 +2573,10 @@ static inline void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype) {}
>  static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
>  #endif /* CONFIG_BPF_LSM */
>
> +#ifdef CONFIG_KEYS
> +struct bpf_key {
> +       struct key *key;
> +       bool has_ref;
> +};
> +#endif /* CONFIG_KEYS */
>  #endif /* _LINUX_BPF_H */
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 68e5cdd24cef..a607bb0be738 100644
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
> @@ -1181,6 +1183,150 @@ static const struct bpf_func_proto bpf_get_func_arg_cnt_proto = {
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
> + * @serial: key serial

nit: "key handle serial number"


> + * @flags: lookup-specific flags
> + *
> + * Search a key with a given *serial* and the provided *flags*. The
> + * returned key, if found, has the reference count incremented by
> + * one, and is stored in a bpf_key structure, returned to the caller.

nit: This can be made a little clearer with:

Search a key with a given *serial* and the provided *flags*.
If found, increment the reference count of the key by
one, and return it in the bpf_key structure.


> + * The bpf_key structure must be passed to bpf_key_put() when done
> + * with it, so that the key reference count is decremented and the
> + * bpf_key structure is freed.
> + *
> + * Permission checks are deferred to the time the key is used by
> + * one of the available key-specific kfuncs.
> + *
> + * Set *flags* with 1, to attempt creating a requested special
> + * keyring (e.g. session keyring), if it doesn't yet exist. Set
> + * *flags* with 2 to lookup a key without waiting for the key
> + * construction, and to retrieve uninstantiated keys (keys without
> + * data attached to them).

The 1 and 2 here are so confusing why not just use their actual names here:
KEY_LOOKUP_CREATE and KEY_LOOKUP_PARTIAL.

> + *
> + * Return: a bpf_key pointer with a valid key pointer if the key is found, a
> + *         NULL pointer otherwise.
> + */
> +struct bpf_key *bpf_lookup_user_key(u32 serial, u64 flags)
> +{
> +       key_ref_t key_ref;
> +       struct bpf_key *bkey;
> +
> +       /* Keep in sync with include/linux/key.h. */

What does this comment mean? Does this mean that more flags may end up in this
check? if so, let's just put an inline function in include/linux/key.h?

> +       if (flags & ~(KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL))
> +               return NULL;
> +
> +       /*
> +        * Permission check is deferred until actual kfunc using the key,
> +        * since here the intent of the caller is not yet known.
> +        *
> +        * We cannot trust the caller to provide the needed permission as
> +        * argument, since nothing prevents the caller from using the
> +        * obtained key for a different purpose than the one declared.
> +        */

nit: This can just be a simple comment.

Permission check is deferred until the key is used as the intent of the
caller is unknown here.

> +       key_ref = lookup_user_key(serial, flags, KEY_DEFER_PERM_CHECK);
> +       if (IS_ERR(key_ref))
> +               return NULL;
> +
> +       bkey = kmalloc(sizeof(*bkey), GFP_ATOMIC);
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
> + * 0 for the primary keyring (immutable keyring of system keys); 1 for both

Please use VERIFY_USE_PLATFORM_KEYRING
and VERIFY_USE_SECONDARY_KEYRING here instead of 0 and 1


> + * the primary and secondary keyring (where keys can be added only if they
> + * are vouched for by existing keys in those keyrings); 2 for the platform
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
> +       /* Keep in sync with defs in include/linux/verification.h. */

Here too, it's best to introduce a "MAX" value or a small inline helper
rather than this comment.

> +       if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
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

This is more of a style thing but your comment literally describes the
small function
below. Do we really need this?

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
> +       int ret;
> +
> +       ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
> +                                       &bpf_key_sig_kfunc_set);
> +       if (!ret)
> +               return 0;
> +
> +       return register_btf_kfunc_id_set(BPF_PROG_TYPE_LSM,
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

[...]
