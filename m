Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC75610262
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 22:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236865AbiJ0UKO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 16:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbiJ0UKM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 16:10:12 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609132CC9D;
        Thu, 27 Oct 2022 13:10:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id sc25so7796532ejc.12;
        Thu, 27 Oct 2022 13:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7qkzsPf4Wsy3Ys2sVKTyt+Eo/JlciSvXArZDH9fmiY=;
        b=l5gaCDVVhGQ8Y5EquY6I9Ojcw/dlIjSsABW1ecEFamptjjW1cnav6ZSYH/ssMqYhWv
         8U8+rS9UiOElwdoXBq7KsG/SJjl8f+d8dm4xqnMGE/Ynda08atIgTGlQltUIh0oirbN8
         /XaQkWc6PrcPeSELQyQI3cEOseDU2kR2rPpMM/bKOGeyXVroRwfrNZqJMAtOOHLB5RAd
         YLZoao0V0CAVDpZVthi/e+udKyu7ABs7AAFQB8lRpefedXFSfA2MxFB9TlweOEQJbYVp
         Hz7jXwbUzorSi1x9gqoaO/VZieBlWSlsgaWKwdEojYHzY2RCZBqU1hm86+0nj8/j3zbz
         gS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7qkzsPf4Wsy3Ys2sVKTyt+Eo/JlciSvXArZDH9fmiY=;
        b=qsD8Cd6Uh4tQoO0zfi2AL/MgxCsIqn4C7bFDBHHviKkprczbOMc2NfCQntl66VB1dX
         1Nw/e6vTAjxTIreW3YkJtlFvrxNBgaonrhvdmo+KqUl+BUeXGBvZOATXX/H6fDyOtDlB
         XS1cKCW8BjsH4zTn+pnu4auqk6dZHMXs5YUOIz/uXKW/lT5w5OhN3TLvGEx+HpsoAOVd
         yP2GGMG0qAUiNKbV9nihtXhC1y/sKlfCodUMJ71RJ3qWuJgVLB966Sfwy3tE0EwDTkyy
         1lb120eUjO31midfyfaL5oz9RmfdgjYXAYt4z1d2hvasBnkscIYQBwb7m3vDVCvB53W2
         BJCQ==
X-Gm-Message-State: ACrzQf2ymaKt2B1i8rul0enc0sB2fGwaCRogxC4LSG+sDfHNkSNGiPj7
        4S2U8IGddyno24PtHwkGOx9VjGeO0F3YiSfQnIs=
X-Google-Smtp-Source: AMsMyM7TYEM2Cx88wDUSsE2LXMvlu6hNz/jx1bxb/M96kqza4kf5VyNmt9ecjeFZcJqrhMEmBQsLVGf9yf27k2D2RhE=
X-Received: by 2002:a17:907:2d91:b0:78d:8747:71b4 with SMTP id
 gt17-20020a1709072d9100b0078d874771b4mr43697599ejc.545.1666901409929; Thu, 27
 Oct 2022 13:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_EE3E19F80ACD66955D26A878BC768CFA210A@qq.com>
In-Reply-To: <tencent_EE3E19F80ACD66955D26A878BC768CFA210A@qq.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 27 Oct 2022 13:09:57 -0700
Message-ID: <CAEf4Bzbq0PSsc6xCGSF=Af-pcysjt8Lv76-4N65AJMpXOOpOcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix strncpy() fortify warning
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Rong Tao <rongtao@cestc.cn>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" 
        <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Oct 27, 2022 at 4:34 AM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Compile samples/bpf, error:
> $ cd samples/bpf
> $ make
> ...
> In function =E2=80=98__enable_controllers=E2=80=99:
> samples/bpf/../../tools/testing/selftests/bpf/cgroup_helpers.c:80:17: war=
ning: =E2=80=98strncpy=E2=80=99 specified bound 4097 equals destination siz=
e [-Wstringop-truncation]
>    80 |                 strncpy(enable, controllers, sizeof(enable));
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  tools/testing/selftests/bpf/cgroup_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing=
/selftests/bpf/cgroup_helpers.c
> index e914cc45b766..a70e873b267e 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -77,7 +77,7 @@ static int __enable_controllers(const char *cgroup_path=
, const char *controllers
>                 enable[len] =3D 0;
>                 close(fd);
>         } else {
> -               strncpy(enable, controllers, sizeof(enable));
> +               strncpy(enable, controllers, sizeof(enable) - 1);

enable is not initialized, so we might end up with non-zero-terminated
string. Let's enable[0] =3D '\0'; at the beginning and then strncat()
here?

>         }
>
>         snprintf(path, sizeof(path), "%s/cgroup.subtree_control", cgroup_=
path);
> --
> 2.31.1
>
