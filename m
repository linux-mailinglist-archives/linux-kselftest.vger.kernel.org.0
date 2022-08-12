Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B6259153C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Aug 2022 20:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238844AbiHLSHp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 12 Aug 2022 14:07:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiHLSHo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 12 Aug 2022 14:07:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5CB2863;
        Fri, 12 Aug 2022 11:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660327660; x=1691863660;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oNcyKLO9UI+rsw1981C2DTLKPsPQSX6QWQM+cMyCFe4=;
  b=GmwjX6ZW3FJ6gVyrAXo4eFu1TB6hR3rgKbGmuvUcjEAOwodqTUDNpywB
   LZx2qOQAOeA5GEVaL4m/GsyxuPfx+37euNPRXX8d/pXZiVxIqGqnaqxm/
   0fr8CTEAIqtUBwA80xz1UrdJBs+y9D3EWxCxXfuRaG1umYYGhhcypxLWu
   /x1UuWyqogx4/R2EevDU3KdVTkC1ORUOkAcFfnE+5wgHMtTiTSzysaz3R
   pKQtxFjgo+h6qHyLTTzIRLI6alZl8FDZU0AOZDVYwZOy4AsYhGI6deVeG
   d+ZaC2/tihvwaukwHt7gl1lV+IB5EfYj4+OCQToZppb0z2gmcH926Tw7d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292921391"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="292921391"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 11:07:22 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="582180066"
Received: from mmeng-mobl2.amr.corp.intel.com (HELO kcaccard-desk.amr.corp.intel.com) ([10.209.105.65])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 11:07:20 -0700
From:   Kristen Carlson Accardi <kristen@linux.intel.com>
To:     linux-kernel@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-sgx@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions warning
Date:   Fri, 12 Aug 2022 11:07:13 -0700
Message-Id: <20220812180714.566257-1-kristen@linux.intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

OpenSSL 3.0 deprecates some of the functions used in the SGX
selftests, causing build errors on new distros. For now ignore
the warnings until support for the functions is no longer
available and mark FIXME so that it can be clear this should
be removed at some point.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
---
 tools/testing/selftests/sgx/sigstruct.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/sgx/sigstruct.c b/tools/testing/selftests/sgx/sigstruct.c
index 50c5ab1aa6fa..a07896a46364 100644
--- a/tools/testing/selftests/sgx/sigstruct.c
+++ b/tools/testing/selftests/sgx/sigstruct.c
@@ -17,6 +17,12 @@
 #include "defines.h"
 #include "main.h"
 
+/*
+ * FIXME: OpenSSL 3.0 has deprecated some functions. For now just ignore
+ * the warnings.
+ */
+#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
+
 struct q1q2_ctx {
 	BN_CTX *bn_ctx;
 	BIGNUM *m;
-- 
2.36.1

