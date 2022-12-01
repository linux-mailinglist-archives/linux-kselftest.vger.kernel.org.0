Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA263E6BE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 01:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiLAAzh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Nov 2022 19:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbiLAAza (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Nov 2022 19:55:30 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA58D673;
        Wed, 30 Nov 2022 16:55:27 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id gu23so583707ejb.10;
        Wed, 30 Nov 2022 16:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yr9ys6HO2MrWpQ3INHTC37QpZhNvq29WcYZp15OMZA0=;
        b=kcHHG2Iamod1Y29/0RF6tU4qbFBr7C/Zf8EeuSiIehjif8naYO1+rK7wOQHopwBbC2
         w6tXt+ZQDU/gyDViHmOEvlDnDLTqLVJesYIv7Yr+JC51pT63wA+H68b+xoomLJZXJHSO
         W85ps7TUbPKxm4MnItGJWiIBAOKbJqo6NJ0ClO8xiAwLazR8st81mv9ywkhbtfCZbrNu
         CuHOtBsX2RNCBK5ICIfo49IIwvX2Yq5WaE0ClYRqmuSP3buh2jCReV2br51VnAvKWHWY
         Ug7/Ckr16NoxZNfBPnbAzs5dGfGPo7Zvhh3ee1RpBDluFYPBrzidgY9Tkb9t5NzUgE10
         m51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yr9ys6HO2MrWpQ3INHTC37QpZhNvq29WcYZp15OMZA0=;
        b=OL5/xPowHZNLreDPX+bZB3JK0lVAvnlSmwzloUVMLP5Bbf88Hs3mVBYZEGBisqhblN
         LS67FHdrzsBPgSubzwvmS1ElXJDA2J8miC/tezIYELhA/Zb66zb7RBcW5RXSUUfAGP+k
         aqTKVfbuGY8u84KVLfsVUblo2hfx2uEg2QPrvt7wIa8YRkDHroPppIFNouOefTf1wvDt
         AZYbwo6AYgne4i49hC+qaBvnM0TabBtMCSE5OyJ/lTAenHr+XtDPYCYLAoGiaL9YQIdO
         ltkH5eCaz2/JtpBuxc+EPs4PIq7ZmbnmQWe2NCGCnkagLQLpJJzWhuewv6oxZpOA/bkl
         hlzA==
X-Gm-Message-State: ANoB5pn3StdPXRDri9omydUYq5s/JDRLRpFNYcfMWu69xtOLwUmUvW0z
        /o9K+IyK91Lpn4iuL7h31SoqSFyJow2zRZFJvD8=
X-Google-Smtp-Source: AA0mqf5TMdaho2mYK0Woa9ZJMyDANjEA59+nAojEa04/IDe1PQguHXe+kIYnjYgHJzcZO+PRVtPWXpFfE/zfNQm9KDE=
X-Received: by 2002:a17:906:6403:b0:7b2:9667:241e with SMTP id
 d3-20020a170906640300b007b29667241emr54933523ejm.115.1669856125585; Wed, 30
 Nov 2022 16:55:25 -0800 (PST)
MIME-Version: 1.0
References: <20221129134217.52767-1-changbin.du@gmail.com> <20221129134217.52767-2-changbin.du@gmail.com>
In-Reply-To: <20221129134217.52767-2-changbin.du@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 30 Nov 2022 16:55:13 -0800
Message-ID: <CAEf4BzZ=+DVkNT+Ti2L_ZyqrxwajfN04ou9XDrju704O6Ake4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: show error info about missing ".BTF" section
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 29, 2022 at 5:42 AM Changbin Du <changbin.du@gmail.com> wrote:
>
> Show the real problem instead of just saying "No such file or directory".
>
> Now will print below info:
> libbpf: can not find '.BTF' section
> Error: failed to load BTF from /home/changbin/work/linux/vmlinux: No such file or directory
>
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d88647da2c7f..1adc0f6019a0 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -990,6 +990,7 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
>         err = 0;
>
>         if (!btf_data) {
> +               pr_warn("can not find '%s' section\n", BTF_ELF_SEC);

let's use consistent form of error messages:

pr_warn("failed to find '%s' ELF section in %s\n", BTF_ELF_SEC, path);

>                 err = -ENOENT;
>                 goto done;
>         }
> --
> 2.37.2
>
