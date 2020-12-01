Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7864F2C982C
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 08:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgLAHd2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Dec 2020 02:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727369AbgLAHd2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Dec 2020 02:33:28 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5ACC0613CF
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 23:32:47 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id z1so1270234ljn.4
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 23:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbe/nqv4yjxM4O/pibnJtQkmz5RlRahdxIO5m6H5lfQ=;
        b=C+31D/pUo6BHvkpQeHxLE0CfoWaV0WDs92vQAv1iJxxA1K58JacJ+xQiiKbEly2uM2
         t3w2LwG7D4fFHlAKH551zn27xAPSmUndtTtdMX7IT3fYT80kbr9Tb4ijpf/Lh+YYE18i
         5ifpH7VkJ/LX531opdhP3iEX5Xyc0IQazwlCFaAxwln3lQylnyK4+0bXAy1D0S1hqGKQ
         tDF5wxW1w2QFEvS+qtV73hvQ2ZqX5S9o7WayBvXmwNYCVNwU4KzSrVAk2yLpPbONkdTn
         rRbqIxwb8iZ5MhLKF6y8NbtDh4VFYTuUUgsSH1D7t+CSM3rv3/T0P/nNIYsxXQpilGdk
         BmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbe/nqv4yjxM4O/pibnJtQkmz5RlRahdxIO5m6H5lfQ=;
        b=AqWcrq7ewogoxxpv0dtIPtF2UNq7qOO70H5e01NXzpTD7KOVO2LBlpvzICh+vorIkH
         TQuvI5BWioZ8N+p2vbD5G7p6rctVc/EOQEhm1c6oqimCLMvZ9vYKNaPj/nzs+Ld/1jGh
         crBfiq5sU+1yTEmLT2xBvN2cQTIXIi9JN9s7yCbL48sf2XrfjzpAma+McWKJ67zXaQST
         wi3l9qWq5qP6s/JuGrEPR6ygVWmeuTCh4cFv3+hp0WB4BGh2+BC/HCS7gs9Eg0YnogWR
         dFkD0uSGETHm4VJwGkW/wQfBvzs+tlSc1pfJuNWIhOpvL+TrLc4IQDGN5R8WGMtDMZoC
         Z3cg==
X-Gm-Message-State: AOAM532yo57MsP5PyXJEYlhkSh1TA9W6KkTXtEFJ4oIDIGE+3lLfp/2Z
        vuhW5Y8WgwRvC2AERJiMzQiUaeol13Sp2hZ1gkd4ZOzPhCKgXLxX
X-Google-Smtp-Source: ABdhPJw5ydskKvMSHgHg0yzc/UMBCSR0JQ5sVG7sgmKBzXOJ2fu9M7YHGG5fQ6lCi46jRsOV1CoysUBGq1ZFK6JWFBQ=
X-Received: by 2002:a2e:9f16:: with SMTP id u22mr706251ljk.456.1606807966183;
 Mon, 30 Nov 2020 23:32:46 -0800 (PST)
MIME-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com>
In-Reply-To: <20201130233242.78413-1-dlatypov@google.com>
From:   David Gow <davidgow@google.com>
Date:   Tue, 1 Dec 2020 15:32:34 +0800
Message-ID: <CABVgOSmXK8KMf0pK4_yBK0W-+fK5f9nJvbCOpMiH67GQ8ASg=Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] kunit: tool: fix unit test cleanup handling
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

On Tue, Dec 1, 2020 at 7:32 AM Daniel Latypov <dlatypov@google.com> wrote:
>
> * Stop leaking file objects.
> * Use self.addCleanup() to ensure we call cleanup functions even if
> setUp() fails.
> * use mock.patch.stopall instead of more error-prone manual approach
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---

I won't pretend to be an expert on Python, but this seems good to me.
I tested it on my machine and it works fine.

So,
Reviewed-by: David Gow <davidgow@google.com>

-- Davkd

>  tools/testing/kunit/kunit_tool_test.py | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
> index 497ab51bc170..3fbe1acd531a 100755
> --- a/tools/testing/kunit/kunit_tool_test.py
> +++ b/tools/testing/kunit/kunit_tool_test.py
> @@ -288,19 +288,17 @@ class StrContains(str):
>  class KUnitMainTest(unittest.TestCase):
>         def setUp(self):
>                 path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
> -               file = open(path)
> -               all_passed_log = file.readlines()
> -               self.print_patch = mock.patch('builtins.print')
> -               self.print_mock = self.print_patch.start()
> +               with open(path) as file:
> +                       all_passed_log = file.readlines()
> +
> +               self.print_mock = mock.patch('builtins.print').start()
> +               self.addCleanup(mock.patch.stopall)
> +
>                 self.linux_source_mock = mock.Mock()
>                 self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
>                 self.linux_source_mock.build_um_kernel = mock.Mock(return_value=True)
>                 self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
>
> -       def tearDown(self):
> -               self.print_patch.stop()
> -               pass
> -
>         def test_config_passes_args_pass(self):
>                 kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
>                 assert self.linux_source_mock.build_reconfig.call_count == 1
>
> base-commit: b65054597872ce3aefbc6a666385eabdf9e288da
> --
> 2.29.2.454.gaff20da3a2-goog
>
