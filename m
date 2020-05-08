Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92C001CA490
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 May 2020 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEHGxt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 May 2020 02:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725971AbgEHGxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 May 2020 02:53:48 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38809C05BD43;
        Thu,  7 May 2020 23:53:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49JLdh6JfQz9sSy; Fri,  8 May 2020 16:53:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588920824;
        bh=9Ynms6h27w3AbHNpPH8n4uEonv1y0P/FM3hzIpDmeh0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBieyN440rRpPXdGKZOP/FUv65pTIR2LQbC4+L21Xu6LA4zmzWIQafdUr6+jxSeiW
         l5m5McNHxwk5XIa9VtBvcx4dmDfD0zH0b8hNkXEp2ql0y+HcaISvLyNHR+lJb+8bRq
         IJl+jgMjI2qVUVFUiQUTz/ouKLyiCeMr9O3bEiZBfKGsxKcKp3tQXfPqfFuPVZXsQj
         MXK4NEVfsv/qDbYdI7o+J1iw2jpjgJUOrs4V0HcNJ6r6KCmmi85gVAiiJ6Aj/3R4EP
         V9wtD8tWLW6JeC6uV8EAiRVXYJXdSmITh0po6xMm/O73AXtX3HWCXA2ayzGF7V8sLL
         6dfxqUlxwidog==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     keescook@chromium.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] selftests/lkdtm: Use grep -E instead of egrep
Date:   Fri,  8 May 2020 16:53:56 +1000
Message-Id: <20200508065356.2493343-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200508065356.2493343-1-mpe@ellerman.id.au>
References: <20200508065356.2493343-1-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

shellcheck complains that egrep is deprecated, and the grep man page
agrees. Use grep -E instead.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/lkdtm/run.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/lkdtm/run.sh b/tools/testing/selftests/lkdtm/run.sh
index 0b409e187c7b..ee64ff8df8f4 100755
--- a/tools/testing/selftests/lkdtm/run.sh
+++ b/tools/testing/selftests/lkdtm/run.sh
@@ -25,13 +25,13 @@ fi
 # Figure out which test to run from our script name.
 test=$(basename $0 .sh)
 # Look up details about the test from master list of LKDTM tests.
-line=$(egrep '^#?'"$test"'\b' tests.txt)
+line=$(grep -E '^#?'"$test"'\b' tests.txt)
 if [ -z "$line" ]; then
 	echo "Skipped: missing test '$test' in tests.txt"
 	exit $KSELFTEST_SKIP_TEST
 fi
 # Check that the test is known to LKDTM.
-if ! egrep -q '^'"$test"'$' "$TRIGGER" ; then
+if ! grep -E -q '^'"$test"'$' "$TRIGGER" ; then
 	echo "Skipped: test '$test' missing in $TRIGGER!"
 	exit $KSELFTEST_SKIP_TEST
 fi
@@ -80,11 +80,11 @@ dmesg | diff --changed-group-format='%>' --unchanged-group-format='' "$DMESG" -
 
 cat "$LOG"
 # Check for expected output
-if egrep -qi "$expect" "$LOG" ; then
+if grep -E -qi "$expect" "$LOG" ; then
 	echo "$test: saw '$expect': ok"
 	exit 0
 else
-	if egrep -qi XFAIL: "$LOG" ; then
+	if grep -E -qi XFAIL: "$LOG" ; then
 		echo "$test: saw 'XFAIL': [SKIP]"
 		exit $KSELFTEST_SKIP_TEST
 	else
-- 
2.25.1

