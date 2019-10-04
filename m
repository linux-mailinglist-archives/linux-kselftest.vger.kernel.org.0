Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A64B3CB5D1
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2019 10:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387535AbfJDINq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Oct 2019 04:13:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39782 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfJDINq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Oct 2019 04:13:46 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iGIic-0001Rs-IS; Fri, 04 Oct 2019 08:13:42 +0000
From:   Colin King <colin.king@canonical.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kvm: selftests: fix spelling mistake: missmatch -> mismatch
Date:   Fri,  4 Oct 2019 09:13:42 +0100
Message-Id: <20191004081342.22108-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in in an error message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/kvm/lib/sparsebit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 031ba3c932ed..59ffba902e61 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -1866,7 +1866,7 @@ void sparsebit_validate_internal(struct sparsebit *s)
 		 * of total bits set.
 		 */
 		if (s->num_set != total_bits_set) {
-			fprintf(stderr, "Number of bits set missmatch,\n"
+			fprintf(stderr, "Number of bits set mismatch,\n"
 				"  s->num_set: 0x%lx total_bits_set: 0x%lx",
 				s->num_set, total_bits_set);
 
-- 
2.20.1

