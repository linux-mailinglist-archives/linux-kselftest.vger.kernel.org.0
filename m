Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF958EE3E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiHJO0E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 10:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHJO0B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 10:26:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDF411759D
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660141559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oHQ26Wvf1D0+B6ua9zuInzugzqKwF0GdDplI8J7sX94=;
        b=PgyHFCTCIFwuA7ZWw9lWEm+AH6NrGf8LZ1aqEqC3jAYI6if6/lN+g3YeoXwN36Jr/cje/8
        0fV3oQmpsckJvWLOOIO8zyuguCtMD8cVxviM7AVq0prL2g5uc3kkh8HLdiVUArpK/MXpvH
        AKe950aF9SI6/TPKX4y3pMwkrsd83i4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-SWrQdZCxMU2WYEjmaV8Igg-1; Wed, 10 Aug 2022 10:25:58 -0400
X-MC-Unique: SWrQdZCxMU2WYEjmaV8Igg-1
Received: by mail-pf1-f200.google.com with SMTP id by13-20020a056a00400d00b0052ec5a1cd4dso6184834pfb.21
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 07:25:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oHQ26Wvf1D0+B6ua9zuInzugzqKwF0GdDplI8J7sX94=;
        b=OiDCVsc6AS/NnuaIrD4zsL85Yo5psA1+C7BDNNesO33HrENj66Lo9+SsMwTUA5xjsU
         h10BYTYNS716axnWHa1GqkBzLbK+nvHZwDCc43HtffBSQhiQQdBh4elE0y+xq424SiKL
         wt+3QbXSCLW1mmX5w5Tg8A2rWPBA2SnryzJCxJrzdIWtmwD9dLpqo2DljJhVLWAOTtLm
         3xlPVtsZWc8skX9eDPWTVpl4lr9lgdRmx2fNZRrEtdnx1Ig+do36BU8jy8bMGtlZ4eUI
         1SDG3nNzH7TX1XVySqIPvhSm3D6RBxwthshtKqTqLqJ8zWbU+FzDEnFMIAaIYcrTxpmP
         KYRw==
X-Gm-Message-State: ACgBeo3UXZG56ixl5LAuC8rrjtb182aNKi1kWKkHoN+syP+boJAxP8zL
        diQtuVvPuCdrJmqymCEqwiBe+xiZ39vFakbHtH1ACiRVPHlyTLuQQZ2XzYl3LSnol7amaCUnNld
        YL3vyvUFEdGtfZdvkpEgTuUwy4fQfCqNvAMmsYQrYXqk4
X-Received: by 2002:a17:902:f650:b0:15f:3a10:a020 with SMTP id m16-20020a170902f65000b0015f3a10a020mr27766181plg.61.1660141555752;
        Wed, 10 Aug 2022 07:25:55 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6jIsgmiVAZO+kwKtA8ssDA5oXrrYxrX9v81lo5S8jlfk0LA/n9SFWvIUSV7m6d+ret3BqnKVOPUoX5Lpegc1U=
X-Received: by 2002:a17:902:f650:b0:15f:3a10:a020 with SMTP id
 m16-20020a170902f65000b0015f3a10a020mr27766137plg.61.1660141555320; Wed, 10
 Aug 2022 07:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-2-roberto.sassu@huawei.com> <YvKRYRjJdXbAWL6Y@kernel.org>
 <c9e73d7aa51a47c585b935a41dbf1924@huawei.com>
In-Reply-To: <c9e73d7aa51a47c585b935a41dbf1924@huawei.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 10 Aug 2022 16:25:44 +0200
Message-ID: <CAO-hwJLNsV00pEcTY65TBNszCTh1DfhidK+m5NULiwtGr7GLmw@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark a
 function to be sleepable
To:     Roberto Sassu <roberto.sassu@huawei.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "paul@paul-moore.com" <paul@paul-moore.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 10, 2022 at 3:44 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
>
> > From: Jarkko Sakkinen [mailto:jarkko@kernel.org]
> > Sent: Tuesday, August 9, 2022 6:55 PM
> > On Tue, Aug 09, 2022 at 03:45:54PM +0200, Roberto Sassu wrote:
> > > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > This allows to declare a kfunc as sleepable and prevents its use in
> > > a non sleepable program.
> >
> > Nit: "Declare a kfunc as sleepable and prevent its use in a
> > non-sleepable program."
> >
> > It's missing the part *how* the patch accomplishes its goals.
>
> I will add:
>
> If an eBPF program is going to call a kfunc declared as sleepable,
> eBPF will look at the eBPF program flags. If BPF_F_SLEEPABLE is
> not set, execution of that program is denied.

All those changes are looking good to me.

Thanks a lot for keeping pushing on this patch :)

Cheers,
Benjamin

>
> Roberto
>
> > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > >  Documentation/bpf/kfuncs.rst | 6 ++++++
> > >  include/linux/btf.h          | 1 +
> > >  kernel/bpf/btf.c             | 9 +++++++++
> > >  3 files changed, 16 insertions(+)
> > >
> > > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > > index c0b7dae6dbf5..c8b21de1c772 100644
> > > --- a/Documentation/bpf/kfuncs.rst
> > > +++ b/Documentation/bpf/kfuncs.rst
> > > @@ -146,6 +146,12 @@ that operate (change some property, perform some
> > operation) on an object that
> > >  was obtained using an acquire kfunc. Such kfuncs need an unchanged pointer
> > to
> > >  ensure the integrity of the operation being performed on the expected object.
> > >
> > > +2.4.6 KF_SLEEPABLE flag
> > > +-----------------------
> > > +
> > > +The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can
> > only
> > > +be called by sleepable BPF programs (BPF_F_SLEEPABLE).
> > > +
> > >  2.5 Registering the kfuncs
> > >  --------------------------
> > >
> > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > index cdb376d53238..976cbdd2981f 100644
> > > --- a/include/linux/btf.h
> > > +++ b/include/linux/btf.h
> > > @@ -49,6 +49,7 @@
> > >   * for this case.
> > >   */
> > >  #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer
> > arguments */
> > > +#define KF_SLEEPABLE   (1 << 5) /* kfunc may sleep */
> > >
> > >  struct btf;
> > >  struct btf_member;
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 7e64447659f3..d3e4c86b8fcd 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -6175,6 +6175,7 @@ static int btf_check_func_arg_match(struct
> > bpf_verifier_env *env,
> > >  {
> > >     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> > >     bool rel = false, kptr_get = false, trusted_arg = false;
> > > +   bool sleepable = false;
> > >     struct bpf_verifier_log *log = &env->log;
> > >     u32 i, nargs, ref_id, ref_obj_id = 0;
> > >     bool is_kfunc = btf_is_kernel(btf);
> > > @@ -6212,6 +6213,7 @@ static int btf_check_func_arg_match(struct
> > bpf_verifier_env *env,
> > >             rel = kfunc_flags & KF_RELEASE;
> > >             kptr_get = kfunc_flags & KF_KPTR_GET;
> > >             trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
> > > +           sleepable = kfunc_flags & KF_SLEEPABLE;
> > >     }
> > >
> > >     /* check that BTF function arguments match actual types that the
> > > @@ -6419,6 +6421,13 @@ static int btf_check_func_arg_match(struct
> > bpf_verifier_env *env,
> > >                     func_name);
> > >             return -EINVAL;
> > >     }
> > > +
> > > +   if (sleepable && !env->prog->aux->sleepable) {
> > > +           bpf_log(log, "kernel function %s is sleepable but the program is
> > not\n",
> > > +                   func_name);
> > > +           return -EINVAL;
> > > +   }
> > > +
> > >     /* returns argument register number > 0 in case of reference release
> > kfunc */
> > >     return rel ? ref_regno : 0;
> > >  }
> > > --
> > > 2.25.1
> > >
> >
> > BR, Jarkko
>

