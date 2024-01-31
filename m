Return-Path: <linux-kselftest+bounces-3900-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBA8844ABA
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 23:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7380B26B10
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 22:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399393A8D2;
	Wed, 31 Jan 2024 22:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hGRcnElc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9976E39FEB;
	Wed, 31 Jan 2024 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738693; cv=none; b=ni0eLyavlVvnfXdBFIam/KiWCqNHb7+ZnQj59s8P3Qq2AUXkSGKOiHYUgIV8rUs9jL7RozdlfACDRWSFNm2lDYrZ9DNBbfBGx79rUvZKsCYYGydqOesZCaE1PX8vDj13Jfs9NpYBduq+JaRNyedhbciwuP1T8/ckbISNs1otC0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738693; c=relaxed/simple;
	bh=7H9VGfXJR9jYnYxJzHccdVf3uGEU5Tce0GliskDOlpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WAZqcox2EoIGma9yPxMYe1sxYQQIBBtOuUkotfiHhWs1UMaRdQcR+KyMN1PBB4vLP62fn9bv3KKkWeyLK1m8Wq3qZ82MduYEA4GPkXaplHh5U0D1HVDGss5hBTUxGXVJidHnDW7Rdr3kKJ4js/9m1A1eUmxR5qj7o1DZcBnti+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hGRcnElc; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706738690;
	bh=7H9VGfXJR9jYnYxJzHccdVf3uGEU5Tce0GliskDOlpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hGRcnElcLWWFhlSNdkDPPLRXd0t/SdjYrXdPbyiWPnTX9+SEnjNnwsj3zqz2lj0ST
	 RTZBZ7zmAA16SXyZgT/lliY505s34/IkpN/YxVBuUK43SDZDcQoifT/LqkaJL5vhyW
	 45ApgmiWh65o4FlspKls0TPWGOA0XZB1Ois5i/ZIm2gE6kSlf4AzNH2njrqyEYZVax
	 Foo9pwx34h+qMDxvRwRd7g4OMVateTMd8mHB9g3AFQ39AagmV94qiMcAfwC/1uZuxG
	 WjcUMvLbGiZTteoyLVtq0+A7iXQOqHNggr71QeomKnPSmUHR3SZjQU197vVXmyyFIt
	 9W2zYr160W0iw==
Received: from [192.168.1.211] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D595C3782079;
	Wed, 31 Jan 2024 22:04:48 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Wed, 31 Jan 2024 17:02:43 -0500
Subject: [PATCH 4/4] selftests: ktap_helpers: Add a helper to finish the
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240131-ktap-sh-helpers-extend-v1-4-98ffb468712c@collabora.com>
References: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
In-Reply-To: <20240131-ktap-sh-helpers-extend-v1-0-98ffb468712c@collabora.com>
To: Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Laura Nao <laura.nao@collabora.com>, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.12.4

Similar to the C counterpart, keep track of the number of test cases in
the test plan and add a helper function to be called at the end of the
test to print the results and exit with the corresponding exit code.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 tools/testing/selftests/kselftest/ktap_helpers.sh | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 87f93c6900c5..f2fbb914e058 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -15,6 +15,8 @@ KSFT_XFAIL=2
 KSFT_XPASS=3
 KSFT_SKIP=4
 
+KSFT_NUM_TESTS=0
+
 ktap_print_header() {
 	echo "TAP version 13"
 }
@@ -25,9 +27,9 @@ ktap_print_msg()
 }
 
 ktap_set_plan() {
-	num_tests="$1"
+	KSFT_NUM_TESTS="$1"
 
-	echo "1..$num_tests"
+	echo "1..$KSFT_NUM_TESTS"
 }
 
 ktap_skip_all() {
@@ -94,6 +96,16 @@ ktap_exit_fail_msg() {
 	exit "$KSFT_FAIL"
 }
 
+ktap_finished() {
+	ktap_print_totals
+
+	if [ $(("$KTAP_CNT_PASS" + "$KTAP_CNT_SKIP")) -eq "$KSFT_NUM_TESTS" ]; then
+		exit "$KSFT_PASS"
+	else
+		exit "$KSFT_FAIL"
+	fi
+}
+
 ktap_print_totals() {
 	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
 }

-- 
2.43.0


