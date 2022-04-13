Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714E75000DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 23:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238886AbiDMVNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Apr 2022 17:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239040AbiDMVNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Apr 2022 17:13:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E3B44A33;
        Wed, 13 Apr 2022 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649884250; x=1681420250;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiU+SVNL1a1zl8isjEY1AJ7ug5DjCIg0sIHkukAZDzE=;
  b=Ld3D8A8gRu1yU+uUUAjZvTb6D8cOUNvVxF5FxxUpk8WUwyehk+Fi8ie8
   2SxBvTi3rPk9ranYWaOL0GPAzVGS51mONKlXAElUqMvsZfTLkO83XDfhV
   0VjHjsT5/MEZDzQ5bn7miTvfZKS1OR3Roix7spyOotUFPa5GK20M35HGf
   AnJLECdmnOovkoFVrWEWQe2CiDmstTmO3vR2yNqTcCVEWYVVdcmMYCpep
   aNH9xpBsV0kxZOhddVUocMnOMSN78WAD8ufpWBBrca2eHs7+YMEHpXeJz
   get+N3GiJaYlDcS6ZSxTQ2NS0nf8Z9LW3e8dgZkCnQmOwMz4jT9+iS/P4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="323219051"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="323219051"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 14:10:45 -0700
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="725054303"
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
Subject: [PATCH V4 21/31] Documentation/x86: Introduce enclave runtime management section
Date:   Wed, 13 Apr 2022 14:10:21 -0700
Message-Id: <21b97a8e9275706f14d6bc652a0f2cfdd5d9648e.1649878359.git.reinette.chatre@intel.com>
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

Enclave runtime management is introduced following the pattern
of the section describing enclave building. Provide a brief
summary of enclave runtime management, pointing to the functions
implementing the ioctl()s that will contain details within their
kernel-doc.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
No changes since V3.

Changes since V2:
- Remove references to ioctl() to relax permissions and update to reflect
  function renaming sgx_ioc_enclave_restrict_perm() ->
  sgx_ioc_enclave_restrict_permissions().
- Rename sgx_ioc_enclave_modt -> sgx_ioc_enclave_modify_type

Changes since V1:
- New patch.

 Documentation/x86/sgx.rst | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/x86/sgx.rst b/Documentation/x86/sgx.rst
index 265568a9292c..10287c558485 100644
--- a/Documentation/x86/sgx.rst
+++ b/Documentation/x86/sgx.rst
@@ -100,6 +100,21 @@ pages and establish enclave page permissions.
                sgx_ioc_enclave_init
                sgx_ioc_enclave_provision
 
+Enclave runtime management
+--------------------------
+
+Systems supporting SGX2 additionally support changes to initialized
+enclaves: modifying enclave page permissions and type, and dynamically
+adding and removing of enclave pages. When an enclave accesses an address
+within its address range that does not have a backing page then a new
+regular page will be dynamically added to the enclave. The enclave is
+still required to run EACCEPT on the new page before it can be used.
+
+.. kernel-doc:: arch/x86/kernel/cpu/sgx/ioctl.c
+   :functions: sgx_ioc_enclave_restrict_permissions
+               sgx_ioc_enclave_modify_type
+               sgx_ioc_enclave_remove_pages
+
 Enclave vDSO
 ------------
 
-- 
2.25.1

