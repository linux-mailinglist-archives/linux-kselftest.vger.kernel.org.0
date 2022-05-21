Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3ED52FA50
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 11:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiEUJb3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 05:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiEUJb3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 05:31:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D3411827;
        Sat, 21 May 2022 02:31:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 75FC41F465AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653125485;
        bh=3dMeDKqY3YLEhMSIs0CO9t6zKOLkLIvKMHOKgZf/DuQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BjJk1R0tq2GiDgTp76STFBfMiCalouZTodeU5zvMk3XqSIty4a2S7D7q9DCJHnBPf
         oRnLsPiClpXPCqzPAvrxARLXv18nykOHpPno0fNPL1jfc8jkRjnJoUT/f9VV7O4vHD
         4yXjxfe1OYqD45lsaEnIFAUW3bOH2EqiN8LKOyZc9taJawkswVREfC20kJcuwC6dRK
         00Ocgr8moMzdc/ghuv579hr9L3Hbjv2eEAgBuaxR4m9e+Z+vYzlmQMU+H9I/e+oxRZ
         GXl8z5eziOewST4FFXbAxhb/1OuaW11DywGholPSS7kaEGhC+zKqY/ATU7hMUdGpaX
         292FWcUFgEY6g==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yang Weijiang <weijiang.yang@intel.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: correct the renamed test name in .gitignore
Date:   Sat, 21 May 2022 14:30:17 +0500
Message-Id: <20220521093017.148149-1-usama.anjum@collabora.com>
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

Correct the vmx_pmu_caps_test test name from vmx_pmu_msrs_test in
.gitignore file.

Fixes: dc8a9febbab0 ("KVM: selftests: x86: Fix test failure on arch lbr capable platforms")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/.gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index b2f3c2168d69a..2c17c31fb4494 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -56,7 +56,7 @@
 /x86_64/xen_shinfo_test
 /x86_64/xen_vmcall_test
 /x86_64/xss_msr_test
-/x86_64/vmx_pmu_msrs_test
+/x86_64/vmx_pmu_caps_test
 /access_tracking_perf_test
 /demand_paging_test
 /dirty_log_test
-- 
2.30.2

