Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E195455C3
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jun 2022 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbiFIUhq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Jun 2022 16:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiFIUhq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Jun 2022 16:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22225DE81
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Jun 2022 13:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654807064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PRwCAczOEs3oWB79ndk+TRrGu6B70/rR3Wnhg/0mT/M=;
        b=BAYaX70Xm46KB+UrLa0w//d8CwQ7O3CnaM4NtNGEEekTokyInCzrUuP5iV6bP0/heKtSsx
        p7cQABDYVyafXybiwInJb76ys8jOdGeiiZVHAEDqVNYfc0iuFRNbdhHv33fxnLK84acKh4
        8mbpSODhO6GSBkjcTYX1ZhhQ7ZH5fJM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-79-kvgtpqTPPj62Ir5KLx3dGQ-1; Thu, 09 Jun 2022 16:37:43 -0400
X-MC-Unique: kvgtpqTPPj62Ir5KLx3dGQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90A4B80159B;
        Thu,  9 Jun 2022 20:37:42 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.11.108])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 434E71730C;
        Thu,  9 Jun 2022 20:37:42 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, Nico Pache <npache@redhat.com>
Subject: [PATCH] selftests: make use of GUP_TEST_FILE macro
Date:   Thu,  9 Jun 2022 16:32:17 -0400
Message-Id: <20220609203217.3206247-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit 17de1e559cf1 ("selftests: clarify common error when running
gup_test") had most of its hunks dropped due to a conflict with another
patch accepted into Linux around the same time that implemented the same
behavior as a subset of other changes.

However, the remaining hunk defines the GUP_TEST_FILE macro without
making use of it. This patch makes use of the macro in the two relevant
places.

Furthermore, the above mentioned commit's log message erroneously describes
the changes that were dropped from the patch.

This patch corrects the record.

Fixes: 17de1e559cf1 ("selftests: clarify common error when running gup_test")

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/gup_test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 6bb36ca71cb5..a309876d832f 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -209,7 +209,7 @@ int main(int argc, char **argv)
 	if (write)
 		gup.gup_flags |= FOLL_WRITE;
 
-	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	gup_fd = open(GUP_TEST_FILE, O_RDWR);
 	if (gup_fd == -1) {
 		switch (errno) {
 		case EACCES:
@@ -224,7 +224,7 @@ int main(int argc, char **argv)
 			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
 			break;
 		default:
-			perror("failed to open /sys/kernel/debug/gup_test");
+			perror("failed to open " GUP_TEST_FILE);
 			break;
 		}
 		exit(KSFT_SKIP);
-- 
2.31.1

