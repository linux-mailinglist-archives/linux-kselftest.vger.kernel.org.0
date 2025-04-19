Return-Path: <linux-kselftest+bounces-31203-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E72A942EE
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 12:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB4617C560
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Apr 2025 10:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EEB1D5178;
	Sat, 19 Apr 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="B8D/hyRD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74223594F;
	Sat, 19 Apr 2025 10:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745059592; cv=none; b=PMxweFThwn95/3V7zfJpeYiaxVRFaEi0bBQgRsiM65AnLuZ7Qx/9sSz4InTLbwCZ12oTKB9GI+i1Gsh10rMxFCr+qlLsCK5IT/91ZOGg04B25Pv44P91jvfLthmwBuhUvMp0d5VoXfYHm+24X02GTwxYWhIG/2fEmRExwcXUYnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745059592; c=relaxed/simple;
	bh=Fu/a9dHUfU/79QPTkLGEpbkvpxkUIMfawpy6A0iNqxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qf4ClpY11q6/lzfF8G/Nr6TGxlWrgPPC2kJ2BaetNrV4F9kzMF2nMKmk2bXIRSweEXU4Zb9fA+QuBqt6jZjRLcus2ucTcLCtoe7RWfRbcZEvu0eQJw04UuBBQEv7cqceVXU7HDz/MSZ+mWLJzNcK11sJGggfmTZLcrW4Wunsbu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=B8D/hyRD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745059587;
	bh=Fu/a9dHUfU/79QPTkLGEpbkvpxkUIMfawpy6A0iNqxY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B8D/hyRDOsOkP8ijENRJPFIbKNtaeiGbYOXpqY9mnBRDDgv6xDydXpFUXAjp1e3Ef
	 7M+/+X+BQurglBVGw44X0NEuWlkyE1RPLmEgJUwst8MwKguKWrmS0wcARtuLILIhBB
	 BE0TJwq9RgkURvOTEfQXGS9IHX7BXkPhRBfR/bHM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Apr 2025 12:46:18 +0200
Subject: [PATCH v2 1/7] tools/nolibc: add __nolibc_has_feature()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250419-nolibc-ubsan-v2-1-060b8a016917@weissschuh.net>
References: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
In-Reply-To: <20250419-nolibc-ubsan-v2-0-060b8a016917@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, "Paul E. McKenney" <paulmck@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745059587; l=938;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Fu/a9dHUfU/79QPTkLGEpbkvpxkUIMfawpy6A0iNqxY=;
 b=jZKxSVvJvzKwJPUpol2ww+N3g5hZzIzBox9BWKkrgbb2LCaxNULTCMMJrruB0yyZpsnwSRP1n
 nT9I9XG7QeYAtUbtRGHDttt+RIp1NFFaCuXiP5oX0qpnZE1pLZPkMOm
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Certain compiler features are signaled via the __has_feature()
preprocessor builtin.

Add a nolibc wrapper for it, similar to __nolibc_has_attribute().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/compiler.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index fa1f547e7f13d151ea98b9c585b36659d2d27324..e6d6dc116e43aa69b37eca02ed1590fc09486bdb 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -12,6 +12,12 @@
 #  define __nolibc_has_attribute(attr) 0
 #endif
 
+#if defined(__has_feature)
+#  define __nolibc_has_feature(feature) __has_feature(feature)
+#else
+#  define __nolibc_has_feature(feature) 0
+#endif
+
 #if __nolibc_has_attribute(naked)
 #  define __nolibc_entrypoint __attribute__((naked))
 #  define __nolibc_entrypoint_epilogue()

-- 
2.49.0


