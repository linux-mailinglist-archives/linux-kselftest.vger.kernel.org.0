Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9A52C982F
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 08:33:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgLAHdx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 02:33:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbgLAHdw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 02:33:52 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6CFC0613D4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 23:33:12 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s30so2180156lfc.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 23:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLkue7K6jExHpwJWMRxV7/9D2xLrHZpnPA5DwXbXOm8=;
        b=SnOzZjB9WThwROzsyO6iuvFKBuHPXAjc8RhSlY4OR7cCdEehDTk0YBUXg/Bth3znKs
         /bJTxarNWBk2Fr82Arkcsg8FxU9UOp5NT76nLcM5IAer0tfS31/SXWIvaNlxnA9n8ZeU
         +aJ82prly9Z/HSSTvvNjFW2W59BRpU10SXFaxBqOENRA1YYXkzX5b2bA2T3oe/NLibnx
         6Vq1vQW3bO98qap3svw4zkOdtLSsKsN0GYRRcIZB4Nnf9yy+WTt/t1+4/4mAbVkYcGL4
         DHPDP4wT4Xkbm/T7cyn4cJLHdsIapBYp8jZ8VctYoYgZceRiwwEAknwKGQCvvgniaZq8
         /S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLkue7K6jExHpwJWMRxV7/9D2xLrHZpnPA5DwXbXOm8=;
        b=DQGqi9DhKqa7bkCpOZC7UmS7L71m6CJnQlOWhBcX2P/qWNZ2MyvKcnd2To8GGulKaj
         J4x98gR/+aoimzevgAT3fAa98iSkNNE8WVa6IfmDJx0QJmNOcV7LuD0p5ga0vEiWN7uz
         U/KsoN7HCscLK5d6M7hg9AYB3HZ4EC1xWmoWBsQsWdHvgAI/jbQ2DHtJSFVbAjw/g3hU
         ijjZPCs8tYpaZGfLft/EVRRgxI4B6oHE8PSLHgLT3IM4awSJ5DazzGlxyTtohjQSSdtx
         QIoOo6ag3pVEP5pj2pZi9i4hqj+chU9yrmZUHvpFp4KeYPqGtTBHKV6KlIQjfwwZIX1b
         /hIg==
X-Gm-Message-State: AOAM53364JyF/AQrF/Ul5Cq8bgxTKZMejuZj27npsCZTXe9hlVFKFdQ+
        8HQTYo/PT+s/JNZHVAqy03j5pQsXszorplxPFQZaDQ==
X-Google-Smtp-Source: ABdhPJz0bGkdl6XPJXs6wZfwa6p45SnjZjgvjGf0AvFfjTbuQPD22QeUQkfjFNmLBBuAIxgbSqADkSH42abW2ptHFRk=
X-Received: by 2002:a19:5e5e:: with SMTP id z30mr600885lfi.277.1606807990560;
 Mon, 30 Nov 2020 23:33:10 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com> <20201130233242.78413-2-dlatypov@google.com>
In-Reply-To: <20201130233242.78413-2-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Dec 2020 15:32:59 +0800
Message-ID: <CABVgOSmX3foOr6XJhQ_goYabFEg8qNYoQ+5O7JPRW=gLmh=OQA@mail.gmail.com>
Subject: Re: [PATCH 2/5] kunit: tool: fix unit test so it can run from
 non-root dir
To:     Daniel Latypov <dlatypov@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Dec 1, 2020 at 7:33 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> get_absolute_path() makes an attempt to allow for this.
> But that doesn't work as soon as os.chdir() gets called.

Can we explain why this doesn't work? It's because the test_data/
files are accessed with relative paths, so chdir breaks access to
them, right?

>
> So make it so that os.chdir() does nothing to avoid this.
>
> Note: mock.patch.object() doesn't seem to work in setUpModule(), hence
> the introduction of a new base class instead.
>
> Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kernel tree")
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I don't like this: disabling a real system call seems like overkill to
work around a path issue like this.

Wouldn't it be better to either:
(a) stop kunit_tool from needing to chdir entirely; or
(b) have get_absolute_path() / test_data_path() produce an absolute path.

The latter really seems like the most sensible approach: have the
script read its own path and read files relative to that.

Cheers,
-- David


>  tools/testing/kunit/kunit_tool_test.py | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 3fbe1acd531a..9f1f1e1b772a 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -32,7 +32,13 @@ def tearDownModule():
>  def get_absolute_path(path):
>         return os.path.join(os.path.dirname(__file__), path)
>
> -class KconfigTest(unittest.TestCase):
> +class KUnitTest(unittest.TestCase):
> +       """Contains common setup, like stopping main() from calling chdir."""
> +       def setUp(self):
> +               mock.patch.object(os, 'chdir').start()
> +               self.addCleanup(mock.patch.stopall)
> +
> +class KconfigTest(KUnitTest):
>
>         def test_is_subset_of(self):
>                 kconfig0 = kunit_config.Kconfig()
> @@ -88,7 +94,7 @@ class KconfigTest(unittest.TestCase):
>                 self.assertEqual(actual_kconfig.entries(),
>                                  expected_kconfig.entries())
>
> -class KUnitParserTest(unittest.TestCase):
> +class KUnitParserTest(KUnitTest):
>
>         def assertContains(self, needle, haystack):
>                 for line in haystack:
> @@ -250,7 +256,7 @@ class KUnitParserTest(unittest.TestCase):
>                                 result.status)
>                         self.assertEqual('kunit-resource-test', result.suites[0].name)
>
> -class KUnitJsonTest(unittest.TestCase):
> +class KUnitJsonTest(KUnitTest):
>
>         def _json_for(self, log_file):
>                 with(open(get_absolute_path(log_file))) as file:
> @@ -285,8 +291,9 @@ class StrContains(str):
>         def __eq__(self, other):
>                 return self in other
>
> -class KUnitMainTest(unittest.TestCase):
> +class KUnitMainTest(KUnitTest):
>         def setUp(self):
> +               super().setUp()
>                 path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
>                 with open(path) as file:
>                         all_passed_log = file.readlines()
> --
> 2.29.2.454.gaff20da3a2-goog
>
