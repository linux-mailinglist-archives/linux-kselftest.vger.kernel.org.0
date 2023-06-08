Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23401728AC9
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 00:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbjFHWBv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Jun 2023 18:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHWBu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Jun 2023 18:01:50 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3FC1FE9;
        Thu,  8 Jun 2023 15:01:49 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1acd41ad2so11541621fa.3;
        Thu, 08 Jun 2023 15:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686261708; x=1688853708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9hNmMs82jsS6xNZ5MQRTVCDn5jLbDEwoTYuUqiILy8=;
        b=PdK2kwXTm0A+AUGPzeAbBJ4biiqnKlWJ93EIDffo02RFUmVBBXXZW1LofktKSl3p1d
         aG2Tevn4/qPtJxD4e9o7rQ8DwqC1bFENCPAxGdQDb+Y82Nm7cEeQGaNqgky0iOwJRGrD
         ciyWjjqRtazm6UB3lkMF6EwJKM2JRadmO9v1DIilCCgFNsep5aIz9emgqweaWCQRymdR
         QVnjK37K0WQlQN4aPsmry4qQ83JlJuWRmPbPgvES47YzrJzbxbUViwPWn/++uMzF7D5d
         8zN9orZ/TG0OSMnq+OmnIK1Bu+6fYyj996Nst/oDEGI4VkFcfneZJagO36BUBX1xOZjy
         H0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686261708; x=1688853708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H9hNmMs82jsS6xNZ5MQRTVCDn5jLbDEwoTYuUqiILy8=;
        b=Q/1fzyUB792nNTiZhYGApgiWmycA+TIwwjaQeKganKrQ3vnNYevM1tZ5MniJqNcBdX
         s0BU4RJkNoo+NXPUtS4lprBHZ4hXQFNI/lL6JhykG9wLxaCtR7DAnS+FNBqPFTRyMcTV
         pMoqdzle2azsKzl8gjQxqx1+s6sKx7k5Vgn+BNU2zcIFG0RJcNwH5RpMD2Jh36DN2RQy
         dse5cWkXcJjFZZ92Rbysc4Cnk/Z5vCumsfV0K+JqrQ1WntElSJqXP5kHG2nRAa0pHYEf
         is0PKJwlkT156wSObkMjwmKBpgr6wDd0ljHVMp5uwsuAJHymYQ1CDRo71LeWxSaGZr4I
         i/aA==
X-Gm-Message-State: AC+VfDwpp/NT6RrynJ+Dk57oRRLdqPG0wlia3+zdiOtZ/9feGbQ+QKH5
        6EAlQ74VYLWJWhDXvylS3s9ifZbaPtgCxgSZRno=
X-Google-Smtp-Source: ACHHUZ5JPShNzttmMw9l9ZlwY4QIBGA9Q4ZrRAveXgYfD75EfSQ/d+Vl7J6pHbO1NIUVksnly5oxWELHUr2E4+kklqc=
X-Received: by 2002:a2e:9785:0:b0:2ac:82c1:5a3d with SMTP id
 y5-20020a2e9785000000b002ac82c15a3dmr3856046lji.23.1686261707593; Thu, 08 Jun
 2023 15:01:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686166633.git.kjlx@templeofstupid.com> <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
In-Reply-To: <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Jun 2023 15:01:36 -0700
Message-ID: <CAADnVQJd=_OZJUWVcQH7OtaH2cv8FLsB7kBhxZANsR9O3+AfZA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
To:     Krister Johansen <kjlx@templeofstupid.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jun 7, 2023 at 2:04=E2=80=AFPM Krister Johansen <kjlx@templeofstupi=
d.com> wrote:
>
> When bpf subprograms are in use, the main program is not jit'd after the
> subprograms because jit_subprogs sets a value for prog->bpf_func upon
> success.  Subsequent calls to the JIT are bypassed when this value is
> non-NULL.  This leads to a situation where the main program and its
> func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
> has an extable.  Extables are only created during JIT.  Now there are
> two nearly identical program ksym entries in the tree, but only one has
> an extable.  Depending upon how the entries are placed, there's a chance
> that a fault will call search_extable on the aux with the NULL entry.
>
> Since jit_subprogs already copies state from func[0] to the main
> program, include the extable pointer in this state duplication.  The
> alternative is to skip adding the main program to the bpf_kallsyms
> table, but that would mean adding a check for subprograms into the
> middle of bpf_prog_load.

adding a check to bpf_prog_load() isn't great. that's true, but...

> Cc: stable@vger.kernel.org
> Fixes: 1c2a088a6626 ("bpf: x64: add JIT support for multi-function progra=
ms")
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  kernel/bpf/verifier.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5871aa78d01a..d6939db9fbf9 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17242,6 +17242,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>         prog->jited =3D 1;
>         prog->bpf_func =3D func[0]->bpf_func;
>         prog->jited_len =3D func[0]->jited_len;
> +       prog->aux->extable =3D func[0]->aux->extable;

Why not to do this hunk and what I suggested earlier: start from func=3D1 ?
That will address double ksym insertion that Yonghong mentioned.
