Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EB16F40EC
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 May 2023 12:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbjEBKRU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 May 2023 06:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233480AbjEBKRS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 May 2023 06:17:18 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4773D3586
        for <linux-kselftest@vger.kernel.org>; Tue,  2 May 2023 03:17:12 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:f07a:92a2:297:162b])
        by baptiste.telenet-ops.be with bizsmtp
        id rmHA290065FQxRj01mHA2s; Tue, 02 May 2023 12:17:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptn4D-000ymU-UK;
        Tue, 02 May 2023 12:17:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1ptn4H-00AtQ3-Sh;
        Tue, 02 May 2023 12:17:09 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] Input: tests - miscellaneous fixes
Date:   Tue,  2 May 2023 12:17:01 +0200
Message-Id: <cover.1683022164.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

	Hi all,

This patch series fixes a crash in the new input selftest, and makes the
test available when the KUnit framework is modular.

Unfortunately test 3 still fails for me (tested on Koelsch (R-Car M2-W)
and ARAnyM):

        KTAP version 1
        # Subtest: input_core
        1..3
    input: Test input device as /devices/virtual/input/input1
        ok 1 input_test_polling
    input: Test input device as /devices/virtual/input/input2
        ok 2 input_test_timestamp
    input: Test input device as /devices/virtual/input/input3
        # input_test_match_device_id: ASSERTION FAILED at # drivers/input/tests/input_test.c:99
        Expected input_match_device_id(input_dev, &id) to be true, but is false
        not ok 3 input_test_match_device_id
    # input_core: pass:2 fail:1 skip:0 total:3
    # Totals: pass:2 fail:1 skip:0 total:3
    not ok 1 input_core

Thanks!

Geert Uytterhoeven (2):
  Input: tests - fix use-after-free and refcount underflow in
    input_test_exit()
  Input: tests - modular KUnit tests should not depend on KUNIT=y

 drivers/input/Kconfig            | 2 +-
 drivers/input/tests/input_test.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
