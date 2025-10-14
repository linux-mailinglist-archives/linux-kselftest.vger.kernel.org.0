Return-Path: <linux-kselftest+bounces-43134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C23B4BDA225
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE8019A54B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 14:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C762FB09B;
	Tue, 14 Oct 2025 14:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xErK7qIV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DBB2F99A6
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 14:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453135; cv=none; b=MZmuX8KFiFO191XFPpYdcetWejElxqUOcOL7rGLrYfKp0gfi/XAYNeGrsLQQAUqSh2YCmsDkhfL7wz449diSjd/JgfNQ+BnTRhJIw9GwO98ZODUJqNIYEitJq7jtlOnAA483/U67iuGClxx+M4cZUevCL4blsBqfY3O0yo6Dux4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453135; c=relaxed/simple;
	bh=8YGDWKZMZ4rg6g9jadHfjYJ49DLGb0GNWnRjrg7bjP8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Mp6RVdvfqKwe+ZW969x+LRIDsrjx+kZcalPz3dyNzh1TlPkNQyPaiVmicu9NioEx/n2cs9+ytIh3kRNqySZiutyzK7d78XJuztF2JLEgF3no4uIjHnTuymywQEhpr5U23/q+Y+rb+mKkW4CAejsw2fZYqh+BfAfSJ7ri5ZCW2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xErK7qIV; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-46e2d845ebeso35932735e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 07:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760453131; x=1761057931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gHk+n1DTS8EFhi+cKHdXuVXK4mRrNAjTvT92loE1bGw=;
        b=xErK7qIVKa04S4WyxU1S+qrTZg8tdGI24sFvrcml3cQcLMsrOlmwOAKwr/f7UsqxKT
         vH/I7h2Yy1NHfvg1qUN0+2BKAnrh9RHVPT/5kDuCwrgRkSb1973CmnZ+fZQKjM+Uhqc+
         f3CKbAmvQk0UqEC3B95Bfv8Ykl2mK6DiTwHq11eypJxUfjyXLZkv8X2Ehd8iXHEfAalL
         yXeU20/kklIbGHSXrna8/yJlXuP8JSdgQ0qnHTzEV8sDddfZGR6pflCnpbLazzuxK5AR
         qjCKSVmIxcbezMbms6coq8Fkgp+23O3L4cDOHbHxfZeuYplkVlapu9VfOwVtmmrveqEU
         wE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453131; x=1761057931;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gHk+n1DTS8EFhi+cKHdXuVXK4mRrNAjTvT92loE1bGw=;
        b=h+qBt9ttmyTkVvPzLJ3hZwaVHFoPKjxxYUJcWVxEjksis/xbszuKHnlnrAUV++9kQH
         1Fxvh60wSrH1UFbDTPHMagWfpCuUpwU6UaYd6o2pNspJ6z4QR+OHqH+IP3ckE9fsygqF
         f86FbIgAgAZFFHGwkHglONSkgF/kTPwlnpWRz2Qxjms1LFmvvINoA2l9hwzz4dZV4TYP
         c0jQtAeQJowiGeF9QTk53cIi4F/65ZHaCH9j7wM//A8J6pZ39z1HzyxxOzS7tKCbkEdn
         Echqt4hzhsVwLQCHXgdg9Olwj4fsTkXkf9KGRfn92DlbAlr5QLllIClSORC09riiw7YL
         RXrA==
X-Forwarded-Encrypted: i=1; AJvYcCWqJIVOhC4x0jhLMfaRDEv16PiYHbWEeqpqT70Z2ODVt1wQA2Rz3A2LsywhFpWxDr+ySnJko/ubTUQEi7UO/tA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCPuVe9ht9QBGc/9Yimp6P+o1WrlKEozCK1VyASVEnl/Ks5xRR
	nSFHXs9Re0TQXL2+2mx4BfgcYAxgLtLXcrYFi077L+0zjn0zM/F56C1sFdecLFS1eECWT50LSCB
	Fv/3lkCsQFasnYw==
X-Google-Smtp-Source: AGHT+IGStL63V0FhO1l0cVvqKc9OTBHXvyFk5MbM/ZPcJ10xamJ8DJso5DtxHGWCKT7x5jpmn9mFsq4KkGOAmg==
X-Received: from wmvw16.prod.google.com ([2002:a05:600d:42d0:b0:46f:aa50:d714])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c23:b0:46e:32a5:bd8d with SMTP id 5b1f17b1804b1-46fa9a892d7mr183885885e9.3.1760453131207;
 Tue, 14 Oct 2025 07:45:31 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:45:20 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAP9h7mgC/4XNTQ7CIBCG4asY1o6B4a9x5T2Mi4LQEmsx0BBN0
 7tLu9KFcfl+yTwzk+xScJkcdzNJroQc4liD73fE9u3YOQjX2gQpSkapBiPglv0ELqWYII7g2zA
 AtWgNR6GoYKTePpLz4bm550vtPuQpptf2prB1/ScWBgw0M57Kxkul8NTF2A3uYOOdrGTBD4aJX wxWxnCHSmrk2jRfzLIsbycYHKUCAQAA
X-Change-Id: 20251007-b4-ksft-error-on-fail-0c2cb3246041
X-Mailer: b4 0.14.2
Message-ID: <20251014-b4-ksft-error-on-fail-v3-1-31e96fdf9bd7@google.com>
Subject: [PATCH v3] selftests/run_kselftest.sh: exit with error if tests fail
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


