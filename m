Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2A1372D41D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 00:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238594AbjFLWHh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 18:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238519AbjFLWHh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 18:07:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E674E1;
        Mon, 12 Jun 2023 15:07:35 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f620583bc2so5737287e87.1;
        Mon, 12 Jun 2023 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607654; x=1689199654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcHe4XpFq0AW2AUqP2k4N8qIUXEU3zKguGq7BXWzAdE=;
        b=jHgOf0AWqjxtbfSi/mnme0SxvQEIzX1iEXtrpvJsUaatCv4uINA30hRmB5lJuuGcM2
         Swo6zESQOUraHapg+ZHN6LUEGw3SHwyCOF7reaaFSIJ0X6OO1W0Thj6iKzsj3cExjYlC
         zS6mph96er0FeY5w7lGyVqQnjmaTwqciwvzbWym5IziLfJocYwcqAE3GXCW6Raeu4U7m
         TFFSZyCdWlZoT+WlaQ6yQ4UuRqHApLShhDggLbaYpLb5irBMQgI+2WA0b3UpjgSmLPNj
         /TarMdUTakduM0kIsfwT59AzXp8dK8bbn0gKGGblFdMYzvZdwYSRoAE+wrZRMShjFWxQ
         /OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607654; x=1689199654;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mcHe4XpFq0AW2AUqP2k4N8qIUXEU3zKguGq7BXWzAdE=;
        b=eBbUXqW8NrgnR69S7lHjkfgcS361gUuXiZBN7EBuzH2cd/n+qLd2BaxOcBmZ+yrJwD
         wd8DkgZqCcszSdSSA6ZU3WZ8iaa32HeqwhX8AJSJAcmZZPfJBDLMI7Y2N68cNraOgbgF
         Rtn1cI2medzeGkOkCvJ+484bNteXklVH0UJ18jcXzRcw8xLvww/6Hz99YD5F4ad0nSCr
         HjI6yjv0KPsLYahjLodKHzY0rZR9ku+QQclNYHJb8bTPnVP2byCQ0DWj373y85B/e/+C
         9zPTCFBTbUkcoEjJqGyu2cBSUdM74SzY/jXB/bzQDWAMwahIMlAM/8fAhYiDNXINKNeR
         82hw==
X-Gm-Message-State: AC+VfDzKTTeBofvWnX7NYD3JYsiPtYsUS4I6WFYwBernGr+q8++zN6rm
        EvVcdVUYnKpOQUZsjNgP9ihqhVITKPZ17ZaXNzE=
X-Google-Smtp-Source: ACHHUZ6JueSPOeP2I+jZk3U364o996ITHBauYMOpKEvV2emdY5w+CaYkyu1MYxkEEWt/1UVBmUf0lcuuUqa9/OsQpGw=
X-Received: by 2002:a2e:9bd3:0:b0:2ae:db65:2d01 with SMTP id
 w19-20020a2e9bd3000000b002aedb652d01mr3555485ljj.23.1686607653334; Mon, 12
 Jun 2023 15:07:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1686268304.git.kjlx@templeofstupid.com> <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
 <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com> <ef33f004f1f20c7a4cc7c963eea628df7bec0c53.camel@linux.ibm.com>
In-Reply-To: <ef33f004f1f20c7a4cc7c963eea628df7bec0c53.camel@linux.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 12 Jun 2023 15:07:22 -0700
Message-ID: <CAADnVQLWNt0KsXoYVGFD0i089YMivYJ+ZeWmutUiefcdK=eOrw@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram extables
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Krister Johansen <kjlx@templeofstupid.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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

On Mon, Jun 12, 2023 at 6:46=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> On Fri, 2023-06-09 at 11:15 -0700, Alexei Starovoitov wrote:
> > On Thu, Jun 8, 2023 at 5:11=E2=80=AFPM Krister Johansen
> > <kjlx@templeofstupid.com> wrote:
> > >
> > > In certain situations a program with subprograms may have a NULL
> > > extable entry.  This should not happen, and when it does, it turns
> > > a
> > > single trap into multiple.  Add a test case for further debugging
> > > and to
> > > prevent regressions.  N.b: without any other patches this can panic
> > > or
> > > oops a kernel.
> > >
> > > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > > ---
> > >  .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
> > >  .../bpf/progs/test_subprogs_extable.c         | 46
> > > +++++++++++++++++++
> > >  2 files changed, 77 insertions(+)
> > >  create mode 100644
> > > tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > >  create mode 100644
> > > tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > >
> > > diff --git
> > > a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > new file mode 100644
> > > index 000000000000..2201988274a4
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > @@ -0,0 +1,31 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include <test_progs.h>
> > > +#include "test_subprogs_extable.skel.h"
> > > +
> > > +void test_subprogs_extable(void)
> > > +{
> > > +       const int READ_SZ =3D 456;
> > > +       struct test_subprogs_extable *skel;
> > > +       int err;
> > > +
> > > +       skel =3D test_subprogs_extable__open();
> > > +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> > > +               return;
> > > +
> > > +       err =3D test_subprogs_extable__load(skel);
> > > +       if (!ASSERT_OK(err, "skel_load"))
> > > +               goto cleanup;
> > > +
> > > +       err =3D test_subprogs_extable__attach(skel);
> > > +       if (!ASSERT_OK(err, "skel_attach"))
> > > +               goto cleanup;
> > > +
> > > +       /* trigger tracepoint */
> > > +       ASSERT_OK(trigger_module_test_read(READ_SZ),
> > > "trigger_read");
> > > +
> > > +       test_subprogs_extable__detach(skel);
> > > +
> > > +cleanup:
> > > +       test_subprogs_extable__destroy(skel);
> > > +}
> > > diff --git
> > > a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > new file mode 100644
> > > index 000000000000..c3ff66bf4cbe
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > @@ -0,0 +1,46 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +#include "vmlinux.h"
> > > +#include <bpf/bpf_helpers.h>
> > > +#include <bpf/bpf_tracing.h>
> > > +
> > > +struct {
> > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > +       __uint(max_entries, 8);
> > > +       __type(key, __u32);
> > > +       __type(value, __u64);
> > > +} test_array SEC(".maps");
> > > +
> > > +static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val,
> > > void *data)
> > > +{
> > > +       return 1;
> > > +}
> > > +
> > > +SEC("fexit/bpf_testmod_return_ptr")
> > > +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> > > +{
> > > +       *(volatile long *)ret;
> > > +       *(volatile int *)&ret->f_mode;
> > > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("fexit/bpf_testmod_return_ptr")
> > > +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file
> > > *ret)
> > > +{
> > > +       *(volatile long *)ret;
> > > +       *(volatile int *)&ret->f_mode;
> > > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > > +       return 0;
> > > +}
> > > +
> > > +SEC("fexit/bpf_testmod_return_ptr")
> > > +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file
> > > *ret)
> > > +{
> > > +       *(volatile long *)ret;
> > > +       *(volatile int *)&ret->f_mode;
> > > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > > +       return 0;
> > > +}
> >
> > What is the point of attaching 3 the same progs to the same hook?
> > One would be enough to test it, no?
> >
> > In other news...
> > Looks like this test is triggering a bug on s390.
> >
> > Ilya,
> > please take a look:
> > https://github.com/kernel-patches/bpf/actions/runs/5216942096/jobs/9416=
404780
> >
> > bpf_prog_78c0d4c618ed2df7_handle_fexit_ret_subprogs3
> > is crashing the kernel.
> > A bug in extable logic on s390?
>
> I think we also need this:
>
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17664,6 +17664,7 @@ static int jit_subprogs(struct bpf_verifier_env
> *env)
>         prog->bpf_func =3D func[0]->bpf_func;
>         prog->jited_len =3D func[0]->jited_len;
>         prog->aux->extable =3D func[0]->aux->extable;
> +       prog->aux->num_exentries =3D func[0]->aux->num_exentries;
>         prog->aux->func =3D func;
>         prog->aux->func_cnt =3D env->subprog_cnt;
>         bpf_prog_jit_attempt_done(prog);
>
> The reason is that s390 JIT doubles the number of extable entries due
> to how the hardware works (some exceptions point to the failing insn,
> some point to the next one).
>
> With that:
>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
>
> for the v4 series.

Great.

Krister,
could you please resubmit v5 adding the above change and Ilya's tags to pat=
ch 1?

I'd like to see green BPF CI on all platforms before landing.
