Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9326A5A59C8
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Aug 2022 05:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiH3DNe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 23:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiH3DNE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 23:13:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC15D9E0F7;
        Mon, 29 Aug 2022 20:12:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CD4BB81620;
        Tue, 30 Aug 2022 03:12:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CB6C433D6;
        Tue, 30 Aug 2022 03:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661829167;
        bh=FqTQE1AyeMGOdXFby6N3o3vi9Zp1KEJIUZ0giA1CbGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hnJfjHM/mxvhchF0HTEfF7qaNtilwqdQsrzAfkLDUufDLr199hnUVuWI/f383DUPu
         /+dtTMx5CzCpK3nj83oNvi6pMK7ppKunWgZO7eOrNhrkppToOApxjZmxYiFMQJtyZu
         ztBzPUrPQhaLE9k8xXHLfmNENXGn0WNbdF8IPQ3ns1lFr1v7Ls3uvG5kuidjll2CsY
         YVDoOFc3mEVwu8EVZuGxpGH6eJqQ+lyZ/NvO2Tftzkwl8Jno828603vfC09qOWULZc
         kjW6NK8L0xvU2PLnWElqopJUIE/3+euNyGIytTIxW3DsqvS9CiowzA48j1rv7Lta1F
         S6z/m4PmhtMYg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-sgx@vger.kernel.org
Cc:     Haitao Huang <haitao.huang@linux.intel.com>,
        Vijay Dhanraj <vijay.dhanraj@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH 6/6] selftests/sgx: Add a bpftrace script for tracking allocation errors
Date:   Tue, 30 Aug 2022 06:12:06 +0300
Message-Id: <20220830031206.13449-7-jarkko@kernel.org>
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

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 tools/testing/selftests/sgx/alloc-error.bt | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/sgx/alloc-error.bt

diff --git a/tools/testing/selftests/sgx/alloc-error.bt b/tools/testing/selftests/sgx/alloc-error.bt
new file mode 100644
index 000000000000..9268d50dea29
--- /dev/null
+++ b/tools/testing/selftests/sgx/alloc-error.bt
@@ -0,0 +1,7 @@
+kr:sgx_alloc_epc_page /(uint64)retval >= (uint64)(-4095)/ {
+		 printf("sgx_alloc_epc_page: retval=%d\n", (int64)retval);
+}
+
+kr:sgx_encl_page_alloc /(uint64)retval >= (uint64)(-4095)/ {
+		 printf("sgx_encl_page_alloc: retval=%d\n", (int64)retval);
+}
-- 
2.37.2

