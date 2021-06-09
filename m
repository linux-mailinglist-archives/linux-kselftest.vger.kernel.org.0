Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608B53A20DA
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jun 2021 01:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhFIXj7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Jun 2021 19:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhFIXj4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Jun 2021 19:39:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DA5C061574;
        Wed,  9 Jun 2021 16:38:00 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 3CF481F41031
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com,
        David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        tales.aparecida@gmail.com,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH v2 0/1] lib: Convert UUID runtime test to KUnit
Date:   Wed,  9 Jun 2021 20:37:29 -0300
Message-Id: <20210609233730.164082-1-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This patch converts existing UUID runtime test to use KUnit framework.

Below, there's a comparison between the old output format and the new
one. Keep in mind that even if KUnit seems very verbose, this is the
corner case where _every_ test has failed.

* This is how the current output looks like in success:

  test_uuid: all 18 tests passed

* And when it fails:

  test_uuid: conversion test #1 failed on LE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
  test_uuid: cmp test #2 failed on LE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
  test_uuid: cmp test #2 actual data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
  test_uuid: conversion test #3 failed on BE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
  test_uuid: cmp test #4 failed on BE data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
  test_uuid: cmp test #4 actual data: 'c33f4995-3701-450e-9fbf-206a2e98e576'
  test_uuid: conversion test #5 failed on LE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
  test_uuid: cmp test #6 failed on LE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
  test_uuid: cmp test #6 actual data: '64b4371c-77c1-48f9-8221-29f054fc023b'
  test_uuid: conversion test #7 failed on BE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
  test_uuid: cmp test #8 failed on BE data: '64b4371c-77c1-48f9-8221-29f054fc023b'
  test_uuid: cmp test #8 actual data: '64b4371c-77c1-48f9-8221-29f054fc023b'
  test_uuid: conversion test #9 failed on LE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
  test_uuid: cmp test #10 failed on LE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
  test_uuid: cmp test #10 actual data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
  test_uuid: conversion test #11 failed on BE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
  test_uuid: cmp test #12 failed on BE data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
  test_uuid: cmp test #12 actual data: '0cb4ddff-a545-4401-9d06-688af53e7f84'
  test_uuid: negative test #13 passed on wrong LE data: 'c33f4995-3701-450e-9fbf206a2e98e576 '
  test_uuid: negative test #14 passed on wrong BE data: 'c33f4995-3701-450e-9fbf206a2e98e576 '
  test_uuid: negative test #15 passed on wrong LE data: '64b4371c-77c1-48f9-8221-29f054XX023b'
  test_uuid: negative test #16 passed on wrong BE data: '64b4371c-77c1-48f9-8221-29f054XX023b'
  test_uuid: negative test #17 passed on wrong LE data: '0cb4ddff-a545-4401-9d06-688af53e'
  test_uuid: negative test #18 passed on wrong BE data: '0cb4ddff-a545-4401-9d06-688af53e'
  test_uuid: failed 18 out of 18 tests


* Now, here's how it looks like with KUnit:

  ======== [PASSED] uuid ========
  [PASSED] uuid_correct_be
  [PASSED] uuid_correct_le
  [PASSED] uuid_wrong_be
  [PASSED] uuid_wrong_le

* And if every test fail with KUnit:

  ======== [FAILED] uuid ========
  [FAILED] uuid_correct_be
      # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
      Expected uuid_parse(data->uuid, &be) == 1, but
          uuid_parse(data->uuid, &be) == 0
  
  failed to parse 'c33f4995-3701-450e-9fbf-206a2e98e576'
      # uuid_correct_be: not ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
      # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
      Expected uuid_parse(data->uuid, &be) == 1, but
          uuid_parse(data->uuid, &be) == 0
  
  failed to parse '64b4371c-77c1-48f9-8221-29f054fc023b'
      # uuid_correct_be: not ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
      # uuid_correct_be: ASSERTION FAILED at lib/test_uuid.c:57
      Expected uuid_parse(data->uuid, &be) == 1, but
          uuid_parse(data->uuid, &be) == 0
  
  failed to parse '0cb4ddff-a545-4401-9d06-688af53e7f84'
      # uuid_correct_be: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
      not ok 1 - uuid_correct_be
  
  [FAILED] uuid_correct_le
      # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
      Expected guid_parse(data->uuid, &le) == 1, but
          guid_parse(data->uuid, &le) == 0
  
  failed to parse 'c33f4995-3701-450e-9fbf-206a2e98e576'
      # uuid_correct_le: not ok 1 - c33f4995-3701-450e-9fbf-206a2e98e576
      # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
      Expected guid_parse(data->uuid, &le) == 1, but
          guid_parse(data->uuid, &le) == 0
  
  failed to parse '64b4371c-77c1-48f9-8221-29f054fc023b'
      # uuid_correct_le: not ok 2 - 64b4371c-77c1-48f9-8221-29f054fc023b
      # uuid_correct_le: ASSERTION FAILED at lib/test_uuid.c:46
      Expected guid_parse(data->uuid, &le) == 1, but
          guid_parse(data->uuid, &le) == 0
  
  failed to parse '0cb4ddff-a545-4401-9d06-688af53e7f84'
      # uuid_correct_le: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e7f84
      not ok 2 - uuid_correct_le
  
  [FAILED] uuid_wrong_be
      # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
      Expected uuid_parse(*data, &be) == 0, but
          uuid_parse(*data, &be) == -22
  
  parsing of 'c33f4995-3701-450e-9fbf206a2e98e576 ' should've failed
      # uuid_wrong_be: not ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
      # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
      Expected uuid_parse(*data, &be) == 0, but
          uuid_parse(*data, &be) == -22
  
  parsing of '64b4371c-77c1-48f9-8221-29f054XX023b' should've failed
      # uuid_wrong_be: not ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
      # uuid_wrong_be: ASSERTION FAILED at lib/test_uuid.c:77
      Expected uuid_parse(*data, &be) == 0, but
          uuid_parse(*data, &be) == -22
  
  parsing of '0cb4ddff-a545-4401-9d06-688af53e' should've failed
      # uuid_wrong_be: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
      not ok 3 - uuid_wrong_be
  
  [FAILED] uuid_wrong_le
      # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
      Expected guid_parse(*data, &le) == 0, but
          guid_parse(*data, &le) == -22
  
  parsing of 'c33f4995-3701-450e-9fbf206a2e98e576 ' should've failed
      # uuid_wrong_le: not ok 1 - c33f4995-3701-450e-9fbf206a2e98e576
      # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
      Expected guid_parse(*data, &le) == 0, but
          guid_parse(*data, &le) == -22
  
  parsing of '64b4371c-77c1-48f9-8221-29f054XX023b' should've failed
      # uuid_wrong_le: not ok 2 - 64b4371c-77c1-48f9-8221-29f054XX023b
      # uuid_wrong_le: ASSERTION FAILED at lib/test_uuid.c:68
      Expected guid_parse(*data, &le) == 0, but
          guid_parse(*data, &le) == -22
  
  parsing of '0cb4ddff-a545-4401-9d06-688af53e' should've failed
      # uuid_wrong_le: not ok 3 - 0cb4ddff-a545-4401-9d06-688af53e
      not ok 4 - uuid_wrong_le

Changes from v1:
 - Test suite name: uuid_test -> uuid
 - Config name: TEST_UUID -> UUID_KUNIT_TEST
 - Config entry in the Kconfig file left where it is
 - Converted tests to use _MSG variant

André Almeida (1):
  lib: Convert UUID runtime test to KUnit

 lib/Kconfig.debug |  11 +++-
 lib/Makefile      |   2 +-
 lib/test_uuid.c   | 137 +++++++++++++++++++---------------------------
 3 files changed, 67 insertions(+), 83 deletions(-)

-- 
2.31.1

