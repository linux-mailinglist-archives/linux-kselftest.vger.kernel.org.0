Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F1F7094C1
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 May 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjESK2Y (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 May 2023 06:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjESK2W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 May 2023 06:28:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FE410D2
        for <linux-kselftest@vger.kernel.org>; Fri, 19 May 2023 03:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684492062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dpVUKoV13qmSlxZhl7UVQfhf3HY6y+j5TROYuDuVGKc=;
        b=NYRHhubu376ugmr6zvraAVVMOmwyg20/BLPylVV3qx2d38tQeZhMapDZt2px00QpaSne3m
        roEU0RPcvHkaR+NqP5+SC5WYsBio0YO7PPmORfyVLYd2K+uh2qIGiONm2Qp6s+MmybU+Qi
        MZEIbGbl8jqzo9/q/1Cnm89ZSVVcNB8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-282-noILZ21kOdC-g25uQy8reA-1; Fri, 19 May 2023 06:27:36 -0400
X-MC-Unique: noILZ21kOdC-g25uQy8reA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB8361C04B50;
        Fri, 19 May 2023 10:27:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F08C62166B25;
        Fri, 19 May 2023 10:27:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v1 3/3] selftests/mm: gup_longterm: add liburing tests
Date:   Fri, 19 May 2023 12:27:23 +0200
Message-Id: <20230519102723.185721-4-david@redhat.com>
In-Reply-To: <20230519102723.185721-1-david@redhat.com>
References: <20230519102723.185721-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Similar to the COW selftests, also use io_uring fixed buffers to test
if long-term page pinning works as expected.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 tools/testing/selftests/mm/gup_longterm.c | 73 +++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index 44a3617fd423..d33d3e68ffab 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -22,6 +22,9 @@
 #include <linux/memfd.h>
 
 #include "local_config.h"
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+#include <liburing.h>
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
 
 #include "../../../../mm/gup_test.h"
 #include "../kselftest.h"
@@ -80,6 +83,9 @@ enum test_type {
 	TEST_TYPE_RO_FAST,
 	TEST_TYPE_RW,
 	TEST_TYPE_RW_FAST,
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+	TEST_TYPE_IOURING,
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
 };
 
 static void do_test(int fd, size_t size, enum test_type type, bool shared)
@@ -173,6 +179,51 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		ksft_test_result(should_work, "Should have worked\n");
 		break;
 	}
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+	case TEST_TYPE_IOURING: {
+		struct io_uring ring;
+		struct iovec iov;
+
+		/* io_uring always pins pages writable. */
+		if (shared && fs_is_unknown(fs_type)) {
+			ksft_test_result_skip("Unknown filesystem\n");
+			return;
+		}
+		should_work = !shared ||
+			      fs_supports_writable_longterm_pinning(fs_type);
+
+		/* Skip on errors, as we might just lack kernel support. */
+		ret = io_uring_queue_init(1, &ring, 0);
+		if (ret < 0) {
+			ksft_test_result_skip("io_uring_queue_init() failed\n");
+			break;
+		}
+		/*
+		 * Register the range as a fixed buffer. This will FOLL_WRITE |
+		 * FOLL_PIN | FOLL_LONGTERM the range.
+		 */
+		iov.iov_base = mem;
+		iov.iov_len = size;
+		ret = io_uring_register_buffers(&ring, &iov, 1);
+		/* Only new kernels return EFAULT. */
+		if (ret && (errno == ENOSPC || errno == EOPNOTSUPP ||
+			    errno == EFAULT)) {
+			ksft_test_result(!should_work, "Should have failed\n");
+		} else if (ret) {
+			/*
+			 * We might just lack support or have insufficient
+			 * MEMLOCK limits.
+			 */
+			ksft_test_result_skip("io_uring_register_buffers() failed\n");
+		} else {
+			ksft_test_result(should_work, "Should have worked\n");
+			io_uring_unregister_buffers(&ring);
+		}
+
+		io_uring_queue_exit(&ring);
+		break;
+	}
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
 	default:
 		assert(false);
 	}
@@ -310,6 +361,18 @@ static void test_private_ro_fast_pin(int fd, size_t size)
 	do_test(fd, size, TEST_TYPE_RO_FAST, false);
 }
 
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+static void test_shared_iouring(int fd, size_t size)
+{
+	do_test(fd, size, TEST_TYPE_IOURING, true);
+}
+
+static void test_private_iouring(int fd, size_t size)
+{
+	do_test(fd, size, TEST_TYPE_IOURING, false);
+}
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
+
 static const struct test_case test_cases[] = {
 	{
 		"R/W longterm GUP pin in MAP_SHARED file mapping",
@@ -343,6 +406,16 @@ static const struct test_case test_cases[] = {
 		"R/O longterm GUP-fast pin in MAP_PRIVATE file mapping",
 		test_private_ro_fast_pin,
 	},
+#ifdef LOCAL_CONFIG_HAVE_LIBURING
+	{
+		"io_uring fixed buffer with MAP_SHARED file mapping",
+		test_shared_iouring,
+	},
+	{
+		"io_uring fixed buffer with MAP_PRIVATE file mapping",
+		test_private_iouring,
+	},
+#endif /* LOCAL_CONFIG_HAVE_LIBURING */
 };
 
 static void run_test_case(struct test_case const *test_case)
-- 
2.40.1

