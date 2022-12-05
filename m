Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B8C643405
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Dec 2022 20:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbiLETld (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 14:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiLETlO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 14:41:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879BE286E6
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 11:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670269047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=839Tn9IdUKD1bh/4wO2u5vVCxR5w23tzArKt5zK/zSI=;
        b=YZ0A0JnpGGAv9V+Aw2H3tVUl+qAXB/WtuKgXcGw+KXbuvXZzCAJdaZLay6O8Q73D100xOS
        H8wO690DirUBtFDYW5YU/mDFWeIwI4O2YCKKWo/VBnjwgd4EQc8PbEuEVqFVyl6gVUvpMm
        D8cMzxUBfCVDYv34mw0IPajpUakCU5M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-190-jwXJRswbMtG5Lezn7_olIw-1; Mon, 05 Dec 2022 14:37:24 -0500
X-MC-Unique: jwXJRswbMtG5Lezn7_olIw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2489686F12A;
        Mon,  5 Dec 2022 19:37:24 +0000 (UTC)
Received: from t480s.fritz.box (unknown [10.39.193.244])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 475E920290A5;
        Mon,  5 Dec 2022 19:37:22 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH mm-unstable v1 1/4] mm/gup_test: fix PIN_LONGTERM_TEST_READ with highmem
Date:   Mon,  5 Dec 2022 20:37:13 +0100
Message-Id: <20221205193716.276024-2-david@redhat.com>
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

... we have to kmap()/kunmap(), otherwise this won't work as expected
with highmem.

Fixes: c77369b437f9 ("mm/gup_test: start/stop/read functionality for PIN LONGTERM test")
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/gup_test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 0d76d9b4bb5a..33f431e0da60 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -4,6 +4,7 @@
 #include <linux/uaccess.h>
 #include <linux/ktime.h>
 #include <linux/debugfs.h>
+#include <linux/highmem.h>
 #include "gup_test.h"
 
 static void put_back_pages(unsigned int cmd, struct page **pages,
@@ -297,10 +298,13 @@ static inline int pin_longterm_test_read(unsigned long arg)
 		return -EFAULT;
 
 	for (i = 0; i < pin_longterm_test_nr_pages; i++) {
-		void *addr = page_to_virt(pin_longterm_test_pages[i]);
+		void *addr = kmap_local_page(pin_longterm_test_pages[i]);
+		unsigned long ret;
 
-		if (copy_to_user((void __user *)(unsigned long)user_addr, addr,
-				 PAGE_SIZE))
+		ret = copy_to_user((void __user *)(unsigned long)user_addr, addr,
+				   PAGE_SIZE);
+		kunmap_local(addr);
+		if (ret)
 			return -EFAULT;
 		user_addr += PAGE_SIZE;
 	}
-- 
2.38.1

