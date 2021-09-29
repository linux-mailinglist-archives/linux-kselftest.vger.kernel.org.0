Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09BBD41CCF2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 21:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245152AbhI2T40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbhI2T4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 15:56:25 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5647DC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:54:44 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id o6-20020a05622a008600b002a6c2fbc853so9671043qtw.16
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Sep 2021 12:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=OiLVv+xlAY408jKup4fnR/QKBpKolunAgpCER+09La0=;
        b=NVz31hGg+OiDBrChin3fOWkXkIWb3ISmobKjwkzs0XPlc28pv+wuq00CWHagraj773
         zo3U/yk6XMMeIMJs2xYUJGGHz0uhr59tErdoYHAezMShRzTpFlOOswzlw/e+lJUMeWu9
         +rVzvPIZWHnQnFU173saT2ILUVo9wigRlPWMZxm0ydxYTDLpRMKvGNGelx+4/Hj+CNr0
         L+qDrKc5z6C8XdHySjQCvR75HnznMfvEmh6urSK7kzY67YeQE1xK81qNvIYHCDvbTnR8
         v6Jugm8TQ1RHqxOpl0sGZHnYB7mSP5couet8WA/K3pmqi7UBDJ/iygBfJ42TJ7VZPJuP
         d+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=OiLVv+xlAY408jKup4fnR/QKBpKolunAgpCER+09La0=;
        b=25t0MRu9yGjc+t6nvFRHpC8o8D1ANDyvIcZKMZly/c8DdKrcAeGE9lYZa4ZlF2G3iB
         8eIsg+hwYVSoVkYRHFLNXaiFZOEtFx8n29WrZZP08pvCZKEC3lnkxmIXJEgwdcjZ7NPg
         cu5VaTT4uUGZDRlZk2UMeQAgNf8vwoymv86BZiipuh10Rmsu5/tU5zPAyWs40mUZse4k
         TvozVoUA5W6fzE1Q1BTfJlN9WBaGP1Q8FRQDD8v/O3Wdnt8QNRfvBzxtOALax4kXgZYG
         FRE9zb52XppDND3g3SiLomW4Gfu3teqJ11YtnuO8WD0Dj1xj5fS1yHb3Ao/n6EdlyADu
         xPsA==
X-Gm-Message-State: AOAM5316UkpjFCUP5t5Z0hgVQe1D5FuGyIAmZsKyCe4E9q4GOuhPzrTn
        8zzuVYJPjboNeYgZxhLp2fo/3f+WUQ/vug==
X-Google-Smtp-Source: ABdhPJyiigPPp4XqOmZYp9GJQy5+YfZfy+Mm5NDfc+aIOt8KOrP4lLxG7SliycGcOcw426+rX1fOQPhhvOIN8w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:e473:7cd7:9986:85b7])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:1046:: with SMTP id
 l6mr287892qvr.6.1632945283492; Wed, 29 Sep 2021 12:54:43 -0700 (PDT)
Date:   Wed, 29 Sep 2021 12:54:32 -0700
Message-Id: <20210929195436.1405996-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 0/3] kunit: allow running test suites/cases individually
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

Daniel Latypov (4):
  kunit: add 'kunit.action' param to allow listing out tests
  kunit: tool: factor exec + parse steps into a function
  kunit: tool: actually track how long it took to run tests
  kunit: tool: support running each suite/test separately

 lib/kunit/executor.c                   |  45 ++++++++-
 tools/testing/kunit/kunit.py           | 129 +++++++++++++++++--------
 tools/testing/kunit/kunit_tool_test.py |  40 ++++++++
 3 files changed, 169 insertions(+), 45 deletions(-)


base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.685.g46640cef36-goog

