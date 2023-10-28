Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1487DA478
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Oct 2023 02:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbjJ1Ait (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Oct 2023 20:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjJ1Aip (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Oct 2023 20:38:45 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB500D47
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:34 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5afa86b8d66so11063297b3.3
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Oct 2023 17:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698453514; x=1699058314; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPstGiI3zb7PZzW8m1s/TtyE02RR3fMaWMy1rl5jbQE=;
        b=BeSptafSteAJ1GLueLN5Xs0S9464cQ+bGDix6+RjP+34ekltXa3wkWpIdTTHJr6Oxi
         hQzW97G8IwhN0NY11Y7fCf3o9LT4dD7Iezc3c1emKdNj6lwrdY87tw/pS7mo8uxFimEp
         TmWkXce2ZJWeP4ZCaeAm3jljkHHEiaAqRdwFQz52vos3qsswhARr34RI3opDXCU15+KL
         q2PS8XEks8jIskgBxTYOxTKIF8+uZ6u4GkXUv6tMt24+/3mqL8wSzgyalnx8b4UIBPbO
         hYFSq88kZ1QITcexW1GNbwenyIP6sdIlk4OhYOr2HD2zpx26YmvwCx85VVStEYvKDI/9
         V+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698453514; x=1699058314;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DPstGiI3zb7PZzW8m1s/TtyE02RR3fMaWMy1rl5jbQE=;
        b=kjsCBJdVgw+moYCAg+92RvhsEKRmAgMdrJENw9ZljLn2HI+E9Peo1YXiBg0kLcaN4P
         NADC/VHRcPjZKAcaJBEjfgEkZrios9KiddAchWb7H3s/M3iUOjH9/5xUntVyKfcaEi5T
         Di13pjrLluAizhQ/aVC3oThSyY/tJKeAn5koGhJMzZiBUaTM/W24/Y42Z98r91fMeQLY
         v+6NNPjB4+efkWIhEZqqKsq4fhv5oN939AY7V5/KWorZFBDF/0ijsV7mYIKPh8flHKJi
         Y9P5ieXEdDARmwKy3CX5xTmBvBjtERGsPvlWxLbbDrp6rnOG6M9kUQKJJVVGfAs/S/R2
         KPlQ==
X-Gm-Message-State: AOJu0Yz4aonU3rGA7iJtAGEhsZGN03XRdrWBcfq2yelOMSG5C8hsV8qa
        bdpEhulCp6OhUWSVhzi8HOI3jw6K/gc=
X-Google-Smtp-Source: AGHT+IHkyagOv7vQjaKfa8YJr6CBe53G6nlWj5O4BlA1iQSMbHSpme2yM6964WYBoEz45GQ9XcUSJSde3/4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:cba3:7e7f:79e4:fa57])
 (user=surenb job=sendgmr) by 2002:a81:6d17:0:b0:59b:c6bb:babb with SMTP id
 i23-20020a816d17000000b0059bc6bbbabbmr87372ywc.6.1698453513868; Fri, 27 Oct
 2023 17:38:33 -0700 (PDT)
Date:   Fri, 27 Oct 2023 17:38:15 -0700
In-Reply-To: <20231028003819.652322-1-surenb@google.com>
Mime-Version: 1.0
References: <20231028003819.652322-1-surenb@google.com>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
Message-ID: <20231028003819.652322-6-surenb@google.com>
Subject: [PATCH v4 5/5] selftests/mm: add UFFDIO_MOVE ioctl test
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     viro@zeniv.linux.org.uk, brauner@kernel.org, shuah@kernel.org,
        aarcange@redhat.com, lokeshgidra@google.com, peterx@redhat.com,
        david@redhat.com, hughd@google.com, mhocko@suse.com,
        axelrasmussen@google.com, rppt@kernel.org, willy@infradead.org,
        Liam.Howlett@oracle.com, jannh@google.com, zhangpeng362@huawei.com,
        bgeffon@google.com, kaleshsingh@google.com, ngeoffray@google.com,
        jdduke@google.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add tests for new UFFDIO_MOVE ioctl which uses uffd to move source
into destination buffer while checking the contents of both after
the move. After the operation the content of the destination buffer
should match the original source buffer's content while the source
buffer should be zeroed. Separate tests are designed for PMD aligned and
unaligned cases because they utilize different code paths in the kernel.

Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 tools/testing/selftests/mm/uffd-common.c     |  24 ++++
 tools/testing/selftests/mm/uffd-common.h     |   1 +
 tools/testing/selftests/mm/uffd-unit-tests.c | 141 +++++++++++++++++++
 3 files changed, 166 insertions(+)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 69e6653ad255..98957fd788d8 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -643,6 +643,30 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 	return __copy_page(ufd, offset, false, wp);
 }
 
+int move_page(int ufd, unsigned long offset)
+{
+	struct uffdio_move uffdio_move;
+
+	if (offset >= nr_pages * page_size)
+		err("unexpected offset %lu\n", offset);
+	uffdio_move.dst = (unsigned long) area_dst + offset;
+	uffdio_move.src = (unsigned long) area_src + offset;
+	uffdio_move.len = page_size;
+	uffdio_move.mode = UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES;
+	uffdio_move.move = 0;
+	if (ioctl(ufd, UFFDIO_MOVE, &uffdio_move)) {
+		/* real retval in uffdio_move.move */
+		if (uffdio_move.move != -EEXIST)
+			err("UFFDIO_MOVE error: %"PRId64,
+			    (int64_t)uffdio_move.move);
+		wake_range(ufd, uffdio_move.dst, page_size);
+	} else if (uffdio_move.move != page_size) {
+		err("UFFDIO_MOVE error: %"PRId64, (int64_t)uffdio_move.move);
+	} else
+		return 1;
+	return 0;
+}
+
 int uffd_open_dev(unsigned int flags)
 {
 	int fd, uffd;
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 19930fd6682b..c9526b2cb6b3 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -121,6 +121,7 @@ void wp_range(int ufd, __u64 start, __u64 len, bool wp);
 void uffd_handle_page_fault(struct uffd_msg *msg, struct uffd_args *args);
 int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
+int move_page(int ufd, unsigned long offset);
 void *uffd_poll_thread(void *arg);
 
 int uffd_open_dev(unsigned int flags);
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index debc423bdbf4..89e9529ce941 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1064,6 +1064,133 @@ static void uffd_poison_test(uffd_test_args_t *targs)
 	uffd_test_pass();
 }
 
+static void uffd_move_handle_fault(
+	struct uffd_msg *msg, struct uffd_args *args)
+{
+	unsigned long offset;
+
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
+
+	if (msg->arg.pagefault.flags &
+	    (UFFD_PAGEFAULT_FLAG_WP | UFFD_PAGEFAULT_FLAG_MINOR | UFFD_PAGEFAULT_FLAG_WRITE))
+		err("unexpected fault type %llu", msg->arg.pagefault.flags);
+
+	offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
+	offset &= ~(page_size-1);
+
+	if (move_page(uffd, offset))
+		args->missing_faults++;
+}
+
+static void uffd_move_test(uffd_test_args_t *targs)
+{
+	unsigned long nr;
+	pthread_t uffd_mon;
+	char c;
+	unsigned long long count;
+	struct uffd_args args = { 0 };
+
+	/* Prevent source pages from being mapped more than once */
+	if (madvise(area_src, nr_pages * page_size, MADV_DONTFORK))
+		err("madvise(MADV_DONTFORK) failure");
+
+	if (uffd_register(uffd, area_dst, nr_pages * page_size,
+			  true, false, false))
+		err("register failure");
+
+	args.handle_fault = uffd_move_handle_fault;
+	if (pthread_create(&uffd_mon, NULL, uffd_poll_thread, &args))
+		err("uffd_poll_thread create");
+
+	/*
+	 * Read each of the pages back using the UFFD-registered mapping. We
+	 * expect that the first time we touch a page, it will result in a missing
+	 * fault. uffd_poll_thread will resolve the fault by moving source
+	 * page to destination.
+	 */
+	for (nr = 0; nr < nr_pages; nr++) {
+		/* Check area_src content */
+		count = *area_count(area_src, nr);
+		if (count != count_verify[nr])
+			err("nr %lu source memory invalid %llu %llu\n",
+			    nr, count, count_verify[nr]);
+
+		/* Faulting into area_dst should move the page */
+		count = *area_count(area_dst, nr);
+		if (count != count_verify[nr])
+			err("nr %lu memory corruption %llu %llu\n",
+			    nr, count, count_verify[nr]);
+
+		/* Re-check area_src content which should be empty */
+		count = *area_count(area_src, nr);
+		if (count != 0)
+			err("nr %lu move failed %llu %llu\n",
+			    nr, count, count_verify[nr]);
+	}
+
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
+	if (pthread_join(uffd_mon, NULL))
+		err("join() failed");
+
+	if (args.missing_faults != nr_pages || args.minor_faults != 0)
+		uffd_test_fail("stats check error");
+	else
+		uffd_test_pass();
+}
+
+static int prevent_hugepages(void)
+{
+	/* This should be done before source area is populated */
+	if (madvise(area_src, nr_pages * page_size, MADV_NOHUGEPAGE)) {
+		/* Ignore if CONFIG_TRANSPARENT_HUGEPAGE=n */
+		if (errno != EINVAL)
+			return -errno;
+	}
+	return 0;
+}
+
+struct uffd_test_case_ops uffd_move_test_case_ops = {
+	.post_alloc = prevent_hugepages,
+};
+
+#define ALIGN_UP(x, align_to) \
+	(__typeof__(x))((((unsigned long)(x)) + ((align_to)-1)) & ~((align_to)-1))
+
+static char *orig_area_src, *orig_area_dst;
+static int pmd_align_areas(void)
+{
+	orig_area_src = area_src;
+	orig_area_dst = area_dst;
+	area_src = ALIGN_UP(area_src, page_size);
+	area_dst = ALIGN_UP(area_dst, page_size);
+	nr_pages--;
+
+	return 0;
+}
+
+static void pmd_restore_areas(void)
+{
+	area_src = orig_area_src;
+	area_dst = orig_area_dst;
+	nr_pages++;
+}
+
+static int adjust_page_size(void)
+{
+	page_size = default_huge_page_size();
+	nr_pages = UFFD_TEST_MEM_SIZE / page_size;
+
+	return 0;
+}
+
+struct uffd_test_case_ops uffd_move_pmd_test_case_ops = {
+	.pre_alloc = adjust_page_size,
+	.post_alloc = pmd_align_areas,
+	.pre_release = pmd_restore_areas,
+};
+
 /*
  * Test the returned uffdio_register.ioctls with different register modes.
  * Note that _UFFDIO_ZEROPAGE is tested separately in the zeropage test.
@@ -1141,6 +1268,20 @@ uffd_test_case_t uffd_tests[] = {
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = 0,
 	},
+	{
+		.name = "move",
+		.uffd_fn = uffd_move_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_test_case_ops,
+	},
+	{
+		.name = "move-pmd",
+		.uffd_fn = uffd_move_test,
+		.mem_targets = MEM_ANON,
+		.uffd_feature_required = UFFD_FEATURE_MOVE,
+		.test_case_ops = &uffd_move_pmd_test_case_ops,
+	},
 	{
 		.name = "wp-fork",
 		.uffd_fn = uffd_wp_fork_test,
-- 
2.42.0.820.g83a721a137-goog

