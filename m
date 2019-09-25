Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8991EBDEE1
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2019 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406161AbfIYNYv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Sep 2019 09:24:51 -0400
Received: from foss.arm.com ([217.140.110.172]:49392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406133AbfIYNYu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Sep 2019 09:24:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B42F1596;
        Wed, 25 Sep 2019 06:24:50 -0700 (PDT)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C91DF3F59C;
        Wed, 25 Sep 2019 06:24:49 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org
Cc:     dave.martin@arm.com
Subject: [PATCH 2/2] kselftest: exclude failed TARGETS from runlist
Date:   Wed, 25 Sep 2019 14:24:21 +0100
Message-Id: <20190925132421.23572-2-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925132421.23572-1-cristian.marussi@arm.com>
References: <20190925132421.23572-1-cristian.marussi@arm.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A TARGET which failed to be built/installed should not be included in the
runlist generated inside the run_kselftest.sh script.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
As an example, here BPF failed to compile but was included in the runlist
and attempted to run anyway:

...
./KSFT_LAST_2/run_kselftest.sh: 37: cd: can't cd to bpf
TAP version 13
1..49
\# selftests: KSFT_LAST_2: test_verifier
\# Warning: file test_verifier is missing!
not ok 1 selftests: KSFT_LAST_2: test_verifier
\# selftests: KSFT_LAST_2: test_tag
\# Warning: file test_tag is missing!
---
 tools/testing/selftests/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 103936faa46d..e11ace11b07c 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -202,8 +202,12 @@ ifdef INSTALL_PATH
 	echo "  cat /dev/null > \$$logfile" >> $(ALL_SCRIPT)
 	echo "fi" >> $(ALL_SCRIPT)
 
+	@# While building run_kselftest.sh skip also non-existent TARGET dirs:
+	@# they could be the result of a build failure and should NOT be
+	@# included in the generated runlist.
 	for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
+		[ ! -d $$INSTALL_PATH/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
-- 
2.17.1

