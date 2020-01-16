Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E742413D6E1
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2020 10:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730597AbgAPJ3P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Jan 2020 04:29:15 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60325 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgAPJ3O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Jan 2020 04:29:14 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1is1SZ-0004ke-RB; Thu, 16 Jan 2020 09:29:03 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Aleksa Sarai <cyphar@cyphar.com>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fix spelling mistaked "chaigned" -> "chained"
Date:   Thu, 16 Jan 2020 09:29:03 +0000
Message-Id: <20200116092903.52690-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/openat2/resolve_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/openat2/resolve_test.c b/tools/testing/selftests/openat2/resolve_test.c
index 7a94b1da8e7b..bbafad440893 100644
--- a/tools/testing/selftests/openat2/resolve_test.c
+++ b/tools/testing/selftests/openat2/resolve_test.c
@@ -230,7 +230,7 @@ void test_openat2_opath_tests(void)
 		{ .name = "[in_root] garbage link to /root",
 		  .path = "cheeky/garbageself",	.how.resolve = RESOLVE_IN_ROOT,
 		  .out.path = "root",		.pass = true },
-		{ .name = "[in_root] chainged garbage links to /root",
+		{ .name = "[in_root] chained garbage links to /root",
 		  .path = "abscheeky/garbageself", .how.resolve = RESOLVE_IN_ROOT,
 		  .out.path = "root",		.pass = true },
 		{ .name = "[in_root] relative path to 'root'",
-- 
2.24.0

