Return-Path: <linux-kselftest+bounces-30403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D55BA8214F
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 11:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98BCD7AEA72
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 09:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F0DF25C6F7;
	Wed,  9 Apr 2025 09:50:26 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FF625A2DC;
	Wed,  9 Apr 2025 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744192226; cv=none; b=AZ3J0NUoJdGbc2nV91UyzFU8Cp3Bpzti0fFWAIeEgjoYPARpx4nYrbciUYZBX14LGzVk20k3R4YVdDRoWtYJ96e977SDh/BAtHHixPwxrYCvCcShzY3Q5jyxvU8Wx4zaPb/j6+nrjnBl6swqDanz0nAfSgCSxd6WEy2x8U9AUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744192226; c=relaxed/simple;
	bh=djv4e+40pLsB+IrtUJHHfQeXkTy4AFV6Uvs67CoZRFk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EAfd7osSj266QSsiDlvHSqwCIPrtiLpxxT5t+xGyOKJL1xcgjlwP8NJ766KUOrpkQy5sGO51VHTob8hF7gboAwhnlL0T1NCtciKcx7bLdmjBvh1+PvVKhvKK/zw1EUSJQNt7zEVZRVLDKvurwtm8YTWWWMMXFahtI5Tw9GehV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 76DAC106F;
	Wed,  9 Apr 2025 02:50:14 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA9EF3F694;
	Wed,  9 Apr 2025 02:50:11 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/mm: Fix compiler -Wmaybe-uninitialized warning
Date: Wed,  9 Apr 2025 15:20:06 +0530
Message-Id: <20250409095006.1422620-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Following build warning comes up for cow test as 'transferred' variable has
not been initialized. Fix the warning via zero init for the variable.

  CC       cow
cow.c: In function ‘do_test_vmsplice_in_parent’:
cow.c:365:61: warning: ‘transferred’ may be used uninitialized [-Wmaybe-uninitialized]
  365 |                 cur = read(fds[0], new + total, transferred - total);
      |                                                 ~~~~~~~~~~~~^~~~~~~
cow.c:296:29: note: ‘transferred’ was declared here
  296 |         ssize_t cur, total, transferred;
      |                             ^~~~~~~~~~~
  CC       compaction_test
  CC       gup_longterm

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/testing/selftests/mm/cow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index f0cb14ea8608..b6cfe0a4b7df 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -293,7 +293,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
 		.iov_base = mem,
 		.iov_len = size,
 	};
-	ssize_t cur, total, transferred;
+	ssize_t cur, total, transferred = 0;
 	struct comm_pipes comm_pipes;
 	char *old, *new;
 	int ret, fds[2];
-- 
2.43.0


