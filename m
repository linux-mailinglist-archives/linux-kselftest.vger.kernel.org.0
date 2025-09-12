Return-Path: <linux-kselftest+bounces-41372-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74F48B54E11
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78C1F1644D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6A63064BF;
	Fri, 12 Sep 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="H3JI5oOM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C832302755;
	Fri, 12 Sep 2025 12:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680278; cv=none; b=HSblV5O1o1jHnUobCGYlRTdcEGfhL/vvZ6vTHGDK5Jr+vqgWz1+GwcF+vlftkTQHPjusC8r0wSZBH2ikNtLZuKV8aRkzBwieoPkTafD5HFLkTu2UogAq0VcFg4SGppPOwvAgCibPY6+BAg0eH/wzog8l83wRdst07nUfR9VFjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680278; c=relaxed/simple;
	bh=t+a7zA6bZDMOWmuPa8ga3Id8iVwTgiOsXbGtzVzdwx0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OqiPWSwu/5anco/D/FoZ6trQ7dAYlM7vFmaShQ/1wQjijbIM1JFS9mlIjUrr0RgAeovWXxrZdx6Dip71PvMnd3TRnDB0gbSET5goRkS9sTs5XeSHBnGN+5MIGBDoiDZtdDc0Wz8wwL8bRseBt0n2aBVikCR1z6JKQ3CtLPn4cHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=H3JI5oOM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757680274;
	bh=t+a7zA6bZDMOWmuPa8ga3Id8iVwTgiOsXbGtzVzdwx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H3JI5oOMwl9BnNQ/9ofEPsnIh7Bo0S8a1+haHTZwoLjB+HK5LE41Ku60KxBPj0G9f
	 ppECop1iZbdyjsdqsADCxKxnBJD08+0j86+lJ1WbDqvgMLwNiox4vjXzxfuxgKe5HT
	 ES62BY1dizMXPbmxIROIRtRG4a9Thr1YY3cWh6eqvo6k+BWybSARB2f1FaA3s5DKSO
	 d/ebpckXtm6p5VGeGV+K5hWlStP7sVa1QegWZ8NM1QuYBkW4LTMW1C+lY5gYQ2Xiqu
	 st0VbvrlsQSxUkuwmBq5QWl0gnD7KGR+mm15hl3eM/VvZRYQIHDg6UzTXqnLgDT+SO
	 J1myC79JdnxVg==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C7A2117E0DD7;
	Fri, 12 Sep 2025 14:31:02 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	Sidhartha Kumar <sidhartha.kumar@oracle.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>
Subject: [PATCH 1/2] selftests/mm: Add -Wunreachable-code and fix warnings
Date: Fri, 12 Sep 2025 17:30:21 +0500
Message-ID: <20250912123025.1271051-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250912123025.1271051-1-usama.anjum@collabora.com>
References: <20250912123025.1271051-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable -Wunreachable-code flag to catch dead code and fix them.

1. Remove the dead code and write a comment instead:
hmm-tests.c:2033:3: warning: code will never be executed
[-Wunreachable-code]
                perror("Should not reach this\n");
                ^~~~~~

2. ksft_exit_fail_msg() calls exit(). So cleanup isn't done. Replace it
   with ksft_print_msg().
split_huge_page_test.c:301:3: warning: code will never be executed
[-Wunreachable-code]
                goto cleanup;
                ^~~~~~~~~~~~

3. Remove duplicate inline.
pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
specifier [-Wduplicate-decl-specifier]
static inline __always_inline

Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/Makefile                | 1 +
 tools/testing/selftests/mm/hmm-tests.c             | 5 ++---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
 tools/testing/selftests/mm/split_huge_page_test.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 5a1dee50b8987..eaf9312097f7b 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -34,6 +34,7 @@ endif
 MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS += -Wunreachable-code
 LDLIBS = -lrt -lpthread -lm
 
 # Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 1325de70f44fc..25045536f4707 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -2030,11 +2030,10 @@ TEST_F(hmm, hmm_cow_in_device)
 	if (pid == -1)
 		ASSERT_EQ(pid, 0);
 	if (!pid) {
-		/* Child process waitd for SIGTERM from the parent. */
+		/* Child process waits for SIGTERM from the parent. */
 		while (1) {
 		}
-		perror("Should not reach this\n");
-		exit(0);
+		/* Should not reach this */
 	}
 	/* Parent process writes to COW pages(s) and gets a
 	 * new copy in system. In case of device private pages,
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index b5e076a564c95..302fef54049c8 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -41,7 +41,7 @@ static siginfo_t siginfo = {0};
  * syscall will attempt to access the PLT in order to call a library function
  * which is protected by MPK 0 which we don't have access to.
  */
-static inline __always_inline
+static __always_inline
 long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 {
 	unsigned long ret;
diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index 7731191cc8e9b..743af3c051905 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -510,7 +510,7 @@ static void split_file_backed_thp(int order)
 
 	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
 	if (status >= INPUT_MAX) {
-		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
+		ksft_print_msg("Fail to create file-backed THP split testing file\n");
 		goto cleanup;
 	}
 
-- 
2.47.3


