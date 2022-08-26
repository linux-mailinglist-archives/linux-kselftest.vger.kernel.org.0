Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186B95A21C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Aug 2022 09:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245225AbiHZHZ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Aug 2022 03:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245070AbiHZHZz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Aug 2022 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 458971D0F9;
        Fri, 26 Aug 2022 00:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4B9C61CEB;
        Fri, 26 Aug 2022 07:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AEA2C43144;
        Fri, 26 Aug 2022 07:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661498753;
        bh=eoEfCiZf+UFMjTs3Z8rXcKqcIWDyH3RE5B0CCIV8wcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jWmCsezjS7DuK7fuoTsOK74K+SSUOpPydkcBjeTEjjw8mZM4c/t6yV4d7+j3hIHiR
         1K13X0uuHHl+QKzrGMMDYJ+CNQFcAKc7ljrcABBrkFHWZh7qjXtFneWcgP/aRiZuWT
         byh7a00NDtXQOxxSi7a+hEDdNlA4b8fTTIgzbCSzYhAhBroCXyisJyRiW07CpZHmXn
         coa97oXynV3LGd/9/D3K+kc+zNxS1lhEWnHX4v+M18wLSNxZi6NNzeq6aj7kfBpe3/
         gnvsOtR1sryCQ3zqBgqUSVxY7UJG+XJIpaRJO0YvU5LI9dwyMszeSrxDe9EFHLkNn4
         8QAufpEg8tXiA==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31f445bd486so14973027b3.13;
        Fri, 26 Aug 2022 00:25:53 -0700 (PDT)
X-Gm-Message-State: ACgBeo0RyPjqSLrqPN7/T+33ChMyd7nxYae7+eQScyX0n95ZqEB/deM3
        Hmfsgz6KWMRnbyBrhKa9B1AJDBsUTr/Ax5jOcdw=
X-Google-Smtp-Source: AA6agR5YodWivkrk0r4yRLheqbcmjyTAzUB6ibsijAyS9QtlH8xDmP+jOjTbq6x72HF7K+pEL/rq9wtQchxEgSi4NeM=
X-Received: by 2002:a25:8b92:0:b0:66d:553a:f309 with SMTP id
 j18-20020a258b92000000b0066d553af309mr6358786ybl.322.1661498752107; Fri, 26
 Aug 2022 00:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220823150035.711534-1-roberto.sassu@huaweicloud.com>
 <20220823150035.711534-6-roberto.sassu@huaweicloud.com> <CAPhsuW5iVRSCQsMRC7bGHw=ZHW1Y7y0SccQG-i-7=umHF2yJEQ@mail.gmail.com>
 <67c4a5e7cf363a6c9b79a436690c4c3f469652de.camel@huaweicloud.com>
In-Reply-To: <67c4a5e7cf363a6c9b79a436690c4c3f469652de.camel@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 26 Aug 2022 00:25:41 -0700
X-Gmail-Original-Message-ID: <CAPhsuW76kwaX2mhDtp3_5cC+gxsB3tnVQ00CUrjAR6bFKBcFtQ@mail.gmail.com>
Message-ID: <CAPhsuW76kwaX2mhDtp3_5cC+gxsB3tnVQ00CUrjAR6bFKBcFtQ@mail.gmail.com>
Subject: Re: [PATCH v13 05/10] bpf: Add bpf_lookup_*_key() and bpf_key_put() kfuncs
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>,
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

On Fri, Aug 26, 2022 at 12:22 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Thu, 2022-08-25 at 22:56 -0700, Song Liu wrote:
> > On Tue, Aug 23, 2022 at 8:02 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Add the bpf_lookup_user_key(), bpf_lookup_system_key() and
> > > bpf_key_put()
> > > kfuncs, to respectively search a key with a given key handle serial
> > > number
> > > and flags, obtain a key from a pre-determined ID defined in
> > > include/linux/verification.h, and cleanup.
> > >
> > > Introduce system_keyring_id_check() to validate the keyring ID
> > > parameter of
> > > bpf_lookup_system_key().
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  include/linux/bpf.h          |   6 ++
> > >  include/linux/verification.h |   8 +++
> > >  kernel/trace/bpf_trace.c     | 135
> > > +++++++++++++++++++++++++++++++++++
> > >  3 files changed, 149 insertions(+)
> > >
> > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > index 6041304b402e..991da09a5858 100644
> > > --- a/include/linux/bpf.h
> > > +++ b/include/linux/bpf.h
> > > @@ -2586,4 +2586,10 @@ static inline void bpf_cgroup_atype_get(u32
> > > attach_btf_id, int cgroup_atype) {}
> > >  static inline void bpf_cgroup_atype_put(int cgroup_atype) {}
> > >  #endif /* CONFIG_BPF_LSM */
> > >
> > > +#ifdef CONFIG_KEYS
> >
> > Do we need to declare struct key here?
> >
> > > +struct bpf_key {
> > > +       struct key *key;
> > > +       bool has_ref;
> > > +};
> > > +#endif /* CONFIG_KEYS */
> > >  #endif /* _LINUX_BPF_H */
> > >
>
> If there is a better place, I will move there.

I guess you misunderstood. I meant we need

struct key;

struct bpf_key {
       struct key *key;
       bool has_ref;
};

Otherwise, we may get some warning with certain config.

Thanks,
Song
