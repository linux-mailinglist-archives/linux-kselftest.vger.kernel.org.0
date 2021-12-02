Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC6E466D7C
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 Dec 2021 00:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349485AbhLBXNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 18:13:54 -0500
Received: from vps-vb.mhejs.net ([37.28.154.113]:40758 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244721AbhLBXNy (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 18:13:54 -0500
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1msvDX-0003bw-1M; Fri, 03 Dec 2021 00:10:19 +0100
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: selftests: svm_int_ctl_test: fix intercept calculation
Date:   Fri,  3 Dec 2021 00:10:13 +0100
Message-Id: <49b9571d25588870db5380b0be1a41df4bbaaf93.1638486479.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

INTERCEPT_x are bit positions, but the code was using the raw value of
INTERCEPT_VINTR (4) instead of BIT(INTERCEPT_VINTR).
This resulted in masking of bit 2 - that is, SMI instead of VINTR.

Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
index df04f56ce859..30a81038df46 100644
--- a/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
+++ b/tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
@@ -75,7 +75,7 @@ static void l1_guest_code(struct svm_test_data *svm)
 	vmcb->control.int_ctl &= ~V_INTR_MASKING_MASK;
 
 	/* No intercepts for real and virtual interrupts */
-	vmcb->control.intercept &= ~(1ULL << INTERCEPT_INTR | INTERCEPT_VINTR);
+	vmcb->control.intercept &= ~(BIT(INTERCEPT_INTR) | BIT(INTERCEPT_VINTR));
 
 	/* Make a virtual interrupt VINTR_IRQ_NUMBER pending */
 	vmcb->control.int_ctl |= V_IRQ_MASK | (0x1 << V_INTR_PRIO_SHIFT);
