Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4421A4A682A
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Feb 2022 23:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240121AbiBAWrP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Feb 2022 17:47:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:18697 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239234AbiBAWrO (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Feb 2022 17:47:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643755634; x=1675291634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkaZuACiZ0ejAq9qCfv3ISOiQAYfbcK3eJHzVdB5CKk=;
  b=F8nNAN+NBuHPp+cxFDGoXaItUxccqIQMu9kXLLlWuGh5FFz01OW5Iv19
   +lTnsXAZwhkoHJE2/tzcywVJnm3/Z4D9roVXikdfCUUMBebZHfnRMlEH0
   85MG/+bS3VEI4311CribFtYA4sUl1XkdHKb4987bJOVaS7kMtGHJlN5jy
   SPNCdF1QkkBcnk+w91x/YDvmjGevYRgFvtEZZk9J+yQNrP+AJnJJHNxVM
   mSHGElrNXeLOOJYn6hri9leStgJoNjCxdEssHb37bvJ1ZDjFrHiFabLMV
   lE8nzwMIbyxoMSzSX4fbEO5U7mloBRWn10LcBJ3LyIu1vEhoZlu3coKai
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="247582280"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="247582280"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="698584742"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:47:14 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH V2 1/4] selftests/sgx: Fix NULL-pointer-dereference upon early test failure
Date:   Tue,  1 Feb 2022 14:47:03 -0800
Message-Id: <89824888783fd8e770bfc64530c7549650a41851.1643754040.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643754040.git.reinette.chatre@intel.com>
References: <cover.1643754040.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

== Background ==

The SGX selftests track parts of the enclave binaries in an array:
encl->segment_tbl[]. That array is dynamically allocated early
(but not first) in the test's lifetime. The array is referenced
at the end of the test in encl_delete().

== Problem ==

encl->segment_tbl[] can be NULL if the test fails before its
allocation. That leads to a NULL-pointer-dereference in encl_delete().
This is triggered during early failures of the selftest like if the
enclave binary ("test_encl.elf") is deleted.

== Solution ==

Ensure encl->segment_tbl[] is valid before attempting to access
its members. The offset with which it is accessed, encl->nr_segments,
is initialized before encl->segment_tbl[] and thus considered valid
to use after the encl->segment_tbl[] check succeeds.

Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Rewrite commit message (Dave).

 tools/testing/selftests/sgx/load.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/load.c b/tools/testing/selftests/sgx/load.c
index 9d4322c946e2..006b464c8fc9 100644
--- a/tools/testing/selftests/sgx/load.c
+++ b/tools/testing/selftests/sgx/load.c
@@ -21,7 +21,7 @@
 
 void encl_delete(struct encl *encl)
 {
-	struct encl_segment *heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
+	struct encl_segment *heap_seg;
 
 	if (encl->encl_base)
 		munmap((void *)encl->encl_base, encl->encl_size);
@@ -32,10 +32,11 @@ void encl_delete(struct encl *encl)
 	if (encl->fd)
 		close(encl->fd);
 
-	munmap(heap_seg->src, heap_seg->size);
-
-	if (encl->segment_tbl)
+	if (encl->segment_tbl) {
+		heap_seg = &encl->segment_tbl[encl->nr_segments - 1];
+		munmap(heap_seg->src, heap_seg->size);
 		free(encl->segment_tbl);
+	}
 
 	memset(encl, 0, sizeof(*encl));
 }
-- 
2.25.1

