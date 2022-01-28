Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41E04A000E
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 19:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347788AbiA1SYY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 13:24:24 -0500
Received: from mga11.intel.com ([192.55.52.93]:26182 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343789AbiA1SYX (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 13:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643394263; x=1674930263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F0TN1kp9SPJ+PH0r0h5Xs9kk0gE4PkwwlTkbFb+O0rs=;
  b=QOnSskvZcAQtdgk9LxCZ3qGYmXN2TBZ8Bs5JyImuseRfEz9oUbJh9uOh
   8CoLN+I1nJosvWug4ijNLhPtBztdsx8UCO7y29bOwVlZ6MRKfxFKwnTP1
   pfbpdlvVp47xR1Pxl/9g9bgG9FtPsVR0TitsILL1u10i1NtLbNzmWkURi
   NNqlFS5jUu5f1waTwk4AGn7UoHRsDlNdyUAoRzMjiTM35vmrx+Tiwtrxc
   xqNa9dcBSg9TXKNjiuN/YbQmgLmXQiaIeFYpWsmuvIRcqagsYt729WlKc
   4vaVN/UXe/2sWYe7iF0BbOWmLLdlKGmix39Nx4V7c6c3R750eZbz0OhPX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="244773366"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="244773366"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="581930428"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 10:24:23 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     jarkko@kernel.org, dave.hansen@linux.intel.com,
        linux-sgx@vger.kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org
Subject: [PATCH 1/4] selftests/sgx: Fix segfault upon early test failure
Date:   Fri, 28 Jan 2022 10:23:56 -0800
Message-Id: <3c1d84724ecc7c94131ba1d94dc4c5de5aafc58f.1643393473.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643393473.git.reinette.chatre@intel.com>
References: <cover.1643393473.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A segfault is encountered if there happens to be an
early failure of any of the SGX tests. One way to
reproduce this is to remove the enclave binary
"test_encl.elf" that will trigger early enclave loading
failure followed by a segfault.

The segfault occurs within encl_delete() that cleans up
after an enclave by umapping its mapped regions and closing
the file descriptor to the SGX driver. As integrated with
the kselftest harness encl_delete() is called upon exit
from every test, irrespective of test success. encl_delete()
is also called to clean up if an error is encountered during
enclave loading.

encl_delete() is thus responsible for cleaning any amount of
enclave state - including state that has already been cleaned.

encl_delete() starts by accessing encl->segment_tbl that may
not have been created yet due to a very early failure or may
already be cleaned up because of a failure encountered after
encl->segment_tbl was created.

Ensure encl->segment_tbl is valid before attempting to access
memory offset from it. The offset with which it is accessed,
encl->nr_segments, is initialized after encl->segment_tbl and
thus considered valid to use after the encl->segment_tbl check
succeeds.

Fixes: 3200505d4de6 ("selftests/sgx: Create a heap for the test enclave")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
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

