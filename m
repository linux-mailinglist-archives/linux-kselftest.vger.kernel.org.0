Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C43FF3EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Sep 2021 21:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347254AbhIBTOv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Sep 2021 15:14:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243525AbhIBTOu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Sep 2021 15:14:50 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B80BC061575;
        Thu,  2 Sep 2021 12:13:52 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w8so3019301pgf.5;
        Thu, 02 Sep 2021 12:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HuFL9SrWt8TgOKWuzSN3+Eda4flwK1j2j+5Ge7i3JLw=;
        b=qO4BYhxpyh0i1oqhV7G9YySQQKZfdNcqJFO+wfkHzzUV2Ba9TYRU+xDxenUwUK+C+k
         fG7cfjiP0/pexV1JeaJjdgbuA3SKxpfz48MDa171THkUnn6ghNaaiLMRccIBxkWlHPvC
         VkeLlvGNCigis/CWSV5Qyq2LrPXYkXcVwgoak4YHDhycaGRvIzWDobeIoHSrSSh6KVtM
         oY30jCFL8lQUjBKF/iUW9c15iBUht6Vuw1zf5PBJWF1BcLnxqhCCyCGUmJGKvGXHoR+F
         B6Zip9qDznFBObOBbB0C6OSwpFSeRTO5x8TrblFUumbyWcO1kv1FzwIyDGaOsfBQeJOT
         x64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HuFL9SrWt8TgOKWuzSN3+Eda4flwK1j2j+5Ge7i3JLw=;
        b=ktxwIc8YGOKdXV3ysboKBdWtMdcnWbv+dOD7p6lCxDiVHVekoqqn42xNeoav0AIx60
         EAoI0Gt5/fg+OoY5+ED4CYV1W/uTGbuuoVcJEYC13xavzF1kwW7EgQllsbmbYMoZP7NX
         NPJSpeeWILh136fy4aIYFKIc8UEHAw4UWuv6GmWz/Lz7Qur4filWLy6IdcWC+udFWlgo
         IpzN9GWJCCc81qIY+TJNneFBCFunQ0QKbPhrW8SRXrRaShlXNgFe1203W3BiYPo1vZzG
         C01LJCGYfw8dUR05eNwNoFoYlzlqEem4RRAqaMvRmcmYlwIqsWC0iM3qC13wjmmJSVDi
         Rfkw==
X-Gm-Message-State: AOAM531PM25tLQhEZsNgPtvecj95OiU40/Ua16C/h8aI5T3ft9Q3JiUL
        b0zKi1cYb5z8OI/AgRntY0QMmC5UMVYcWWKE6Ro=
X-Google-Smtp-Source: ABdhPJxT7MoadrwNOWcLYHeTO19S+s7QOce9Sz9PQyW8nGHNAx9SkLSkk5zoYx4dVWPuYKhYm38T78u2i7m0XhRgVTo=
X-Received: by 2002:a63:ec45:: with SMTP id r5mr4690840pgj.440.1630610031377;
 Thu, 02 Sep 2021 12:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210902090925.2010528-1-jean-philippe@linaro.org>
In-Reply-To: <20210902090925.2010528-1-jean-philippe@linaro.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 2 Sep 2021 12:13:40 -0700
Message-ID: <CAADnVQKwHXw7fLGpJBJBb_MW+d1Gzexo2wk9QwE2v3fy=kHDRA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix build of task_pt_regs tests
 for arm64
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 2, 2021 at 2:08 AM Jean-Philippe Brucker
<jean-philippe@linaro.org> wrote:
>
> struct pt_regs is not exported to userspace on all archs. arm64 and s390
> export "user_pt_regs" instead, which causes build failure at the moment:
>
>   progs/test_task_pt_regs.c:8:16: error: variable has incomplete type 'struct pt_regs'
>   struct pt_regs current_regs = {};

Right, which is 'bpf_user_pt_regs_t'.
It's defined for all archs and arm64/s390/ppc/risv define it
differently from pt_regs.

>
> Use the multi-arch macros defined by tools/lib/bpf/bpf_tracing.h to copy
> the pt_regs into a locally-defined struct.
>
> Copying the user_pt_regs struct on arm64 wouldn't work because the
> struct is too large and the compiler complains about using too much
> stack.

That's a different issue.
I think the cleaner fix would be to make the test use
bpf_user_pt_regs_t instead.

> Fixes: 576d47bb1a92 ("bpf: selftests: Add bpf_task_pt_regs() selftest")
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>  .../selftests/bpf/bpf_pt_regs_helpers.h       | 30 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/task_pt_regs.c   |  1 +
>  .../selftests/bpf/progs/test_task_pt_regs.c   | 10 ++++---
>  3 files changed, 37 insertions(+), 4 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/bpf_pt_regs_helpers.h
>
> diff --git a/tools/testing/selftests/bpf/bpf_pt_regs_helpers.h b/tools/testing/selftests/bpf/bpf_pt_regs_helpers.h
> new file mode 100644
> index 000000000000..7531f4824ead
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/bpf_pt_regs_helpers.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __BPF_PT_REGS_HELPERS
> +#define __BPF_PT_REGS_HELPERS
> +
> +#include <bpf/bpf_tracing.h>
> +
> +struct bpf_pt_regs {
> +       unsigned long long parm[5];
> +       unsigned long long ret;
> +       unsigned long long fp;
> +       unsigned long long rc;
> +       unsigned long long sp;
> +       unsigned long long ip;
> +};
> +
> +static inline void bpf_copy_pt_regs(struct bpf_pt_regs *dest, struct pt_regs *src)
> +{
> +       dest->parm[0]   = PT_REGS_PARM1(src);
> +       dest->parm[1]   = PT_REGS_PARM2(src);
> +       dest->parm[2]   = PT_REGS_PARM3(src);
> +       dest->parm[3]   = PT_REGS_PARM4(src);
> +       dest->parm[4]   = PT_REGS_PARM5(src);
> +       dest->ret       = PT_REGS_RET(src);
> +       dest->fp        = PT_REGS_FP(src);
> +       dest->rc        = PT_REGS_RC(src);
> +       dest->sp        = PT_REGS_SP(src);
> +       dest->ip        = PT_REGS_IP(src);
> +}
> +
> +#endif /* __BPF_PT_REGS_HELPERS */
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> index 53f0e0fa1a53..196453b75937 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_pt_regs.c
> @@ -2,6 +2,7 @@
>  #define _GNU_SOURCE
>  #include <test_progs.h>
>  #include <linux/ptrace.h>
> +#include "bpf_pt_regs_helpers.h"
>  #include "test_task_pt_regs.skel.h"
>
>  void test_task_pt_regs(void)
> diff --git a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> index 6c059f1cfa1b..348da3509093 100644
> --- a/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> +++ b/tools/testing/selftests/bpf/progs/test_task_pt_regs.c
> @@ -5,8 +5,10 @@
>  #include <bpf/bpf_helpers.h>
>  #include <bpf/bpf_tracing.h>
>
> -struct pt_regs current_regs = {};
> -struct pt_regs ctx_regs = {};
> +#include "bpf_pt_regs_helpers.h"
> +
> +struct bpf_pt_regs current_regs = {};
> +struct bpf_pt_regs ctx_regs = {};
>  int uprobe_res = 0;
>
>  SEC("uprobe/trigger_func")
> @@ -17,8 +19,8 @@ int handle_uprobe(struct pt_regs *ctx)
>
>         current = bpf_get_current_task_btf();
>         regs = (struct pt_regs *) bpf_task_pt_regs(current);
> -       __builtin_memcpy(&current_regs, regs, sizeof(*regs));
> -       __builtin_memcpy(&ctx_regs, ctx, sizeof(*ctx));
> +       bpf_copy_pt_regs(&current_regs, regs);
> +       bpf_copy_pt_regs(&ctx_regs, ctx);
>
>         /* Prove that uprobe was run */
>         uprobe_res = 1;
> --
> 2.33.0
>
