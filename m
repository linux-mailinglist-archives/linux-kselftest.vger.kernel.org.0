Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67976522376
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 May 2022 20:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348669AbiEJSNi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 May 2022 14:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348608AbiEJSN0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 May 2022 14:13:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C67F29820;
        Tue, 10 May 2022 11:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652206168; x=1683742168;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6MmFC/P7PHWENM/7pD3aeR70sEQG/z/SlZ7AM86ayZc=;
  b=C8zfSixeRKXpsOMaMbzr8+szYq7r9dFBiM6RR0xfmjRMFGKBX2kelXOq
   40ka31EFjUdH3MlxSGDSi48TyU/dPyfcewsejZRBHiAwU4dR0w6chIgde
   stDWx5gvQbJqeYTdqas79EzzatvXDfUxrGdfpOKHaksb50TfhZo0bo5Dd
   5shBl03JqHhBJj6I+0eW31waSYCHNVslZhxbqhn7/+vh13Q95QCzzNYNT
   EWlZtbhcCj6s+EcyMfVF2sjH3wyHzyla4rwFggx44PS17Vuw1Kr5lQ66z
   ta59wL0q75b207HLH179oiE2khKze6DQfEO+KVcxx8uvdzsTp9aUuEU3O
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="330057540"
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="330057540"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="541908815"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 11:09:17 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, luto@kernel.org, mingo@redhat.com,
        linux-sgx@vger.kernel.org, x86@kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     seanjc@google.com, kai.huang@intel.com, cathy.zhang@intel.com,
        cedric.xing@intel.com, haitao.huang@intel.com,
        mark.shanahan@intel.com, vijay.dhanraj@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 21/31] Documentation/x86: Introduce enclave runtime management section
Date:   Tue, 10 May 2022 11:08:57 -0700
Message-Id: <1da0b9a938b28e68e6870ebd5291490d680e700b.1652137848.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652137848.git.reinette.chatre@intel.com>
References: <cover.1652137848.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V4:
- Rename sgx_ioc_enclave_modify_type -> sgx_ioc_enclave_modify_types.
  (Jarkko)
- Add Jarkko's Reviewed-by tag.

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
index 265568a9292c..2bcbffacbed5 100644
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
+               sgx_ioc_enclave_modify_types
+               sgx_ioc_enclave_remove_pages
+
 Enclave vDSO
 ------------
 
-- 
2.25.1

