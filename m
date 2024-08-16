Return-Path: <linux-kselftest+bounces-15522-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB3E954DD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 17:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73FC41F25254
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212121BE226;
	Fri, 16 Aug 2024 15:33:03 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738851BD013
	for <linux-kselftest@vger.kernel.org>; Fri, 16 Aug 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822383; cv=none; b=p+UGjKC+s1GOKfJZgwrxaHSyh3DOxyLXmNe0RYa96DIYprboHpCkRaPw1lFm15goT/6KV/iTOF1bvdcIXdlNRBKDo1wM3+8E9HBHQnhl/Fkn1UbTB6ZxCsVrjuTO8U0WsVOgqpRhTBFGuEOsVPXaoTe8cFl22aumFqSPUTWe3Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822383; c=relaxed/simple;
	bh=AzHoy3SOuCwiovEr4Jq2DsZOL87U0tXHKSqU02GMaAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BG1mwHJEJuDGN98c0e7RADe204S+k+tTwAz49O//NeZWJTr2yUA5qZijLTj4u0K9eqde1WM59P/wpdlcul8GmKzBcZPNNb5dl9O02wPQ12vDUiGX69Wq1uskA6Lw2lvH92ii19ataNO3GuY1AEAxLfh/KDq+3/AuKQSOLraHo3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67886143D;
	Fri, 16 Aug 2024 08:33:26 -0700 (PDT)
Received: from donnerap.arm.com (donnerap.manchester.arm.com [10.32.100.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2457B3F6A8;
	Fri, 16 Aug 2024 08:32:59 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Amit Daniel Kachhap <amit.kachhap@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/8] kselftest/arm64: signal: drop now redundant GNU_SOURCE definition
Date: Fri, 16 Aug 2024 16:32:44 +0100
Message-Id: <20240816153251.2833702-2-andre.przywara@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240816153251.2833702-1-andre.przywara@arm.com>
References: <20240816153251.2833702-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The definition of GNU_SOURCE was recently centralised in an upper layer
kselftest Makefile, so the definition in the arm64 signal tests Makefile
is no longer needed. To make things worse, since both definitions are
not strictly identical, the compiler warns about it:
<command-line>: warning: "_GNU_SOURCE" redefined
<command-line>: note: this is the location of the previous definition

Drop the definition in the arm64/signal Makefile.

Fixes: cc937dad85ae ("selftests: centralize -D_GNU_SOURCE= to CFLAGS in lib.mk")
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 tools/testing/selftests/arm64/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a2..37c8207b99cfc 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
-- 
2.25.1


