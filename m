Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0894471829F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 May 2023 15:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236570AbjEaNoY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 May 2023 09:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjEaNnv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 May 2023 09:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69411998;
        Wed, 31 May 2023 06:42:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2C163B1B;
        Wed, 31 May 2023 13:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D30C4339E;
        Wed, 31 May 2023 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540535;
        bh=ilWEH3BtlOrYY29wnpH97XrWy7zVq/O5HyDySM8Ml0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U3g21z00aWNkk478eXaiGfmvXBVTQzgLnBgrb46K/rTn4kZbHlHAwRgWA9sP71LLz
         1HOLci41sPFk97FuJjgHmn51QWGReVA6c8XjkZ8yHKOF3y875gBMTMJ8+wTNprfIR/
         iiJ0ZTNXQrMuiPsvRG6O61+ieaWlwX8fg9CbJH9Qk96Kz27AsFv4B5BumZeHwW7jjE
         B0U9cFPxZ4C23sMb5gZlIe6iyF8ayJqTcjLGq8HAuhaPTR4/6g3b/1ete+XuFmiBg5
         +q9uStg8N4lPH6npd7Dm9JRaS4b7++K5q2JVjr/VpPgVMeRfjF5zGGBpwBcG32Toze
         6ZOzwBVvxFCqg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Sasha Levin <sashal@kernel.org>, bamv2005@gmail.com,
        shuah@kernel.org, linux-gpio@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/33] selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change
Date:   Wed, 31 May 2023 09:41:32 -0400
Message-Id: <20230531134159.3383703-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134159.3383703-1-sashal@kernel.org>
References: <20230531134159.3383703-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

[ Upstream commit 976d3c6778e99390c6d854d140b746d12ea18a51 ]

According to Mirsad the gpio-sim.sh test appears to FAIL in a wrong way
due to missing initialisation of shell variables:

 4.2. Bias settings work correctly
 cat: /sys/devices/platform/gpio-sim.0/gpiochip18/sim_gpio0/value: No such file or directory
 ./gpio-sim.sh: line 393: test: =: unary operator expected
 bias setting does not work
 GPIO gpio-sim test FAIL

After this change the test passed:

 4.2. Bias settings work correctly
 GPIO gpio-sim test PASS

His testing environment is AlmaLinux 8.7 on Lenovo desktop box with
the latest Linux kernel based on v6.2:

  Linux 6.2.0-mglru-kmlk-andy-09238-gd2980d8d8265 x86_64

Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/gpio/gpio-sim.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 341e3de008968..bf67b23ed29ac 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -389,6 +389,9 @@ create_chip chip
 create_bank chip bank
 set_num_lines chip bank 8
 enable_chip chip
+DEVNAME=`configfs_dev_name chip`
+CHIPNAME=`configfs_chip_name chip bank`
+SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio0/value"
 $BASE_DIR/gpio-mockup-cdev -b pull-up /dev/`configfs_chip_name chip bank` 0
 test `cat $SYSFS_PATH` = "1" || fail "bias setting does not work"
 remove_chip chip
-- 
2.39.2

