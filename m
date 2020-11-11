Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390FD2AFA7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727304AbgKKVfG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:35:06 -0500
Received: from smtp-bc0f.mail.infomaniak.ch ([45.157.188.15]:33093 "EHLO
        smtp-bc0f.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727202AbgKKVez (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:55 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdL51lB7zlhTHM;
        Wed, 11 Nov 2020 22:34:53 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdL46qj1zlh8T5;
        Wed, 11 Nov 2020 22:34:52 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 7/9] landlock: Clean up get_ruleset_from_fd()
Date:   Wed, 11 Nov 2020 22:34:40 +0100
Message-Id: <20201111213442.434639-8-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rewrite get_ruleset_from_fd() to please the 0-DAY CI Kernel Test Service
that reported an uninitialized variable (false positive).  Anyway, it is
cleaner like this.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Link: https://lore.kernel.org/linux-security-module/202011101854.zGbWwusK-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/syscall.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/security/landlock/syscall.c b/security/landlock/syscall.c
index 486136d4f46e..543ae36cd339 100644
--- a/security/landlock/syscall.c
+++ b/security/landlock/syscall.c
@@ -196,24 +196,26 @@ static struct landlock_ruleset *get_ruleset_from_fd(const int fd,
 {
 	struct fd ruleset_f;
 	struct landlock_ruleset *ruleset;
-	int err;
 
 	ruleset_f = fdget(fd);
 	if (!ruleset_f.file)
 		return ERR_PTR(-EBADF);
 
 	/* Checks FD type and access right. */
-	err = 0;
-	if (ruleset_f.file->f_op != &ruleset_fops)
-		err = -EBADFD;
-	else if (!(ruleset_f.file->f_mode & mode))
-		err = -EPERM;
-	if (!err) {
-		ruleset = ruleset_f.file->private_data;
-		landlock_get_ruleset(ruleset);
+	if (ruleset_f.file->f_op != &ruleset_fops) {
+		ruleset = ERR_PTR(-EBADFD);
+		goto out_fdput;
 	}
+	if (!(ruleset_f.file->f_mode & mode)) {
+		ruleset = ERR_PTR(-EPERM);
+		goto out_fdput;
+	}
+	ruleset = ruleset_f.file->private_data;
+	landlock_get_ruleset(ruleset);
+
+out_fdput:
 	fdput(ruleset_f);
-	return err ? ERR_PTR(err) : ruleset;
+	return ruleset;
 }
 
 /* Path handling */
-- 
2.29.2

