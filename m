Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEF6DE233
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Apr 2023 19:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjDKRPj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Apr 2023 13:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDKRPi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Apr 2023 13:15:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A5C5FFB;
        Tue, 11 Apr 2023 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681233331; x=1712769331;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hkjCkl5c+7zSxcTy7EubOaO/P5T/a3MNoi17HIee2x8=;
  b=nHml3D/orgRA4H0jDsYVLB/YRZkiiA4BQo+w/OBhISLDOQfQDz0cI7XV
   rVh6KTkaxWnVG3hls975Js6s9lWnpVlMNv2BagCAeElKY131LSVTobUra
   lmX+Cq6eyTGaF7PBDUVm8NpndZ4Qw5BYhGsjkbfWtux+v6c9bA5HtBqFS
   zOE0o4HgBIfd2cq2PJDBmMRUlv2AOjzeOTxDjNj2rALMnBosOPdmxIJxV
   qqKA8GIdqVpqSrokvZx+e9SlZVI8SNTNOk59wzew97vwFNa5eAssPACrw
   ms15PueDPpVRRMAbUXH3l+5CK2iTQ/sspb5K2p2bcD8P2mVX6+V9wWNZk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="341172119"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="341172119"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 10:15:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="862951139"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="862951139"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2023 10:15:28 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7D0E669A; Tue, 11 Apr 2023 20:15:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-gpio@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] selftests: gpio: gpio-sim: Use same variable name for sysfs pathname
Date:   Tue, 11 Apr 2023 20:15:21 +0300
Message-Id: <20230411171521.29678-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
References: <20230411171521.29678-1-andriy.shevchenko@linux.intel.com>
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

SYSFS_PATH can be used locally and globally, especially that has
the same content.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/testing/selftests/gpio/gpio-sim.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-sim.sh b/tools/testing/selftests/gpio/gpio-sim.sh
index fa2ce2b9dd5f..6fb66a687f17 100755
--- a/tools/testing/selftests/gpio/gpio-sim.sh
+++ b/tools/testing/selftests/gpio/gpio-sim.sh
@@ -152,9 +152,9 @@ sysfs_set_pull() {
 	local PULL=$4
 	local DEVNAME=`configfs_dev_name $DEV`
 	local CHIPNAME=`configfs_chip_name $DEV $BANK`
-	local SYSFSPATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio$OFFSET/pull"
+	local SYSFS_PATH="/sys/devices/platform/$DEVNAME/$CHIPNAME/sim_gpio$OFFSET/pull"
 
-	echo $PULL > $SYSFSPATH || fail "Unable to set line pull in sysfs"
+	echo $PULL > $SYSFS_PATH || fail "Unable to set line pull in sysfs"
 }
 
 # Load the gpio-sim module. This will pull in configfs if needed too.
-- 
2.40.0.1.gaa8946217a0b

