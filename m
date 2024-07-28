Return-Path: <linux-kselftest+bounces-14336-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42593E46E
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD928281BD2
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEE747772;
	Sun, 28 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="P+zDsOUO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27443BBD8;
	Sun, 28 Jul 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161421; cv=none; b=qXrFM7Egau0jmPibISc7wl93BwVmmfMmuHdL0S95gk39Z/Muc8iPwPlhNNQ9w8LwCJ8+zvlM0J7H7Sj/n7zWOVj+Ql3pdm0qo/bB7kXyRUyOtrR8QQSvbWAIZnlZu4nCrl0iUgX979DcsxX1eh3UEgFfxk8txJ9HrWHZebWkPyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161421; c=relaxed/simple;
	bh=HhxOZYqnzVx7tmwtHxKV0fQk9a2vX+belMUnjSiyOSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPYS4gGdGCt07XgfI4l4Dt38U1nfDP7UwCBW74TEZsTWeQNvRwbWgvoo9wiCD9wVC85hw7+/ibXwG+IombWa0CO4f+43RAE6F4ALi27/UFIUe3dZxqSCXPLfIEL47C51CGRDYFLLf9LwyrXxtXrW6UmUyQ8IW6rSy1edlfnH/gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=P+zDsOUO; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=HhxOZYqnzVx7tmwtHxKV0fQk9a2vX+belMUnjSiyOSw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P+zDsOUON7eKhnx0q3g+1vO9PxZHMTvZ7zJjQBpnU5QBV/2LifEOVa8mEBszjEOSS
	 X14rMGEP7FCta5thqtoKLd0iX1KTccP27UiwmYnDeJ8a9j3hNByaZbeMYzeBG0IYTn
	 IZ0V8pCnRHvI9NIAthlvPRpKZXdEp0hypm6dykKo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:09:59 +0200
Subject: [PATCH 05/12] selftests/nolibc: report failure if no testcase
 passed
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-5-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=1001;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=HhxOZYqnzVx7tmwtHxKV0fQk9a2vX+belMUnjSiyOSw=;
 b=K+mg+H91EkPWJuuw17d9UaczssIUxIFRcewKx9aTxpl+d1ev6E+Jn0ve1nqXUcTwI180K6HiI
 z6UYwJ6J+J1B6JSyGtiAU9sY8etY+ie2D9aPgX2Ng8BUv3Roj1k0Jh4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When nolibc-test is so broken, it doesn't even start,
don't report success.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 3fbabab46958..46dfbb50fae5 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -157,7 +157,7 @@ LDFLAGS :=
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
-		if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
+		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("\nSee all results in %s\n", ARGV[1]); }'
 
 help:

-- 
2.45.2


