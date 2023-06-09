Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC4D72A1EF
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jun 2023 20:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFISQH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 14:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjFISQG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 14:16:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DA535A9;
        Fri,  9 Jun 2023 11:15:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b1adf27823so23697641fa.2;
        Fri, 09 Jun 2023 11:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686334530; x=1688926530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cjni4d3UMj1znH7uhH7utbW9YPqd4ueWaeLPtTPh3wY=;
        b=OB8fokvltk+wBSHhCvaF2w42HaAb0n47rWuoa9s8ArbiQZeVG++WwLE+0o4GUK5270
         6SvbsFcdkPHkBnuQJ0vDHcAeI8/NXfD7zcERvnM3HlCWyV84R4geQ5zTnaM9GwnIvvb9
         d/E719YsGqlgTEpaf0lgjRoyYNcpxEh/OHSI2GRWEXBWyzJNun0HL4kl0WARAPpMr+MT
         jb6i4IlJnOJyVWF8kJso8KS9eJSLOYrC0kGRA05ZZJGEddCn//h+uL1Yc4RshfQWBIlc
         R6uksC73UK2ge3Cga6yR1qMSIK3kWZ17ibd+6UIgjSGBzPeKVScAEfznl87zx66GDQDf
         ejtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686334530; x=1688926530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cjni4d3UMj1znH7uhH7utbW9YPqd4ueWaeLPtTPh3wY=;
        b=OVFBjMP7af00prR1NlFly/vHDBgRikW4UgEl0cWJS2x3d/DvUJWVXGJk+2yCZ37rmp
         AWYyDeHQDZIcMGNADhwahqIH+DKL1XrtUD//VX+OLIOPoor4ZWIeyNZtC5jNRsBC6gHu
         A2ZPt8I80b0Tt1BD87ou9xFdmqYLGduRenzhAjODUsnfKsBPVbgwu8PC0kX68ptRvM1D
         YKnkfVmF4UtWmQ5Gs6qMGFtcM8pLdLC/zoUo3CwlyaLVyRX5pYHFdI6gJDblDcgcH+6w
         kezWBcjxVFGt/MSScah7wlXUpU5v3bcqgZi2EB2CNmcRBR7fmCxd12j4io8thVejQXhd
         XgWw==
X-Gm-Message-State: AC+VfDy6U4HEn9Hx3fp61sBFe+m5EYkMOY6reXNkUDbjLClP0JXLPm1I
        rYqepgZ0FwJYI4grfNcBQEui417csVcpmvrb+M8=
X-Google-Smtp-Source: ACHHUZ6RtEPqFERBttErWzMg11zUQtRHZj2x4PNuSQfcx45XA7jymugK/ta25HLDUZ7HmaxAgw4Ypp7oVutQejx8Jqw=
X-Received: by 2002:a2e:924d:0:b0:2b1:a89a:5f2b with SMTP id
 v13-20020a2e924d000000b002b1a89a5f2bmr1648988ljg.2.1686334530025; Fri, 09 Jun
 2023 11:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686268304.git.kjlx@templeofstupid.com> <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
In-Reply-To: <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Jun 2023 11:15:18 -0700
Message-ID: <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram extables
To:     Krister Johansen <kjlx@templeofstupid.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jun 8, 2023 at 5:11=E2=80=AFPM Krister Johansen <kjlx@templeofstupi=
d.com> wrote:
>
> In certain situations a program with subprograms may have a NULL
> extable entry.  This should not happen, and when it does, it turns a
> single trap into multiple.  Add a test case for further debugging and to
> prevent regressions.  N.b: without any other patches this can panic or
> oops a kernel.
>
> Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> ---
>  .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
>  .../bpf/progs/test_subprogs_extable.c         | 46 +++++++++++++++++++
>  2 files changed, 77 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/subprogs_extab=
le.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_subprogs_extab=
le.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c b/=
tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> new file mode 100644
> index 000000000000..2201988274a4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "test_subprogs_extable.skel.h"
> +
> +void test_subprogs_extable(void)
> +{
> +       const int READ_SZ =3D 456;
> +       struct test_subprogs_extable *skel;
> +       int err;
> +
> +       skel =3D test_subprogs_extable__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       err =3D test_subprogs_extable__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto cleanup;
> +
> +       err =3D test_subprogs_extable__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       /* trigger tracepoint */
> +       ASSERT_OK(trigger_module_test_read(READ_SZ), "trigger_read");
> +
> +       test_subprogs_extable__detach(skel);
> +
> +cleanup:
> +       test_subprogs_extable__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c b/=
tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> new file mode 100644
> index 000000000000..c3ff66bf4cbe
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "vmlinux.h"
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY);
> +       __uint(max_entries, 8);
> +       __type(key, __u32);
> +       __type(value, __u64);
> +} test_array SEC(".maps");
> +
> +static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val, void *=
data)
> +{
> +       return 1;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> +{
> +       *(volatile long *)ret;
> +       *(volatile int *)&ret->f_mode;
> +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file *ret)
> +{
> +       *(volatile long *)ret;
> +       *(volatile int *)&ret->f_mode;
> +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +       return 0;
> +}
> +
> +SEC("fexit/bpf_testmod_return_ptr")
> +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file *ret)
> +{
> +       *(volatile long *)ret;
> +       *(volatile int *)&ret->f_mode;
> +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> +       return 0;
> +}

What is the point of attaching 3 the same progs to the same hook?
One would be enough to test it, no?

In other news...
Looks like this test is triggering a bug on s390.

Ilya,
please take a look:
https://github.com/kernel-patches/bpf/actions/runs/5216942096/jobs/94164047=
80

bpf_prog_78c0d4c618ed2df7_handle_fexit_ret_subprogs3
is crashing the kernel.
A bug in extable logic on s390?
