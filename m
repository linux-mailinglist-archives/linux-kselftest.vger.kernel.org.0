Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA492AFA6C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgKKVet (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:34:49 -0500
Received: from smtp-190c.mail.infomaniak.ch ([185.125.25.12]:33459 "EHLO
        smtp-190c.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725933AbgKKVet (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:49 -0500
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdKz2lNrzlhbQT;
        Wed, 11 Nov 2020 22:34:47 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdKz0tvLzlh8TF;
        Wed, 11 Nov 2020 22:34:47 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 2/9] landlock: Cosmetic fixes for filesystem management
Date:   Wed, 11 Nov 2020 22:34:35 +0100
Message-Id: <20201111213442.434639-3-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Improve comments and make get_inode_object() more readable.  The kfree()
call is correct but we should mimimize as much as possible lock windows.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/fs.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b67c821bb40b..33fc7ae17c7f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -85,8 +85,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 			return object;
 		}
 		/*
-		 * We're racing with release_inode(), the object is going away.
-		 * Wait for release_inode(), then retry.
+		 * We are racing with release_inode(), the object is going
+		 * away.  Wait for release_inode(), then retry.
 		 */
 		spin_lock(&object->lock);
 		spin_unlock(&object->lock);
@@ -107,21 +107,21 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
 			lockdep_is_held(&inode->i_lock));
 	if (unlikely(object)) {
 		/* Someone else just created the object, bail out and retry. */
-		kfree(new_object);
 		spin_unlock(&inode->i_lock);
+		kfree(new_object);
 
 		rcu_read_lock();
 		goto retry;
-	} else {
-		rcu_assign_pointer(inode_sec->object, new_object);
-		/*
-		 * @inode will be released by hook_sb_delete() on its
-		 * superblock shutdown.
-		 */
-		ihold(inode);
-		spin_unlock(&inode->i_lock);
-		return new_object;
 	}
+
+	rcu_assign_pointer(inode_sec->object, new_object);
+	/*
+	 * @inode will be released by hook_sb_delete() on its superblock
+	 * shutdown.
+	 */
+	ihold(inode);
+	spin_unlock(&inode->i_lock);
+	return new_object;
 }
 
 /* All access rights which can be tied to files. */
-- 
2.29.2

