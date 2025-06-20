Return-Path: <linux-kselftest+bounces-35466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF64AE2431
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 23:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A071F1C218F3
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 21:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ACC23D282;
	Fri, 20 Jun 2025 21:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DsKhrjJV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B5A23717C;
	Fri, 20 Jun 2025 21:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750455590; cv=none; b=Tm7ZDP55RVevOP3cj9oZPId6oQ8g1YQstjcxtedsfVfFUE+awQj6DQDAaf2R7p4AMi15eL3vPD9iIQgCcyFCoYRgoasnykS+UyqkqNk8Km5Fxv9Uxl2Lj2Vw2M0xBmjYCGhkkl1OSCkqtq5jH9VOpxmrKXsd8ebFT3gGTB27DrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750455590; c=relaxed/simple;
	bh=muvONxb2wPgiwglaesqALOnMRz4u14VQeWzPjdB/Kxo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oN+nkYXzNX87vPlNRvUTyJL2IMjuyMyw9FYFyVUv+0al/wmNOlZFNvuX+IAc3lpzsMAT5e1IUqj2RF269SxB7fEA+kE1ouqGv5VVkYfKSl8fpcUoBAWwru+W8bvWWQaPvLDbV36mdd4Q/caW9DcEYIda7fBT2an1A0CKT3h8cbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DsKhrjJV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750455579;
	bh=muvONxb2wPgiwglaesqALOnMRz4u14VQeWzPjdB/Kxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DsKhrjJVQCqePvtRQASrU9cE6/lQSlIjeZP4CGiIHc+uWMiwWK9+Yi8aEFSrEZvRW
	 /hd5NHBDNE9rgOMq6gAtaUrYdbOFxOwtxLSY50Zd8h2TYYI3FJr1IJF4tfJ/Ax3G7p
	 k9jBCNnNgqdlnqw1LYZynJeckmwG6O8EjivmBE6U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 20 Jun 2025 23:39:32 +0200
Subject: [PATCH 3/4] selftests/nolibc: rename Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250620-nolibc-selftests-v1-3-f6b2ce7c5071@weissschuh.net>
References: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
In-Reply-To: <20250620-nolibc-selftests-v1-0-f6b2ce7c5071@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750455578; l=1615;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=muvONxb2wPgiwglaesqALOnMRz4u14VQeWzPjdB/Kxo=;
 b=aDlqUmSlmo5eRGJOlLK6yeUEVneC37p0I83yh78sFEvH1yj0JsrZXGSlHRxOeVsRK+tj0IXIm
 GDkqmvJDDYICFDgpoliKaYv33cP1s1+qB7Na3vlq31fZ3h3wzrLKKSf
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The nolibc tests are not real kselftests, they work differently and
provide a different interface. Users trying to use them like real
selftests may be confused and the tests are not executed by CI systems.

To make space for an integration with the kselftest framework, move the
custom tests out of the way.
The custom tests are still useful to keep as they provide functionality
not provided by kselftests.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/{Makefile => Makefile.nolibc} | 0
 tools/testing/selftests/nolibc/run-tests.sh                  | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile.nolibc
similarity index 100%
rename from tools/testing/selftests/nolibc/Makefile
rename to tools/testing/selftests/nolibc/Makefile.nolibc
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 8277599e6441a933d9c1ec5003acf49b06df226f..279fbd93ef70497868689b7f1e14ddc6c5c1a15f 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -169,7 +169,7 @@ test_arch() {
 	if [ "$werror" -ne 0 ]; then
 		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror"
 	fi
-	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
+	MAKE=(make -f Makefile.nolibc -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
 
 	case "$test_mode" in
 		'system')

-- 
2.50.0


