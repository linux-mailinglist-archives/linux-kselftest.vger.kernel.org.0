Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DBD42F964
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Oct 2021 18:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbhJORAR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Oct 2021 13:00:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234056AbhJORAR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Oct 2021 13:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634317089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BCCImfJhyHOawDgiSCX14dm7XlnLossWZqBpkklh4Cw=;
        b=czCdG48MNPMldmw5QvnqX2jgucqYVc5plEvncaloiq07usSO9UzEZMYZcD5juLuedR9uxr
        NJNcXBn16rjwjlfB+kuSTm1LBOL7hROf8AlVAzI+YjZAAmpN7BBooo7baos8HsuLCD0K+N
        4S3lteQ3RLE4th/D3YZ8vDrwmTQF6YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-524-KPdbV3pHPqSG91ky1sBnOg-1; Fri, 15 Oct 2021 12:58:06 -0400
X-MC-Unique: KPdbV3pHPqSG91ky1sBnOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50C4310A8E00;
        Fri, 15 Oct 2021 16:58:05 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C1705C1A3;
        Fri, 15 Oct 2021 16:57:59 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1] selftests/vm: make MADV_POPULATE_(READ|WRITE) use in-tree headers
Date:   Fri, 15 Oct 2021 18:57:58 +0200
Message-Id: <20211015165758.41374-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The madv_populate selftest currently builds with a warning when the
local installed headers (via the distribution) don't include
MADV_POPULATE_READ and MADV_POPULATE_WRITE. The warning is correct,
because the test cannot locate the necessary header.

Reason is that the in-tree installed headers (usr/include) have a
"linux" instead of a "sys" subdirectory.

Including "linux/mman.h" instead of "sys/mman.h" doesn't work (e.g.,
mmap() and madvise() are not defined that way). The only
thing that seems to work is including "linux/mman.h" in addition to
"sys/mman.h".

We can get rid of our availability check and simplify.

Reported-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/vm/madv_populate.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
index b959e4ebdad4..3ee0e8275600 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -14,12 +14,11 @@
 #include <unistd.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <linux/mman.h>
 #include <sys/mman.h>
 
 #include "../kselftest.h"
 
-#if defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE)
-
 /*
  * For now, we're using 2 MiB of private anonymous memory for all tests.
  */
@@ -328,15 +327,3 @@ int main(int argc, char **argv)
 				   err, ksft_test_num());
 	return ksft_exit_pass();
 }
-
-#else /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
-
-#warning "missing MADV_POPULATE_READ or MADV_POPULATE_WRITE definition"
-
-int main(int argc, char **argv)
-{
-	ksft_print_header();
-	ksft_exit_skip("MADV_POPULATE_READ or MADV_POPULATE_WRITE not defined\n");
-}
-
-#endif /* defined(MADV_POPULATE_READ) && defined(MADV_POPULATE_WRITE) */
-- 
2.31.1

