Return-Path: <linux-kselftest+bounces-14993-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE36794B273
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C965B20F8A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED196158D72;
	Wed,  7 Aug 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="q6VIE1wh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F1E15A4B0;
	Wed,  7 Aug 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067527; cv=none; b=r5PvLLzEezrcqBfDUV+u1x/imzSBXpZkuj9NiWeWprOgfAK6orHAdzujkwIMZbhyZcDPHvHzjFhkPKOlW4qg7WiPtGH8ACtpc6uvGbHSfXV4dnM0+7fMa2gP2+uPw5Y3ABmBLnAKKz/5B9EiMjOf0slrPqeP9BMIyBK8lM/Iao0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067527; c=relaxed/simple;
	bh=QNaY7kJFMuM3ZkGNIHxAYKHUdeofTLZIOkuPKOo4EXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k4B7rJMp8JfxeC00Rw2nwqO9ULcrCyvlIeNmpW70cWzzb+iuvX7phh71lwGMPOokIWJvzVngwKqMnl/O9xv92aCM8RJ+wKs8Fwua4pikFamS0vBfGcVORUdAkonW3dQ5c4PgBNm6gcmADr33Ciixut/NuXbcQvXugCaWsAjWPxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=q6VIE1wh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=QNaY7kJFMuM3ZkGNIHxAYKHUdeofTLZIOkuPKOo4EXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q6VIE1whSznrFdxsRqK0MYRIhpO4HMdfTemBTUHFdF7ZAPvUPssVvZm8IUtRydZmN
	 /V8+mAP1CaV5MvWDQLGjg4H8iz8MNCDL/CuM71swEv9VdNIR/6NQrcXjqbCCIEK5BB
	 nEEIgEMg4dtz5fIcg2OyRyTRwDIZ3JPmIQ7qiqLo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:50 +0200
Subject: [PATCH v2 14/15] selftests/nolibc: use correct clang target for
 s390/powerz
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-14-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1173;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=QNaY7kJFMuM3ZkGNIHxAYKHUdeofTLZIOkuPKOo4EXs=;
 b=yRql2CS1JaYly+HZvycEqBSi9NWWl/xm4ctiJUhHLAbiLSO5EWansfaH4XnPb5qdK2HdyKdXm
 7velTRzdn2NAjC8pEExFKk2dy/nzOrHYMtYoncnWxLtjs2wDReBi3zt
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The target names between GCC and clang differ for s390.
While GCC uses "s390", clang uses "powerz".
This mapping is not handled by tools/scripts/Makefile.include,
so do it in the nolibc-test Makefile.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f0ce8264baac..8de98ea7af80 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -167,6 +167,9 @@ endif
 # Modify CFLAGS based on LLVM=
 include $(srctree)/tools/scripts/Makefile.include
 
+# GCC uses "s390", clang "systemz"
+CLANG_CROSS_FLAGS := $(subst --target=s390-linux,--target=systemz-linux,$(CLANG_CROSS_FLAGS))
+
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("\n%3d test(s): %3d passed, %3d skipped, %3d failed => status: ", p+s+f, p, s, f); \
 		if (f || !p) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \

-- 
2.46.0


