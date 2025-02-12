Return-Path: <linux-kselftest+bounces-26484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB5FA32E11
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 19:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236741886CAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D4120E02B;
	Wed, 12 Feb 2025 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="brZyZlR4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21D7271838;
	Wed, 12 Feb 2025 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383268; cv=none; b=gIis5mEV2eL4X/WOKoAkiWIgGi/qmkx0svyDSAthGaLJqegADriuINKBw6M9Ud3hoknF0hgQ6lYdGw3JJ65rZrSr4e3Fg5hwo0I1/zrp3sl6i4Qh8NDyj+lBUt4VqnlK++hLavzYlAy9Rkq7sjhpsPPPo/6wvRIfvKV85K8gJDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383268; c=relaxed/simple;
	bh=tAxQY0eKt3wmeEo9qIBpZoK5Itd60oQWZnzbi12wCkk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SwTMgvz7DUlTVx5oxvu1807J6b/H3zahPm3CQ4tXiw0HZ/Oi2kmhBBiOCgCtmU34GEPywTrI8jrka3HyH5CjQ164eLrfKCcbTnAvZfV7imUeAYWui2oCYm25Ih7Wq4yRYJV6cCUYxNyE312IqBJMBuOAUTPwsoEcZqvf4L3EiFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=brZyZlR4; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739383264;
	bh=tAxQY0eKt3wmeEo9qIBpZoK5Itd60oQWZnzbi12wCkk=;
	h=From:Date:Subject:To:Cc:From;
	b=brZyZlR4TUNrd2NAuWjANL7iqDHqlvctb491o0VzVuE/9H62SRAD4Ltx3MXGb17zp
	 gFP2NkPg1m/yMVL9iUlcLR80urQHzpqdh3hhuMtqQECIWOdMBxA9V8UBPsabkOFVEy
	 iRRJ+1SOfoYxrM7w0em3ZUy7kMKLd3xqi1hUpJyo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 12 Feb 2025 19:01:01 +0100
Subject: [PATCH] selftests/nolibc: only run constructor tests on nolibc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-nolibc-test-constructor-v1-1-c963875b3da4@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIANzhrGcC/x3MQQqDQAxA0atI1gZMUIq9SulinEYbKDOSjFIQ7
 +7g8i3+P8DFVByezQEmu7rmVEFtA/Eb0iKon2rgjoeOiTHln04Ri3jBmJMX22LJhj33I03hQYF
 GqPVqMuv/Pr/e53kBLCA4uWkAAAA=
X-Change-ID: 20250212-nolibc-test-constructor-42491ba71a19
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739383264; l=1873;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tAxQY0eKt3wmeEo9qIBpZoK5Itd60oQWZnzbi12wCkk=;
 b=AzR36VL0Vrz/TfCVtLqV7MDcEZkm+7bEajuBkAhNWEWGhieuzRTM83D3psbu8BYkCKrdFWQl6
 Ol6Yufi4IosBr6SdDUandKn38N2BFOUI2VV/lsOGwCkx781FYlT6xl/
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The nolibc testsuite can be run against other libcs to test for
interoperability. Some aspects of the constructor execution are not
standardized and musl does not provide all tested feature, for one it
does not provide arguments to the constructors, anymore?

Skip the constructor tests on non-nolibc configurations.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 798fbdcd3ff8c36b514feb3fa1c7b8d7701cccd7..94db506eca906ff0ce8f518298dee34abf386484 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -738,9 +738,9 @@ int run_startup(int min, int max)
 		CASE_TEST(environ_HOME);     EXPECT_PTRNZ(1, getenv("HOME")); break;
 		CASE_TEST(auxv_addr);        EXPECT_PTRGT(test_auxv != (void *)-1, test_auxv, brk); break;
 		CASE_TEST(auxv_AT_UID);      EXPECT_EQ(1, getauxval(AT_UID), getuid()); break;
-		CASE_TEST(constructor);      EXPECT_EQ(1, constructor_test_value, 2); break;
+		CASE_TEST(constructor);      EXPECT_EQ(is_nolibc, constructor_test_value, 2); break;
 		CASE_TEST(linkage_errno);    EXPECT_PTREQ(1, linkage_test_errno_addr(), &errno); break;
-		CASE_TEST(linkage_constr);   EXPECT_EQ(1, linkage_test_constructor_test_value, 6); break;
+		CASE_TEST(linkage_constr);   EXPECT_EQ(is_nolibc, linkage_test_constructor_test_value, 6); break;
 		case __LINE__:
 			return ret; /* must be last */
 		/* note: do not set any defaults so as to permit holes above */

---
base-commit: 16681bea9a80080765c98b545ad74c17de2d513c
change-id: 20250212-nolibc-test-constructor-42491ba71a19

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


