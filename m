Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9164FEA5E
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Apr 2022 01:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbiDLXaZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Apr 2022 19:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiDLX3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Apr 2022 19:29:31 -0400
Received: from mail-oi1-x249.google.com (mail-oi1-x249.google.com [IPv6:2607:f8b0:4864:20::249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E7516809D
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Apr 2022 15:30:44 -0700 (PDT)
Received: by mail-oi1-x249.google.com with SMTP id k25-20020a544699000000b002fa69ba89b6so84971oic.19
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Apr 2022 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=u+9yLdrvqv+15A9PShNP0Bj2lgMYcE44VCQG0+LZtrY=;
        b=mwfr+1QL20PQIeOZQZw4zuZEGgBuBUOGgqdqpg6THGQZKaFw5Wj8PV8H59rdqaaBLU
         96DEcj2/yCle2oJspe3XQ+wvE7SynQC2qq8T45bjBHdWr775iHRDb1Awf9JLNlMzGg0Z
         g9Vavh5XkBcZCDWPUCYqQaA2bJ40hvxQocKz/LgmqNRswWSq0TrGjsidj6Uh160Cxgg9
         Br/LGeUfE2qBk04WfS9pWdcxkZ6ZfhQUGAQUPaDVZVTwx2AivA1G7qb2eWdfFOoTI0KO
         79/zwiYoOluzurGB1K8giL4K789L/VwUjzCmIrbzk2s/dgPratqPJ30cmLHHGCauiOdw
         Ag0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=u+9yLdrvqv+15A9PShNP0Bj2lgMYcE44VCQG0+LZtrY=;
        b=Z4ZDXVCV4vvbd71yc0gCWstB6gu/k8Da12tAIFirgOVqLFvMRJNuqAWQ6msq3Rn0my
         62fnIoAp8rMWiBB1ny4HMvUEkMEizy1amPU3i6/J/rPrHtByUDtsfubX37U+pGXgU38o
         /SsLEGhYacLbotqZUm7mQrD8Muypkb9oVAThgN05PO5qxmPEae9PHb4RN3NAGMgk9bGM
         ocgmeORTB3yU25tARbYYLHFCBEOjjl5dU2u8zZ+JNC7/mrpmQU10CNum891feCW9EKS0
         qHXJdxztH9lROO+Y78mPg1NWp97orgJSwKCrOV7lb8C2NUFoikFAOQfOqDudUwB/qWB9
         OyuQ==
X-Gm-Message-State: AOAM533jYzQ/31PTrGwP3atdw/iLGxAbnnIS5EfMD59xanjSnhNZm5Zt
        5wxm7g+Us3ddtwTho9qyNtAQa5LhVoMhNPKv3ILp
X-Google-Smtp-Source: ABdhPJzT2Zt45zo3Wf9Ef/5d1NiGtDnKycptXlg/R76ipboiOT8KRuG6nigv1WkYm1tB4Mt/wit/6RMj+xbJNsBmESHI
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:8927:f9ed:8b14:ddae])
 (user=axelrasmussen job=sendgmr) by 2002:a17:90b:3c47:b0:1cb:8121:dcc8 with
 SMTP id pm7-20020a17090b3c4700b001cb8121dcc8mr6997487pjb.35.1649795391430;
 Tue, 12 Apr 2022 13:29:51 -0700 (PDT)
Date:   Tue, 12 Apr 2022 13:29:42 -0700
In-Reply-To: <20220412202942.386981-1-axelrasmussen@google.com>
Message-Id: <20220412202942.386981-2-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20220412202942.386981-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.35.1.1178.g4f1659d476-goog
Subject: [PATCH 2/2] userfaultfd: selftests: modify selftest to use /dev/userfaultfd
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <namit@vmware.com>, Peter Xu <peterx@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Prefer this new interface, but if using it fails for any reason just
fall back to using userfaultfd(2) as before.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 92a4516f8f0d..a50c430f036c 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -383,13 +383,32 @@ static void assert_expected_ioctls_present(uint64_t mode, uint64_t ioctls)
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
+	__userfaultfd_open_dev();
+	if (uffd < 0) {
+		printf("/dev/userfaultfd failed, fallback to userfaultfd(2)\n");
+		uffd = syscall(__NR_userfaultfd,
+			       O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
+	}
 	if (uffd < 0)
-		err("userfaultfd syscall not available in this kernel");
+		err("userfaultfd syscall failed");
 	uffd_flags = fcntl(uffd, F_GETFD, NULL);
 
 	uffdio_api.api = UFFD_API;
-- 
2.35.1.1178.g4f1659d476-goog

