Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7864718BCE5
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Mar 2020 17:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCSQmo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Mar 2020 12:42:44 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:56227 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbgCSQmn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:43 -0400
Received: by mail-yb1-f202.google.com with SMTP id j10so1079850ybh.22
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Mar 2020 09:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Dz7alAscI1YvV+X2ok1ND7NhQJcsBO33MSW+QX9MTto=;
        b=OYcIxAhVB7TkVa6WZyRwxfsKV9lKaUsk0UijSeFRvD9xTLr5/CX3x3kHaQhyHaqy1C
         APv2OCbdhn8rHtXnR1dE+KyIY0eMy//e5p9Dfw6LR8UInTfIuwqCnJHflNpvHpJ+4ScF
         A0zL74CzffXi1OhRsrWxgUDnMuKxnHz4ZSXxNmeWLaOP2UCKBFTkqc2iNvQPyv911Pcd
         3YydHB74C/AYS6D3kFPMyT9ZwGrVV8SjJK85KnmEGjHDu6ixzV4QyexmMYugujIR6ivt
         t/AZ82O8U9Q3PvPyb9qPhA+5phKUy6IsLwHdqkgzGr/p0J9/gQWBxj84w/RxveZKhhaX
         QfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Dz7alAscI1YvV+X2ok1ND7NhQJcsBO33MSW+QX9MTto=;
        b=rObpwnqdGeZKDQR35kv6bEbHgLi4nSsCh1YVcCj84m0XcpVrpsKqhNC7CyKVDfDZyg
         ugEy+giSi6gz0zrAZsm7rbbTkwoDw/bALUwvNwsbbGBM+jkDMxo2qvGEqZJTcmHkjTl2
         yV3mTdwCYBQ7I0GGk+Rn3qn8jfsLusUnudLye/j9b6Ba7uMGErvXnY/30mnnOW2MBhxh
         Bbmu0AAPNHk/OVsqq9HtIy9G0X/snu1sClwElQsYD7S18ugUzgphnfp53uIFPTmQdD96
         qa5d69L8/J44EK4VNcdXrXF8svgDtkHz1wnsD1RRIjNt/tmhZMZcDJ76II+njNdJez3w
         YE8w==
X-Gm-Message-State: ANhLgQ1+AD9Qii1eUa33xg8qDzjORVXeMKNjzpzvdmDXAyyhqEaNrskY
        DGRPNcaFXxtwymHTOlF/q/LNeVeNIk4vVsN+ApA=
X-Google-Smtp-Source: ADFU+vtYjo4ouzn/Ha6fj35qaYti71akcCt+bJBb5MBf7qZK7JbtPmyF4kMw+AlB8eOy7HU5Va3ZmBYJc8/OJnZa7jo=
X-Received: by 2002:a25:a281:: with SMTP id c1mr5753816ybi.327.1584636161413;
 Thu, 19 Mar 2020 09:42:41 -0700 (PDT)
Date:   Thu, 19 Mar 2020 09:42:24 -0700
Message-Id: <20200319164227.87419-1-trishalfonso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [RFC PATCH v2 0/3] KASAN/KUnit Integration
From:   Patricia Alfonso <trishalfonso@google.com>
To:     davidgow@google.com, brendanhiggins@google.com,
        aryabinin@virtuozzo.com, dvyukov@google.com, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        Patricia Alfonso <trishalfonso@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patchset contains everything needed to integrate KASAN and KUnit.

KUnit will be able to:
(1) Fail tests when an unexpected KASAN error occurs
(2) Pass tests when an expected KASAN error occurs

KASAN Tests have been converted to KUnit with the exception of
copy_user_test because KUnit is unable to test those. I am working on
documentation on how to use these new tests to be included in the next
version of this patchset.

Changes since v1:
 - Make use of Alan Maguire's suggestion to use his patch that allows
   static resources for integration instead of adding a new attribute to
   the kunit struct
 - All KUNIT_EXPECT_KASAN_FAIL statements are local to each test
 - The definition of KUNIT_EXPECT_KASAN_FAIL is local to the
   test_kasan.c file since it seems this is the only place this will
   be used.
 - Integration relies on KUnit being builtin
 - copy_user_test has been separated into its own file since KUnit
   is unable to test these. This can be run as a module just as before,
   using CONFIG_TEST_KASAN_USER
 - The addition to the current task has been separated into its own
   patch as this is a significant enough change to be on its own.

Patricia Alfonso (3):
  Add KUnit Struct to Current Task
  KUnit: KASAN Integration
  KASAN: Port KASAN Tests to KUnit

 include/kunit/test.h       |  10 +
 include/linux/sched.h      |   4 +
 lib/Kconfig.kasan          |  13 +-
 lib/Makefile               |   1 +
 lib/kunit/test.c           |  10 +-
 lib/test_kasan.c           | 639 +++++++++++++++----------------------
 lib/test_kasan_copy_user.c |  75 +++++
 mm/kasan/report.c          |  33 ++
 8 files changed, 400 insertions(+), 385 deletions(-)
 create mode 100644 lib/test_kasan_copy_user.c

-- 
2.25.1.696.g5e7596f4ac-goog

