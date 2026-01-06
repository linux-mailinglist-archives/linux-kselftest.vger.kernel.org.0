Return-Path: <linux-kselftest+bounces-48286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AE1CF8262
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50AA83012770
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42625328243;
	Tue,  6 Jan 2026 11:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="KHU6zK7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87421327C08;
	Tue,  6 Jan 2026 11:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699903; cv=none; b=VxOUFtnhDQF9rdQot5fgwwQCZ4R3MNinyXsFB/xCFTq/aTus/X2Q5FPYMzaTawj64DYGkoiDrV0L/NAYyX580zMFe/pRfueiG4Vq1J7E9oHZEgiOil3IEG14GpHVHzAJG273qREc0ybl874s1eTNvRLs3hpM0aMZVj92RRGI5EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699903; c=relaxed/simple;
	bh=RxxB6NV9if6awA3P4aQd3C0EaaKp6EItM45W9RNOxYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIQuCMyux2oMTpiZN3rXb/+2Nu96wkJt7Kw4ejMaaankqn1lmlmFaQbzvfmYWTXtE1THiO1S/m26ZcyXJrzoW3UnwWFp6bNLRMJhE0DdpbrNeKL12EwlLJoRfiaaWbC/23BIMrLpfwqmBkGMpJQw69ns0LYL1Faz+YBBKSarNPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=KHU6zK7r; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767699898;
	bh=RxxB6NV9if6awA3P4aQd3C0EaaKp6EItM45W9RNOxYs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KHU6zK7rg9vm0WqhR8Sc6Ts0ZRphdHSmg4kLNjlAL5d19xbiUnDRJhpmA8cmx3aq3
	 +tnHRusVgyuGbvK7SifmmYPp2tBVoTskYTu871zLbGn0LoO3aeo2hmMMvjl5kHIJj+
	 k20EVMiz5PYM/g9w3FprQ4H8M+2vbMIQaB876GbM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 06 Jan 2026 12:44:58 +0100
Subject: [PATCH 2/3] selftests/nolibc: scope custom flags to the
 nolibc-test target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-nolibc-selftests-v1-2-f82101c2c505@weissschuh.net>
References: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
In-Reply-To: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767699897; l=1021;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=RxxB6NV9if6awA3P4aQd3C0EaaKp6EItM45W9RNOxYs=;
 b=nL5JUcNnomQNt3EK+oYGHT6f+IGwg+8M+nF3OXhkJ+SMywgPd0GbKEKJ9p1rXeLX79pbkRUXt
 SVLneCL91okDwFutXqSDkzegRi42xexj2YlG2ArrRbrY2xPO+SIc1H4
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A new target for 'libc-test' is going to be added which should not be
affected by these options.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 40f5c2908dda..43f0b608c796 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -9,14 +9,10 @@ cc-option = $(call __cc-option, $(CC),,$(1),$(2))
 
 include Makefile.include
 
-CFLAGS = -nostdlib -nostdinc -static \
+$(OUTPUT)/nolibc-test: CFLAGS = -nostdlib -nostdinc -static \
 	 -isystem $(top_srcdir)/tools/include/nolibc -isystem $(top_srcdir)/usr/include \
 	 $(CFLAGS_NOLIBC_TEST)
-
-ifeq ($(LLVM),)
-LDLIBS := -lgcc
-endif
-
+$(OUTPUT)/nolibc-test: LDLIBS = $(if $(LLVM),,-lgcc)
 $(OUTPUT)/nolibc-test: nolibc-test.c nolibc-test-linkage.c | headers
 
 help:

-- 
2.52.0


