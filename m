Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F92168CAB7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Feb 2023 00:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjBFXnu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 18:43:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBFXnt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 18:43:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1332B20D39;
        Mon,  6 Feb 2023 15:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Cbgf/3ExiLkHeTDiZkg2YzpW1KimliBdCulTSMGSMg0=; b=C6wiMemruzk9Tl7wyo+11Q6EXQ
        oQVGA/1/oLDLf+j4d3Kho6plTzXnY5XAGp2QbDRGXybpiSfifMXylUGWX+UhDIL6d0PhIqCJ1bS3h
        ovoJDhqw6y3xWVso4DJMI+nHMGlT7GX98uEwCwo2kUZwtCNxNsJ1eTc6X5jjxW9YLvrrOtkoc8FmP
        BK3e3lxjNP3kxa18wnVYcEPdK4TJPbmFHBlc7nb5Khe1uB66jQrzy4cKvTfNCXCrwUN114GmHOpO4
        v0KwU37J3nHbYaxGjwlbvhQsP7pqjJXAGc4yuOZ348RxCKH0BzHD2p178lY5ELoq43uwrtk94+V0v
        /aIH8UEQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPB9F-00ADBX-Te; Mon, 06 Feb 2023 23:43:45 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, tiwai@suse.de, tianfei.zhang@intel.com,
        russell.h.weight@intel.com, keescook@chromium.org,
        tweek@google.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] selftests/firmware: increase timeout from 165 to 230
Date:   Mon,  6 Feb 2023 15:43:44 -0800
Message-Id: <20230206234344.2433950-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230206234344.2433950-1-mcgrof@kernel.org>
References: <20230206234344.2433950-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Bump the timeout up to what we can empirally need on a q35
8MiB system / 8 vcpus as supported easily now with kdevops [0].

To test firmware_loader with kdevops:

make menuconfig # enable dedicated selftests and firmware test
make
make bringup
make linux
make selftests-firmware

In practice this test now takes about 170 seconds so let's give it
a bit more breathing room we end up with 230. Note: I'm seeing
a failure only on Android setups running this test in a loop, we
eventually OOM on linux-next tag next-20230119.

[0] https://github.com/linux-kdevops/kdevops
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 tools/testing/selftests/firmware/settings | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/firmware/settings b/tools/testing/selftests/firmware/settings
index 085e664ee093..75773074af35 100644
--- a/tools/testing/selftests/firmware/settings
+++ b/tools/testing/selftests/firmware/settings
@@ -5,4 +5,10 @@
 # Additionally, fw_fallback may take 5 seconds for internal timeouts in each
 # of the 3 configs, so at least another 15 seconds are needed. Add another
 # 10 seconds for each testing config: 120 + 15 + 30
-timeout=165
+#
+# That's 165.. but we also now have some other batched tests, we get the
+# current timeout value by running manually withtout the timeout:
+#
+# time ./tools/testing/selftests/firmware/fw_run_tests.sh
+# then add give or take about 50 seconds.
+timeout=230
-- 
2.39.1

