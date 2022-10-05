Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F715F5D1F
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Oct 2022 01:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiJEXOD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 5 Oct 2022 19:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJEXNu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 5 Oct 2022 19:13:50 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E1C857E6;
        Wed,  5 Oct 2022 16:13:46 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-35ad0584879so2851427b3.7;
        Wed, 05 Oct 2022 16:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gmiz/wuNnU8BZdDy2S10cD1cwP8umQKlztbKDOp2EKw=;
        b=dYgEN6ksrYxelG57QYh2+PSV+Ecohh5DH9UbAU4GTxum9xRA4pxPhqBbjYOJrKu44D
         E5TemwmsZuDLwaDZdSB0WaFQRa1uFOqqC88MjzpFZOeVXp8hLHabJvkYExeWS0dP/4yv
         YjVUxxRhtN82zKXo6bRfmRl5ltHB39EZyGICbule0UL8LbQUyFYo48l868lAUj46e6ta
         ZfY7FfaVfFHDwSBRClLhbEfTfjHJOFtTgdO8Cbv1MmEfi2cdqPcQGi2Q5RfuEqea178w
         6z7aV54Pvxu1R2pTwlQXFPTwWagj6UCElTpfIqQ+gP/FQBxK00gQcO7a/NHAm1Yk/xwI
         n+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gmiz/wuNnU8BZdDy2S10cD1cwP8umQKlztbKDOp2EKw=;
        b=8A/F+87w6LZ+QuhlogcupFiMrTVlkAekQ5wYkIO7erlqHCEK5qZSfzbqWqv2mTMkx8
         dEoG5DmGNdKPCazbe/qnQmiVqy4IwOgvcxWHobwbM2ymNL75xvG9XIk5tmlWJjSgr/Xo
         dMnrEiEYAHg6mMcFjW4Xzh+7YYYgmdbzlHKpIkjVXLbeHUG6hHATLD02bx+KPfPmj4YY
         YJ2nxRH7HxWX3b3misue+akCQA6Yog9Xih0rZwc0e3CF6AUQxHA9a/yOWE0V/RvkbQtn
         1iVmVfU0SRZ/2IY6G05HwMWV8r9COyvhlsb9oXj7HRbXGxKv0I6ywujBWYtkWLs7VCG8
         M4fw==
X-Gm-Message-State: ACrzQf1NW9BPosGiL8qSb8luwS/N1xLWGrfk/r94i9gTNcXEqiNvshgH
        0BvI4/rJIh8KCflFeNG7jL/93q04A6KhvB4cteU=
X-Google-Smtp-Source: AMsMyM5PGzQ9/vAC1OSujXUtannPqYLHhSMSF7H/bx0eBZv8/dG2fNZnxjAeIg8P7R36q7uRxYm2CTbsY3+/mcBzXEw=
X-Received: by 2002:a81:4b96:0:b0:354:8935:d5a9 with SMTP id
 y144-20020a814b96000000b003548935d5a9mr2188964ywa.36.1665011625915; Wed, 05
 Oct 2022 16:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221004131750.2306251-1-roberto.sassu@huaweicloud.com> <20221004131750.2306251-7-roberto.sassu@huaweicloud.com>
In-Reply-To: <20221004131750.2306251-7-roberto.sassu@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 16:13:33 -0700
Message-ID: <CAEf4BzaYojpVNrbr+jVOmwcQh3GS8eY6fPGcz-7KeO=XubAZZw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 6/6] selftests/bpf: Add tests for _opts variants
 of bpf_*_get_fd_by_id()
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

On Tue, Oct 4, 2022 at 6:19 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the data_input map, write-protected with a small eBPF program
> implementing the lsm/bpf_map hook.
>
> Then, ensure that bpf_map_get_fd_by_id() and bpf_map_get_fd_by_id_opts()
> with NULL opts don't succeed due to requesting read-write access to the
> write-protected map. Also, ensure that bpf_map_get_fd_by_id_opts() with
> open_flags in opts set to BPF_F_RDONLY instead succeeds.
>
> After obtaining a read-only fd, ensure that only map lookup succeeds and
> not update. Ensure that update works only with the read-write fd obtained
> at program loading time, when the write protection was not yet enabled.
>
> Finally, ensure that the other _opts variants of bpf_*_get_fd_by_id() don't
> work if the BPF_F_RDONLY flag is set in opts (due to the kernel not
> handling the open_flags member of bpf_attr).
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  tools/testing/selftests/bpf/DENYLIST.s390x    |  1 +
>  .../bpf/prog_tests/libbpf_get_fd_opts.c       | 88 +++++++++++++++++++
>  .../bpf/progs/test_libbpf_get_fd_opts.c       | 36 ++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_libbpf_get_fd_opts.c
>
> diff --git a/tools/testing/selftests/bpf/DENYLIST.s390x b/tools/testing/selftests/bpf/DENYLIST.s390x
> index 17e074eb42b8..780a9b2090ad 100644
> --- a/tools/testing/selftests/bpf/DENYLIST.s390x
> +++ b/tools/testing/selftests/bpf/DENYLIST.s390x
> @@ -75,3 +75,4 @@ user_ringbuf                             # failed to find kernel BTF type ID of
>  lookup_key                               # JIT does not support calling kernel function                                (kfunc)
>  verify_pkcs7_sig                         # JIT does not support calling kernel function                                (kfunc)
>  kfunc_dynptr_param                       # JIT does not support calling kernel function                                (kfunc)
> +libbpf_get_fd_opts                       # failed to attach: ERROR: strerror_r(-524)=22                                (trampoline)
> diff --git a/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
> new file mode 100644
> index 000000000000..2d4ba8f80d55
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/libbpf_get_fd_opts.c
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2022 Huawei Technologies Duesseldorf GmbH
> + *
> + * Author: Roberto Sassu <roberto.sassu@huawei.com>
> + */
> +
> +#include <test_progs.h>
> +
> +#include "test_libbpf_get_fd_opts.skel.h"
> +
> +void test_libbpf_get_fd_opts(void)
> +{
> +       struct test_libbpf_get_fd_opts *skel;
> +       struct bpf_map_info info_m = { 0 };

1) this 0 is misleading, it's initializing only first field
(explicitly), all the other ones are implicitly initialized with
zeroes as well. In short, just use = {} to zero-initialize structs, in
general.

> +       __u32 len = sizeof(info_m), value;
> +       struct bpf_map *map;
> +       int ret, zero = 0, fd = -1;
> +
> +       DECLARE_LIBBPF_OPTS(bpf_get_fd_opts, fd_opts_rdonly,
> +               .open_flags = BPF_F_RDONLY,
> +       );

LIBBPF_OPTS() macro defines variable, so don't add empty line before
it, it should be part of variable declaration section. Also use
shorter LIBBPF_OPTS() macro instead.


> +
> +       skel = test_libbpf_get_fd_opts__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "test_libbpf_get_fd_opts__open_and_load"))
> +               return;
> +
> +       ret = test_libbpf_get_fd_opts__attach(skel);
> +       if (!ASSERT_OK(ret, "test_libbpf_get_fd_opts__attach"))
> +               goto close_prog;
> +
> +       map = bpf_object__find_map_by_name(skel->obj, "data_input");
> +       if (!ASSERT_OK_PTR(map, "bpf_object__find_map_by_name"))
> +               goto close_prog;

why find_map_by_name, you have that same map as skel->maps.data_input

> +
> +       ret = bpf_obj_get_info_by_fd(bpf_map__fd(map), &info_m, &len);
> +       if (!ASSERT_OK(ret, "bpf_obj_get_info_by_fd"))
> +               goto close_prog;

[...]

> +       /* BTF get fd with opts set should not work (no kernel support). */
> +       ret = bpf_btf_get_fd_by_id_opts(0, &fd_opts_rdonly);
> +       ASSERT_EQ(ret, -EINVAL, "bpf_btf_get_fd_by_id_opts");
> +
> +close_prog:
> +       close(fd);

if (fd >= 0) is missing

> +       test_libbpf_get_fd_opts__destroy(skel);
> +}

[...]
