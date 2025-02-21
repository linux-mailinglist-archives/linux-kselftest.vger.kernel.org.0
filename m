Return-Path: <linux-kselftest+bounces-27148-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B0B1A3F066
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72CB386042D
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 09:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C109202F96;
	Fri, 21 Feb 2025 09:33:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF83FD4
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130419; cv=none; b=Uwzsb69zy5i/xZ+59xAU1JmHA+2HueBBNiUqcfgjdoFXKwsynoHK1uxhQeAtvQ3kVXjV+j/vfIMCTo8C8ycibJSXPbZOYuJ2kksqaDzRMflbnLMcAWb4TVg9gLz4Vb/I7xdJcxyDaCfqlZ0Q1usCOCnhuhBzFqQm/RGeLTkOKoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130419; c=relaxed/simple;
	bh=AgiPjyj+GZGQVfJyADV4HcULtk2jTxWfn2MGp4+sU5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bUd55DS5tIOFSjyKMX0/ISzC2ixVDxxs//ai8CrHdN0vzsVmUXfIVYA8vVPBNAhunMmU4MafnAdTlJkOfoyr1t3EbiwYUWx3551M/PuvfFX6Egz1lLSaJ6RoLSpsSksUTNMmQKdSai5VKeYjXPfCqBjzyCMj6DKhjZT35n8mkts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E015C4CED6;
	Fri, 21 Feb 2025 09:33:37 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>,
	Yang Shi <yang@os.amperecomputing.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 2/2] kselftest/arm64: mte: Skip the hugetlb tests if MTE not supported on such mappings
Date: Fri, 21 Feb 2025 09:33:31 +0000
Message-Id: <20250221093331.2184245-3-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250221093331.2184245-1-catalin.marinas@arm.com>
References: <20250221093331.2184245-1-catalin.marinas@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the kselftest was added at the same time with the kernel support
for MTE on hugetlb mappings, the tests may be run on older kernels. Skip
the tests if PROT_MTE is not supported on MAP_HUGETLB mappings.

Fixes: 27879e8cb6b0 ("selftests: arm64: add hugetlb mte tests")
Cc: Yang Shi <yang@os.amperecomputing.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 .../selftests/arm64/mte/check_hugetlb_options.c       | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
index 11f812635b51..3bfcd3848432 100644
--- a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
+++ b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
@@ -227,6 +227,8 @@ static int check_child_hugetlb_memory_mapping(int mem_type, int mode, int mappin
 int main(int argc, char *argv[])
 {
 	int err;
+	void *map_ptr;
+	unsigned long map_size;
 
 	err = mte_default_setup();
 	if (err)
@@ -243,6 +245,15 @@ int main(int argc, char *argv[])
 		return KSFT_FAIL;
 	}
 
+	/* Check if MTE supports hugetlb mappings */
+	map_size = default_huge_page_size();
+	map_ptr = mmap(NULL, map_size, PROT_READ | PROT_MTE,
+		       MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB, -1, 0);
+	if (map_ptr == MAP_FAILED)
+		ksft_exit_skip("PROT_MTE not supported with MAP_HUGETLB mappings\n");
+	else
+		munmap(map_ptr, map_size);
+
 	/* Set test plan */
 	ksft_set_plan(12);
 

