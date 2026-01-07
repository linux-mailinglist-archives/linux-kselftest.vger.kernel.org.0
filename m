Return-Path: <linux-kselftest+bounces-48419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4BCCFFE08
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 20:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4961D30221BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 19:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D9D34D4E2;
	Wed,  7 Jan 2026 16:49:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6D634A3D0;
	Wed,  7 Jan 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767804543; cv=none; b=hdmq63wBJHcCk+AG1yqXR10L06Dw5dXRrYlHaGHm3mO9C5XJaskPt8ze5j95TWqmiHrhH1YOKmMPnAOhxi5F8uAv5UataDPXl8TiO/frQF6xK94NUbFAu6qUZgTvJ2+aoS0ws4+A9J8ej0+J5SkJLKXScOJMmO9crlqePuW+KMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767804543; c=relaxed/simple;
	bh=ZNRxNFE32weRNSCQI7tMxuz6rq0DOTVV9Nj6X02kyMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGFGVvejFn+04gEGYxatp3n+fQzPd3o8U1biJhsAkjirzWRd6gGWsvWNh4YHtmf+v/qob8dcqvnMFyrFETFyvk4CTImvLMXm2Pytww6CEeBe4BvELpWgABRCyDKdSdOa2KoHuDtPQnVxX8IvzbMmZnP8upptMGrsu7H9ursecVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5ED81595;
	Wed,  7 Jan 2026 08:48:45 -0800 (PST)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 434633F5A1;
	Wed,  7 Jan 2026 08:48:51 -0800 (PST)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Mark Brown <broonie@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH v2 1/8] selftests/mm: default KDIR to build directory
Date: Wed,  7 Jan 2026 16:48:35 +0000
Message-ID: <20260107164842.3289559-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260107164842.3289559-1-kevin.brodsky@arm.com>
References: <20260107164842.3289559-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KDIR currently defaults to the running kernel's modules directory
when building the page_frag module. The underlying assumption is
that most users build the kselftests in order to run them against
the system they're built on.

This assumption seems questionable, and there is no guarantee that
the module can actually be built against the running kernel.

Switch the default value of KDIR to the kernel's build directory,
i.e. $(O) if O= or KBUILD_OUTPUT= is used, and the source directory
otherwise. This seems like the least surprising option: the test
module is built against the kernel that has been previously built.

Note: we can't use $(top_srcdir) in mm/Makefile because it is only
defined once lib.mk is included.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 tools/testing/selftests/mm/Makefile           | 2 +-
 tools/testing/selftests/mm/page_frag/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eaf9312097f7..bb93101e339e 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -44,7 +44,7 @@ LDLIBS = -lrt -lpthread -lm
 # warnings.
 CFLAGS += -U_FORTIFY_SOURCE
 
-KDIR ?= /lib/modules/$(shell uname -r)/build
+KDIR ?= $(if $(O),$(O),$(realpath ../../../..))
 ifneq (,$(wildcard $(KDIR)/Module.symvers))
 ifneq (,$(wildcard $(KDIR)/include/linux/page_frag_cache.h))
 TEST_GEN_MODS_DIR := page_frag
diff --git a/tools/testing/selftests/mm/page_frag/Makefile b/tools/testing/selftests/mm/page_frag/Makefile
index 8c8bb39ffa28..96e5f646e69b 100644
--- a/tools/testing/selftests/mm/page_frag/Makefile
+++ b/tools/testing/selftests/mm/page_frag/Makefile
@@ -1,5 +1,5 @@
 PAGE_FRAG_TEST_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
-KDIR ?= /lib/modules/$(shell uname -r)/build
+KDIR ?= $(if $(O),$(O),$(realpath ../../../../..))
 
 ifeq ($(V),1)
 Q =
-- 
2.51.2


