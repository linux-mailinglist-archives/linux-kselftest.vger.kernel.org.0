Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C09B5ADDA8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Sep 2022 04:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238009AbiIFC6W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 22:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbiIFC6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 22:58:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126786BD52;
        Mon,  5 Sep 2022 19:58:18 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id a9so5370588ilh.1;
        Mon, 05 Sep 2022 19:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4x4iyOx/qVbQuH7nJfiJGEP2eqYxJVCITtuz3ZahOGo=;
        b=lQ/KQWX997iGCOqIJTfok8gUQHJNcxoGhPRj2dUh5ihpUuZ4UQaxlnEKw2FddVkFDM
         L/IdKuvxznuxkvNM1jdTwn1NGEG3HSGQXp0ur414xM/qpO/TNHEAamsezhcZPl3ZFu9W
         Y0Ar8NzKm7Ub+w9ynjfMckiwuGQIncPaQDwOwOWzcU/g8aruy+7Em8nP2bPT1i0jcVUW
         ktRvXeBUVlAhLVAYIDFgDF12JcMELmYLPzRk39iSSVl5L4JKUqg88iHTQRNjoyb+Ynil
         nOFjorQUHCnIeXaQ9HaGqDf3P/6U7O/WQ8jhwcsN1Txla+vQB4e83KNW/kGudRAvpmWr
         uPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4x4iyOx/qVbQuH7nJfiJGEP2eqYxJVCITtuz3ZahOGo=;
        b=dU7cr3i1gemKFcOMq1VWIrpBUC9SWOyjdUyDPfq97zMC2TnYyZbHwrpR1qQ65lfuZL
         7eu6ETawISVHfLC0bpCUMaJ6KUuE49PTknHbQGqKPthlEAZAk1ioR6zRLOTG8oCa8jny
         0FEE2x923FWucWGB+wjYTyrn1oCB4vvZhvc7a+38wATby+KjZm14B+IamXeOyjFRgLEo
         tH7WLv+vkSuBW17jfxAVW0UP1qyrgfzK5MlnXBFK3YASZSUzyhyk3Zr8Gbti31beGS6r
         qhTV+KNuxw+VGd3H3MtWKJyooh/lkoG1MtXNfJwwSF7QzjsUE6FMP2B8zwe06iZxQieQ
         dXsg==
X-Gm-Message-State: ACgBeo36MQp8+H1HzkWapimiA6m1Ge1Nb2nSaNDeFB3i+nnTwvrgXp5r
        Zm42Wkw9jIxCczI1IrTgLSHpvAbYiT+A1QxWk+I=
X-Google-Smtp-Source: AA6agR5aMg+qaWsjwd2wu0dFhLTJgtP4otraU5rsKzrQ2LNbsJlrEgmoSx8wVUBnNjXWp/gSOBSBa4LXzC+D9wlAwik=
X-Received: by 2002:a05:6e02:1d0b:b0:2eb:73fc:2235 with SMTP id
 i11-20020a056e021d0b00b002eb73fc2235mr15057542ila.164.1662433097391; Mon, 05
 Sep 2022 19:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com> <20220905143318.1592015-8-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220905143318.1592015-8-roberto.sassu@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 6 Sep 2022 04:57:41 +0200
Message-ID: <CAP01T77F-A7igW+vp5RhzcqzRJymO6YRvNR2cfsh+2fKNy56YA@mail.gmail.com>
Subject: Re: [PATCH v16 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        joannelkoong@gmail.com
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
> index 7a7023704ac2..8e2c026b0a58 100644
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

MIssing check for data_ptr->data == NULL before making this call? Same
for sig_ptr.

> +                                     trusted_keyring->key,
> +                                     VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> +                                     NULL);
> +}
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
