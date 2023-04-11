Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DC76DE230
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 19:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDKRPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDKRPi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:38 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F4B5BA0;
        Tue, 11 Apr 2023 10:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681233330; x=1712769330;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=l77rwRkmmaeKf8oCWhGD/yj1q+/ZZYlFQ+ZgKZ60owc=;
  b=YiTihbpZc/YfJWIudoEx6Ib8fCRULyyjKJ4Rt8bIUhEcu/IpB4gPij6a
   mSNnIUC6MV+LkfMOXKqBOJaRW8MU6pcxDX8gIXXeu4xHFeKpYepJC3Tg4
   gpAiG3B9wSBUcvf2sVCK0G1f3Kle2uUVJg1FI0sRoWYHY2gG56oyFOpVH
   1708YHElLb2x8WJkB/R5eR92Q9mS59gq18mj4/h5cTotcHVA1Gqun6ywZ
   KArNoOcq4oeSAXu38w+tdyc03m1hdcbVDGk4mMJ9hzpQD+FxPsCGp2yZR
   hlQgfsXi9oEV2/vw34zStgYIwDw88q8m2EIOseWowRVluKNU4t4LhXIr7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="346354122"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="346354122"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:15:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="638904505"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="638904505"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 11 Apr 2023 10:15:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B7195438; Tue, 11 Apr 2023 20:15:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] selftests: gpio: gpio-sim: Fix BUG: test FAILED due to recent change
Date:   Tue, 11 Apr 2023 20:15:20 +0300
Message-Id: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

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
---
 tools/testing/selftests/gpio/gpio-sim.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index 9f539d454ee4..fa2ce2b9dd5f 100755
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
2.40.0.1.gaa8946217a0b

