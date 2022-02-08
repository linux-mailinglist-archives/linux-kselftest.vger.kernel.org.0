Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823D44AE414
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Feb 2022 23:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387022AbiBHWZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Feb 2022 17:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387027AbiBHVsw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Feb 2022 16:48:52 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B6C0612BA;
        Tue,  8 Feb 2022 13:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644356930; x=1675892930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HEBg2eQcO7Fk1Q3mMJehGhu8DX1HWgw88BE5sdLZ/f0=;
  b=Agr68XLFtPCLJKAx5j9/jgRuOciH2gMbQav2Et9YID3WWU6spM5foaQ9
   VMRINiRO7V/cdEhvRimw7bllIQEul264gty30ZJT/S2WtNC/8pX7vSnW5
   B5f7ZclsLARzKBKQJv6his9K9GhQNbDSf8NBcG4KxPWhl54ScLblbPNAz
   jhkxHG7Zb21Ym4rSwWP1juRfDPv/HOitgptdeDIoVMlceE28thq3bX/rc
   AwmWoYUwrUiJX22I7ID38hKVH2KZQJJHuo3qDXbstcxw0piDWtMqQ6FO3
   RGJp38M1hEKtu44ljKZBHq1XUvIJstizUZBijMxkjFoj8FopgSD4qhWv9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="309805366"
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="309805366"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
X-IronPort-AV: E=Sophos;i="5.88,353,1635231600"; 
   d="scan'208";a="632992865"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 13:48:49 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/4] selftests/sgx: Fix NULL-pointer-dereference upon early test failure
Date:   Tue,  8 Feb 2022 13:48:39 -0800
Message-Id: <90a31dfd640ea756fa324712e7cbab4a90fa7518.1644355600.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644355600.git.reinette.chatre@intel.com>
References: <cover.1644355600.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V2:
- Add Acked by from Shuah.

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

