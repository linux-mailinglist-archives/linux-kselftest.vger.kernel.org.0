Return-Path: <linux-kselftest+bounces-10825-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5A38D2E26
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 09:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40EFF1C23EA9
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 May 2024 07:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEF7167D82;
	Wed, 29 May 2024 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RDECX0O5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAF5167275;
	Wed, 29 May 2024 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716967581; cv=none; b=ZT/GgQUxsjvsQGLgY1i+9qFAzUW/kB668UqqiGtQURwvJPZwekOLd9wPJlqwCiCnxJ3+EYA+sDsn9xGHNdtsqqgQ7V9iER4A8rbjqDoRIN+MpXGKzpp+EnmhiHGAzar4svVYoFYEpY6KaHzmhlc+V4SHm5GVDE361AXyQ2cuF1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716967581; c=relaxed/simple;
	bh=ipCczr7QYa5QI1mKS580Ngx2AkBjsXEeRuQtWBoAi+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqzXgFl0BDgavc3gNUmZv4zk9bpWlsisrJ68GlT4kgPZJnOUoxEqsY32uQTXA9WHTBf5flq4UxZQS+tBRq4LoP4VpAjHo1GdK1rjShBblLoThlEhtYTOY+VWwfYiK/nbkF7iC1XaLZ4eF93MxHWnuIyNng6lMJeFiEaPHtsoSRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RDECX0O5; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716967578;
	bh=ipCczr7QYa5QI1mKS580Ngx2AkBjsXEeRuQtWBoAi+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RDECX0O58siFle7LkoL209kMCVijbPKqGvWaKxXoOBV1PmGG97MQmlCV9esT0gX7u
	 tG37/YzNryU+7kDgrFY6ZZiGEF6s7ih1RKltpxfJl36/UtKo1lS8JDT6ebMWU7wuVX
	 YVe4/zPXzYpK/9keiT4rU2Euj5P7WL+JWYIve/qUE2EL7dzlh59LVR8X8LDwSrfFAJ
	 xwIK4N/xFqGnh0XXfsjBF1JxvBG8a1QzCV29m1vn2DCgSMvYPSC6voTnPYldYz6qVD
	 fV7NNxciXCF+nrBkp1WdTNzMPf9qge9TYyxljXyoA+bFSe/jMAqfRd69RAsEXUFymH
	 pQODu9XtDjtsw==
Received: from localhost.localdomain (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3F78B3782162;
	Wed, 29 May 2024 07:26:07 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH 4/4] kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output
Date: Wed, 29 May 2024 12:24:54 +0500
Message-Id: <20240529072454.2522495-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529072454.2522495-1-usama.anjum@collabora.com>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
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
 .../selftests/vDSO/vdso_test_gettimeofday.c   | 23 ++++++++++---------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
index ee4f1ca56a71a..2f42277b29ffe 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -24,10 +24,13 @@ int main(int argc, char **argv)
 {
 	const char *version = versions[VDSO_VERSION];
 	const char **name = (const char **)&names[VDSO_NAMES];
-
 	unsigned long sysinfo_ehdr = getauxval(AT_SYSINFO_EHDR);
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
 	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
+		ksft_print_msg("AT_SYSINFO_EHDR is not present!\n");
 		return KSFT_SKIP;
 	}
 
@@ -38,20 +41,18 @@ int main(int argc, char **argv)
 	gtod_t gtod = (gtod_t)vdso_sym(version, name[0]);
 
 	if (!gtod) {
-		printf("Could not find %s\n", name[0]);
+		ksft_print_msg("Could not find %s\n", name[0]);
 		return KSFT_SKIP;
 	}
 
 	struct timeval tv;
 	long ret = gtod(&tv, 0);
 
-	if (ret == 0) {
-		printf("The time is %lld.%06lld\n",
-		       (long long)tv.tv_sec, (long long)tv.tv_usec);
-	} else {
-		printf("%s failed\n", name[0]);
-		return KSFT_FAIL;
-	}
+	if (ret == 0)
+		ksft_test_result_pass("The time is %lld.%06lld\n",
+				      (long long)tv.tv_sec, (long long)tv.tv_usec);
+	else
+		ksft_test_result_fail("%s failed\n", name[0]);
 
-	return 0;
+	ksft_finished();
 }
-- 
2.39.2


