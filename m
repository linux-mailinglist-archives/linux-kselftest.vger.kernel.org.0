Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3AE145780F
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234978AbhKSVUX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 16:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbhKSVUU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 16:20:20 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BECC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 13:17:18 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id x9so11494684ilu.6
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 13:17:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8ELWBcqkSolpZEFFX9Tm/wJ6vj79dx7uxDXP5Le+nI=;
        b=JN4FLXri1dmM3TTwvWU+rnhn/EXFHGU2Xmrlkoxd7URBqK4EQbaUwigHRUiQ4LYQrV
         BCXSv2MF3xh3lKZL4t1P/oftBa15+rCy5i393AjewxFnorE4b1Ujmr/Nlrno/p6+jD/o
         ctOKAM34bu3zrnbtKoEX1e1hLBbwZMn3RuZvolDl0zIa25dt8qi1SlpoUjgmjxnzFQo2
         aPxZH721fxOuqbVEpJTqpobKv50SbYdEEdh0S6ua46mHuiX1SK+NxnbOIQ540myHfnWz
         Dx+vQXK1ZlOWUfC15FO9an60q1p7IT2qKf1cPpUDVBmeK/zSRejCeXjVnMsTTtOHZoR7
         Mgmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8ELWBcqkSolpZEFFX9Tm/wJ6vj79dx7uxDXP5Le+nI=;
        b=NoX+dEHdP8MTwkk+6IwugjWaCC1YQ/h2OO5ItJ83k+QXfRrMpL+97ZL98QxmeK5jSR
         I2sajQr9tFiWfe33qhpWkEuDqNFwGSGhj07EyrpExn7JjW2tnzV6ubnKzXqIQ8BoEdwa
         AI/Xx7lrqZTTDulfTiWqObmxT2dOJSBwD3ZMbkP+ASe4+fhPgFUUQyx/3YY/zGl9045l
         wnpnrcSWwCxuFHbikrvArmBVRh49Us3HB2aP43OeXgi7M0UmLCpg4rsEgRV3eNvYx0XH
         mhzuK6L/F1NxxcA/ChjGQTX5M2A3SFESfGl+UdEqFqzlfxXx9/3sCV16cOGperdoUkoa
         Pskg==
X-Gm-Message-State: AOAM5329zpgBgGwO06GfDqkzxbDxcqgbOcRGkWZbOlCbKyjtfl6IGyP4
        9qCbjpFSMUmXLPLArSFuzO6pOZvpHDR0/0uzi3p2Rw==
X-Google-Smtp-Source: ABdhPJyCTcRzWd/bCvb4vu4Q6R1cEd14ZZV3J8oVfqVFEbwsboki59KfKhTFsq38oVnMLs+mPRZkvIcwT69mIWLn6iM=
X-Received: by 2002:a05:6e02:20ea:: with SMTP id q10mr6923711ilv.283.1637356637771;
 Fri, 19 Nov 2021 13:17:17 -0800 (PST)
MIME-Version: 1.0
References: <20211118190329.1925388-1-dlatypov@google.com> <CABVgOSnfuYnLOHLvRn5EQ_pghh+Q=-ewxTyRoB-oEOsEsx_O6g@mail.gmail.com>
In-Reply-To: <CABVgOSnfuYnLOHLvRn5EQ_pghh+Q=-ewxTyRoB-oEOsEsx_O6g@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 19 Nov 2021 13:17:05 -0800
Message-ID: <CAGS_qxppxgsZi4-D=DkirXNx2qeFozn_njhtZVCYPaVhAno-TQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: reconfigure when the used kunitconfig changes
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Nov 18, 2021 at 11:04 PM David Gow <davidgow@google.com> wrote:
>
> On Fri, Nov 19, 2021 at 3:03 AM 'Daniel Latypov' via KUnit Development
> <kunit-dev@googlegroups.com> wrote:
> >
> > Problem: currently, if you remove something from your kunitconfig,
> > kunit.py will not regenerate the .config file.
> > The same thing happens if you did --kunitconfig_add=CONFIG_KASAN=y [1]
> > and then ran again without it. Your new run will still have KASAN.
> >
> > The reason is that kunit.py won't regenerate the .config file if it's a
> > superset of the kunitconfig. This speeds it up a bit for iterating.
> >
> > This patch adds an additional check that forces kunit.py to regenerate
> > the .config file if the current kunitconfig doesn't match the previous
> > one.
> >
> > What this means:
> > * deleting entries from .kunitconfig works as one would expect
> > * dropping  a --kunitconfig_add also triggers a rebuild
> > * you can still edit .config directly to turn on new options
> >
> > We implement this by creating a `last_used_kunitconfig` file in the
> > build directory (so .kunit, by default) after we generate the .config.
> > When comparing the kconfigs, we compare python sets, so duplicates and
> > permutations don't trip us up.
> >
> > The majority of this patch is adding unit tests for the existing logic
> > and for the new case where `last_used_kunitconfig` differs.
> >
> > [1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> Note that this patch has some prerequisites before it applies cleanly,
> notably this series:
> https://patchwork.kernel.org/project/linux-kselftest/list/?series=576317
>
> I'm also seeing a couple of issues with this, though I haven't had a
> chance to track down the cause fully, so it could just be another
> missing prerequisite, or me doing something silly.
>
> In particular:
> - Removing items from .kunit/.kunitconfig still wasn't triggering a reconfig.

This is an edge case that only comes up the absolute first time you
switch to using kunit.py with this change.

If there's no last_used_kunitconfig file, this new check doesn't do anything.
See how it returns False when the file doesn't exist in _kconfig_changed().

Given you hit the error below about last_used_kunitconfig not
existing, I'm 99% this is what you ran into.

The file is currently only generated if we actually call `make oldefconfig`.
So if you just run `kunit.py run` a few times after this change with
no config changes, last_used_kunitconfig won't be created, and the new
check won't kick in.

We can avoid this one-time confusion by
* make _kconfig_changed() return True if last_used_kunitconfig doesn't
exist, since maybe the config did change.
* or always write last_used_kunitconfig on every invocation.

The first would trigger a false positive the first time a user uses
kunit.py after this change goes in.
It also lightly penalizes the user for messing with `last_used_kunitconfig`.

The second adds some overhead that isn't really necessary most of the time.
It also won't help with the absolute first time you run kunit.py after
this change.
But it will make it so the second time onwards will have the logic enabled.

So I'd personally prefer we leave it as-is.
To most users, this will be a transparent change, so there's no
expectations about it coming into play immediately.

> - Running with --arch=x86_64 was giving me a "FileNotFoundError:

Ah, this should be unrelated to --arch.
os.remove() throws an exception if the argument doesn't exist.

So the fix is
+ if os.path.exists(old_path)
      os.remove(old_path)  # write_to_file appends to the file

And ah, that didn't get caught by the added unit test since
build_config() is mocked out and it's in there, no build_reconfig().


> [Errno 2] No such file or directory: '.kunit/last_used_kunitconfig'"
> error:
>
> davidgow@spirogrip:~/kunit-linux$ ./tools/testing/kunit/kunit.py run
> --arch=x86_64
> [23:00:01] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=x86_64 olddefconfig O=.kunit
> Traceback (most recent call last):
>  File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
> line 503, in <module>
>    main(sys.argv[1:])
>  File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
> line 420, in main
>    result = run_tests(linux, request)
>  File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
> line 216, in run_tests
>    config_result = config_tests(linux, config_request)
>  File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
> line 62, in config_tests
>    success = linux.build_reconfig(request.build_dir, request.make_options)
>  File "/usr/local/google/home/davidgow/kunit-linux/tools/testing/kunit/kunit_kernel.py",
> line 320, in build_reconfig
>    return self.build_config(build_dir, make_options)
>  File "/usr/local/google/home/davidgow/kunit-linux/tools/testing/kunit/kunit_kernel.py",
> line 295, in build_config
>    os.remove(old_path)  # write_to_file appends to the file
> FileNotFoundError: [Errno 2] No such file or directory:
> '.kunit/last_used_kunitconfig'
>
>
> Otherwise, while I wasn't completely convinced by this change at
> first, I'm much happier with it having thought a bit more about it, so
> I'm definitely on-board with the idea. My only real reservation is
> that this is a change in behaviour, and some people (including me)
> occasionally may rely on the old behaviour. This does make more sense
> now, though, and the old behaviour wasn't useful enough to justify it,
> IMHO.
>
> Cheers,
> -- David
