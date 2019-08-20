Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05BF59558C
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Aug 2019 05:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbfHTDgS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Aug 2019 23:36:18 -0400
Received: from mx2.mailbox.org ([80.241.60.215]:64082 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728975AbfHTDgS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Aug 2019 23:36:18 -0400
Received: from smtp2.mailbox.org (smtp2.mailbox.org [80.241.60.241])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B5A75A104E;
        Tue, 20 Aug 2019 05:36:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter04.heinlein-hosting.de (spamfilter04.heinlein-hosting.de [80.241.56.122]) (amavisd-new, port 10030)
        with ESMTP id ZOr36I3E8IrG; Tue, 20 Aug 2019 05:36:03 +0200 (CEST)
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Tycho Andersen <tycho@tycho.ws>,
        David Drysdale <drysdale@google.com>,
        Chanho Min <chanho.min@lge.com>,
        Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        containers@lists.linux-foundation.org, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Subject: [PATCH RESEND v11 6/8] namei: aggressively check for nd->root escape on ".." resolution
Date:   Tue, 20 Aug 2019 13:34:04 +1000
Message-Id: <20190820033406.29796-7-cyphar@cyphar.com>
In-Reply-To: <20190820033406.29796-1-cyphar@cyphar.com>
References: <20190820033406.29796-1-cyphar@cyphar.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch allows for LOOKUP_BENEATH and LOOKUP_IN_ROOT to safely permit
".." resolution (in the case of LOOKUP_BENEATH the resolution will still
fail if ".." resolution would resolve a path outside of the root --
while LOOKUP_IN_ROOT will chroot(2)-style scope it). Magic-link jumps
are still disallowed entirely because now they could result in
inconsistent behaviour if resolution encounters a subsequent ".."[*].

The need for this patch is explained by observing there is a fairly
easy-to-exploit race condition with chroot(2) (and thus by extension
LOOKUP_IN_ROOT and LOOKUP_BENEATH if ".." is allowed) where a rename(2)
of a path can be used to "skip over" nd->root and thus escape to the
filesystem above nd->root.

  thread1 [attacker]:
    for (;;)
      renameat2(AT_FDCWD, "/a/b/c", AT_FDCWD, "/a/d", RENAME_EXCHANGE);
  thread2 [victim]:
    for (;;)
      openat2(dirb, "b/c/../../etc/shadow",
              { .flags = O_PATH, .resolve = RESOLVE_IN_ROOT } );

With fairly significant regularity, thread2 will resolve to
"/etc/shadow" rather than "/a/b/etc/shadow". There is also a similar
(though somewhat more privileged) attack using MS_MOVE.

With this patch, such cases will be detected *during* ".." resolution
(which is the weak point of chroot(2) -- since walking *into* a
subdirectory tautologically cannot result in you walking *outside*
nd->root -- except through a bind-mount or magic-link). By detecting
this at ".." resolution (rather than checking only at the end of the
entire resolution) we can both correct escapes by jumping back to the
root (in the case of LOOKUP_IN_ROOT), as well as avoid revealing to
attackers the structure of the filesystem outside of the root (through
timing attacks for instance).

In order to avoid a quadratic lookup with each ".." entry, we only
activate the slow path if a write through &rename_lock or &mount_lock
has occurred during path resolution (&rename_lock and &mount_lock are
re-taken to further optimise the lookup). Since the primary attack being
protected against is MS_MOVE or rename(2), not doing additional checks
unless a mount or rename have occurred avoids making the common case
slow.

The use of path_is_under() here might seem suspect, but on further
inspection of the most important race (a path was *inside* the root but
is now *outside*), there appears to be no attack potential:

  * If path_is_under() occurs before the rename, then the path will be
    resolved -- however the path was originally inside the root and thus
    there is no escape (and to userspace it'd look like the rename
    occurred after the path was resolved). If path_is_under() occurs
    afterwards, the resolution is blocked.

  * Subsequent ".." jumps are guaranteed to check path_is_under() -- by
    construction, &rename_lock or &mount_lock must have been taken by
    the attacker after path_is_under() returned in the victim. Thus ".."
    will not be able to escape from the previously-inside-root path.

  * Walking down in the moved path is still safe since the entire
    subtree was moved (either by rename(2) or MS_MOVE) and because (as
    discussed above) walking down is safe.

A variant of the above attack is included in the selftests for
openat2(2) later in this patch series. I've run this test on several
machines for several days and no instances of a breakout were detected.
While this is not concrete proof that this is safe, when combined with
the above argument it should lend some trustworthiness to this
construction.

[*] It may be acceptable in the future to do a path_is_under() check
    after resolving a magic-link and permit resolution if the
    nd_jump_link() result is still within the dirfd. However this seems
    unlikely to be a feature that people *really* need* -- it can be
    added later if it turns out a lot of people want it.

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jann Horn <jannh@google.com>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namei.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 0352d275bd13..fd1eb5ce8baa 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -491,7 +491,7 @@ struct nameidata {
 	struct path	root;
 	struct inode	*inode; /* path.dentry.d_inode */
 	unsigned int	flags;
-	unsigned	seq, m_seq;
+	unsigned	seq, m_seq, r_seq;
 	int		last_type;
 	unsigned	depth;
 	int		total_link_count;
@@ -1758,22 +1758,36 @@ static inline int handle_dots(struct nameidata *nd, int type)
 	if (type == LAST_DOTDOT) {
 		int error = 0;
 
-		/*
-		 * LOOKUP_BENEATH resolving ".." is not currently safe -- races
-		 * can cause our parent to have moved outside of the root and
-		 * us to skip over it.
-		 */
-		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT)))
-			return -EXDEV;
 		if (!nd->root.mnt) {
 			error = set_root(nd);
 			if (error)
 				return error;
 		}
-		if (nd->flags & LOOKUP_RCU) {
-			return follow_dotdot_rcu(nd);
-		} else
-			return follow_dotdot(nd);
+		if (nd->flags & LOOKUP_RCU)
+			error = follow_dotdot_rcu(nd);
+		else
+			error = follow_dotdot(nd);
+		if (error)
+			return error;
+
+		if (unlikely(nd->flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT))) {
+			bool m_retry = read_seqretry(&mount_lock, nd->m_seq);
+			bool r_retry = read_seqretry(&rename_lock, nd->r_seq);
+
+			/*
+			 * Don't bother checking unless there's a racing
+			 * rename(2) or MS_MOVE.
+			 */
+			if (likely(!m_retry && !r_retry))
+				return 0;
+
+			if (m_retry && !(nd->flags & LOOKUP_RCU))
+				nd->m_seq = read_seqbegin(&mount_lock);
+			if (r_retry)
+				nd->r_seq = read_seqbegin(&rename_lock);
+			if (!path_is_under(&nd->path, &nd->root))
+				return -EXDEV;
+		}
 	}
 	return 0;
 }
@@ -2245,6 +2259,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->last_type = LAST_ROOT; /* if there are only slashes... */
 	nd->flags = flags | LOOKUP_JUMPED | LOOKUP_PARENT;
 	nd->depth = 0;
+
+	nd->m_seq = read_seqbegin(&mount_lock);
+	if (flags & (LOOKUP_BENEATH | LOOKUP_IN_ROOT))
+		nd->r_seq = read_seqbegin(&rename_lock);
+
 	if (flags & LOOKUP_ROOT) {
 		struct dentry *root = nd->root.dentry;
 		struct inode *inode = root->d_inode;
@@ -2266,8 +2285,6 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	nd->path.mnt = NULL;
 	nd->path.dentry = NULL;
 
-	nd->m_seq = read_seqbegin(&mount_lock);
-
 	/* LOOKUP_IN_ROOT treats absolute paths as being relative-to-dirfd. */
 	if (flags & LOOKUP_IN_ROOT)
 		while (*s == '/')
-- 
2.22.0

