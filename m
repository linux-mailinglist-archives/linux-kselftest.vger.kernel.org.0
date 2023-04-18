Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8C56E6818
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjDRPaf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 11:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjDRPad (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 11:30:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB319A2
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Apr 2023 08:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681831744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7hwLzEYfyCC+1HV0+CQuKr6XrxBkPdmXIv3+pwAsAU=;
        b=bmfoqXYvEjJIxh9L2VOAgzyxW6hxU1TVQEii7fKesGNn04IKohG0D51mitHh4XoyMpvVNG
        dMloIUPNiWlTzyb14lzh6OjvhpEUE8rU8n71TdfgDBBUJnwhBKh3DHUChk1ii7zUu9aCZT
        4RiNPu6hRGq9t3fzWT+/LpOAcH23SAw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-283-tx5a0GuAONunj9TrLi1nxQ-1; Tue, 18 Apr 2023 11:29:01 -0400
X-MC-Unique: tx5a0GuAONunj9TrLi1nxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 048921C0A58F;
        Tue, 18 Apr 2023 15:29:00 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.149])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B148314152F6;
        Tue, 18 Apr 2023 15:28:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-s390@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stefan Roesch <shr@devkernel.io>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH v1 2/3] selftests/ksm: ksm_functional_tests: add prctl unmerge test
Date:   Tue, 18 Apr 2023 17:28:48 +0200
Message-Id: <20230418152849.505124-3-david@redhat.com>
In-Reply-To: <20230418152849.505124-1-david@redhat.com>
References: <20230418051342.1919757-1-shr@devkernel.io>
 <20230418152849.505124-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's test whether setting PR_SET_MEMORY_MERGE to 0 after setting it to
1 will unmerge pages, similar to how setting MADV_UNMERGEABLE after setting
MADV_MERGEABLE would.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 .../selftests/mm/ksm_functional_tests.c       | 46 ++++++++++++++++---
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 7bc9fc17c9f0..26853badae70 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -91,9 +91,10 @@ static int ksm_merge(void)
 	return 0;
 }
 
-static char *mmap_and_merge_range(char val, unsigned long size)
+static char *mmap_and_merge_range(char val, unsigned long size, bool use_prctl)
 {
 	char *map;
+	int ret;
 
 	map = mmap(NULL, size, PROT_READ|PROT_WRITE,
 		   MAP_PRIVATE|MAP_ANON, -1, 0);
@@ -110,7 +111,17 @@ static char *mmap_and_merge_range(char val, unsigned long size)
 
 	/* Make sure each page contains the same values to merge them. */
 	memset(map, val, size);
-	if (madvise(map, size, MADV_MERGEABLE)) {
+
+	if (use_prctl) {
+		ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
+		if (ret < 0 && errno == EINVAL) {
+			ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
+			goto unmap;
+		} else if (ret) {
+			ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
+			goto unmap;
+		}
+	} else if (madvise(map, size, MADV_MERGEABLE)) {
 		ksft_test_result_fail("MADV_MERGEABLE failed\n");
 		goto unmap;
 	}
@@ -133,7 +144,7 @@ static void test_unmerge(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size);
+	map = mmap_and_merge_range(0xcf, size, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -155,7 +166,7 @@ static void test_unmerge_discarded(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size);
+	map = mmap_and_merge_range(0xcf, size, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -187,7 +198,7 @@ static void test_unmerge_uffd_wp(void)
 
 	ksft_print_msg("[RUN] %s\n", __func__);
 
-	map = mmap_and_merge_range(0xcf, size);
+	map = mmap_and_merge_range(0xcf, size, false);
 	if (map == MAP_FAILED)
 		return;
 
@@ -323,9 +334,31 @@ static void test_prctl_fork(void)
 	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
 }
 
+static void test_prctl_unmerge(void)
+{
+	const unsigned int size = 2 * MiB;
+	char *map;
+
+	ksft_print_msg("[RUN] %s\n", __func__);
+
+	map = mmap_and_merge_range(0xcf, size, true);
+	if (map == MAP_FAILED)
+		return;
+
+	if (prctl(PR_SET_MEMORY_MERGE, 0, 0, 0, 0)) {
+		ksft_test_result_fail("PR_SET_MEMORY_MERGE=0 failed\n");
+		goto unmap;
+	}
+
+	ksft_test_result(!range_maps_duplicates(map, size),
+			 "Pages were unmerged\n");
+unmap:
+	munmap(map, size);
+}
+
 int main(int argc, char **argv)
 {
-	unsigned int tests = 4;
+	unsigned int tests = 5;
 	int err;
 
 #ifdef __NR_userfaultfd
@@ -355,6 +388,7 @@ int main(int argc, char **argv)
 
 	test_prctl();
 	test_prctl_fork();
+	test_prctl_unmerge();
 
 	err = ksft_get_fail_cnt();
 	if (err)
-- 
2.39.2

