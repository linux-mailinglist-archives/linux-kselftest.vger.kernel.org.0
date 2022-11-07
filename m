Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCED461F81E
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbiKGQA1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 11:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiKGQAZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 11:00:25 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F73638A;
        Mon,  7 Nov 2022 08:00:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id f5so31386224ejc.5;
        Mon, 07 Nov 2022 08:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g+lIXqP4rj9xpDmU5hRWj/6YWyT2YMyOV99bvITSLGw=;
        b=Dzzx/pid0uEsTtvM7XLovM8woWQJDT60+jm6is41mDgEax/ZkH2ZhI8T4mv3UQmpz7
         uF8leVHpYCihcnxCP9CJ7xAcGhVLe1J0IDl5bH/fAQAnYppe9ezCWTLRagRw2yyVDqLQ
         twG4w8cGvu1Fi6k8PgEAqMTigvlfj6w8N+UHzCzYI4tmmrSO0SqhiWf1FxksEwlT0dBJ
         ld2aB+EsuZW34P8epCwSAHuRfeTz1x1k+xgW0GXO3XMAVUwtv1Yy2CZCrF5AtAJMLaur
         jEcX2J7VJsSP0BHgYxRn6GqWhIgkz3NqjsM8ZQv70HzBv4jL2vOlHu0XoYMtNLK0ld+p
         4MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+lIXqP4rj9xpDmU5hRWj/6YWyT2YMyOV99bvITSLGw=;
        b=AdVXfaiERIQfIsv3dVgOLjfiE/efy4iKlVLopi1gihFJACj3AIDXCmCLFQznaYAVHx
         I2eUPHOsTuURAlUMO/egKflWT3H8j/R2MFlL+twOADAJlW1rlDoQQruIvLTvJNh7pke0
         xnBSRicZ4CWXM73x+vb7SOS6fiOzVenGjkLbQHPNCinfsk+31a7/v2R0SB/pEUxkT5ml
         XLbEr3PoE6IfQCQVB2ApU+Gbam8VNRtIsZ/L9tmSCLRTFvtDY8LlyhMmwpvvy/I71gRJ
         kBWZIpJty9c6739cfX8fKMILBxrGbkwN9mdjuTWxV0vsOIFpbtd9MVgCZZ+VSfU2mkn2
         hjrA==
X-Gm-Message-State: ACrzQf0+/buRaDlDzw1HUh/2B4CbMSznsSMPOUq8Ek/RN5VRFwaYLc2O
        dj9+yB/cvwsmDEDF10lEASKWq3HZmHzF9bBh6u8=
X-Google-Smtp-Source: AMsMyM5f1sOg/7ieiNovUftNSyFVCfw4+gAEpvzWwyAldDM3ERMOc2Mqb8vSCd6HkUUKovrUHad2eyGhUjAz8q6a8mY=
X-Received: by 2002:a17:906:8a73:b0:7ae:3962:47e7 with SMTP id
 hy19-20020a1709068a7300b007ae396247e7mr16098703ejc.502.1667836820607; Mon, 07
 Nov 2022 08:00:20 -0800 (PST)
MIME-Version: 1.0
References: <20221028165423.386151-1-roberto.sassu@huaweicloud.com>
 <20221028165423.386151-2-roberto.sassu@huaweicloud.com> <CACYkzJ5gFu5a-NoKFD6XFNYMDyP+iPon=kHMimJybmNexbhAPg@mail.gmail.com>
 <38c3ff70963de4a7a396c0fad84349c7c39c0f07.camel@huaweicloud.com>
 <CAADnVQ+K0NMFKV8pQR+ZMHMM9KArRsLSv-F82_qbK4+4xaPxrg@mail.gmail.com> <7ecbf4fff621bb3340422ff668452c0bbf4c4e71.camel@huaweicloud.com>
In-Reply-To: <7ecbf4fff621bb3340422ff668452c0bbf4c4e71.camel@huaweicloud.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 7 Nov 2022 08:00:08 -0800
Message-ID: <CAADnVQ+nmneJGNRHHh8yAbrewnD_SVsZmw1U=CzNf8AD38BTrw@mail.gmail.com>
Subject: Re: [RESEND][RFC][PATCH 2/3] bpf-lsm: Limit values that can be
 returned by security modules
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Mimi Zohar <zohar@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        nicolas.bouchinet@clip-os.org
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

On Mon, Nov 7, 2022 at 4:33 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Fri, 2022-11-04 at 17:42 -0700, Alexei Starovoitov wrote:
> > On Fri, Nov 4, 2022 at 8:29 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > On Thu, 2022-11-03 at 16:09 +0100, KP Singh wrote:
> > > > On Fri, Oct 28, 2022 at 6:55 PM Roberto Sassu
> > > > <roberto.sassu@huaweicloud.com> wrote:
> > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > >
> > > > > BPF LSM defines a bpf_lsm_*() function for each LSM hook, so that
> > > > > security modules can define their own implementation for the desired hooks.
> > > > >
> > > > > Unfortunately, BPF LSM does not restrict which values security modules can
> > > > > return (for non-void LSM hooks). Security modules might follow the
> > > > > conventions stated in include/linux/lsm_hooks.h, or put arbitrary values.
> > > > >
> > > > > This could cause big troubles, as the kernel is not ready to handle
> > > > > possibly malicious return values from LSMs. Until now, it was not the
> > > >
> > > > I am not sure I would call this malicious. This would be incorrect, if
> > > > someone is writing a BPF LSM program they already have the powers
> > > > to willingly do a lot of malicious stuff.
> > > >
> > > > It's about unknowingly returning values that can break the system.
> > >
> > > Maybe it is possible to return specific values that lead to acquire
> > > more information/do actions that the eBPF program is not supposed to
> > > cause.
> > >
> > > I don't have a concrete example, so I will use the word you suggested.
> > >
> > > > > case, as each LSM is carefully reviewed and it won't be accepted if it
> > > > > does not meet the return value conventions.
> > > > >
> > > > > The biggest problem is when an LSM returns a positive value, instead of a
> > > > > negative value, as it could be converted to a pointer. Since such pointer
> > > > > escapes the IS_ERR() check, its use later in the code can cause
> > > > > unpredictable consequences (e.g. invalid memory access).
> > > > >
> > > > > Another problem is returning zero when an LSM is supposed to have done some
> > > > > operations. For example, the inode_init_security hook expects that their
> > > > > implementations return zero only if they set the name and value of the new
> > > > > xattr to be added to the new inode. Otherwise, other kernel subsystems
> > > > > might encounter unexpected conditions leading to a crash (e.g.
> > > > > evm_protected_xattr_common() getting NULL as argument).
> > > > >
> > > > > Finally, there are LSM hooks which are supposed to return just one as
> > > > > positive value, or non-negative values. Also in these cases, although it
> > > > > seems less critical, it is safer to return to callers of the LSM
> > > > > infrastructure more precisely what they expect.
> > > > >
> > > > > As eBPF allows code outside the kernel to run, it is its responsibility
> > > > > to ensure that only expected values are returned to LSM infrastructure
> > > > > callers.
> > > > >
> > > > > Create four new BTF ID sets, respectively for hooks that can return
> > > > > positive values, only one as positive value, that cannot return zero, and
> > > > > that cannot return negative values. Create also corresponding functions to
> > > > > check if the hook a security module is attached to belongs to one of the
> > > > > defined sets.
> > > > >
> > > > > Finally, check in the eBPF verifier the value returned by security modules
> > > > > for each attached LSM hook, and return -EINVAL (the security module cannot
> > > > > run) if the hook implementation does not satisfy the hook return value
> > > > > policy.
> > > > >
> > > > > Cc: stable@vger.kernel.org
> > > > > Fixes: 9d3fdea789c8 ("bpf: lsm: Provide attachment points for BPF LSM programs")
> > > > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > ---
> > > > >  include/linux/bpf_lsm.h | 24 ++++++++++++++++++
> > > > >  kernel/bpf/bpf_lsm.c    | 56 +++++++++++++++++++++++++++++++++++++++++
> > > > >  kernel/bpf/verifier.c   | 35 +++++++++++++++++++++++---
> > > > >  3 files changed, 112 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > > > > index 4bcf76a9bb06..cd38aca4cfc0 100644
> > > > > --- a/include/linux/bpf_lsm.h
> > > > > +++ b/include/linux/bpf_lsm.h
> > > > > @@ -28,6 +28,10 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
> > > > >                         const struct bpf_prog *prog);
> > > > >
> > > > >  bool bpf_lsm_is_sleepable_hook(u32 btf_id);
> > > > > +bool bpf_lsm_can_ret_pos_value(u32 btf_id);
> > > > > +bool bpf_lsm_can_ret_only_one_as_pos_value(u32 btf_id);
> > > > > +bool bpf_lsm_cannot_ret_zero(u32 btf_id);
> > > > > +bool bpf_lsm_cannot_ret_neg_value(u32 btf_id);
> > > > >
> > > >
> > > > This does not need to be exported to the rest of the kernel. Please
> > > > have this logic in bpf_lsm.c and export a single verify function.
> > > >
> > > > Also, these really don't need to be such scattered logic, Could we
> > > > somehow encode this into the LSM_HOOK definition?
> > >
> > > The problem is that a new LSM_HOOK definition would apply to every LSM
> > > hook, while we need the ability to select subsets.
> > >
> > > I was thinking, but I didn't check yet, what about using BTF_ID_FLAGS,
> > > introducing a flag for each interval (<0, 0, 1, >1) and setting the
> > > appropriate flags for each LSM hook?
> >
> > Before adding infra to all hooks, let's analyze all hooks first.
> > I thought the number of exceptions is very small.
> > 99% of hooks will be fine with IS_ERR.
> > If so, adding an extra flag to every hook will cause too much churn.
>
> If I counted them correctly, there are 12 hooks which can return a
> positive value. Among them, 6 can return only 1. 3 should not return a
> negative value.
>
> A reason for making this change in the LSM infrastructure would be that
> the return values provided there would be the official reference for
> anyone dealing with LSM hooks (e.g. redefining the LSM_HOOK macro).
>
> Another reason would be that for new hooks, the developer introducing
> them would have to provide the information. BPF LSM would use that
> automatically (otherwise it might get out of sync).

I'd prefer these 12 hooks to get converted to IS_ERR instead.
Especially those that can only return 1... why aren't they void?

> The idea would be to use BTF_ID_FLAGS() with the flags coming from
> lsm_hook_defs.h, and to check if a flag is set depending on the
> interval of the return value provided by the eBPF program.

BTF_ID_FLAGS is not appropriate for this.
