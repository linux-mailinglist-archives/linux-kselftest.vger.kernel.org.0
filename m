Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E4523C0EB
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Aug 2020 22:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728092AbgHDUrz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 4 Aug 2020 16:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgHDUrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 4 Aug 2020 16:47:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D88EC06179E
        for <linux-kselftest@vger.kernel.org>; Tue,  4 Aug 2020 13:47:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n21so34447554ybf.18
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Aug 2020 13:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bdWZwbCIT3bffqBHb6yQ2UmqBVzTTDxDz7sK3Dmf5r4=;
        b=KwW8r91AHMUBg5mbfjpRjTR0cf8DPX1yH2l3+2XlygGEQCNkBkp2T2avLdbvlR2jc5
         ZQm2c//EyKWM6yPtV07c6G5etRYsRM9DZ2B75umwcvYj/eSDCb/0pmH3ChoVnbPee3sb
         9Nad960qcZ7Pntd3PNRvjToJEh98i1sw+0BoWjYtw9qBBjJ/OGfyiru1BE6QPWoaurg7
         u3xRcgLuUVZ44ozwU2hkrDxmjUESSDaE6J28cl2lPisJzKQK0i2ZR1wuI+4/SybCfSy6
         4co+aJUXzsaFTtcH1WE9aHdxc0jxWuPbUzb8KHakh/FPkJ210Kk3i2DBCdADP7ALt38o
         f3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bdWZwbCIT3bffqBHb6yQ2UmqBVzTTDxDz7sK3Dmf5r4=;
        b=ssTaGasRN8mrMgZa5oYZD48tqABOEVXBNeXhN5GGHHYRsWXwqvbr/3FFhZlXHHWRkq
         xMQTriwBu5mjOhmvOjZCPDV2gXBOWeqDhRwWtgratxMHP17MYQWVUsZ74XOtKWgNFEUT
         jFDJOxQM9eD9npWSpS3atmIKeus9+vOSybLGwZpFMY4RSWUF8JITLlrJbqXn+DYi2mpZ
         2YUn2UsRiPE360HLAQOjvpwaWjJK+0KR/GR5GVvsVtv2N/EfYigtmrr0fNRiLMZrB7EM
         R7l8/mf1ssE5rAVYp0SrwzmnBdkpDlhr/BJaJs2bFjH5l0icKA2Ht+8vXTACEocXlq/J
         W3Vw==
X-Gm-Message-State: AOAM531acko9kA+B2m3sfWHF+NCLUsUiaQWGR4AVJiDXXpfzn4Jdd2XY
        qOMP65TFUpTcF8iAfC4HrUT0v6wKDoEVYKJlmVuHPg==
X-Google-Smtp-Source: ABdhPJwYimCKG7zFBoA8l8yiip0nr1b5jytYj7cr6BxJOxfhLVlpZg6kC8ksmiseCKfq3ISGowf5zR5F1rWu8FFPMWnf3Q==
X-Received: by 2002:a25:5887:: with SMTP id m129mr39203687ybb.11.1596574072436;
 Tue, 04 Aug 2020 13:47:52 -0700 (PDT)
Date:   Tue,  4 Aug 2020 13:47:40 -0700
Message-Id: <20200804204745.987648-1-brendanhiggins@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
Subject: [PATCH v6 0/5] kunit: create a centralized executor to dispatch all
 KUnit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com,
        arnd@arndb.de, keescook@chromium.org, skhan@linuxfoundation.org,
        alan.maguire@oracle.com, yzaikin@google.com, davidgow@google.com,
        akpm@linux-foundation.org, rppt@linux.ibm.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, sboyd@kernel.org, logang@deltatee.com,
        mcgrof@kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

## TL;DR

This patchset adds a centralized executor to dispatch tests rather than
relying on late_initcall to schedule each test suite separately along
with a couple of new features that depend on it.

## What am I trying to do?

Conceptually, I am trying to provide a mechanism by which test suites
can be grouped together so that they can be reasoned about collectively.
The second to last patch in this series add features which depend on
this:

PATCH 04/05 Prints out a test plan[1] right before KUnit tests are run;
            this is valuable because it makes it possible for a test
            harness to detect whether the number of tests run matches
            the number of tests expected to be run, ensuring that no
            tests silently failed. The test plan includes a count of
            tests that will run. With the centralized executor, the
            tests are located in a single data structure and thus can be
            counted.

In addition, by dispatching tests from a single location, we can
guarantee that all KUnit tests run after late_init is complete, which
was a concern during the initial KUnit patchset review (this has not
been a problem in practice, but resolving with certainty is nevertheless
desirable).

Other use cases for this exist, but the above features should provide an
idea of the value that this could provide.

## Changes since last revision:
 - Renamed the KUNIT_TEST_SUITES the KUNIT_TABLE section and moved it
   from INIT_DATA_SECTION to INIT_DATA; this had the additional
   consequence of making the first several architecture specific patches
   unnecessary - suggested by Kees.
 - Dropped the kunit_shutdown patches; I think it makes more sense to
   reintroduce them in a later patchset.

Alan Maguire (1):
  kunit: test: create a single centralized executor for all tests

Brendan Higgins (4):
  vmlinux.lds.h: add linker section for KUnit test suites
  init: main: add KUnit to kernel init
  kunit: test: add test plan to KUnit TAP format
  Documentation: kunit: add a brief blurb about kunit_test_suite

 Documentation/dev-tools/kunit/usage.rst       |   5 ++
 include/asm-generic/vmlinux.lds.h             |  10 ++-
 include/kunit/test.h                          |  76 +++++++++++++-----
 init/main.c                                   |   4 +
 lib/kunit/Makefile                            |   3 +-
 lib/kunit/executor.c                          |  43 ++++++++++
 lib/kunit/test.c                              |  13 +--
 tools/testing/kunit/kunit_parser.py           |  76 ++++++++++++++----
 .../test_is_test_passed-all_passed.log        | Bin 1562 -> 1567 bytes
 .../test_data/test_is_test_passed-crash.log   | Bin 3016 -> 3021 bytes
 .../test_data/test_is_test_passed-failure.log | Bin 1700 -> 1705 bytes
 11 files changed, 180 insertions(+), 50 deletions(-)
 create mode 100644 lib/kunit/executor.c


base-commit: 145ff1ec090dce9beb5a9590b5dc288e7bb2e65d
-- 
2.28.0.163.g6104cc2f0b6-goog

