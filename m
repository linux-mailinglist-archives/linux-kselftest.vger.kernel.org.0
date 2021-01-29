Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA21308410
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 04:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhA2DGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jan 2021 22:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhA2DF7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jan 2021 22:05:59 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5A2C061756
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:19 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id e9so5579869pjj.0
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=++jZtzOYyQ1+vtEeMaOUIstaO3RLvVGMYd5LElrs3tk=;
        b=uhyod5IVvkWiHsST5/O68YcC4Axe3RKRQzvKBXYml1+ezIoSduIUXyT3McvxxfQb6X
         MdGdB6a0QGYeKJPc6EOPv4LDPZzHfkLWnQhCaEjmTW+3EDXkZRQFpri3M7TDZpXFwknB
         nzDT/YpZaeczzI5+TCeNblHK1riCKukRLYsO4ZNEgO2aC4WhQT2Ut1dctUoeYX4W6t9T
         ZW828X9T4wU/86xrUnE1rqIASwioP5MyUUMrrPaQuKKUYlALfUnddC1lV5fGS3MkmN8L
         pujzNObUmAqlaJN71GQQzc71PDhg+rwgYMgYwG4kvOBSZEYKrvspyB0LF4dA10Zcxcfq
         DqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=++jZtzOYyQ1+vtEeMaOUIstaO3RLvVGMYd5LElrs3tk=;
        b=tm0tYSU8SJ20tYAGLb9Q/s5jOhuLOvTqxNpPgmi43RDsYlPdhhnFq7I9YOJ1GaR2Qs
         EYuIFiwkte1YROrT7BGc6J7OgAZN4maOb0dJLGfxYOcsqLAo+gH8Zl9TW9W9UVnkWfqL
         X4oXR5aNgBZXh4gfPwM4aUA954nBhntHZMiZHifE9SbXA1QyxCrnK6m3IyOpxm00ZQdq
         2arCSGn14n6KIAp3zbyGdjlts/hOTkqvd7wUqlWX8MT1/jhGTKSj8+nIZ8MMOdhoPofk
         naS2gFLJwjIvouHGAUYlEhtCQnMX5XtDnH5glYRz4muktvP4D+PYrHIbgq/zNpSQlCV1
         JOzQ==
X-Gm-Message-State: AOAM533fZ5A2zS3bc8sNlGRGz8RX49evHEHlwm+nVj2NZnMmAYFiQgOn
        niQdD8f6cg8LnW7FGVdDthA9Hw==
X-Google-Smtp-Source: ABdhPJyGn3wdGoYadza5iNZE6bj/nXq6MrRCQBVxL3lyhFqvG5bHcjloTEwy1RXyVtmPLRFrsk59eQ==
X-Received: by 2002:a17:902:a710:b029:dc:3817:e7c2 with SMTP id w16-20020a170902a710b02900dc3817e7c2mr2361020plq.0.1611889518950;
        Thu, 28 Jan 2021 19:05:18 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y75sm6854496pfg.119.2021.01.28.19.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:05:18 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Shuah Khan <shuah@kernel.org>,
        Brian Starkey <brian.starkey@arm.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Laura Abbott <labbott@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH 2/5] kselftests: dmabuf-heaps: Add clearer checks on DMABUF_BEGIN/END_SYNC
Date:   Fri, 29 Jan 2021 03:05:11 +0000
Message-Id: <20210129030514.1231773-2-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129030514.1231773-1-john.stultz@linaro.org>
References: <20210129030514.1231773-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add logic to check the dmabuf sync calls succeed.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Brian Starkey <brian.starkey@arm.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>
Cc: Laura Abbott <labbott@kernel.org>
Cc: Hridya Valsaraju <hridya@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Sandeep Patil <sspatil@google.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: linux-media@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 909da9cdda97..46f6759a8acc 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -130,16 +130,13 @@ static int dmabuf_heap_alloc(int fd, size_t len, unsigned int flags,
 					 dmabuf_fd);
 }
 
-static void dmabuf_sync(int fd, int start_stop)
+static int dmabuf_sync(int fd, int start_stop)
 {
 	struct dma_buf_sync sync = {
 		.flags = start_stop | DMA_BUF_SYNC_RW,
 	};
-	int ret;
 
-	ret = ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
-	if (ret)
-		printf("sync failed %d\n", errno);
+	return ioctl(fd, DMA_BUF_IOCTL_SYNC, &sync);
 }
 
 #define ONE_MEG (1024 * 1024)
@@ -197,9 +194,18 @@ static int test_alloc_and_import(char *heap_name)
 	}
 	printf("import passed\n");
 
-	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
+	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
+	if (ret < 0) {
+		printf("Sync start failed!\n");
+		goto out;
+	}
+
 	memset(p, 0xff, ONE_MEG);
-	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
+	if (ret < 0) {
+		printf("Sync end failed!\n");
+		goto out;
+	}
 	printf("syncs passed\n");
 
 	close_handle(importer_fd, handle);
-- 
2.25.1

