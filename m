Return-Path: <linux-kselftest+bounces-31202-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D41C0A942ED
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 076D43A77B3
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F23F1D432D;
	Sat, 19 Apr 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rBTkcQHb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CAF6F305;
	Sat, 19 Apr 2025 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059592; cv=none; b=Tym0/fno7q1P3e+J9kF6kARRo0bSGEsmbH+HQHfBztE5pwy80+xR+CiMNPLb9SNFRC+oWctyfY7hdCoI1fVeZ8phRHxn+Mrv9ETZfV/zOK9O3lHQWLQXPmc5AmWPE+4ymFSnhWLomnyNz54FfEcaz1vATVi+b9lVSIJnj+R8Iac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059592; c=relaxed/simple;
	bh=KobCUeJS2OEM5lPwozYg0JTzSnTraZcO9O3oDYtCUhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aR/CeOgzVQ+xQamhZChn8Ysf237C00e+MFOH9oHDkPqTtaC846TTplRMsQzSMf+tLWu2jk6OLgFe3oWmnhFKaMT6V6OJ3j+wHbGnpDr1I3ZT5hDpaOUqo2nb0/XNNjqZDAESuvDPbFtP/7SVcZDxTBA2QbdlpCVnZj6V1qdt6uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rBTkcQHb; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059588;
	bh=KobCUeJS2OEM5lPwozYg0JTzSnTraZcO9O3oDYtCUhI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rBTkcQHb8lkVzHhG9XDJRHGDK4+0Q7wUdSUzRvO+/WWD2Pk/XtnkYWDri6SoSlyIt
	 /uV8K4IMyrLTxvwSt6ZMLdan7sFebHwnLdxbuWiEm2XrDfmqcBokuG1MspyL77oNGm
	 MeSrGa/09fX8ei82TJURoX7wzLn9UAgTv8s4PV/4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Apr 2025 12:46:23 +0200
Subject: [PATCH v2 6/7] selftests/nolibc: disable ubsan for smash_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250419-nolibc-ubsan-v2-6-060b8a016917@weissschuh.net>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=736;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=KobCUeJS2OEM5lPwozYg0JTzSnTraZcO9O3oDYtCUhI=;
 b=aTcG+XP2wsZflP4N2plzIKE1ncwCU+vNw2Ru1zEyu3v9UOkFjJ3uWddAb+bhWm5LKc2+40T4N
 X5Hz/NPuZT/AOChjxHY7B4WDDPLDKT2MAWzkHqsy86AR9FZGeYB1hX9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

smash_stack() intentionally crashes.

Prevent UBSAN from tripping over it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7a60b6ac1457e8d862ab1a6a26c9e46abec92111..b176a706609b7641dd1d743c8a02b6b6e7a4c746 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1438,6 +1438,7 @@ static int run_vfprintf(int min, int max)
 	return ret;
 }
 
+__attribute__((no_sanitize("undefined")))
 static int smash_stack(void)
 {
 	char buf[100];

-- 
2.49.0


