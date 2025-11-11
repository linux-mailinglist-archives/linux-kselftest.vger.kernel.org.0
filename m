Return-Path: <linux-kselftest+bounces-45339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2576BC4F48B
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 18:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DB18C35B9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Nov 2025 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6BE3A79A0;
	Tue, 11 Nov 2025 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ohPOIF7K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DC3A1D0D
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882613; cv=none; b=Dsihg+LUIq76VoHp/4s82JuQV01Gh7EfcEG85ThvLMzILdv9oY2AdhFmR+/WeTQdA9ixnnbnEgqxJTMLamNvna6+ZijUl7ruccJFL3eaYkbNNjqZXsPm5Rt/mb33kuNbPeF+vRW+TfIVwffMpsRPIO2WAbNEtVCiV0j+/qujf1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882613; c=relaxed/simple;
	bh=8YGDWKZMZ4rg6g9jadHfjYJ49DLGb0GNWnRjrg7bjP8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CufeYTIQ9un2EBq0dK4EXV17X2pmx9FGIn6iixn8psdzdLj3BaVYspyRPE7FaB/DXTp2S2P/Bzv+tUUndsHGZTB/MCZLp9RxZLce1Xbs2XBThg/tvsu/qf/ITB2OBeBPAXgPz0eTzufbPiokCPrpRL6cFzFmfWWz5quewZstNLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ohPOIF7K; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-475e032d81bso26958615e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Nov 2025 09:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762882609; x=1763487409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHk+n1DTS8EFhi+cKHdXuVXK4mRrNAjTvT92loE1bGw=;
        b=ohPOIF7K8E+ozFul3+YJ9aCbMe61QoiL85Garz+qhXpdRX3kot1txeoP4+BaofPbk9
         EjWtlXLEUQfFsVx8P3U+dhEsEG1Tw3Sz8W6f57WHgJMm2iqQI+NAWsCHADYQhSYedDWF
         sPbi2p3fpAxYdNFPyxk4KjMW1+HWgCVOXNHKjA6RoM7Od89w5xIUMOA5nE3VlYf87RpC
         gzu2aQXEbB51yR50pjidfN0Tic33+uKrNN2ZyV83J89lWLn6kjzz9fINEWa5Gb1NmtYe
         XqMby7UIsmYhmCTo64aVgJNxfB06sOnwNbMkwRtCoMbbU1VvLFkl6dOqt5CWUDRSZ/Es
         JPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882609; x=1763487409;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHk+n1DTS8EFhi+cKHdXuVXK4mRrNAjTvT92loE1bGw=;
        b=cW+sAXG4lHCqpNqKYYy1NqDkfpyMwiXF1pZ9YyYpLNbcgq6vTr6tL5Er9BlXK6bBv0
         AcP3VTQRglvuNngvi1XfOCfcgF1CBTJ1aYPUmGWgfjEcvR6bFqGk2l+Y+mf2wxhKJQUO
         mcj+i5gNDgLSJLBNDGnccBbdZXkT4cakSnJDdc1GVUF2p74mDJEoBeAYNT1hFwANv02+
         KdVsuWp9+/yhSvAoqxrh+yyyE+Da2UyXwUA4PvYQnjIuUAgZWjNHG/oCZukWnQYLXpRb
         u3wDSuTIn3tAIFQsLqR8RbQRZD77db8JiklkaH4e/K07pNH0ng+3vJlB9hnVCl82UnAl
         G4/A==
X-Forwarded-Encrypted: i=1; AJvYcCXi3I3XGaoUoiOMG+5qOye9hrj4PA64/73llpb39pr3c62kEl/GpJkFdhHnIxtuiEtja77bDs9gZVW/CZeS174=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFMLuxgK+pg7nG4soSZcW7yn4iJiHiGRMjc+tgd03nfoogd9Xr
	9E6HtQVmxpyD0vIP8QjyLRFH6wepigBhUeulECLXGj93bIyzE0jz65VlP0sTHDoS2zjs56JivkP
	kaXTr4a03hI0U4g==
X-Google-Smtp-Source: AGHT+IFash/y2AqAf9V3BG0zVcfUyjagtoZoZBAYxC2RDwTCzOL54auCDPMewWsZlZffs19L721j6rDsLwitPA==
X-Received: from wmcq1.prod.google.com ([2002:a05:600c:c101:b0:477:40c1:3e61])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4694:b0:475:e007:baf2 with SMTP id 5b1f17b1804b1-477870ba725mr2270855e9.41.1762882609366;
 Tue, 11 Nov 2025 09:36:49 -0800 (PST)
Date: Tue, 11 Nov 2025 17:36:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.14.2
Message-ID: <20251111-b4-ksft-error-on-fail-v3-1-0951a51135f6@google.com>
Subject: [PATCH RESEND v3] selftests/run_kselftest.sh: exit with error if
 tests fail
From: Brendan Jackman <jackmanb@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: "=?utf-8?q?Thomas_Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Parsing KTAP is quite an inconvenience, but most of the time the thing
you really want to know is "did anything fail"?

Let's give the user the his information without them needing
to parse anything.

Because of the use of subshells and namespaces, this needs to be
communicated via a file. Just write arbitrary data into the file and
treat non-empty content as a signal that something failed.

In case any user depends on the current behaviour, such as running this
from a script with `set -e` and parsing the result for failures
afterwards, add a flag they can set to get the old behaviour, namely
--no-error-on-fail.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Changes in v3:
- Fixed quoting
- Link to v2: https://lore.kernel.org/r/20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com

Changes in v2:
- Fixed bug in report_failure()
- Made error-on-fail the default
- Link to v1: https://lore.kernel.org/r/20251007-b4-ksft-error-on-fail-v1-1-71bf058f5662@google.com
---
 tools/testing/selftests/kselftest/runner.sh | 14 ++++++++++----
 tools/testing/selftests/run_kselftest.sh    | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 2c3c58e65a419f5ee8d7dc51a37671237a07fa0b..3a62039fa6217f3453423ff011575d0a1eb8c275 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -44,6 +44,12 @@ tap_timeout()
 	fi
 }
 
+report_failure()
+{
+	echo "not ok $*"
+	echo "$*" >> "$kselftest_failures_file"
+}
+
 run_one()
 {
 	DIR="$1"
@@ -105,7 +111,7 @@ run_one()
 	echo "# $TEST_HDR_MSG"
 	if [ ! -e "$TEST" ]; then
 		echo "# Warning: file $TEST is missing!"
-		echo "not ok $test_num $TEST_HDR_MSG"
+		report_failure "$test_num $TEST_HDR_MSG"
 	else
 		if [ -x /usr/bin/stdbuf ]; then
 			stdbuf="/usr/bin/stdbuf --output=L "
@@ -123,7 +129,7 @@ run_one()
 				interpreter=$(head -n 1 "$TEST" | cut -c 3-)
 				cmd="$stdbuf $interpreter ./$BASENAME_TEST"
 			else
-				echo "not ok $test_num $TEST_HDR_MSG"
+				report_failure "$test_num $TEST_HDR_MSG"
 				return
 			fi
 		fi
@@ -137,9 +143,9 @@ run_one()
 			echo "ok $test_num $TEST_HDR_MSG # SKIP"
 		elif [ $rc -eq $timeout_rc ]; then \
 			echo "#"
-			echo "not ok $test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
+			report_failure "$test_num $TEST_HDR_MSG # TIMEOUT $kselftest_timeout seconds"
 		else
-			echo "not ok $test_num $TEST_HDR_MSG # exit=$rc"
+			report_failure "$test_num $TEST_HDR_MSG # exit=$rc"
 		fi)
 		cd - >/dev/null
 	fi
diff --git a/tools/testing/selftests/run_kselftest.sh b/tools/testing/selftests/run_kselftest.sh
index 0443beacf3621ae36cb12ffd57f696ddef3526b5..d4be97498b32e975c63a1167d3060bdeba674c8c 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -33,6 +33,7 @@ Usage: $0 [OPTIONS]
   -c | --collection COLLECTION	Run all tests from COLLECTION
   -l | --list			List the available collection:test entries
   -d | --dry-run		Don't actually run any tests
+  -f | --no-error-on-fail	Don't exit with an error just because tests failed
   -n | --netns			Run each test in namespace
   -h | --help			Show this usage info
   -o | --override-timeout	Number of seconds after which we timeout
@@ -44,6 +45,7 @@ COLLECTIONS=""
 TESTS=""
 dryrun=""
 kselftest_override_timeout=""
+ERROR_ON_FAIL=true
 while true; do
 	case "$1" in
 		-s | --summary)
@@ -65,6 +67,9 @@ while true; do
 		-d | --dry-run)
 			dryrun="echo"
 			shift ;;
+		-f | --no-error-on-fail)
+			ERROR_ON_FAIL=false
+			shift ;;
 		-n | --netns)
 			RUN_IN_NETNS=1
 			shift ;;
@@ -105,9 +110,18 @@ if [ -n "$TESTS" ]; then
 	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
+kselftest_failures_file="$(mktemp --tmpdir kselftest-failures-XXXXXX)"
+export kselftest_failures_file
+
 collections=$(echo "$available" | cut -d: -f1 | sort | uniq)
 for collection in $collections ; do
 	[ -w /dev/kmsg ] && echo "kselftest: Running tests in $collection" >> /dev/kmsg
 	tests=$(echo "$available" | grep "^$collection:" | cut -d: -f2)
 	($dryrun cd "$collection" && $dryrun run_many $tests)
 done
+
+failures="$(cat "$kselftest_failures_file")"
+rm "$kselftest_failures_file"
+if "$ERROR_ON_FAIL" && [ "$failures" ]; then
+	exit 1
+fi

---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20251007-b4-ksft-error-on-fail-0c2cb3246041

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


