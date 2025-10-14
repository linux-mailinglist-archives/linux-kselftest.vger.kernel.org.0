Return-Path: <linux-kselftest+bounces-43132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A31C1BDA066
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 16:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20FD19A1362
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Oct 2025 14:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DE52D8DD0;
	Tue, 14 Oct 2025 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MIMc37OI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4562E7F39
	for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 14:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760452555; cv=none; b=bpJ/dx4YoOTp3/Jf6t2ki9yy+ijRGby9WEdB4Y7aqxw+8rRUpLf5SxcUMdEc6DIThmw0A5HbEXG7liBYltQa7U+A0CsB8a9QhN/FM3glUqMl6oPzckgk7dNmAUb5yKpUbP1dyRWzEeynoGyWJvSO3rETjLD1Vx9PBHkPbYyTPkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760452555; c=relaxed/simple;
	bh=smKJmBdlgPVHcFrF7jSBvUjhAqz577pFj83leCW2Ra4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=b3oe6CPYNDmUF1I1Mv6xJD652YmLYX2B1lkT4cG0jZVrLiRHzptJoIfjnuvsnNk7x+PSZVrgqN7FxoNLUilYF0JqRdLZ0kE0ZoLmlRn3cw2mg+r+XWJo2Gey3N8CAaf1lOzERMCLigNXA2fA8Cowd/Io0aU7MsZSqmBagzimH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MIMc37OI; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3f3c118cbb3so5378395f8f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Oct 2025 07:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760452551; x=1761057351; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bHNEr90mGpAMRqoIVdbDY10uCx0QdvNkq5/JQ1Hhwfo=;
        b=MIMc37OI/OAX5y0nwlN9vsIJ1ALebpyoe03U4xlrhJZ/s3Fq6utESZIKmOGauX50bb
         FPemWxDrC5mwoycM5Yqg+0XlA+XqgVfTh5Is66q+4widsZBfAEHBF/2wf9yr6iFkekG/
         AOjOW5kYab7N8IGSSjsAfurAZKfxNmBJ4Qam1Zz1aT9MZxlhffg/Q3kT3CePKXEDPtkp
         gYDJCwZgt0PcGQ1rY1JoUChEAVlgjIWfWaLT3tKgCmlZ304FKjXrwRPxA/UNWhKPv0q2
         OBj+dCqP1Zy62YfbBcqU57oRQVu/Z6sIacAipTiaZSt5xDhnhbRLEVo9ytXuULcUNZdd
         aQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760452551; x=1761057351;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bHNEr90mGpAMRqoIVdbDY10uCx0QdvNkq5/JQ1Hhwfo=;
        b=jU64xJf6tLhp1hiZreatFhbuYFNtYi7MjjoZr3acTTWlY8Hk5uK9jXZKNAL7YVx67W
         JKja3jorUmoJzxvQ4ly988TtO3cMXoOGNO8QobCuKlIoqCvdfBO7F8Vg4EtOur23IOK1
         cpzLAWz5RN43JYmvOJSmGMmzscA+OWSosK5JRGwfNyGQY45QJwa9NLrezkqoRIH5tLzt
         GgzFjpDHSSySqpUxUMWVCCIU1X70/V9OmKhTPg15Ovi+qCKUykznZbFdmFVLzNAbKzsv
         cwNs9BCnpaTerUrgh7j/mNrneXjnKDISxCaVAlz6mrei8fXJMFYEtgoIFlw113swks1D
         yMXg==
X-Forwarded-Encrypted: i=1; AJvYcCXsaRzyXdtJpdn3MoSlF0DonsIyDZeSQKV4RLeal0CFTGpr1Y91wNz2UNbp3srHFP/S9DpUAUzCCdVrAlWtJrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCW0YEsjOsLTQ+PlRWL1py/veHGO+FR4vAyQv8tEZlI6FMf98C
	8RytvX/i8MnQgwoK1qcfJejXZFkTZM2zmDCJNXq6RkQOKDu02zgaC2hUV12SncnO/zOXTQH04Vc
	tCMa5Xz+j8nKY5g==
X-Google-Smtp-Source: AGHT+IGhF9ZB6/Y6kRfKUT4L5E8KWE7b6QPh1ffSf76NgvsrvtGUIUm2HKpx63xXq3ojibgQADjjP4YO+TEBmg==
X-Received: from wrbdf2.prod.google.com ([2002:a5d:5b82:0:b0:402:ec26:76f8])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64c3:0:b0:3e7:4197:c99d with SMTP id ffacd0b85a97d-42667363e76mr15467393f8f.15.1760452550726;
 Tue, 14 Oct 2025 07:35:50 -0700 (PDT)
Date: Tue, 14 Oct 2025 14:35:41 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIALxf7mgC/4WNTQ6CMBBGr0Jm7Zi28mNceQ/DgtYpTETGTAnRE
 O5u5QIu30u+962QSJkSXIoVlBZOLFMGdyggDN3UE/I9MzjjKmtMg77ER4ozkqooyoSx4xFNcMG
 fXFmb0kLevpQiv/furc08cJpFP/vNYn/2X3GxaLGxPprqHKu6dtdepB/pGOQJ7bZtX1HK/S67A AAA
X-Change-Id: 20251007-b4-ksft-error-on-fail-0c2cb3246041
X-Mailer: b4 0.14.2
Message-ID: <20251014-b4-ksft-error-on-fail-v2-1-b3e2657237b8@google.com>
Subject: [PATCH v2] selftests/run_kselftest.sh: exit with error if tests fail
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
index 0443beacf3621ae36cb12ffd57f696ddef3526b5..cc1b4190edacedadafd9b993a351e4cfbf17ccd5 100755
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


