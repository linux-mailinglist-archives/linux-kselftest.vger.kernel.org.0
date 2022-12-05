Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9520764340C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 20:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234495AbiLETlx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 14:41:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234407AbiLETlT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 14:41:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33623275D3
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 11:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670269052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWQ4pPsBzpe6OTUvcnaLk/UT4hr86kNhRIgvcHh2HCk=;
        b=Vfxu6h4Ol9tHBxo1i41FgYmTo5oSIXB3v+drBMAxZtd1z8eGT1YgPSnMLBhJGH4OIlSpdF
        Fevq47K01nm44GmWR/VNijQ9XkMb7Fb9u/3SNPoWmzCk0lsDuNr7Dr4ehFUp/sWTwuSC+B
        Apsk0igJ6mzL31pOPSA/NDzKQg/LR8w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-ajpONTwvN6mbx4Wv6398SA-1; Mon, 05 Dec 2022 14:37:28 -0500
X-MC-Unique: ajpONTwvN6mbx4Wv6398SA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD9F78569A4;
        Mon,  5 Dec 2022 19:37:27 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E57F2028CE4;
        Mon,  5 Dec 2022 19:37:26 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH mm-unstable v1 3/4] selftests/vm: cow: fix compile warning on 32bit
Date:   Mon,  5 Dec 2022 20:37:15 +0100
Message-Id: <20221205193716.276024-4-david@redhat.com>
In-Reply-To: <20221205193716.276024-1-david@redhat.com>
References: <20221205193716.276024-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The compiler complains about the conversion of a pointer to an int of
different width.

Fixes: 6f1405efc61b ("selftests/vm: anon_cow: add R/O longterm tests via gup_test")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/cow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/cow.c b/tools/testing/selftests/vm/cow.c
index 73e05b52c49e..26f6ea3079e2 100644
--- a/tools/testing/selftests/vm/cow.c
+++ b/tools/testing/selftests/vm/cow.c
@@ -650,7 +650,7 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	}
 
 	/* Take a R/O pin. This should trigger unsharing. */
-	args.addr = (__u64)mem;
+	args.addr = (__u64)(uintptr_t)mem;
 	args.size = size;
 	args.flags = fast ? PIN_LONGTERM_TEST_FLAG_USE_FAST : 0;
 	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_START, &args);
@@ -669,7 +669,7 @@ static void do_test_ro_pin(char *mem, size_t size, enum ro_pin_test test,
 	 * Read back the content via the pin to the temporary buffer and
 	 * test if we observed the modification.
 	 */
-	tmp_val = (__u64)tmp;
+	tmp_val = (__u64)(uintptr_t)tmp;
 	ret = ioctl(gup_fd, PIN_LONGTERM_TEST_READ, &tmp_val);
 	if (ret)
 		ksft_test_result_fail("PIN_LONGTERM_TEST_READ failed\n");
-- 
2.38.1

