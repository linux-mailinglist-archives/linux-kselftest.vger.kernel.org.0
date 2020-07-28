Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20192230E5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jul 2020 17:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730750AbgG1PvK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jul 2020 11:51:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59651 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730671AbgG1PvK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jul 2020 11:51:10 -0400
Received: from 1.general.cascardo.us.vpn ([10.172.70.58] helo=localhost.localdomain)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <cascardo@canonical.com>)
        id 1k0Rsb-0007kg-96; Tue, 28 Jul 2020 15:51:01 +0000
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Shuah Khan <shuah@kernel.org>, cascardo@canonical.com,
        linuxppc-dev@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: return skip code for spectre_v2
Date:   Tue, 28 Jul 2020 12:50:39 -0300
Message-Id: <20200728155039.401445-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When running under older versions of qemu of under newer versions with old
machine types, some security features will not be reported to the guest.
This will lead the guest OS to consider itself Vulnerable to spectre_v2.

So, spectre_v2 test fails in such cases when the host is mitigated and miss
predictions cannot be detected as expected by the test.

Make it return the skip code instead, for this particular case. We don't
want to miss the case when the test fails and the system reports as
mitigated or not affected. But it is not a problem to miss failures when
the system reports as Vulnerable.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/powerpc/security/spectre_v2.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/powerpc/security/spectre_v2.c b/tools/testing/selftests/powerpc/security/spectre_v2.c
index 8c6b982af2a8..d5445bfd63ed 100644
--- a/tools/testing/selftests/powerpc/security/spectre_v2.c
+++ b/tools/testing/selftests/powerpc/security/spectre_v2.c
@@ -183,6 +183,14 @@ int spectre_v2_test(void)
 		if (miss_percent > 15) {
 			printf("Branch misses > 15%% unexpected in this configuration!\n");
 			printf("Possible mis-match between reported & actual mitigation\n");
+			/* Such a mismatch may be caused by a guest system
+			 * reporting as vulnerable when the host is mitigated.
+			 * Return skip code to avoid detecting this as an
+			 * error. We are not vulnerable and reporting otherwise,
+			 * so missing such a mismatch is safe.
+			 */
+			if (state == VULNERABLE)
+				return 4;
 			return 1;
 		}
 		break;
-- 
2.25.1

