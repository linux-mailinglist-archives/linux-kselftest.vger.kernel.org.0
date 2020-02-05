Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA8E152431
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Feb 2020 01:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgBEAqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Feb 2020 19:46:19 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33283 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgBEAqT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Feb 2020 19:46:19 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so261958pfn.0
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Feb 2020 16:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jbXhZF5smr0VCo0yfjlueAkORaQkGkLfl7KuvZp7LOk=;
        b=trjQTKEcV+kKOikM42Wbf9MeohPKvpDiAR6wfK9tGdjNbhxbgKVMeLMLWqTzE75Lzj
         XzQs+PwDCYFs9bUQoYE/UEKUs9Y5i1ySE/A8x/y1p5rihW0ia1qJCvI4o0g+2NL6tdbP
         xwzp1yW2CKhSBPDOr/MQRlj8xdJj2QmgDO1ed+oyosoS+natcdwAVWisWdua+gUwW474
         /5qCy4pQhNfSWStJZv10Qv9YSge7DfzCzgvCj9QYXkTudU3qcokfz4DJEtFkQNl5DOwg
         AMv+zAAvp4HST/DZKJrcOyuy+KzgZIln5D5mZ5gNb1RqqcdrRmbTnqbt5KECWOI/Z22g
         D00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jbXhZF5smr0VCo0yfjlueAkORaQkGkLfl7KuvZp7LOk=;
        b=gHoctYTIqnM6jkMQ+mOEJjeGzLXQUFDdTTudytyDalettDPhJ/Gk3UJn4rYxgtZtbI
         ODRB6J5tc2iV9aymOARWAnAfwAd8yN7asWx18FdV78giR7915tviSok2JryUfnqwRiz2
         zffNV0SE5FhuMjdsQvhNLgg0zlEu5OybztaNjJQhk+dunLeSPzGP74JGQyIT6LYlX5j7
         LEpkFVenNEAtNkfxkI/olllnbIViaZswThu1rGqOzFq64l3J2qd1AX6pHF9cEPY3LQcX
         XofCCFLAe6xysHs45ndpHVGy6ZNxEeZWBB79N9/xYJgMDw76orq7LLxbjc8TjQZuEpTM
         qPHg==
X-Gm-Message-State: APjAAAU93kZg90/6FX2xEI0nRCN9iYfglT73s3j9mYIfASVuL4l7SLKt
        GOM5x68hSw/A44XCIeWA0PiLxDD3K24J8ndxQZwCdg==
X-Google-Smtp-Source: APXvYqyuxCKeLushwGlONzOojYKCDXVimXGzfxYP4SCMe7bIf2LPPR49Ss25lN0JapFZe7BHl9q2telKwkmu0HkG6/A=
X-Received: by 2002:a63:1d5f:: with SMTP id d31mr34692010pgm.159.1580863578322;
 Tue, 04 Feb 2020 16:46:18 -0800 (PST)
MIME-Version: 1.0
References: <CAFd5g46v-RyNMP7GROn4bUEAATOPZ=w5AyO+tvuTG25aqt6oAg@mail.gmail.com>
 <20200128060300.23989-1-sj38.park@gmail.com>
In-Reply-To: <20200128060300.23989-1-sj38.park@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 16:46:06 -0800
Message-ID: <CAFd5g448555=dKFQMbjJ6G=tvtfF5oJgTtTgGx+38Ls3VqHo5g@mail.gmail.com>
Subject: Re: Re: [PATCH] kunit/kunit_kernel: Rebuild .config if .kunitconfig
 is modified
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Sorry for the delay.

On Mon, Jan 27, 2020 at 10:03 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Mon, 27 Jan 2020 16:02:48 -0800 Brendan Higgins <brendanhiggins@google.com> wrote:
>
> > On Sat, Jan 25, 2020 at 5:59 PM <sj38.park@gmail.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > Deletions of configs in the '.kunitconfig' is not applied because kunit
> > > rebuilds '.config' only if the '.config' is not a subset of the
> > > '.kunitconfig'.  To allow the deletions to applied, this commit modifies
> > > the '.config' rebuild condition to addtionally check the modified times
> > > of those files.
> >
> > The reason it only checks that .kunitconfig is a subset of .config is
> > because we don't want the .kunitconfig to remove options just because
> > it doesn't recognize them.
> >
> > It runs `make ARCH=um olddefconfig` on the .config that it generates
> > from the .kunitconfig, and most of the time that means you will get a
> > .config with lots of things in it that aren't in the .kunitconfig.
> > Consequently, nothing should ever be deleted from the .config just
> > because it was deleted in the .kunitconfig (unless, of course, you
> > change a =y to a =n or # ... is not set), so I don't see what this
> > change would do.
> >
> > Can you maybe provide an example?
>
> Sorry for my insufficient explanation.  I added a kunit test
> (SYSCTL_KUNIT_TEST) to '.kunitconfig', ran the added test, and then removed it
> from the file.  However, '.config' is not generated again due to the condition
> and therefore the test still runs.
>
> For more detail:
>
>     $ ./tools/testing/kunit/kunit.py run --defconfig --build_dir ../kunit.out/
>     $ echo "CONFIG_SYSCTL_KUNIT_TEST=y" >> ../kunit.out/.kunitconfig
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>     $ sed -i '4d' ../kunit.out/.kunitconfig
>     $ ./tools/testing/kunit/kunit.py run --build_dir ../kunit.out/
>
> The 2nd line command adds sysctl kunit test and the 3rd line shows it runs the
> added test as expected.  Because the default kunit config contains only 3
> lines, The 4th line command removes the sysctl kunit test from the
> .kunitconfig.  However, the 5th line still run the test.
>
> This patch is for such cases.  Of course, this might make more false positives
> but I believe it would not be a big problem because .config generation takes no
> long time.  If I missed something, please let me know.

I think I understand.

It is intentional - currently - that KUnit doesn't generate a new
.config with every invocation. The reason is basically to support
interaction with other methods of generating .configs. Consider that
you might want to use make menuconfig to turn something on. It is a
pretty handy interface if you work on vastly different parts of the
kernel. Or maybe you have a defconfig that you always use for some
platform, I think it is easier to run

make foo_config; tools/testing/kunit/kunit.py run

Then having to maintain both your defconfig and a .kunitconfig which
is a superset of the defconfig.

Your change would make it so that you have to have a .kunitconfig for
every test environment that you care about, and you could not as
easily take advantage of menuconfig.

I think what we do now is a bit janky, and the use cases I mentioned
are not super well supported. So I am sympathetic to what you are
trying to do, maybe we could have a config option for it?

I think Ted and Bjorn might have opinions on this; they had some
related opinions in the past.
