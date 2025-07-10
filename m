Return-Path: <linux-kselftest+bounces-36947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE13AFFF7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 12:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19C7564720D
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B902D9480;
	Thu, 10 Jul 2025 10:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bdmRjMzT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC3B2D97AC
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752144209; cv=none; b=S65aBDribA25E6hiJyUnjTOsZrdv2ogJrHL8zipmiRXSCCqC/W6Uu7O3fiWRRpLQzfFBNnfQ0PVE+ThswKEN8RQV25ICdn6FDkfM10WuF7vongKiqchW6kWJPGmZTmqOiolgf5aH6LRfnWY3zVUb2ZCDDBLEq2JRprbMz9NgY3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752144209; c=relaxed/simple;
	bh=Ughs5XEDmYMFiEdLwEEcutqAnHPoJ27e/mXTLJXX+BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0PUDoHwug6cDPz+ePIPfeudmyopztVr5IEx0ihjT2TW0TAnQdMkLdBo9eOEPcJbh4R5OoG6Yo31rf5M3tZBV30xHge0EAy3uK1G/FhuotVDGYfdonTSlHfalW0CufYkvLKwdpYvJ3oS8JF7w+4WUOlq/P7eYPor/nlnBsZf9NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bdmRjMzT; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=XVacv/cJmnq53svBWxmMoW966egifC4I/dvzdYXs6Hc=;
	t=1752144207; x=1753353807; b=bdmRjMzTGWlKa3zPRnA1LuOuhzL2bs96l5UwRHuNp16lTiH
	UsD2eNe9Mjbb+P7wqmgHiyI4d4nwxEeC676q+4oY9YTMUygj8wcmLGPHWJxDyzrn9YSrTa07f8as7
	yD0mOz0bZgfZFg6ys1lAtBUXlPNNj67kNODdRSXzndLTg56zhS1Ta2YzTPxN4XwhwlZHk0vPQhEsA
	5pOTlO9JqqcgxiW8BV6YR6EVFtUt9SvWRxzsLQFYkJaWNUFegVb/zW3/3HtIvTiu8YCy4vGpFa0S6
	y+RDtEFmlX/5p/aiBqKbyM1/zdzwAkhLNHuqzF3Dj425mm0iB+pBJ27xrlsxji5A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uZokF-0000000Eg4e-2CDe;
	Thu, 10 Jul 2025 12:43:18 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v2 1/4] selftests/nolibc: fix EXPECT_NZ macro
Date: Thu, 10 Jul 2025 12:39:47 +0200
Message-ID: <20250710103950.1272379-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250710103950.1272379-1-benjamin@sipsolutions.net>
References: <20250710103950.1272379-1-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

The expect non-zero macro was incorrect and never used. Fix its
definition.
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a297ee0d6d07..97efc98b6a3d 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -196,8 +196,8 @@ int expect_zr(int expr, int llen)
 }
 
 
-#define EXPECT_NZ(cond, expr, val)			\
-	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen; } while (0)
+#define EXPECT_NZ(cond, expr)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_nz(expr, llen); } while (0)
 
 static __attribute__((unused))
 int expect_nz(int expr, int llen)
-- 
2.50.0


