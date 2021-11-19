Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74A9045798B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Nov 2021 00:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234609AbhKSX2i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 18:28:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbhKSX2h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 18:28:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50762C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:25:35 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id w22so14862828ioa.1
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Nov 2021 15:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=it3DWuW79u/nsdxkEb/2evJiil/sUQ4gb8oxX/K39ao=;
        b=SjrjZrYGldMVil7QLGqNC0WCKQauoOsWfor6s576d6XxjTeW5sl7wNMh5RjONv9VLt
         icPEpZi+eV/1CQaTpkw8hGGruJ1IV1WLHFwAGhbCG3Fw/gh7tb+qbpXI1rEC1j4mknWe
         7Td1iYbZJqy4pjqdd+Hfrx6TJzwSins/bduN+VvYXZFOtKAjrwe/mR/eLxnzXif/+4jI
         4/NqDxD9rvrLS0ZZc28nssTqErLfR72kZkC6Kl/WLeKjgSzZwbLXrCI3P7k4yJj4l9wf
         aepVdXhlieizJ0j7aP/AVsWAmhfZB7qkxqokqbUgPVcVfaMyDgGxPPtx6pHjScbPB3Ac
         qb3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=it3DWuW79u/nsdxkEb/2evJiil/sUQ4gb8oxX/K39ao=;
        b=sgSHpIQ+qCXjpdYA/ss7U2BECi5UECMF2n0AujvyG4UMKUO8MMVFZc6+HZYFQkG94i
         6tSJVlsSk5FueJEKUFgvvHlpteGqJU+Sv3Tn86kqvunV8kzFQEpjw4mgJWmI35IU8nBp
         hK2fPlWkOKDc1xQv6O5tMV+hBeQXO+97WEJozIgJalCQ5f6Sgrp4K2u04mp29TTNcLQK
         ZQghYy3nmm+6hLP/8PFrgb8T3Aw8LNwJT7GAvrmQ9o0fA/2yGXS7nRzltsBKyHIfjjqj
         c3HkR4km89flValZfdjxqZtMpWDNhcTrpSFzNEfIQbyDHWhB5vOmKMo0c/j39hvICXiM
         EQyg==
X-Gm-Message-State: AOAM531m9VDmTS05P5jyxI7N96X/RhhnbkXKnaR2Z1sERVtsdCyhXGFn
        E0huOoU3/UCG0ICLc6Unf9X3Zty0wr1QBWKI55XReg==
X-Google-Smtp-Source: ABdhPJxoH5kLk5SS6F9QfDbpPd3acmFNmh+8JAt0pc6hiRMtkXDdNroJi+lT882SuSmAE4VvNlFxqwimeVuPayK3m0s=
X-Received: by 2002:a05:6602:2b0b:: with SMTP id p11mr8512489iov.62.1637364334286;
 Fri, 19 Nov 2021 15:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20211118190329.1925388-1-dlatypov@google.com> <CABVgOSnfuYnLOHLvRn5EQ_pghh+Q=-ewxTyRoB-oEOsEsx_O6g@mail.gmail.com>
 <CAGS_qxppxgsZi4-D=DkirXNx2qeFozn_njhtZVCYPaVhAno-TQ@mail.gmail.com> <CABVgOSmT95SuLPfm7ARQ9erUeDkMuji1zCxPQnfyRwqOW-91mg@mail.gmail.com>
In-Reply-To: <CABVgOSmT95SuLPfm7ARQ9erUeDkMuji1zCxPQnfyRwqOW-91mg@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 19 Nov 2021 15:25:22 -0800
Message-ID: <CAGS_qxp1GRxzvM_4NoGD4qAnbfeKbedixThWgOAnCD0t5OYLuQ@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: reconfigure when the used kunitconfig changes
To:     David Gow <davidgow@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 3:06 PM David Gow <davidgow@google.com> wrote:
>
> On Sat, Nov 20, 2021 at 5:17 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > On Thu, Nov 18, 2021 at 11:04 PM David Gow <davidgow@google.com> wrote:
> > >
> > > On Fri, Nov 19, 2021 at 3:03 AM 'Daniel Latypov' via KUnit Development
> > > <kunit-dev@googlegroups.com> wrote:
> > > >
> > > > Problem: currently, if you remove something from your kunitconfig,
> > > > kunit.py will not regenerate the .config file.
> > > > The same thing happens if you did --kunitconfig_add=CONFIG_KASAN=y [1]
> > > > and then ran again without it. Your new run will still have KASAN.
> > > >
> > > > The reason is that kunit.py won't regenerate the .config file if it's a
> > > > superset of the kunitconfig. This speeds it up a bit for iterating.
> > > >
> > > > This patch adds an additional check that forces kunit.py to regenerate
> > > > the .config file if the current kunitconfig doesn't match the previous
> > > > one.
> > > >
> > > > What this means:
> > > > * deleting entries from .kunitconfig works as one would expect
> > > > * dropping  a --kunitconfig_add also triggers a rebuild
> > > > * you can still edit .config directly to turn on new options
> > > >
> > > > We implement this by creating a `last_used_kunitconfig` file in the
> > > > build directory (so .kunit, by default) after we generate the .config.
> > > > When comparing the kconfigs, we compare python sets, so duplicates and
> > > > permutations don't trip us up.
> > > >
> > > > The majority of this patch is adding unit tests for the existing logic
> > > > and for the new case where `last_used_kunitconfig` differs.
> > > >
> > > > [1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/
> > > >
> > > > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > > > ---
> > >
> > > Note that this patch has some prerequisites before it applies cleanly,
> > > notably this series:
> > > https://patchwork.kernel.org/project/linux-kselftest/list/?series=576317
> > >
> > > I'm also seeing a couple of issues with this, though I haven't had a
> > > chance to track down the cause fully, so it could just be another
> > > missing prerequisite, or me doing something silly.
> > >
> > > In particular:
> > > - Removing items from .kunit/.kunitconfig still wasn't triggering a reconfig.
> >
> > This is an edge case that only comes up the absolute first time you
> > switch to using kunit.py with this change.
> >
> > If there's no last_used_kunitconfig file, this new check doesn't do anything.
> > See how it returns False when the file doesn't exist in _kconfig_changed().
> >
> > Given you hit the error below about last_used_kunitconfig not
> > existing, I'm 99% this is what you ran into.
> >
> > The file is currently only generated if we actually call `make oldefconfig`.
> > So if you just run `kunit.py run` a few times after this change with
> > no config changes, last_used_kunitconfig won't be created, and the new
> > check won't kick in.
> >
> > We can avoid this one-time confusion by
> > * make _kconfig_changed() return True if last_used_kunitconfig doesn't
> > exist, since maybe the config did change.
> > * or always write last_used_kunitconfig on every invocation.
> >
> > The first would trigger a false positive the first time a user uses
> > kunit.py after this change goes in.
> > It also lightly penalizes the user for messing with `last_used_kunitconfig`.
>
> This seems like a good compromise to me: people are likely to get this
> change only after a major kernel release, and re-configuring then
> (even if not strictly necessary) doesn't seem totally silly. Equally,
> I think it's best for the behaviour to change exactly when the change
> goes in, rather than some unspecified time afterwards.

Sounds good, changed for v2.

>
> >
> > The second adds some overhead that isn't really necessary most of the time.
> > It also won't help with the absolute first time you run kunit.py after
> > this change.
> > But it will make it so the second time onwards will have the logic enabled.
> >
> > So I'd personally prefer we leave it as-is.
> > To most users, this will be a transparent change, so there's no
> > expectations about it coming into play immediately.
>
> As mentioned above, I'd prefer this be a little less transparent and
> come into play immediately. I don't think one extra reconfigure will
> be a problem for most users, and it'll be obvious it's caused by an
> update. Equally, I don't expect people will mess with
> `last_used_kunitconfig`, so that shouldn't be a problem?
>
> >
> > > - Running with --arch=x86_64 was giving me a "FileNotFoundError:
> >
> > Ah, this should be unrelated to --arch.
> > os.remove() throws an exception if the argument doesn't exist.
> >
> > So the fix is
> > + if os.path.exists(old_path)
> >       os.remove(old_path)  # write_to_file appends to the file
>
> Ah... makes sense. Let's fix this in the next revision.
>
> > And ah, that didn't get caught by the added unit test since
> > build_config() is mocked out and it's in there, no build_reconfig().
> >
> >
>
> So, could we have these changes for v2:
> - Reconfigure if there's no last_used_kunitconfig
> - Fix the os.remove() issue if last_used_kunitconfig doesn't exist.
> - Note the dependencies for this to merge cleanly in the email.
>
> Does that sound sensible?

v2: https://lore.kernel.org/linux-kselftest/20211119232316.2246034-1-dlatypov@google.com

>
> -- David
