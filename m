Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AA966B2C5
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Jan 2023 18:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbjAORH3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 15 Jan 2023 12:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjAORHN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 15 Jan 2023 12:07:13 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC00612840;
        Sun, 15 Jan 2023 09:06:57 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
        by gnuweeb.org (Postfix) with ESMTPSA id 850E581870;
        Sun, 15 Jan 2023 17:06:57 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673802417;
        bh=dcakJR7qlaPRzeX+cbXVY0AH02DQvlsTZgd8qrY95Xw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YENzDR2BXOxMKqQZzEeXT2Hry+3iEzqlrZG7JNsx5WLBLxVCe6wPjTkCKUTwBkTY4
         SkKZvi5afylGxCkms6UA1NmA3GzAKh/nyoTxXbspkLPeun/Z1GJoaUYACwVVPjAgWf
         ssKF2r/xFuq83zEN7smPYnHDBGN+WGVsAoZAMXnyRpz6rfRBMp3KEv3zpTMprjFifI
         B2ok2g1ynlnzPR095GYckVfHk7V59lEMCBV5n1Hi6RE1VF/oGvqyS5gwyQa/0WfKvD
         /7vb+8ZQjyAOEHrJM+Yj+WssJxYW9hKUXOzN/rEhVJ41RUO9X42WTtGMkzkeFadyQp
         TWLOpdiucK1gg==
Received: by mail-lf1-f41.google.com with SMTP id o20so7810627lfk.5;
        Sun, 15 Jan 2023 09:06:57 -0800 (PST)
X-Gm-Message-State: AFqh2kr948a1htGx5MpZwvGizMEhsfaaU6adrPs0s+/d0M0XKdkTjfEi
        ysZ7yUfroXCKCQCu3h2sVY/WRjKaYhk/bwgE/Ws=
X-Google-Smtp-Source: AMrXdXt+ONtp8KGOj1DXG2x4qJeG/whOylQhdguLA1D7PE5APKMLbsoAM/lnwgcmZcvGx847LMWTklp/38FUaL4U2YU=
X-Received: by 2002:ac2:4c32:0:b0:4b5:798a:9087 with SMTP id
 u18-20020ac24c32000000b004b5798a9087mr6093252lfq.314.1673802415554; Sun, 15
 Jan 2023 09:06:55 -0800 (PST)
MIME-Version: 1.0
References: <20230108135904.851762-1-ammar.faizi@intel.com>
 <20230108175842.GB18859@1wt.eu> <Y7sL9U1dYkuWJ8rS@biznet-home.integral.gnuweeb.org>
 <20230108184930.GC18859@1wt.eu> <Y8QjQnkPxVyEOxPz@biznet-home.integral.gnuweeb.org>
In-Reply-To: <Y8QjQnkPxVyEOxPz@biznet-home.integral.gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Mon, 16 Jan 2023 00:06:44 +0700
X-Gmail-Original-Message-ID: <CAOG64qMcvd==jfHc22q2=n79siixqbKOxb7N8i6SXjqCJtnZpw@mail.gmail.com>
Message-ID: <CAOG64qMcvd==jfHc22q2=n79siixqbKOxb7N8i6SXjqCJtnZpw@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] nolibc signal handling support
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Jan 15, 2023 at 11:01 PM Ammar Faizi wrote:
> That is not the 'sigset_t' that the kernel wants. The kernel wants the
> 'sigset_t' that is in <asm-generic/signal.h>:
>
>     #define _NSIG       64
>     #define _NSIG_BPW   __BITS_PER_LONG      // this 64 on x86-64, but 32=
 on i386.
>     #define _NSIG_WORDS (_NSIG / _NSIG_BPW)
>
>     typedef struct {
>         unsigned long sig[_NSIG_WORDS];
>     } sigset_t;
>
> The above struct is always 8 bytes in size. In other words:
>
>     _NSIG_WORDS =3D=3D 2 on i386
>     _NSIG_WORDS =3D=3D 1 on x86-64
>     sizeof(unsigned long) =3D=3D 4 on i386
>     sizeof(unsigned long) =3D=3D 8 on x86-64
>
> Therefore, sizeof(unsigned long [_NSIG_WORDS]) is always 8 on both
> architectures. That's the correct size.
>
> I tried to #include <asm-generic/signal.h> but it conflicts with the
> other 'sigset_t' definition. So I can't do that.

Read the glibc sigaction implementation, it has different struct
sigaction definitions for user and kernel too.

https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysdeps/unix/sysv/li=
nux/libc_sigaction.c;h=3D3cbf241a5fa28296c910fa40a41b09d2b6113b05;hb=3D7e31=
d166510ac4adbf53d5e8144c709a37dd8c7a

Since nolibc compiles everything in a single translation unit, you
can't have a different sigset_t definition. You need to copy the
definition to nolibc header and change the type name to something else
for internal use only.

> Why are there two different definitions of 'sigset_t'? I don't know.
>
> I probably should read the story behind this syscall to get it
> implemented right. Let me ponder this again on Monday. But at least I
> tell what I have found so people can give some comments on it...

`man 2 rt_sigaction` tells the story. Here is the bedtime story, have
a nice dream :-)

The original Linux system call was named sigaction(). However, with
the addition of real-time signals in Linux 2.2, the fixed-size, 32-bit
sigset_t type supported by that system call was no longer fit for
purpose.
Consequently, a new system call, rt_sigaction(), was added to support
an enlarged sigset_t type. The new system call takes a fourth
argument, size_t sigsetsize, which specifies the size in bytes of the
signal sets
in act.sa_mask and oldact.sa_mask. This argument is currently required
to have the value sizeof(sigset_t) (or the error EINVAL results). The
glibc sigaction() wrapper function hides these details from us,
transpar=E2=80=90
ently calling rt_sigaction() when the kernel provides it.
