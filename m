Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660C8662C69
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jan 2023 18:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjAIROm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Jan 2023 12:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjAIROH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Jan 2023 12:14:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FEA3E840
        for <linux-kselftest@vger.kernel.org>; Mon,  9 Jan 2023 09:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673284382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fo9GzvG4z/7wz8H4hq6ngHRCbnPgEy8B7PFW0+5WHAo=;
        b=WMpGc8byRJ8Etl8wCxy8EjsFq3S/z3+mZdnA13W92q4MoL2dMQNnwyLJA6CfKOlfR/F1zX
        W3DhZdtYefRg9+n65giQGdDsuN6r4Q+4k8hLy2VuGxJKA/fklTThAQ3V4cLYzqyEz6XaOp
        qPm+20cBjwVlO3iNZU5JSuKOmjJL968=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-L5VmuwvhO6-Y216kbZTMVQ-1; Mon, 09 Jan 2023 12:12:58 -0500
X-MC-Unique: L5VmuwvhO6-Y216kbZTMVQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6515085CBCB;
        Mon,  9 Jan 2023 17:12:58 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 55480492C14;
        Mon,  9 Jan 2023 17:12:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>
Subject: [PATCH mm-unstable v1] selftests/mm: define MADV_PAGEOUT to fix compilation issues
Date:   Mon,  9 Jan 2023 18:12:55 +0100
Message-Id: <20230109171255.488749-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If MADV_PAGEOUT is not defined (e.g., on AlmaLinux 8), compilation will
fail. Let's fix that like khugepaged.c does by conditionally defining
MADV_PAGEOUT.

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Fixes: 69c66add5663 ("selftests/vm: anon_cow: test COW handling of anonymous memory")
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/cow.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 16216d893d96..0eb2e8180aa5 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -30,6 +30,9 @@
 #include "../kselftest.h"
 #include "vm_util.h"
 
+#ifndef MADV_PAGEOUT
+#define MADV_PAGEOUT 21
+#endif
 #ifndef MADV_COLLAPSE
 #define MADV_COLLAPSE 25
 #endif
-- 
2.39.0

