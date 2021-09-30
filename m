Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676FD41E3BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346605AbhI3WWg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 18:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbhI3WWf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 18:22:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DB7C06176A
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso10810026ybj.1
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=XcWUiZrKPvcsO2JyZO05WjXmCKArwR1SUmaqLWJ1TH8=;
        b=sKsGVMz2+yzKbIp/RGJtNRzunEBXXTIKXB1d256NaFkPCkx+gav3AAvoUzPocmg/XA
         ryYKc8ZjqqrrxazRYkISAL7RNlmrirot0VXFbnjgcN4TNa2ZLJiHF73v07Fk/Vg3F0iQ
         8FYXaFxqp3rSWPTfKcQc4eksM8Y9Mm2DTL6TxDRiGd1LKpAFybKNsi1nc1n6+myUNvEp
         KRQ67gohr2D3+4Jys1wqeV1Adjkwc2eU2A1R+cwDHGi6hSpH4D3qZMkVEKh8m7t7HQTM
         wTafqDzsWFbOyFXdYuwMjNsxwLcRAQCUCz6/P40f9AyXSCxNsuENVi1AGLNMGmWJvr8I
         snRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=XcWUiZrKPvcsO2JyZO05WjXmCKArwR1SUmaqLWJ1TH8=;
        b=qxI3OmvOIFqm6iIggGD2RK8B18/jYF0cTpMSDW9jcgTAcV8mJ5A0hxSbiUUsrrkacb
         AL8w5UYRXAo3y6RQgX0zxelWA13Fr7eoIgs5cZMo3QxW9EqzoDdcbL6uClPBB240MDbf
         tlPcfMuf/yT5R019qcucqy+AuU0MFMefRZSQb/ipAjscDK96Ode/+hX+Zmsprk3I5BZl
         zu5Dv8CRsE/roOzmTPfKSC3BdPA1ng9dt//Zx8vkqQDurCyGubtoIkZPbzHSOCYVUHTe
         ifySCfvxosx5Qzzr5X3ynV1I029O6IEozUMpEilsfX+CsR+WhJGnqqNIpo6gZDqKOY6m
         jjMg==
X-Gm-Message-State: AOAM533Ovzjdxgla1wF0fcaWI3B7lx7arFjysID5DodxcJHs651/djOd
        x6rlG7ozLPGYmPCkTUJ/dXIWqRrEFVQW2w==
X-Google-Smtp-Source: ABdhPJxD50RBcoG3NxE6a9bafyHFO5/7qK4AROrgxYz72WGLH1AhmwRPA2lubRUYWYmO0TZ2r7bWlDgpWHIYdA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:39fa:d88:fb3b:880e])
 (user=dlatypov job=sendgmr) by 2002:a25:fc05:: with SMTP id
 v5mr2022824ybd.120.1633040451780; Thu, 30 Sep 2021 15:20:51 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:20:44 -0700
Message-Id: <20210930222048.1692635-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 0/3] kunit: allow running test suites/cases individually
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Allow running each suite or each test case alone per kernel boot.
The motivation for this is to debug "test hermeticity" issues.
This new --run_isolated flag would be a good first step to try and
narrow down root causes.

Context: sometimes tests pass/fail depending on what ran before them.
Memory corruption errors in particular might only cause noticeable
issues later on. But you can also have the opposite, where "fixing" one
test causes another to start failing.

Usage:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test example

The last one would provide output like
  ======== [PASSED] example ========
  [PASSED] example_simple_test
  ============================================================
  Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
  Starting KUnit Kernel (2/3)...
  ============================================================
  ======== [SKIPPED] example ========
  [SKIPPED] example_skip_test # SKIP this test should be skipped
  ============================================================
  Testing complete. 1 tests run. 0 failed. 0 crashed. 1 skipped.
  Starting KUnit Kernel (3/3)...
  ============================================================
  ======== [SKIPPED] example ========
  [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
  ============================================================
  Testing complete. 1 tests run. 0 failed. 0 crashed. 1 skipped.

See the last patch's description for a bit more detail.

Meta:
The first patch is from another series with just a reworded commit
message, https://lore.kernel.org/linux-kselftest/20210805235145.2528054-2-dlatypov@google.com/

This patch series is based on Shuah's kunit branch:
https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/?h=kunit

Changes:
v1 -> v2: rebase onto Shuah's kunit branch, fix missing code in patch 1.
v2 -> v3: fix mypy errors, drop test plan from output, fix pre-existing
bug where kunit was not actually tracking test execution time (new patch 3).
v3 -> v4: attempt to filter out non-KUnit dmesg output when getting list
of test names, using this regex: ^[^\s.]+\.[^\s.]+$

Daniel Latypov (4):
  kunit: add 'kunit.action' param to allow listing out tests
  kunit: tool: factor exec + parse steps into a function
  kunit: tool: actually track how long it took to run tests
  kunit: tool: support running each suite/test separately

 lib/kunit/executor.c                   |  45 ++++++++-
 tools/testing/kunit/kunit.py           | 134 +++++++++++++++++--------
 tools/testing/kunit/kunit_tool_test.py |  40 ++++++++
 3 files changed, 173 insertions(+), 46 deletions(-)


base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.800.g4c38ced690-goog

