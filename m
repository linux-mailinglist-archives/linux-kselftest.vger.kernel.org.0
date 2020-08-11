Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AE02415BC
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 06:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbgHKEaO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 00:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbgHKEaM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 00:30:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F2AC06174A
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 21:30:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so10159852wra.5
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Aug 2020 21:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UTA/jlI4ZkjE+5vHGh7qBO6GyXxZqYMrHrBvLYqNA/8=;
        b=ecIE6H8POPKe2GmWnNT6j85kVXuCut+VRP5UWYxjZhFuR0utGUaTCLiyLZFEFaDGXA
         Nk/IlTphNYMbm49+EFFnIapGm8TEPL82eic3iPh2Rlf0lJA+8IhA3A3oHXIQu8w5MVug
         OvVkhDq+VZYnuiK6dN1Bu0HPFneZmrTPkI3nfzbMatTEZlaex8bGobr6YOJ7YoXcI07z
         DkFRr3Qa5XPbsrwvmjqdYC/0QkNHbwQzMak6Zf9z33kZSpuCDs0VGKCcRf8TGkbkT+vT
         dqycUjwh94zMZvgPC4Dchf6trndi28QLRRNPB7oCxwuYZkAjf/7FraDP6yUyEczB2yKe
         wI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UTA/jlI4ZkjE+5vHGh7qBO6GyXxZqYMrHrBvLYqNA/8=;
        b=uFK/UcfbL4ISyiV8Rzo1cHPmp2zqvbq52uphnrWPuhW2qO6n9YqQbjQD7+aCP9sfXD
         VjZJiry5Mh9hBsGkMX8kGpPXH/rdS8IGOTlzUyWIyjoihb+S9DS4VgatpYkWLJi53Cs1
         juttCNuAqOkBaEmdPEc7KyneT9fvGHkH61AuPr5LcD+jNe62eA5K29BLe1krQ/EjacSH
         yjNACT+nq//u7+sRNhovp4TqeKtumLracVmufCxN9mUmSHh8aRq/WS+kwo6bLcytJYSE
         cePQDmHpAzbLzGXIqSC36c7C0vP4wFIaANnfEQ1SlraKXK3iiNQTtuvfw5Taoa56e1yU
         v5Zw==
X-Gm-Message-State: AOAM531MOUm3JIaJSp5NGnjV8azuYYU84f4MDTYk9QwqAeJfRNi7AYzA
        q8fw5xJMADyKQ3WfAxYjAvQiCTzAxz/+s4p1glnAuw==
X-Google-Smtp-Source: ABdhPJycvgzrejAmWvErgPyXmMcxP7oFh0zNGsbjxXriifiC7oqFsCyotTtJ4bM768Iz1pVpC2Nv3L+9xIOQhTKoCgc=
X-Received: by 2002:adf:f511:: with SMTP id q17mr4184981wro.414.1597120210798;
 Mon, 10 Aug 2020 21:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com>
 <CABVgOSkEiQkcOy+gF9irJo-R6xCeiCvDRZXa_ubzCfz+9Yx2ZA@mail.gmail.com> <CAFd5g47itmDHzVRiihUe_P2yjqGuvGC8LPLpiDx1D8aQX1T1BA@mail.gmail.com>
In-Reply-To: <CAFd5g47itmDHzVRiihUe_P2yjqGuvGC8LPLpiDx1D8aQX1T1BA@mail.gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 11 Aug 2020 12:29:59 +0800
Message-ID: <CABVgOSkpTuT6=V08xU0eun-7_OgMR2TdQe0f5rA=mvEPkVrrsw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] kunit: tool: fix running kunit_tool from outside
 kernel tree
To:     Brendan Higgins <brendanhiggins@google.com>
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

On Sat, Aug 8, 2020 at 4:51 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> On Fri, Aug 7, 2020 at 10:45 PM David Gow <davidgow@google.com> wrote:
> >
> > On Sat, Aug 8, 2020 at 9:17 AM Brendan Higgins
> > <brendanhiggins@google.com> wrote:
> > >
> > > Currently kunit_tool does not work correctly when executed from a path
> > > outside of the kernel tree, so make sure that the current working
> > > directory is correct and the kunit_dir is properly initialized before
> > > running.
> > >
> > > Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> > > ---
> > >  tools/testing/kunit/kunit.py | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> > > diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
> > > index 425ef40067e7..96344a11ff1f 100755
> > > --- a/tools/testing/kunit/kunit.py
> > > +++ b/tools/testing/kunit/kunit.py
> > > @@ -237,9 +237,14 @@ def main(argv, linux=None):
> > >
> > >         cli_args = parser.parse_args(argv)
> > >
> > > +       if get_kernel_root_path():
> > > +               print('cd ' + get_kernel_root_path())
> > Do we want to print this, or is it a leftover debug statement?
>
> Whoops, I was supposed to delete that. That's embarrassing... ^_^;
>
> > > +               os.chdir(get_kernel_root_path())
> > > +
> > >         if cli_args.subcommand == 'run':
> > >                 if not os.path.exists(cli_args.build_dir):
> > >                         os.mkdir(cli_args.build_dir)
> > > +                       create_default_kunitconfig()
> > Why are we adding this everywhere when it's already in config_tests,
> > which should already be called in all of the places where a
> > kunitconfig is required?
>
> Ah yes, .kunitconfig needs to be created before config_tests() can be
> called because the LinuxSourceTree constructor needs .kunitconfig to
> exist.

I see. I guess the ultimate solution will be for LinuxSourceTree not
require a .kunitconfig unless it's actually being used.

> > Is the goal to always copy the default kunitconfig when creating a new
> > build_dir? While I can sort-of see why we might want to do that, if
> > the build dir doesn't exist, most of the subcommands will fail anyway
> > (maybe we should only create the build-dir for 'config' and 'run'?)
>
> I just did it because we were getting a failure in a constructor so we
> couldn't do much. Ideally we would check that the current state allows
> for the command that the user intended to run, but I think that's
> beyond the scope of this change.
>
> So I guess the real question is: Is it okay for it to crash in the
> constructor with a cryptic error message for now, or do we want to let
> it fail with a slightly less cryptic message later?
>

I personally am leaning towards allowing it to crash in the build,
exec, etc. subcommands for now, and tidying up the error messages
later, rather than silently creating a blank build dir, only for it
then to fail later.

In the meantime, yeah, we can add this for the config and run tasks,
and maybe remove the whole "if cli_args.build_dir" / mkdir branch from
the other subcommands.

If we weren't going to fix the LinuxSourceTree constructor, it'd make
sense to get rid of the redundant code to create it in config_tests(),
too, but I'm not sure it's worthwhile.

In any case, now I know what's happening, I'm okay with anything
moderately sensible which gets the 'config' and 'run' subcommands
working on an empty build dir, and the code and error messages can be
fixed when tidying up the LinuxSourceTree() constructor in a separate
patch.

Cheers,
-- David

> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > > @@ -257,6 +262,7 @@ def main(argv, linux=None):
> > >                 if cli_args.build_dir:
> > >                         if not os.path.exists(cli_args.build_dir):
> > >                                 os.mkdir(cli_args.build_dir)
> > > +                               create_default_kunitconfig()
> > >
> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > > @@ -273,6 +279,7 @@ def main(argv, linux=None):
> > >                 if cli_args.build_dir:
> > >                         if not os.path.exists(cli_args.build_dir):
> > >                                 os.mkdir(cli_args.build_dir)
> > > +                               create_default_kunitconfig()
> > >
> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > > @@ -291,6 +298,7 @@ def main(argv, linux=None):
> > >                 if cli_args.build_dir:
> > >                         if not os.path.exists(cli_args.build_dir):
> > >                                 os.mkdir(cli_args.build_dir)
> > > +                               create_default_kunitconfig()
> > >
> > >                 if not linux:
> > >                         linux = kunit_kernel.LinuxSourceTree()
> > >
> > > base-commit: 30185b69a2d533c4ba6ca926b8390ce7de495e29
> > > --
> > > 2.28.0.236.gb10cc79966-goog
> > >
