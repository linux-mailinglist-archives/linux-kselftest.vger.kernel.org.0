Return-Path: <linux-kselftest+bounces-35428-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FBAE19BB
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 13:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3983B416F
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Jun 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321D8289E1F;
	Fri, 20 Jun 2025 11:12:00 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84680288CBF;
	Fri, 20 Jun 2025 11:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417920; cv=none; b=rwTRH6iHM4aNczs1JoWDaaRvs2Gr/ipjmx+pORtQvCoEtOIDMXIaq9WZJDX66x+1FqW6F/cn/FOWkKMt7S18flpOYXmnKaeW16QvziXMlZj4gJ4Isu4DMCUBLV8oprRbSPTRo+67O2QMv9/RvhTKSzmcfRY+4UST0HHT6fahiS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417920; c=relaxed/simple;
	bh=C3sH3mhSfvedE6q+7+YDcLAOXFJCWeiEUkujc6ssmgU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2R8G9XQNkrqgG/SHHTVzgALAMaU+YZx5nTWWZ03gGvKQISzeQQMhmcM5bzgoW3gIDjcm5V83SuV98pOB++LwaoEmABRHeMKdWQG7LJ7gYfIBvZ8QPeMWaIsTDHHIfkoM9JVGJPkSib5v4rETXKZDc6qo/S0r3F9oWHnlDow8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45776176A;
	Fri, 20 Jun 2025 04:11:38 -0700 (PDT)
Received: from MacBook-Pro.blr.arm.com (MacBook-Pro.blr.arm.com [10.164.18.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 952DD3F673;
	Fri, 20 Jun 2025 04:11:54 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	anshuman.khandual@arm.com,
	ryan.roberts@arm.com,
	lorenzo.stoakes@oracle.com,
	david@redhat.com,
	donettom@linux.ibm.com,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH] selftests/mm: Fix validate_addr helper
Date: Fri, 20 Jun 2025 16:41:50 +0530
Message-Id: <20250620111150.50344-1-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

validate_addr() function checks whether the address returned by mmap()
lies in the low or high VA space, according to whether a high addr hint
was passed or not. The fix commit mentioned below changed the code in
such a way that this function will always return failure when passed
high_addr == 1; addr will be >= HIGH_ADDR_MARK always, we will fall
down to "if (addr < HIGH_ADDR_MARK)" and return failure. Fix this.

Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/virtual_address_range.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index b380e102b22f..169dbd692bf5 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -77,8 +77,11 @@ static void validate_addr(char *ptr, int high_addr)
 {
 	unsigned long addr = (unsigned long) ptr;
 
-	if (high_addr && addr < HIGH_ADDR_MARK)
-		ksft_exit_fail_msg("Bad address %lx\n", addr);
+	if (high_addr) {
+		if (addr < HIGH_ADDR_MARK)
+			ksft_exit_fail_msg("Bad address %lx\n", addr);
+		return;
+	}
 
 	if (addr > HIGH_ADDR_MARK)
 		ksft_exit_fail_msg("Bad address %lx\n", addr);
-- 
2.30.2


