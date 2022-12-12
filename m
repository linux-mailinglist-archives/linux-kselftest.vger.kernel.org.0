Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909564A57B
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Dec 2022 18:05:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbiLLRFX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 12 Dec 2022 12:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbiLLRFD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 12 Dec 2022 12:05:03 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17A062664;
        Mon, 12 Dec 2022 09:05:02 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id d20so13868636edn.0;
        Mon, 12 Dec 2022 09:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9w/JTv9rQFmiRXswwobAFodBfcSIMTmtd3CY5de0LI0=;
        b=k7I1yqCYkgukumbjx/EnuXYfNKt1XGFLP2t9MyO3u2C/A/CGVyTAlKzdAkucNhXAsB
         BUWKeTc4uZq4JxcxECd+1KEWB3TDaleOSWBZV60cSezmEopxQJ1L1zowUWjkzh+b/Aj/
         Fnuw17+u/6PTtqaTkA86rkck53iVnW3o4AGxK+MdB9RcHsO9ANNQhoHaRrsE8urVwpLs
         i/0j62za2H+QsiANp7UztwKcQU9+m5++gMCe/4YP+0kgE4emQfPEioG84dK6uTJeLLdb
         ewZwyARYSXk2EvcTiF/O4kicg8BUmCa9Ve0F8J9EjzvdbBI08PHNItl+p2exf8djLHrk
         l1+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9w/JTv9rQFmiRXswwobAFodBfcSIMTmtd3CY5de0LI0=;
        b=KXHAhd1hz9LlOF0eBKFoCiuz5BGeixAMS7WOnOz40+qN5Juqw1dipU7SGozBCehMoQ
         P6yHPnrEm+gaB2t4vkwYthlnUz85k+oGCxQw/tovzYvPO6lB4z+I9J9eUnn9b9lK3h40
         kstojqAil7tfWjKXdRwl3t/8RpXXzfiDeeO9ek7esJjWNY21hNINBu03A3ytydaV8vkf
         M4kT0Gn7kcslpo0CwDPIUaBZN0oXhIIp5df+LkRlQqy2SkEH7kT9p2zwF3z7WHME1aVG
         78sGtuRJZnHKPtIzcQ93/Fh+C5KeuCAFkgehsI6IkCRZjRKOljS9yiDrQLfPCfS9Gak6
         MYHQ==
X-Gm-Message-State: ANoB5pkbejqT5CAZBJ/PqFDz8DyBXaQe1e9SsOZeVBNHs+lHw5Hyml5Q
        /Diu3edmDOj3d+gyuhZDgzaKAgn5o7UTIT6iIMo=
X-Google-Smtp-Source: AA0mqf6NvM9tlXkKJ1ZwkN/L015b9DOzjX3XIIQnc/4AN614AnJJrTh7pAzCF5lGh7uIePPPGIHZBt475p2rYs+9irw=
X-Received: by 2002:a05:6402:2409:b0:45c:935b:ae15 with SMTP id
 t9-20020a056402240900b0045c935bae15mr62588411eda.357.1670864700479; Mon, 12
 Dec 2022 09:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20221207172434.435893-1-roberto.sassu@huaweicloud.com>
 <20221207172434.435893-3-roberto.sassu@huaweicloud.com> <CAADnVQKhWEtqAkMnWR8Twpc6uPo_MWnAf68R-xeM=YVqxkLOyQ@mail.gmail.com>
 <17749b60bcffdc05ce0343199c14ef3cf2d54010.camel@huaweicloud.com>
In-Reply-To: <17749b60bcffdc05ce0343199c14ef3cf2d54010.camel@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 12 Dec 2022 09:04:49 -0800
Message-ID: <CAADnVQJedxOdWnDfLcK-o5SiKK-2Qkw-b=-kiP_8rryF3MgtpQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 2/7] bpf: Mark ALU32 operations in bpf_reg_state structure
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

On Mon, Dec 12, 2022 at 4:45 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Sat, 2022-12-10 at 18:28 -0800, Alexei Starovoitov wrote:
> > On Wed, Dec 7, 2022 at 9:25 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > BPF LSM needs a reliable source of information to determine if the return
> > > value given by eBPF programs is acceptable or not. At the moment, choosing
> > > either the 64 bit or the 32 bit one does not seem to be an option
> > > (selftests fail).
> > >
> > > If we choose the 64 bit one, the following happens.
> > >
> > >       14:       61 10 00 00 00 00 00 00 r0 = *(u32 *)(r1 + 0)
> > >       15:       74 00 00 00 15 00 00 00 w0 >>= 21
> > >       16:       54 00 00 00 01 00 00 00 w0 &= 1
> > >       17:       04 00 00 00 ff ff ff ff w0 += -1
> > >
> > > This is the last part of test_deny_namespace. After #16, the register
> > > values are:
> > >
> > > smin_value = 0x0, smax_value = 0x1,
> > > s32_min_value = 0x0, s32_max_value = 0x1,
> > >
> > > After #17, they become:
> > >
> > > smin_value = 0x0, smax_value = 0xffffffff,
> > > s32_min_value = 0xffffffff, s32_max_value = 0x0
> > >
> > > where only the 32 bit values are correct.
> > >
> > > If we choose the 32 bit ones, the following happens.
> > >
> > > 0000000000000000 <check_access>:
> > >        0:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0)
> > >        1:       79 10 08 00 00 00 00 00 r0 = *(u64 *)(r1 + 8)
> > >        2:       67 00 00 00 3e 00 00 00 r0 <<= 62
> > >        3:       c7 00 00 00 3f 00 00 00 r0 s>>= 63
> > >
> > > This is part of test_libbpf_get_fd_by_id_opts (no_alu32 version). In this
> > > case, 64 bit register values should be used (for the 32 bit ones, there is
> > > no precise information from the verifier).
> > >
> > > As the examples above suggest that which register values to use depends on
> > > the specific case, mark ALU32 operations in bpf_reg_state structure, so
> > > that BPF LSM can choose the proper ones.
> >
> > I have a hard time understanding what is the problem you're
> > trying to solve and what is the proposed fix.
>
> The problem is allowing BPF LSM programs to return positive values when
> LSM hooks expect zero or negative values. Those values could be
> converted to a pointer, and escape the IS_ERR() check.

The bigger goal is clear.

> The challenge is to ensure that the verifier prediction of R0 is
> accurate, so that the eBPF program is not unnecessarily rejected.

There is a code in the verifier already that checks ret values.
lsm restrictions should fit right in.

> > The patch is trying to remember the bitness of the last
> > operation, but what for?
> > The registers are 64-bit. There are 32-bit operations,
> > but they always update the upper 32-bits of the register.
> > reg_bounds_sync() updates 32 and 64 bit bounds regardless
> > whether the previous operation was on 32 or 64 bit.
>
> Ok, yes. I also thought that using the 64 bit register should be ok,
> but selftests fail.

maybe selftests are buggy?
they fail with patch 3 alone without patch 2 ?
please explain exactly the problem.

> Regarding your comment, I have not seen reg_bounds_sync() for the case
> R = imm.

because it's unnecessary there.

> > It seems you're trying to hack around something that breaks
> > patch 3 which also looks fishy.
>
> I thought it was a good idea that changes in the LSM infrastructure are
> automatically reflected in the boundaries that BPF LSM should enforce.

That's fine. Encoding restrictions in lsm_hook_defs.h
is the cleanest approach.

> If not, I'm open to new ideas. If we should use BTF ID sets, I'm fine
> with it.
>
> > Please explain the problem first with a concrete example.
>
> Ok, I have a simple one:
>
> $ llvm-objdump -d test_bpf_cookie.bpf.o
>
> 0000000000000000 <test_int_hook>:
>
> [...]
>
>        8:       85 00 00 00 0e 00 00 00 call 14
>        9:       b4 06 00 00 ff ff ff ff w6 = -1
>       10:       5e 08 07 00 00 00 00 00 if w8 != w0 goto +7 <LBB11_3>
>       11:       bf 71 00 00 00 00 00 00 r1 = r7
>       12:       85 00 00 00 ae 00 00 00 call 174
>       13:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 = 0 ll
>       15:       79 12 00 00 00 00 00 00 r2 = *(u64 *)(r1 + 0)
>       16:       4f 02 00 00 00 00 00 00 r2 |= r0
>       17:       7b 21 00 00 00 00 00 00 *(u64 *)(r1 + 0) = r2
>
> smin_value = 0xffffffff, smax_value = 0xffffffff,
> s32_min_value = 0xffffffff, s32_max_value = 0xffffffff,

and this applies where?
what reg are you talking about?
Where is the issue?

> This is what I see at the time the BPF LSM check should be done.
>
> How this should be properly handled?

The patch 3 should be fine alone. I don't see a need for patch 2 yet.
