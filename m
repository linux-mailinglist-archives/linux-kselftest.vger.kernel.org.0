Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F260A2AFA69
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKKVes (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:34:48 -0500
Received: from smtp-8faa.mail.infomaniak.ch ([83.166.143.170]:34497 "EHLO
        smtp-8faa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726287AbgKKVes (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:48 -0500
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdKy1kKxzlhQ42;
        Wed, 11 Nov 2020 22:34:46 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdKx6wm5zlh8T4;
        Wed, 11 Nov 2020 22:34:45 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 1/9] landlock: Fix memory allocation error handling
Date:   Wed, 11 Nov 2020 22:34:34 +0100
Message-Id: <20201111213442.434639-2-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Handle memory allocation errors in landlock_create_object() call.  This
prevent to inadvertently hold an inode.  Also, make get_inode_object()
more readable.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c     | 5 +++++
 security/landlock/object.c | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index d8c5d19ac2af..b67c821bb40b 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -9,6 +9,7 @@
 #include <linux/atomic.h>
 #include <linux/compiler_types.h>
 #include <linux/dcache.h>
+#include <linux/err.h>
 #include <linux/fs.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -98,6 +99,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 	 * holding any locks).
 	 */
 	new_object = landlock_create_object(&landlock_fs_underops, inode);
+	if (IS_ERR(new_object))
+		return new_object;
 
 	spin_lock(&inode->i_lock);
 	object = rcu_dereference_protected(inode_sec->object,
@@ -145,6 +148,8 @@ int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
 	access_rights |= _LANDLOCK_ACCESS_FS_MASK & ~ruleset->fs_access_mask;
 	rule.access = access_rights;
 	rule.object = get_inode_object(d_backing_inode(path->dentry));
+	if (IS_ERR(rule.object))
+		return PTR_ERR(rule.object);
 	mutex_lock(&ruleset->lock);
 	err = landlock_insert_rule(ruleset, &rule, false);
 	mutex_unlock(&ruleset->lock);
diff --git a/security/landlock/object.c b/security/landlock/object.c
index a71644ee72a7..54ba0327002a 100644
--- a/security/landlock/object.c
+++ b/security/landlock/object.c
@@ -8,6 +8,7 @@
 
 #include <linux/bug.h>
 #include <linux/compiler_types.h>
+#include <linux/err.h>
 #include <linux/kernel.h>
 #include <linux/rcupdate.h>
 #include <linux/refcount.h>
@@ -23,10 +24,10 @@ struct landlock_object *landlock_create_object(
 	struct landlock_object *new_object;
 
 	if (WARN_ON_ONCE(!underops || !underobj))
-		return NULL;
+		return ERR_PTR(-ENOENT);
 	new_object = kzalloc(sizeof(*new_object), GFP_KERNEL_ACCOUNT);
 	if (!new_object)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	refcount_set(&new_object->usage, 1);
 	spin_lock_init(&new_object->lock);
 	new_object->underops = underops;
-- 
2.29.2

