Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56AB776A09D
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Jul 2023 20:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjGaSrM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 31 Jul 2023 14:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjGaSrL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 31 Jul 2023 14:47:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F9518F;
        Mon, 31 Jul 2023 11:47:10 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b962c226ceso71015121fa.3;
        Mon, 31 Jul 2023 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690829228; x=1691434028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsDP4OSKk4fj8rnGVRvHaWke258uZTHgXHn3HYO48cQ=;
        b=qRSadawJ6qlYS+8IeUlJ0Y+LCFExh7JSRCJ2Xx//mWnuxSLyFc1LqbweloptxXpnWf
         vlInfCiRDHygNa6Hi7A1wHqoEK1tpvB8nUAnXoYBIL94/lFhMPqQZdY+FZmd9U81fNTi
         wG1ej1YFOo4/zlZIwxnK3sNafE4sDe69UbXa1gPgyuJqYkxTpzApNum3Xw34s3zAVg+C
         4PgPojAtL4jmX3pc9cnD1guqmqo/WMJxUlMDL4134gueoulDBoT5Ji3DB5eTCyxmz23M
         uvohAoSq4Edn+Xb8PVVP119q9ld6lOwyM0+0xJmn219UVjKWHgLnu0reZR0k3jdkE3iD
         HDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690829228; x=1691434028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsDP4OSKk4fj8rnGVRvHaWke258uZTHgXHn3HYO48cQ=;
        b=I+JtUWjjf8qmkdKF0IP6wHuc9TkEMgD6DS61QH2cXFxkhVNNli9A7b8kLrj5M1uS3E
         yQnNBJ1FouV92YD+Cd1WZttZkGaTqX+sKbh8l2ZwJSgK54LcKkLULOKAFGOV9HNem/3o
         j2U3IMUXU2JvN24jj3Sntt5IsUncOP50wi+FkebHlRTiirHr9tSV4a1mtxkKJO5/3lRS
         M57FkMtAM2juqyA7VptPgw5GSlOohHmdrj+uC7Y4B2VMAeH182XuOiLqzrmgJ5mhs6gC
         jcNWPvI3M5E3Y/e5n/S7nzv5M5+fidtyi9GDe4lKOJMT4vEag88SQBt5HzbKlzFGB1DN
         HK1A==
X-Gm-Message-State: ABy/qLaTHQ8CrYTC4NqAWKyo8BXNKhJfeYYjf0bKK06U4ZeATFRww2Pt
        PJdSurCvs5EvxD6702r3zzBc9ww46bxjZ3YA05U=
X-Google-Smtp-Source: APBJJlFe+rjtdVgpjaiPDbFqCZuYnj78NXa8q3r/nKu4g9h0xqWtP+MGmHFMvlCtmZbUj2vsSdOQ2dy6rL1thFpCLMM=
X-Received: by 2002:a2e:b16f:0:b0:2b7:a72:103b with SMTP id
 a15-20020a2eb16f000000b002b70a72103bmr528373ljm.53.1690829227967; Mon, 31 Jul
 2023 11:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1690332693.git.yan@cloudflare.com> <9c4896b109a39c3fa088844addaa1737a84bbbb5.1690332693.git.yan@cloudflare.com>
 <791b919c-de82-6dc8-905a-520543f975cd@linux.dev> <87edkoflvx.fsf@cloudflare.com>
In-Reply-To: <87edkoflvx.fsf@cloudflare.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 31 Jul 2023 11:46:56 -0700
Message-ID: <CAADnVQ+7akLU_rY7xe=LbvY=bLiN8C5Vk5m0iwbao6hVH9v88w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf 2/2] bpf: selftests: add lwt redirect regression
 test cases
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Yan Zhai <yan@cloudflare.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Jordan Griege <jgriege@cloudflare.com>,
        Markus Elfring <Markus.Elfring@web.de>
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

On Mon, Jul 31, 2023 at 2:52=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
>
> On Fri, Jul 28, 2023 at 03:47 PM -07, Martin KaFai Lau wrote:
> > On 7/25/23 6:09 PM, Yan Zhai wrote:
>
> [...]
>
> >> diff --git a/tools/testing/selftests/bpf/test_lwt_redirect.sh
> >> b/tools/testing/selftests/bpf/test_lwt_redirect.sh
> >> new file mode 100755
> >> index 000000000000..1b7b78b48174
> >> --- /dev/null
> >> +++ b/tools/testing/selftests/bpf/test_lwt_redirect.sh
> >
> > This has to be written in the test_progs infrastructure in C. Only test=
_progs is
> > run by the BPF CI. Take a look at other tests in prog_tests/. For examp=
le,
> > tc_redirect.c and xdp_metadata.c which are having setup in netns/link/.=
..etc. It
> > currently has helpers to add tc qdisc and filter but not adding route y=
et which
> > could be a useful addition.
>
> Can we help make the BPF CI better so that it also runs other tests in
> addition test_progs?

Not really.
CI is not just running the test. It needs to understand the output,
pass it to UI, run in parallel, etc.
All the shell scripts are not suitable for long term CI exposure.

So I completely agree with Martin. No new shell scripts.
All selftests must be in test_progs.

> We have bpf selftests written in shell and even Python. These are
> sometimes the right tools for the job and make adding tests easier,
> IMHO. Network setup from C is verbose and tedious. Not to mention, hard
> to read through.

For comparison take a look at BPF CI code base and what it takes to run
the tests and process the output. There is plenty of work for CI ahead.
