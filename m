Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2643E19C56D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Apr 2020 17:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388942AbgDBPEu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Apr 2020 11:04:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43820 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388744AbgDBPEu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Apr 2020 11:04:50 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jK1NC-00008m-IC; Thu, 02 Apr 2020 15:03:14 +0000
From:   Colin King <colin.king@canonical.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Frank Rowand <frank.rowand@sony.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] kunit: fix dereference of suite before it has been null checked
Date:   Thu,  2 Apr 2020 16:03:14 +0100
Message-Id: <20200402150314.568044-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently pointer 'suite' is dereferenced when variable success
is being initialized before the pointer is null checked. Fix this
by only dereferencing suite after is has been null checked.

Addresses-Coverity: ("Dereference before null check")
Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/kunit/debugfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index 9214c493d8b7..05547642f37c 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -52,12 +52,13 @@ static void debugfs_print_result(struct seq_file *seq,
 static int debugfs_print_results(struct seq_file *seq, void *v)
 {
 	struct kunit_suite *suite = (struct kunit_suite *)seq->private;
-	bool success = kunit_suite_has_succeeded(suite);
+	bool success;
 	struct kunit_case *test_case;
 
 	if (!suite || !suite->log)
 		return 0;
 
+	success = kunit_suite_has_succeeded(suite);
 	seq_printf(seq, "%s", suite->log);
 
 	kunit_suite_for_each_test_case(suite, test_case)
-- 
2.25.1

