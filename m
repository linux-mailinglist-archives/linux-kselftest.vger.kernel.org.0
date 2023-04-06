Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C687C6DA59E
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Apr 2023 00:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjDFWNX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 18:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjDFWNX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 18:13:23 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A8D5243;
        Thu,  6 Apr 2023 15:13:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id cw23so4685698ejb.12;
        Thu, 06 Apr 2023 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680819200; x=1683411200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LR838qn5ojTxvte1z440mNOMaVbvtK1CNLDQN93r+0Q=;
        b=YpwuY6e5l56eHE2e8U0yGmlSOzu99EGm937lDzi7An3yJ4XEFzkcYygz3arY0oVMXY
         csaE77AaXI2TkIk02KiWY+G4dl56eFrH2MpsjJFJdZVcNyrhLhKPZRn0A91yfY24YYts
         p1lzCf1JVazl6Ij56fDZymyvDdLjAnDkAoQo6sQOZGN0DSLQt4hlHUUajrAGTJBwa0Em
         DST57BRWU8U5K+/aM8OBGskCsoh3zGNrVSimGTI8/I9bfKTqchEr7EAIJgoeROCLRGfv
         dfb5EKA8VbatCI8amqYbDkv6R1Ab/0K+pI9ee5pRh3hPAMr0cl+rx+eU4g+J4NY00a71
         6EZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680819200; x=1683411200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LR838qn5ojTxvte1z440mNOMaVbvtK1CNLDQN93r+0Q=;
        b=48r1BpoqZC9BAQOvmBbdG/ES/lfb1zY1Qulkl1CD5miIrdZ50XnojL6cnJLLHkXbHZ
         id63nN5bri2Umtcm/QsqCozzp9dclX1pdWklxwsxzwBUP38NUTjcJrtNozWMmYZA9dpE
         svzmWTY5P+j/5Eq7wHxrGivOPOAuC/QTQ5tLqwYT0Z8h89H8wjpORoUgiLfvLKm+b1d1
         uIPwvqDz78TgJ1N2mWOzIa/owtJH779a+lWbPLZTet3ojn8ATAW18dHzL+8JsTK+WfAL
         9VL/MWCirYrMuOF01x4C6aCLJtkznrQZ5aIDsOJ/Z3bPR4XfOEDqpAos07dlLZfo/3Ht
         BUcQ==
X-Gm-Message-State: AAQBX9cVpy4t1WdPiyhq77Z1CfJwcqGHaPTan3T0X+KldqyqsHvLfltU
        Ep5fqrIaYu6cVCvngHqrdcwaVsPbA31bgv91/No=
X-Google-Smtp-Source: AKy350bGHFTcvlgl4c1fEe9+sVRUEwan9gMUZ8FtCLnfntaacVK4sQsNsIGVLx5EZruDK74J2ez9SQqP8QD7Vd7uyFY=
X-Received: by 2002:a17:906:55d5:b0:88d:ba79:4317 with SMTP id
 z21-20020a17090655d500b0088dba794317mr5418820ejp.7.1680819200222; Thu, 06 Apr
 2023 15:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-2-drosen@google.com>
 <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com>
In-Reply-To: <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 6 Apr 2023 15:13:09 -0700
Message-ID: <CAADnVQ+jQG95kVqkajr=zz2-vs24XedEXcBgSx29oAjqUsFn2g@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joanne Koong <joannelkoong@gmail.com>,
        Mykola Lysenko <mykolal@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Apr 6, 2023 at 1:55=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Apr 5, 2023 at 5:40=E2=80=AFPM Daniel Rosenberg <drosen@google.co=
m> wrote:
> >
> > This allows using memory retrieved from dynptrs with helper functions
> > that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
> > can be passed along to bpf_strncmp.
> >
> > Signed-off-by: Daniel Rosenberg <drosen@google.com>
> > ---
>
> I think patches like this should be targeted against bpf-next, so for
> next revision please send them against bpf-next tree.
>
> >  kernel/bpf/verifier.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 56f569811f70..20beab52812a 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -7164,12 +7164,16 @@ static int check_reg_type(struct bpf_verifier_e=
nv *env, u32 regno,
> >          * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM an=
d PTR_TO_MEM + MAYBE_NULL,
> >          * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NO=
T with PTR_TO_MEM + MAYBE_NULL
> >          *
> > +        * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged =
with a dynptr type.
> > +        *
> >          * Therefore we fold these flags depending on the arg_type befo=
re comparison.
> >          */
> >         if (arg_type & MEM_RDONLY)
> >                 type &=3D ~MEM_RDONLY;
> >         if (arg_type & PTR_MAYBE_NULL)
> >                 type &=3D ~PTR_MAYBE_NULL;
> > +       if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM)
> > +               type &=3D ~DYNPTR_TYPE_FLAG_MASK;
>
> Something feels off here. Can you paste a bit of verifier log for the
> failure you were getting. And let's have a selftest for this situation
> as well.
>
> ARG_PTR_TO_MEM shouldn't be qualified with the DYNPTR_TYPE flag, it's
> just memory, there is no need to know what type of dynptr it was
> derived from. So if that happens, the problem is somewhere else. Let's
> root cause and fix that. Having a selftest that demonstrates the
> problem will help with that.

+1
All of the DYNPTR_TYPE_FLAG_MASK flags cannot appear in type =3D=3D reg->ty=
pe
here.
They are either dynamic flags inside bpf_dynptr_kern->size
or in arg_type.
Like in bpf_dynptr_from_mem_proto.
