Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1050D517A35
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 May 2022 00:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbiEBWxl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 May 2022 18:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235479AbiEBWxk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 May 2022 18:53:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8077A11A2B
        for <linux-kselftest@vger.kernel.org>; Mon,  2 May 2022 15:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651531787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=teevnqkm14nHJRBfyCMDeZXlCSbdTUq69zQhC9ksboU=;
        b=WqWhDi9kOK65G7rpIqYDDlJ6nMOlHDNicH+AC+vwaB5rRc89G9YWs3vL+ekJzdpISccA9l
        y/fg0duSvKgZjb955XFpPv5rKyBRNV2kXKofencDhtjmVx2zX4X0tx4DAtVciwVPnTspLk
        Gw2FHZZGCDK17fP8T56KG0xXb0aMCSU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-528-cj8PsvapOTaO0EDOQlRiCQ-1; Mon, 02 May 2022 18:49:46 -0400
X-MC-Unique: cj8PsvapOTaO0EDOQlRiCQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0091C3C10AA2;
        Mon,  2 May 2022 22:49:46 +0000 (UTC)
Received: from jsavitz-csb.redhat.com (unknown [10.22.10.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 885AD554A1E;
        Mon,  2 May 2022 22:49:45 +0000 (UTC)
From:   Joel Savitz <jsavitz@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Nico Pache <npache@redhat.com>,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: clarify common error when running gup_test
Date:   Mon,  2 May 2022 18:49:42 -0400
Message-Id: <20220502224942.995427-1-jsavitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


The gup_test binary will fail showing only the output of perror("open") in
the case that /sys/kernel/debug/gup_test is not found. This will almost
always be due to CONFIG_GUP_TEST not being set, which enables
compilation of a kernel that provides this file.

Add a short error message to clarify this failure and point the user to
the solution.

Signed-off-by: Joel Savitz <jsavitz@redhat.com>
---
 tools/testing/selftests/vm/gup_test.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index cda837a14736..ac4e804d47f0 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -18,6 +18,8 @@
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 
+#define GUP_TEST_FILE "/sys/kernel/debug/gup_test"
+
 static unsigned long cmd = GUP_FAST_BENCHMARK;
 static int gup_fd, repeats = 1;
 static unsigned long size = 128 * MB;
@@ -204,9 +206,11 @@ int main(int argc, char **argv)
 	if (write)
 		gup.gup_flags |= FOLL_WRITE;
 
-	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	gup_fd = open(GUP_TEST_FILE, O_RDWR);
 	if (gup_fd == -1) {
 		perror("open");
+		fprintf(stderr, "Unable to open %s: check that CONFIG_GUP_TEST=y\n",
+				GUP_TEST_FILE);
 		exit(1);
 	}
 
-- 
2.27.0

