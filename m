Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4E5A848A
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Aug 2022 19:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiHaRjQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Aug 2022 13:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiHaRjE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Aug 2022 13:39:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E73CD2B35;
        Wed, 31 Aug 2022 10:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F23AB8220A;
        Wed, 31 Aug 2022 17:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD46C433C1;
        Wed, 31 Aug 2022 17:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661967539;
        bh=sWEr2xMf9c7ybMRCB7FvcjLwjU8c0HJfCMDxZvDmsi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hKOF7i2CshRktPzeGXQwfSNA4H3HLA2mer2CnxVIJhQunFzZuaf0PO3W7onzBsAfR
         YpQMKnOqABfenu8nfZyRuAjLt6xmYs8CBqsUXKdYGaI7QGeOcN+vI0JHg8/rzMNnT9
         2gvuJnD2blULZZCCMPQEzPiWqIa02mvUnd+uE36C0HcOC5ExzTtAvXOuOPcvmElh5W
         cyMwpDoqq06AohcnYM72QSQp0yiszyHi8eP0B9qlNJkFnWIyC6ujvKoMeknBak0j2N
         h8OLnBeOSIHDlL0JZ14E14sYq2wTb4waF+lQcFOL6UJtpresw+YBAcGz0RqjvTg8+Z
         eIPPt+47ljMig==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v2 6/6] selftests/sgx: Add a bpftrace script for tracking allocation errors
Date:   Wed, 31 Aug 2022 20:38:29 +0300
Message-Id: <20220831173829.126661-7-jarkko@kernel.org>
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

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
* Added comments.
---
 tools/testing/selftests/sgx/alloc-error.bt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 tools/testing/selftests/sgx/alloc-error.bt

diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
new file mode 100644
index 000000000000..0cc8b2e41852
--- /dev/null
+++ b/tools/testing/selftests/sgx/alloc-error.bt
@@ -0,0 +1,9 @@
+/* EPC allocation */
+kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
+		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
+}
+
+/* kzalloc for struct sgx_encl_page */
+kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
+		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
+}
-- 
2.37.2

