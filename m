Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6714340209D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Sep 2021 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235677AbhIFUCN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Sep 2021 16:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhIFUCM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Sep 2021 16:02:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444D8C061575
        for <linux-kselftest@vger.kernel.org>; Mon,  6 Sep 2021 13:01:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so12964326ljn.1
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Sep 2021 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UkyLfdWueNNxe1Qb3XvyB9HNkffKZTQ0ibmlbba1EJ4=;
        b=OdQP2/gs45I/iflH232SnxOcuyBqUwcbIs0y6yWKkGq46J0EwBG/NkAHQJcAbav77d
         x/hazPng714LbqKQsjDV68TdMp7r6FisNye8g7p2rXtzuWEwx4qTEiLglMskrX8c4mdJ
         Fri/WAauDOPmTyJGo63j0XqDd3AbE2IVEwfik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=UkyLfdWueNNxe1Qb3XvyB9HNkffKZTQ0ibmlbba1EJ4=;
        b=uMJqxvUB9yI0b67lDcieScbc6Y4FU795kAK1Sf/0FspGy/D0SyL78jvvMaDwtaJRVz
         neXl7JGrGZLW2GWbuiAU4j+nsoCV3J1fNqwDjZDdKbpKF5eYpLo83MMh9S9bTAAtwkBY
         kLw5T9KoPya6hQ9+1oG0OVNpXa6F3E9TyNRnVP+7zrctVUTTx8LhlvnUb9rhvRVIKsvk
         Fq07y72pcecpum+FxNMFXeeTVnFwg7biFOfH+YxYwFkoalUF+GG9K5pmEvTG/KlI4MWy
         hdqGH/bZ9qeyk8Zb1aFI7dSDS8VBO/Tj4Wy2HZ69FtEvwKBd6e3Uo8BaaA7RrwEZL+tO
         PWYQ==
X-Gm-Message-State: AOAM533XBqATGlwr9wif5y0haQJzadIl4u0eXrVokG4Q7PLVv+XEvhSw
        Bbqv0+hd0mRoiE728PADIBs89TZXC8pgJVh1
X-Google-Smtp-Source: ABdhPJwnT17Mk4wmluvPZgKC1E41m67ou07g0g0aWMKvfrI2ED39XAPEaBtrpagKs/mUemrRNo6kEw==
X-Received: by 2002:a05:651c:118f:: with SMTP id w15mr11925726ljo.47.1630958465023;
        Mon, 06 Sep 2021 13:01:05 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id s9sm1176041ljp.34.2021.09.06.13.01.04
        for <linux-kselftest@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 13:01:04 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id m28so15195825lfj.6
        for <linux-kselftest@vger.kernel.org>; Mon, 06 Sep 2021 13:01:04 -0700 (PDT)
X-Received: by 2002:a05:6512:3da5:: with SMTP id k37mr10599018lfv.655.1630958463829;
 Mon, 06 Sep 2021 13:01:03 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Sep 2021 13:00:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
Message-ID: <CAHk-=wgd2eJrkQCb2Pd0Fzh3mX1AjMHXAjjYxOPdCNCRDx2oYg@mail.gmail.com>
Subject: Fixing up at least some fallout from '-Werror'
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     kunit-dev@googlegroups.com,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

So I just committed these three fixes:

   4b93c544e90e ("thunderbolt: test: split up test cases in
tb_test_credit_alloc_all")
   ba7b1f861086 ("lib/test_scanf: split up number parsing test routines")
   1476ff21abb4 ("iwl: fix debug printf format strings")

for the fallout from -Werror that I could easily check (mainly i386
'allyesconfig' - a situation I don't normally test).

The printk format string one was trivial and I hopefully didn't screw
anything up, but I'd ask people to look at and verify the two other
ones. I tried to be very careful, and organizing the code movement in
such a way that 'git diff' shows that it's doing the same thing before
and after, but hey, mistakes happen.

I found those two test-based ones somewhat annoying, because they both
showed how little the test infrastructure tries to follow kernel
rules. I bet those warnings have been showing up for a long long time,
and people went "that's not a relevant configuration" or had some
other reason to ignore them.

No, the test cases may not be relevant in most situations, but it's
not a good thing when something that is supposed to verify kernel
behavior then violates some very fundamental and core kernel rules.

And maybe it was simply missed. The one thing that was clear when I
did that thunderbolt thing in particular is how easy it is to create
variations of those 'struct some-assertion-struct' things on stack as
part of the KUNIT infrastructure. That's unfortunate. It is possible
that the solution to the kernel stack usage might have been to make
those structures static instead, but I didn't check whether the
description structs really can be.

It would be even nicer if they were 'static const'. Being fully
initialized instead of generating not only code that uses up stack,
but also the code to dynamically initialize them on the stack is all
kinds of nasty. I took one look at the generated code, and ran away
screaming.

Anyway, I'm adding the Kunit maintainer and lists here too, just to
see if maybe it could be possible to make those 'struct kunit_assert'
things and friends be static and const, but at least for the cases
that caused problems for i386, those three commits should make the
build pass.

The test_scanf case didn't actually use the Kunit infrastructure, the
stack use explosion is because gcc doesn't seem to combine stack
allocations in many situations. I know gcc *sometimes* does that stack
allocation combining, but not here. I suspect it might be related to
type aliasing, and only merging stack slots when they have the same
types, and thus triggered by the different result buffer sizes. Maybe.

             Linus
