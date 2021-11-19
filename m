Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9F456AA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Nov 2021 08:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbhKSHHl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Nov 2021 02:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhKSHHk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Nov 2021 02:07:40 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F04C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 23:04:39 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id s13so16396535wrb.3
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Nov 2021 23:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9ywz+qPtr3kMkJg0gX/ZppmmwhgvXrP1RWc4y++VqU=;
        b=tHpX50m1+YiJw8qICGW0ZAd9mdkdypovPNyhOZCg48UcG5cro4QAUIKgnkApGz2U+D
         71GQkj1wu2Z7P+zsdIVmuUCqxv5mfUyplL6KlmXNsYoepxNyg68KeB//YfV2pMfTAwVe
         0Y8aRNo2KNDBP5dlEgVy5uO7YatGuDOn+sSvOhDUAqspPCtS15UaJdczgIxhbdbMzX7X
         jG5lModr2eSPDX9VvR42TMRSLAq/3R11U3pU5BBUUoKtsme7H3XssJ094U47n+uVtc3f
         Ln/tLT6ZMMggtQmwdnofzdM7dRyrvsc8OyxD9xNqfJkQpeX+vozvKD2+yovyit0JEctw
         JthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9ywz+qPtr3kMkJg0gX/ZppmmwhgvXrP1RWc4y++VqU=;
        b=bXr5r2iId4eYSUBJfBdyYo05iNp6Fr6L06+unBLI1iaTjkcn2Z+TT/snhGpt2puGds
         LRnv3JgijrsM741hYnMTz4Oi1NHYfMxI4B36sAT2PG57lE+kUHU+49Op70FhTSBUmRIu
         Utle/zm0FjgTyrBTUMRhFB9pfhMrnkyRITFm+PDE7S9RqjGdW6c0cJlPi+7vNDym6hxx
         7obXO+VFs+BRL/ygq4rvfk38nDymUMgue7UtzyyMSe+s+qzqDdC8MDZ+4Bbm66zGMDMP
         LSOtEnqIrwzbStpog7ptOY4NtWK3WGNDX4Ph62cYimBflrfc6de/HkyYuyySOmw7Szce
         x4fQ==
X-Gm-Message-State: AOAM533GBw4KuBcoExlOHZAegvc+HPBVa1Usn4nACcdYEht+nYdIf2Yf
        2ImEgTj6DO2JuQ0lH2FYrx9qqv17gNxABIy6wsjrlw==
X-Google-Smtp-Source: ABdhPJxL67dZ1oH5x8jAN3vTatr9KzJbd/6vzPxJUM7c0D16vylipDE5gOfWbS9NA1hrFF/Q1CuYaD5FkK4woL+ehA4=
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr4446434wrs.437.1637305477189;
 Thu, 18 Nov 2021 23:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20211118190329.1925388-1-dlatypov@google.com>
In-Reply-To: <20211118190329.1925388-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 19 Nov 2021 15:04:26 +0800
Message-ID: <CABVgOSnfuYnLOHLvRn5EQ_pghh+Q=-ewxTyRoB-oEOsEsx_O6g@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: reconfigure when the used kunitconfig changes
To:     Daniel Latypov <dlatypov@google.com>
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 19, 2021 at 3:03 AM 'Daniel Latypov' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> Problem: currently, if you remove something from your kunitconfig,
> kunit.py will not regenerate the .config file.
> The same thing happens if you did --kunitconfig_add=CONFIG_KASAN=y [1]
> and then ran again without it. Your new run will still have KASAN.
>
> The reason is that kunit.py won't regenerate the .config file if it's a
> superset of the kunitconfig. This speeds it up a bit for iterating.
>
> This patch adds an additional check that forces kunit.py to regenerate
> the .config file if the current kunitconfig doesn't match the previous
> one.
>
> What this means:
> * deleting entries from .kunitconfig works as one would expect
> * dropping  a --kunitconfig_add also triggers a rebuild
> * you can still edit .config directly to turn on new options
>
> We implement this by creating a `last_used_kunitconfig` file in the
> build directory (so .kunit, by default) after we generate the .config.
> When comparing the kconfigs, we compare python sets, so duplicates and
> permutations don't trip us up.
>
> The majority of this patch is adding unit tests for the existing logic
> and for the new case where `last_used_kunitconfig` differs.
>
> [1] https://lore.kernel.org/linux-kselftest/20211106013058.2621799-2-dlatypov@google.com/
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

Note that this patch has some prerequisites before it applies cleanly,
notably this series:
https://patchwork.kernel.org/project/linux-kselftest/list/?series=576317

I'm also seeing a couple of issues with this, though I haven't had a
chance to track down the cause fully, so it could just be another
missing prerequisite, or me doing something silly.

In particular:
- Removing items from .kunit/.kunitconfig still wasn't triggering a reconfig.
- Running with --arch=x86_64 was giving me a "FileNotFoundError:
[Errno 2] No such file or directory: '.kunit/last_used_kunitconfig'"
error:

davidgow@spirogrip:~/kunit-linux$ ./tools/testing/kunit/kunit.py run
--arch=x86_64
[23:00:01] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=x86_64 olddefconfig O=.kunit
Traceback (most recent call last):
 File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
line 503, in <module>
   main(sys.argv[1:])
 File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
line 420, in main
   result = run_tests(linux, request)
 File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
line 216, in run_tests
   config_result = config_tests(linux, config_request)
 File "/usr/local/google/home/davidgow/kunit-linux/./tools/testing/kunit/kunit.py",
line 62, in config_tests
   success = linux.build_reconfig(request.build_dir, request.make_options)
 File "/usr/local/google/home/davidgow/kunit-linux/tools/testing/kunit/kunit_kernel.py",
line 320, in build_reconfig
   return self.build_config(build_dir, make_options)
 File "/usr/local/google/home/davidgow/kunit-linux/tools/testing/kunit/kunit_kernel.py",
line 295, in build_config
   os.remove(old_path)  # write_to_file appends to the file
FileNotFoundError: [Errno 2] No such file or directory:
'.kunit/last_used_kunitconfig'


Otherwise, while I wasn't completely convinced by this change at
first, I'm much happier with it having thought a bit more about it, so
I'm definitely on-board with the idea. My only real reservation is
that this is a change in behaviour, and some people (including me)
occasionally may rely on the old behaviour. This does make more sense
now, though, and the old behaviour wasn't useful enough to justify it,
IMHO.

Cheers,
-- David
