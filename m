Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3D10F1CE
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2019 21:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725835AbfLBU7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Dec 2019 15:59:38 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39549 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfLBU7i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Dec 2019 15:59:38 -0500
Received: by mail-lf1-f65.google.com with SMTP id q6so984177lfb.6;
        Mon, 02 Dec 2019 12:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JUXiWknTlgHQc/VaEzGlCuw+4pkNPjt8eB0ftM9tvIU=;
        b=mRGYhaCMvw/bQIYeE9dRvVxkVHCdIX+8fSv5bgHuSCqVfAd7oOInH+ajqTZQEUVAgo
         iiVBLkfbrukmcfASqZMfF7ZzpVIiMDZin+Rz5UcKAgKEDcBFWOEI4KwBQzxQOOhkPQmp
         MwFyZ1J+fYX6+zxHnnGE+aB+2fAPWoJOSujzxhS/a1URFcSyh75zw8lc0WSEHWTnD/yY
         4qYBNO1VCJR2F7eKxLt2tOUIzTUDXmWbP7NtMNewcHCP8kE1SNhRmzhF2/YzIOcJuYDQ
         pHlcJndQpgsBz+UWEEOnn1sZxM8rolI25vV4xp3Ll1rzo1QYeW5BoLmlByyv/KbAqTDK
         9fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JUXiWknTlgHQc/VaEzGlCuw+4pkNPjt8eB0ftM9tvIU=;
        b=UKOSljDRDn05Kt6a+d+L3weXDtmrz6Sshar34O3Ran7OS1d6CIiNYyywRIB0nF1jaa
         UwpBk+a3+WRFTlyhdn99//Vgd6ZzCh8AtB2T+vkTByMglY/fhLwQSWGLb3uFKQttHy0v
         OS6YzHM3eRaVIhJhw/i82NqC/PAzEUOCo8CNlmxKR8goFtlbcHtf1ZqYP/kl+m3979e7
         9JzDKSGnqFWWmNxbz9JG8BFM2LXNwCGAIC/Nh414W1TC+diR+Wv47PE6NdIM9KEGbCHE
         L59924lGaF2ttAnsumwDfDqz0Mjr+DdxH/d+MZNrwWI6xg24bqhwKBNf2pTUbrMxn/Ay
         dfFQ==
X-Gm-Message-State: APjAAAX25y2OfgsEWYQiuopUrmY/rjX/HnJEUkNe06N2UJ54B4OiEsjV
        xtmN7wLT2BAwJePyt9WLFWc2UZDmo8f5ofmCPQM=
X-Google-Smtp-Source: APXvYqz9DuMX+1L06tkoH0tDMZobzhWgcBEpGzp/wedAmvjhSAumh6A+QCoR2KSXiCW7rlRhMZ7I7K5qRG9WGJxvvx8=
X-Received: by 2002:ac2:5216:: with SMTP id a22mr626019lfl.18.1575320375964;
 Mon, 02 Dec 2019 12:59:35 -0800 (PST)
MIME-Version: 1.0
References: <1575242724-4937-1-git-send-email-sj38.park@gmail.com>
 <1575242724-4937-3-git-send-email-sj38.park@gmail.com> <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
In-Reply-To: <CAFd5g47C6OShsYy5ngSGTmkL3fQoj-6jb09iQ+CD6FE0usggCA@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Mon, 2 Dec 2019 21:59:09 +0100
Message-ID: <CAEjAshoLUQDWdg2LAzOzeDsiV_DRFzWqhCAkOaGK4B4nkLRgSA@mail.gmail.com>
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

On Mon, Dec 2, 2019 at 6:25 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> +David Gow - David has lots of good opinions on our documentation.
>
> On Sun, Dec 1, 2019 at 3:25 PM SeongJae Park <sj38.park@gmail.com> wrote:
> >
> > From: SeongJae Park <sjpark@amazon.de>
> >
> > The kunit 'Getting Started' document first shows the wrapper running
> > command.  However, a new user who simply following the command might
> > encounter a failure like below:
> >
> >     $ ./tools/testing/kunit/kunit.py run
> >     Traceback (most recent call last):
> >       File "./tools/testing/kunit/kunit.py", line 140, in <module>
> >         main(sys.argv[1:])
> >       File "./tools/testing/kunit/kunit.py", line 126, in main
> >         linux = kunit_kernel.LinuxSourceTree()
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_kernel.py", line 85, in __init__
> >         self._kconfig.read_from_file(KUNITCONFIG_PATH)
> >       File "/home/sjpark/linux/tools/testing/kunit/kunit_config.py", line 65, in read_from_file
> >         with open(path, 'r') as f:
> >     FileNotFoundError: [Errno 2] No such file or directory: 'kunitconfig'
> >
> > Though the reason of the failure ('kunitconfig') is explained in its
> > next section, it would be better to reduce any failure that user might
> > encounter.  This commit removes the example command for the reason.
>
> Seems reasonable.
>
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > ---
> >  Documentation/dev-tools/kunit/start.rst | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
> > index 78a0aed..e25978d 100644
> > --- a/Documentation/dev-tools/kunit/start.rst
> > +++ b/Documentation/dev-tools/kunit/start.rst
> > @@ -15,12 +15,6 @@ Included with KUnit is a simple Python wrapper that helps format the output to
> >  easily use and read KUnit output. It handles building and running the kernel, as
> >  well as formatting the output.
> >
> > -The wrapper can be run with:
> > -
> > -.. code-block:: bash
> > -
> > -   ./tools/testing/kunit/kunit.py run
> > -
> >  Creating a kunitconfig
> >  ======================
>
> I think maybe we should demote this section so that this is a
> subsection under KUnit Wrapper. Might also want to add a tie-in
> explaining why we are talking about kunitconfig here? Right now this
> kind of reads as a non sequitur.
>
> Note: we have tried to address this potential issue for new users in
> this patch under review:
>
> https://patchwork.kernel.org/patch/11252953/
>
> I don't feel strongly whether we do it your way or my way. What do
> other people think?

I totally agree your way :)


Thanks,
SeongJae Park

>
> >  The Python script is a thin wrapper around Kbuild as such, it needs to be
> > --
> > 2.7.4
> >
