Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0843746BC26
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Dec 2021 14:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236749AbhLGNJr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Dec 2021 08:09:47 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:38016
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236847AbhLGNJr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Dec 2021 08:09:47 -0500
Received: from mussarela.. (unknown [191.23.94.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 5A3F33F051;
        Tue,  7 Dec 2021 13:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1638882372;
        bh=pfD3hfjfBHQLHEt8+m6l+yGjSs+9S0CZh8LkB9uKIEI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=IGN66SNBhGbgESvzIgH66Zkq68fAioBytkskSs0gtHv2qEUNvRkTXMBgZcZ35SEAo
         Zg3ITm7VTfHma1leKyg8yseZIjlHAXE8xe2nZN4pOW9CB5jkBCzapsWtfiQflSengO
         pJU5K2YUSedpKmVN8GzJk6nx3+es7LVGIzCa6REuavZffcWZcMfcR69B9R+PhqQWSG
         LH3Bvj7GST8Bma9cqhnHqbgmQDQJC/Fe52kt42TuSPaJAZPdFr3HNJYMo1kpY0WABn
         VSHN35sOjWH/eCQilhCV43j2MpWRE6e2e+VniyVteS5/uXhYqLggaPbZLyykNpLOBY
         2uiOVlpNL7MiA==
From:   Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kselftest@vger.kernel.org, mpe@ellerman.id.au
Subject: [PATCH] selftests/powerpc/spectre_v2: Return skip code when miss_percent is high
Date:   Tue,  7 Dec 2021 10:05:57 -0300
Message-Id: <20211207130557.40566-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A mis-match between reported and actual mitigation is not restricted to the
Vulnerable case. The guest might also report the mitigation as "Software
count cache flush" and the host will still mitigate with branch cache
disabled.

So, instead of skipping depending on the detected mitigation, simply skip
whenever the detected miss_percent is the expected one for a fully
mitigated system, that is, above 95%.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
---
 tools/testing/selftests/powerpc/security/spectre_v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/security/spectre_v2.c b/tools/testing/selftests/powerpc/security/spectre_v2.c
index adc2b7294e5f..83647b8277e7 100644
--- a/tools/testing/selftests/powerpc/security/spectre_v2.c
+++ b/tools/testing/selftests/powerpc/security/spectre_v2.c
@@ -193,7 +193,7 @@ int spectre_v2_test(void)
 			 * We are not vulnerable and reporting otherwise, so
 			 * missing such a mismatch is safe.
 			 */
-			if (state == VULNERABLE)
+			if (miss_percent > 95)
 				return 4;
 
 			return 1;
-- 
2.32.0

