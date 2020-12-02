Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAE02CB14F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 01:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgLBAGC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 19:06:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:56606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbgLBAGB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 19:06:01 -0500
X-Gm-Message-State: AOAM530DgHv0XxsTdyHwQN5QYeb8/7eCXJcfG4d76UkiwGwP8BgtgMwg
        tm4Lp7YNCzGcNkQoPosJK2YLgafslFdmsL4Pcejahw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606867514;
        bh=mMmeqR8hm5LCOImSwkBcFK9EfPV0jMKdTiPbXqm0H9U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YXKNYXDqKx7uMuuKII51Blau1OyoYZmaGq2xiWFqRdbh4+0ttupnaaWnGQHRnEM41
         smeEHSLyi14sV+mrjmryB3SZOUZjPEsdIHqPpW5U11RoLLQn/z9ywK8n8ai3McEYK0
         A6Kqi9oXU0ufUDniPBUM+Kt+zze/tgSxpQQREg1M=
X-Google-Smtp-Source: ABdhPJxGs1zQTY53PW9S7f3409gymiEDgGfegriuR8Dl9nvI8iqGiqqobv4k0ao5I32uvxBf3l/glympCI0ntbMurBU=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr7014860wro.184.1606867512366;
 Tue, 01 Dec 2020 16:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20201127193238.821364-1-krisman@collabora.com>
In-Reply-To: <20201127193238.821364-1-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 1 Dec 2020 16:04:59 -0800
X-Gmail-Original-Message-ID: <CALCETrUh=+=3tYQQTC+Fsakx5xmzQmN_BfzQ7nwY=1GBwoGDNA@mail.gmail.com>
Message-ID: <CALCETrUh=+=3tYQQTC+Fsakx5xmzQmN_BfzQ7nwY=1GBwoGDNA@mail.gmail.com>
Subject: Re: [PATCH v8 0/7] Syscall User Dispatch
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Paul Gofman <gofmanp@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, X86 ML <x86@kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 27, 2020 at 11:32 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Hi,
>
> This is v8 of syscall user dispatch.  Last version got some acks but
> there was one small documentation fix I wanted to do, as requested by
> Florian.  This also addresses the commit message fixup Peter requested.
>
> The only actual code change from v7 is solving a trivial merge conflict
> I myself created with the entry code fixup I made week and with
> something else in the TIP tree.
>
> I also shared this with glibc and there wasn't any complaints other than
> the matter about user-notif vs. siginfo, which was discussed in v7 and
> the understanding is that it is not necessary now and can be added
> later, if needed, on the same infrastructure without a new api.
>
> I'm not sure about TIP the rules, but is it too late to be queued for
> the next merge window?  I'd love to have this in 5.11 if possible, since
> it has been flying for quite a while.
>

Other than my little nitpick about on_syscall_dispatch(), the whole series is:

Reviewed-by: Andy Lutomirski <luto@kernel.org>
