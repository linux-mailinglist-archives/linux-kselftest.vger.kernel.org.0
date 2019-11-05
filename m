Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0413FEF9BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 10:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbfKEJlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 04:41:09 -0500
Received: from m12-14.163.com ([220.181.12.14]:40039 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730537AbfKEJlJ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 04:41:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=oTfm9
        nHSTYeQdNmpFEU/ZEk19olGK2tJWTcVpXVi3yU=; b=AkZHwEbHwM87b+irIKTjf
        5mnzcHkiC+EkGjjt0EFeFfa1I6mcqujyU4hFm7Tk7uEOHL+nC5w9iJ/LkDpyDFtC
        js+KofdLckbXzFAisfIIeEm2tZtbZ78JJ0UALPQ99ZO53X7jXp1+leJGm+Ss+BJS
        a9IYXlSiFHpCPnPH+NQv8U=
Received: from localhost.localdomain (unknown [112.25.212.39])
        by smtp10 (Coremail) with SMTP id DsCowAD3_JiaQ8FdeNDtBg--.147S2;
        Tue, 05 Nov 2019 17:40:44 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     john.stultz@linaro.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, Xiao Yang <ice_yangxiao@163.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] dmabuf-heaps/dmabuf-heap.c: Initialize features variable to avoid compiler warning
Date:   Tue,  5 Nov 2019 17:40:29 +0800
Message-Id: <20191105094029.21213-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAD3_JiaQ8FdeNDtBg--.147S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxKry3KrWkGr45WrWfKrg_yoW3ZFXEvF
        Z5tFZ7urZ5AFyqkr15Xas8Wrs7Xay5WF48G34rJ3W3Krs8AFWYyFWDZF4UJFnagrn8uFW2
        vFZrKr9xGw12yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUL0eJUUUUU==
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiTB1kXlSIi09rhwAAsf
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
index ec47901ef2e2..5e3eeec299b2 100644
--- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
+++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
@@ -154,7 +154,7 @@ static int do_test(char *heap_name)
 	int heap_fd = -1, dmabuf_fd = -1, importer_fd = -1;
 	uint32_t handle = 0;
 	void *p = NULL;
-	unsigned long long features;
+	unsigned long long features = 0;
 	int ret;
 
 	printf("Testing heap: %s\n", heap_name);
-- 
2.21.0


