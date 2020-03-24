Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3881903B5
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Mar 2020 03:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgCXC4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Mar 2020 22:56:17 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40891 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbgCXC4R (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Mar 2020 22:56:17 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so1810657wmf.5
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Mar 2020 19:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0+7iyULVUw6dbuIVInQO+4nPeWfn4xVz7ibloxImNQ=;
        b=pygvSvd+eSrvDdmSvX8FjMjj6JJjC9drPpobUWysZJHmY2+uVcZ/CK1j3o67YZSFev
         7rH2WjQYGKxuNOjOFg+MHVI1bcoY5f0hf6x2eHxK5zhTR4Opqgl4TJ4lHni0I/AE0Yhg
         t5QlwixxmXc68bdC1BDiwlnLNRKc4fPy/CexA1KMFW/JPN1/EWVb1MD55t6360/gh0Tr
         WvmGSqyc86YOZeRUPbn5LNVcMXD6H2cZc3+WNrK8It/KS/Fvkhi1g5e6Cs1LVFqrfZEi
         ce7M60lZ9CwU7UmHn0ok9azJpMCYwYBxhO+KCVpn63hS0jP/NswzeGUTC+OU6wiUAu3l
         5qOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0+7iyULVUw6dbuIVInQO+4nPeWfn4xVz7ibloxImNQ=;
        b=ms6Bv9KMNaLmFO+Uzw9riGZDy6nk3gke9AuMUmHEGUCG1TvKBEahKaVTLYIIZ6BF2X
         4ucLmbJkUKXe5/M66ZQx3mJIxp8UC+tDNbOgUSGhWCRcx4yUXLu/C+GvbcY3p+UbS3Sr
         4WNQSy1VVQ+UG8M7bMDh2WwJKJwKNiyFGJLTc37ob4jTUAnrEIOcpKC0IPOqG7e4eyeo
         KnqjcKtepIX9mri/wrUnO2pG3TxJiLwcjEmYMhvrF6mh+Oo3RKSOUPMp72vHSRKVKTT6
         SwY/FNLdE049iY3e03EFHibl57sts7E848NBExv2Q/pZNmDKo64xsLhUKiG50ZRundVh
         LhdA==
X-Gm-Message-State: ANhLgQ11zcRZ1I/3WRnodnGacbac6MxR65J2w1QMdns6E2C6o74Katvd
        DkBDcnAtorwQm/AZlgAWBufX+CUGq0Ycd0+1Jc9A5A==
X-Google-Smtp-Source: ADFU+vtDDkbuzT5Gw8bD3VQH7XBa3+hEnpPF8q/9mh4Mk8cuXyVL3lDQtyD9qM5xo1O9D4wQLY3hbJhIkJv3u9c9FXE=
X-Received: by 2002:a1c:2404:: with SMTP id k4mr2634050wmk.87.1585018574854;
 Mon, 23 Mar 2020 19:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200323192236.70152-1-brendanhiggins@google.com>
In-Reply-To: <20200323192236.70152-1-brendanhiggins@google.com>
From:   David Gow <davidgow@google.com>
Date:   Mon, 23 Mar 2020 19:56:03 -0700
Message-ID: <CABVgOSkf58zMRhpqoZY3cZuAfujnTwVe14xOMcS6VBC4S2+vEw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: add missing test data file content
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, Heidi Fahim <heidifahim@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 23, 2020 at 12:22 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add a missing raw dmesg test log to test the kunit_tool's dmesg parser.
> test_prefix_poundsign and test_output_with_prefix_isolated_correctly
> fail without this test log.
>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>

Tested-by: David Gow <davidgow@google.com>

This patch does indeed fix the kunit_tool's unit tests (run with
./tools/testing/kunit/kunit_tool_test.py).

Beforehand, it failed with the errors below:
======================================================================
ERROR: test_prefix_poundsign (__main__.KUnitParserTest)
----------------------------------------------------------------------
Traceback (most recent call last):
 File "./tools/testing/kunit/kunit_tool_test.py", line 208, in
test_prefix_poundsign
   self.assertEqual('kunit-resource-test', result.suites[0].name)
IndexError: list index out of range

======================================================================
FAIL: test_output_with_prefix_isolated_correctly
(__main__.KUnitParserTest)
----------------------------------------------------------------------
Traceback (most recent call last):
 File "./tools/testing/kunit/kunit_tool_test.py", line 116, in
test_output_with_prefix_isolated_correctly
   self.assertContains('TAP version 14\n', result)
 File "./tools/testing/kunit/kunit_tool_test.py", line 96, in
assertContains
   str(needle) + '" not found in "' + str(haystack) + '"!')
AssertionError: "TAP version 14
" not found in "<generator object isolate_kunit_output at 0x7f4e88d85ed0>"!

----------------------------------------------------------------------
Ran 20 tests in 0.022s

FAILED (failures=1, errors=1)
