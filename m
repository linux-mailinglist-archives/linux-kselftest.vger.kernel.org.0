Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E932852F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Oct 2020 22:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727178AbgJFUR0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Oct 2020 16:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgJFUR0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Oct 2020 16:17:26 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB7BC0613D4
        for <linux-kselftest@vger.kernel.org>; Tue,  6 Oct 2020 13:17:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id e22so12693310ejr.4
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Oct 2020 13:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5D/KhjYZ/F6OUNTmASsZK9nvaTQ/z+uGyjhYNK/ZLao=;
        b=syAFmJ6PHpLQ9fBKdlbTtyFbIIYk45rz96pMdgVFxTy7qX0h51U+ZxMNsnSRSU2GJy
         7xcG1DinKA8nylHJjK2+tQGvVOXqBIvE8CJz0i3hmzBJv3nPx3uPHeWDDUwLlNTcdQ4c
         qKtvJo8YYYhrJ1lLkBDZpBjPniVJRV6A8ZosbeMOVDmKUTcajvaLe72Zv/iSEpkWdi7r
         M0smO2oXTKmzTEw2bOehubTqJDBIiEPRKFepcmoBNYKrb3l2zxFP9ab1lnEJlo7okgJH
         cds/M4qXZq/8w0CcTu3h8RuVh57fVOv+9DlEAqbbeIt5NYmRVz/y2cLkl5pNtyt/uBxT
         9NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5D/KhjYZ/F6OUNTmASsZK9nvaTQ/z+uGyjhYNK/ZLao=;
        b=l3AWF/fz8lixaY685X92Hcwlz0YPyA3Z8TP0LyPhVnQizfGLH39aORGLTNeaguxNIK
         mKfI+2gpBpYAOOB4/3GzGggPsKopOF/Q1Za3opxMP7r2CT7pL6B6ZYr8wm+1rD0L5E4u
         RZeV+mtI/SfxvTfhZUN3b/ww2kqFCTCTcF8vgbpaNlX1WtuNwqGpNCltgXwPuomKqApU
         5GENQZIG04w7y4y+OLm74z5z/+7HFYm2aWx/3KWDUwyDeJMpeM3S9/7gVJVadRV1q7We
         2umYjXIu8Q5OP//1F9SdEuX1D6VoGbQ9Fe/fmLCH67zP8j0Ni/JEUGQ2UWNB+POVLOuE
         0Hlw==
X-Gm-Message-State: AOAM532+eqDAgCz5iC8yqFzDGz+0rExFc4zVrAZRwG1/Y/7KTPuVYQZk
        n2PC9AmpSwT2MM/NL6iEkgqn5BrWW3Zg1NGI/PZhng==
X-Google-Smtp-Source: ABdhPJx+AZ5o3eCgoq4q+6PjDXINFIUIJE5Lw9X2W3HZ87fOvOk/cHg1VfIGCTbUJXMe1/ribhgrE6IY0RMLjypdmbE=
X-Received: by 2002:a17:906:7d52:: with SMTP id l18mr1343800ejp.220.1602015443789;
 Tue, 06 Oct 2020 13:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200929235049.2533242-1-haoluo@google.com> <20200929235049.2533242-2-haoluo@google.com>
 <CAADnVQKc4m6X62udhpPE3EBBvuOA2ngyWSOKQ7fc-rtqdeQj6w@mail.gmail.com>
In-Reply-To: <CAADnVQKc4m6X62udhpPE3EBBvuOA2ngyWSOKQ7fc-rtqdeQj6w@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 6 Oct 2020 13:17:12 -0700
Message-ID: <CA+khW7jKU733tUHCMou0X8ivsSJSHCWT7+aq3AqssH5C74n+PQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/6] bpf: Introduce pseudo_btf_id
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Network Development <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Ack. Will do.

On Tue, Oct 6, 2020 at 12:05 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Sep 29, 2020 at 4:50 PM Hao Luo <haoluo@google.com> wrote:
> >
> > -       ret = replace_map_fd_with_map_ptr(env);
> > -       if (ret < 0)
> > -               goto skip_full_check;
> > -
> >         if (bpf_prog_is_dev_bound(env->prog->aux)) {
> >                 ret = bpf_prog_offload_verifier_prep(env->prog);
> >                 if (ret)
> > @@ -11662,6 +11757,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr,
> >         if (ret)
> >                 goto skip_full_check;
> >
> > +       ret = resolve_pseudo_ldimm64(env);
> > +       if (ret < 0)
> > +               goto skip_full_check;
> > +
>
> Hao,
>
> this change broke several tests in test_verifier:
> #21/u empty prog FAIL
> Unexpected error message!
>     EXP: unknown opcode 00
>     RES: last insn is not an exit or jmp
>
> #656/u test5 ld_imm64 FAIL
> Unexpected error message!
>     EXP: invalid bpf_ld_imm64 insn
>     RES: last insn is not an exit or jmp
>
> #656/p test5 ld_imm64 FAIL
> Unexpected error message!
>     EXP: invalid bpf_ld_imm64 insn
>     RES: last insn is not an exit or jmp
>
> Please send a fix.
> Thanks
