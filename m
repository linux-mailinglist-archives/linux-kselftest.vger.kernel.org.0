Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CCB638D9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Nov 2022 16:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiKYPmm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Nov 2022 10:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKYPmL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Nov 2022 10:42:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0605A46672;
        Fri, 25 Nov 2022 07:42:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AC372B;
        Fri, 25 Nov 2022 07:42:17 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D7DA63F73B;
        Fri, 25 Nov 2022 07:42:09 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Shuah Khan <shuah@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Dilip Kota <dilip.kota@arm.com>
Subject: [PATCH] selftests: splice_read: Fix sysfs read cases
Date:   Fri, 25 Nov 2022 15:42:01 +0000
Message-Id: <20221125154201.1991127-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

sysfs now supports splice_* operations with

 commit f2d6c2708bd84 ("kernfs: wire up ->splice_read and ->splice_write")

Update the selftests to expect success instead of failure.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Siddharth Gupta <sidgup@codeaurora.org
Reported-by: Dilip Kota <dilip.kota@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 tools/testing/selftests/splice/short_splice_read.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/splice/short_splice_read.sh b/tools/testing/selftests/splice/short_splice_read.sh
index 22b6c8910b18..4710e09f49fa 100755
--- a/tools/testing/selftests/splice/short_splice_read.sh
+++ b/tools/testing/selftests/splice/short_splice_read.sh
@@ -127,7 +127,7 @@ expect_success "proc_handler: special read splice" test_splice /proc/sys/kernel/
 if ! [ -d /sys/module/test_module/sections ] ; then
 	expect_success "test_module kernel module load" modprobe test_module
 fi
-expect_failure "kernfs attr splice" test_splice /sys/module/test_module/coresize
-expect_failure "kernfs binattr splice" test_splice /sys/module/test_module/sections/.init.text
+expect_success "kernfs attr splice" test_splice /sys/module/test_module/coresize
+expect_success "kernfs binattr splice" test_splice /sys/module/test_module/sections/.init.text
 
 exit $ret
-- 
2.38.1

