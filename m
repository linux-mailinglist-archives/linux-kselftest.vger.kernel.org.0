Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820F1308420
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Jan 2021 04:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhA2DH5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jan 2021 22:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbhA2DGi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jan 2021 22:06:38 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B33C061786
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:21 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id f63so5312223pfa.13
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 19:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zTNb1lTIEVQ6SY+1PM+jItpjx6YB2483ibK9X9oBYPQ=;
        b=z1kwyFNg5hSYRi20ZvZ8wuUsM10FJZoI8McYKRlownqrb/9vwSuD19hHoANIKl9o7S
         NM3r0rFYtS7BoYRIxUKv2hJYefP+6PduFPKe6sNVWE7NJvVoSFSo+oGB5ds50UhCUA9V
         SyK9daFDnwbPsOxmmmogF/izeRWdoG3OgCQ6k0DmEgOaW1qa9ZwCI/06RZVukTBn91KD
         jWkK57VznZPmUOrJGfJnxT8iH5+1O3xSd8qHCSqHOszD3n07tm6upXSk82uB3LtU1IAy
         N+1l7G24LEncO+U+I1O4bg5Gt8C/bhkcHAaGe6YPBKuBSfvXS+AFhnzu9hoyFu2QqGYg
         S+4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTNb1lTIEVQ6SY+1PM+jItpjx6YB2483ibK9X9oBYPQ=;
        b=SXf9LDyvgxNHXNBM5k+0toMITni93/DVlNXQ4pE123r9PlN2r5v6NfvUobmkgg860j
         doqALWLgKQeA4cJ1zqxc+kJNIh3gvGG+POdjTFnATW+8NCyT+Qw4cu2IAG8MyAiwGiKh
         ztSn4+DS8bMvVmU+nckfti9EiJ9RajlFDNTcTaeHoZhe7oZeygKfJBwr5CO7Jwu4u7K3
         0Ceq7BpEky0mfX/ZIqlQKhnmFzBTrBOACHf+uKhEobd2qcVfq+71K7nQoba4+3lyPKpB
         8otrRncUK5WXMSLHAOSdO8hbMuS3nL5/CAg/oJquOIVFMJmIieig34ywkxcf5/y2gzQP
         EirQ==
X-Gm-Message-State: AOAM5318R2pDHF+Ery3RwC9uQ/MLIreq5hJgJazEhqGlhm7SkdGYdSgq
        VW11JFo8Sl6vA0tElIsy8jKFoQ==
X-Google-Smtp-Source: ABdhPJxgU85/WQXQ6xIZh5kol/FeQ53pYxb2sLTuRnfE+yO6MQ1sib5AHGRb02vCaC8rjeUx7mU2rw==
X-Received: by 2002:a63:f404:: with SMTP id g4mr2518687pgi.114.1611889520497;
        Thu, 28 Jan 2021 19:05:20 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id y75sm6854496pfg.119.2021.01.28.19.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 19:05:19 -0800 (PST)
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
Subject: [PATCH 3/5] kselftests: dmabuf-heaps: Softly fail if don't find a vgem device
Date:   Fri, 29 Jan 2021 03:05:12 +0000
Message-Id: <20210129030514.1231773-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210129030514.1231773-1-john.stultz@linaro.org>
References: <20210129030514.1231773-1-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While testing against a vgem device is helpful for testing importing
they aren't always configured in, so don't make it a fatal failure.

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
 .../testing/selftests/dmabuf-heaps/dmabuf-heap.c  | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index 46f6759a8acc..8cedd539c7fb 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -184,15 +184,14 @@ static int test_alloc_and_import(char *heap_name)
 	if (importer_fd < 0) {
 		ret = importer_fd;
 		printf("Failed to open vgem\n");
-		goto out;
-	}
-
-	ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
-	if (ret < 0) {
-		printf("Failed to import buffer\n");
-		goto out;
+	} else {
+		ret = import_vgem_fd(importer_fd, dmabuf_fd, &handle);
+		if (ret < 0) {
+			printf("Failed to import buffer\n");
+			goto out;
+		}
+		printf("import passed\n");
 	}
-	printf("import passed\n");
 
 	ret = dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
 	if (ret < 0) {
-- 
2.25.1

