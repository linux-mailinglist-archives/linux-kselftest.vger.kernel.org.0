Return-Path: <linux-kselftest+bounces-22527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB01C9D94A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625DE1674DC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Nov 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8D71BBBF4;
	Tue, 26 Nov 2024 09:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="OajecJN8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BFD1B87DC;
	Tue, 26 Nov 2024 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613839; cv=pass; b=CE6VYryAEDwm2kfCHVj3xC9nJRBtDH/0riF+osJ7Y0EHOJUgJRe1hZ36ie0m4gjz/9iccujUSCEQeYMBppehQ5lOT4eM8nAo2dlkNdx3d9gQfW7tANXSgD65Bvq+qctFkTDl6q3PvgPBYu0LPEzh9JcwrdogAwUQHmXVawthOUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613839; c=relaxed/simple;
	bh=pGQjsV8WADMN/kZ8lRycL16QOgiWUNXsq+WaovEeYJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n4Zvs5cmmoWHS+ALzVmWxdq8QKJOKO3c5l1wUKrHwSjgUwfDjqBNpuQ37pZh9ktfcNz83v/QkOy5yjBMBIX6+ZNWljqCO0bHFKAvpffKq31XwTCQeKEA23VaR7GsUlz6zZaERMeM40lLfyNSyGik0Fs7I/jys8BtNqw7rUw9ZPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=OajecJN8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732613827; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hc/ygFitAkhiv1Aur1pQXmK/+uIrRGUuJek7sfDU3cNAnk8Mj+YdzcXLHAkG3Dn06Crk8JtDDa4tcyzNUM98rw5jgWPBMj/SQhGVhHwotkbbq8D5GZxCNCRo0Sdrmid0S7zGztolYIu/1hqn+5LK1tJiN5XSgSAQi0JijT7LOCE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732613827; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ltz32nFo4k/W7uTNqDzuEM+nhwt2vahueCheGlbCoog=; 
	b=RhwTKbJpY8VbfzTEBBxZS8DEvExQTUm5aPTofOwy40t+JH/bgy8v94x11/MRmnnXWiBR53DQfAHQI4EJy1FymFsADWvKnDf6WX8+ExMhsPqNjROpznOIdqVq1cyaia6lveJQa7lWjf/drWJNGk4zXs4ulQ+7mWNqoeUc6ZeL2aY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732613827;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Ltz32nFo4k/W7uTNqDzuEM+nhwt2vahueCheGlbCoog=;
	b=OajecJN8uUJ7Yvgkgozvqvh2FQ2/86iDZNthPxwiT9BhuGQhsRcwi9APmvASQA+0
	YLGXzkXYJdw/9z4sgOmpwcxg//iMiBdaqI3RnxKXDTwSk9CuJhMg6q8FWkVS5a3tJVW
	2kXFNz1zZLifzyw/eykXd4zaqiRdDjiApRsR9Fgc=
Received: by mx.zohomail.com with SMTPS id 1732613796296967.0355782356701;
	Tue, 26 Nov 2024 01:36:36 -0800 (PST)
From: Laura Nao <laura.nao@collabora.com>
To: shuah@kernel.org
Cc: gregkh@linuxfoundation.org,
	nfraprado@collabora.com,
	usama.anjum@collabora.com,
	robh@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2] selftests: Warn about skipped tests in result summary
Date: Tue, 26 Nov 2024 10:37:10 +0100
Message-Id: <20241126093710.13314-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Update the functions that print the test totals at the end of a selftest
to include a warning message when skipped tests are detected. The
message advises users that skipped tests may indicate missing
configuration options and suggests enabling them to improve coverage.

Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
Changes in v2:
- Included count of skipped tests in the warning message
---
 tools/testing/selftests/kselftest.h               | 5 +++++
 tools/testing/selftests/kselftest/ksft.py         | 3 +++
 tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++++
 3 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 29fedf609611..249201664bcb 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -147,6 +147,11 @@ static inline void ksft_set_plan(unsigned int plan)
 
 static inline void ksft_print_cnts(void)
 {
+	if (ksft_cnt.ksft_xskip > 0)
+		printf(
+			"# %u skipped test(s) detected. Consider enabling relevant config options to improve coverage.\n",
+			ksft_cnt.ksft_xskip
+		);
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
index bf215790a89d..0e030837fc17 100644
--- a/tools/testing/selftests/kselftest/ksft.py
+++ b/tools/testing/selftests/kselftest/ksft.py
@@ -27,6 +27,9 @@ def set_plan(num_tests):
 
 
 def print_cnts():
+    if ksft_cnt['skip'] > 0:
+        print(f"# {ksft_cnt['skip']} skipped test(s) detected. Consider enabling relevant config options to improve coverage.")
+
     print(
         f"# Totals: pass:{ksft_cnt['pass']} fail:{ksft_cnt['fail']} xfail:0 xpass:0 skip:{ksft_cnt['skip']} error:0"
     )
diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..531094d81f03 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -107,5 +107,9 @@ ktap_finished() {
 }
 
 ktap_print_totals() {
+	if [ "$KTAP_CNT_SKIP" -gt 0 ]; then
+		echo "# $KTAP_CNT_SKIP skipped test(s) detected. " \
+			"Consider enabling relevant config options to improve coverage."
+	fi
 	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
 }
-- 
2.30.2


