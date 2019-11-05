Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1A20EF7D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Nov 2019 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbfKEJHZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 5 Nov 2019 04:07:25 -0500
Received: from mout-p-202.mailbox.org ([80.241.56.172]:31768 "EHLO
        mout-p-202.mailbox.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfKEJHZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 5 Nov 2019 04:07:25 -0500
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 476kMD5BTTzQlBr;
        Tue,  5 Nov 2019 10:07:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id hBZfkmaeX9ST; Tue,  5 Nov 2019 10:07:08 +0100 (CET)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Aleksa Sarai <asarai@suse.de>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, libc-alpha@sourceware.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH v15 1/9] namei: LOOKUP_NO_SYMLINKS: block symlink resolution
Date:   Tue,  5 Nov 2019 20:05:45 +1100
Message-Id: <20191105090553.6350-2-cyphar@cyphar.com>
In-Reply-To: <20191105090553.6350-1-cyphar@cyphar.com>
References: <20191105090553.6350-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

/* Background. */
Userspace cannot easily resolve a path without resolving symlinks, and
would have to manually resolve each path component with O_PATH and
O_NOFOLLOW. This is clearly inefficient, and can be fairly easy to screw
up (resulting in possible security bugs). Linus has mentioned that Git
has a particular need for this kind of flag[1]. It also resolves a
fairly long-standing perceived deficiency in O_NOFOLLOw -- that it only
blocks the opening of trailing symlinks.

This is part of a refresh of Al's AT_NO_JUMPS patchset[2] (which was a
variation on David Drysdale's O_BENEATH patchset[3], which in turn was
based on the Capsicum project[4]).

/* Userspace API. */
LOOKUP_NO_SYMLINKS will be exposed to userspace through openat2(2).

/* Semantics. */
Unlike most other LOOKUP flags (most notably LOOKUP_FOLLOW),
LOOKUP_NO_SYMLINKS applies to all components of the path.

With LOOKUP_NO_SYMLINKS, any symlink path component encountered during
path resolution will yield -ELOOP. If the trailing component is a
symlink (and no other components were symlinks), then O_PATH|O_NOFOLLOW
will not error out and will instead provide a handle to the trailing
symlink -- without resolving it.

/* Testing. */
LOOKUP_NO_SYMLINKS is tested as part of the openat2(2) selftests.

[1]: https://lore.kernel.org/lkml/CA+55aFyOKM7DW7+0sdDFKdZFXgptb5r1id9=Wvhd8AgSP7qjwQ@mail.gmail.com/
[2]: https://lore.kernel.org/lkml/20170429220414.GT29622@ZenIV.linux.org.uk/
[3]: https://lore.kernel.org/lkml/1415094884-18349-1-git-send-email-drysdale@google.com/
[4]: https://lore.kernel.org/lkml/1404124096-21445-1-git-send-email-drysdale@google.com/

Cc: Christian Brauner <christian.brauner@ubuntu.com>
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c            | 3 +++
 include/linux/namei.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..4e85d6fa4048 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1045,6 +1045,9 @@ const char *get_link(struct nameidata *nd)
 	int error;
 	const char *res;
 
+	if (unlikely(nd->flags & LOOKUP_NO_SYMLINKS))
+		return ERR_PTR(-ELOOP);
+
 	if (!(nd->flags & LOOKUP_RCU)) {
 		touch_atime(&last->link);
 		cond_resched();
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 397a08ade6a2..ee2e35af387f 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -39,6 +39,9 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_ROOT		0x2000
 #define LOOKUP_ROOT_GRABBED	0x0008
 
+/* Scoping flags for lookup. */
+#define LOOKUP_NO_SYMLINKS	0x020000 /* No symlink crossing. */
+
 extern int path_pts(struct path *path);
 
 extern int user_path_at_empty(int, const char __user *, unsigned, struct path *, int *empty);
-- 
2.23.0

