Return-Path: <linux-kselftest+bounces-22456-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B73709D619A
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42924160504
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C201DE2CB;
	Fri, 22 Nov 2024 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b="BTyJIPyt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33201DE2BD;
	Fri, 22 Nov 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732290953; cv=pass; b=ApKOnYNbCSHBhWvq8q2fADlBSKw0pRpQFkmQDndM6yVfvOSREvepeih4lqvCfaUin91+ZrwkbE0SADqBFLgpYBFFjq+7JE59Smj69vobaue+zN3tpQ1UuvSj4Kvb6E0tXJ7pflbmXqAYA5Ox3x+E+Tv4UBF5RFAFyMmEpg+7nZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732290953; c=relaxed/simple;
	bh=HSelt8aSaX3YoLZqFlscpVdWRA+Af8AxL1yTwR40tu4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MkXjbAAPbrFY6AjnjGOo0H2EyT34HI+vDkZcgC95f7cTsExuPMjNQrg5FyYEs+Z4A7kpnrwfokIO2syuNXaUWiI1v4Cx8n1o2fybOCNom/JM9fiGG2HvjDrCpr/oDBBtQ+YOdYEYMRk738Zp0bM0BHq1qsPHEBIomsNF/TAJ0Kg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=laura.nao@collabora.com header.b=BTyJIPyt; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732290938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VyKSHiwSl/dsFKvrdoS5PwBZ2uM945hktUdNPAWLS3AU9UbLwR8s1h8Ax1MQhrL8Isi1H3QdX5m5ppnkYiV+oJRBv7K4VOOsST4PXI3XdmudyNp9+WeuxsPdjfcdvaHjx1Bi+rZroLaNbiU4OXEZ0Ee1Bhy++z1sqr426xaxgoM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732290938; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CN5iYkj+rU7UVfSUIvfDcYnj0TR51dCXC7MGEbhtuiE=; 
	b=ltRenQUeZW7yBlB2/66YMcyawW4tKBuoR4yGuEqns4aP/lWbByr6DG67iH87Bp2GaD6CADITETV3lGw4OzJLR3CyBE5DWzi9ppFp5BOpxnWpr8sg7CLRpE+g82zKnUF2G9KWbku2NZR6BtZHXp7KAfCk/+XsscowNSXqY4yzIbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=laura.nao@collabora.com;
	dmarc=pass header.from=<laura.nao@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732290938;
	s=zohomail; d=collabora.com; i=laura.nao@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=CN5iYkj+rU7UVfSUIvfDcYnj0TR51dCXC7MGEbhtuiE=;
	b=BTyJIPytr+N4i5ZgFSCgkriwCxNR4W4ogng6MStFM1hWgbJdJ2ShUpss4F4qSDY5
	gGuolceFxM8ujyJ6kw5UHhkHCs6L/DrN07B752ZSJldNdOatkb/akkrYUkFL6ltSglP
	0PKBbxHDMDL3MhtVIqj7uZeKSAIaKjEYeZ8SkBbU=
Received: by mx.zohomail.com with SMTPS id 1732290936077450.0847135949839;
	Fri, 22 Nov 2024 07:55:36 -0800 (PST)
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
Subject: [PATCH] selftests: Warn about skipped tests in result summary
Date: Fri, 22 Nov 2024 16:55:48 +0100
Message-Id: <20241122155548.55495-1-laura.nao@collabora.com>
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
This patch follows up on a previous discussion[1] and aims to highlight
skipped tests for the user's attention.

[1] https://lore.kernel.org/lkml/2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org/
---
 tools/testing/selftests/kselftest.h               | 4 ++++
 tools/testing/selftests/kselftest/ksft.py         | 3 +++
 tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 29fedf609611..d3f64b333acd 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -147,6 +147,10 @@ static inline void ksft_set_plan(unsigned int plan)
 
 static inline void ksft_print_cnts(void)
 {
+	if (ksft_cnt.ksft_xskip > 0)
+		printf(
+			"# Skipped tests detected. Consider enabling relevant config options to improve coverage.\n"
+		);
 	if (ksft_plan != ksft_test_num())
 		printf("# Planned tests != run tests (%u != %u)\n",
 			ksft_plan, ksft_test_num());
diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
index bf215790a89d..7675a15a1264 100644
--- a/tools/testing/selftests/kselftest/ksft.py
+++ b/tools/testing/selftests/kselftest/ksft.py
@@ -27,6 +27,9 @@ def set_plan(num_tests):
 
 
 def print_cnts():
+    if ksft_cnt['skip'] > 0:
+        print("# Skipped tests detected. Consider enabling relevant config options to improve coverage.")
+
     print(
         f"# Totals: pass:{ksft_cnt['pass']} fail:{ksft_cnt['fail']} xfail:0 xpass:0 skip:{ksft_cnt['skip']} error:0"
     )
diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
index 79a125eb24c2..a4211221ccd6 100644
--- a/tools/testing/selftests/kselftest/ktap_helpers.sh
+++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
@@ -107,5 +107,9 @@ ktap_finished() {
 }
 
 ktap_print_totals() {
+	if [ "$KTAP_CNT_SKIP" -gt 0 ]; then
+		echo "# Skipped tests detected. " \
+			"Consider enabling relevant config options to improve coverage."
+	fi
 	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
 }
-- 
2.30.2


