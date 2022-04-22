Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051E250C35F
	for <lists+linux-kselftest@lfdr.de>; Sat, 23 Apr 2022 01:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbiDVWia (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 22 Apr 2022 18:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbiDVWhx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 22 Apr 2022 18:37:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF4A9286AB3
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 14:29:58 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f7be51e6a9so11672687b3.22
        for <linux-kselftest@vger.kernel.org>; Fri, 22 Apr 2022 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3u4/NkkFqdFi5mqy1tDjNb7vVlfXM8Eh6uSpLtQT30E=;
        b=ZGYpRbKPRC+XBA+J9Pgv5tGqSeG77393GIEZtav9y5jdJsYVHZu6DE9FQuFF3DOF0J
         FuNiC+t/6dWddinYIxjJazPTVsQGm4aYgH1xVag1JT6yX/rutxG2D6vqOIO+3jvrxoR8
         LlhdASQ+SYkAZPZBLnxf4QMwcqJESUmBcKLtRd4PizkS49zRHMGslMRd8FZVM8HCDQAt
         pWB3BEBVFbk8ZupnaeI9yKetCZBkqXpEgICQya4F2EDK8WndIiiM1gyXfMdKP/S13U/+
         dxciIAdWsYURvLxXEf7S3BZ8X/iFqLMyaOoYK1FYEq3MotK1Ig03rgQM9CL5HwBdNlNN
         PzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3u4/NkkFqdFi5mqy1tDjNb7vVlfXM8Eh6uSpLtQT30E=;
        b=HWHSG/Yw+ZWQaFMcsv0WNmdxs3YMeW9CKn3DYxwbTfMxcgTX74Y/B9MHub/Lb90cLp
         NXeoJenpvzG+OZo3/KfmGb5dIdSFvi+Xqj75/Ri7eWIUa/xpMae7QnMxKJEtymtYoexW
         0B20cF3lB5WqTU5mTG3H4lDZICThRrTke3BUdxFyCrqTh81MHfKh9kH4/GvMbfqFITcg
         6DptHbSkmaggXYyFtD8SsBUzOB319csT8/gWpGDuHV1JfkHP4DzRHn5atS59DL7Ul76M
         STdJrUOZHDNsz7NcLXyUBfXBUY1zqb9ykXx7JsFipyhQDjym/QuNM44AlM7DrlmYnGq+
         Hv+g==
X-Gm-Message-State: AOAM530zLuZi7tMJ3aGkqXFkPzWtLTSL1XX5oZKSgu83c94xfTD4Ru0A
        7YaF8tP1kI9JpYlPWZCVgp33qDeKCDi8O611kRha
X-Google-Smtp-Source: ABdhPJwut5kVL9//x/VuhvU7tnMAPFLYjWnVV3LoUrrKiz5XT6olvUf5+q/YJhl4rhX6qANLKIq5vC52x37lwR9oMUtA
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:7ba6:20ac:a8f7:1dbd])
 (user=axelrasmussen job=sendgmr) by 2002:a25:40c4:0:b0:645:88a3:eb8b with
 SMTP id n187-20020a2540c4000000b0064588a3eb8bmr5324286yba.193.1650662997965;
 Fri, 22 Apr 2022 14:29:57 -0700 (PDT)
Date:   Fri, 22 Apr 2022 14:29:42 -0700
In-Reply-To: <20220422212945.2227722-1-axelrasmussen@google.com>
Message-Id: <20220422212945.2227722-4-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220422212945.2227722-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.36.0.rc2.479.g8af0fa9b8e-goog
Subject: [PATCH v2 3/6] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Hugh Dickins <hughd@google.com>, Jan Kara <jack@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, Nadav Amit <namit@vmware.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, zhangyi <yi.zhang@huawei.com>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We clearly want to ensure both userfaultfd(2) and /dev/userfaultfd keep
working into the future, so just run the test twice, using each
interface.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 31 ++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 92a4516f8f0d..12ae742a9981 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -77,6 +77,9 @@ static int bounces;
 #define TEST_SHMEM	3
 static int test_type;
 
+/* test using /dev/userfaultfd, instead of userfaultfd(2) */
+static bool test_dev_userfaultfd;
+
 /* exercise the test_uffdio_*_eexist every ALARM_INTERVAL_SECS */
 #define ALARM_INTERVAL_SECS 10
 static volatile bool test_uffdio_copy_eexist = true;
@@ -383,13 +386,31 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
 	}
 }
 
+static void __userfaultfd_open_dev(void)
+{
+	int fd;
+
+	uffd = -1;
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return;
+
+	uffd = ioctl(fd, USERFAULTFD_IOC_NEW,
+		     O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
+	close(fd);
+}
+
 static void userfaultfd_open(uint64_t *features)
 {
 	struct uffdio_api uffdio_api;
 
-	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
+	if (test_dev_userfaultfd)
+		__userfaultfd_open_dev();
+	else
+		uffd = syscall(__NR_userfaultfd,
+			       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
 	if (uffd < 0)
-		err("userfaultfd syscall not available in this kernel");
+		err("creating userfaultfd failed");
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
@@ -1698,6 +1719,12 @@ int main(int argc, char **argv)
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
+
+	test_dev_userfaultfd = false;
+	if (userfaultfd_stress())
+		return 1;
+
+	test_dev_userfaultfd = true;
 	return userfaultfd_stress();
 }
 
-- 
2.36.0.rc2.479.g8af0fa9b8e-goog

