Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4D2B1743F0
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Feb 2020 01:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB2AuF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Feb 2020 19:50:05 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39411 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgB2AuF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Feb 2020 19:50:05 -0500
Received: by mail-wr1-f66.google.com with SMTP id y17so5255071wrn.6
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Feb 2020 16:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0fc83ZqAA6+83fPnMS4lxXssttTpf+l85Fw1w82L0QU=;
        b=Pim9Ezl7Ogaq4+QBBsebEB02RdWCvqDSk5e+uOiY+5RXQ1V+C68fvK9QsIWdvHkN/f
         OBPsP/JpzLaEhAtXXWhzuc9drpsT0f4y43v8vWquIfwSgzxpHoq7I5yL+lTiwe9mx5ae
         j7L0hjOzXyGaorIc4fJACvVGBXhCcTVOG0v4J8cxjYYxiqItAeSsciXciS62jlbKuyLV
         tTwg9fe2wrOHf5ERg1Bzi5sn0YPgUYPwtPeKHCpnx276D0/neLh271s7V77wR37so6kC
         QkzO9hz8kFZp+zNYV4iSE+1YzINAdq9N3jbU6U6nluZs/kvA9DyKYT9YrKY5Wl2FPvQD
         Nw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0fc83ZqAA6+83fPnMS4lxXssttTpf+l85Fw1w82L0QU=;
        b=D2LFAPpP2hh+vKV0RxrLvSWCv1LlJWBJQKL8Ry66vC3xuK6qV+rSQ+e4s6gcCNffDK
         1c9iir4zzDYiMmLG4DBbGa86+TushEWN5GygvSbDaRJ9lb66aenYhmJx9bOzzdFpVmos
         gh012TvnP5aN1iHcDlzX6+acQFZ6CRfdwNoqwgZkS5K6VCf/V9wkNrUOylafSCDMs56V
         Kg8RsN1ysRDb7YKnrYNOlRzWeRl0KFfkWos2C4kMyxFQYlwnFkcq7dH4+Vqjzz3MAOr3
         Bgflh5HrS1X07swZeT1zI41J8MM5QUwYLnuJeDLlKu804CLrcZjLcEKlONmvbouxO9Nz
         Bt4A==
X-Gm-Message-State: APjAAAXf45yoIqCRXiLXLz4px0IHNkIHYAk2jgRV+l+dP5TUdOKK+/SD
        c8BG81XbdF6WQUEcY/UnaO7oS7uNPR+vIQ5vogt+Gg==
X-Google-Smtp-Source: APXvYqxWGTtiwUL9PxLOYIePXDdM4+bHkwvOLmQq+Uy1p1lTrTCmmm7EHolfnlQp1sTZeAHX4qJocD0WQucx+d4aaME=
X-Received: by 2002:adf:e38d:: with SMTP id e13mr6955293wrm.133.1582937403580;
 Fri, 28 Feb 2020 16:50:03 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com>
 <20200227024301.217042-2-trishalfonso@google.com> <CACT4Y+b0LHp15GNchK_TPxaqX8zscqgBw-Jm2Y3yq8Bn=dRbeQ@mail.gmail.com>
In-Reply-To: <CACT4Y+b0LHp15GNchK_TPxaqX8zscqgBw-Jm2Y3yq8Bn=dRbeQ@mail.gmail.com>
From:   Patricia Alfonso <trishalfonso@google.com>
Date:   Fri, 28 Feb 2020 16:49:52 -0800
Message-ID: <CAKFsvUJhbk6cOXKgQ1+9=eDRDES1AB0rSTM+zid-yfk2U-qhYw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, vincent.guittot@linaro.org,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 27, 2020 at 6:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > Integrate KASAN into KUnit testing framework.
> >  - Fail tests when KASAN reports an error that is not expected
> >  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
> >  - KUnit struct added to current task to keep track of the current test
> > from KASAN code
> >  - Booleans representing if a KASAN report is expected and if a KASAN
> >  report is found added to kunit struct
> >  - This prints "line# has passed" or "line# has failed"
> >
> > Signed-off-by: Patricia Alfonso <trishalfonso@google.com>
>
> This does not build for me:
>
> $ make
> scripts/kconfig/conf  --syncconfig Kconfig
>   CC      arch/x86/kernel/asm-offsets.s
>   UPD     include/generated/asm-offsets.h
>   CALL    scripts/checksyscalls.sh
>   CALL    scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      init/main.o
> In file included from ./include/linux/uaccess.h:11,
>                  from ./arch/x86/include/asm/fpu/xstate.h:5,
>                  from ./arch/x86/include/asm/pgtable.h:26,
>                  from ./include/linux/kasan.h:15,
>                  from ./include/linux/slab.h:136,
>                  from ./include/kunit/test.h:16,
>                  from ./include/linux/sched.h:35,
>                  from ./include/linux/ioprio.h:5,
>                  from ./include/linux/fs.h:39,
>                  from ./include/linux/proc_fs.h:9,
>                  from init/main.c:18:
> ./arch/x86/include/asm/uaccess.h: In function =E2=80=98set_fs=E2=80=99:
> ./arch/x86/include/asm/uaccess.h:31:9: error: dereferencing pointer to
> incomplete type =E2=80=98struct task_struct=E2=80=99
>    31 |  current->thread.addr_limit =3D fs;
>       |         ^~
> make[1]: *** [scripts/Makefile.build:268: init/main.o] Error 1
> make: *** [Makefile:1681: init] Error 2
>
>
> On bfdc6d91a25f4545bcd1b12e3219af4838142ef1 config:
> https://pastebin.com/raw/nwnL2N9w

I'm sorry. It seems I only ever tested locally on UML. As Alan
suggested, removing "#include <kunit/test.h>" from
include/linux/sched.h seems to fix this problem.

--=20
Best,
Patricia Alfonso
