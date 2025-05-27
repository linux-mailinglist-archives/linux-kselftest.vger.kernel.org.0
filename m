Return-Path: <linux-kselftest+bounces-33880-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5A3AC52C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF5F93AF8CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 16:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B5227F72C;
	Tue, 27 May 2025 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lcFiSLrc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3272CCC0;
	Tue, 27 May 2025 16:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748362402; cv=none; b=RBqxFr/0vsyHHGMsEt62/T0kPv2ZuLeck0hxG0fxv2F8gLl9nYjzTZEzWxO5rKbt3UpDhdl2kLmqtVZyhD+PPG+N2IwngqcgXxcV9fuBpuJjuaFeUtCpQicYqSYaEnY12EXFqXmt7IlCOlp49WVqbnPKdpWT3gKu7tEBXbACP4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748362402; c=relaxed/simple;
	bh=BfV3xzhjunrMLDK9cWHpUfmqXZar03TrfugoHRogF2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eOEoEtbTCvYLCvOn/BLH9JfVUKVHMgFeDRKfhuOY70+c2BeswCjnQg3SUHS+JKqFJdbKM9TukziD35zfLvG0k7f3Omvsq0O3PyGVBJR9f6U6wV5D47uk+Tu+K4aiyGqHqcRJHIKWHWOmHhu2WIm+PHFDIAl3iAVwsVGygoJ5zVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lcFiSLrc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFEFC4CEF1;
	Tue, 27 May 2025 16:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748362401;
	bh=BfV3xzhjunrMLDK9cWHpUfmqXZar03TrfugoHRogF2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lcFiSLrcmPbrIwfvaoSotL1hnrEWYr1MiGfv33PRH6r72Jkw0Xm3Yl3WcqEnbCrZs
	 WiLu0mbK93sTfCaXPfGu5dvL4kPlXBVNAU9jEVC+Cjbex9TIofzC6EV3lz1Fi4++/S
	 BW8ClajFzBbsAiuze4FNoijNLNvAV4yU0i7VEtiUYcIGOy7TkPlv8uS3DMBRhHlVb+
	 sJoiW/kAxJitsWDQJhE6vD+ESGyjrizJUK1EYAWyaMUH1R9ZRtxpU7QU39g48wM07O
	 GMsJxgEniYwY+gdLy3M4t4cgtIVymFqrav8SNDrgL167IYbHobVhpdW2BzQjjXvUUb
	 8zoRha2bsReQA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 27 May 2025 17:04:46 +0100
Subject: [PATCH v2 2/4] selftests/mm: Add helper for logging test start and
 results
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-selftests-mm-cow-dedupe-v2-2-ff198df8e38e@kernel.org>
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
In-Reply-To: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2420; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BfV3xzhjunrMLDK9cWHpUfmqXZar03TrfugoHRogF2k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoNeSZFGgUGRjh/JzAf2Wi1QwwiU+M7NmFk0ydozbq
 UIbQ8AqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaDXkmQAKCRAk1otyXVSH0FXSB/
 4lYjWbEISd9ZPjMuF+WeRSYIecmGrqlKUONbk4Kp3kf/KPFd+xUbfklb7NL5mol/5IlkyBKR5nsp2U
 wdZIrsBsg4SXtnLLt9TmNJBfHnxArL0wiAiff9CGm13MqC/di3oKB65M3wbcoOarE5rmPLe77ahziI
 3MRHxI2xvQ04PX9PbFs//2fR9Y5SuEv6+rH9Dswy1cyKv6f4HTSqxrtdsSPLH/+H0LP/zO5bHF5Gkt
 83oa9LH1Jme9Ym9ymO6KGpTbp3bvnkMsE0ufC+H8S3X7qn+VbrAiov0KvkndM2uLXAojdWd0s5hck9
 dT4NfJC0a5TC0yHu2Lk5JTSIF8fize
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


