Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E055AF9DB
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Sep 2022 04:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIGC2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Sep 2022 22:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiIGC2k (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Sep 2022 22:28:40 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE00C90802;
        Tue,  6 Sep 2022 19:28:37 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id v15so6914913iln.6;
        Tue, 06 Sep 2022 19:28:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6adJ3vFxu7LJgVGtWumUtBEFtalw2Gru7dwbkWzIto0=;
        b=Qzes80q1nY3NMTB/u4RR9qRposPgyIWEglwe9n8azaRLBgllpg11dzioo6lHb3SSWP
         F8YNlr0AikuyTVa9O819Rg/M6iTu9c/OQHv7W/Exf6W01JPK4XmoD9TQyTC7yVCUcu7c
         r0LjwIYwgVN17yVpDkSVGtd7JNkZ0CkGakzS2ReCWF9HcBOH+OYnUz0Banqdk1xtbdli
         cUfd795MsTkTiz+16Iue5opV8OSPgxuE8n5PMh8OqSG3vaB56THP6jTBQLrDz/J+3gE2
         nTn+DPorWFSDFWslz3xDaVFZvbY8ywySWMEr8HOD5EZ+osXBfLJ3z3WInBtlcq95+uJB
         k1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6adJ3vFxu7LJgVGtWumUtBEFtalw2Gru7dwbkWzIto0=;
        b=54uhIh1vA1d3RPyxLLCyv16p6V1n97QMEdPljj8Qz/4FAyiyHdfjuOrpwX/jgLFxA9
         7DAcbsjHQ1QcG65dK+FfCDaowOMIwIw3Q+82UNEv1dcKTYlDUOWmpys00tI1624jgd63
         u7ZU/eUjx2RkcCX8jXzrVF3Zr7OTXgvw0ZC5Jvb4Ph+GZKKONCCGEvQsWZACGRZyI/9x
         CAg9WdUWWR56hzKL6IrJXn3HcH3QmhlWjpjx1pOXwoqXPW6potlXQzo8n2TP0Jvjy7nC
         olBadDkdE6lubi42v9G7s4kG4PdkqrDZNdLp9lpKb59bako5OZDO4EmMRIaPVK5pgTbC
         QOqw==
X-Gm-Message-State: ACgBeo2kzyibkUDF12/pujOqs1ZvPRHM6KmJREQy2bq3Y2cVqMhw02Pd
        H6WWaebkQyASx4X5s6pMekueKMGvu0WRRRTNB2Q=
X-Google-Smtp-Source: AA6agR5GHMpNuon9uP5D/DsqmVpozOs1KIkPUdiWqptV+F5uPCHPCS2OpvNCpBPI6O64E6+NF/6Y+LZVPqKdfFOe1CM=
X-Received: by 2002:a05:6e02:190a:b0:2ee:9e75:ae4b with SMTP id
 w10-20020a056e02190a00b002ee9e75ae4bmr738115ilu.219.1662517717158; Tue, 06
 Sep 2022 19:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220905143318.1592015-1-roberto.sassu@huaweicloud.com>
 <20220905143318.1592015-8-roberto.sassu@huaweicloud.com> <CAP01T77F-A7igW+vp5RhzcqzRJymO6YRvNR2cfsh+2fKNy56YA@mail.gmail.com>
 <3d32decb1fda80e261d9ed08decfdca45614c4af.camel@huaweicloud.com>
In-Reply-To: <3d32decb1fda80e261d9ed08decfdca45614c4af.camel@huaweicloud.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 7 Sep 2022 04:28:00 +0200
Message-ID: <CAP01T76csO9pdL=KLU4s7M__GnEifmKEB0pb7genw3UN8tA=FQ@mail.gmail.com>
Subject: Re: [PATCH v16 07/12] bpf: Add bpf_verify_pkcs7_signature() kfunc
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     joannelkoong@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
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

On Tue, 6 Sept 2022 at 10:08, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2022-09-06 at 04:57 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 5 Sept 2022 at 16:35, Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Add the bpf_verify_pkcs7_signature() kfunc, to give eBPF security
> > > modules
> > > the ability to check the validity of a signature against supplied
> > > data, by
> > > using user-provided or system-provided keys as trust anchor.
> > >
> > > The new kfunc makes it possible to enforce mandatory policies, as
> > > eBPF
> > > programs might be allowed to make security decisions only based on
> > > data
> > > sources the system administrator approves.
> > >
> > > The caller should provide the data to be verified and the signature
> > > as eBPF
> > > dynamic pointers (to minimize the number of parameters) and a
> > > bpf_key
> > > structure containing a reference to the keyring with keys trusted
> > > for
> > > signature verification, obtained from bpf_lookup_user_key() or
> > > bpf_lookup_system_key().
> > >
> > > For bpf_key structures obtained from the former lookup function,
> > > bpf_verify_pkcs7_signature() completes the permission check
> > > deferred by
> > > that function by calling key_validate(). key_task_permission() is
> > > already
> > > called by the PKCS#7 code.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Acked-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  kernel/trace/bpf_trace.c | 45
> > > ++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 45 insertions(+)
> > >
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 7a7023704ac2..8e2c026b0a58 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -1294,12 +1294,57 @@ void bpf_key_put(struct bpf_key *bkey)
> > >         kfree(bkey);
> > >  }
> > >
> > > +#ifdef CONFIG_SYSTEM_DATA_VERIFICATION
> > > +/**
> > > + * bpf_verify_pkcs7_signature - verify a PKCS#7 signature
> > > + * @data_ptr: data to verify
> > > + * @sig_ptr: signature of the data
> > > + * @trusted_keyring: keyring with keys trusted for signature
> > > verification
> > > + *
> > > + * Verify the PKCS#7 signature *sig_ptr* against the supplied
> > > *data_ptr*
> > > + * with keys in a keyring referenced by *trusted_keyring*.
> > > + *
> > > + * Return: 0 on success, a negative value on error.
> > > + */
> > > +int bpf_verify_pkcs7_signature(struct bpf_dynptr_kern *data_ptr,
> > > +                              struct bpf_dynptr_kern *sig_ptr,
> > > +                              struct bpf_key *trusted_keyring)
> > > +{
> > > +       int ret;
> > > +
> > > +       if (trusted_keyring->has_ref) {
> > > +               /*
> > > +                * Do the permission check deferred in
> > > bpf_lookup_user_key().
> > > +                * See bpf_lookup_user_key() for more details.
> > > +                *
> > > +                * A call to key_task_permission() here would be
> > > redundant, as
> > > +                * it is already done by keyring_search() called by
> > > +                * find_asymmetric_key().
> > > +                */
> > > +               ret = key_validate(trusted_keyring->key);
> > > +               if (ret < 0)
> > > +                       return ret;
> > > +       }
> > > +
> > > +       return verify_pkcs7_signature(data_ptr->data,
> > > +                                     bpf_dynptr_get_size(data_ptr)
> > > ,
> > > +                                     sig_ptr->data,
> > > +                                     bpf_dynptr_get_size(sig_ptr),
> >
> > MIssing check for data_ptr->data == NULL before making this call?
> > Same
> > for sig_ptr.
>
> Patch 3 requires the dynptrs to be initialized. Isn't enough?
>

No, it seems even initialized dynptr can be NULL at runtime. Look at
both ringbuf_submit_dynptr and ringbuf_discard_dynptr.
The verifier won't know after ringbuf_reserve_dynptr whether it set it
to NULL or some valid pointer.

dynptr_init is basically that stack slot is now STACK_DYNPTR, it says
nothing more about the dynptr.

As far as testing this goes, you can pass invalid parameters to
ringbuf_reserve_dynptr to have it set to NULL, then make sure your
helper returns an error at runtime for it.

> Thanks
>
> Roberto
>
