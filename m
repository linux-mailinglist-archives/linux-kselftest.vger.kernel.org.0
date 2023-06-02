Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841017205D3
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 17:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236548AbjFBPUw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 11:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbjFBPUv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 11:20:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2483718C;
        Fri,  2 Jun 2023 08:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B590B6176E;
        Fri,  2 Jun 2023 15:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7545C433D2;
        Fri,  2 Jun 2023 15:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685719249;
        bh=JrdWhqdwYCo5+dxpyaTBpOM09b+3lqOKw8HosotnMs0=;
        h=From:Subject:Date:To:Cc:From;
        b=h7knj2B5GdpIqG30KBjAmBUV7y4Y2EqxsA8SDIG1kJB05mbthV5F579lioekLHG59
         zDnBn8LOr1eTgmCyd5BtOXiry8vkipsS7M0YyELkzh/OlkCW4k7h1X8b+ByCu/ASEa
         uePeEu5HrE7Pm/qd9bnB8QggpmzsrYJuf/unXWRv+2pw+AUb2QSSCIxIoUCMz8Aph0
         m3FLu94JvZv/6u2JwjS39wMIyyGMAKDNoin8whj8a1Rxx6hBw/jB85G/hLlUA8Hcvl
         Nwt/Cts0k4s6khrOLkeGTT0dx61LjRzAUrZ97t99xcXd38fb7cWxUGYt2Z5OEHV5HI
         d/jK6YA4963GA==
From:   Maxime Ripard <mripard@kernel.org>
Subject: [PATCH RESEND 0/2] drivers: base: Add tests showing devm handling
 inconsistencies
Date:   Fri, 02 Jun 2023 17:20:42 +0200
Message-Id: <20230329-kunit-devm-inconsistencies-test-v1-0-015b1574d673@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
X-Mailer: b4 0.13-dev-02a79
X-Developer-Signature: v=1; a=openpgp-sha256; l=1520; i=mripard@kernel.org;
 h=from:subject:message-id; bh=JrdWhqdwYCo5+dxpyaTBpOM09b+3lqOKw8HosotnMs0=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDClVHOdeLlF4eeoU99T1PBu/a+a6zLhmWfjOkqNW2zjkhVVv
 98rzHaUsDGJcDLJiiiwxwuZL4k7Net3JxjcPZg4rE8gQBi5OAZhIiSXD/8grpcxXFgQ1Mi1/zT9XdP
 Mn4QvHJSIubRT7vOoj9yLLzgeMDBtv6m1TYXv2bTlT/ueKhqZZbS2Fh3j3GCxQsn/26aiXBwcA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

Let me know what you think,
Maxime

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
Maxime Ripard (2):
      drivers: base: Add basic devm tests for root devices
      drivers: base: Add basic devm tests for platform devices

 drivers/base/test/.kunitconfig           |   2 +
 drivers/base/test/Kconfig                |   4 +
 drivers/base/test/Makefile               |   3 +
 drivers/base/test/platform-device-test.c | 278 +++++++++++++++++++++++++++++++
 drivers/base/test/root-device-test.c     | 120 +++++++++++++
 5 files changed, 407 insertions(+)
---
base-commit: a6faf7ea9fcb7267d06116d4188947f26e00e57e
change-id: 20230329-kunit-devm-inconsistencies-test-5e5a7d01e60d

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>

