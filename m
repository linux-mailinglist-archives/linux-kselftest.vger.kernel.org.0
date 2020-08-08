Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE5423F6FF
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Aug 2020 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHHIvG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Aug 2020 04:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726256AbgHHIvG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Aug 2020 04:51:06 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B13C061A27
        for <linux-kselftest@vger.kernel.org>; Sat,  8 Aug 2020 01:51:05 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so2230463pgc.8
        for <linux-kselftest@vger.kernel.org>; Sat, 08 Aug 2020 01:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iJ0NqtLhxMa8vy08p3okMi0ViGuJVupVz011S0TP8uw=;
        b=cImpvsWPA0tuRi4FaCIuCkXN09crvNWiva4SxYghBRxe6QF2UvZhTPYZb15Kg/i6q4
         U04UHFT/tSEwoIikSa9Sv9Ww6ahDFtp7AX/xoeCrjs09WdmOunuqUuQll8zvKiEI8xWl
         B5SS6ez59kzeNCmSP6eRF54eKARyzxYPJoGuqXxvfJ70QYV54PMxDCXnbPFnZd2eECBk
         bmMzFz8Q5U4eOEvqpx12T5+VfNpUNdTNemuIe3yul8DlBqCwiMSFO4FzonQLwBbiAD17
         hyRba4cPe6q4owa2MM8Q//2W8lXY3zXmDtx5B9W/F+2EeHESKda7rDJvNkzrsIeEJGv+
         a4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iJ0NqtLhxMa8vy08p3okMi0ViGuJVupVz011S0TP8uw=;
        b=qN+KpVdoM/IshyJGSrdnnwLEqTs0SWwSIuPHLoSsGP9MPM8so3zoLT0tFuaaEhBmxX
         jIwe/RUczg2UGLV58wKRECja/icD0j461HgLX6XFdAGP4/H8VBKoZE4sbtH8W+jK9DQj
         /KkMeDmmyq499magniGVXkCdeplECzE7s8qnOlepi649IdKE6NbouoV+AMYdESa1MdVH
         QPuqWAlFY5zqCzPfiBETUlB7GdSxdzR+rMsTqSg1BjVNWkNDqcK4kjKAZdbghzixdmwz
         U8FAi9zzKknwUv+5xzGo85sYjHJODm0pAjf7dFNWbYRHiq/NgcMq1dfrAr5PhHI/ohcT
         DZ/w==
X-Gm-Message-State: AOAM532pAdGi2h8Vp93FBP3qkzpDTQ0Mme/L/8e8Gj6jP5LNwP+W2g7Z
        IKGMn9HoCA4SmyzNO4fJq93SHRSFxsrpw9JF9F0CZg==
X-Google-Smtp-Source: ABdhPJxAo+2rzPqPflRATM8sZ8jKh8Eqk5Td2gDaK3rMsOsNEKuQG6IxCX+MvyVsMYXGQLQwroTsDDpIERUbjKXA8v0=
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr14337055pgc.384.1596876664643;
 Sat, 08 Aug 2020 01:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com> <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com>
In-Reply-To: <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Sat, 8 Aug 2020 01:50:53 -0700
Message-ID: <CAFd5g47itmDHzVRiihUe_P2yjqGuvGC8LPLpiDx1D8aQX1T1BA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
To:     David Gow <davidgow@google.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 7, 2020 at 10:45 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Aug 8, 2020 at 9:17 AM Brendan Higgins
> <brendanhiggins@google.com> wrote:
> >
> > Currently kunit_tool does not work correctly when executed from a path
> > outside of the kernel tree, so make sure that the current working
> > directory is correct and the kunit_dir is properly initialized before
> > running.
> >
> > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > ---
> >  tools/testing/kunit/kunit.py | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > index 425ef40067e7..96344a11ff1f 100755
> > --- a/tools/testing/kunit/kunit.py
> > +++ b/tools/testing/kunit/kunit.py
> > @@ -237,9 +237,14 @@ def main(argv, linux=None):
> >
> >         cli_args = parser.parse_args(argv)
> >
> > +       if get_kernel_root_path():
> > +               print('cd ' + get_kernel_root_path())
> Do we want to print this, or is it a leftover debug statement?

Whoops, I was supposed to delete that. That's embarrassing... ^_^;

> > +               os.chdir(get_kernel_root_path())
> > +
> >         if cli_args.subcommand == 'run':
> >                 if not os.path.exists(cli_args.build_dir):
> >                         os.mkdir(cli_args.build_dir)
> > +                       create_default_kunitconfig()
> Why are we adding this everywhere when it's already in config_tests,
> which should already be called in all of the places where a
> kunitconfig is required?

Ah yes, .kunitconfig needs to be created before config_tests() can be
called because the LinuxSourceTree constructor needs .kunitconfig to
exist.

> Is the goal to always copy the default kunitconfig when creating a new
> build_dir? While I can sort-of see why we might want to do that, if
> the build dir doesn't exist, most of the subcommands will fail anyway
> (maybe we should only create the build-dir for 'config' and 'run'?)

I just did it because we were getting a failure in a constructor so we
couldn't do much. Ideally we would check that the current state allows
for the command that the user intended to run, but I think that's
beyond the scope of this change.

So I guess the real question is: Is it okay for it to crash in the
constructor with a cryptic error message for now, or do we want to let
it fail with a slightly less cryptic message later?

> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> > @@ -257,6 +262,7 @@ def main(argv, linux=None):
> >                 if cli_args.build_dir:
> >                         if not os.path.exists(cli_args.build_dir):
> >                                 os.mkdir(cli_args.build_dir)
> > +                               create_default_kunitconfig()
> >
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> > @@ -273,6 +279,7 @@ def main(argv, linux=None):
> >                 if cli_args.build_dir:
> >                         if not os.path.exists(cli_args.build_dir):
> >                                 os.mkdir(cli_args.build_dir)
> > +                               create_default_kunitconfig()
> >
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> > @@ -291,6 +298,7 @@ def main(argv, linux=None):
> >                 if cli_args.build_dir:
> >                         if not os.path.exists(cli_args.build_dir):
> >                                 os.mkdir(cli_args.build_dir)
> > +                               create_default_kunitconfig()
> >
> >                 if not linux:
> >                         linux = kunit_kernel.LinuxSourceTree()
> >
> > base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> > --
> > 2.28.0.236.gb10cc79966-goog
> >
