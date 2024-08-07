Return-Path: <linux-kselftest+bounces-14992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8E894B271
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDA5B21023
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67B215B0F4;
	Wed,  7 Aug 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="brLJN4tG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F7156646;
	Wed,  7 Aug 2024 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067526; cv=none; b=EztrcYX68IPgMFoZkVmcfBZcNudxjpyJBhssE3URbuNKlKvMda/DINI1ndi2Zi3EwJeAzNidnMoBJ1iYwoquQtluK73/InNSfNPrdCSWK69tYsgwG4er+eBt055CwPnIlt4ajbujsKqcLesReWAxQOH93qO6398Zc6kuotm8sn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067526; c=relaxed/simple;
	bh=1QhxkVf3uYyMNNfNQNnEZrKfY/yCzs9TKeRStDwW9/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iVfV7dvV3PnR6ImgW0oMMSjLFSNSx/OZv/2ctSJZaa1ge91u7qyyKSbk9eWduGSaTkkTwGTV7bWhtjFlFLTbcv0clGr/VkQ4dC2HIkonWyGR208clBv7R6oeKC+PMHXTRzhreB/B9VL6d/hj7qUEtzouUBxGfEf/IUW3VOl4QDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=brLJN4tG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067510;
	bh=1QhxkVf3uYyMNNfNQNnEZrKfY/yCzs9TKeRStDwW9/c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=brLJN4tG7nuJcRo7F6gHXUxQxiQjfvO+AXjk9ztVT2xnZvcH60ussVRaEqWbVRR8U
	 0W6hGqD2vPLqDhkbcIokK71hmWxQbH5OYe3fCy364dPOMNqukQoyRQWPa+Sqqw1Q7I
	 G4AMtforlH8o4cg3abz82e2mUuBZ1xNes1yrpowg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:39 +0200
Subject: [PATCH v2 03/15] tools/nolibc: powerpc: limit stack-protector
 workaround to GCC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-3-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1020;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=1QhxkVf3uYyMNNfNQNnEZrKfY/yCzs9TKeRStDwW9/c=;
 b=jcxH1PjB1MjV0zoFCKqh0tGskIv4ZpblDDUXgw2mm1q0vOUwYSW+Uf9IkpmOnZO0cJUpt3VFo
 MFPki47281iDp1sEkACyBLB+Pq4ctoBVzGMddUz3YOkgVpKSyWZiW5n
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

As mentioned in the comment, the workaround for
__attribute__((no_stack_protector)) is only necessary on GCC.
Avoid applying the workaround on clang, as clang does not recognize
__attribute__((__optimize__)) and would fail.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-powerpc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index ac212e6185b2..41ebd394b90c 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -172,7 +172,7 @@
 	_ret;                                                                \
 })
 
-#ifndef __powerpc64__
+#if !defined(__powerpc64__) && !defined(__clang__)
 /* FIXME: For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
  * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
  * works with __attribute__((__optimize__("-fno-stack-protector")))

-- 
2.46.0


