Return-Path: <linux-kselftest+bounces-13036-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E987991EF8E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 08:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6CE4284306
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 06:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45055C1A;
	Tue,  2 Jul 2024 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rC17l2Ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88278BA37;
	Tue,  2 Jul 2024 06:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903386; cv=none; b=Pm7XueGeCxXXkDlwAID2qIq+ObnpFJu5vv5+e1Wj2Vrh6EcRmex2NFwy1ndVoer5gpr0IykkqDlUhzahX3pW59M15/1heyG9NdPs6HjEpFPH/rW42nW/caSCJUufWJEUB4mNMkqWlug4QVdUx67400cs2/bh0s112Hn58yR4Psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903386; c=relaxed/simple;
	bh=NZ9ZWfiHNIhbklOLar+w2gJL4apswyhvs2Vi1emaHQE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NNWfskeNeQSXSLnMcaQRON7vJh/AyDMOD5o30bc7MoEcMSYZKcuVam3BCwIm7sMt+bDVE+VMhWodCJ7C/zc74AMQ253op+wW+2MXNjPIixA59V/C+hCUrTh3shk78dNXTKWWbeI1CcnpCJp2fU4MQ4U8uyjD/1xB2/yyWE0laJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rC17l2Ck; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719903376;
	bh=NZ9ZWfiHNIhbklOLar+w2gJL4apswyhvs2Vi1emaHQE=;
	h=From:To:Cc:Subject:Date:From;
	b=rC17l2Ckr1F+vyRE+6NNFuGJClihxc8+rvHXaUPFWEdB/nGyqEwlQfjvjuUaHosqq
	 Gmj6+TQAwOjEIYJERCyYixM8hzfbI5pQM0pC6ALtlaZD+mKGGWioxCxKSKLcCEvXT1
	 XEaHs0m+DI4K6/Fl91OYvcPQIq+KRICRa49cvwqCjglkhWzlcURK2kk50KzKAP4vHN
	 ajTFz2VlDCX8mKLkCG7TRpHJENlbB7x3MHjNigAyNsq9XlMfdszjyvqSuOzVaFwd6O
	 1mYhEB88hzWaZsgcJe5DSCXFsd4OWTelIzH0IXtUoC3TJOlDor07FoGhuz3qrlu7XH
	 CJOJwaXYHFouw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 698D03782139;
	Tue,  2 Jul 2024 06:56:10 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Jarkko Sakkinen <jarkko@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: tpm2: conform test to TAP output
Date: Tue,  2 Jul 2024 11:55:53 +0500
Message-Id: <20240702065559.772855-1-usama.anjum@collabora.com>
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

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- CC more people which were missing earlier
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


