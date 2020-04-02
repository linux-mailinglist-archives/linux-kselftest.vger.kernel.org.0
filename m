Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6742A19CBD6
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 22:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731892AbgDBUqq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 16:46:46 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47336 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBUqq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 16:46:46 -0400
Received: by mail-pg1-f202.google.com with SMTP id x1so4031123pgb.14
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Apr 2020 13:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=doFYw6zYWi88EjcRuuk27vmWcX6A0cdwO9jpkk/bWtM=;
        b=RBbZn9mYhYjitPkmy5sRH9kNOHVrQxRBFMBY8gjTZYvFGXqFCXNjoMECXbmAZ+pFiq
         hdw5i/g3PRyDTDvPm7zf7R7Wld4/v2v8/vilftHf1q6ENdi67YBKIyXz++EH5qjkOXzL
         DmJ6d4FebB7QJzlN6No2oYCv/Yc0nRaEPNA4yqHs7tYyvytiklWiDzxEGE+2jZrq0tFX
         gOoNhHKQ3RkOXtNCCwvN5R2b9YG3IUatl7aNSxcjM2lSwoG0ZxNSVw5GnvVxpa2dGRGS
         mvUhnfVrsdduSFvKXs5gnQEhLdlt5GXeFylh6xkgTpPthg64ROoVNelgzJBxoAA4dQ5u
         Wa4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=doFYw6zYWi88EjcRuuk27vmWcX6A0cdwO9jpkk/bWtM=;
        b=gLCAob2GWQt+PLxsxIdlva4BSNqTAQaNQ9G0NILosdQagOjslyPDaNT1tsMb41mW3q
         GTIhyaV0XaBDs3LlvQx0KAUhgwICcrGLhlaoaeXfymLo5HlDEa2wxJQuQDtrkPDpSTLL
         l+aOG0PIkn9rfuJfLX6jVHCxM3pgzGe5cRE3FgC3qmCsvtkPKdAlH37haRyJDgLdE4EH
         f6z0v9ylWxZn02Ur0WX3V36aknEvwvNGt4F74TqBssk6ha4Uuz/oX8xcllP8YeNc6K3Y
         Blyp8io7fOzBIHJA46XxvS4okARDEBu1HHmR2LiAxKnmHARM+lhVIGucij3EEa+W4JyM
         LA6A==
X-Gm-Message-State: AGi0PuZsfiGaWJf18FNmVsvhRmE9VVOFJyyUnLpcxKh27ca2uZOdtlwI
        eJoGHPdHAQcIpnM+9JuCxJVSqymGtrzcW3/23qU=
X-Google-Smtp-Source: APiQypIsos9ak6KsELAiKXt6ZeQu8VSJPpOnCM4QkCRwwa2AOAOUMtfXxJEfUZdMtMZ0sSXGmD5mamEiHN1G26T9Njs=
X-Received: by 2002:a63:d013:: with SMTP id z19mr5212048pgf.349.1585860403382;
 Thu, 02 Apr 2020 13:46:43 -0700 (PDT)
Date:   Thu,  2 Apr 2020 13:46:35 -0700
Message-Id: <20200402204639.161637-1-trishalfonso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH v4 0/4] KUnit-KASAN Integration
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

Convert KASAN tests to KUnit with the exception of copy_user_test
because KUnit is unable to test those.

Add documentation on how to run the KASAN tests with KUnit and what to
expect when running these tests.

Depends on "[PATCH v3 kunit-next 0/2] kunit: extend kunit resources
API" patchset [1]

[1] https://lore.kernel.org/linux-kselftest/1585313122-26441-1-git-send-email-alan.maguire@oracle.com/T/#t

Changes from v3:
 - KUNIT_SET_KASAN_DATA and KUNIT_DO_EXPECT_KASAN_FAIL have been
 combined and included in KUNIT_DO_EXPECT_KASAN_FAIL() instead.
 - Reordered logic in kasan_update_kunit_status() in report.c to be
 easier to read.
 - Added comment to not use the name "kasan_data" for any kunit tests
 outside of KUNIT_EXPECT_KASAN_FAIL().

Patricia Alfonso (4):
  Add KUnit Struct to Current Task
  KUnit: KASAN Integration
  KASAN: Port KASAN Tests to KUnit
  KASAN: Testing Documentation

 Documentation/dev-tools/kasan.rst |  70 +++
 include/kunit/test.h              |   5 +
 include/linux/kasan.h             |   6 +
 include/linux/sched.h             |   4 +
 lib/Kconfig.kasan                 |  15 +-
 lib/Makefile                      |   3 +-
 lib/kunit/test.c                  |  13 +-
 lib/test_kasan.c                  | 680 +++++++++++++-----------------
 lib/test_kasan_module.c           |  76 ++++
 mm/kasan/report.c                 |  30 ++
 10 files changed, 511 insertions(+), 391 deletions(-)
 create mode 100644 lib/test_kasan_module.c

-- 
2.26.0.292.g33ef6b2f38-goog

