Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E9C1CA48E
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 08:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgEHGxq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 02:53:46 -0400
Received: from ozlabs.org ([203.11.71.1]:33791 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgEHGxp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 02:53:45 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49JLdg623nz9sSs; Fri,  8 May 2020 16:53:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588920823;
        bh=acAgab8g6yhDEvTaya+ecKBQqSHAhREHhSbZFn0j3sY=;
        h=From:To:Cc:Subject:Date:From;
        b=pRFFc4jh4HLz9bwkFCuTkCFdIwklxYYg6WoWqUvG2tbuebKPlO+q2Eyc45+pcGlRh
         JFhRjsVFi7AflB108Hman1pd3K3r2vV1pDrn7HepYny22964LV6ireFqjx/gzBCEMj
         Xje5vDl2YuXJuBObStk4wFk3cnQdOtJmqNQK/HTRFSGn1/tkfqzsvC01wtVAPgR41u
         JlyELZ20QPqTfwMT+yGNgNx6f/SkQrkuN+Uh8ZvcnV5h2HQC8EB/zY6XiXwEq/KOba
         Mgw5VMIHMwRgAVqYH4QQpMVI2Sq+X5O7cHzkJpF7RwDtW5OxOUCJyTviT+3dO2Y5nW
         lnyS5wm+xTvwQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     keescook@chromium.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/lkdtm: Don't clear dmesg when running tests
Date:   Fri,  8 May 2020 16:53:55 +1000
Message-Id: <20200508065356.2493343-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It is Very Rude to clear dmesg in test scripts. That's because the
script may be part of a larger test run, and clearing dmesg
potentially destroys the output of other tests.

We can avoid using dmesg -c by saving the content of dmesg before the
test, and then using diff to compare that to the dmesg afterward,
producing a log with just the added lines.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/lkdtm/run.sh | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index dadf819148a4..0b409e187c7b 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -59,23 +59,25 @@ if [ -z "$expect" ]; then
 	expect="call trace:"
 fi
 
-# Clear out dmesg for output reporting
-dmesg -c >/dev/null
-
 # Prepare log for report checking
-LOG=$(mktemp --tmpdir -t lkdtm-XXXXXX)
+LOG=$(mktemp --tmpdir -t lkdtm-log-XXXXXX)
+DMESG=$(mktemp --tmpdir -t lkdtm-dmesg-XXXXXX)
 cleanup() {
-	rm -f "$LOG"
+	rm -f "$LOG" "$DMESG"
 }
 trap cleanup EXIT
 
+# Save existing dmesg so we can detect new content below
+dmesg > "$DMESG"
+
 # Most shells yell about signals and we're expecting the "cat" process
 # to usually be killed by the kernel. So we have to run it in a sub-shell
 # and silence errors.
 ($SHELL -c 'cat <(echo '"$test"') >'"$TRIGGER" 2>/dev/null) || true
 
 # Record and dump the results
-dmesg -c >"$LOG"
+dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" - > "$LOG" || true
+
 cat "$LOG"
 # Check for expected output
 if egrep -qi "$expect" "$LOG" ; then

base-commit: 192ffb7515839b1cc8457e0a8c1e09783de019d3
-- 
2.25.1

