Return-Path: <linux-kselftest+bounces-42819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61686BC1146
	for <lists+linux-kselftest@lfdr.de>; Tue, 07 Oct 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13D213C6F0C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Oct 2025 11:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE022D7D47;
	Tue,  7 Oct 2025 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1VIP6vHo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC8E55A
	for <linux-kselftest@vger.kernel.org>; Tue,  7 Oct 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759835214; cv=none; b=RWeb+Wa11Fjh8ubnMaZxyXZc3+pdCNRj/feGM24gg9t9boVtV69wD7hvAuRQj/kI9p0ToKam6LjTJj6WpmmK/+vq+TnduHwU1/6kYCErD+p+jn0CI/AnYchiRmD5ZjhDa+aFyzxsmKkpaUmowxdg8rRGvAVdZzZrHYP0zJg6l24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759835214; c=relaxed/simple;
	bh=dhC+tck7SoCu2DOH8eOnMLOWkdZc4Jvf0qEzQt9OOHs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KyImc772YVGWHx03GiB+dYONMdVP5K6niUXS3E2J3IO2p4c11exNknqUr5DK+gUWpXtBfAoVsCwM+Lfp5F0I7tYLsDJ21FhGyHbpzFURQ4fcLLzzsIk8EV4/ts7/cj6hFYsrNMLft97WSyw+NzELqwcPj0m6kQDrvA+jcyUyxg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1VIP6vHo; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-3f3787688b0so3235316f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 Oct 2025 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759835211; x=1760440011; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X9OPas9CQaXCTsqdlBo/r+C4etd098o3ygIBmIxCaaE=;
        b=1VIP6vHoVsjEvCNfSduQE0bCmsxinh/CbvRV26FsrFWMLu4QLOdUMHYvSKZcTAJOKC
         sul2HryBfkBcV6b0zIg0ilD7AVTAgWf7ZpK4+DrG4kqehdMWsIThq1TCoIpk4C7r51ev
         AHxz76pWPOygnIDM82HI6f11kf3wxwEZf2zm8SkD+QgFgyQlfRToKEKNQ6O2V0raM+az
         VcKXpH1uE8e+Kx1gbDsvUTtwD6+GT+MO7tcMjewU+ngR9GnZYJPfp/9OF21EzLvlV6LW
         Ey7jLgGf0oaOCQ+LxtfzARUUx65+T3NYyvMfp2hTLWew9NVqV8J6uOXhf1/vP0x3BKp3
         t8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759835211; x=1760440011;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X9OPas9CQaXCTsqdlBo/r+C4etd098o3ygIBmIxCaaE=;
        b=nUFgwXsfyek8M2JKsNT28ws+1uC6e4AqCqkkOHoXAJ1Z4/ha54xZHVj32CCilXS/XU
         ciFd844Xt5bxa1njbNxeKtW2lOqEX+c+R6jL9+pgB2rnnRMyk8MRuiLyJACCgFZEOZ4M
         mw4i9c4Jftgt7umT9T0YlAJEHo2N5nRhk6id0KcAAdZeh3jSPOfQ39BYwn7NRxnBs0XO
         Jfe7mmtZ40fcPiceFIz+4WgDiv0uM1cX+D2sYCXe4ywxcoIkmlPJEIhjakQR/h+d9uq5
         hmvvpUXFNTsXo9xtwd64Y6pueLmfIj0N+Ru/YbHoMO/WSRau57ZR6DE2Kdjq8+xxwDJW
         17Xw==
X-Gm-Message-State: AOJu0Yz5x/qRJGu+berxUFwz4l/KI2772t1vVY31Pb2KecDw23kT/9wR
	E83yqWY2P+kWzEaFZKavSSyvXGWzouzVr+QdZjrD4kbwadIkuvgVxPBHljCHf6JCV/Ly3dP0yHn
	3RnvRsE5PwB0rsg==
X-Google-Smtp-Source: AGHT+IFF71N3ri/vmCY9Td9Ir9xDpGeZFKtGf4Xpj2ed0w0VYoVGa6kfi6XBJy2gM7bv0uzcI+1X4nEiOlOf6w==
X-Received: from wmna4.prod.google.com ([2002:a05:600c:684:b0:46d:6939:1b46])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:240f:b0:3fc:c90d:9957 with SMTP id ffacd0b85a97d-4256714a7c5mr10323858f8f.16.1759835211023;
 Tue, 07 Oct 2025 04:06:51 -0700 (PDT)
Date: Tue, 07 Oct 2025 11:06:46 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEX05GgC/x3MQQqDMBBA0avIrB2YpKmCVykukjipg5KUiZSCe
 PcGl2/x/wmVVbjC1J2g/JUqJTeYvoO4+vxmlKUZLNmnIRoxONxqOpBVi2LJmLzsSNHG8LBuIGe gtR/lJL/7+5qv6w96IFx/ZwAAAA==
X-Change-Id: 20251007-b4-ksft-error-on-fail-0c2cb3246041
X-Mailer: b4 0.14.2
Message-ID: <20251007-b4-ksft-error-on-fail-v1-1-71bf058f5662@google.com>
Subject: [PATCH] selftests/run_kselftest.sh: Add --error-on-fail flag
From: Brendan Jackman <jackmanb@google.com>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Parsing KTAP is quite an inconvenience, but most of the time the thing
you really want to know is "did anything fail"?

Let's give the user the ability to get this information without needing
to parse anything.

Because of the use of subshells and namespaces, this needs to be
communicated via a file. Just write arbitrary data into the file and
treat non-emppty content as a signal that something failed.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/kselftest/runner.sh | 14 ++++++++++----
 tools/testing/selftests/run_kselftest.sh    | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kselftest/runner.sh b/tools/testing/selftests/kselftest/runner.sh
index 2c3c58e65a419f5ee8d7dc51a37671237a07fa0b..fd1e0f9b1cef48c5df1afaaedc0c97bee1c12dc5 100644
--- a/tools/testing/selftests/kselftest/runner.sh
+++ b/tools/testing/selftests/kselftest/runner.sh
@@ -44,6 +44,12 @@ tap_timeout()
 	fi
 }
 
+report_failure()
+{
+	echo "not ok $*" >> "$kselftest_failures_file"
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
index 0443beacf3621ae36cb12ffd57f696ddef3526b5..c345f38ad424029bfe50d19b26bdd1d4bda29316 100755
--- a/tools/testing/selftests/run_kselftest.sh
+++ b/tools/testing/selftests/run_kselftest.sh
@@ -36,6 +36,7 @@ Usage: $0 [OPTIONS]
   -n | --netns			Run each test in namespace
   -h | --help			Show this usage info
   -o | --override-timeout	Number of seconds after which we timeout
+  -e | --error-on-fail	After finishing all tests, exit with code 1 if any failed.
 EOF
 	exit $1
 }
@@ -44,6 +45,7 @@ COLLECTIONS=""
 TESTS=""
 dryrun=""
 kselftest_override_timeout=""
+ERROR_ON_FAIL=false
 while true; do
 	case "$1" in
 		-s | --summary)
@@ -71,6 +73,9 @@ while true; do
 		-o | --override-timeout)
 			kselftest_override_timeout="$2"
 			shift 2 ;;
+		-e | --error-on-fail)
+			ERROR_ON_FAIL="true"
+			shift ;;
 		-h | --help)
 			usage 0 ;;
 		"")
@@ -105,9 +110,18 @@ if [ -n "$TESTS" ]; then
 	available="$(echo "$valid" | sed -e 's/ /\n/g')"
 fi
 
+kselftest_failures_file=$(mktemp --tmpdir kselftest-failures-XXXXXX)
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


