Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E6F5B4E84
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Sep 2022 13:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiIKLlF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 11 Sep 2022 07:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiIKLlD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Sep 2022 07:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8CF386B1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Sep 2022 04:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AE2260FD1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Sep 2022 11:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5FCC433C1
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Sep 2022 11:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662896460;
        bh=mfC/DzcLdVbiyBOdkdFzHVkQuK8qpwvJhFQkQNsjoBc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dO9a1bCjZWZa+j3+YvkaHc7afn0eZ9xJRUUkbpjJwNa/BYKyox7+5L8Yifx9OJPm9
         xMLqBGhuNZ+T31UE2LZrDlYWarc+dQCNZSHWZad6WxBTvSBYyYtZ0RK3f7KOeCDUSW
         dlg5T4Shm1GiDFVY9tJY12iLzzPf/o0ThJBjK5PE7R2kMOvLxGDCHCs9IXsF5pjzNQ
         P/R2OdrYWxNWCDC/URJu5xhtP/D2zLgnoV4xggnx8yVQeLADKs052ntgWzXyw6BZag
         g+I0CSxGWEleFvbhU93i0yzauY4cAUAveQQI95Y0peM1f0q0ClLTAFlZ+YDCD5WhLk
         PbF8/UPo+gLQQ==
Received: by mail-ej1-f47.google.com with SMTP id l14so14120586eja.7
        for <linux-kselftest@vger.kernel.org>; Sun, 11 Sep 2022 04:41:00 -0700 (PDT)
X-Gm-Message-State: ACgBeo2JmUW2Eo2Rdj2OhdsD+/iW9BIZCUqg6Ir6bUz3Bt1jSyESxvHf
        XoIDCwfwiV09r2TedSV7aASY8W7ahBz4WoCaiM7NdA==
X-Google-Smtp-Source: AA6agR7gs0xxqnhzhdmlHMESnGLHahKK3mbikc37UgqaUcsvF6ftFAuRZVzQ4u53rO5Up2H7UPABpxSJ5Mh/VrkiE8c=
X-Received: by 2002:aa7:cd14:0:b0:44e:2335:fb90 with SMTP id
 b20-20020aa7cd14000000b0044e2335fb90mr18029880edw.152.1662896448217; Sun, 11
 Sep 2022 04:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com> <20220909120736.1027040-8-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220909120736.1027040-8-roberto.sassu@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Sun, 11 Sep 2022 13:40:37 +0200
X-Gmail-Original-Message-ID: <CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=0KLwAj1Gc0SA@mail.gmail.com>
Message-ID: <CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=0KLwAj1Gc0SA@mail.gmail.com>
Subject: Re: [PATCH v17 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, dhowells@redhat.com,
        jarkko@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        shuah@kernel.org, bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 9, 2022 at 2:09 PM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
> the ability to check the validity of a signature against supplied data, by
> using user-provided or system-provided keys as trust anchor.
>
> The new kfunc makes it possible to enforce mandatory policies, as eBPF
> programs might be allowed to make security decisions only based on data
> sources the system administrator approves.
>
> The caller should provide the data to be verified and the signature as eBPF
> dynamic pointers (to minimize the number of parameters) and a bpf_key
> structure containing a reference to the keyring with keys trusted for
> signature verification, obtained from bpf_lookup_user_key() or
> bpf_lookup_system_key().
>
> For bpf_key structures obtained from the former lookup function,
> bpf_verify_pkcs7_signature() completes the permission check deferred by
> that function by calling key_validate(). key_task_permission() is already
> called by the PKCS#7 code.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: KP Singh <kpsingh@kernel.org>
> ---
>  kernel/trace/bpf_trace.c | 45 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index ab183dbaa8d1..9df53c40cffd 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
>         kfree(bkey);
>  }
>
> +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> +/**
> + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> + * @data_ptr: data to verify
> + * @sig_ptr: signature of the data
> + * @trusted_keyring: keyring with keys trusted for signature verification
> + *
> + * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
> + * with keys in a keyring referenced by *trusted_keyring*.
> + *
> + * Return: 0 on success, a negative value on error.
> + */
> +int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
> +                              struct bpf_dynptr_kern *sig_ptr,
> +                              struct bpf_key *trusted_keyring)
> +{
> +       int ret;
> +
> +       if (trusted_keyring->has_ref) {
> +               /*
> +                * Do the permission check deferred in bpf_lookup_user_key().
> +                * See bpf_lookup_user_key() for more details.
> +                *
> +                * A call to key_task_permission() here would be redundant, as
> +                * it is already done by keyring_search() called by
> +                * find_asymmetric_key().
> +                */
> +               ret = key_validate(trusted_keyring->key);
> +               if (ret < 0)
> +                       return ret;
> +       }
> +
> +       return verify_pkcs7_signature(data_ptr->data,
> +                                     bpf_dynptr_get_size(data_ptr),
> +                                     sig_ptr->data,
> +                                     bpf_dynptr_get_size(sig_ptr),
> +                                     trusted_keyring->key,
> +                                     VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> +                                     NULL);
> +}

This seems to work if the data that needs to be verified
and the signature is allocated onto the map.

For BPF program signing, the signature will be void * pointer (and length)
in a struct in the kernel

+++ b/include/uapi/linux/bpf.h
@@ -1383,6 +1383,8 @@ union bpf_attr {
                __aligned_u64   fd_array;       /* array of FDs */
                __aligned_u64   core_relos;
                __u32           core_relo_rec_size; /* sizeof(struct
bpf_core_relo) */
+               __aligned_u64   signature;
+               __u32           signature_size;
        };

Something like this in the bpf_prog_aux struct which is passed to
security_bpf_prog_alloc.

Now creating a dynptr to use with this kfunc does not work:

   bpf_dynptr_from_mem(aux->signature, aux->signature_size, 0, &sig_ptr);

So one has to copy kernel data into a map and then create dynptrs.
Would you be able to update
the dynptr logic to handle this case too? (follow up is okay too).

- KP


> +#endif /* CONFIG_SYSTEM_DATA_VERIFICATION */
> +
>  __diag_pop();
>
>  BTF_SET8_START(key_sig_kfunc_set)
>  BTF_ID_FLAGS(func, bpf_lookup_user_key, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_lookup_system_key, KF_ACQUIRE | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_key_put, KF_RELEASE)
> +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> +BTF_ID_FLAGS(func, bpf_verify_pkcs7_signature, KF_SLEEPABLE)
> +#endif
>  BTF_SET8_END(key_sig_kfunc_set)
>
>  static const struct btf_kfunc_id_set bpf_key_sig_kfunc_set = {
> --
> 2.25.1
>
