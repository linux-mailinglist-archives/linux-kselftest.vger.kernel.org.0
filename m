Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B0D644AB8
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 18:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiLFR7u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Dec 2022 12:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiLFR7n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Dec 2022 12:59:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213D37FA4;
        Tue,  6 Dec 2022 09:59:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C14DAB81AFA;
        Tue,  6 Dec 2022 17:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E36CC433D6;
        Tue,  6 Dec 2022 17:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670349579;
        bh=o0TV1HOPfiH9a0H0xzJPDnxPuLSbs1Q7360odceTfMM=;
        h=From:To:Cc:Subject:Date:From;
        b=Z77ZGSa60WISk2h8lBf+Xh8Q51iFo5TmkWf4Sm2pqqig2+4BC6qhItxkcWkce+1VH
         qX9lc+3JTY0WwcPh7d7WgKd33MDD8Fa1WT4acCfzmC8Yfb9uU3q9cXhYXYXvuaEjCH
         Hs5wCYWsSr+sOHEJthyfq5PjMYWE818UCrxdZ7mKmdSdmCOifhkaJw1Nhe0+RqdfTN
         Imo1rL2yWSkh+HNxr/+zSZqRVPyF03fXL1V1LbaKBvhq7rbbm+TcoeNA35vi59YXdY
         OqrvRUFSZtzZov4i15PHwuCTOJELP2RClE/ukYJK5DZ2fq4dvyxODRM68l+kmelABj
         3VLPpXD7Q08mA==
From:   Mark Brown <broonie@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        Marc Zyngier <maz@kernel.org>,
        David Matlack <dmatlack@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] KVM: selftests: Fix build for memstress.[ch] rename
Date:   Tue,  6 Dec 2022 17:59:16 +0000
Message-Id: <20221206175916.250104-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1381; i=broonie@kernel.org; h=from:subject; bh=o0TV1HOPfiH9a0H0xzJPDnxPuLSbs1Q7360odceTfMM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjj4LzSoPHFfR6xPPjyDoC7F0CIyvHnfthk4EaicFP 0ColOPmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4+C8wAKCRAk1otyXVSH0FkZB/ 99RaWE3a8gxnRIwy76uoedpxJ+mhAIDYoItqYxEAHAiYkgGcBQTPmkQMCWvO7vomTUNBLaKro3TMZ7 FnSMR5SYdf8E5vcdGlNH9MmhwiIizUsd5PpD7g4wO1+YA6+H+CD8rDHurJdvpUaU5c3CP11MJLfVDa KF8YFEjB3Khyx91e2o1d1qimPXtMkILwMTMge0JY98vn6VmHpeLy9HzZ1EIr55B5qquBjUJAteLVnQ PZTVCe83JNUksAad2p/Cphxt6QAI4r6fsg0NsEisuv8mv82+7PLzRsKaPFf87xerZPDiIo+/lEUDUn /TCfuiGPQ/BxqEJRXnRO87Y2tPctbp
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Today's -next fails to build the KVM selftests on at least arm64 due to
commit

 9fda6753c9dd ("KVM: selftests: Rename perf_test_util.[ch] to memstress.[ch]")

interacting poorly with commit

 a93871d0ea9f ("KVM: selftests: Add a userfaultfd library")

which adds a new user of perf_test_util.h.  Do the rename in the new
user.

Fixes: 9fda6753c9dd ("KVM: selftests: Rename perf_test_util.[ch] to memstress.[ch]")
Fixes: a93871d0ea9f ("KVM: selftests: Add a userfaultfd library")
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Ricardo Koller <ricarkol@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: David Matlack <dmatlack@google.com>
Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
 tools/testing/selftests/kvm/lib/userfaultfd_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/userfaultfd_util.c b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
index 3b44846fc277..92cef20902f1 100644
--- a/tools/testing/selftests/kvm/lib/userfaultfd_util.c
+++ b/tools/testing/selftests/kvm/lib/userfaultfd_util.c
@@ -20,7 +20,7 @@
 
 #include "kvm_util.h"
 #include "test_util.h"
-#include "perf_test_util.h"
+#include "memstress.h"
 #include "userfaultfd_util.h"
 
 #ifdef __NR_userfaultfd
-- 
2.30.2

