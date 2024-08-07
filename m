Return-Path: <linux-kselftest+bounces-14988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758EE94B26A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1678D1F22DC7
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33610159598;
	Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OuSRhXuz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59E9155C8F;
	Wed,  7 Aug 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067526; cv=none; b=LXy9cm3yiqSjNSSrn+x2MYrJpFYqdOlYrn4oBYbB8Ri8ARwpBsCroN+kgWc17X5KzXS/eMaCjsR+6ruqoxREf8BIooqBs3WPaco1pf2czlm3wg8XWj/31ZdqIuXewNvXv9YIKKZMPpnjEjFHqvw+tDBMAEO27n5/2RH+uC6uPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067526; c=relaxed/simple;
	bh=8l0Dnz5Yd/S2UT/jNbx7vp2HyK4QJxhKjhlILkEgS5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r86BQBmcyY/MGZW2++dUhPs5ECO1TqspP4PnS3N7LKE6qe6lohHEZL5rNECoOBUA3/3Q8AaxekKe7159Jfl6FcFC3kqA88P4jQ+w29SD1WsB28qNqSV6zuKJr+ucvy/qKJk+5ocUK0zAYLQ/L2se6nv5gly/QHNuK8lDgc48Bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OuSRhXuz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=8l0Dnz5Yd/S2UT/jNbx7vp2HyK4QJxhKjhlILkEgS5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OuSRhXuzVjmlrXknPY08I2ptU6++PxRBBS91mNcZq7ogAGbfSZmXrE6v70Ib31B5s
	 NOPhX02Tzez3yGPO3aAM/zA3ky5kfmclFHMN1+KouE1xr1a2VCBdsj6mp1xAEhF1mJ
	 U+jOC2gbJWkjdDpQHn4op/vNbgMrXw5vGHhE8FMc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:43 +0200
Subject: [PATCH v2 07/15] selftests/nolibc: report failure if no testcase
 passed
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-7-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1054;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=8l0Dnz5Yd/S2UT/jNbx7vp2HyK4QJxhKjhlILkEgS5o=;
 b=YG//gAYehWzBTZAjqtDTQ5VQk1MvrVvaJIjYk32f6GxA0Twj8SycU/17qjKf0xNVO31sveDpx
 850wxVZhMsrD+kqMNTi2/rvmETJvh7S1cWLUnOs5Z1hwkHzx+yI70nD
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When nolibc-test is so broken, it doesn't even start,
don't report success.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
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
2.46.0


