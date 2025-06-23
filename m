Return-Path: <linux-kselftest+bounces-35652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BEDAE5189
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0BD1B62C0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D0221D3DD;
	Mon, 23 Jun 2025 21:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IxTC4yEH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5674409;
	Mon, 23 Jun 2025 21:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714481; cv=none; b=dc58WZVN7QPLsejz6tHvlPNnt32TdB6B3HXTbzLA7yXdLM1AftxhTn1hVpsk7DU/1sh4SOBWQLFi7ebcGkv4IobONykgafWWsU+QHR3fdQI2MmeZEiN2qbK5D1tSB8AK3X51T06jeOdkSM20Ll0hYVmXcyfSgqIA0YwSCUbFB1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714481; c=relaxed/simple;
	bh=fXHjf5kAplja/Aqd3bJwXhrov/7KbAE7Wxegk3EDHTY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ute/5+06qIcm71XUZuIzCgqGFracm9bybl5ZlyYVd0e+E8DF370Fz6XZ/7pPTWiMsnt2wMfoPyEE3ooJ65iJ9oUzOWl7N0QOthZWhMtegj2vXuY6HG/QhLTpVnQK+4Yli88/qmlElDqxOgtaraj2oPWrvh7xNxaaxEQHpcq0trI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IxTC4yEH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750714475;
	bh=fXHjf5kAplja/Aqd3bJwXhrov/7KbAE7Wxegk3EDHTY=;
	h=From:Date:Subject:To:Cc:From;
	b=IxTC4yEHps9iwfFe8f2OUwpOKgAf3FN7ADfS1AfbGnS7gE/8r6/8u0ZS3i0YIjnR9
	 Ly/IQfFZlNzc7eoaZz3fklgQV/+rmM9evrN63oqNwBL3/wHEuPCxzBrx7bwc6hXZxC
	 XaDG/7Eebw815RR3Ucw1IDL1WZtqx0gK1LYaWfQA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:34:32 +0200
Subject: [PATCH] selftests/nolibc: avoid GCC 15
 -Wunterminated-string-initialization
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-nonstring-v1-1-11282204766a@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAGfIWWgC/x2MQQqAIBAAvyJ7TjDLor4SHdK2Wog1NCIQ/550G
 uYwkyBiIIwwigQBH4rkuUhdCXDHwjtKWouDVtqoTjeS/UnWFXC8A/Eu+w27oW+N0dZAya6AG73
 /cppz/gBIIPwvYgAAAA==
X-Change-ID: 20250623-nolibc-nonstring-7fe6974552b5
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750714474; l=1620;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fXHjf5kAplja/Aqd3bJwXhrov/7KbAE7Wxegk3EDHTY=;
 b=PW+Gb46lJlUdeywmmBMeOVRfIyUwBDjzRNypiJJ625eclLBSjV6LamIbyYcFa7Eyym0qTy3yI
 tD6Llp51gsdBamfCX8ufLsN3FPcqlHtxKR6haXb/IZ4bEaLo/FF3H8w
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

On GCC 15 the following warnings is emitted:

nolibc-test.c: In function ‘run_stdlib’:
nolibc-test.c:1416:32: warning: initializer-string for array of ‘char’ truncates NUL terminator but destination lacks ‘nonstring’ attribute (11 chars into 10 available) [-Wunterminated-string-initialization]
 1416 |                 char buf[10] = "test123456";
      |                                ^~~~~~~~~~~~

Increase the size of buf to avoid the warning.

It would also be possible to use __attribute__((nonstring)) but that
would require some ifdeffery to work with older compilers.

Fixes: 1063649cf531 ("selftests/nolibc: Add tests for strlcat() and strlcpy()")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dbe13000fb1ac153e9a89f627492daeb584a05d4..52640d8ae402b9e34174ae798e74882ca750ec2b 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1413,7 +1413,7 @@ int run_stdlib(int min, int max)
 		 * Add some more chars after the \0, to test functions that overwrite the buffer set
 		 * the \0 at the exact right position.
 		 */
-		char buf[10] = "test123456";
+		char buf[11] = "test123456";
 		buf[4] = '\0';
 
 

---
base-commit: eb135311083100b6590a7545618cd9760d896a86
change-id: 20250623-nolibc-nonstring-7fe6974552b5

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


