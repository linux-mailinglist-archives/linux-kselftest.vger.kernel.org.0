Return-Path: <linux-kselftest+bounces-38120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A04DB176F4
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0A31C275F8
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3090C2550B3;
	Thu, 31 Jul 2025 20:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Fv1VotlS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A939B2441AF
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992808; cv=none; b=jAJpA3q6Fy2kepXNfbQuUtmTZyesUZe0YxiLHQYiYH1XtXYF7+0G/h/eUlAzRYR26PNVYXb6+US1LUg2kHEpBF6f7W+Oe1xxtmvkN2JZ8w8jPTOvdCWEcSboIDFeWC0UJeUfvBfFxfSzvnSfVUKEjbPIBbR4ws/7a8HwJO/0+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992808; c=relaxed/simple;
	bh=iEZPOjGVOc2TZQtFneBg13kt/wyiJeNZTE1+P6w5mjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrzFBL7m13OronbSjEtaCLHf3B7/d/3MCY5m0Jj22VpuuG9+Yk6kxGp99X/xqc+XffTXAaAPkJ7Ow6mXDafRM6LPlBRwolmn4bn4z+8NmMY7wo+DoHci9RX4vuW9VFoI7KnfLODua/5z96dOw0P1yaCgs2rqdpvmUQP9yEZuPaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Fv1VotlS; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8RB7EsB2byxPA7NhdGKEtox/u1UB/3BX+TUR1fK9/A4=;
	t=1753992806; x=1755202406; b=Fv1VotlSU+AvqA+VYgYEl5RxrSfjf9pkghRPd9btXlCazyv
	QMo499xSz9MS2VW7P1PVuPFFera8QAF3jzZuBeVs/P70pMEVyRp87ZGBSlIhqR6Rs5UEpJPwcWt5Q
	U2iTDEI5w2PzIDr9HBpC2F0xEMDjJFw7bqOWAjvyoi79V+NuD0ANl5+cEVDia0MK3/3ZtY2xgSH0W
	OFDRYeNdSuciFJhZ228tMj2aMKYk9TxjxWCSD0+U/Cv6pdLzoXqivrvAuOJkSXlosRKauXaSuV5hN
	DhZAA/GME3ueBWA3EKyfSfuYdLu5T0SpLJKE0keZJChTQRkXjuAHcy0DTg6EF3zw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uhZeV-00000001lJH-3ge4;
	Thu, 31 Jul 2025 22:13:24 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 2/4] selftests/nolibc: remove outdated comment about construct order
Date: Thu, 31 Jul 2025 22:12:23 +0200
Message-ID: <20250731201225.323254-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731201225.323254-1-benjamin@sipsolutions.net>
References: <20250731201225.323254-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The constructor order is not (and should not) be tested. Remove the
comment.

Fixes: a782d45c867c ("selftests/nolibc: stop testing constructor order")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 97efc98b6a3d..180f0436127a 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -686,7 +686,6 @@ int expect_strtox(int llen, void *func, const char *input, int base, intmax_t ex
 #define CASE_TEST(name) \
 	case __LINE__: llen += printf("%d %s", test, #name);
 
-/* constructors validate that they are executed in definition order */
 __attribute__((constructor))
 static void constructor1(void)
 {
-- 
2.50.1


