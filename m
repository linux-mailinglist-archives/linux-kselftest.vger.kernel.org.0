Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96E93EBBDB
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2019 03:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKACFL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 22:05:11 -0400
Received: from m12-15.163.com ([220.181.12.15]:56398 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbfKACFL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 22:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=yww0h
        0f2dGfyYC2liA3XUs+tgQHf71r+Sa4057gJ5Us=; b=P+JdqcJFG4udWJMRLsThb
        SOBnBRNStBowg1rbm+Ekyl9CW8XlOG3kAfHUCquVoUfKGBh4MTICqpitKKQuJXpR
        BHiQClNBCAKp2+iSO6l6anNCEOFZ7XLGlf5C357blile6HhYbQggOz0/reV/Pdrf
        gaSBrWpivDTS0dAXjpubqE=
Received: from localhost.localdomain (unknown [112.25.212.39])
        by smtp11 (Coremail) with SMTP id D8CowAAHFpDJkrtdVl44EQ--.26S2;
        Fri, 01 Nov 2019 10:05:03 +0800 (CST)
From:   Xiao Yang <ice_yangxiao@163.com>
To:     john.stultz@linaro.org, shuah@kernel.org
Cc:     linux-kselftest@vger.kernel.org, Xiao Yang <ice_yangxiao@163.com>
Subject: [PATCH] kselftests/dmabuf-heaps: Fix compiler error in one condition
Date:   Fri,  1 Nov 2019 10:04:50 +0800
Message-Id: <20191101020450.12948-1-ice_yangxiao@163.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowAAHFpDJkrtdVl44EQ--.26S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4fWF4kWFWfJr47WFykXwb_yoWDZFbE9F
        WUtF1kJ3yDZryDur45Xa45Crs7J34UWr4fCr1DJw43Jr9xAr45CF4DWr48XFnYgryUXry2
        vFWktFy3Jr1jyjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbec_PUUUUU==
X-Originating-IP: [112.25.212.39]
X-CM-SenderInfo: 5lfhs5xdqj5xldr6il2tof0z/1tbiFgRgXlWBkPGU7QAAsg
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Compiling dmabuf-heaps cannot locate headers and then gets the following
error when kernel source code instead of system provides headers:
-------------------------------------------
dmabuf-heap.c:16:10: fatal error: drm/drm.h: No such file or directory
-------------------------------------------

Signed-off-by: Xiao Yang <ice_yangxiao@163.com>
---
 tools/testing/selftests/dmabuf-heaps/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dmabuf-heaps/Makefile b/tools/testing/selftests/dmabuf-heaps/Makefile
index 8c4c36e2972d..9043e0b5a432 100644
--- a/tools/testing/selftests/dmabuf-heaps/Makefile
+++ b/tools/testing/selftests/dmabuf-heaps/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS += -static -O3 -Wl,-no-as-needed -Wall
+CFLAGS += -static -O3 -Wl,-no-as-needed -Wall -I../../../../usr/include
 #LDLIBS += -lrt -lpthread -lm
 
 # these are all "safe" tests that don't modify
-- 
2.21.0


