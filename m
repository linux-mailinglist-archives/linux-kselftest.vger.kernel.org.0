Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F825A34A1
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Aug 2022 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242020AbiH0Ezw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 27 Aug 2022 00:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiH0Ezv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 27 Aug 2022 00:55:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9593FAB1A3;
        Fri, 26 Aug 2022 21:55:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id d21so6486601eje.3;
        Fri, 26 Aug 2022 21:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=5aMAeHzrrsc0396PFnmiinGvA1sR4vTxRAUJqdbVkvQ=;
        b=BxqJ+jTWTZ7lkorE1MNvD8Fd3LIKi2o3k6Cbv3yWlh2/ug+6Xeg3pU91nqkkggzDql
         iYblWFqOkO+l0rv6H2SPV2jzfNNKnRXUmp6lTm+KFpXY6X5Yeysw8Xn2kOK3wwhFpywU
         nVjQzt5GSv8v5NwgETQ1XJqPodQH66qN5Za4jBE8pCV5hqp/eFkkGVRtun3uQmjubQ+B
         Zz9oNZKr50qgJqgdZuRQXsD8tWIzWlRmbY+XPAaB5DYY54NMKEFXc1m9TsPUsH7/9q8j
         MgIWnSr4RG25pvb9rVdLhz+1e9UhDNnb4TCT59ltcWCFbMicOULoBVMCAyOU+VS9k7ML
         UkLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5aMAeHzrrsc0396PFnmiinGvA1sR4vTxRAUJqdbVkvQ=;
        b=eqoNDBStS3EJXOBpqS0pMaMWwxHSuPsUi0XytU7JeI6GXuDQW8ZmTZUdtRR3El6Zl7
         JmfPuzKNHPan5AsuK2oT1n+cT2+N3y2rJTkSlaeUYTQl1Ow+w/46f8uimnjKkV/KySJW
         eD9wkpcS1xj2Tau2BhmTNh8lGCqLOsTDQpc+yVvWQTNQaVrjLBmjr032H/ueTb7VU1F5
         M09DcPcn0LXwmXI/piuajjntbD5pNqpiAGYIJwa5LNsG70E+1sNBirFmk3CVLmx52n6W
         sO8DWo+VuY6qmQjXFO/Aum9APoEGtijYvJc7AjpDrENH5O6kpj3glgpHog0Pesdr4WOJ
         9iNg==
X-Gm-Message-State: ACgBeo191lTMiLn22m9dsSywbYDlfgbJxcGeiIBt/Xvu09DJcjpWc87Q
        tVjWT08sFVbOsWxC8OG+U4YMp0js2ZHt1NG48SzKx8sp
X-Google-Smtp-Source: AA6agR57BWqDHWZPj9rnLUWkoW8+bKr7VA26GC78t9AGbeUYDlNys59A4LhFwNfb+lVxD7uGfYyITHSi4iEFxFax+JM=
X-Received: by 2002:a17:907:7e9e:b0:73d:ae12:5f11 with SMTP id
 qb30-20020a1709077e9e00b0073dae125f11mr7424867ejc.176.1661576149109; Fri, 26
 Aug 2022 21:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220826012614.552860-1-james.hilliard1@gmail.com>
In-Reply-To: <20220826012614.552860-1-james.hilliard1@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 26 Aug 2022 21:55:38 -0700
Message-ID: <CAEf4BzahSjt1huoJXAxSj-ycVjGKJm_dFinsZFBHtRGj7apiUQ@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix conflicts with built-in functions in bpf_iter_ksym
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 25, 2022 at 6:26 PM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Both tolower and toupper are built in c functions, we should not

Really? How come? Can you point out where this is specified in C
standard? From what I can tell you have to include <ctype.h> to get
toupper()/tolower().

This seems like yet another GCC-BPF quirk?

> redefine them as this can result in a build error.
>
> Fixes the following errors:
> progs/bpf_iter_ksym.c:10:20: error: conflicting types for built-in function 'tolower'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
>    10 | static inline char tolower(char c)
>       |                    ^~~~~~~
> progs/bpf_iter_ksym.c:5:1: note: 'tolower' is declared in header '<ctype.h>'
>     4 | #include <bpf/bpf_helpers.h>
>   +++ |+#include <ctype.h>
>     5 |
> progs/bpf_iter_ksym.c:17:20: error: conflicting types for built-in function 'toupper'; expected 'int(int)' [-Werror=builtin-declaration-mismatch]
>    17 | static inline char toupper(char c)
>       |                    ^~~~~~~
> progs/bpf_iter_ksym.c:17:20: note: 'toupper' is declared in header '<ctype.h>'
>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> index 285c008cbf9c..9ba14c37bbcc 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> @@ -7,14 +7,14 @@ char _license[] SEC("license") = "GPL";
>
>  unsigned long last_sym_value = 0;
>
> -static inline char tolower(char c)
> +static inline char to_lower(char c)
>  {
>         if (c >= 'A' && c <= 'Z')
>                 c += ('a' - 'A');
>         return c;
>  }
>
> -static inline char toupper(char c)
> +static inline char to_upper(char c)
>  {
>         if (c >= 'a' && c <= 'z')
>                 c -= ('a' - 'A');
> @@ -54,7 +54,7 @@ int dump_ksym(struct bpf_iter__ksym *ctx)
>         type = iter->type;
>
>         if (iter->module_name[0]) {
> -               type = iter->exported ? toupper(type) : tolower(type);
> +               type = iter->exported ? to_upper(type) : to_lower(type);
>                 BPF_SEQ_PRINTF(seq, "0x%llx %c %s [ %s ] ",
>                                value, type, iter->name, iter->module_name);
>         } else {
> --
> 2.34.1
>
