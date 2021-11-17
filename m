Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A65EB455118
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Nov 2021 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241569AbhKQX1o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Nov 2021 18:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbhKQX1m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Nov 2021 18:27:42 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5880AC061766
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 15:24:43 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id g14so18285369edb.8
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 15:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Rq1p7FgqjQgLj6wWCnFTWOkKeEiQAkvoX+FiUPaLW4=;
        b=YPCr00kDBxh/itERVSRooieksGZWtLMe/RdKR3aooxI8lobYRND0Mg50ayCY7r9TWr
         3amekzEnVXhAZqAGNhFMSZ/ZDbuCr8jH9a9ExaHWadzVgWJ17upYM+lUM07qt0D6194p
         dYHbGUQG2vLoKGnH58h11FwDhffXU7NWQ5oU0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Rq1p7FgqjQgLj6wWCnFTWOkKeEiQAkvoX+FiUPaLW4=;
        b=FZOr2HHBkkfVF8wjFXS/4GoJQI+9CHWdJpZSdxFiKrQkSlkQ8BEd6Le6bCILKUUQDp
         AGmTmeWdVNbtXWPmfUcBiz2GkKFsh775kvG+6lmWA1vRZepDTYlKvupXbCTUVmUnDhgi
         1Vi63yFW8FNQYLNjTH/6VT+uIbMS5nsOgfG3xo+f8ZqnRs6H0jjDMryg4mIE0u8gEpcO
         bzShvaYBLBnF+DDszWIzDrK/8eP0bKy7h5yd7EKFJrPz67neFGfBsl23LxmBaOTUhEqF
         gOOZr9zlF7WTvVphhkbOVMjL3ztjzUkWZcplJNbwb9TiCjhhH37FHn6JrLeAcHHGgEyC
         zQLg==
X-Gm-Message-State: AOAM5320tWQbNrTJjxgddOrtGyeemddDb6MbNtv2kS2x6zSfiNQLFMTr
        6HUTF6xpP3rIjb2wFvbCcFSAfS3Eushwwzvz
X-Google-Smtp-Source: ABdhPJziAAA2Wp1pvI999PghBZzK2HBp8kVULqfYeUbefypHX+TvobLtxb0qJRcgM0Ys2Mvkz+4m/Q==
X-Received: by 2002:a50:da42:: with SMTP id a2mr3787198edk.361.1637191481479;
        Wed, 17 Nov 2021 15:24:41 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id h10sm654189edk.41.2021.11.17.15.24.40
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Nov 2021 15:24:40 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so3339044wme.4
        for <linux-kselftest@vger.kernel.org>; Wed, 17 Nov 2021 15:24:40 -0800 (PST)
X-Received: by 2002:a1c:7405:: with SMTP id p5mr4139475wmc.152.1637191480450;
 Wed, 17 Nov 2021 15:24:40 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
 <202111171049.3F9C5F1@keescook> <CAP045Apg9AUZN_WwDd6AwxovGjCA++mSfzrWq-mZ7kXYS+GCfA@mail.gmail.com>
 <CAP045AqjHRL=bcZeQ-O+-Yh4nS93VEW7Mu-eE2GROjhKOa-VxA@mail.gmail.com>
 <87k0h6334w.fsf@email.froward.int.ebiederm.org> <202111171341.41053845C3@keescook>
In-Reply-To: <202111171341.41053845C3@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Nov 2021 15:24:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
Message-ID: <CAHk-=wgkOGmkTu18hJQaJ4mk8hGZc16=gzGMgGGOd=uwpXsdyw@mail.gmail.com>
Subject: Re: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kyle Huey <me@kylehuey.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 17, 2021 at 1:54 PM Kees Cook <keescook@chromium.org> wrote:
>
> The SA_IMMUTABLE change was to deal with failures seen in the seccomp
> test suite after the recent fatal signal refactoring. Mainly that a
> process that should have effectively performed do_exit() was suddenly
> visible to the tracer.

I think this basically shows that the conversion from do_exit() to
fatal_signal() was just wrong. The "do_exit()" wasn't really a signal,
and can't be treated as such.

That said, instead of reverting, maybe we can just mark the cases
where it really is about sending a synchronous signal, vs sending an
explicitly fatal signal.

It's basically the "true" condition to force_sig_info_to_task(), so
the fix might be just

  @@ -1323,7 +1323,8 @@ force_sig_info_to_task(struct kernel_siginfo
*info, struct task_struct *t, bool
        blocked = sigismember(&t->blocked, sig);
        if (blocked || ignored || sigdfl) {
                action->sa.sa_handler = SIG_DFL;
  -             action->sa.sa_flags |= SA_IMMUTABLE;
  +             if (sigdfl)
  +                     action->sa.sa_flags |= SA_IMMUTABLE;
                if (blocked) {
                        sigdelset(&t->blocked, sig);
                        recalc_sigpending_and_wake(t);

Kyle, does that fix your test-case? And Kees - yours?

               Linus
