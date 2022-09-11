Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F45B5134
	for <lists+linux-kselftest@lfdr.de>; Sun, 11 Sep 2022 23:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbiIKVIq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 11 Sep 2022 17:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIKVIp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 11 Sep 2022 17:08:45 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CDD25C5A;
        Sun, 11 Sep 2022 14:08:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id d16so3627433ils.8;
        Sun, 11 Sep 2022 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dfaSYpOE7cAlOB6lgtNwix6VkGo4PGRDDhlfC3pQXWo=;
        b=AY+k6a14ANY3j3WHkVqabrzmv706Harc72VI8vN2U1iSDb2xmFmsWTeAMgf9EPOr/Y
         qSxPhKKd/qVF2g85ofZfa7HVvdCL+Z0qpaXYHfs6dOppeL5xeYM5FYwlHlOBVCzQKy/s
         IjtrvpJm4ytCo2B/OBUFBejsYwjrDQN8MVTBSYIsti6B2jHp0D9HotWkqsGd230MxWup
         BGeqiKGV/WPIRdnpuD/Js7ckW0MPzZZ2V6QEqHWUyq94JprSVvd0oK3y7arQSddCoGQ0
         UVETagiQTnshmmGjzQP4zc90DYOMYmDJKJP9uHrZoz2Pm6tNkKbFbmSD/ESK7Xir0frn
         PJAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dfaSYpOE7cAlOB6lgtNwix6VkGo4PGRDDhlfC3pQXWo=;
        b=yltU7UiczH0W4QAPyFEjJEcf9QnlQEG1ajcuera3Tt20w2psXyxQf60km1lNXdDncO
         kVGBADnoY0mkm0u1YQsihGwzZaazPc80boukJ5WXFWuj+xnp0aqtG25iIRc64LI9ZG2C
         wahZGanE4NJ5eP4eNZ2KMFQSjacTlpAR9s38W0tnGtKpF3PlgHsovLO5JH6NVNUW0CB9
         QQlZxfw1aBkZaLu7pZ9tGy90A4MbLytAMbBKnxdWWykrs/KPcv7IkQJDY3Ll/1tl5aoE
         dUkapr6Px6JAq9SUGagz868ZVeQhW7AVR5IWCUHwEeGeqtHzv2qA/VbKaquVJGIJyNoJ
         sWPA==
X-Gm-Message-State: ACgBeo1MJcI77LNAdC/TRdIOO+5uFe4XtVusK1tW2Ru7TQMQZtGBpjz5
        FkBIK+AVv8DqRqjWVCNZu10b2O/YRY1h/gN9fP4=
X-Google-Smtp-Source: AA6agR6i0U3QWYAIfs8bjdq0ijlQt0nrG1HljX2cZF6u26b0IV0RLj1n96MwMPS4EI/xncvz9L2K7LJ8Ws3Hx89kENI=
X-Received: by 2002:a92:cbcf:0:b0:2f3:b515:92d with SMTP id
 s15-20020a92cbcf000000b002f3b515092dmr2755976ilq.91.1662930522984; Sun, 11
 Sep 2022 14:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220909120736.1027040-1-roberto.sassu@huaweicloud.com>
 <20220909120736.1027040-8-roberto.sassu@huaweicloud.com> <CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=0KLwAj1Gc0SA@mail.gmail.com>
In-Reply-To: <CACYkzJ6xSk_DHO+3JoCYpGrXjFkk9v-LOSWW0=0KLwAj1Gc0SA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Sun, 11 Sep 2022 23:08:05 +0200
Message-ID: <CAP01T77d-79-1nGUC=i4mgExY+iKs0j2iiB5DitT_cTj7oXYHQ@mail.gmail.com>
Subject: Re: [PATCH v17 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     KP Singh <kpsingh@kernel.org>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        mykolal@fb.com, dhowells@redhat.com, jarkko@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, shuah@kernel.org,
        bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
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

On Sun, 11 Sept 2022 at 13:41, KP Singh <kpsingh@kernel.org> wrote:
>
> On Fri, Sep 9, 2022 at 2:09 PM Roberto Sassu
> <roberto.sassu@huaweicloud.com> wrote:
> >
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security modules
> > the ability to check the validity of a signature against supplied data, by
> > using user-provided or system-provided keys as trust anchor.
> >
> > The new kfunc makes it possible to enforce mandatory policies, as eBPF
> > programs might be allowed to make security decisions only based on data
> > sources the system administrator approves.
> >
> > The caller should provide the data to be verified and the signature as eBPF
> > dynamic pointers (to minimize the number of parameters) and a bpf_key
> > structure containing a reference to the keyring with keys trusted for
> > signature verification, obtained from bpf_lookup_user_key() or
> > bpf_lookup_system_key().
> >
> > For bpf_key structures obtained from the former lookup function,
> > bpf_verify_pkcs7_signature() completes the permission check deferred by
> > that function by calling key_validate(). key_task_permission() is already
> > called by the PKCS#7 code.
> >
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > Acked-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  kernel/trace/bpf_trace.c | 45 ++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index ab183dbaa8d1..9df53c40cffd 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
> >         kfree(bkey);
> >  }
> >
> > +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > +/**
> > + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> > + * @data_ptr: data to verify
> > + * @sig_ptr: signature of the data
> > + * @trusted_keyring: keyring with keys trusted for signature verification
> > + *
> > + * Verify the PKCS#7 signature *sig_ptr* against the supplied *data_ptr*
> > + * with keys in a keyring referenced by *trusted_keyring*.
> > + *
> > + * Return: 0 on success, a negative value on error.
> > + */
> > +int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
> > +                              struct bpf_dynptr_kern *sig_ptr,
> > +                              struct bpf_key *trusted_keyring)
> > +{
> > +       int ret;
> > +
> > +       if (trusted_keyring->has_ref) {
> > +               /*
> > +                * Do the permission check deferred in bpf_lookup_user_key().
> > +                * See bpf_lookup_user_key() for more details.
> > +                *
> > +                * A call to key_task_permission() here would be redundant, as
> > +                * it is already done by keyring_search() called by
> > +                * find_asymmetric_key().
> > +                */
> > +               ret = key_validate(trusted_keyring->key);
> > +               if (ret < 0)
> > +                       return ret;
> > +       }
> > +
> > +       return verify_pkcs7_signature(data_ptr->data,
> > +                                     bpf_dynptr_get_size(data_ptr),
> > +                                     sig_ptr->data,
> > +                                     bpf_dynptr_get_size(sig_ptr),
> > +                                     trusted_keyring->key,
> > +                                     VERIFYING_UNSPECIFIED_SIGNATURE, NULL,
> > +                                     NULL);
> > +}
>
> This seems to work if the data that needs to be verified
> and the signature is allocated onto the map.
>
> For BPF program signing, the signature will be void * pointer (and length)
> in a struct in the kernel
>
> +++ b/include/uapi/linux/bpf.h
> @@ -1383,6 +1383,8 @@ union bpf_attr {
>                 __aligned_u64   fd_array;       /* array of FDs */
>                 __aligned_u64   core_relos;
>                 __u32           core_relo_rec_size; /* sizeof(struct
> bpf_core_relo) */
> +               __aligned_u64   signature;
> +               __u32           signature_size;
>         };
>
> Something like this in the bpf_prog_aux struct which is passed to
> security_bpf_prog_alloc.
>
> Now creating a dynptr to use with this kfunc does not work:
>
>    bpf_dynptr_from_mem(aux->signature, aux->signature_size, 0, &sig_ptr);
>
> So one has to copy kernel data into a map and then create dynptrs.
> Would you be able to update
> the dynptr logic to handle this case too? (follow up is okay too).
>

ISTM it needs the feature first before it can be added.
To make it work like map_val, value_size(which is a constant) to pass
to bpf_dynptr_from_mem,
verifier will have to mark load of aux->signature as PTR_TO_MEM with the known
constant size, and then mark_reg_known for scalar reg for aux->signature_size.
Since we need to know that 0 <= r2 <= r1.mem_size.
This would require some work on the btf_struct_access handling.

It cannot be made to work in the general case of void * and len.
There might also be other better options (like kernel itself preparing
read only bpf_dynptr struct in bpf_prog_aux for the signature) so you
can pass its address directly to the kfunc.
