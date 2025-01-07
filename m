Return-Path: <linux-kselftest+bounces-24008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEB3A04773
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 18:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34863A2286
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366171F427B;
	Tue,  7 Jan 2025 17:01:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5B1EBFE4;
	Tue,  7 Jan 2025 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269285; cv=none; b=E2jiVH6Q4zZrl34LtFJ6A5kbitC9yCEvN0L+SB0KWsBzaVytbVTFBq7HS3JG/Ed1u6v0tYE8iBQ+14bcu9ORysunMNUFAzD0HspToxzHjyBGbl+52954qJDHphEowntn6oCRzY9YVmTnBgl+gqSnSSaJed2Ns3wYn4jDO51CeS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269285; c=relaxed/simple;
	bh=wn82mFB2CWtaqZypR5OsrDmf9uqw228mGJzlo4dBzEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCLQ37SG5f2qtzo2hmPgH5wS5+yyLQIAPDv4wl3TV41iU/kqqfqRYl+YPcYixzkroGGlsONYvQRR/nH5uatLOn7tWwkGjxisWumS0TIRs5Z5C1dQSXBu0hS3x+2ZbOGQKDBEylPeIUZiat5j90jgMIdQYnkDSeQiB1WD6woYIh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53D5B1424;
	Tue,  7 Jan 2025 09:01:48 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1AD3A3F59E;
	Tue,  7 Jan 2025 09:01:17 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	aruna.ramakrishna@oracle.com,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	joey.gouly@arm.com,
	keith.lucas@oracle.com,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH] selftests/mm: silence unused-result warnings
Date: Tue,  7 Jan 2025 17:01:10 +0000
Message-ID: <20250107170110.2819685-1-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241209095019.1732120-6-kevin.brodsky@arm.com>
References: <20241209095019.1732120-6-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switching to -O2 when building the mm tests has the unexpected side
effect of triggering many unused-result warnings on certain distros
like Ubuntu, where GCC is configured so that -O2 implies
-D_FORTIFY_SOURCE.

Explicitly disable FORTIFY_SOURCE to avoid those warnings. This has
no effect on upstream toolchains where FORTIFY_SOURCE is not
implicitly enabled.

Suggested-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Hi Andrew,

Could you please take this fixup patch for "selftests/mm: Build with
-O2" in mm-unstable? Ryan found that building the mm kselftests on
Ubuntu yields a bunch of warnings, this patch suppresses them.

Cheers,
- Kevin

Cc: aruna.ramakrishna@oracle.com
Cc: catalin.marinas@arm.com
Cc: dave.hansen@linux.intel.com
Cc: joey.gouly@arm.com
Cc: keith.lucas@oracle.com
Cc: shuah@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: x86@kernel.org
---
 tools/testing/selftests/mm/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index fce194a92cad..d633d6b6a6e1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -36,6 +36,13 @@ MAKEFLAGS += --no-builtin-rules
 CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS = -lrt -lpthread -lm
 
+# Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
+# automatically enabled at -O1 or above. This triggers various unused-result
+# warnings where functions such as read() or write() are called and their
+# return value is not checked. Disable _FORTIFY_SOURCE to silence those
+# warnings.
+CFLAGS += -U_FORTIFY_SOURCE
+
 KDIR ?= /lib/modules/$(shell uname -r)/build
 ifneq (,$(wildcard $(KDIR)/Module.symvers))
 ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
-- 
2.47.0


