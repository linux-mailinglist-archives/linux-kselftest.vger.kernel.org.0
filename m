Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464D65F142A
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Sep 2022 22:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiI3Uv1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Sep 2022 16:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbiI3UvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Sep 2022 16:51:06 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CB513FEF8;
        Fri, 30 Sep 2022 13:51:03 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 29so7468735edv.7;
        Fri, 30 Sep 2022 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2uOxQ/gH+BgVfHcCDAltFHRafqSJpRPHbM8VX4eQrmE=;
        b=fs3yfrRRvR85fOrAE8GAeQyZ90fUrcsb8udC0e71buYHjY7T74pIwS4w8H6f0fvC1s
         eK1vQrVnAe11HDk8LzNmz0xfvfvSzsCz1ixvXx8fJu7+L1bNRcc0dHRJHZmDvPkRIlWm
         I1fJ72Y6Mrqo2iI86ZwRQ8DuriJW+M4cPlEtm26wRMz2IJEZTmfwc/4aA0/e/5X01Iz/
         kM32AzxGKVsgPsUg3kpMi15piKRvsb5ucsexXD2H8sMNDHTFJYcKuVXXfbc224KV7pyB
         0w75MjDrHvddHHvwM0/gmQp92smLeagbdaWPIfvWpJR/wMCK/vTnDO01/eXyipt43CPA
         iycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uOxQ/gH+BgVfHcCDAltFHRafqSJpRPHbM8VX4eQrmE=;
        b=hyHxQf9SE4zGuN+O8awkt86kalDjwrp8usfneYxuAQlHYC2kA/Jiv7aHr5WY/6K1Gt
         Jphz9j4KPxuTK7r143ZEXIzBY9S7j72bq8f2ixqbu5xADtg49iL8WwaFZMZH7Pa0Qils
         Ev3RoYpssRiJmLo56sUzNvyRytt8BBrvwpKrkivioLfJ85rR9EDFBq4AdtnSV/+uIL1Z
         R7qDG6YdVRI4nt6JJNKJ4gZrobc78DeZ76VPsB0RQWR1Ya0NFbtmJMmDV0srny51jdRs
         3Q5l6/EFbKsybLsL3J1jnTcGFS2oqKk4ajRXZAb1w4qTC9IdtEy4/D/1huoL3h2R9+mX
         Jolg==
X-Gm-Message-State: ACrzQf3Jte6G//qU9+xVE+67ZxPDi1uO5h+6+wtPmW1buOgfS424vcfI
        FEHW4uMHIiXE77fR+J2WQZinLc6nxeisPFjltWignHnD
X-Google-Smtp-Source: AMsMyM6EKTV3OYVPy0FeoJ4Q0c8PKaZ0YHnV+7MLNI7ACfUNUTYGxH23fggkidH07Wm5gwKzJTddxXJ7IeZ1U3oJHxc=
X-Received: by 2002:a50:eb05:0:b0:457:c6f5:5f65 with SMTP id
 y5-20020a50eb05000000b00457c6f55f65mr9072849edp.311.1664571061776; Fri, 30
 Sep 2022 13:51:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220926154430.1552800-1-roberto.sassu@huaweicloud.com> <20220926154430.1552800-2-roberto.sassu@huaweicloud.com>
In-Reply-To: <20220926154430.1552800-2-roberto.sassu@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 30 Sep 2022 13:50:49 -0700
Message-ID: <CAEf4BzZT3aSWYzaNrOW6Qw95mfj1S+AduGi+A0H+h4maTU2umQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/3] libbpf: Define bpf_get_fd_opts and introduce bpf_map_get_fd_by_id_opts()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, oss@lmb.io, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengc@google.com, davem@davemloft.net
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

On Mon, Sep 26, 2022 at 8:45 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Define a new data structure called bpf_get_fd_opts, with the member
> open_flags, to be used by callers of the _opts variants of
> bpf_*_get_fd_by_id() to specify the permissions needed for the file
> descriptor to be obtained.
>
> Also, introduce bpf_map_get_fd_by_id_opts(), to let the caller pass a
> bpf_get_fd_opts structure.
>
> Finally, keep the existing bpf_map_get_fd_by_id(), and call
> bpf_map_get_fd_by_id_opts() with NULL as opts argument, to request
> read-write permissions (current behavior).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---

looks good overall, but please see two nits below

>  tools/lib/bpf/bpf.c      | 12 +++++++++++-
>  tools/lib/bpf/bpf.h      | 10 ++++++++++
>  tools/lib/bpf/libbpf.map |  3 ++-
>  3 files changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 1d49a0352836..4b03063edf1d 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -948,19 +948,29 @@ int bpf_prog_get_fd_by_id(__u32 id)
>         return libbpf_err_errno(fd);
>  }
>
> -int bpf_map_get_fd_by_id(__u32 id)
> +int bpf_map_get_fd_by_id_opts(__u32 id,
> +                             const struct bpf_get_fd_opts *opts)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
>         union bpf_attr attr;
>         int fd;
>
> +       if (!OPTS_VALID(opts, bpf_get_fd_opts))
> +               return libbpf_err(-EINVAL);
> +
>         memset(&attr, 0, attr_sz);
>         attr.map_id = id;
> +       attr.open_flags = OPTS_GET(opts, open_flags, 0);
>
>         fd = sys_bpf_fd(BPF_MAP_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
> +int bpf_map_get_fd_by_id(__u32 id)
> +{
> +       return bpf_map_get_fd_by_id_opts(id, NULL);
> +}
> +
>  int bpf_btf_get_fd_by_id(__u32 id)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 9c50beabdd14..38a1b7eccfc8 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -365,7 +365,17 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
> +
> +struct bpf_get_fd_opts {
> +       size_t sz; /* size of this struct for forward/backward compatibility */
> +       __u32 open_flags; /* permissions requested for the operation on fd */
> +       __u32 :0;

this should be size_t: 0

> +};
> +#define bpf_get_fd_opts__last_field open_flags
> +
>  LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
> +LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
> +                                        const struct bpf_get_fd_opts *opts);
>  LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c1d6aa7c82b6..2e665b21d84f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -367,10 +367,11 @@ LIBBPF_1.0.0 {
>                 libbpf_bpf_map_type_str;
>                 libbpf_bpf_prog_type_str;
>                 perf_buffer__buffer;
> -};
> +} LIBBPF_0.8.0;
>

good catch, please send this as a separate fix, thanks!

>  LIBBPF_1.1.0 {
>         global:
> +               bpf_map_get_fd_by_id_opts;
>                 user_ring_buffer__discard;
>                 user_ring_buffer__free;
>                 user_ring_buffer__new;
> --
> 2.25.1
>
