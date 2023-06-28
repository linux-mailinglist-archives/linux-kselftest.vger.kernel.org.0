Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBF9740E0E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 12:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjF1KF7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 06:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233530AbjF1Jy1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 05:54:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0F13584;
        Wed, 28 Jun 2023 02:50:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56F4261275;
        Wed, 28 Jun 2023 09:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D230C433C8;
        Wed, 28 Jun 2023 09:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687945803;
        bh=TXTgGw22TRrq/yHvL8i1FsJg0CZ5aaXG0yKvftRWvJY=;
        h=From:Subject:Date:To:Cc:From;
        b=rSouGZM4ruMEOKCFF8qlJjK3eBoVDscNPwo2NBLOP3rTHuEHxwl8U+C0SQfPZFC/t
         wV4qM2BxhGZcoToRn7XQYgaUQe7jggMdAQAiZbdJWvOxesGWQ4k6mNG3y47iGFW2FL
         dq6U1jKA89W+kZPpVAImy/HPlEk/Iu6JDfICmJ6Ji1WQ9rjD2/BJH2u1qepu/eAAMl
         JbsneY/JcTpCrpx0C3Wkg38e8qcXQXOOGkGMi4c1HDFMGb1Dm3nGZZKN2HZ6iTYVsB
         Ep4YPtbYzptqPb6THvyNgxsbra0En95h4ARH89f8x19gzh8ROIPMnpzAd3+aLzL3lZ
         B67/DJJZKZFgg==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2 0/3] drivers: base: Add tests showing devm handling
 inconsistencies
Date:   Wed, 28 Jun 2023 11:49:20 +0200
Message-Id: <20230329-kunit-devm-inconsistencies-test-v2-0-19feb71e864b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACACnGQC/42OOw7CMBAFr4Jcs8gfQoCKe6AUjr0Qi7BGtmOBo
 tydJSegnFfMvFlkTAGzOG9mkbCGHCIx6O1GuMHSHSF4ZqGlNtLoEzwmCgU81icEcpFyyAXJsQM
 K5gINNrb1UuFBesGW3maEPllyA3toGkceXwlv4b1mrx3zwJKYPuuLqn7r/8GqQIIzRulW7o+mb
 S4OE8VdQS52y7J8AXP4UY/kAAAA
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2015; i=mripard@kernel.org;
 h=from:subject:message-id; bh=TXTgGw22TRrq/yHvL8i1FsJg0CZ5aaXG0yKvftRWvJY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClzmDTUP9sEqs069Uby7N36X3usJ61a+2R306SAILvES
 1ECRzx2dZSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAiW5IYGZ7IHj7077PP9wv5
 r9+27lMsu9NufeXNQ66aFZyPF547dHwWw38P5maxi9O3rCm9M+/qlXUT7Yzjeo4tUTmheEvQx0h
 acTMTAA==
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
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
base-commit: 53cdf865f90ba922a854c65ed05b519f9d728424
change-id: 20230329-kunit-devm-inconsistencies-test-5e5a7d01e60d

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

