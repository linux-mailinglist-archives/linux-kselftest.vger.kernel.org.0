Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B858F5D04A
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfGBNNF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 09:13:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726375AbfGBNNE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 09:13:04 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 62F53ECD8DA4E939F752;
        Tue,  2 Jul 2019 21:12:57 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 2 Jul 2019
 21:12:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <shuah@kernel.org>, <tj@kernel.org>, <guro@fb.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] kselftests: cgroup: remove duplicated include from test_freezer.c
Date:   Tue, 2 Jul 2019 21:12:33 +0800
Message-ID: <20190702131233.7064-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 tools/testing/selftests/cgroup/test_freezer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/cgroup/test_freezer.c b/tools/testing/selftests/cgroup/test_freezer.c
index 2bfddb6..8219a30 100644
--- a/tools/testing/selftests/cgroup/test_freezer.c
+++ b/tools/testing/selftests/cgroup/test_freezer.c
@@ -11,7 +11,6 @@
 #include <stdlib.h>
 #include <sys/inotify.h>
 #include <string.h>
-#include <sys/types.h>
 #include <sys/wait.h>
 
 #include "../kselftest.h"
-- 
2.7.4


