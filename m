Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8496114AF50
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 07:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbgA1GDK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jan 2020 01:03:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50963 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgA1GDK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jan 2020 01:03:10 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so1161157wmb.0;
        Mon, 27 Jan 2020 22:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=uzw58AxJyROr8rcMN8+tQkKTP/GB1BTnbsoLW+T9bYk=;
        b=U/XLAZmEa7FoBjgoyU8wMcZ5kvRPBBjiKtZOhlYZ3i50AyKGIhCme4LOTgNUES0zoh
         DNsTA7p5hOqy9mpaE8Q/Z9vSC7iwRlelFsVCWaYkxc6KCkCCYQcqmB3/wpYq6iOOd+Vm
         wRCrDdthL6nGdesnPUuxuLrV5lWHAXe6GBpZ/jypCVTGNSJkjZI3teQaFR0kys0adpFs
         d2TkDOV0Sut3b3wmXMggXviARjCbAtsF3Ux+BHH/jQikGhJZY66CfdUdSjZvC+/4fFnQ
         t4sfRbb6/DbFYLXMTPY98hoA72GXMlUn+ifhP5sPO0CjECVSzz4X/ddRarBwaMx2EEVg
         FVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=uzw58AxJyROr8rcMN8+tQkKTP/GB1BTnbsoLW+T9bYk=;
        b=h0p9KQIQ+i8Us+Q+jqQ5U5dT6Yk7f2pR1CdWx4/KhPTuH5uk2UGYcV/LKtFDJI7n0y
         e11OgyeKl9m149cqqpsxK6CmZNHDCbu90aUBAjJTYCbhyL5/qjPqaZGlBzAZBWYNWFzV
         Zykm0bCzSRzvxINn9JHRL88BfB3NdLcRrFQXTrvmj3F7MdE6GPLhjYdV8ZX+ag6lW4jl
         7vV5bsm/yxHEdttgHD70FB8MP6dHzTq9/AkyAu/YpfKOeJO38z99AkF3Kzj7utKMWuqj
         c72QwdLt6/1qQmtIqQ7mzN1PcgLi+TegeUdy9tyEB3VRF/ODus1SixQeUfHmNUk/Oa4C
         YM0g==
X-Gm-Message-State: APjAAAX0qB4FLcV5xVP1cRTTuYcYCNdBFlYjoJvmiHxXh7wbrAnKaFjG
        czDKKE5CW1AWagreCbrkMPA=
X-Google-Smtp-Source: APXvYqzGz7ZuGFcI0BoC2X5Ts/w3Qvls5A/hK7yPgVcvXcHRKynQCnFsoiuBdQJgjo4rs+q/oVWTSQ==
X-Received: by 2002:a05:600c:3d1:: with SMTP id z17mr2876527wmd.90.1580191387751;
        Mon, 27 Jan 2020 22:03:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:841f:4795:9ca0:c33f])
        by smtp.gmail.com with ESMTPSA id w13sm24781940wru.38.2020.01.27.22.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 22:03:07 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     SeongJae Park <sj38.park@gmail.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig is modified
Date:   Tue, 28 Jan 2020 07:03:00 +0100
Message-Id: <20200128060300.23989-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAFd5g46v-RyNMP7GROn4bUEAATOPZ=w5AyO+tvuTG25aqt6oAg@mail.gmail.com> (raw)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, 27 Jan 2020 16:02:48 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:

> On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > Deletions of configs in the '.kunitconfig' is not applied because kunit
> > rebuilds '.config' only if the '.config' is not a subset of the
> > '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> > the '.config' rebuild condition to addtionally check the modified times
> > of those files.
> 
> The reason it only checks that .kunitconfig is a subset of .config is
> because we don't want the .kunitconfig to remove options just because
> it doesn't recognize them.
> 
> It runs `make ARCH=um olddefconfig` on the .config that it generates
> from the .kunitconfig, and most of the time that means you will get a
> .config with lots of things in it that aren't in the .kunitconfig.
> Consequently, nothing should ever be deleted from the .config just
> because it was deleted in the .kunitconfig (unless, of course, you
> change a =y to a =n or # ... is not set), so I don't see what this
> change would do.
> 
> Can you maybe provide an example?

Sorry for my insufficient explanation.  I added a kunit test
(SYSCTL_KUNIT_TEST) to '.kunitconfig', ran the added test, and then removed it
from the file.  However, '.config' is not generated again due to the condition
and therefore the test still runs.

For more detail:

    $ ./tools/testing/kunit/kunit.py run --defconfig --build_dir ../kunit.out/
    $ echo "CONFIG_SYSCTL_KUNIT_TEST=y" >> ../kunit.out/.kunitconfig
    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
    $ sed -i '4d' ../kunit.out/.kunitconfig
    $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/

The 2nd line command adds sysctl kunit test and the 3rd line shows it runs the
added test as expected.  Because the default kunit config contains only 3
lines, The 4th line command removes the sysctl kunit test from the
.kunitconfig.  However, the 5th line still run the test.

This patch is for such cases.  Of course, this might make more false positives
but I believe it would not be a big problem because .config generation takes no
long time.  If I missed something, please let me know.


Thanks,
SeongJae Park

> 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  tools/testing/kunit/kunit_kernel.py | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index cc5d844ecca1..a3a5d6c7e66d 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -111,17 +111,22 @@ class LinuxSourceTree(object):
> >                 return True
> >
> >         def build_reconfig(self, build_dir):
> > -               """Creates a new .config if it is not a subset of the .kunitconfig."""
> > +               """Creates a new .config if it is not a subset of, or older than the .kunitconfig."""
> >                 kconfig_path = get_kconfig_path(build_dir)
> >                 if os.path.exists(kconfig_path):
> >                         existing_kconfig = kunit_config.Kconfig()
> >                         existing_kconfig.read_from_file(kconfig_path)
> > -                       if not self._kconfig.is_subset_of(existing_kconfig):
> > -                               print('Regenerating .config ...')
> > -                               os.remove(kconfig_path)
> > -                               return self.build_config(build_dir)
> > -                       else:
> > +                       subset = self._kconfig.is_subset_of(existing_kconfig)
> > +
> > +                       kunitconfig_mtime = os.path.getmtime(kunitconfig_path)
> > +                       kconfig_mtime = os.path.getmtime(kconfig_path)
> > +                       older = kconfig_mtime < kunitconfig_mtime
> > +
> > +                       if subset and not older:
> >                                 return True
> > +                       print('Regenerating .config ...')
> > +                       os.remove(kconfig_path)
> > +                       return self.build_config(build_dir)
> >                 else:
> >                         print('Generating .config ...')
> >                         return self.build_config(build_dir)
> > --
> > 2.17.1
> >
