Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C894758EEE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Aug 2022 16:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbiHJO6t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 10:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbiHJO6s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 10:58:48 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA2753B2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 07:58:47 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1121682wmq.3
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BqfACkhwAWP9NRXH+qghT2ZCWYZmFePzRNh6qpDv98Y=;
        b=nHP8P6YcWU8257oudlhd8RfKMaaMHLA4pfv48irGmWc0Uu4/ML7Zx6fBtx6ZumQIMp
         i1Shj79/kbTs3nRmRmfa/uhMQA3oyLWWvzCCZG/ax0n+Y+2/BDoTQymVclDr3OdWyeHi
         NT0gczx4C6PJwJkY38KiYweLeShEu7SSrnkxn6pr3xj/DC2WHncuNuXfyMRA7dO2Zipv
         Bzu+n50FX3Y+AiY1NbgX2tCcN7d1UloZLDBayfQ/8HsBlkLnnNkyvK5J/p7JfclmIYgY
         7MUoBsBcnU8NYdVfMNrsQdYCYJZxVBUHV7x/9r6O+HSoAZVbGoAnQVQodVu9FJPNcwGD
         V7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BqfACkhwAWP9NRXH+qghT2ZCWYZmFePzRNh6qpDv98Y=;
        b=a6LY3UH87nqSf3SsJemWcyXmubGJhDir1yfKl4BfFXe7FXiSWd2rRAcVrh6zX+NIBu
         WE+OTD62lF8B/FrNZeaWOr7ps5ZDVzTKiP8ckVu7B6HrFOTYiZFs7yuMO1DfFKnYKxeh
         eO8hkyBjJy0ZoD58jC0Yk4YG7PmU9DCO7tzYOWn2t6l5MvDuMVUzxp9fJofu5MZRGSVC
         gpdJ2MllSpuMeynFd+7sO+mAxuNIYQ1e4Kszu2T2nqlgvDJ5exLBRRus/IXzBDNKlkmr
         ZwxZ31EX+gz5ImsJUKA9hYdmFLElMbJd0HarnmzXjvt8t82wixhxlnGzpld6/UDQHqnR
         FH0Q==
X-Gm-Message-State: ACgBeo1PDNXv//YkQWHWxJYqEMgJh08lSaqq9eaZqX0A9txHoB2ZdThm
        2E595QaGnlF9Il23VbQ0uDOmQi6DLz1cWB9VV83K0A==
X-Google-Smtp-Source: AA6agR5WuP6xwJAiTVFsRVVFH5xgiWOKm009pwYL5WdGG1ScSz7ubiU7aJojf133NxPrFFrNUdCIM3mcnruLRy+t/5g=
X-Received: by 2002:a05:600c:1e05:b0:3a5:b441:e9c with SMTP id
 ay5-20020a05600c1e0500b003a5b4410e9cmr2058339wmb.24.1660143525421; Wed, 10
 Aug 2022 07:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220809134603.1769279-1-roberto.sassu@huawei.com>
 <20220809134603.1769279-2-roberto.sassu@huawei.com> <YvKRYRjJdXbAWL6Y@kernel.org>
 <c9e73d7aa51a47c585b935a41dbf1924@huawei.com> <CAO-hwJLNsV00pEcTY65TBNszCTh1DfhidK+m5NULiwtGr7GLmw@mail.gmail.com>
In-Reply-To: <CAO-hwJLNsV00pEcTY65TBNszCTh1DfhidK+m5NULiwtGr7GLmw@mail.gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 10 Aug 2022 07:58:09 -0700
Message-ID: <CAJD7tkbcLU11u3w4DhqnUbbUE_QW60fBLoZngWTXHe9qTbonNw@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] btf: Add a new kfunc flag which allows to mark a
 function to be sleepable
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Aug 10, 2022 at 7:26 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> On Wed, Aug 10, 2022 at 3:44 PM Roberto Sassu <roberto.sassu@huawei.com> wrote:
> >
> > > From: Jarkko Sakkinen [mailto:jarkko@kernel.org]
> > > Sent: Tuesday, August 9, 2022 6:55 PM
> > > On Tue, Aug 09, 2022 at 03:45:54PM +0200, Roberto Sassu wrote:
> > > > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > >
> > > > This allows to declare a kfunc as sleepable and prevents its use in
> > > > a non sleepable program.
> > >
> > > Nit: "Declare a kfunc as sleepable and prevent its use in a
> > > non-sleepable program."
> > >
> > > It's missing the part *how* the patch accomplishes its goals.
> >
> > I will add:
> >
> > If an eBPF program is going to call a kfunc declared as sleepable,
> > eBPF will look at the eBPF program flags. If BPF_F_SLEEPABLE is
> > not set, execution of that program is denied.
>
> All those changes are looking good to me.
>
> Thanks a lot for keeping pushing on this patch :)

Multiple series other than the HID one started resending your patch
once you dropped it, it's obviously needed :) Thanks for sending it in
the first place :)

>
> Cheers,
> Benjamin
>
> >
> > Roberto
> >
> > > > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > > > Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
> > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > > >  Documentation/bpf/kfuncs.rst | 6 ++++++
> > > >  include/linux/btf.h          | 1 +
> > > >  kernel/bpf/btf.c             | 9 +++++++++
> > > >  3 files changed, 16 insertions(+)
> > > >
> > > > diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> > > > index c0b7dae6dbf5..c8b21de1c772 100644
> > > > --- a/Documentation/bpf/kfuncs.rst
> > > > +++ b/Documentation/bpf/kfuncs.rst
> > > > @@ -146,6 +146,12 @@ that operate (change some property, perform some
> > > operation) on an object that
> > > >  was obtained using an acquire kfunc. Such kfuncs need an unchanged pointer
> > > to
> > > >  ensure the integrity of the operation being performed on the expected object.
> > > >
> > > > +2.4.6 KF_SLEEPABLE flag
> > > > +-----------------------
> > > > +
> > > > +The KF_SLEEPABLE flag is used for kfuncs that may sleep. Such kfuncs can
> > > only
> > > > +be called by sleepable BPF programs (BPF_F_SLEEPABLE).
> > > > +
> > > >  2.5 Registering the kfuncs
> > > >  --------------------------
> > > >
> > > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > > index cdb376d53238..976cbdd2981f 100644
> > > > --- a/include/linux/btf.h
> > > > +++ b/include/linux/btf.h
> > > > @@ -49,6 +49,7 @@
> > > >   * for this case.
> > > >   */
> > > >  #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer
> > > arguments */
> > > > +#define KF_SLEEPABLE   (1 << 5) /* kfunc may sleep */
> > > >
> > > >  struct btf;
> > > >  struct btf_member;
> > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > index 7e64447659f3..d3e4c86b8fcd 100644
> > > > --- a/kernel/bpf/btf.c
> > > > +++ b/kernel/bpf/btf.c
> > > > @@ -6175,6 +6175,7 @@ static int btf_check_func_arg_match(struct
> > > bpf_verifier_env *env,
> > > >  {
> > > >     enum bpf_prog_type prog_type = resolve_prog_type(env->prog);
> > > >     bool rel = false, kptr_get = false, trusted_arg = false;
> > > > +   bool sleepable = false;
> > > >     struct bpf_verifier_log *log = &env->log;
> > > >     u32 i, nargs, ref_id, ref_obj_id = 0;
> > > >     bool is_kfunc = btf_is_kernel(btf);
> > > > @@ -6212,6 +6213,7 @@ static int btf_check_func_arg_match(struct
> > > bpf_verifier_env *env,
> > > >             rel = kfunc_flags & KF_RELEASE;
> > > >             kptr_get = kfunc_flags & KF_KPTR_GET;
> > > >             trusted_arg = kfunc_flags & KF_TRUSTED_ARGS;
> > > > +           sleepable = kfunc_flags & KF_SLEEPABLE;
> > > >     }
> > > >
> > > >     /* check that BTF function arguments match actual types that the
> > > > @@ -6419,6 +6421,13 @@ static int btf_check_func_arg_match(struct
> > > bpf_verifier_env *env,
> > > >                     func_name);
> > > >             return -EINVAL;
> > > >     }
> > > > +
> > > > +   if (sleepable && !env->prog->aux->sleepable) {
> > > > +           bpf_log(log, "kernel function %s is sleepable but the program is
> > > not\n",
> > > > +                   func_name);
> > > > +           return -EINVAL;
> > > > +   }
> > > > +
> > > >     /* returns argument register number > 0 in case of reference release
> > > kfunc */
> > > >     return rel ? ref_regno : 0;
> > > >  }
> > > > --
> > > > 2.25.1
> > > >
> > >
> > > BR, Jarkko
> >
>
