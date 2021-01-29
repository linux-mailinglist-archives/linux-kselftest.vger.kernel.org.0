Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 617B4308415
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 04:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbhA2DGr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jan 2021 22:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhA2DGj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jan 2021 22:06:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88108C06178B
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:22 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id jx18so5570066pjb.5
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OKBQYxsiF/Yxl/0bRH0OqXnXLh71Bs92MecR17vq6CE=;
        b=YyD6yWoGpCJBFSxr5KRkbyz5bfteCsw39788klP5cnw03qARl97eSoGDQg8ShaHYMB
         +9hHYQc9rgyU5dFnO0S/zoWBhNvMGrHZszlgbWsYa8/r5YlVRp0wOe8+HZ+UwUSMS2lY
         yZPXNzOj1dM0/CwLm0fOF5X9rnt6C0xec6nqE4t7OMnCEqxW+vteZ0eq3EaekznrH4/Y
         c0th+OgCWrgUpZXQtP7vfZiFqOZP3fiO2Q+eWnlD9H/a4yIsK5oJK66xr8s3E28ZcDFP
         rh1/IQ9t+f4HhBcbqODmoetiQSjoK5X4ERzDst+KHYWNvCwCDiyCUuK/pvBvCQt751Hg
         F9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OKBQYxsiF/Yxl/0bRH0OqXnXLh71Bs92MecR17vq6CE=;
        b=ufgX+0zZMKBB9fBmGeq6zmSWPn5WVjprb+O77hu3YgtE/Q456Rnt7DyxVYsy5uwF/k
         ztqW5k7w6EnS2ha+79bHOl9E3/o2RJwQVO/TKPlVXP916tefugT84YYw+5Ra/LXcStKj
         KDpPpzkh8p9BLbYGDhG2qOlwZbDjQytRZxLZYZVNXQ5ma2sR3rO0GryYgzeqbvbI9CFY
         hMYPwEotZlNU+e7xUndDXm3etG4okKKbzjNmo4qnbPes1tGrI1zs/i5oYDkQDKGYXGgF
         yjzJELi8lp5duslhbWXxeAvZdAtAEqKnIlE/ufTWfw5y+IUapWouDpSxqU+f566xtJBx
         X3MQ==
X-Gm-Message-State: AOAM5316Ji4DNd43bafb2zxXDnzDRBu/oEClVg6VwYRZ340mewtfQaWK
        8xtNv0vRQgs0UWDseGSALFSRnA==
X-Google-Smtp-Source: ABdhPJwFkKoGEbsS48QlG2raIqaa9osIVu/ssWmT+77IVRcpOInpa7ki/IP6MdqqkEeLDOObv8Sjsw==
X-Received: by 2002:a17:902:d2c1:b029:de:7c38:f86a with SMTP id n1-20020a170902d2c1b02900de7c38f86amr2336534plc.83.1611889522041;
        Thu, 28 Jan 2021 19:05:22 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y75sm6854496pfg.119.2021.01.28.19.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:05:21 -0800 (PST)
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
Subject: [PATCH 4/5] kselftests: dmabuf-heaps: Cleanup test output
Date:   Fri, 29 Jan 2021 03:05:13 +0000
Message-Id: <20210129030514.1231773-4-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129030514.1231773-1-john.stultz@linaro.org>
References: <20210129030514.1231773-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cleanup the test output so it is a bit easier to read

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
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 44 +++++++++----------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 8cedd539c7fb..d179d81e2355 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -148,16 +148,14 @@ static int test_alloc_and_import(char *heap_name)
 	void *p = NULL;
 	int ret;
 
-	printf("Testing heap: %s\n", heap_name);
-
 	heap_fd = dmabuf_heap_open(heap_name);
 	if (heap_fd < 0)
 		return -1;
 
-	printf("Allocating 1 MEG\n");
+	printf("  Testing allocation and importing:  ");
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("Allocation Failed!\n");
+		printf("FAIL (Allocation Failed!)\n");
 		ret = -1;
 		goto out;
 	}
@@ -169,11 +167,10 @@ static int test_alloc_and_import(char *heap_name)
 		 dmabuf_fd,
 		 0);
 	if (p == MAP_FAILED) {
-		printf("mmap() failed: %m\n");
+		printf("FAIL (mmap() failed)\n");
 		ret = -1;
 		goto out;
 	}
-	printf("mmap passed\n");
 
 	dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	memset(p, 1, ONE_MEG / 2);
@@ -183,33 +180,31 @@ static int test_alloc_and_import(char *heap_name)
 	importer_fd = open_vgem();
 	if (importer_fd < 0) {
 		ret = importer_fd;
-		printf("Failed to open vgem\n");
+		printf("(Could not open vgem - skipping):  ");
 	} else {
 		ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
 		if (ret < 0) {
-			printf("Failed to import buffer\n");
+			printf("FAIL (Failed to import buffer)\n");
 			goto out;
 		}
-		printf("import passed\n");
 	}
 
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	if (ret < 0) {
-		printf("Sync start failed!\n");
+		printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
 		goto out;
 	}
 
 	memset(p, 0xff, ONE_MEG);
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
 	if (ret < 0) {
-		printf("Sync end failed!\n");
+		printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
 		goto out;
 	}
-	printf("syncs passed\n");
 
 	close_handle(importer_fd, handle);
 	ret = 0;
-
+	printf(" OK\n");
 out:
 	if (p)
 		munmap(p, ONE_MEG);
@@ -297,23 +292,24 @@ static int test_alloc_compat(char *heap_name)
 	if (heap_fd < 0)
 		return -1;
 
-	printf("Testing (theoretical)older alloc compat\n");
+	printf("  Testing (theoretical)older alloc compat:  ");
 	ret = dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("Older compat allocation failed!\n");
+		printf("FAIL (Older compat allocation failed!)\n");
 		ret = -1;
 		goto out;
 	}
 	close(dmabuf_fd);
+	printf("OK\n");
 
-	printf("Testing (theoretical)newer alloc compat\n");
+	printf("  Testing (theoretical)newer alloc compat:  ");
 	ret = dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
 	if (ret) {
-		printf("Newer compat allocation failed!\n");
+		printf("FAIL (Newer compat allocation failed!)\n");
 		ret = -1;
 		goto out;
 	}
-	printf("Ioctl compatibility tests passed\n");
+	printf("OK\n");
 out:
 	if (dmabuf_fd >= 0)
 		close(dmabuf_fd);
@@ -332,17 +328,17 @@ static int test_alloc_errors(char *heap_name)
 	if (heap_fd < 0)
 		return -1;
 
-	printf("Testing expected error cases\n");
+	printf("  Testing expected error cases:  ");
 	ret = dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
 	if (!ret) {
-		printf("Did not see expected error (invalid fd)!\n");
+		printf("FAIL (Did not see expected error (invalid fd)!)\n");
 		ret = -1;
 		goto out;
 	}
 
 	ret = dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd);
 	if (!ret) {
-		printf("Did not see expected error (invalid heap flags)!\n");
+		printf("FAIL (Did not see expected error (invalid heap flags)!)\n");
 		ret = -1;
 		goto out;
 	}
@@ -350,12 +346,12 @@ static int test_alloc_errors(char *heap_name)
 	ret = dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
 					~(O_RDWR | O_CLOEXEC), 0, &dmabuf_fd);
 	if (!ret) {
-		printf("Did not see expected error (invalid fd flags)!\n");
+		printf("FAIL (Did not see expected error (invalid fd flags)!)\n");
 		ret = -1;
 		goto out;
 	}
 
-	printf("Expected error checking passed\n");
+	printf("OK\n");
 	ret = 0;
 out:
 	if (dmabuf_fd >= 0)
@@ -384,6 +380,8 @@ int main(void)
 		if (!strncmp(dir->d_name, "..", 3))
 			continue;
 
+		printf("Testing heap: %s\n", dir->d_name);
+		printf("=======================================\n");
 		ret = test_alloc_and_import(dir->d_name);
 		if (ret)
 			break;
-- 
2.25.1

