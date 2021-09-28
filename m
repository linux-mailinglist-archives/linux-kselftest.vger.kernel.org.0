Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69D5441BA64
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 00:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbhI1WbS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 18:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbhI1WbN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 18:31:13 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C91AC06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 15:29:33 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w10-20020ac87e8a000000b002a68361412bso1400588qtj.7
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 15:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=GK5opevJbE32c+uEXxnNWpR+NW2MgdYAZczKGBZbPPk=;
        b=R2NGOz3lznmqE1yzhxeK0czRa7ELv6suiN00XtsJ37ykZr+h7LJR7NfJUc3/Mz2GGx
         rLFMSZDIaWmWU1CTml5uWa1hRMY1N0kdzUj9a5LZ8gKa7hUrLBpfPQu8Dxmj38sT9d8o
         RbhSxFPwLk1KogzBFIlRb6i6Y39ypoMvfXWQbeipr72qFSyhSgxpG7/9uA25QNUSdwZ9
         zgvaMgfJ1pn/LSHIlOoae/O1MFuMEXfAdJHmtPxn4Fdod+qiHQJ3djU1za4H0ymr4Ob/
         BjA57xVWkjjAbGl5AMYGodYJphEXEJ4agCBzOZM2dwtm+zEM4LV8yFojMz9GWjjTBcjS
         OVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=GK5opevJbE32c+uEXxnNWpR+NW2MgdYAZczKGBZbPPk=;
        b=w2Dp5T9ccmZ7P8Z1SqjOqPEZz4YKxdN+KkKP4yEbfKE/JBd+SWI2AXL7X4pKtoHX7r
         Fe08JNT1hgN1NB0eapZXKvhKBQJ8AxIK0DrQw2QvmETrzi08jJyAlGb+wpdxrB5DCEcC
         tns+0s4zOK3bFSaahjeuGhf8jenfM/32CWAoYrqKzeWJxyXZYpy7CJTKR+x86++Mn44t
         cAHB6PIw9h1Nr2q5B4hjFRFOUCW4UZhAxYoCMqZDlWu+xPM8IT4uA2zd2eCRpcj8LXhA
         wDFBnYkxDE6/RJdXCj7yw7QU747dZ2yjQSp/t7DRyEWj+O+eAEw5wgfRRlj/gPsDu4x3
         5klw==
X-Gm-Message-State: AOAM532DEH+gl03NqrFTUrCtPWaGYBn2VgL+5OU+TQQW811763Hsq3ee
        vRtOP1bEevyPNF5ySTQGzUG5os0TfrFdyQ==
X-Google-Smtp-Source: ABdhPJy9xul3oDu/FIQi1YAetTFUVHe4gqiVR9Y54+57SBGnGMMP/WdsiZ/2jNZPeAtOT08KU2KqB0bFqx2pfA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:981c:22f3:3855:9bb7])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:140c:: with SMTP id
 n12mr8214944qvx.39.1632868172824; Tue, 28 Sep 2021 15:29:32 -0700 (PDT)
Date:   Tue, 28 Sep 2021 15:29:23 -0700
Message-Id: <20210928222926.1180749-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 0/3] kunit: allow running test suites/cases individually
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

Daniel Latypov (3):
  kunit: add 'kunit.action' param to allow listing out tests
  kunit: tool: factor exec + parse steps into a function
  kunit: tool: support running each suite/test separately

 lib/kunit/executor.c                   |  45 ++++++++-
 tools/testing/kunit/kunit.py           | 127 +++++++++++++++++--------
 tools/testing/kunit/kunit_tool_test.py |  40 ++++++++
 3 files changed, 167 insertions(+), 45 deletions(-)


base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.685.g46640cef36-goog

