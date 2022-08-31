Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48F55A8480
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 19:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbiHaRip (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiHaRio (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 13:38:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2F7419BC;
        Wed, 31 Aug 2022 10:38:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F05D161B1C;
        Wed, 31 Aug 2022 17:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB337C433D7;
        Wed, 31 Aug 2022 17:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967522;
        bh=K0hI/bUfvuTrO8Hp5qbhY5nQMSlI4oMg7Xl5KtCfosg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdeGj/O9PDce1uDd4ghDyBT6qqfv8Uae8PkOrdqrd9DaACQQ56WzUAGaFmjDYOb6l
         A0rIcNNyjFeMrHzgEj65MPn0FfpvGVtb2ZCspM4RAVrFDpb55Rl9yKGUCySb81b24x
         BXVxP5+H91eXxYMvlTZbl+bSHWcSUeTKn2hz9ZM+n4oD0qsOP26ipwXQsz7/lxnKrf
         XUfq2n2+5K9obm5e9UST3ihIvzIvn66ClcOKKXLLWhTOFSUWeuI2A1Pr5dfNOMoEsw
         oHmyMBleEkR7+ZdDV03H+nTk2oXazdywjs/XPpFjxTOgikCoNZ7X2UMglSR28r6EN1
         MCrfyfOwvb0zQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/6] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions warning
Date:   Wed, 31 Aug 2022 20:38:24 +0300
Message-Id: <20220831173829.126661-2-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831173829.126661-1-jarkko@kernel.org>
References: <20220831173829.126661-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Kristen Carlson Accardi <kristen@linux.intel.com>

OpenSSL 3.0 deprecates some of the functions used in the SGX
selftests, causing build errors on new distros. For now ignore
the warnings until support for the functions is no longer
available and mark FIXME so that it can be clear this should
be removed at some point.

Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
- Kept because does not exist in tip/x86/sgx, which is the
  maintainer branch for SGX, and is required for selftests.
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
2.37.2

