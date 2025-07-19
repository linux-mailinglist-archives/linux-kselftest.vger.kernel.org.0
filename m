Return-Path: <linux-kselftest+bounces-37636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65832B0B0AD
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9BADAA6AA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 15:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE31288539;
	Sat, 19 Jul 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WVtI9GZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB7F2877EE;
	Sat, 19 Jul 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752939537; cv=none; b=pyk3YaWY0Bcp+IKJoJxGhNhD36FX5WEQdHDfDDElNPbL2O7zes4HGvBDpPifiTTy9N5JIjnND66khBI3//h0mQiKNQ+/O6XcFi+DcQrMO1kQE+vqqSJPrMcHXOTitsv1ME7c9SoURTXwvtJlSFq2YGFnu41f3OM3KRBt/ZwK28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752939537; c=relaxed/simple;
	bh=51GkrVrQpjPfvvJr3LapBWVH8+FIFYkaT062gxrS96I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBmbnSi1KX5eQJDnqP7w23oOjYDXV/9OX20tzzMLPSSj3OYCQ2yERVGg19v1cUi0LSc5mER77ezSuhadBST3/4h+XNPdsfKzFlflHiqso5XuVaA3KM5DtKXXGQr9tO7HoK2ag+CuOP2SDfW00/brqzKdzr60kD4DgxE7iy8yPaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WVtI9GZY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752939526;
	bh=51GkrVrQpjPfvvJr3LapBWVH8+FIFYkaT062gxrS96I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WVtI9GZYhsNpCZV/Cgg8eE7tgSuYjabUaW6lyLIS/v92QbaJFV/2FNnvHDrYwVkcG
	 yioU/3HcMnzGsIlaxW40bBR30+/9sb1nICi21tzsXtVhqxEns2advXeQ/9zQHxUgEN
	 OFkdfjRGZDztG3XLAgZsqrV9B04a2ZuC/j/q0VFQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 19 Jul 2025 17:38:29 +0200
Subject: [PATCH 3/3] selftests/nolibc: always compile the kernel with GCC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250719-nolibc-llvm-system-v1-3-1730216ce171@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752939526; l=1288;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=51GkrVrQpjPfvvJr3LapBWVH8+FIFYkaT062gxrS96I=;
 b=BRqqIxDJNQdSvuWhzuAvv++iXFFsb1KwrMKiT8bWI8nXvZwVhxwcGPJOIn8Ry8DkCynnALEcu
 rwqRwA6kxhDBHkv+uuQnvLcytH6hZ3eskUoIYw4adK3VZ0jFevyjRNi
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

LLVM/clang can not build the kernel for all architectures supported by
nolibc. The current setup uses the same compiler to build the kernel as
is used for nolibc-test. This prevents using the full qemu-system tests
for LLVM builds.

Instead always build the kernel with GCC. For the nolibc testsuite the
kernel does not need to be built with LLVM.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 6e6dddaa2e3ed56886cd76c423297648d13027c7..3d8e314c2433a2d032cf4f58ea1d6a2f430faaae 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -263,7 +263,7 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 		printf("\nSee all results in %s\n", ARGV[1]); }'
 
 # Execute the toplevel kernel Makefile
-KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE)
+KBUILD_MAKE = $(MAKE) -C $(srctree) ARCH=$(ARCH) CROSS_COMPILE=$(CROSS_COMPILE) LLVM=
 
 help:
 	@echo "Supported targets under selftests/nolibc:"

-- 
2.50.1


