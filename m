Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA35575AEAC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 14:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjGTMpW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 08:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGTMpV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 08:45:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AFD268E;
        Thu, 20 Jul 2023 05:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDD0A61A77;
        Thu, 20 Jul 2023 12:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7347DC433C8;
        Thu, 20 Jul 2023 12:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689857116;
        bh=5d6Vcd3i0QdevHm+PGdaD3ugaO4LY83MGq1tZNki+JU=;
        h=From:Subject:Date:To:Cc:From;
        b=gMN3NsmbToZ5uGhZvME1SxRJMORTFK3LQXLvryIx2Dsznsk4S1qt+y5boSN71/Wy3
         bUejr9nX9rJGlDdmRvigTsckCyxY2xWPJ61qaSDKYDrAugC3h1/ipCDWiA+asPyHHZ
         dLU5HY+ea2Rz8wIXh3YTotGmarkHWG5yBnlx00gVqJoPGrPrQz+Y5OuQzggyYOyYz2
         MHZvLHok1afyi8rwAqGeurCWYgr3m6wi4KFh7Xa5qvfrXoXMbiPWjY/EuXxTd8+jDU
         cd6wL2VUK3u+TKZhgt8ElKm+6wfg7STBK+4IwvT6TGUlH/ymEJBirib8SXhAe4VSD1
         AhHmCFAexrhCA==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Date:   Thu, 20 Jul 2023 14:45:06 +0200
Message-Id: <20230720-kunit-devm-inconsistencies-test-v3-0-6aa7e074f373@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFIsuWQC/5XOOw7CMBAE0Ksg12zkTz5AlXsgisRZiEVYI9tYo
 Ch3Z5MTQDlTvJlZRAwOozjtZhEwu+g8cTD7nbBjRzcEN3AWWmojjT7C/UUuwYD5AY6sp+hiQrJ
 sQMKYoMKqawapsJaDYKXvIkIfOrIjO/SaJi6fAa/uvc2eL5xHRnz4bC+yWtvfB7MCCdYYpRtZH
 kxTtRYD+SIhL6541n+CmkF1vGLfKDzUZd/eGcSp8OEmLsuyfAH7RFTkNQEAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2230; i=mripard@kernel.org;
 h=from:subject:message-id; bh=5d6Vcd3i0QdevHm+PGdaD3ugaO4LY83MGq1tZNki+JU=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDCk7dSL0RH6yrsxh/bi75VOwPLdjovf6G2UTI9eeq/i/X
 Sj98vQbHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZiItgPDP7P7LopxU297bSm+
 K3v3leW6xaVrrQrMU/lz/fg5aoQviDP8sz/0dsnFeUwJUt+UKss4y+YIcrk7rnb1spXTajRKvSv
 PCQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

This follows the discussion here:
https://lore.kernel.org/linux-kselftest/20230324123157.bbwvfq4gsxnlnfwb@houat/

This shows a couple of inconsistencies with regard to how device-managed
resources are cleaned up. Basically, devm resources will only be cleaned up
if the device is attached to a bus and bound to a driver. Failing any of
these cases, a call to device_unregister will not end up in the devm
resources being released.

We had to work around it in DRM to provide helpers to create a device for
kunit tests, but the current discussion around creating similar, generic,
helpers for kunit resumed interest in fixing this.

This can be tested using the command:
./tools/testing/kunit/kunit.py run --kunitconfig=drivers/base/test/

I added the fix David suggested back in that discussion which does fix
the tests. The SoB is missing, since David didn't provide it back then.

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
Changes in v3:
- Reworded the commit logs according to David's feedback
- Rebased on current next
- Link to v2: https://lore.kernel.org/r/20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org

Changes in v2:
- Use an init function
- Document the tests
- Add a fix for the bugs
- Link to v1: https://lore.kernel.org/r/20230329-kunit-devm-inconsistencies-test-v1-0-c33127048375@cerno.tech

---
David Gow (1):
      drivers: base: Free devm resources when unregistering a device

Maxime Ripard (2):
      drivers: base: Add basic devm tests for root devices
      drivers: base: Add basic devm tests for platform devices

 drivers/base/core.c                      |  11 ++
 drivers/base/test/.kunitconfig           |   2 +
 drivers/base/test/Kconfig                |   4 +
 drivers/base/test/Makefile               |   3 +
 drivers/base/test/platform-device-test.c | 220 +++++++++++++++++++++++++++++++
 drivers/base/test/root-device-test.c     | 108 +++++++++++++++
 6 files changed, 348 insertions(+)
---
base-commit: c58c49dd89324b18a812762a2bfa5a0458e4f252
change-id: 20230329-kunit-devm-inconsistencies-test-5e5a7d01e60d

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

