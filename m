Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB610F866
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 08:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLCHK4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 02:10:56 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34389 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfLCHKz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 02:10:55 -0500
Received: by mail-lj1-f195.google.com with SMTP id m6so2555828ljc.1;
        Mon, 02 Dec 2019 23:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2oE/2ITTWUYWdiRD1UkVYx9tpV5y/qN7WKbuS8zqvk=;
        b=IpBzg5jomg2hqfZqFOL+4Z2qK4TAHWstGJIqb3mUCDL03GtM9q3IV+COWDN4ecHtGY
         hdt6Z7toqPcgqf5AZAhBo0ytu6mgjjiPzmRNloS/zzSUbWAjh+96Nif5bwoK30/ehJnC
         A9RI/GDiS1peoHcV8dT5QZ+v1SCGYEPWBenTEdumCoQZcSSihbpkvdIEIhMlKhMKUer1
         2koz2qyOdSuAxWUqdvFPvfb30mU/CkXoP84mKKRBnoKhhRx0TxQXXpAN7xKzm48NjsTX
         FGyUzMcbLcj2mss86iVwSA7racaih2s4SG0Tw50FeLXM+2fxF21iNxuLtcDnmE5bsbph
         tdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2oE/2ITTWUYWdiRD1UkVYx9tpV5y/qN7WKbuS8zqvk=;
        b=H1830PYOg058ozingUnh64aQMGC+pBEN8/MDMpBFHypBtWVwn5v82DpXJuEx792ueN
         NOSVsB+dG3mSMdBjVs+2lpzyaV+42gWwwVO7esF7RYDMJBkjEKYN47i1GjD25mER+thi
         3AXvYdCN/8nFBw9+w2oU8ELsGn2FTFf82Xd1E3O5j9Znfelc9dK/7KNf7Ynjle30R1zi
         ujQg0NXqaJA+9KBkrtRNHcx93wSPUnA5cl9QN7wv3cYuWSnv6cAXb3gjNs91jamt5MjV
         bLwGr7LdSNvYnx9Ca6wDmS9cizcCQHcl8kjBibdbpg+M+8ASJvq6WSYIuuL7ILuGzJMv
         ApDA==
X-Gm-Message-State: APjAAAUbTcbCegqu4V/cku4dmDCvTZ6nu1occuGU/z+/Blrd99YYYq86
        zntGY+QSX5wdRlUE3dyiIDpAsiUQ+pwI/u//JFo=
X-Google-Smtp-Source: APXvYqweZp802KOAOJ8BisQDD2SIzdLKUOS/xVrxSfjAi42aOc57eQ5eEjmiqISt4Ij5722rvuc/8ygCbAkkgbksSQk=
X-Received: by 2002:a2e:7816:: with SMTP id t22mr1625051ljc.161.1575357053013;
 Mon, 02 Dec 2019 23:10:53 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com> <20191203070025.GA4206@google.com>
In-Reply-To: <20191203070025.GA4206@google.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 3 Dec 2019 08:10:26 +0100
Message-ID: <CAEjAshraUy20gEEaff69=b11DhB7zbz8WHT=6wOuw6C2FyJwYA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Fix nits in the kunit
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 3, 2019 at 8:00 AM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Mon, Dec 02, 2019 at 08:25:18AM +0900, SeongJae Park wrote:
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > This patchset contains trivial fixes for the kunit documentations and the
> > wrapper python scripts.
> >
> > SeongJae Park (6):
> >   docs/kunit/start: Use in-tree 'kunit_defconfig'
> >   docs/kunit/start: Skip wrapper run command
> >   kunit: Remove duplicated defconfig creation
> >   kunit: Create default config in 'build_dir'
> >   kunit: Place 'test.log' under the 'build_dir'
> >   kunit: Rename 'kunitconfig' to '.kunitconfig'
> >
> >  Documentation/dev-tools/kunit/start.rst | 19 +++++--------------
> >  tools/testing/kunit/kunit.py            | 10 ++++++----
> >  tools/testing/kunit/kunit_kernel.py     |  6 +++---
> >  3 files changed, 14 insertions(+), 21 deletions(-)
>
> I applied your patchset to torvalds/master, ran the command:
>
> tools/testing/kunit/kunit.py run --timeout=60 --jobs=8 --defconfig --build_dir=.kunit
>
> and got the error:
>
> Traceback (most recent call last):
>   File "tools/testing/kunit/kunit.py", line 140, in <module>
>     main(sys.argv[1:])
>   File "tools/testing/kunit/kunit.py", line 123, in main
>     create_default_kunitconfig()
>   File "tools/testing/kunit/kunit.py", line 36, in create_default_kunitconfig
>     kunit_kernel.KUNITCONFIG_PATH)
>   File "/usr/lib/python3.7/shutil.py", line 121, in copyfile
>     with open(dst, 'wb') as fdst:
> FileNotFoundError: [Errno 2] No such file or directory: '.kunit/.kunitconfig'
>
> It seems that it expects the build_dir to already exist; however, I
> don't think this is clear from the error message. Would you mind
> addressing that here?

Thank you for sharing this.  I will take a look!


Thanks,
SeongJae Park
>
> Cheers!
