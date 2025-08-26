Return-Path: <linux-kselftest+bounces-39921-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C317B35505
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 09:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C753BBF85
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 07:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9862F618F;
	Tue, 26 Aug 2025 07:07:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FF62F6573;
	Tue, 26 Aug 2025 07:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756192072; cv=none; b=X/ho3xKoRTX/93nY/EyQp+tin2G/Iecb7v7lRjvXluAHfWw+mByphbdTpLTHS+QekTsipXovM55nsdSmfCrNxo+gS56FEr1cM4aLP9eZu/VBlrOVsHOtcuCI4ff+VoWQ7A5mdSlJC3Ua0vVV3X+A3tXqaH2DJXo3ywXT/uMWN3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756192072; c=relaxed/simple;
	bh=WImtmxEHdhUmjAW+QhjHJ7SKooKqpRstSTXIbLo7+5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r7oGHurWSyTw9DDVkfRQGgL3pLyPapFaDu3SNUTW3dTe2HbSGiCEobNLqkw1AL1szpHGGHXUMdhNJp0fEqkqjFgkdyZRQ0MJBkhkSuhbYi4eJ384m/yXxXU2fhspOQcXo7HGBGoXo9EZ9BSZgpZY+IPaGMQflTOdY8EdzVhOyF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B63031BC0;
	Tue, 26 Aug 2025 00:07:41 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.163.65.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CB183F63F;
	Tue, 26 Aug 2025 00:07:43 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
	shuah@kernel.org
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH 2/2] selftests/mm/uffd-stress: Stricten constraint on free hugepages before the test
Date: Tue, 26 Aug 2025 12:37:05 +0530
Message-Id: <20250826070705.53841-3-dev.jain@arm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826070705.53841-1-dev.jain@arm.com>
References: <20250826070705.53841-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test requires at least 2 * (bytes/page_size) hugetlb memory, since
we require identical number of hugepages for src and dst location. Fix
this.

Along with the above, as explained in patch "selftests/mm/uffd-stress:
Make test operate on less hugetlb memory", the racy nature of the test
requires that we have some extra number of hugepages left beyond what is
required. Therefore, stricten this constraint.

Fixes: 5a6aa60d1823 ("selftests/mm: skip uffd hugetlb tests with insufficient hugepages")
Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/mm/uffd-stress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index 40af7f67c407..eb0b37f08061 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -449,7 +449,7 @@ int main(int argc, char **argv)
 	bytes = atol(argv[2]) * 1024 * 1024;
 
 	if (test_type == TEST_HUGETLB &&
-	   get_free_hugepages() < bytes / page_size) {
+	   get_free_hugepages() < 2 * (bytes / page_size) + 10) {
 		printf("skip: Skipping userfaultfd... not enough hugepages\n");
 		return KSFT_SKIP;
 	}
-- 
2.30.2


