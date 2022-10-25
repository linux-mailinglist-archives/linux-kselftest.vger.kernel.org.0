Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09A660D7B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Oct 2022 01:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiJYXLJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 Oct 2022 19:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbiJYXLI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 Oct 2022 19:11:08 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D38CF874;
        Tue, 25 Oct 2022 16:11:07 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Mxnk21dYqzDqs8;
        Tue, 25 Oct 2022 23:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1666739466; bh=KKHR24rPQxFu1YA5ld6wDOQ/gCh3kJrbD7p3rWeW2Tg=;
        h=From:To:Cc:Subject:Date:From;
        b=GVJQsrY1HzfiJfux+/dhic0R4jUYqYXHr38lir4sSk2NO9//jrTWPBkSmpEvO4RFS
         DbGoeo0PfZJoCR+e3D4vavQc6G3zJVjJ4t2c0BuAio8jIbGsUijXH5eJgMWwiADfXm
         eFJZimPDgaowT6ZxWVomOneiri3Do+VfQy3Kdvc8=
X-Riseup-User-ID: EF1CFFE6C67DC1ABFA3A5A31252CC2AD9978F88F1CF011EF5CD6A589F715F482
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Mxnjv0gL0z1yRB;
        Tue, 25 Oct 2022 23:10:58 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, airlied@gmail.com,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v7 0/3] Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
Date:   Tue, 25 Oct 2022 20:10:40 -0300
Message-Id: <20221025231043.115295-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently, in order to compare memory blocks in KUnit, the KUNIT_EXPECT_EQ or
KUNIT_EXPECT_FALSE macros are used in conjunction with the memcmp function,
such as:
  KUNIT_EXPECT_EQ(test, memcmp(foo, bar, size), 0);

Although this usage produces correct results for the test cases, if the
expectation fails the error message is not very helpful, indicating only the
return of the memcmp function.

Therefore, create a new set of macros KUNIT_EXPECT_MEMEQ and
KUNIT_EXPECT_MEMNEQ that compare memory blocks until a determined size. In
case of expectation failure, those macros print the hex dump of the memory
blocks, making it easier to debug test failures for memory blocks.

The v7 has some formatting changes on the first patch and it was rebased on
top of the mainline (due to 7089003304c6).

The first patch of the series introduces the KUNIT_EXPECT_MEMEQ and
KUNIT_EXPECT_MEMNEQ. The second patch adds an example of memory block
expectations on the kunit-example-test.c. And the last patch replaces the
KUNIT_EXPECT_EQ for KUNIT_EXPECT_MEMEQ on the existing occurrences.

Best Regards,
- Maíra Canal

v1 -> v2: https://lore.kernel.org/linux-kselftest/2a0dcd75-5461-5266-2749-808f638f4c50@riseup.net/T/#m402cc72eb01fb3b88d6706cf7d1705fdd51e5da2

- Change "determinated" to "specified" (Daniel Latypov).
- Change the macro KUNIT_EXPECT_ARREQ to KUNIT_EXPECT_MEMEQ, in order to make
it easier for users to infer the right size unit (Daniel Latypov).
- Mark the different bytes on the failure message with a <> (Daniel Latypov).
- Replace a constant number of array elements for ARRAY_SIZE() (André Almeida).
- Rename "array" and "expected" variables to "array1" and "array2" (Daniel Latypov).

v2 -> v3: https://lore.kernel.org/linux-kselftest/20220802212621.420840-1-mairacanal@riseup.net/T/#t

- Make the bytes aligned at output.
- Add KUNIT_SUBSUBTEST_INDENT to the output for the indentation (Daniel Latypov).
- Line up the trailing \ at macros using tabs (Daniel Latypov).
- Line up the params to the functions (Daniel Latypov).
- Change "Increament" to "Augment" (Daniel Latypov).
- Use sizeof() for array sizes (Daniel Latypov).
- Add Daniel Latypov's tags.

v3 -> v4: https://lore.kernel.org/linux-kselftest/CABVgOSm_59Yr82deQm2C=18jjSv_akmn66zs4jxx3hfziXPeHg@mail.gmail.com/T/#t

- Fix wrapped lines by the mail client (David Gow).
- Mention on documentation that KUNIT_EXPECT_MEMEQ is not recommended for
structured data (David Gow).
- Add Muhammad Usama Anjum's tag.

v4 -> v5: https://lore.kernel.org/linux-kselftest/20220808125237.277126-1-mairacanal@riseup.net/

- Rebase on top of drm-misc-next.
- Add David Gow's tags.

v5 -> v6: https://lore.kernel.org/linux-kselftest/20220921014515.113062-1-mairacanal@riseup.net/

- Rebase on top of Linux 6.1.
- Change KUNIT_ASSERTION macro to _KUNIT_FAILED.

v6 -> v7: https://lore.kernel.org/linux-kselftest/20221018190541.189780-1-mairacanal@riseup.net/

- Format nits (David Gow).
- Rebase on top of Linux 6.1-rc2.

Maíra Canal (3):
  kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
  kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
  kunit: Use KUNIT_EXPECT_MEMEQ macro

 .../gpu/drm/tests/drm_format_helper_test.c    | 12 +--
 include/kunit/assert.h                        | 33 +++++++
 include/kunit/test.h                          | 87 +++++++++++++++++++
 lib/kunit/assert.c                            | 56 ++++++++++++
 lib/kunit/kunit-example-test.c                |  7 ++
 net/core/dev_addr_lists_test.c                |  4 +-
 6 files changed, 191 insertions(+), 8 deletions(-)

-- 
2.37.3

