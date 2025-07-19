Return-Path: <linux-kselftest+bounces-37635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1464B0B0AC
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 17:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299571AA2B5D
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 15:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E182288532;
	Sat, 19 Jul 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="M1+62AlU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAA2877EC;
	Sat, 19 Jul 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939537; cv=none; b=DEfyzORFyVPIDXpkWOqq7tzpz8NzLo5QQ+2uFD9dkFSgbvIqrPEkftIh6WV2fEp6FAoTc1aFMRzhuNStsMWee01vL+LE1eTakdBEQTai+oYF0gfLiqpxJlPvp8TVGU/RMMv0FwctFsDhPveEp9ay2/tKrl9saMaHtO7Ee7i3ruw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939537; c=relaxed/simple;
	bh=6wjbJvAYhEr+Q1+vLoPhEwso9NtlBvkp222xuQek8xw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IRbdx8e+w1DkGfHU518+9lIBZltVCKNFZS896uPeemDwn4PJXFuGtfzwlYUJcAIX6gu9hYbzz98JWqhEFWSBDSatgCb0/jBmHEuiLbrwgFlj1t2Fc89BFazJZ6DY+EyPJLUfORLMbaZwMy23cxM/MiBsOBJp1GltQOMa2FwB7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=M1+62AlU; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752939527;
	bh=6wjbJvAYhEr+Q1+vLoPhEwso9NtlBvkp222xuQek8xw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M1+62AlUVMHzsQAg5cua9oKCMr1AhHz74iICiEjpiKvrJVHZiIlMJs7KRInwe0Y2T
	 JSCzRuZ1Sd+yoXN6I0lNmvDYEZ7nu5tUScuPdQuJBQNkpm9fKeKhfGhMR3F32Fjg4d
	 glEykmbjwcbirjJIMfD2b0BEg/SEz8RB36k+Fims=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Jul 2025 17:38:28 +0200
Subject: [PATCH 2/3] selftests/nolibc: don't pass CC to toplevel Makefile
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-nolibc-llvm-system-v1-2-1730216ce171@weissschuh.net>
References: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
In-Reply-To: <20250719-nolibc-llvm-system-v1-0-1730216ce171@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752939526; l=1063;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=6wjbJvAYhEr+Q1+vLoPhEwso9NtlBvkp222xuQek8xw=;
 b=iUmJdpPOCf9XJXCDnMPP0afmk0OVui6krQ1l7h7VmBNCQhuE3u+zTs1+anixDzdq9JoETg0A4
 VSuL2Xl7N9eBlmSHSVtn6DF2gQIXoKmLKKFPpEdRECm0xm8hTIPSFjo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The toplevel Makefile is capable of calculating CC from CROSS_COMPILE
and/or ARCH.

Stop passing the unnecessary variable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 8e7a832ba3f6da3ca0d669b941acd1cf79813a8d..6e6dddaa2e3ed56886cd76c423297648d13027c7 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -263,7 +263,7 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 		printf("\nSee all results in %s\n", ARGV[1]); }'
 
 # Execute the toplevel kernel Makefile
-KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
+KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
 
 help:
 	@echo "Supported targets under selftests/nolibc:"

-- 
2.50.1


