Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9499176C2D2
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Aug 2023 04:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjHBCXg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 22:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjHBCXf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 22:23:35 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5E82689;
        Tue,  1 Aug 2023 19:23:34 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso96748721fa.3;
        Tue, 01 Aug 2023 19:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690943012; x=1691547812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FguIqfO6fA0en1tAJcHc1To85beuh1CsHQRCqfyQt0=;
        b=d1uLtGhtE4ga7jedFfoU52u3XFP5LL4+sF4vs9hz0lH/pTqgkQTBLCKYzdU+lHBLvn
         5NadrBu9uulcQs/MVVEXgAnBrpUunlu/UZXaS3ilaDS66w0HMewijXOXN9eqEDQjQul2
         Y/TLS6Nhj+60BHQrXfhPPLeCQW4959KG5l0F4RiIWUGMzT8TJriVj9RGrmZ3m/jNF9mN
         VT0q3AIlC++O5J/3ELqS9WYwi5M+Yg0zQ5q0VuzOIlBNeJ7jWiNe6oWLXWGEMUnOYLV8
         WyQt+g3zhsi1/Xdht0ZsRqsJQQVmbPTuyx359Xwsqxpmyc+L/xgea/8PyaKcEoGn/M9+
         3eTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690943012; x=1691547812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3FguIqfO6fA0en1tAJcHc1To85beuh1CsHQRCqfyQt0=;
        b=OdwUVQ0ZsNNTMZzhvm1dch5WxhfvuUmrWD3Z5wjPE+zW2JNO4AQre05bQTPuAmSqTZ
         7qKmUYhKhAQ24rn3MnZ5R7+7q0sTINQXg0RZFelywEJsrwtUHKlNTC2zZwDfEfSiOwV6
         Y0p8yRTS5of9fkeHOQdmeBWwatkvHhdj0aurVnxXLl3pMelxisQZ/Zs5pol6yyuJoN+s
         3eWqwuuQ1FLnyu0pqKLYY1kIfGiZ+h8hSy3ZV7HY0F8sMykgFtCDgXYDKLrJyqdXVYfj
         /q3ztMfgG2LZ1B/izSzzv9syQqRCOa0iogN/82lD+i4vtMO60wWKgUXACKYxQSMmZUbj
         atGw==
X-Gm-Message-State: ABy/qLYqL5Cr+wkp3QJngq/94uRzlnOMF3ekVsOOSEy9Y6EJxENPuEoq
        5N8ChjuwszboxL919v4yPYy7tdAqaQfvB3UYtQA=
X-Google-Smtp-Source: APBJJlG8DpVQd1HX0sziPuWjT0LVfNpCxEMyII6e8Er09IIz5vcp1ZwFHDi/kyZCsVnrgHRgcFINXGCy73y0Os8s2MQ=
X-Received: by 2002:a2e:8ec3:0:b0:2a7:adf7:1781 with SMTP id
 e3-20020a2e8ec3000000b002a7adf71781mr3969470ljl.2.1690943012233; Tue, 01 Aug
 2023 19:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690624340.git.geliang.tang@suse.com> <20230801004323.l2npfegkq3srzff3@MacBook-Pro-8.local>
 <20230802021903.GA3070@bogon>
In-Reply-To: <20230802021903.GA3070@bogon>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 1 Aug 2023 19:23:21 -0700
Message-ID: <CAADnVQJRmXy_iFBsWLTTKBnmwPjSJP+7RLfJwB9GUb=GEFoMwg@mail.gmail.com>
Subject: Re: [RFC bpf-next v7 0/6] bpf: Force to MPTCP
To:     Geliang Tang <geliang.tang@suse.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        MPTCP Upstream <mptcp@lists.linux.dev>,
        apparmor@lists.ubuntu.com,
        LSM List <linux-security-module@vger.kernel.org>,
        selinux@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 1, 2023 at 7:19=E2=80=AFPM Geliang Tang <geliang.tang@suse.com>=
 wrote:
>
> On Mon, Jul 31, 2023 at 05:43:23PM -0700, Alexei Starovoitov wrote:
> > On Sat, Jul 29, 2023 at 05:57:21PM +0800, Geliang Tang wrote:
> > >
> > > The main idea is to add a hook in sys_socket() to change the protocol=
 id
> > > from IPPROTO_TCP (or 0) to IPPROTO_MPTCP.
> >
> > I still think it's a hack, but its blast radius is nicely contained.
> > And since I cannot propose any better I'm ok with it.
> >
> > Patches 1-2 can be squashed into one.
> > Just like patches 3-6 as a single patch for selftests.
>
> Thanks Alexei. I'll squash patch 1 and patch 2 into one, and squash patch=
 3
> and patch 6 into one for selftests. But I prefer to keep patch 4 and patc=
h 5
> as is, since they were implemented in different times for different purpo=
ses.
> They were merged into MPTCP repo on May 17 for "run MPTCP sched tests in =
a
> dedicated ns" [1].

since they were sent to a different tree than don't send them here.
git will not like that during the merge window.
