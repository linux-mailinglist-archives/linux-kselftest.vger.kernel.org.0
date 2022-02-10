Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89B84B1405
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Feb 2022 18:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245105AbiBJRUD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Feb 2022 12:20:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240659AbiBJRUD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Feb 2022 12:20:03 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24038E6F;
        Thu, 10 Feb 2022 09:20:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 539FB1F466D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644513602;
        bh=4ZRzOeA0BzZmQCrJSjrLre8JwtBFUH2qQEzwvoHCRi4=;
        h=From:To:Cc:Subject:Date:From;
        b=V/OLGQ+psRen6xBS33RM8DqRuDn97x5Kalyng14L7bkSGJ6rQRU1hYNOnceQxbmkx
         cS7FrnfrTLdFD+ZmrWWCmZMXkPC+PF864rTB2IQAqj/zh8piq3BzBs99nOpxlG3XP4
         GL7RswdbHNGA93WgKd7ekXUjRBIgSd+XUR0Ssjn037F4posi8WIe2Ltyv+UCY5/vHl
         jEDZjGic5/hIyIG7uQqdKavRLhhyyC+rICVvRCpHpMIPSMwd6bDmMStPlKSnjdbcZc
         Ur29n8aqYWLcg3DgA+LuWoTiO0CkgGBfCD49N6QcFcb4zsP0u7/NOpccIGmTMGntj7
         QycNfl0F8pJvA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Peter Gonda <pgonda@google.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kernelci@groups.io,
        "kernelci.org bot" <bot@kernelci.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftest: KVM: Remove absent target file
Date:   Thu, 10 Feb 2022 22:19:29 +0500
Message-Id: <20220210171929.1312078-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is no vmx_pi_mmio_test file. Remove it to get rid of error while
creation of selftest archive:

rsync: [sender] link_stat "/kselftest/kvm/x86_64/vmx_pi_mmio_test" failed: No such file or directory (2)
rsync error: some files/attrs were not transferred (see previous errors) (code 23) at main.c(1333) [sender=3.2.3]

Fixes: 6a58150859fd ("selftest: KVM: Add intra host migration tests")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index d61286208e242..b970397f725c7 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -82,7 +82,6 @@ TEST_GEN_PROGS_x86_64 += x86_64/tsc_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_pmu_msrs_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_shinfo_test
 TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
-TEST_GEN_PROGS_x86_64 += x86_64/vmx_pi_mmio_test
 TEST_GEN_PROGS_x86_64 += x86_64/sev_migrate_tests
 TEST_GEN_PROGS_x86_64 += x86_64/amx_test
 TEST_GEN_PROGS_x86_64 += access_tracking_perf_test
-- 
2.30.2

