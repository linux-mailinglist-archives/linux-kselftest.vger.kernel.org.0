Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89B3254498
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Aug 2020 13:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgH0Lxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Aug 2020 07:53:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728820AbgH0Lxp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Aug 2020 07:53:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F147AC50;
        Thu, 27 Aug 2020 11:07:43 +0000 (UTC)
From:   Miroslav Benes <mbenes@suse.cz>
To:     jpoimboe@redhat.com, jikos@kernel.org, pmladek@suse.com,
        joe.lawrence@redhat.com, shuah@kernel.org
Cc:     live-patching@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH] selftests/livepatch: Do not check order when using "comm" for dmesg checking
Date:   Thu, 27 Aug 2020 13:07:09 +0200
Message-Id: <20200827110709.26824-1-mbenes@suse.cz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

check_result() uses "comm" to check expected results of selftests output
in dmesg. Everything works fine if timestamps in dmesg are unique. If
not, like in this example

[   86.844422] test_klp_callbacks_demo: pre_unpatch_callback: test_klp_callbacks_mod -> [MODULE_STATE_LIVE] Normal state
[   86.844422] livepatch: 'test_klp_callbacks_demo': starting unpatching transition

, "comm" fails with "comm: file 2 is not in sorted order". Suppress the
order checking with --nocheck-order option.

Signed-off-by: Miroslav Benes <mbenes@suse.cz>
---

The strange thing is, I can reproduce the issue easily and reliably on
older codestreams (4.12) but not on current upstream in my testing
environment. I think the change makes sense regardless though.

 tools/testing/selftests/livepatch/functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index 1aba83c87ad3..846c7ed71556 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -278,7 +278,7 @@ function check_result {
 	# help differentiate repeated testing runs.  Remove them with a
 	# post-comparison sed filter.
 
-	result=$(dmesg | comm -13 "$SAVED_DMESG" - | \
+	result=$(dmesg | comm --nocheck-order -13 "$SAVED_DMESG" - | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
 		 sed 's/^\[[ 0-9.]*\] //')
-- 
2.28.0

