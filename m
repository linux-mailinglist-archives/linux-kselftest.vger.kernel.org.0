Return-Path: <linux-kselftest+bounces-33513-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 386CCAC1241
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E49A91798C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B2B19D8A8;
	Thu, 22 May 2025 17:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZKEEf2k"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040E19D88B;
	Thu, 22 May 2025 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747935558; cv=none; b=daiorWxZXfRu7y181baWzJ+JWdBILp9qhhW+nmsMf1gpmBTpM92Yqxnkbm4zMiGtCTdDpyVifxcG1GIczGjRxkwCz/gpXgZRMpLRiB7tkwxFOrPqnShN5YuRMSbsRjt1bulcFhay8HXZDCPucxqx87uxLmyekD+rboe5FyzDUtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747935558; c=relaxed/simple;
	bh=BfV3xzhjunrMLDK9cWHpUfmqXZar03TrfugoHRogF2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k98rzS79ueodBKEH2Xc1pVtwausI3X0HpWTRwOLi7rVR2p58smHVn1nrmYHe9lKs+zw6UopB7z2MzLm8C/RUfm3OvaX9+o6jFo6XBCtnGYpRhWpxEhu3X0pYsGKyGUFzbbHiKc84aKjgNElKrF1xE2mzr427tvcivvs04iTkBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZKEEf2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E770C4CEE4;
	Thu, 22 May 2025 17:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747935556;
	bh=BfV3xzhjunrMLDK9cWHpUfmqXZar03TrfugoHRogF2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bZKEEf2kmgWS8SMxr95A7OurYGQNSLzhSxXIghZQnB74rli2wfofyjQC3jbgcQCeu
	 4pjQmW3HdB/eOktv9Hcnk1gfqlPUU/Qs0irdRqh2Ia1EZuFH0kFwg0I/XimT0UAXjL
	 HCuJh8DFQ69SEddP5i6YVIAZcviw/Cex28eCMZqxxHQ3hXOQErZtiPTMkDrInzhMkO
	 ZK9JL58OumY4/UJ3EqQHAne8EEcLXEtndi/EfgblywYralx/2Zvz3O+bW9NpVPATyd
	 nj7BcRIep2wZ3nfdfPSmMBXpOHqyGwiYgScgBGztxzN+pKEOfMEaa4TRZBQZrX8giS
	 G0c3Zj/i2E8tQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 22 May 2025 18:38:51 +0100
Subject: [PATCH 2/4] selftest/mm: Add helper for logging test start and
 results
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-selftests-mm-cow-dedupe-v1-2-713cee2fdd6d@kernel.org>
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
In-Reply-To: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BfV3xzhjunrMLDK9cWHpUfmqXZar03TrfugoHRogF2k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoL2E7O39pUMyl3dQ+mcq8nzpDDPVlGvzoAqNsnaJP
 kuc1PSiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaC9hOwAKCRAk1otyXVSH0CxUB/
 kB2R1vX+3cCm7FLaenjY7igzq8Hh7eHaGLYXArBg5H571Am5bniAKcnivXRgPeUuVslt37mL8BuROS
 aaDyL+QKrMhKjy5Tr4coNZce7Xaw20QyvfWJvhXCkfyua9huedcQ3f7600VPcdanRDE6XwRfWZPDOQ
 08xWB22bzic4y41tqKHz1rNFI3BPQA7HmvMygneY/s/xZBnrKTAV7Q3t7yIbe22X5Uq//Av5zuhot9
 5rtiMactb/SJYZ2o2kKXaZAiY/vDuc91RVWZ7KwTfR4/V0po5rAAa8nwlRBfVD/OsPlV163UZJqc7M
 hDMGlXswISPftH9WB28hrR8BF/y4uC
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Several of the MM tests have a pattern of printing a description of the
test to be run then reporting the actual TAP result using a generic string
not connected to the specific test, often in a shared function used by many
tests. The name reported typically varies depending on the specific result
rather than the test too. This causes problems for tooling that works with
test results, the names reported with the results are used to deduplicate
tests and track them between runs so both duplicated names and changing
names cause trouble for things like UIs and automated bisection.

As a first step towards matching these tests better with the expectations
of kselftest provide helpers which record the test name as part of the
initial print and then use that as part of reporting a result.

This is not added as a generic kselftest helper partly because the use of
a variable to store the test name doesn't fit well with the header only
implementation of kselftest.h and partly because it's not really an
intended pattern. Ideally at some point the mm tests that use it will be
updated to not need it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/vm_util.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 6effafdc4d8a..4944e4c79051 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -3,6 +3,7 @@
 #include <stdbool.h>
 #include <sys/mman.h>
 #include <err.h>
+#include <stdarg.h>
 #include <strings.h> /* ffsl() */
 #include <unistd.h> /* _SC_PAGESIZE */
 #include "../kselftest.h"
@@ -74,6 +75,25 @@ int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 unsigned long get_free_hugepages(void);
 bool check_vmflag_io(void *addr);
 
+/* These helpers need to be inline to match the kselftest.h idiom. */
+static char test_name[1024];
+
+static inline void log_test_start(const char *name, ...)
+{
+	va_list args;
+	va_start(args, name);
+
+	vsnprintf(test_name, sizeof(test_name), name, args);
+	ksft_print_msg("[RUN] %s\n", test_name);
+
+	va_end(args);
+}
+
+static inline void log_test_result(int result)
+{
+	ksft_test_result_report(result, "%s\n", test_name);
+}
+
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */

-- 
2.39.5


