Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079CE5F5D0F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 01:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiJEXHB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 19:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEXHA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 19:07:00 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A540857D7;
        Wed,  5 Oct 2022 16:06:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id b145so399897yba.0;
        Wed, 05 Oct 2022 16:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FmImwKatnMwbFulNzGw3sRM/1NjJtezQ9bl/fz9hQTc=;
        b=JefZ4ZlrnfEPRiZxSl7bQ8/CvH5MuUBBTDrYGiueAVz7XyQrGQhtgC2vUBZ8viKzkz
         700xK66FJwez1MSQq6JtWMTPEUjh+jwfW6NasVaztWFz/CgDRu3PVU23J3MEsgvq9N9O
         9l8iGZrAks162LaJzfDxLJhgpmfcY+oNKsVKvBGaP49m6ehuzGMOZLE3LV1U4RQ2Yfmh
         NkTvlkdhL3JRwdefCi+JNx6I8rVIMQbj8Y0PdAi22sJUmCjBFfC9j9Xz28+Hjlvg4pll
         o10MMafSnLTYnh9wnDp6F2Wwooukz9rcZRUPAP/HWlDpoNVIgT6aiyAnhwc0r9GYXySl
         jQwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FmImwKatnMwbFulNzGw3sRM/1NjJtezQ9bl/fz9hQTc=;
        b=7dOIhMJMmhIg+8OB3TZeRGnfxJkYuVmZXVyRzb/L/tYbFqLLtunI3m+G6yxtsDTy7e
         n1eqojUaXIP7ffvINY1MJapIDLK6m1B43F6xLRbCup4qt8KQ5kKYSmAASD6IzNLFyPb/
         mGW4zI6mde0vknFKTzw1SHEG+NBd11Vr/zLAPsTm/K9S46HFv2CgfdauG53xlbWkFpNA
         yeGbRtoznD+Y2NbAFyqyvwp14dCb1G5fXgbC8AwX1b9Ef9SPnc/cAKCjIHfHxN8gaZPw
         bsJHmtSWNnzG/4Rf9ajBwgh0636tlZeVGf0o5RHlEUCR9Zm3HosallFokqUM/bcnzpz3
         Tw0w==
X-Gm-Message-State: ACrzQf2RRO/IfAhvGyQMOPHDDNgKI/3Cbfea3D/EI0DOgBuIT+iXeUm3
        1ZC2OMTyPtA1uAEwhXelw6d+8BsvrjZ7SIEaYss=
X-Google-Smtp-Source: AMsMyM6hgHAL9ud1h7kcp37MU46mb8sHpbWZglKDHHju/Us8wJOB/fgSwln0AX4Hhj2baQ55J8hwll/wcwKBSplFesI=
X-Received: by 2002:a25:6d88:0:b0:6be:6dbd:c477 with SMTP id
 i130-20020a256d88000000b006be6dbdc477mr2140673ybc.385.1665011216127; Wed, 05
 Oct 2022 16:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com> <20221004131750.2306251-5-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221004131750.2306251-5-roberto.sassu@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 16:06:43 -0700
Message-ID: <CAEf4BzZm1iEPyr2Q3L+95JdC4H11dq1AGw1FiOH0XCRHaCzigg@mail.gmail.com>
Subject: Re: [RESEND][PATCH 4/6] libbpf: Introduce bpf_btf_get_fd_by_id_opts()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        shuah@kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
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

On Tue, Oct 4, 2022 at 6:18 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce bpf_btf_get_fd_by_id_opts(), for symmetry with
> bpf_map_get_fd_by_id_opts(), to let the caller pass the newly introduced
> data structure bpf_get_fd_opts. Keep the existing bpf_btf_get_fd_by_id(),
> and call bpf_btf_get_fd_by_id_opts() with NULL as opts argument, to prevent
> setting open_flags.
>
> Currently, the kernel does not support non-zero open_flags for
> bpf_btf_get_fd_by_id_opts(), and a call with them will result in an error
> returned by the bpf() system call. The caller should always pass zero
> open_flags.
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/lib/bpf/bpf.c      | 12 +++++++++++-
>  tools/lib/bpf/bpf.h      |  2 ++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 92464c2d1da7..f43e8c8afbd3 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -980,19 +980,29 @@ int bpf_map_get_fd_by_id(__u32 id)
>         return bpf_map_get_fd_by_id_opts(id, NULL);
>  }
>
> -int bpf_btf_get_fd_by_id(__u32 id)
> +int bpf_btf_get_fd_by_id_opts(__u32 id,
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
>         attr.btf_id = id;
> +       attr.open_flags = OPTS_GET(opts, open_flags, 0);
>
>         fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
> +int bpf_btf_get_fd_by_id(__u32 id)
> +{
> +       return bpf_btf_get_fd_by_id_opts(id, NULL);
> +}
> +
>  int bpf_link_get_fd_by_id(__u32 id)
>  {
>         const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 595d342fb7f9..559af0b84299 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -379,6 +379,8 @@ LIBBPF_API int bpf_prog_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_map_get_fd_by_id_opts(__u32 id,
>                                          const struct bpf_get_fd_opts *opts);
>  LIBBPF_API int bpf_map_get_fd_by_id(__u32 id);
> +LIBBPF_API int bpf_btf_get_fd_by_id_opts(__u32 id,
> +                                        const struct bpf_get_fd_opts *opts);

It's subjective, but opts variants of APIs, being more "advanced"
usually are listed after their simpler non-opts variants. Can you
please add new _opts APIs after their non-opts variants?

>  LIBBPF_API int bpf_btf_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_link_get_fd_by_id(__u32 id);
>  LIBBPF_API int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c3604eaa220d..7011d5eec67b 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -371,6 +371,7 @@ LIBBPF_1.0.0 {
>
>  LIBBPF_1.1.0 {
>         global:
> +               bpf_btf_get_fd_by_id_opts;
>                 bpf_map_get_fd_by_id_opts;
>                 bpf_prog_get_fd_by_id_opts;
>                 user_ring_buffer__discard;
> --
> 2.25.1
>
