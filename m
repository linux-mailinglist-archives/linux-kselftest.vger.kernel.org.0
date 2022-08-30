Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2825A59C0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 05:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiH3DMc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 23:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiH3DM3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 23:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9708F97D;
        Mon, 29 Aug 2022 20:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9748C614CE;
        Tue, 30 Aug 2022 03:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7832C433C1;
        Tue, 30 Aug 2022 03:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661829147;
        bh=nzCc4zxnmZ1AVayNfTK5umfHZuNG574BWi7DauR6Bmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PU+G5iPJ+EIOyDM1BakmlsKxZm+S9tXxGHZOa8s66X1TKldF57d+UFx5GTyL6Y6E2
         RTmcWqWH/NtLtqtVwMNYQbjEFdK8NGsTwq6Ihdflpxwk/rU0aUjxQL8FEKKkZnwbxt
         bnVTx+1MTYhllJtf4U8QK9To36THtEXfffQfIz6aVUCLoWBzb7cWN6SyrMYWrjwwya
         QANMwP9bHWXLsbpHcOzT04mF/z1o3aTXmkXb3oJpL6KtrLNg4tWi/TFhmzHTRRXr98
         1IQ3flCMM0CQY6Y0hSDqgE32s5GPpnYuZV7aS2q6OAL2qTfaItvPBVJP3RdLtI6S8A
         sScSwyaObN7+Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/6] selftests/sgx: Ignore OpenSSL 3.0 deprecated functions warning
Date:   Tue, 30 Aug 2022 06:12:03 +0300
Message-Id: <20220830031206.13449-4-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830031206.13449-1-jarkko@kernel.org>
References: <20220830031206.13449-1-jarkko@kernel.org>
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

