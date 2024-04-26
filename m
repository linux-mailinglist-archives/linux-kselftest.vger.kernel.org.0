Return-Path: <linux-kselftest+bounces-8907-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D815B8B33AA
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 11:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C1ECB21E8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Apr 2024 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B31513D53D;
	Fri, 26 Apr 2024 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="snay4uiP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68608282EA;
	Fri, 26 Apr 2024 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122861; cv=none; b=He4OLHxj7XkvnIejMzuabDKwjIgMpDgdm5aj/4f71VcOQSo/zmPKcoJ3H86c3eyc4+EWV7myjHUZaUAEebDwfPTMOIuBGfu9SShNsQODYPYREeJ29Ky0BiTz4VXjrfvXGi3PGC4WPl46XCiRFG0iVzM3/Dnqnv0E4rOGRSeVwic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122861; c=relaxed/simple;
	bh=XRMyjyuFRMYv4naA7smww2pv7Fyy87chOndvIRM21zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VsqTIRwwMnvmyS1KEetxn8jOU1fgusojDCcgSYDDg4UwCcrnpFPP2WqmRUtdiDb6dIviaPCCm52BlHwDuVoGxGKfQWMAzXcfizjFsDX15Jjap0rFrHjrPkCprPGKFYby2LUp1Bf7c8Zy0t/DfZ8TTd9uyW6SzWNJW7oQIkPSIf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=snay4uiP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714122857;
	bh=XRMyjyuFRMYv4naA7smww2pv7Fyy87chOndvIRM21zo=;
	h=From:To:Cc:Subject:Date:From;
	b=snay4uiPzdNKoUj8uDMupInxEoFmLrh7EgQ1xM1KF+ZwDk++yID21DyPwhm6WawCF
	 Hukc5U8qJHT57NoFnEIWTX38a/KWVnSXuh2Xr/2+Fry9NPfxsyMH3szlCGo72Nx3U9
	 t8vskqpAM0809QTFEExY8ZU/hgX2clP8KVn6xMNC3kwOgiIScGde4gbqgGD5Pel80g
	 SICtTjnjBCv6UXWjLM0/JvrcyUCQPkLHlQfVDecXBsQ8KaKsBS/VL7z3vjylnomqYe
	 511Aijo4a1XAhTGlEjqhsv/5UOXIjtdHyKCDCtXb4yadEmkiZA9ws2PbGaOfxLT9wE
	 smOewfX04lHAQ==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id DCAD737809D1;
	Fri, 26 Apr 2024 09:14:14 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: tpm2: conform test to TAP output
Date: Fri, 26 Apr 2024 14:14:31 +0500
Message-Id: <20240426091435.2742024-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The python unittest is being used for executing tests. TAP output
cannot be added in the unittest framework. The python unittest is being
run from a script. Add the output TAP logs to the script. Add "#"
prefix to the python unittest output which will mark all output as
informational TAP messages. Check exit status of the python unittest to
decide if test passed or failed. Not sure why but python unittest
outputs logs in stderr. So redirect the logs to stdout and then add
prefix.

Specify the bash explicitly instead of sh to run these tests as all of
the kselftests are shifting towards using bash explicitly. Some
interpreters have different syntax and cause issues.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/tpm2/test_async.sh | 24 ++++++++++++++++------
 tools/testing/selftests/tpm2/test_smoke.sh | 19 ++++++++++++++---
 tools/testing/selftests/tpm2/test_space.sh | 19 ++++++++++++++---
 3 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
index 43bf5bd772fd4..0e6e5d9d649fb 100755
--- a/tools/testing/selftests/tpm2/test_async.sh
+++ b/tools/testing/selftests/tpm2/test_async.sh
@@ -1,10 +1,22 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+DIR="$(dirname $(readlink -f "$0"))"
+source "${DIR}"/../kselftest/ktap_helpers.sh
 
-[ -e /dev/tpm0 ] || exit $ksft_skip
-[ -e /dev/tpmrm0 ] || exit $ksft_skip
+ktap_print_header
 
-python3 -m unittest -v tpm2_tests.AsyncTest
+[ -e /dev/tpm0 ] || ktap_finished
+[ -e /dev/tpmrm0 ] || ktap_finished
+
+ktap_set_plan 1
+
+python3 -m unittest -v tpm2_tests.AsyncTest 2>&1 | sed "s/^/# /"
+
+if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
+	ktap_test_pass "tpm2_tests.AsyncTest"
+else
+	ktap_test_fail "tpm2_tests.AsyncTest"
+fi
+
+ktap_finished
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 58af963e5b55a..2219a180de91d 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,9 +1,22 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
 # Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+DIR="$(dirname $(readlink -f "$0"))"
+source "${DIR}"/../kselftest/ktap_helpers.sh
+
+ktap_print_header
 
 [ -e /dev/tpm0 ] || exit $ksft_skip
 
-python3 -m unittest -v tpm2_tests.SmokeTest
+ktap_set_plan 1
+
+python3 -m unittest -v tpm2_tests.SmokeTest 2>&1 | sed "s/^/# /"
+
+if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
+	ktap_test_pass "tpm2_tests.AsyncTest"
+else
+	ktap_test_fail "tpm2_tests.AsyncTest"
+fi
+
+ktap_finished
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 04c47b13fe8ac..6a55d13d74983 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,9 +1,22 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
 # Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
+DIR="$(dirname $(readlink -f "$0"))"
+source "${DIR}"/../kselftest/ktap_helpers.sh
+
+ktap_print_header
 
 [ -e /dev/tpmrm0 ] || exit $ksft_skip
 
-python3 -m unittest -v tpm2_tests.SpaceTest
+ktap_set_plan 1
+
+python3 -m unittest -v tpm2_tests.SpaceTest 2>&1 | sed "s/^/# /"
+
+if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
+	ktap_test_pass "tpm2_tests.AsyncTest"
+else
+	ktap_test_fail "tpm2_tests.AsyncTest"
+fi
+
+ktap_finished
-- 
2.39.2


