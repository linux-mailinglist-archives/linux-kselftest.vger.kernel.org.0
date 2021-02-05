Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D366A3119D8
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Feb 2021 04:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhBFCbd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 21:31:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhBFCbD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 21:31:03 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB596C08ED8D
        for <linux-kselftest@vger.kernel.org>; Fri,  5 Feb 2021 15:52:07 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id o21so4241921pgn.12
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Feb 2021 15:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tplZjrhwK0og+HFPZBrvcmGmXMT8WcYpGq1c6sxH3EY=;
        b=KKCagEzOnD3Ka8smtOSqfKaA6rCUwXFITgiZYNG+ObMNW6Bso8UfB4em9Yau++4euI
         ZPQsJEaOSY1LXpVMZqzO/ypoczSA7F1NrJdmbUTxECIVlBVH+AVxLgIrK+8Z4RrOE7Ia
         3c8mC1xxm+hGFqqhvakpbltxPGVAFkFW+PB+tcuWDgwVi3JndM+ezUkGNRqPvbgymrQ7
         9i6Hp+iV1ToEDxjbdO6pQ6ymIJpTCywYFbEJwkspaq/2veRMiE88QEjO+V3A7Ex3/wii
         HDxz4qa10yYtTXvh7jSEcFWv+yI0xws1Fx4UvbAaDKwmBH50i67rDJ1st7noBp7BnS6g
         h0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tplZjrhwK0og+HFPZBrvcmGmXMT8WcYpGq1c6sxH3EY=;
        b=FzrkFf0ZhjmJPg3saum9sS7nZpahJuvIQ1mlOGJ/XxorWhqlQTjsO68dI15gWN2KZj
         xsoPlG9f0tJGsIc5aYrLfrSf0YR+ndc4lY1q7CYW2YR6ByAUFx4sDMIoBaSB5muh/uf9
         MuRPKEvZMqqELGB/ou288sUTiG+6T1oAScOQJYkFjV9QH3RVfd/+CDCS6uU4mpzGFjEW
         ou8Zw+14Bmq/F3MnZNuitYczlXSXoxzVPY+eHVpkZBqsgcQ1g3eLEN6HztnD1/WBJu4i
         EuB6QPWNKn6BMANO+7pHb1Ax9pMTv+AWqCdXFif6zwGJvatDizzORTjwk8o0zQSBrPbW
         pdLg==
X-Gm-Message-State: AOAM531LHJRPtu/8eZjRCdeda5BfefmaZXuiRAcythvHfmf7xMTxAh3y
        m53tTRSB55CFgnXW11b5W1/nyR8dNxHtx/sOaqyony6saFaOeA==
X-Google-Smtp-Source: ABdhPJw9J0CiEg95zh8/XJVPfZuPthlj4aQGsTz5Tv3pfIrnQVYiEk0Uqf37sdmOsN1dLryXfclPx2yU0oK9/xjlKLw=
X-Received: by 2002:a65:4184:: with SMTP id a4mr6848425pgq.384.1612569127259;
 Fri, 05 Feb 2021 15:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20210204225448.1393741-1-dlatypov@google.com>
In-Reply-To: <20210204225448.1393741-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 5 Feb 2021 15:51:56 -0800
Message-ID: <CAFd5g448GebW-zYwRzfCkJqx-7VZZOa_7dfSuqX_pAJLk4+CyQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] kunit: support running subsets of test suites from kunit.py
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 4, 2021 at 2:54 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> When using `kunit.py run` to run tests, users must populate a
> `kunitconfig` file to select the options the tests are hidden behind and
> all their dependencies.
>
> The patch [1] to allow specifying a path to kunitconfig promises to make
> this nicer as we can have checked in files corresponding to different
> sets of tests.
>
> But it's still annoying
> 1) when trying to run a subet of tests
> 2) when you want to run tests that don't have such a pre-existing
> kunitconfig and selecting all the necessary options is tricky.
>
> This patch series aims to alleviate both:
> 1) `kunit.py run 'my-suite-*'`
> I.e. use my current kunitconfig, but just run suites that match this glob
> 2) `kunit.py run --alltests 'my-suite-*'`
> I.e. use allyesconfig so I don't have to worry about writing a
> kunitconfig at all.
>
> See the first commit message for more details and discussion about
> future work.
>
> This patch series also includes a bugfix for a latent bug that can't be
> triggered right now but has worse consequences as a result of the
> changes needed to plumb in this suite name glob.
>
> [1] https://lore.kernel.org/linux-kselftest/20210201205514.3943096-1-dlatypov@google.com/

I tried applying this series on top of several of your other patches
over the past cycle and running the kunit_tool unit tests
(kunit_tool_test.py) and I got several failures:

======================================================================
FAIL: test_exec_builddir (__main__.KUnitMainTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/testing/kunit/kunit_tool_test.py", line 417, in test_exec_builddir
    self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir,
timeout=300)
  File "/usr/lib/python3.8/unittest/mock.py", line 925, in
assert_called_once_with
    return self.assert_called_with(*args, **kwargs)
  File "/usr/lib/python3.8/unittest/mock.py", line 913, in assert_called_with
    raise AssertionError(_error_message()) from cause
AssertionError: expected call not found.
Expected: run_kernel(build_dir='.kunit', timeout=300)
Actual: run_kernel(timeout=300, filter_glob='', build_dir='.kunit')

======================================================================
FAIL: test_exec_passes_args_pass (__main__.KUnitMainTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/testing/kunit/kunit_tool_test.py", line 337, in
test_exec_passes_args_pass
    self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit',
timeout=300)
  File "/usr/lib/python3.8/unittest/mock.py", line 925, in
assert_called_once_with
    return self.assert_called_with(*args, **kwargs)
  File "/usr/lib/python3.8/unittest/mock.py", line 913, in assert_called_with
    raise AssertionError(_error_message()) from cause
AssertionError: expected call not found.
Expected: run_kernel(build_dir='.kunit', timeout=300)
Actual: run_kernel(timeout=300, filter_glob='', build_dir='.kunit')

======================================================================
FAIL: test_exec_timeout (__main__.KUnitMainTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/testing/kunit/kunit_tool_test.py", line 385, in test_exec_timeout
    self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit',
timeout=timeout)
  File "/usr/lib/python3.8/unittest/mock.py", line 925, in
assert_called_once_with
    return self.assert_called_with(*args, **kwargs)
  File "/usr/lib/python3.8/unittest/mock.py", line 913, in assert_called_with
    raise AssertionError(_error_message()) from cause
AssertionError: expected call not found.
Expected: run_kernel(build_dir='.kunit', timeout=3453)
Actual: run_kernel(timeout=3453, filter_glob='', build_dir='.kunit')

======================================================================
FAIL: test_run_builddir (__main__.KUnitMainTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/testing/kunit/kunit_tool_test.py", line 400, in test_run_builddir
    self.linux_source_mock.run_kernel.assert_called_once_with(
  File "/usr/lib/python3.8/unittest/mock.py", line 925, in
assert_called_once_with
    return self.assert_called_with(*args, **kwargs)
  File "/usr/lib/python3.8/unittest/mock.py", line 913, in assert_called_with
    raise AssertionError(_error_message()) from cause
AssertionError: expected call not found.
Expected: run_kernel(build_dir='.kunit', timeout=300)
Actual: run_kernel(timeout=300, filter_glob='', build_dir='.kunit')

======================================================================
FAIL: test_run_passes_args_pass (__main__.KUnitMainTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/testing/kunit/kunit_tool_test.py", line 344, in
test_run_passes_args_pass
    self.linux_source_mock.run_kernel.assert_called_once_with(
  File "/usr/lib/python3.8/unittest/mock.py", line 925, in
assert_called_once_with
    return self.assert_called_with(*args, **kwargs)
  File "/usr/lib/python3.8/unittest/mock.py", line 913, in assert_called_with
    raise AssertionError(_error_message()) from cause
AssertionError: expected call not found.
Expected: run_kernel(build_dir='.kunit', timeout=300)
Actual: run_kernel(timeout=300, filter_glob='', build_dir='.kunit')

======================================================================
FAIL: test_run_timeout (__main__.KUnitMainTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "tools/testing/kunit/kunit_tool_test.py", line 392, in test_run_timeout
    self.linux_source_mock.run_kernel.assert_called_once_with(
  File "/usr/lib/python3.8/unittest/mock.py", line 925, in
assert_called_once_with
    return self.assert_called_with(*args, **kwargs)
  File "/usr/lib/python3.8/unittest/mock.py", line 913, in assert_called_with
    raise AssertionError(_error_message()) from cause
AssertionError: expected call not found.
Expected: run_kernel(build_dir='.kunit', timeout=3453)
Actual: run_kernel(timeout=3453, filter_glob='', build_dir='.kunit')

----------------------------------------------------------------------
Ran 37 tests in 0.082s

FAILED (failures=6)
