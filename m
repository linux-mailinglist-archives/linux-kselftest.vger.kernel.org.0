Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E19872D431
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jun 2023 00:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbjFLWMd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Jun 2023 18:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbjFLWMc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Jun 2023 18:12:32 -0400
Received: from aye.elm.relay.mailchannels.net (aye.elm.relay.mailchannels.net [23.83.212.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373D110CB
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 15:12:30 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 792E2762B2C
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 22:12:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a251.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 033BC762C50
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 22:12:29 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686607949; a=rsa-sha256;
        cv=none;
        b=G7biQ7W1cTn5OGOd8dDSN+fZ9AbuhCXGIRX3cUgWsHSMusBynqNLShfdLctjCUPmttk9kx
        nGMLx6h/AIxtF/XfCrG0qsj2fsUrdDKa/iVqIGiTKYuj1j6M7I2jZjscElCtVLG00nU/Tw
        UgnRqFpeeujobAyKxmLq/TUbxr+sttOO3YV++ZM2k/7gXMNXJcr+W8qlB33W+fYPFKP0q2
        8IV/iQWrZyLoeE2nZN3AH8lLuPnYIkjd6c9SEMXNm4jvIEYaf7Gw08pk+nu01gAOW+W1eP
        j1BgFnwIEILksW4m4PAQumTS7CJqyADy5YgJUg0WcLyaTFzxgp7K91GnFn8G8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686607949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=Uw+jdfJkDSDc1rZ9hM9IyUE6VppD4X6NU4hjQZ4wAUI=;
        b=cV7Y3lZI5GfgT5R8swnkbXL+uIkqvWlOd77jh0aJyvbihDYdO42SMTYevrR9A5iYGDwMnZ
        +UeN+Gb2v43nzHawtkPWGqZ++SdqG/wUMXEdqTgEqqMwSWw/hKwrfl/BPjqDg6bRel+SVc
        jUfZo/aLtkuwZJeMOPX02yqYjH1CGfluaOytXLz7vE1eEVwYvOn9SCyEdYjeCoulRelRjE
        AenDZVwJpAyp0xGQOc9SfNDyMo/AKm3HIy32HbT0Rjz0tSPMREncujP6eCRNaFIW5CT7vk
        mfX7alvaGxmauubGCp+YOBbbz3xU3pE08Ris8mkRobalJVuMtsKg+mTqFyZyRA==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-x5df5;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Spot-Battle: 70effe3a7c00384a_1686607949267_3414739719
X-MC-Loop-Signature: 1686607949267:2901581566
X-MC-Ingress-Time: 1686607949266
Received: from pdx1-sub0-mail-a251.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.17 (trex/6.8.1);
        Mon, 12 Jun 2023 22:12:29 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kjlx@templeofstupid.com)
        by pdx1-sub0-mail-a251.dreamhost.com (Postfix) with ESMTPSA id 4Qg5XD0JStzZf
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jun 2023 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
        s=dreamhost; t=1686607948;
        bh=Uw+jdfJkDSDc1rZ9hM9IyUE6VppD4X6NU4hjQZ4wAUI=;
        h=Date:From:To:Cc:Subject:Content-Type:Content-Transfer-Encoding;
        b=oP6zL20uUwr9+8TuQ77C4zC4lKxRJDffnxSj+NkVnjk0dYhMtPpNRlrYcwPVlhJNW
         RrZ5ycHfytz5x1E08xVYbxl2ZgM9yRVUDWUy6qeydXghr7YLl+HX5O4rc1zX377e7T
         gNUet93sZ7QJHlTUznClPFJ7KSIqyQiLkvfvP8oc=
Received: from johansen (uid 1000)
        (envelope-from kjlx@templeofstupid.com)
        id e0085
        by kmjvbox (DragonFly Mail Agent v0.12);
        Mon, 12 Jun 2023 15:12:26 -0700
Date:   Mon, 12 Jun 2023 15:12:26 -0700
From:   Krister Johansen <kjlx@templeofstupid.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Krister Johansen <kjlx@templeofstupid.com>,
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
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: add a test for subprogram
 extables
Message-ID: <20230612221226.GA2077@templeofstupid.com>
References: <cover.1686268304.git.kjlx@templeofstupid.com>
 <9e3041e182a75f558f1132f915ddf2ee7e859c6e.1686268304.git.kjlx@templeofstupid.com>
 <CAADnVQKAmbb2mTNem+3wvCSS44mvmydDCjWj-4V9VZd93vgksQ@mail.gmail.com>
 <ef33f004f1f20c7a4cc7c963eea628df7bec0c53.camel@linux.ibm.com>
 <CAADnVQLWNt0KsXoYVGFD0i089YMivYJ+ZeWmutUiefcdK=eOrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLWNt0KsXoYVGFD0i089YMivYJ+ZeWmutUiefcdK=eOrw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 12, 2023 at 03:07:22PM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 12, 2023 at 6:46 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> >
> > On Fri, 2023-06-09 at 11:15 -0700, Alexei Starovoitov wrote:
> > > On Thu, Jun 8, 2023 at 5:11 PM Krister Johansen
> > > <kjlx@templeofstupid.com> wrote:
> > > >
> > > > In certain situations a program with subprograms may have a NULL
> > > > extable entry.  This should not happen, and when it does, it turns
> > > > a
> > > > single trap into multiple.  Add a test case for further debugging
> > > > and to
> > > > prevent regressions.  N.b: without any other patches this can panic
> > > > or
> > > > oops a kernel.
> > > >
> > > > Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
> > > > ---
> > > >  .../bpf/prog_tests/subprogs_extable.c         | 31 +++++++++++++
> > > >  .../bpf/progs/test_subprogs_extable.c         | 46
> > > > +++++++++++++++++++
> > > >  2 files changed, 77 insertions(+)
> > > >  create mode 100644
> > > > tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > >  create mode 100644
> > > > tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > >
> > > > diff --git
> > > > a/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > > b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > > new file mode 100644
> > > > index 000000000000..2201988274a4
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/subprogs_extable.c
> > > > @@ -0,0 +1,31 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include <test_progs.h>
> > > > +#include "test_subprogs_extable.skel.h"
> > > > +
> > > > +void test_subprogs_extable(void)
> > > > +{
> > > > +       const int READ_SZ = 456;
> > > > +       struct test_subprogs_extable *skel;
> > > > +       int err;
> > > > +
> > > > +       skel = test_subprogs_extable__open();
> > > > +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> > > > +               return;
> > > > +
> > > > +       err = test_subprogs_extable__load(skel);
> > > > +       if (!ASSERT_OK(err, "skel_load"))
> > > > +               goto cleanup;
> > > > +
> > > > +       err = test_subprogs_extable__attach(skel);
> > > > +       if (!ASSERT_OK(err, "skel_attach"))
> > > > +               goto cleanup;
> > > > +
> > > > +       /* trigger tracepoint */
> > > > +       ASSERT_OK(trigger_module_test_read(READ_SZ),
> > > > "trigger_read");
> > > > +
> > > > +       test_subprogs_extable__detach(skel);
> > > > +
> > > > +cleanup:
> > > > +       test_subprogs_extable__destroy(skel);
> > > > +}
> > > > diff --git
> > > > a/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > > b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > > new file mode 100644
> > > > index 000000000000..c3ff66bf4cbe
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/bpf/progs/test_subprogs_extable.c
> > > > @@ -0,0 +1,46 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +#include "vmlinux.h"
> > > > +#include <bpf/bpf_helpers.h>
> > > > +#include <bpf/bpf_tracing.h>
> > > > +
> > > > +struct {
> > > > +       __uint(type, BPF_MAP_TYPE_ARRAY);
> > > > +       __uint(max_entries, 8);
> > > > +       __type(key, __u32);
> > > > +       __type(value, __u64);
> > > > +} test_array SEC(".maps");
> > > > +
> > > > +static __u64 test_cb(struct bpf_map *map, __u32 *key, __u64 *val,
> > > > void *data)
> > > > +{
> > > > +       return 1;
> > > > +}
> > > > +
> > > > +SEC("fexit/bpf_testmod_return_ptr")
> > > > +int BPF_PROG(handle_fexit_ret_subprogs, int arg, struct file *ret)
> > > > +{
> > > > +       *(volatile long *)ret;
> > > > +       *(volatile int *)&ret->f_mode;
> > > > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +SEC("fexit/bpf_testmod_return_ptr")
> > > > +int BPF_PROG(handle_fexit_ret_subprogs2, int arg, struct file
> > > > *ret)
> > > > +{
> > > > +       *(volatile long *)ret;
> > > > +       *(volatile int *)&ret->f_mode;
> > > > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +SEC("fexit/bpf_testmod_return_ptr")
> > > > +int BPF_PROG(handle_fexit_ret_subprogs3, int arg, struct file
> > > > *ret)
> > > > +{
> > > > +       *(volatile long *)ret;
> > > > +       *(volatile int *)&ret->f_mode;
> > > > +       bpf_for_each_map_elem(&test_array, test_cb, NULL, 0);
> > > > +       return 0;
> > > > +}
> > >
> > > What is the point of attaching 3 the same progs to the same hook?
> > > One would be enough to test it, no?
> > >
> > > In other news...
> > > Looks like this test is triggering a bug on s390.
> > >
> > > Ilya,
> > > please take a look:
> > > https://github.com/kernel-patches/bpf/actions/runs/5216942096/jobs/9416404780
> > >
> > > bpf_prog_78c0d4c618ed2df7_handle_fexit_ret_subprogs3
> > > is crashing the kernel.
> > > A bug in extable logic on s390?
> >
> > I think we also need this:
> >
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -17664,6 +17664,7 @@ static int jit_subprogs(struct bpf_verifier_env
> > *env)
> >         prog->bpf_func = func[0]->bpf_func;
> >         prog->jited_len = func[0]->jited_len;
> >         prog->aux->extable = func[0]->aux->extable;
> > +       prog->aux->num_exentries = func[0]->aux->num_exentries;
> >         prog->aux->func = func;
> >         prog->aux->func_cnt = env->subprog_cnt;
> >         bpf_prog_jit_attempt_done(prog);
> >
> > The reason is that s390 JIT doubles the number of extable entries due
> > to how the hardware works (some exceptions point to the failing insn,
> > some point to the next one).
> >
> > With that:
> >
> > Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
> >
> > for the v4 series.
> 
> Great.
> 
> Krister,
> could you please resubmit v5 adding the above change and Ilya's tags to patch 1?
> 
> I'd like to see green BPF CI on all platforms before landing.

Thanks Alexei and Ilya, and yes, absolutely.  I'm hoping to have a v5 out
a little later this afternoon.

-K
