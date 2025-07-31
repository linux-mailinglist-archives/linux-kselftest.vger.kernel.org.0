Return-Path: <linux-kselftest+bounces-38119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E40B176F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 22:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470F2165DF1
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 20:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69DC25486A;
	Thu, 31 Jul 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="WpZBy3mW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58311243379
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753992807; cv=none; b=OL05gIXrWoSmEKsHQIRaSrvJkk+Smj4nr9nygMD3JBWZlBOaZNuMZiJNEjh0ajCbmZ5SdkdTsKkErw70cX4H2ueN7R5phdL4FLywTxFdBl8olFB7wpha71eE+hjt8YspPAK1+IsGo3tuIXUYXYe9+glgyq7sFUGiJvdKPgpkl0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753992807; c=relaxed/simple;
	bh=Lz7yEMCmkOPbpP5H5SXhugvclYwulbbWZjlsy+66u60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zlvj2nYSSfHiONp6mmo/WeQbTLGgvi7pgi0J4UXEp8zzLPGEUeigcpaAYnYYNdt72DdY3mDDcvFAUrZy7xMmqpMa9M58zWOi/OHjuByBeSJjwy/YWh09pbVxr6JRq0mgBt2pCKyiFV3Qmq6FzkJcNBJ6I9y4/eQV7+RUNt4wsNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=WpZBy3mW; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=edR+oM4Nb8OeiGo6KwoDdDf6aqc2VHO40N4LLfSvHjg=;
	t=1753992806; x=1755202406; b=WpZBy3mWDe2ImTHnvvO1mif7EIYAvSWMxonux3GBW+OeA9f
	HgDEk77Xr1eMbcHGNyJR9PvoyfSb5Or7+VD3a2h5o0nuiNsB1sg/M6EnE88s2Bh7g+rymOKpVctc9
	nOhgVzFjPb+0YikGXMu8RTxpgwJ8XQpnvQ19161Etdg5hr9+WYvOgxi3DfCoi3J2oAgUcn1x93Ml5
	io+v5hQZ027nFvHOnhXQI8BLkZcOtyFwggdSnlSxt3ubNOkuMl15zrGIqMlNZqYKTrWVhElN3kwJE
	VFhz0sArbzK9yHyStUk9R9huYIDWs0q895Ei/IbKhjaGU8EfcHfQGr3+BV/QqAfA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1uhZeU-00000001lJH-3Q3c;
	Thu, 31 Jul 2025 22:13:23 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-kselftest@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH v3 1/4] selftests/nolibc: fix EXPECT_NZ macro
Date: Thu, 31 Jul 2025 22:12:22 +0200
Message-ID: <20250731201225.323254-2-benjamin@sipsolutions.net>
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

The expect non-zero macro was incorrect and never used. Fix its
definition.

Fixes: 362aecb2d8cfa ("selftests/nolibc: add basic infrastructure to ease creation of nolibc tests")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
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
2.50.1


