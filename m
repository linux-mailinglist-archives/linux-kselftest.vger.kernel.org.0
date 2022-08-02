Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9EA58837C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Aug 2022 23:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiHBV1D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Aug 2022 17:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbiHBV0r (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Aug 2022 17:26:47 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB48B60D2;
        Tue,  2 Aug 2022 14:26:39 -0700 (PDT)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Ly7NH08XTzDr93;
        Tue,  2 Aug 2022 21:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659475599; bh=6pys3iMu52hsdnf6ApeMwe+qNXJuaJmg/myUJ3vjPHY=;
        h=From:To:Cc:Subject:Date:From;
        b=XRyDEG0k/fWEfbsrkQJEI5e7PECn2RHgoayGQNW7lt3dVnCjoWtow1vvMnkT1t53G
         N4iEtIDlD4KMtKCTA8m2MNHQtlZNMKz89PZ5DiZAoMQgZromKnzIk5BYpiFRytFfdy
         tkZGiyFRfc9W040YaSrVPpghnpZZUKOdmeCYfIqY=
X-Riseup-User-ID: EF436AC255C563BB1539B80E48B6D1CD51C766DC71C4D58B90EE7B98D92D96EA
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4Ly7N82VkQz5vw2;
        Tue,  2 Aug 2022 21:26:32 +0000 (UTC)
From:   =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
To:     Brendan Higgins <brendanhiggins@google.com>, davidgow@google.com,
        Daniel Latypov <dlatypov@google.com>, airlied@linux.ie,
        daniel@ffwll.ch, davem@davemloft.net, kuba@kernel.org,
        jose.exposito89@gmail.com, javierm@redhat.com
Cc:     andrealmeid@riseup.net, melissa.srw@gmail.com,
        siqueirajordao@riseup.net, Isabella Basso <isabbasso@riseup.net>,
        magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mairacanal@riseup.net>
Subject: [PATCH v2 0/3] Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
Date:   Tue,  2 Aug 2022 18:26:18 -0300
Message-Id: <20220802212621.420840-1-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

For example, if I am using the KUNIT_EXPECT_MEMEQ macro and apply the
following diff (introducing a test failure) to the 
drm/tests/drm_format_helper.c:

diff --git a/drivers/gpu/drm/tests/drm_format_helper_test.c b/drivers/gpu/drm/tests/drm_format_helper_test.c
index 3106abb3bead..942aa131a768 100644
--- a/drivers/gpu/drm/tests/drm_format_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_format_helper_test.c
@@ -131,9 +131,9 @@ static struct convert_xrgb8888_case convert_xrgb8888_cases[] = {
                    .rgb565_result = {
                        .dst_pitch = 10,
                        .expected = {
-                               0x0A33, 0x1260, 0xA800, 0x0000, 0x0000,
-                               0x6B8E, 0x0A33, 0x1260, 0x0000, 0x0000,
-                               0xA800, 0x6B8E, 0x0A33, 0x0000, 0x0000,
+                               0x0A31, 0x1260, 0xA800, 0x0000, 0x0000,
+                               0x6B81, 0x0A33, 0x1260, 0x0000, 0x0000,
+                               0xA801, 0x6B8E, 0x0A33, 0x0000, 0x0000,
                        },
                        .expected_swab = {
                                0x330A, 0x6012, 0x00A8, 0x0000, 0x0000,}}}

I will get a test failure with the following form:

➜ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/tests \
  --kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y --kconfig_add CONFIG_VIRTIO_UML=y \
  'drm_format_helper_test'
  [...]
  [18:15:35] ================= xrgb8888_to_rgb565_test ==================
  [18:15:35] [PASSED] single_pixel_source_buffer
  [18:15:35] [PASSED] single_pixel_clip_rectangle
  [18:15:35] [PASSED] well_known_colors
  [18:15:35] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_format_helper_test.c:248
  [18:15:35] Expected dst == result->expected, but
  [18:15:35] dst ==
  [18:15:35] <33> 0a 60 12 00 a8 00 00 00 00 <8e> 6b 33 0a 60 12
  [18:15:35] 00 00 00 00 <00> a8 8e 6b 33 0a 00 00 00 00
  [18:15:35] result->expected ==
  [18:15:35] <31> 0a 60 12 00 a8 00 00 00 00 <81> 6b 33 0a 60 12
  [18:15:35] 00 00 00 00 <01> a8 8e 6b 33 0a 00 00 00 00
  [18:15:35] not ok 4 - destination_pitch
  [18:15:35] [FAILED] destination_pitch
  [18:15:35] # Subtest: xrgb8888_to_rgb565_test
  [18:15:35] # xrgb8888_to_rgb565_test: pass:3 fail:1 skip:0 total:4
  [18:15:35] not ok 2 - xrgb8888_to_rgb565_test
  [...]
  [18:15:35] ============= [FAILED] drm_format_helper_test ==============
  [18:15:35] ============================================================
  [18:15:35] Testing complete. Ran 8 tests: passed: 7, failed: 1
  [18:15:35] Elapsed time: 3.148s total, 0.002s configuring, 3.031s building, 0.090s running

Noticed that, with the hex dump, it is possible to check which bytes are
making the test fail. So, it is easier to debug the cause of the failure.

Moreover, on this v2, the differed bytes are marked with a <>, to ease the
identication of the differences. The bytes are not ideally aligned, but the
marks, suggested by Daniel, are very helpful.

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

Maíra Canal (3):
  kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
  kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
  kunit: Use KUNIT_EXPECT_MEMEQ macro

 .../gpu/drm/tests/drm_format_helper_test.c    |  6 +-
 include/kunit/assert.h                        | 35 +++++++++
 include/kunit/test.h                          | 76 +++++++++++++++++++
 lib/kunit/assert.c                            | 54 +++++++++++++
 lib/kunit/kunit-example-test.c                |  7 ++
 net/core/dev_addr_lists_test.c                |  4 +-
 6 files changed, 177 insertions(+), 5 deletions(-)

-- 
2.37.1

