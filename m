Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037CF5A75F6
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 07:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiHaFuw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 01:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiHaFuq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 01:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D27246DA5
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661925031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/1Gc4iplVnTB0apFsZw2aQwgByP/oAWmtW4VUz4Ez08=;
        b=Quq7RvqdQMHCMflIm6IMs0D3COnf1ddPa5V2tee/FmyYzwDR2/zd2G/YRgHNOeIl/31vJO
        Z5lNlUH940wHX1QTAsrEAp5SKq5jfM1oshRbvT2rTJbWO2bwwH4LFLHoz2YxoZwGRrtU1/
        XCdEBZ4UB41lg0IdwhSb61X7sByWqm4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-317-nrrkMceTOxOpCS5JZBgBDw-1; Wed, 31 Aug 2022 01:50:30 -0400
X-MC-Unique: nrrkMceTOxOpCS5JZBgBDw-1
Received: by mail-pg1-f198.google.com with SMTP id 136-20020a63008e000000b0042d707c94fbso2195550pga.9
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Aug 2022 22:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=/1Gc4iplVnTB0apFsZw2aQwgByP/oAWmtW4VUz4Ez08=;
        b=0f27YOFP0TVwy8LpqTmLhTA6KeQLwTCGT5tptXnDB+0268afu4xqiYQqQpo6WSNcl0
         +5YiGuaCMEioL1BYu/q3vyKmdDKs71+jBVGnMfCaY226r7TjiiYFSVWDQx46NFrS0mEX
         38bVLq6ccRccMsYcDzzPIILwy7o/0dOnFxZ2jRDdHUFtv/e0lqegkUn6dLIpUd2bzySx
         nhKVkbsytDOdX6NO0v/he6nnm34H3wdlfBJS+xIJprs9t9Fbs90/SPAog2y2vu3S25uO
         vSfX+mi/LtFd3ASs1oUooOOx+lqZJ0EbCs2jg6+1eZeh0h2Ay0bkMDhI/Hv80040QvSY
         lBJw==
X-Gm-Message-State: ACgBeo3L7UQrSfKlFwzDI+rp3tmNI5D6T3jZF2V2pW0z6maWicAEsUcZ
        tRtC9K7oNs9QkOJ7fvvhse14mvrbNKOa5/uzcTchIIMKyuRACWrhp4yKK607sj1Cu2Xp08HQUlR
        ikXbpHj9Lib8sJ0qLplsaIc2wx+LQPgOjyreb2pAQC2rd
X-Received: by 2002:a17:903:120c:b0:172:728a:3b24 with SMTP id l12-20020a170903120c00b00172728a3b24mr24262462plh.61.1661925029499;
        Tue, 30 Aug 2022 22:50:29 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7SgL/109emdEPXfdUzoIlo6EvJSY6WnewAiDsO9+9TdY7lKIFYehyZyNgAd6etIldUOqhUKRlJu9/Xt4eCLpQ=
X-Received: by 2002:a17:903:120c:b0:172:728a:3b24 with SMTP id
 l12-20020a170903120c00b00172728a3b24mr24262444plh.61.1661925029212; Tue, 30
 Aug 2022 22:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220824134055.1328882-1-benjamin.tissoires@redhat.com>
 <20220824134055.1328882-5-benjamin.tissoires@redhat.com> <CAP01T74ZmvoYtG=8wiDm0_X3hrMN8s55CkSzurphDrZ3b86UZQ@mail.gmail.com>
In-Reply-To: <CAP01T74ZmvoYtG=8wiDm0_X3hrMN8s55CkSzurphDrZ3b86UZQ@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 31 Aug 2022 07:50:18 +0200
Message-ID: <CAO-hwJ+Xk=93oCXTp7vWVx_oXmx5=PPwWoAgahLSZBTcD9XQmg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/23] bpf/verifier: allow kfunc to return an
 allocated mem
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Joe Stringer <joe@cilium.io>, Jonathan Corbet <corbet@lwn.net>,
        Tero Kristo <tero.kristo@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 26, 2022 at 3:25 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 24 Aug 2022 at 15:41, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > For drivers (outside of network), the incoming data is not statically
> > defined in a struct. Most of the time the data buffer is kzalloc-ed
> > and thus we can not rely on eBPF and BTF to explore the data.
> >
> > This commit allows to return an arbitrary memory, previously allocated by
> > the driver.
> > An interesting extra point is that the kfunc can mark the exported
> > memory region as read only or read/write.
> >
> > So, when a kfunc is not returning a pointer to a struct but to a plain
> > type, we can consider it is a valid allocated memory assuming that:
> > - one of the arguments is either called rdonly_buf_size or
> >   rdwr_buf_size
> > - and this argument is a const from the caller point of view
> >
> > We can then use this parameter as the size of the allocated memory.
> >
> > The memory is either read-only or read-write based on the name
> > of the size parameter.
> >
> > Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> >
> > ---
> >
> > changes in v9:
> > - updated to match upstream (replaced kfunc_flag by a field in
> >   kfunc_meta)
> >
> > no changes in v8
> >
> > changes in v7:
> > - ensures btf_type_is_struct_ptr() checks for a ptr first
> >   (squashed from next commit)
> > - remove multiple_ref_obj_id need
> > - use btf_type_skip_modifiers instead of manually doing it in
> >   btf_type_is_struct_ptr()
> > - s/strncmp/strcmp/ in btf_is_kfunc_arg_mem_size()
> > - check for tnum_is_const when retrieving the size value
> > - have only one check for "Ensure only one argument is referenced
> >   PTR_TO_BTF_ID"
> > - add some more context to the commit message
> >
> > changes in v6:
> > - code review from Kartikeya:
> >   - remove comment change that had no reasons to be
> >   - remove handling of PTR_TO_MEM with kfunc releases
> >   - introduce struct bpf_kfunc_arg_meta
> >   - do rdonly/rdwr_buf_size check in btf_check_kfunc_arg_match
> >   - reverted most of the changes in verifier.c
> >   - make sure kfunc acquire is using a struct pointer, not just a plain
> >     pointer
> >   - also forward ref_obj_id to PTR_TO_MEM in kfunc to not use after free
> >     the allocated memory
> >
> > changes in v5:
> > - updated PTR_TO_MEM comment in btf.c to match upstream
> > - make it read-only or read-write based on the name of size
> >
> > new in v4
> >
> > change btf.h
> >
> > fix allow kfunc to return an allocated mem
> > ---
> >  include/linux/bpf.h   |  9 +++-
> >  include/linux/btf.h   | 10 +++++
> >  kernel/bpf/btf.c      | 98 ++++++++++++++++++++++++++++++++++---------
> >  kernel/bpf/verifier.c | 43 +++++++++++++------
> >  4 files changed, 128 insertions(+), 32 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 39bd36359c1e..90dd218e0199 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1932,13 +1932,20 @@ int btf_distill_func_proto(struct bpf_verifier_log *log,
> >                            const char *func_name,
> >                            struct btf_func_model *m);
> > [...]
> > +
> >  static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                                     const struct btf *btf, u32 func_id,
> >                                     struct bpf_reg_state *regs,
> >                                     bool ptr_to_mem_ok,
> > -                                   u32 kfunc_flags)
> > +                                   struct bpf_kfunc_arg_meta *kfunc_meta)
> >  {
> >         enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> >         bool rel = false, kptr_get = false, trusted_arg = false;
> > @@ -6207,12 +6232,12 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                 return -EINVAL;
> >         }
> >
> > -       if (is_kfunc) {
> > +       if (is_kfunc && kfunc_meta) {
> >                 /* Only kfunc can be release func */
> > -               rel = kfunc_flags & KF_RELEASE;
> > -               kptr_get = kfunc_flags & KF_KPTR_GET;
> > -               trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
> > -               sleepable = kfunc_flags & KF_SLEEPABLE;
> > +               rel = kfunc_meta->flags & KF_RELEASE;
> > +               kptr_get = kfunc_meta->flags & KF_KPTR_GET;
> > +               trusted_arg = kfunc_meta->flags & KF_TRUSTED_ARGS;
> > +               sleepable = kfunc_meta->flags & KF_SLEEPABLE;
> >         }
> >
> >         /* check that BTF function arguments match actual types that the
> > @@ -6225,6 +6250,35 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >
> >                 t = btf_type_skip_modifiers(btf, args[i].type, NULL);
> >                 if (btf_type_is_scalar(t)) {
> > +                       if (is_kfunc && kfunc_meta) {
> > +                               bool is_buf_size = false;
> > +
> > +                               /* check for any const scalar parameter of name "rdonly_buf_size"
> > +                                * or "rdwr_buf_size"
> > +                                */
> > +                               if (btf_is_kfunc_arg_mem_size(btf, &args[i], reg,
> > +                                                             "rdonly_buf_size")) {
> > +                                       kfunc_meta->r0_rdonly = true;
> > +                                       is_buf_size = true;
> > +                               } else if (btf_is_kfunc_arg_mem_size(btf, &args[i], reg,
> > +                                                                    "rdwr_buf_size"))
> > +                                       is_buf_size = true;
> > +
> > +                               if (is_buf_size) {
> > +                                       if (kfunc_meta->r0_size) {
> > +                                               bpf_log(log, "2 or more rdonly/rdwr_buf_size parameters for kfunc");
> > +                                               return -EINVAL;
> > +                                       }
> > +
> > +                                       if (!tnum_is_const(reg->var_off)) {
> > +                                               bpf_log(log, "R%d is not a const\n", regno);
> > +                                               return -EINVAL;
> > +                                       }
> > +
> > +                                       kfunc_meta->r0_size = reg->var_off.value;
>
> Sorry for not pointing it out before, but you will need a call to
> mark_chain_precision here after this, since the value of the scalar is
> being used to decide the size of the returned pointer.

No worries.

I do however have a couple of questions (I have strictly no idea what
mark_chain_precision does):
- which register number should I call mark_chain_precision() as
parameter? r0 or regno (the one with the constant)?
- mark_chain_precision() is declared static in verifier.c. Should I
export it so btf.c can have access to it, or can I delay the call to
mark_chain_precision() in verifier.c when I set
regs[BPF_REG_0].mem_size?


>
> > +                               }
> > +                       }
> > +
> >                         if (reg->type == SCALAR_VALUE)
> >                                 continue;
> >                         bpf_log(log, "R%d is not a scalar\n", regno);
> > @@ -6255,6 +6309,19 @@ static int btf_check_func_arg_match(struct bpf_verifier_env *env,
> >                 if (ret < 0)
> >                         return ret;
> >
> > +               if (is_kfunc && reg->type == PTR_TO_BTF_ID) {
>
> I think you can drop this extra check 'reg->type == PTR_TO_BTF_ID),
> this condition of only one ref_obj_id should hold regardless of the
> type.

Ack.

Cheers,
Benjamin

>
> > [...]
>

