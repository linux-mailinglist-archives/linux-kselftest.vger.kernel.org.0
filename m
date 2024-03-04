Return-Path: <linux-kselftest+bounces-5837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2057870658
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 16:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9E81F22D7D
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Mar 2024 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B17481B9;
	Mon,  4 Mar 2024 15:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="V/ymKtbU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4FC1B273;
	Mon,  4 Mar 2024 15:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567967; cv=none; b=sS1P2xgyUFweKoJS0LGBw3XbeVHuhhTLpE9afmtOEdThJReXymTTNRsVvmZ6f8x45s1dQ0wDFWSbEIzCBPrVRYzXI3MdKJZ/r8NnJDLG9bTBzNImCfAGHsl0Pw/bbEs7bSvZiwFJMayxlpqWj4m7DWJpsxCTo6yg2aNs3gC7zPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567967; c=relaxed/simple;
	bh=hDJ+1B+zZE31bqNelWnsX1xAb8MS/M4MyzfsBFhvn0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vj7XAAj9vrtj/odxcur8MjuD0z3FpYgmCc0076TFesbb69+47ioVeA1oDmNLl+b+qqjgjGcaosFgfgYvCFeri90oOzmcOVnHg29CcXr9Hq9kKf1gGzdBNTJoY/vfHwWp+Hmzye0zfYCaNyo/WUaz6GaNC9udO6FTdlr1y2seNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=V/ymKtbU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709567964;
	bh=hDJ+1B+zZE31bqNelWnsX1xAb8MS/M4MyzfsBFhvn0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V/ymKtbUVUuWevduols2PiqD0visrQxCth/3JhrOkjWaLAuxTr5rxoPzc3FBvSxZp
	 zZHjXYn4gPIAxXkAZ4z3X8GvHlVCUut1SeVVLiXMsxfaNyK5xD81+dcd/LYDCPkk5S
	 soBoo+MYi2+OG5twAke5IaDJFVqvc7p02lisrN4W9HWC4IPV7iX071RMrdUWEDTYWn
	 bwwgA3V8a4RBfVc6O7lcgJztC4PrQ1VjJqiR/Frlniw2jHhdekeGHKkZjOKwuS3aRy
	 Z31/kE+ikR8kxkOqG0sUPQ04iIXeV+4Gml/X3rEUn2PC2avw9wsu7uqrlH5pdUjFlO
	 nU2PAjOIIiVoA==
Received: from localhost.localdomain (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8644C37820CB;
	Mon,  4 Mar 2024 15:59:19 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Eric Biederman <ebiederm@xmission.com>,
	Kees Cook <keescook@chromium.org>,
	Shuah Khan <shuah@kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: kernel@collabora.com,
	kernel-janitors@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] selftest/exec: conform test to TAP format output
Date: Mon,  4 Mar 2024 20:59:24 +0500
Message-Id: <20240304155928.1818928-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240304155928.1818928-1-usama.anjum@collabora.com>
References: <20240304155928.1818928-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Conform the layout, informational and status messages to TAP. No
functional change is intended other than the layout of output messages.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/exec/load_address.c | 34 +++++++++------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/exec/load_address.c b/tools/testing/selftests/exec/load_address.c
index d487c2f6a6150..17e3207d34ae7 100644
--- a/tools/testing/selftests/exec/load_address.c
+++ b/tools/testing/selftests/exec/load_address.c
@@ -5,6 +5,7 @@
 #include <link.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include "../kselftest.h"
 
 struct Statistics {
 	unsigned long long load_address;
@@ -41,28 +42,23 @@ int main(int argc, char **argv)
 	unsigned long long misalign;
 	int ret;
 
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	ret = dl_iterate_phdr(ExtractStatistics, &extracted);
-	if (ret != 1) {
-		fprintf(stderr, "FAILED\n");
-		return 1;
-	}
+	if (ret != 1)
+		ksft_exit_fail_msg("FAILED: dl_iterate_phdr\n");
 
-	if (extracted.alignment == 0) {
-		fprintf(stderr, "No alignment found\n");
-		return 1;
-	} else if (extracted.alignment & (extracted.alignment - 1)) {
-		fprintf(stderr, "Alignment is not a power of 2\n");
-		return 1;
-	}
+	if (extracted.alignment == 0)
+		ksft_exit_fail_msg("FAILED: No alignment found\n");
+	else if (extracted.alignment & (extracted.alignment - 1))
+		ksft_exit_fail_msg("FAILED: Alignment is not a power of 2\n");
 
 	misalign = extracted.load_address & (extracted.alignment - 1);
-	if (misalign) {
-		printf("alignment = %llu, load_address = %llu\n",
-			extracted.alignment, extracted.load_address);
-		fprintf(stderr, "FAILED\n");
-		return 1;
-	}
+	if (misalign)
+		ksft_exit_fail_msg("FAILED: alignment = %llu, load_address = %llu\n",
+				   extracted.alignment, extracted.load_address);
 
-	fprintf(stderr, "PASS\n");
-	return 0;
+	ksft_test_result_pass("Completed\n");
+	ksft_finished();
 }
-- 
2.39.2


