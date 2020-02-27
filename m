Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3E651720D4
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2020 15:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730951AbgB0OpX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Feb 2020 09:45:23 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34814 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730112AbgB0OpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Feb 2020 09:45:23 -0500
Received: by mail-vs1-f65.google.com with SMTP id g15so1999298vsf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Feb 2020 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uIt9DyZ9nPgtt+YVHDl4cWP+F6uXmWHM0NievYA3/mQ=;
        b=VQBU8iu2uCPmMFA6ZKYuIFOaqxlIebNshhGY19HbX6TJSpWpKgmpqa+OiCriOvOtfU
         SURggXzLsOrJPCaj2ZcunCf16QRKxHwV+Tln/q+jGedzB6sCrBuhKpDYKEMg60GJWWMK
         lMR1htPczf5Po2JHrIdWjlWPXyunGfIE0XuEU0NbogWA9f50GQK7Q6rxJWyoq6XXTFpR
         rtG323NNbZowjcYgEr8VNhaRP1Ml4MBs1jk546H6xPLSyU4wF883j7mE9+h51e1Hjl7h
         6ZdSg6VS9SDba70F7hxyUJZGRa0WA/PbzdcftGgzs0iJkWdF5j8GuiPhpb8sAjPaK7yM
         zATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uIt9DyZ9nPgtt+YVHDl4cWP+F6uXmWHM0NievYA3/mQ=;
        b=IsXbC/mpxA/37UREK66X55AcgpH5zoSr6ycrH0v8budjJ87j9//WgFQo0bbC1+2K6Q
         4mvXgOLG4/3KjoAlQvWvM5gqCUuO34wqCd+bJGwyy8XKYTofegoYy01cWU0ZqUyN1AF7
         mBZsd8sk8n/0UfH2DW2fIGQKkIRoFM1xjUZrkY1K1Ha23SfPKUg78u3QTrZi+01R6H4P
         QLh6CsiYsC5sLOyf2coYi97mQ6D1wgqLOplgIpF1Rr5nB39vBVIFsqCH0Ul8CooK4PNz
         /1MDTWm1A4NVpZtGtkuyhgldekotUjhMHOEmCfCPHm3YaJNuGWI57TxInLNse1w9juHD
         AAEw==
X-Gm-Message-State: APjAAAUnDQi+uUpzkW7bQRR+Bd4kOcGf7XOX1OWi3LtwkhZn0O/to8JO
        3AGVM7aCNVMO0LODKzhs4ZNPbWUmnAdIrvGivYr67A==
X-Google-Smtp-Source: APXvYqx24Fufs8kygldW8udN7qzYKu0xpi9B+mGtQ5uymR1YOJw2PzRkveUvacDSqSxOOr5eo6UFeHhjaqb2/JA/bRg=
X-Received: by 2002:a67:f318:: with SMTP id p24mr2792811vsf.240.1582814722123;
 Thu, 27 Feb 2020 06:45:22 -0800 (PST)
MIME-Version: 1.0
References: <20200227024301.217042-1-trishalfonso@google.com> <20200227024301.217042-2-trishalfonso@google.com>
In-Reply-To: <20200227024301.217042-2-trishalfonso@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Feb 2020 15:45:10 +0100
Message-ID: <CACT4Y+b0LHp15GNchK_TPxaqX8zscqgBw-Jm2Y3yq8Bn=dRbeQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] KUnit: KASAN Integration
To:     Patricia Alfonso <trishalfonso@google.com>
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

On Thu, Feb 27, 2020 at 3:44 AM 'Patricia Alfonso' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Integrate KASAN into KUnit testing framework.
>  - Fail tests when KASAN reports an error that is not expected
>  - Use KUNIT_EXPECT_KASAN_FAIL to expect a KASAN error in KASAN tests
>  - KUnit struct added to current task to keep track of the current test
> from KASAN code
>  - Booleans representing if a KASAN report is expected and if a KASAN
>  report is found added to kunit struct
>  - This prints "line# has passed" or "line# has failed"
>
> Signed-off-by: Patricia Alfonso <trishalfonso@google.com>

This does not build for me:

$ make
scripts/kconfig/conf  --syncconfig Kconfig
  CC      arch/x86/kernel/asm-offsets.s
  UPD     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CALL    scripts/atomic/check-atomics.sh
  DESCEND  objtool
  CC      init/main.o
In file included from ./include/linux/uaccess.h:11,
                 from ./arch/x86/include/asm/fpu/xstate.h:5,
                 from ./arch/x86/include/asm/pgtable.h:26,
                 from ./include/linux/kasan.h:15,
                 from ./include/linux/slab.h:136,
                 from ./include/kunit/test.h:16,
                 from ./include/linux/sched.h:35,
                 from ./include/linux/ioprio.h:5,
                 from ./include/linux/fs.h:39,
                 from ./include/linux/proc_fs.h:9,
                 from init/main.c:18:
./arch/x86/include/asm/uaccess.h: In function =E2=80=98set_fs=E2=80=99:
./arch/x86/include/asm/uaccess.h:31:9: error: dereferencing pointer to
incomplete type =E2=80=98struct task_struct=E2=80=99
   31 |  current->thread.addr_limit =3D fs;
      |         ^~
make[1]: *** [scripts/Makefile.build:268: init/main.o] Error 1
make: *** [Makefile:1681: init] Error 2


On bfdc6d91a25f4545bcd1b12e3219af4838142ef1 config:
https://pastebin.com/raw/nwnL2N9w
