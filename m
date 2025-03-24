Return-Path: <linux-kselftest+bounces-29710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E34A6E62A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 23:03:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C3E91892AF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Mar 2025 22:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8A91E8325;
	Mon, 24 Mar 2025 22:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="PVpdqEX1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241E518E75A;
	Mon, 24 Mar 2025 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853705; cv=none; b=ra2smAvn7IMrxWG8KQxICmyVnHokvQoBH4dhU/Xfi6Xq6nb51Rxqt1l3hWlRCM0xdJ1pPkSRW1LDz6ehBln2ZTxrGpocvkam6V+op64pyKjr/8NIc1UHL7X1EO9aLVUtizaDkY95UZPet/7tjd/zonB75t6ZrfQAcBUvCdtJGk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853705; c=relaxed/simple;
	bh=YzqdrLQFmw900gKmkqdoCcoT/1kDx0pVEvq0I7vYnc8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B4YEFKMKeBOIkO5F8YvyA88EOWfTo8TsDDcmfb7FzO5eSqIcrU/JavA6X8aWMieeGJ2cMkdyOdbrcWD+axVZ2icpZvpinm2Ecbavw1R7bH1xci9mO7q0y2UmayZ2w2rIA/SpcdpSrwvf3Fc0Uc5KoGb43/K/sS/VGjdhuBCAtrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=PVpdqEX1; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742853693;
	bh=YzqdrLQFmw900gKmkqdoCcoT/1kDx0pVEvq0I7vYnc8=;
	h=From:Date:Subject:To:Cc:From;
	b=PVpdqEX1cL+qGswZ2p6Ns8smf2GZtj5uJI1ZcFKcB5pmKVpkefe8joCGHkLMDT0ad
	 rxPe+FstMgK8R0nx4+DgZwU0RA5uRUsRXJZDC1QMLcgNmWRGung7mTd5bBICQs9G93
	 DZE5W8SgxViXCVx9CqgWLZutAEEc/ds1JEO8whCg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 24 Mar 2025 23:01:28 +0100
Subject: [PATCH] selftests/nolibc: drop unnecessary sys/io.h include
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250324-nolibc-ioperm-v1-1-8a7cfb2876ae@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADfW4WcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyMT3bz8nMykZN3M/ILUolxdQ1NTMxMzUzODJEtTJaCegqLUtMwKsHn
 RsbW1AA+RrZ1fAAAA
X-Change-ID: 20250324-nolibc-ioperm-155646560b95
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742853692; l=1117;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YzqdrLQFmw900gKmkqdoCcoT/1kDx0pVEvq0I7vYnc8=;
 b=ON8q9+3kEiJLby0+BZbFk94/DXye6ISRKTAp8DrUredPmbc1LVdxi8iBbFXV3FGRI3fYYDaCm
 8Nc0AaFInUJCdlbfk8WToC680ZctBHAhIFpxNYlIdm52VK2PYrOtKJJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The include of sys/io.h is not necessary anymore since
commit 67eb617a8e1e ("selftests/nolibc: simplify call to ioperm").
It's existence is also problematic as the header does not exist on all
architectures.

Reported-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 5884a891c491544050fc35b07322c73a1a9dbaf3..7a60b6ac1457e8d862ab1a6a26c9e46abec92111 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -16,7 +16,6 @@
 #ifndef _NOLIBC_STDIO_H
 /* standard libcs need more includes */
 #include <sys/auxv.h>
-#include <sys/io.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
 #include <sys/mount.h>

---
base-commit: bceb73904c855c78402dca94c82915f078f259dd
change-id: 20250324-nolibc-ioperm-155646560b95

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


