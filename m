Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA945000BD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238939AbiDMVNX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbiDMVNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:12 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A489E4E3AF;
        Wed, 13 Apr 2022 14:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884250; x=1681420250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P3Ah6qx3whbTgLHApTG1GPVxxQd9/F2h3yHprcLpkIQ=;
  b=Y9oRrsW1QRc+hTHGt/+OYho2VFZVnWoorCEmr8wvxnP1ZcHOgLZXiMty
   VHg/aYbWolg7DNyOwRxyJV68GKISJGtUfRAaUMDhKhXqyLNFsEpaGwzHE
   yv2pE4zeWLPgCrlxnq4gUHvGzWBwGlp2yVqCgpyIoFNOIrtkT5Jyo4YQk
   Qh3MA+JRslVsI/uKVjHH63z0bslg+8nQoHGamrRQUjbxpy1h5AhBExdHZ
   NWRDqPolIG3puhYN19N260KVQzMsEm8Vz9X6MdiJcUr/A45hR4HIkVpuU
   3a/XIo5IGr1GB6uU6ac+emLP3Q4wlP/BOM5dLOsDzNn93ez0A7xUAoAdt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219058"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219058"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054311"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 23/31] selftests/sgx: Add test for TCS page permission changes
Date:   Wed, 13 Apr 2022 14:10:23 -0700
Message-Id: <05a85a9b05ded9f0b077ce6eb2bfba01f7dfd067.1649878359.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649878359.git.reinette.chatre@intel.com>
References: <cover.1649878359.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel should not allow permission changes on TCS pages. Add test to
confirm this behavior.

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V3:
- Add Jarkko's Acked-by tag.
- User provides only new permissions in
  SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl(), replacing secinfo. (Jarkko)
- Use SGX page permission bits instead of VMA protection bits.

Changes since V2:
- Update to use new struct name struct sgx_enclave_restrict_perm -> struct
  sgx_enclave_restrict_permissions. (Jarkko)

Changes since V1:
- Adapt test to the kernel interface changes: the ioctl() name change
  and providing entire secinfo as parameter.
- Rewrite error path to reduce line lengths.

 tools/testing/selftests/sgx/main.c | 71 ++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/sgx/main.c b/tools/testing/selftests/sgx/main.c
index 46eac09cd955..016ae3e5f398 100644
--- a/tools/testing/selftests/sgx/main.c
+++ b/tools/testing/selftests/sgx/main.c
@@ -121,6 +121,24 @@ static Elf64_Sym *vdso_symtab_get(struct vdso_symtab *symtab, const char *name)
 	return NULL;
 }
 
+/*
+ * Return the offset in the enclave where the TCS segment can be found.
+ * The first RW segment loaded is the TCS.
+ */
+static off_t encl_get_tcs_offset(struct encl *encl)
+{
+	int i;
+
+	for (i = 0; i < encl->nr_segments; i++) {
+		struct encl_segment *seg = &encl->segment_tbl[i];
+
+		if (i == 0 && seg->prot == (PROT_READ | PROT_WRITE))
+			return seg->offset;
+	}
+
+	return -1;
+}
+
 /*
  * Return the offset in the enclave where the data segment can be found.
  * The first RW segment loaded is the TCS, skip that to get info on the
@@ -567,6 +585,59 @@ TEST_F(enclave, pte_permissions)
 	EXPECT_EQ(self->run.exception_addr, 0);
 }
 
+/*
+ * Modifying permissions of TCS page should not be possible.
+ */
+TEST_F(enclave, tcs_permissions)
+{
+	struct sgx_enclave_restrict_permissions ioc;
+	int ret, errno_save;
+
+	ASSERT_TRUE(setup_test_encl(ENCL_HEAP_SIZE_DEFAULT, &self->encl, _metadata));
+
+	memset(&self->run, 0, sizeof(self->run));
+	self->run.tcs = self->encl.encl_base;
+
+	memset(&ioc, 0, sizeof(ioc));
+
+	/*
+	 * Ensure kernel supports needed ioctl() and system supports needed
+	 * commands.
+	 */
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	/*
+	 * Invalid parameters were provided during sanity check,
+	 * expect command to fail.
+	 */
+	ASSERT_EQ(ret, -1);
+
+	/* ret == -1 */
+	if (errno_save == ENOTTY)
+		SKIP(return,
+		     "Kernel does not support SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS ioctl()");
+	else if (errno_save == ENODEV)
+		SKIP(return, "System does not support SGX2");
+
+	/*
+	 * Attempt to make TCS page read-only. This is not allowed and
+	 * should be prevented by the kernel.
+	 */
+	ioc.offset = encl_get_tcs_offset(&self->encl);
+	ioc.length = PAGE_SIZE;
+	ioc.permissions = SGX_SECINFO_R;
+
+	ret = ioctl(self->encl.fd, SGX_IOC_ENCLAVE_RESTRICT_PERMISSIONS, &ioc);
+	errno_save = ret == -1 ? errno : 0;
+
+	EXPECT_EQ(ret, -1);
+	EXPECT_EQ(errno_save, EINVAL);
+	EXPECT_EQ(ioc.result, 0);
+	EXPECT_EQ(ioc.count, 0);
+}
+
 /*
  * Enclave page permission test.
  *
-- 
2.25.1

