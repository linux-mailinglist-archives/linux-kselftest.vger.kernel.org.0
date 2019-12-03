Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5759610F9D2
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2019 09:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbfLCI1q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Dec 2019 03:27:46 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46633 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCI1q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Dec 2019 03:27:46 -0500
Received: by mail-lj1-f195.google.com with SMTP id z17so2696110ljk.13;
        Tue, 03 Dec 2019 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yVm6GRi8n03b9iXhiD9Ig4lQ+aGyXrPKPapCPEE2QD4=;
        b=gI26hrCGzMnZRsvS33C3KFeqDZnEAl8ozvgYPYTww0fs5diQhDmHdU8Ai+WjAunj95
         96UgqI3gZJtVz6zHkrY77AZLRz207UwLJl7qBz3BW1BlA7c4VVA5WNTnhXqwZQ0/2OPr
         aC4sPxs+TNk29bYOp7QD3myy/K+7UZTqekG3W8Qb1vdBC5NUpaA1hd3TcUUEXEUNe05R
         yCNMQHXpdK3RumbdbEUTAxtrleCch3pAqTDBGvlZ+AU/hfYDLCCdKX9OTSJRQuaj4c8y
         +8JEsTFGkJ6DambeOg/iWgdkC8YnfkDh1Kjv++SeC64crblvILPqTeHI9UlctJUYNrsN
         R9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yVm6GRi8n03b9iXhiD9Ig4lQ+aGyXrPKPapCPEE2QD4=;
        b=PoWnnGWoasy4rIqNBOSUEYoh/d3fvIQoJKhiEOxEt6JNJZLsvKBeURanjvXNa+RDGs
         cbRov3LCB4slvoqWFggTIZ43K5Ir3cJZA8lSis5u9kcJcJXnUcv3rAqF/0AKFB6PD6tv
         ZihRXPGVEYWBiFKILyVdHjgBQ7SYZajlNoJaM3vBLABEbaKjEs6+ANcGULBW+96Nd7Fq
         9ZzgyGntuOJkEunLDmDbPjjuiJjFhwzVDiZDkQQgSCcywpUS+AgMYLgYQYtwy9ys5Ruf
         ssAJOSpIZUd9KzKe3/H1Jdmkd9ZIlTHamh8/W7gp/r1xS2x9Os5pHvEYG/3nJjj0smNf
         mVNg==
X-Gm-Message-State: APjAAAVzLdRR1AJvUPZ/vyIFEieNni4RyY6lyUVXzgv2/0gJoObxhYaQ
        nViQ7pjfom7qKYDWHjfjHVrbsqfgEOQ+qBbIphk=
X-Google-Smtp-Source: APXvYqw+Q3tBF0eBXU1ulsHn3Yz4CHCRVFjaQ3C1AocE7BTbpmRWwIqGuvw8KoM/MpXdstTcHA2nJ2hU7RY/fkiMJTQ=
X-Received: by 2002:a05:651c:102c:: with SMTP id w12mr1763936ljm.53.1575361663976;
 Tue, 03 Dec 2019 00:27:43 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <1575242724-4937-3-git-send-email-sj38.park@gmail.com> <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
 <CAEjAshoLUQDWdg2LAzOzeDsiV_DRFzWqhCAkOaGK4B4nkLRgSA@mail.gmail.com>
In-Reply-To: <CAEjAshoLUQDWdg2LAzOzeDsiV_DRFzWqhCAkOaGK4B4nkLRgSA@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Tue, 3 Dec 2019 09:27:16 +0100
Message-ID: <CAEjAshq=QHdOsd7epLvT9kK-YW5ruyxQg8+U8hCO2tDtGeDyHA@mail.gmail.com>
Subject: Re: [PATCH 2/6] docs/kunit/start: Skip wrapper run command
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>, shuah <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 2, 2019 at 9:59 PM SeongJae Park <sj38.park@gmail.com> wrote:
>
> On Mon, Dec 2, 2019 at 6:25 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > +David Gow - David has lots of good opinions on our documentation.
> >
> > On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> > >
> > > From: SeongJae Park <sjpark@amazon.de>
> > >
> > > The kunit 'Getting Started' document first shows the wrapper running
> > > command.  However, a new user who simply following the command might
> > > encounter a failure like below:
> > >
> > >     $ ./tools/testing/kunit/kunit.py run
> > >     Traceback (most recent call last):
> > >       File "./tools/testing/kunit/kunit.py", line 140, in <module>
> > >         main(sys.argv[1:])
> > >       File "./tools/testing/kunit/kunit.py", line 126, in main
> > >         linux = kunit_kernel.LinuxSourceTree()
> > >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
> > >         self._kconfig.read_from_file(KUNITCONFIG_PATH)
> > >       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
> > >         with open(path, 'r') as f:
> > >     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
> > >
> > > Though the reason of the failure ('kunitconfig') is explained in its
> > > next section, it would be better to reduce any failure that user might
> > > encounter.  This commit removes the example command for the reason.
> >
> > Seems reasonable.
> >
> > > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > > ---
> > >  Documentation/dev-tools/kunit/start.rst | 6 ------
> > >  1 file changed, 6 deletions(-)
> > >
> > > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > > index 78a0aed..e25978d 100644
> > > --- a/Documentation/dev-tools/kunit/start.rst
> > > +++ b/Documentation/dev-tools/kunit/start.rst
> > > @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
> > >  easily use and read KUnit output. It handles building and running the kernel, as
> > >  well as formatting the output.
> > >
> > > -The wrapper can be run with:
> > > -
> > > -.. code-block:: bash
> > > -
> > > -   ./tools/testing/kunit/kunit.py run
> > > -
> > >  Creating a kunitconfig
> > >  ======================
> >
> > I think maybe we should demote this section so that this is a
> > subsection under KUnit Wrapper. Might also want to add a tie-in
> > explaining why we are talking about kunitconfig here? Right now this
> > kind of reads as a non sequitur.
> >
> > Note: we have tried to address this potential issue for new users in
> > this patch under review:
> >
> > https://patchwork.kernel.org/patch/11252953/
> >
> > I don't feel strongly whether we do it your way or my way. What do
> > other people think?
>
> I totally agree your way :)

For the reason, I removed this patch from the second version patchset[1].

[1] https://lore.kernel.org/linux-doc/1575361141-6806-1-git-send-email-sj38.park@gmail.com/


Thanks,
SeongJae Park

>
>
> Thanks,
> SeongJae Park
>
> >
> > >  The Python script is a thin wrapper around Kbuild as such, it needs to be
> > > --
> > > 2.7.4
> > >
