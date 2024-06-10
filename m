Return-Path: <linux-kselftest+bounces-11543-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14186901A51
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 07:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21C72820E7
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jun 2024 05:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A0422F08;
	Mon, 10 Jun 2024 05:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FfTpgH48"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E7C20B34;
	Mon, 10 Jun 2024 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998070; cv=none; b=qwAq1b+kQk5eVWQXqHZ/ttvnY6s3Q1gRTs1Twnpx7eTKH+/rZeJle9EZycUszg5gtLZsJmgoB3Prxss8iw6CMChL3StVvWMWylyUv4LRMx/DI//sM6JgTyoz8U6Ym+Jd+63V+VLOHn2U6zvLXhc1ICs1vT83K9SMl6ELnf+8wio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998070; c=relaxed/simple;
	bh=ipCczr7QYa5QI1mKS580Ngx2AkBjsXEeRuQtWBoAi+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qiQ/BJMAOGPMixLP5hH/gc+q23vyc6hT2pvntEgSM7TNW/CuittQNNCDoobPijCYyGOP+ojQaApQcxrzLBrbkT1oH/NXQBZwJrZpoLibCBABUV9rD1JeiRI8m7vWmeENGRF7b5koPnNlKbDFpulOJlRmv/Jl86DtLlsJ5WTaiWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FfTpgH48; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717998067;
	bh=ipCczr7QYa5QI1mKS580Ngx2AkBjsXEeRuQtWBoAi+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfTpgH48OTFMQWvJPP210pCXJj/fkW3rvBBFELUBcJntVuuHcLHDNM8huW5HjhDSN
	 J5ENl9mSdRNzTKqsBkZnLuoJPs/xYFncLucQRdQr2+6kOi5n99OiBh/8m2M/PfIzNY
	 4H434f15+WSGpytIIIbAB5HALnfiY6X46HeJFFGKi+EK2jlPxJH9m83uyhVR3SSTpq
	 y9nKR08fMYdB3tgsiJyS/Z8OrFStlKxgh9YW1A2PHaN6A/P75N3/q++Y8ewzREGYUR
	 GD+Jpkp/AKlfQbZxyipJFOfNc3XUciaeTxPKFM9rOLr95fMrjvcIPZ1acPEN5ZFk2P
	 SEMqGEZM1jRng==
Received: from deb.www.tendawifi.com (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8D296378217A;
	Mon, 10 Jun 2024 05:41:05 +0000 (UTC)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel@collabora.com
Subject: [PATCH v2 4/4] kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output
Date: Mon, 10 Jun 2024 10:41:29 +0500
Message-Id: <20240610054129.1527389-5-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240610054129.1527389-1-usama.anjum@collabora.com>
References: <20240610054129.1527389-1-usama.anjum@collabora.com>
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


