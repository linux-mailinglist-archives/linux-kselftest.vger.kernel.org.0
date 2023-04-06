Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00416DA418
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 22:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDFUzi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 16:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjDFUzh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 16:55:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1364ED6;
        Thu,  6 Apr 2023 13:55:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qb20so4337932ejc.6;
        Thu, 06 Apr 2023 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680814535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZH+Py50y9vo4DMUtUbK/cR4JBKneDucbAHS4uMgQV/Q=;
        b=KRVuosrjlXoDxku6toLdouLKwUM658atx1aVXMcmtkqbiSm752xfpO6UFVT8mxCkWH
         wrhehxhP0Fw5WOSD5/gFPXvUijBJkpkHZqTNFQdebJUuhsJEhmPhALa4iUAKTyfK3qnJ
         NL5/EpePbdo6U4N1m1g1nNj6Clqm8O6RjgwEAuqGhGmZGZjZIFZEJI0x0m5V9GpQO65D
         Xo6FyvT7NV59g7JsJrfAhdqqyFDRBHqxHYE2EDy7MYIY8azcs4gpOPVRdZ1sJMxDgW41
         XVdsbTZTcBjrT/PgCnd0YuNMhxCJGu/WI2mvzwUIfsINc+V+NWbarY8+JQWjp3OJ4OeA
         UDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680814535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZH+Py50y9vo4DMUtUbK/cR4JBKneDucbAHS4uMgQV/Q=;
        b=ZCOhSookSbSuTeiS+vPMMLyUfyPbCuQIDIFysemkYTh8SYDAgiF0YBP8giwKmDHCAf
         Bpl2fP7iE6eWzLS+KViohtyDNWsxflt/ec5Xo9cPbIZX5l2UgEHas/E8avuGabFDH7F4
         JARmyfakyatjF9nICcuXElsi9qR7zKSm8kDBo928vj7pTAk4veO76/TFpPEbvp8r8/GY
         SQQbV3VF4m0VGzhYt/TnNZCOpiWnJLUP/oeLmUWQjpUG3kRggbYcyJQCwHd12+9hM1Y3
         X6C6Sybxv5IZtI0eEzPdKZspF88LSbHrS7lcXBt5qNLbATjbTJi53JLAbvEF8pHKtGae
         3GlA==
X-Gm-Message-State: AAQBX9c64NE42675bQjsmpS8wcygT5VCZG2Rntwd2wATBWMYAD0ji8Iy
        lz+yNF8T/te6dMduFS+c9hSlEk2Goy0+QO25rZyT7Ra2
X-Google-Smtp-Source: AKy350Y3+FEZ1Cg0ihoX86pgJJmcQhD/cHfq/fxhWNZ0zwmWBiZiTjY0deSWjnSKZKcRks3NmRLLHqbsRPfLxe752OU=
X-Received: by 2002:a17:906:1ec7:b0:949:8e10:31c1 with SMTP id
 m7-20020a1709061ec700b009498e1031c1mr96576ejj.5.1680814534863; Thu, 06 Apr
 2023 13:55:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230406004018.1439952-1-drosen@google.com> <20230406004018.1439952-2-drosen@google.com>
In-Reply-To: <20230406004018.1439952-2-drosen@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 6 Apr 2023 13:55:23 -0700
Message-ID: <CAEf4BzbyX3i6k5eL6D-5enU+u58nVn_fK28zNBJ4w_Vm-+RiMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: verifier: Accept dynptr mem as mem in helpers
To:     Daniel Rosenberg <drosen@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
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
        Mykola Lysenko <mykolal@fb.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
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

On Wed, Apr 5, 2023 at 5:40=E2=80=AFPM Daniel Rosenberg <drosen@google.com>=
 wrote:
>
> This allows using memory retrieved from dynptrs with helper functions
> that accept ARG_PTR_TO_MEM. For instance, results from bpf_dynptr_data
> can be passed along to bpf_strncmp.
>
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---

I think patches like this should be targeted against bpf-next, so for
next revision please send them against bpf-next tree.

>  kernel/bpf/verifier.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 56f569811f70..20beab52812a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7164,12 +7164,16 @@ static int check_reg_type(struct bpf_verifier_env=
 *env, u32 regno,
>          * ARG_PTR_TO_MEM + MAYBE_NULL is compatible with PTR_TO_MEM and =
PTR_TO_MEM + MAYBE_NULL,
>          * but ARG_PTR_TO_MEM is compatible only with PTR_TO_MEM but NOT =
with PTR_TO_MEM + MAYBE_NULL
>          *
> +        * ARG_PTR_TO_MEM is compatible with PTR_TO_MEM that is tagged wi=
th a dynptr type.
> +        *
>          * Therefore we fold these flags depending on the arg_type before=
 comparison.
>          */
>         if (arg_type & MEM_RDONLY)
>                 type &=3D ~MEM_RDONLY;
>         if (arg_type & PTR_MAYBE_NULL)
>                 type &=3D ~PTR_MAYBE_NULL;
> +       if (base_type(arg_type) =3D=3D ARG_PTR_TO_MEM)
> +               type &=3D ~DYNPTR_TYPE_FLAG_MASK;

Something feels off here. Can you paste a bit of verifier log for the
failure you were getting. And let's have a selftest for this situation
as well.

ARG_PTR_TO_MEM shouldn't be qualified with the DYNPTR_TYPE flag, it's
just memory, there is no need to know what type of dynptr it was
derived from. So if that happens, the problem is somewhere else. Let's
root cause and fix that. Having a selftest that demonstrates the
problem will help with that.


>
>         if (meta->func_id =3D=3D BPF_FUNC_kptr_xchg && type & MEM_ALLOC)
>                 type &=3D ~MEM_ALLOC;
> --
> 2.40.0.577.gac1e443424-goog
>
