Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8418E1157
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2019 06:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731554AbfJWE6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Oct 2019 00:58:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbfJWE6U (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Oct 2019 00:58:20 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A44821906;
        Wed, 23 Oct 2019 04:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571806699;
        bh=5UOyBnC5qla2Rd1+pYVADdaJfxPTcdJGTel4r+Yxuog=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JsuTaaG9XM9Ddn0hN5C+a4ZVb7VKn3qnj13bReZNJXttymLzG1LXTcl9cz+mVDs7f
         vZqAzbL/xGREwwF84F+ApA19aMqUGR96YzGMcrq9pRmAeNnikL2xKE+K2jMe3JOFSF
         OWtt30NcZn5+x71Ybl7QiRU6nzol/IqygQ5RIjkE=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        jaswinder.singh@linaro.org,
        =?UTF-8?q?Emilio=20L=C3=B3pez?= <emilio.lopez@collabora.co.uk>
Subject: [BUGFIX PATCH v3 5/5] selftests: sync: Fix cast warnings on arm
Date:   Wed, 23 Oct 2019 13:58:16 +0900
Message-Id: <157180669615.17298.13418495289425106434.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157180665007.17298.907392422924029261.stgit@devnote2>
References: <157180665007.17298.907392422924029261.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix warnings on __u64 and pointer translation on arm and
other 32bit architectures. Since the pointer is 32bits on
those archs, we should not directly cast those types.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Emilio López <emilio.lopez@collabora.co.uk>
---
 tools/testing/selftests/sync/sync.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/sync/sync.c b/tools/testing/selftests/sync/sync.c
index f3d599f249b9..7741c0518d18 100644
--- a/tools/testing/selftests/sync/sync.c
+++ b/tools/testing/selftests/sync/sync.c
@@ -109,7 +109,7 @@ static struct sync_file_info *sync_file_info(int fd)
 			return NULL;
 		}
 
-		info->sync_fence_info = (uint64_t)fence_info;
+		info->sync_fence_info = (uint64_t)(unsigned long)fence_info;
 
 		err = ioctl(fd, SYNC_IOC_FILE_INFO, info);
 		if (err < 0) {
@@ -124,7 +124,7 @@ static struct sync_file_info *sync_file_info(int fd)
 
 static void sync_file_info_free(struct sync_file_info *info)
 {
-	free((void *)info->sync_fence_info);
+	free((void *)(unsigned long)info->sync_fence_info);
 	free(info);
 }
 
@@ -152,7 +152,7 @@ int sync_fence_count_with_status(int fd, int status)
 	if (!info)
 		return -1;
 
-	fence_info = (struct sync_fence_info *)info->sync_fence_info;
+	fence_info = (struct sync_fence_info *)(unsigned long)info->sync_fence_info;
 	for (i = 0 ; i < info->num_fences ; i++) {
 		if (fence_info[i].status == status)
 			count++;

