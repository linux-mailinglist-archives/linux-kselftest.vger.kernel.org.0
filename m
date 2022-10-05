Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE15F5D06
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 01:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJEXET (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEXES (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 19:04:18 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A28E8559C;
        Wed,  5 Oct 2022 16:04:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-35ceeae764dso2815427b3.4;
        Wed, 05 Oct 2022 16:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dZaNz1pzQi1epRSfLigI6QZ/E9hSkPxllAw4SwzkTA0=;
        b=Yb0fwn3nuUtB7A4O2nb5i95beKvK7pOkkOL0dBgrb8IZJFVjlvkzmIJgmViiLUVb0E
         DCdSYQ+m7UWT6nR6kR1BRreRwIaWW4U7bHiugL5jPdUvwVMRcAzt/xJpTxAi66dE2SG1
         ItFjkD6hnFs8RSbNuhK9StcWV12Rz34k9Nbf7xNPcoajW6xlfmMsXSib+ZRa7EQ7sUv1
         Csk4KPjIH/vCwLA4JBTnAgWQVFuclRPq5oh2hfZbYEbHMm36nvaRY2Y1P3Jmcui3v+C0
         nWf2lv3blrpLTkCj1CSy+aVStQmk7a9GWMtI+Gg4fPPpf6a4Ro3YAUep14iuhn6V4oEr
         xvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZaNz1pzQi1epRSfLigI6QZ/E9hSkPxllAw4SwzkTA0=;
        b=yKHTUtxRwabSbv5Jd7Ke5OQWEASVMF+K0zfevhq/YdOunGJ9rLs8IeuDpm6BVgHKku
         lzo/dOe0lV0QvzvnIZ9QQjHPZEmp933KLRD10azysrP8OJhycSqKXzlz0yMhpLSlBED7
         p4fzQCe95Z0q0WkL6vP5uL2fsAL37P5mwiQIZoBCnRFaaQOBO6Y/XltEZtGuKhRTAgBi
         7ZSCUIzheRM/eQqAOs+VBjYtcxVlygI0Rly2e+++FBvobOKALx8a+g6WtgrS4VUuvNDl
         TY6iBJyaiRUw6BnMVyNFFkGO+kmLha6nkJDlfA+tq7b3ZV8vczcuTtt0dbjykPE+Y2lG
         7A3Q==
X-Gm-Message-State: ACrzQf1rtQi9jfUXNIMK/zK9htzL8M7Q0aI96qAEnf7g9qCCSpiemTB2
        LlEEudajXMQ5RTFCE0jQ2r16oFoQIVzaUjkr7BI=
X-Google-Smtp-Source: AMsMyM712/OQJaHW071yNXGMW+ozmWYfCCrrv5e4dFJMZLILTTYuyBylZdOVm+K5Sf4sKt0xLwiZ4m8jBrqdWE7i2uE=
X-Received: by 2002:a0d:df0b:0:b0:358:83d4:95a2 with SMTP id
 i11-20020a0ddf0b000000b0035883d495a2mr2024360ywe.475.1665011056641; Wed, 05
 Oct 2022 16:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com> <20221004131750.2306251-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221004131750.2306251-3-roberto.sassu@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 16:04:03 -0700
Message-ID: <CAEf4Bzby0g3o3i07p-irS4NupQFO+eer6TOageEBOJEdWvz1ZA@mail.gmail.com>
Subject: Re: [RESEND][PATCH 2/6] libbpf: Define bpf_get_fd_opts and introduce bpf_map_get_fd_by_id_opts()
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
>  tools/lib/bpf/bpf.c      | 12 +++++++++++-
>  tools/lib/bpf/bpf.h      | 10 ++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 22 insertions(+), 1 deletion(-)
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
> index 9c50beabdd14..c60eda3c88ad 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -365,7 +365,17 @@ LIBBPF_API int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
>  LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
> +
> +struct bpf_get_fd_opts {

should we call it "bpf_get_fd_by_id_opts" ? kernel command is
specifically about getting object FD by its external ID, so let's
reflect this in the name?

Otherwise it looks good.


> +       size_t sz; /* size of this struct for forward/backward compatibility */
> +       __u32 open_flags; /* permissions requested for the operation on fd */
> +       size_t :0;
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
> index 04fab9f1fdd7..2e665b21d84f 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -371,6 +371,7 @@ LIBBPF_1.0.0 {
>
>  LIBBPF_1.1.0 {
>         global:
> +               bpf_map_get_fd_by_id_opts;
>                 user_ring_buffer__discard;
>                 user_ring_buffer__free;
>                 user_ring_buffer__new;
> --
> 2.25.1
>
