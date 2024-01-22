Return-Path: <linux-kselftest+bounces-3313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EFB8362CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 13:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3D31F216F3
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jan 2024 12:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B973AC34;
	Mon, 22 Jan 2024 12:06:06 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D953AC1B;
	Mon, 22 Jan 2024 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925166; cv=none; b=WUKzCrSshcwslVGcROrAyiLvPeV6/jJSDISUsWaeRKo75kFfxvssMWPe5tBey4gQ8xM/aXaw6xwl3XD37XoNV4naqGceeuTzntXICQx0234TL73LmDqPN856FBMIxjJI+xXA46elVIGeA7Jn6wk2RQihy6QeEWqS81nAq7vFJ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925166; c=relaxed/simple;
	bh=N/VFYUn0CZ1rlxRW2T8jLgBVFQkzzRWnwaF4iuuTHFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LYXYBgTFyVMxxKXJuZrUAFjN4U1n8vfuIQ0jPAg8O4qKTL2P+0p+fvDLKbWL4ufTIdp6XMuzpbSAIKhASooFhwi9/lr58RGIcg4128UoAGM04AihmeTzIUmkJQLIHGsk7mU5Af5Sd0Foed9fkZd/7R3lTd+lLAld7mFDTF7WMao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18CDB1FB;
	Mon, 22 Jan 2024 04:06:50 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17A383F73F;
	Mon, 22 Jan 2024 04:06:02 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] selftests/mm: ksm_tests should only MADV_HUGEPAGE valid memory
Date: Mon, 22 Jan 2024 12:05:54 +0000
Message-Id: <20240122120554.3108022-1-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksm_tests was previously mmapping a region of memory, aligning the
returned pointer to a PMD boundary, then setting MADV_HUGEPAGE, but was
setting it past the end of the mmapped area due to not taking the
pointer alignment into consideration. Fix this behaviour.

Up until commit efa7df3e3bb5 ("mm: align larger anonymous mappings on
THP boundaries"), this buggy behavior was (usually) masked because the
alignment difference was always less than PMD-size. But since the
mentioned commit, `ksm_tests -H -s 100` started failing.

Fixes: 325254899684 ("selftests: vm: add KSM huge pages merging time test")
Cc: stable@vger.kernel.org
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
Applies on top of mm-unstable.

Thanks,
Ryan


 tools/testing/selftests/mm/ksm_tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/ksm_tests.c b/tools/testing/selftests/mm/ksm_tests.c
index 380b691d3eb9..b748c48908d9 100644
--- a/tools/testing/selftests/mm/ksm_tests.c
+++ b/tools/testing/selftests/mm/ksm_tests.c
@@ -566,7 +566,7 @@ static int ksm_merge_hugepages_time(int merge_type, int mapping, int prot,
 	if (map_ptr_orig == MAP_FAILED)
 		err(2, "initial mmap");

-	if (madvise(map_ptr, len + HPAGE_SIZE, MADV_HUGEPAGE))
+	if (madvise(map_ptr, len, MADV_HUGEPAGE))
 		err(2, "MADV_HUGEPAGE");

 	pagemap_fd = open("/proc/self/pagemap", O_RDONLY);
--
2.25.1


