Return-Path: <linux-kselftest+bounces-14980-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5962D94B25A
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7331C2108B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D2D153BE4;
	Wed,  7 Aug 2024 21:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iQC3gS1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71792144D01;
	Wed,  7 Aug 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067521; cv=none; b=knnMIgOWUqi5dvombLXPVePAKG6HA7GqBGCPZQH2V7Izx2l6TgOXAbhwJJrAhGQo6qmFwDK0XClxx1Pt4RrFO2zfJTj0SXJEpYnva6mkr1ZnlP73wg6GsMLjWY7x7E6MJTECNV/4520aEFcckZO7rTIPuU6JPAD6pJZKjmJ8KO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067521; c=relaxed/simple;
	bh=0xwKwk4W4ON043PDHhYy4/zTEWhwuDykJCYQwDWzNPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbFvO4Mt+lzss6K0aWGYZ0gWhi8VHy0D89xXcvF5oNlmDkSHm53GpvI0a7Uu8RivIJrCsVDJYzw83ctmIOiSXL5taxzGxJ6m7wjzFFuom/u2Qut9FHlwuwlf3n2BaWnqSUi3BfQw41xLwrYsbUt0hSWY/utQUkBAsffiyctFI9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iQC3gS1g; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=0xwKwk4W4ON043PDHhYy4/zTEWhwuDykJCYQwDWzNPQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iQC3gS1gBCZpbFQu2FMqgFKxQ6Fo8bc7wolEfv93c/Y5l9IbGV3IChvQ80bHXAOdY
	 OL6ruHTS/JHDXQMjSfl1KNnTd5Y+LPkBENT0h8CiGW7xM8eAZq+eFm6nfnJpAahJ5w
	 JvSvJJzbQxisTrL7Wy+lJeQo1OngrI9RgC4jejZA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:38 +0200
Subject: [PATCH v2 02/15] tools/nolibc: mips: load current function to $t9
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-2-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1345;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=0xwKwk4W4ON043PDHhYy4/zTEWhwuDykJCYQwDWzNPQ=;
 b=xN30aahPcj2gQmFgfOB4sY+Er7K5/CDGgL5RksagY7oNvWXVoDXrYw79rBGWZQ38VG8Z/qaIU
 cbNrnjfZHjGDN0R4o+37G35Ry70sFoAPTwV7XoMBnJUbJ3hJjhO6rs9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The MIPS calling convention requires the address of the current function
to be available in $t9.
This was not done so far.

For GCC this seems to have worked, but when compiled with clang the
executable segfault instantly.
Properly load the address of _start_c() into $t9 before calling it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-mips.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 62cc50ef3288..a2ee77ed2fbb 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -194,7 +194,9 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"li    $t0, -8\n"
 		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
-		"jal   _start_c\n"       /* transfer to c runtime                          */
+		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
+		"ori $t9, %lo(_start_c)\n"
+		"jalr $t9\n"             /* transfer to c runtime                          */
 		" nop\n"                 /* delayed slot                                   */
 		".set pop\n"
 	);

-- 
2.46.0


