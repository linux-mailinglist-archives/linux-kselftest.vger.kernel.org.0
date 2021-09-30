Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8A41D091
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Sep 2021 02:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbhI3AdP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 20:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347101AbhI3AdN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 20:33:13 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C51C061769
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 17:31:31 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id h129so5452579iof.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 17:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9NjcevKVQnuN/WpP0xQVPji3i7t1zFWrbtswcvHVvUQ=;
        b=nvWQPojwziT2LIh5zLMcmo+Uw9XqNGKaC3uepwbdLT72Iy0/Dyq9f6d4anFJKpExsL
         5HOoWfk7iecZUgYP9wKEvnh2NAoYXmWt5RUeRUIna4dKRIWk9ndIem9ab+DTyW3vN4Ac
         OAALCn0Ad0uOLhLPVwU4bFOoCCh6zZW5wUn6+4Gax8kAP6k7vBxZwEjMgjMgpBTwqNzx
         ZVwtNGm6RQ5yrUJX+92arH0BZQNSFjJFEutJrYW+QSrXtY+R7LjqSOX7ovQqyKmfGVhv
         QjhgcQHJ1ng2EwRxJf2Cwq4Dy2o08Wx8oz2LIh0UiLOaXyhMJ+8H2REFQ/Sr/eg+JWKD
         dYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9NjcevKVQnuN/WpP0xQVPji3i7t1zFWrbtswcvHVvUQ=;
        b=4Lqh5W546LRoNQYfm1ManG/EUwW2wRlzmZI85JLqMsBJTjd5leXqwvjW6H3Cn+hDri
         0LVw3O5lEHd+CTLaME5Xv9nImBBvVKFu+2mnYOn7YeBboSpboYKgQ0u0/8aznWM/Y+sa
         cj/upvsHu2bZN+EQjnaHx+RliUunPnGJlBbzm9ykHChtFvQ/vpS+ja+J/Vy7bLNbgMFr
         W4/XI+QcMQuZSJ8iaDkufvGVMDOoGUlwV4ZIb19h8J5jyzdt1zergzqrCj9XKyzu5dwa
         oxVeQqxxbTUZFL4v+p8A3Kepktb+3ncc7ExAJT7OztCANzLmeHlS1A1DthBqSYj0VKbS
         Gbcw==
X-Gm-Message-State: AOAM530v01RDbcni0MCL9PEptSrQQd3+lQabwndXKpPZXEAPq0aWbtqQ
        A5w3YmTu1AfEMg6O1uHfNbXR0JUp4gL9kTVywks2cg==
X-Google-Smtp-Source: ABdhPJx8XeRn22WRZ1l1qajtaT5Xp/jZn4t2MjPRxGhCIwcSOkEMaxOENqBivBKM2TuPHtc1pt67IWhU7YvLPQT6BXU=
X-Received: by 2002:a5e:8d16:: with SMTP id m22mr1936850ioj.62.1632961890953;
 Wed, 29 Sep 2021 17:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210929232534.1433720-1-dlatypov@google.com> <CABVgOSn7KpVj_+3YYrO1DkNxHkO3VJcUYjXuD+RSNHV_aZC6_Q@mail.gmail.com>
In-Reply-To: <CABVgOSn7KpVj_+3YYrO1DkNxHkO3VJcUYjXuD+RSNHV_aZC6_Q@mail.gmail.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Wed, 29 Sep 2021 17:31:19 -0700
Message-ID: <CAGS_qxpodcw=BzjGU5jxMvkT4P3_dsO7VFv4yf0sw0tHcStoUA@mail.gmail.com>
Subject: Re: [PATCH] kunit: tool: show list of valid --arch options when invalid
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 29, 2021 at 5:23 PM David Gow <davidgow@google.com> wrote:
>
> On Thu, Sep 30, 2021 at 7:26 AM Daniel Latypov <dlatypov@google.com> wrote:
> >
> > Consider this attempt to run KUnit in QEMU:
> > $ ./tools/testing/kunit/kunit.py run --arch=x86
> >
> > Before you'd get this error message:
> > kunit_kernel.ConfigError: x86 is not a valid arch
> >
> > After:
> > kunit_kernel.ConfigError: x86 is not a valid arch, options are ['alpha', 'arm', 'arm64', 'i386', 'powerpc', 'riscv', 's390', 'sparc', 'x86_64']
> >
> > This should make it a bit easier for people to notice when they make
> > typos, etc. Currently, one would have to dive into the python code to
> > figure out what the valid set is.
> >
> > Signed-off-by: Daniel Latypov <dlatypov@google.com>
> > ---
>
> This is really nice, particularly given that we've had to reproduce
> that list in lots of talks, documentation, etc. and it could get
> out-of-date.
>
> Reviewed-by: David Gow <davidgow@google.com>
>
> [FYI: this didn't seem to apply cleanly to kselftest/kunit head, but
> it was a pretty minor issue with kunit_tool_test.py.]

Oh, this is on top of
https://lore.kernel.org/linux-kselftest/20210928221111.1162779-1-dlatypov@google.com/

I guess this line there
- tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+ kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 tripped things up a bit.

>
> Thanks,
> -- David
>
> >  tools/testing/kunit/kunit_kernel.py    | 5 +++--
> >  tools/testing/kunit/kunit_tool_test.py | 4 ++++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
> > index 1870e75ff153..a6b3cee3f0d0 100644
> > --- a/tools/testing/kunit/kunit_kernel.py
> > +++ b/tools/testing/kunit/kunit_kernel.py
> > @@ -198,8 +198,9 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
> >                 return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
> >         elif os.path.isfile(config_path):
> >                 return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
> > -       else:
> > -               raise ConfigError(arch + ' is not a valid arch')
> > +
> > +       options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
> > +       raise ConfigError(arch + ' is not a valid arch, options are ' + str(sorted(options)))
> >
> >  def get_source_tree_ops_from_qemu_config(config_path: str,
> >                                          cross_compile: Optional[str]) -> Tuple[
> > diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> > index cad37a98e599..2ae72f04cbe0 100755
> > --- a/tools/testing/kunit/kunit_tool_test.py
> > +++ b/tools/testing/kunit/kunit_tool_test.py
> > @@ -289,6 +289,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
> >                                 pass
> >                         kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
> >
> > +       def test_invalid_arch(self):
> > +               with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
> > +                       kunit_kernel.LinuxSourceTree('', arch='invalid')
> > +
> >         # TODO: add more test cases.
> >
> >
> >
> > base-commit: 865a0a8025ee0b54d1cc74834c57197d184a441e
> > --
> > 2.33.0.685.g46640cef36-goog
> >
