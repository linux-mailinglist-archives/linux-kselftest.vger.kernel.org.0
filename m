Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2647541F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 20:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236630AbjGNR7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbjGNR6T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 13:58:19 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69203588;
        Fri, 14 Jul 2023 10:57:53 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b701dee4bfso35019401fa.0;
        Fri, 14 Jul 2023 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689357372; x=1691949372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9AbKCKlNo5tGcZxjGSyHoxzrDe1FW9XQhnQd8GwdIY=;
        b=M5kSN5aGlyBfYfBxiNFTkbW6CZ6DbxX5u6pTSuWybOI4f9MJRqhk6P/hEsOuoDpmSf
         oNk7xAxFCHPs7GStuaokFaUnIstdfeeYMPYXjSNQYCpz/PeTAUwd7N4UGB67PuWNY5bT
         tGuUIdP0JdOObdVNZ+tSnsB2MJEtvpH9nsjLJ7eElP/QeEjCur6hKHXlPUVTveUf3bW+
         6Af1PDxubILueMTdCHz3yhplq63iQs+omDgxPrHP/HwVFMasSw4WeWUf0JBAyH6ANrMV
         r1fYHZA14qpq8/fogoTLkQjnG+3fcx00d98X/cu35jynPTcomzwXwLiUaMf1zxr9lKoD
         +WaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689357372; x=1691949372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9AbKCKlNo5tGcZxjGSyHoxzrDe1FW9XQhnQd8GwdIY=;
        b=DULB8IBXxudkRkd1gSBebkHsEBZ0Qi0A1AliOiG5+ESPW42SECNv6cqUe//GzfhNxx
         c1o95vPzpiZZri9mzFM6pIGyhEEUQFihGjwMElwANB5sL8+cgWZc3xQg5wj6JIDpDXmm
         mR0hea86LZB9AOJmDYh6Kg7V2oXGhgeCKeg1THSX2CR8tm66GShv5lXR8myf3D8OuWC7
         BJsxrHt44dj3JKrxuDN85GqKiLlzyVz7r5kkVKKTP2f+4uWvlI6FQ5eRBlwCy0VEcHJE
         T64xuw58q3Lc4D8W9Y7wJzbB+wfO+zAQwR8JEzti2wocBsOv5EZfsHLhZOQW3ol/NGKc
         sayQ==
X-Gm-Message-State: ABy/qLYcp6NV2UxB3tloIPTfHTSD8kywMrGowAJO1CTOpvky+Qlebpbk
        THaMOnbz1GTNbTodImHkspPtqKn6epbxStSz9+w=
X-Google-Smtp-Source: APBJJlE9U9U9OSKV3445Mx2CqaXpZtf167ReY7yLnsFAV+bDeZ7EinTup73EXv2WDjrEjViq8yf9wUnCcD6DRmLhXDs=
X-Received: by 2002:a2e:8ed6:0:b0:2b6:cf31:5e81 with SMTP id
 e22-20020a2e8ed6000000b002b6cf315e81mr4638807ljl.20.1689357372078; Fri, 14
 Jul 2023 10:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230714141747.41560-1-aspsk@isovalent.com> <20230714142100.42265-1-aspsk@isovalent.com>
 <20230714142100.42265-2-aspsk@isovalent.com>
In-Reply-To: <20230714142100.42265-2-aspsk@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 14 Jul 2023 10:56:00 -0700
Message-ID: <CAADnVQJztACtOx8UEyWJqTXd95DBDWsNEAG284Ci4N7Ma8Fqgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: consider CONST_PTR_TO_MAP as trusted
 pointer to struct bpf_map
To:     Anton Protopopov <aspsk@isovalent.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Hou Tao <houtao1@huawei.com>, Joe Stringer <joe@isovalent.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
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

On Fri, Jul 14, 2023 at 7:20=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Patch verifier to regard values of type CONST_PTR_TO_MAP as trusted
> pointers to struct bpf_map. This allows kfuncs to work with `struct
> bpf_map *` arguments.
>
> Save some bytes by defining btf_bpf_map_id as BTF_ID_LIST_GLOBAL_SINGLE
> (which is u32[1]), not as BTF_ID_LIST (which is u32[64]).
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  include/linux/btf_ids.h | 1 +
>  kernel/bpf/map_iter.c   | 3 +--
>  kernel/bpf/verifier.c   | 5 ++++-
>  3 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 00950cc03bff..a3462a9b8e18 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -267,5 +267,6 @@ MAX_BTF_TRACING_TYPE,
>  extern u32 btf_tracing_ids[];
>  extern u32 bpf_cgroup_btf_id[];
>  extern u32 bpf_local_storage_map_btf_id[];
> +extern u32 btf_bpf_map_id[];
>
>  #endif
> diff --git a/kernel/bpf/map_iter.c b/kernel/bpf/map_iter.c
> index d06d3b7150e5..b67996147895 100644
> --- a/kernel/bpf/map_iter.c
> +++ b/kernel/bpf/map_iter.c
> @@ -78,8 +78,7 @@ static const struct seq_operations bpf_map_seq_ops =3D =
{
>         .show   =3D bpf_map_seq_show,
>  };
>
> -BTF_ID_LIST(btf_bpf_map_id)
> -BTF_ID(struct, bpf_map)
> +BTF_ID_LIST_GLOBAL_SINGLE(btf_bpf_map_id, struct, bpf_map)
>
>  static const struct bpf_iter_seq_info bpf_map_seq_info =3D {
>         .seq_ops                =3D &bpf_map_seq_ops,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 0b9da95331d7..5663f97ef292 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5419,6 +5419,9 @@ static bool is_trusted_reg(const struct bpf_reg_sta=
te *reg)
>         if (reg->ref_obj_id)
>                 return true;
>
> +       if (reg->type =3D=3D CONST_PTR_TO_MAP)
> +               return true;
> +

Overall it looks great.
Instead of above, how about the following instead:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b9da95331d7..cd08167dc347 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10775,7 +10775,7 @@ static int check_kfunc_args(struct
bpf_verifier_env *env, struct bpf_kfunc_call_
                        if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(m=
eta))
                                break;

-                       if (!is_trusted_reg(reg)) {
+                       if (!is_trusted_reg(reg) &&
!reg2btf_ids[base_type(reg->type)]) {


This way we won't need to list every convertible type in is_trusted_reg.

I'm a bit hesitant to put reg2btf_ids[] check directly into is_trusted_reg(=
).
Maybe it's ok, but it needs more analysis.
