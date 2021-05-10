Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E73D378F51
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 May 2021 15:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbhEJNlI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 May 2021 09:41:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2753 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348031AbhEJMjj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 May 2021 08:39:39 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ff0r83DBWzqSTG;
        Mon, 10 May 2021 20:35:04 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 20:38:18 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Shuah Khan <shuah@kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] mnt: Delete two unneeded bool conversions
Date:   Mon, 10 May 2021 20:38:05 +0800
Message-ID: <20210510123805.3801-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The result of an expression consisting of a single relational operator is
already of the bool type and does not need to be evaluated explicitly.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 tools/testing/selftests/mount/unprivileged-remount-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mount/unprivileged-remount-test.c b/tools/testing/selftests/mount/unprivileged-remount-test.c
index 584dc6bc3b06679..d2917054fe3ae56 100644
--- a/tools/testing/selftests/mount/unprivileged-remount-test.c
+++ b/tools/testing/selftests/mount/unprivileged-remount-test.c
@@ -204,7 +204,7 @@ bool test_unpriv_remount(const char *fstype, const char *mount_options,
 		if (!WIFEXITED(status)) {
 			die("child did not terminate cleanly\n");
 		}
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	create_and_enter_userns();
@@ -282,7 +282,7 @@ static bool test_priv_mount_unpriv_remount(void)
 		if (!WIFEXITED(status)) {
 			die("child did not terminate cleanly\n");
 		}
-		return WEXITSTATUS(status) == EXIT_SUCCESS ? true : false;
+		return WEXITSTATUS(status) == EXIT_SUCCESS;
 	}
 
 	orig_mnt_flags = read_mnt_flags(orig_path);
-- 
2.26.0.106.g9fadedd


