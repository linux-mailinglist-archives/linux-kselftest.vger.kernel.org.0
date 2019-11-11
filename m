Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B106F7036
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2019 10:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfKKJMj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Nov 2019 04:12:39 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44753 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfKKJMj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Nov 2019 04:12:39 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iU5kS-0002aQ-LI; Mon, 11 Nov 2019 09:12:36 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org
Subject: [PATCH][next] kselftest: arm64: fix spelling mistake "contiguos" -> "contiguous"
Date:   Mon, 11 Nov 2019 09:12:36 +0000
Message-Id: <20191111091236.37165-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message literal string. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index e3521949b800..61ebcdf63831 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -43,7 +43,7 @@ bool validate_extra_context(struct extra_context *extra, char **err)
 	else if (extra->size & 0x0fUL)
 		*err = "Extra SIZE misaligned";
 	else if (extra->datap != (uint64_t)term + sizeof(*term))
-		*err = "Extra DATAP misplaced (not contiguos)";
+		*err = "Extra DATAP misplaced (not contiguous)";
 	if (*err)
 		return false;
 
-- 
2.20.1

