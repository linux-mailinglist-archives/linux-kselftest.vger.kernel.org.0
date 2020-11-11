Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6F32AFA81
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Nov 2020 22:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgKKVfI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Nov 2020 16:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgKKVez (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Nov 2020 16:34:55 -0500
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C12C0617A7
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Nov 2020 13:34:55 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4CWdL62XsJzlhbQT;
        Wed, 11 Nov 2020 22:34:54 +0100 (CET)
Received: from localhost (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4CWdL60nM9zlh8T2;
        Wed, 11 Nov 2020 22:34:54 +0100 (CET)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        "Serge E . Hallyn" <serge@hallyn.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v1 8/9] landlock: Add help to enable Landlock as a stacked LSM
Date:   Wed, 11 Nov 2020 22:34:41 +0100
Message-Id: <20201111213442.434639-9-mic@digikod.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111213442.434639-1-mic@digikod.net>
References: <20201111213442.434639-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When using make oldconfig with a previous configuration already
including the CONFIG_LSM variable, no question is asked to update its
content.

Update the Kconfig help and add hints to the sample to help user
understand the required configuration.

This also cut long strings to fit in 100 columns.

Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 samples/landlock/sandboxer.c | 21 +++++++++++++++++++--
 security/landlock/Kconfig    |  4 +++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index ee5ec1203cb7..127fb063c23a 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -169,7 +169,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		fprintf(stderr, "usage: %s=\"...\" %s=\"...\" %s <cmd> [args]...\n\n",
 				ENV_FS_RO_NAME, ENV_FS_RW_NAME, argv[0]);
 		fprintf(stderr, "Launch a command in a restricted environment.\n\n");
-		fprintf(stderr, "Environment variables containing paths, each separated by a colon:\n");
+		fprintf(stderr, "Environment variables containing paths, "
+				"each separated by a colon:\n");
 		fprintf(stderr, "* %s: list of paths allowed to be used in a read-only way.\n",
 				ENV_FS_RO_NAME);
 		fprintf(stderr, "* %s: list of paths allowed to be used in a read-write way.\n",
@@ -185,6 +186,21 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	ruleset_fd = landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
 	if (ruleset_fd < 0) {
 		perror("Failed to create a ruleset");
+		switch (errno) {
+		case ENOSYS:
+			fprintf(stderr, "Hint: Landlock is not supported by the current kernel. "
+					"To support it, build the kernel with "
+					"CONFIG_SECURITY_LANDLOCK=y and prepend "
+					"\"landlock,\" to the content of CONFIG_LSM.\n");
+			break;
+		case EOPNOTSUPP:
+			fprintf(stderr, "Hint: Landlock is currently disabled. "
+					"It can be enabled in the kernel configuration by "
+					"prepending \"landlock,\" to the content of CONFIG_LSM, "
+					"or at boot time by setting the same content to the "
+					"\"lsm\" kernel parameter.\n");
+			break;
+		}
 		return 1;
 	}
 	if (populate_ruleset(ENV_FS_RO_NAME, ruleset_fd,
@@ -210,7 +226,8 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	execvpe(cmd_path, cmd_argv, envp);
 	fprintf(stderr, "Failed to execute \"%s\": %s\n", cmd_path,
 			strerror(errno));
-	fprintf(stderr, "Hint: access to the binary, the interpreter or shared libraries may be denied.\n");
+	fprintf(stderr, "Hint: access to the binary, the interpreter or "
+			"shared libraries may be denied.\n");
 	return 1;
 
 err_close_ruleset:
diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index cbf88bb7fd97..43e5b0bb0706 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -16,4 +16,6 @@ config SECURITY_LANDLOCK
 
 	  See Documentation/userspace-api/landlock.rst for further information.
 
-	  If you are unsure how to answer this question, answer N.
+	  If you are unsure how to answer this question, answer N.  Otherwise, you
+	  should also prepend "landlock," to the content of CONFIG_LSM to enable
+	  Landlock at boot time.
-- 
2.29.2

