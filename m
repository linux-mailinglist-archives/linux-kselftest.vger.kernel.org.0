Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9E8589435
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Aug 2022 23:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiHCV7K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Aug 2022 17:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbiHCV7J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Aug 2022 17:59:09 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022F35B7BB;
        Wed,  3 Aug 2022 14:59:08 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4Lym3J0TtJzDq9t;
        Wed,  3 Aug 2022 21:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1659563948; bh=kT4jHofE9XJAS5PI3Ljks9oJ2ktctNUJKIGMWAhOUC8=;
        h=From:To:Cc:Subject:Date:From;
        b=W+cXsHa2uAWkgMvLw5tnGv3Z4SUEEcWQnNS51NAm7zx6846H2U+Z4jqhnm+sN00cr
         C5YBtYPU+KwWOhZadXlvBwyPomIdzGXDDeL3o2OKmOJvm2r/FmnafFllvoRP8WpPqg
         V9EUQJiTSJnFZLhNuObcmKPd/C5TqPMLhsOxdEiE=
X-Riseup-User-ID: E1B64DBF1CF74C19EA12FC11482FCC9C6B1345351CAFEC908DC484D45983046F
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4Lym3B3mh0z1ySb;
        Wed,  3 Aug 2022 21:59:02 +0000 (UTC)
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
Subject: [PATCH v3 0/3] Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
Date:   Wed,  3 Aug 2022 18:58:52 -0300
Message-Id: <20220803215855.258704-1-mairacanal@riseup.net>
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

Other than the style changes, this v3 brings alignment to the bytes, making
it easier to identify the faulty bytes. So, on the previous version, the
output from a failure would be:
[14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_format_helper_test.c:248
[14:27:42] Expected dst == result->expected, but
[14:27:42] dst ==
[14:27:42] 33 0a <60> 12 00 a8 00 00 <00> 00 8e 6b <33> 0a 60 12
[14:27:42] 00 00 <00> 00 00 a8 <8e> 6b 33 0a 00 00 <00> 00
[14:27:42] result->expected ==
[14:27:42] 33 0a <61> 12 00 a8 00 00 <01> 00 8e 6b <31> 0a 60 12
[14:27:42] 00 00 <01> 00 00 a8 <81> 6b 33 0a 00 00 <01> 00

Now, with the alignment, the output is:
[14:27:42] # xrgb8888_to_rgb565_test: EXPECTATION FAILED at drivers/gpu/drm/tests/drm_format_helper_test.c:248
[14:27:42] Expected dst == result->expected, but
[14:27:42] dst ==
[14:27:42] 33  0a <60> 12  00  a8  00  00 <00> 00  8e  6b <33> 0a  60  12
[14:27:42] 00  00 <00> 00  00  a8 <8e> 6b  33  0a  00  00 <00> 00
[14:27:42] result->expected ==
[14:27:42] 33  0a <61> 12  00  a8  00  00 <01> 00  8e  6b <31> 0a  60  12
[14:27:42] 00  00 <01> 00  00  a8 <81> 6b  33  0a  00  00 <01> 00

Moreover, on the raw output, there were some indentation problems. Those
problems were solved with the use of KUNIT_SUBSUBTEST_INDENT.

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

Maíra Canal (3):
  kunit: Introduce KUNIT_EXPECT_MEMEQ and KUNIT_EXPECT_MEMNEQ macros
  kunit: Add KUnit memory block assertions to the example_all_expect_macros_test
  kunit: Use KUNIT_EXPECT_MEMEQ macro

 .../gpu/drm/tests/drm_format_helper_test.c    |  6 +-
 include/kunit/assert.h                        | 34 +++++++++
 include/kunit/test.h                          | 76 +++++++++++++++++++
 lib/kunit/assert.c                            | 56 ++++++++++++++
 lib/kunit/kunit-example-test.c                |  7 ++
 net/core/dev_addr_lists_test.c                |  4 +-
 6 files changed, 178 insertions(+), 5 deletions(-)

--
2.37.1

