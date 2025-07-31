Return-Path: <linux-kselftest+bounces-38102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA67B17499
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DE3A8305F
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8C51FBCAE;
	Thu, 31 Jul 2025 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="XrTVbySq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2EE1F7569;
	Thu, 31 Jul 2025 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977788; cv=pass; b=Mw6abGQq4UqigHb8lmMVX1cg27/dSeR41qnyXMQdm7vtvfXZacGBuTo7avIz1jdEpjtjT+IEgEznulpfBwnbrAmFlpIaS9r6NXOu2lyp2pCeADBsAJ0IXibd16ads/Q9Npo3kxO2v690x4UvYjCJeGCbGf8DbSPiSIu4rhFnuvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977788; c=relaxed/simple;
	bh=No24s4T5i2jffXqMefP6oST480RjYux7jXeoFxtjyu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=glWa02uPx/xdMxjs0W5DuZlZi8NwAWqA4aYcxThCe6N3AoYAXfSjQ5sK8ywuPC3siOLwLt8/vXHlYgBTODHL9wYQkhAol0OEePg+MQlXlnvsXZG905S15+KQi828q5Fa6oGolhZusmy05Od176rgvTn6LNA8FggLljc0kZPqdSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=XrTVbySq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753977741; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kZrcr8lGjCQ/uaYK88EneYfN9ao5iMrIBdWosfJasMphAJ+cPsUae+MsXRWpNTJQ2tuMMoGDsQJGfRUlk6ZZ31RYSYDRaPmFnRO97x1qjXvufx2sdQPsUXSfy7CS8HV2xD0sJcH4tywWNZM8rogeXywoqIdoG/S/1TiSGyyRNwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753977741; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=0rIUsTPjbY2X209n7mDn3VwLafDt4aFcMM5+u+5YCmk=; 
	b=F5IMe+DOqWDoDKoKKGDgGGaQmw31nvnJ+KztuVci0qh25Ojm+uUW8vJm66LWSJjuAE1wrn2whXV2iEjB42gYvFVPfIVvQ4YIKKdGl5NxztAboLrRE8LDmwf48uhBxhsvEoTLC3CATq3OPWcb/7T4aGdDCgzEtc54jz4WwPOPbQc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753977741;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=0rIUsTPjbY2X209n7mDn3VwLafDt4aFcMM5+u+5YCmk=;
	b=XrTVbySq+/g7c2Lj1WWTvNchEk/DPefYFSW+l/DPiM3RTR1jK97eeN6kQWi/uqCn
	4TbpNczuDUhU3hmlpg/ORIfQKY88frscvRFeoHjMi0OKR26mWrB5qGFMGKNajkvOkba
	y3oqaKPZCEbduEF/ife2TlXQ0ee2aLNB2MrSDlsA=
Received: by mx.zohomail.com with SMTPS id 1753977738812600.6316331219836;
	Thu, 31 Jul 2025 09:02:18 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 1/8] selftests/mm: Add -Wunreachable-code and fix warnings
Date: Thu, 31 Jul 2025 21:01:25 +0500
Message-Id: <20250731160132.1795351-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250731160132.1795351-1-usama.anjum@collabora.com>
References: <20250731160132.1795351-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Enable -Wunreachable-code flag to catch dead code and fix them.

1. Remove the dead code and write a comment instead:
hmm-tests.c:2033:3: warning: code will never be executed
[-Wunreachable-code]
                perror("Should not reach this\n");
                ^~~~~~

2. ksft_exit_fail_msg() calls exit(). Remove the dead code.
split_huge_page_test.c:301:3: warning: code will never be executed
[-Wunreachable-code]
                goto cleanup;
                ^~~~~~~~~~~~

3. Remove duplicate inline.
pkey_sighandler_tests.c:44:15: warning: duplicate 'inline' declaration
specifier [-Wduplicate-decl-specifier]
static inline __always_inline

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/Makefile                | 1 +
 tools/testing/selftests/mm/hmm-tests.c             | 5 ++---
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 2 +-
 tools/testing/selftests/mm/split_huge_page_test.c  | 4 +---
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index d13b3cef2a2b2..23d4bf6215465 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -34,6 +34,7 @@ endif
 MAKEFLAGS += --no-builtin-rules
 
 CFLAGS = -Wall -O2 -I $(top_srcdir) $(EXTRA_CFLAGS) $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
+CFLAGS += -Wunreachable-code
 LDLIBS = -lrt -lpthread -lm
 
 # Some distributions (such as Ubuntu) configure GCC so that _FORTIFY_SOURCE is
diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
index 141bf63cbe05e..15aadaf24a667 100644
--- a/tools/testing/selftests/mm/hmm-tests.c
+++ b/tools/testing/selftests/mm/hmm-tests.c
@@ -2027,11 +2027,10 @@ TEST_F(hmm, hmm_cow_in_device)
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
index 05de1fc0005b7..a85b2e393e4e8 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -296,10 +296,8 @@ void split_file_backed_thp(int order)
 		ksft_exit_fail_msg("Unable to create a tmpfs for testing\n");
 
 	status = snprintf(testfile, INPUT_MAX, "%s/thp_file", tmpfs_loc);
-	if (status >= INPUT_MAX) {
+	if (status >= INPUT_MAX)
 		ksft_exit_fail_msg("Fail to create file-backed THP split testing file\n");
-		goto cleanup;
-	}
 
 	fd = open(testfile, O_CREAT|O_RDWR, 0664);
 	if (fd == -1) {
-- 
2.39.5


