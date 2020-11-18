Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C66C2B7B76
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Nov 2020 11:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgKRKga (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 18 Nov 2020 05:36:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7555 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgKRKga (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 18 Nov 2020 05:36:30 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CbfNs4hpNzhZhj;
        Wed, 18 Nov 2020 18:36:13 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Nov 2020
 18:36:24 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <shuah@kernel.org>, <pintu.ping@gmail.com>
CC:     <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] android/ion: fix error return code in opensocket()
Date:   Wed, 18 Nov 2020 18:39:18 +0800
Message-ID: <20201118103918.58477-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix to return a negative error code from the error handling
case instead of 0, as done elsewhere in this function.

Fixes: 47a18c42d992 ("android/ion: userspace test utility for ion buffer sharing")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 tools/testing/selftests/android/ion/ipcsocket.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/android/ion/ipcsocket.c b/tools/testing/selftests/android/ion/ipcsocket.c
index 7dc521002095..268e6b610357 100644
--- a/tools/testing/selftests/android/ion/ipcsocket.c
+++ b/tools/testing/selftests/android/ion/ipcsocket.c
@@ -28,8 +28,9 @@ int opensocket(int *sockfd, const char *name, int connecttype)
 	}
 
 	*sockfd = ret;
-	if (setsockopt(*sockfd, SOL_SOCKET, SO_REUSEADDR,
-		(char *)&temp, sizeof(int)) < 0) {
+	ret = setsockopt(*sockfd, SOL_SOCKET, SO_REUSEADDR, (char *)&temp,
+			 sizeof(int))
+	if (ret < 0) {
 		fprintf(stderr, "<%s>: Failed setsockopt: <%s>\n",
 		__func__, strerror(errno));
 		goto err;
-- 
2.17.1

