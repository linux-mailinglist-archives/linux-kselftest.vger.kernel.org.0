Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E897421EC53
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 11:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgGNJKq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 05:10:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:54426 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725793AbgGNJKq (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 05:10:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E2E7BAAC7;
        Tue, 14 Jul 2020 09:10:46 +0000 (UTC)
From:   Petr Mladek <pmladek@suse.com>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH v2] selftests/livepatch: adopt to newer sysctl error format
Date:   Tue, 14 Jul 2020 11:10:30 +0200
Message-Id: <20200714091030.1611-1-pmladek@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With procfs v3.3.16, the sysctl command doesn't print the set key and
value on error.  This change breaks livepatch selftest test-ftrace.sh,
that tests the interaction of sysctl ftrace_enabled:

Make it work with all sysctl versions using '-q' option.

Explicitly print the final status on success so that it can be verified
in the log. The error message is enough on failure.

Reported-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
The patch has been created against livepatch.git,
branch for-5.9/selftests-cleanup. But it applies also against
the current Linus' tree.

tools/testing/selftests/livepatch/functions.sh   | 3 ++-
 tools/testing/selftests/livepatch/test-ftrace.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 408529d94ddb..1aba83c87ad3 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -75,7 +75,8 @@ function set_dynamic_debug() {
 }
 
 function set_ftrace_enabled() {
-	result=$(sysctl kernel.ftrace_enabled="$1" 2>&1 | paste --serial --delimiters=' ')
+	result=$(sysctl -q kernel.ftrace_enabled="$1" 2>&1 && \
+		 sysctl kernel.ftrace_enabled 2>&1)
 	echo "livepatch: $result" > /dev/kmsg
 }
 
diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
index 9160c9ec3b6f..552e165512f4 100755
--- a/tools/testing/selftests/livepatch/test-ftrace.sh
+++ b/tools/testing/selftests/livepatch/test-ftrace.sh
@@ -51,7 +51,7 @@ livepatch: '$MOD_LIVEPATCH': initializing patching transition
 livepatch: '$MOD_LIVEPATCH': starting patching transition
 livepatch: '$MOD_LIVEPATCH': completing patching transition
 livepatch: '$MOD_LIVEPATCH': patching complete
-livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy kernel.ftrace_enabled = 0
+livepatch: sysctl: setting key \"kernel.ftrace_enabled\": Device or resource busy
 % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
 livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
 livepatch: '$MOD_LIVEPATCH': starting unpatching transition
-- 
2.26.2

