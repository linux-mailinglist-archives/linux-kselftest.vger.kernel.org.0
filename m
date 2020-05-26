Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBCC11E308E
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 May 2020 22:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404444AbgEZUyT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 May 2020 16:54:19 -0400
Received: from smtp-8fa8.mail.infomaniak.ch ([83.166.143.168]:51931 "EHLO
        smtp-8fa8.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404295AbgEZUxs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 May 2020 16:53:48 -0400
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 49WmQb39NkzlhZ5W;
        Tue, 26 May 2020 22:53:43 +0200 (CEST)
Received: from localhost (unknown [94.23.54.103])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 49WmQZ5lMszlhFDf;
        Tue, 26 May 2020 22:53:42 +0200 (CEST)
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@amacapital.net>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Casey Schaufler <casey@schaufler-ca.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mickael.salaun@ssi.gouv.fr>,
        Richard Weinberger <richard@nod.at>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>,
        Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org, x86@kernel.org
Subject: [PATCH v18 07/12] landlock: Support filesystem access-control
Date:   Tue, 26 May 2020 22:53:17 +0200
Message-Id: <20200526205322.23465-8-mic@digikod.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526205322.23465-1-mic@digikod.net>
References: <20200526205322.23465-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Thanks to the Landlock objects and ruleset, it is possible to identify
inodes according to a process's domain.  To enable an unprivileged
process to express a file hierarchy, it first needs to open a directory
(or a file) and pass this file descriptor to the kernel through
landlock(2).  When checking if a file access request is allowed, we walk
from the requested dentry to the real root, following the different
mount layers.  The access to each "tagged" inodes are collected
according to their rule layer level, and ANDed to create access to the
requested file hierarchy.  This makes possible to identify a lot of
files without tagging every inodes nor modifying the filesystem, while
still following the view and understanding the user has from the
filesystem.

Add a new ARCH_EPHEMERAL_STATES for UML because it currently does not
keep the same struct inodes for the same inodes whereas these inodes are
in use.

This commit adds a minimal set of supported filesystem access-control
which doesn't enable to restrict all file-related actions.  This is the
result of multiple discussions to minimize the code of Landlock to ease
review.  Thanks to the Landlock design, extending this access-control
without breaking user space will not be a problem.  Moreover, seccomp
filters can be used to restrict the use of syscall families which may
not be currently handled by Landlock.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jann Horn <jannh@google.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Serge E. Hallyn <serge@hallyn.com>
---

Changes since v17:
* Replace landlock_release_inodes() with security_sb_delete() (requested
  by James Morris).
* Replace struct super_block->s_landlock_inode_refs with the LSM
  infrastructure management of the superblock (requested by James
  Morris).
* Fix mknod restriction with a zero mode (spotted by Vincent Dagonneau).
* Minimize executed code in path_mknod and file_open hooks when the
  current tasks is not sandboxed.
* Remove useless checks on the file pointer and inode in
  hook_file_open() .
* Constify domain pointers.
* Rename inode_landlock() to landlock_inode().
* Import include/uapi/linux/landlock.h and _LANDLOCK_ACCESS_FS_* from
  the ruleset and domain management patch.
* Explain the rational of this minimal set of access-control.
  https://lore.kernel.org/lkml/f646e1c7-33cf-333f-070c-0a40ad0468cd@digikod.net/

Changes since v16:
* Add ARCH_EPHEMERAL_STATES and enable it for UML.

Changes since v15:
* Replace layer_levels and layer_depth with a bitfield of layers: this
  enables to properly manage superset and subset of access rights,
  whatever their order in the stack of layers.
  Cf. https://lore.kernel.org/lkml/e07fe473-1801-01cc-12ae-b3167f95250e@digikod.net/
* Allow to open pipes and similar special files through /proc/self/fd/.
* Properly handle internal filesystems such as nsfs: always allow these
  kind of roots because disconnected path cannot be evaluated.
* Remove the LANDLOCK_ACCESS_FS_LINK_TO and
  LANDLOCK_ACCESS_FS_RENAME_{TO,FROM}, but use the
  LANDLOCK_ACCESS_FS_REMOVE_{FILE,DIR} and LANDLOCK_ACCESS_FS_MAKE_*
  instead.  Indeed, it is not possible for now (and not really useful)
  to express the semantic of a source and a destination.
* Check access rights to remove a directory or a file with rename(2).
* Forbid reparenting when linking or renaming.  This is needed to easily
  protect against possible privilege escalation by changing the place of
  a file or directory in relation to an enforced access policy (from the
  set of layers).  This will be relaxed in the future.
* Update hooks to take into account replacement of the object's self and
  beneath access bitfields with one.  Simplify the code.
* Check file related access rights.
* Check d_is_negative() instead of !d_backing_inode() in
  check_access_path_continue(), and continue the path walk while there
  is no mapped inode e.g., with rename(2).
* Check private inode in check_access_path().
* Optimize get_file_access() when dealing with a directory.
* Add missing atomic.h .

Changes since v14:
* Simplify the object, rule and ruleset management at the expense of a
  less aggressive memory freeing (contributed by Jann Horn, with
  additional modifications):
  - Rewrite release_inode() to use inode->sb->s_landlock_inode_refs.
  - Remove useless checks in landlock_release_inodes(), clean object
    pointer according to the new struct landlock_object and wait for all
    iput() to complete.
  - Rewrite get_inode_object() according to the new struct
    landlock_object.  If there is a race-condition when cleaning up an
    object, we retry until the concurrent thread finished the object
    cleaning.
  Cf. https://lore.kernel.org/lkml/CAG48ez21bEn0wL1bbmTiiu8j9jP5iEWtHOwz4tURUJ+ki0ydYw@mail.gmail.com/
* Fix nested domains by implementing a notion of layer level and depth:
  - Check for matching level ranges when walking through a file path.
  - Only allow access if every layer granted the access request.
* Handles files without mount points (e.g. pipes).
* Hardens path walk by checking inode pointer values.
* Prefetches d_parent when walking to the root directory.
* Remove useless inode_alloc_security hook() (suggested by Jann Horn):
  already initialized by lsm_inode_alloc().
* Remove the inode_free_security hook.
* Remove access checks that may be required for FD-only requests:
  truncate, getattr, lock, chmod, chown, chgrp, ioctl.  This will be
  handle in a future evolution of Landlock, but right now the goal is to
  lighten the code to ease review.
* Constify variables.
* Move ABI checks into syscall.c .
* Cosmetic variable renames.

Changes since v11:
* Add back, revamp and make a fully working filesystem access-control
  based on paths and inodes.
* Remove the eBPF dependency.

Previous changes:
https://lore.kernel.org/lkml/20190721213116.23476-6-mic@digikod.net/
---
 MAINTAINERS                   |   1 +
 arch/Kconfig                  |   7 +
 arch/um/Kconfig               |   1 +
 include/uapi/linux/landlock.h |  78 +++++
 security/landlock/Kconfig     |   2 +-
 security/landlock/Makefile    |   2 +-
 security/landlock/fs.c        | 610 ++++++++++++++++++++++++++++++++++
 security/landlock/fs.h        |  60 ++++
 security/landlock/setup.c     |   7 +
 security/landlock/setup.h     |   2 +
 10 files changed, 768 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/linux/landlock.h
 create mode 100644 security/landlock/fs.c
 create mode 100644 security/landlock/fs.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c0e1593b2c2b..9d92f219a54a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9498,6 +9498,7 @@ L:	linux-security-module@vger.kernel.org
 S:	Supported
 W:	https://landlock.io
 T:	git https://github.com/landlock-lsm/linux.git
+F:	include/linux/landlock.h
 F:	include/uapi/linux/landlock.h
 F:	security/landlock/
 K:	landlock
diff --git a/arch/Kconfig b/arch/Kconfig
index 786a85d4ad40..11cb49602780 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -826,6 +826,13 @@ config COMPAT_32BIT_TIME
 config ARCH_NO_PREEMPT
 	bool
 
+config ARCH_EPHEMERAL_STATES
+	def_bool n
+	help
+	  An arch should select this symbol if it do not keep an internal kernel
+	  state for kernel objects such as inodes, but instead rely on something
+	  else (e.g. the host kernel for an UML kernel).
+
 config ARCH_SUPPORTS_RT
 	bool
 
diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 96ab7026b037..f86fed3f2778 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -5,6 +5,7 @@ menu "UML-specific options"
 config UML
 	bool
 	default y
+	select ARCH_EPHEMERAL_STATES
 	select ARCH_HAS_KCOV
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
new file mode 100644
index 000000000000..5141185e6487
--- /dev/null
+++ b/include/uapi/linux/landlock.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Landlock - UAPI headers
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _UAPI__LINUX_LANDLOCK_H__
+#define _UAPI__LINUX_LANDLOCK_H__
+
+/**
+ * DOC: fs_access
+ *
+ * A set of actions on kernel objects may be defined by an attribute (e.g.
+ * &struct landlock_attr_path_beneath) and a bitmask of access.
+ *
+ * Filesystem flags
+ * ~~~~~~~~~~~~~~~~
+ *
+ * These flags enable to restrict a sandbox process to a set of actions on
+ * files and directories.  Files or directories opened before the sandboxing
+ * are not subject to these restrictions.
+ *
+ * A file can only receive these access rights:
+ *
+ * - %LANDLOCK_ACCESS_FS_EXECUTE: Execute a file.
+ * - %LANDLOCK_ACCESS_FS_WRITE_FILE: Open a file with write access.
+ * - %LANDLOCK_ACCESS_FS_READ_FILE: Open a file with read access.
+ *
+ * A directory can receive access rights related to files or directories.  This
+ * set of access rights is applied to the directory itself, and the directories
+ * beneath it:
+ *
+ * - %LANDLOCK_ACCESS_FS_READ_DIR: Open a directory or list its content.
+ * - %LANDLOCK_ACCESS_FS_CHROOT: Change the root directory of the current
+ *   process.
+ *
+ * However, the following access rights only apply to the content of a
+ * directory, not the directory itself:
+ *
+ * - %LANDLOCK_ACCESS_FS_REMOVE_DIR: Remove an empty directory or rename one.
+ * - %LANDLOCK_ACCESS_FS_REMOVE_FILE: Unlink (or rename) a file.
+ * - %LANDLOCK_ACCESS_FS_MAKE_CHAR: Create (or rename or link) a character
+ *   device.
+ * - %LANDLOCK_ACCESS_FS_MAKE_DIR: Create (or rename) a directory.
+ * - %LANDLOCK_ACCESS_FS_MAKE_REG: Create (or rename or link) a regular file.
+ * - %LANDLOCK_ACCESS_FS_MAKE_SOCK: Create (or rename or link) a UNIX domain
+ *   socket.
+ * - %LANDLOCK_ACCESS_FS_MAKE_FIFO: Create (or rename or link) a named pipe.
+ * - %LANDLOCK_ACCESS_FS_MAKE_BLOCK: Create (or rename or link) a block device.
+ * - %LANDLOCK_ACCESS_FS_MAKE_SYM: Create (or rename or link) a symbolic link.
+ *
+ * .. warning::
+ *
+ *   It is currently not possible to restrict some file-related actions
+ *   accessible through these syscall families: :manpage:`chdir(2)`,
+ *   :manpage:`truncate(2)`, :manpage:`stat(2)`, :manpage:`flock(2)`,
+ *   :manpage:`chmod(2)`, :manpage:`chown(2)`, :manpage:`setxattr(2)`,
+ *   :manpage:`ioctl(2)`, :manpage:`fcntl(2)`.
+ *   Future Landlock evolutions will enable to restrict them.
+ */
+#define LANDLOCK_ACCESS_FS_EXECUTE			(1ULL << 0)
+#define LANDLOCK_ACCESS_FS_WRITE_FILE			(1ULL << 1)
+#define LANDLOCK_ACCESS_FS_READ_FILE			(1ULL << 2)
+#define LANDLOCK_ACCESS_FS_READ_DIR			(1ULL << 3)
+#define LANDLOCK_ACCESS_FS_CHROOT			(1ULL << 4)
+#define LANDLOCK_ACCESS_FS_REMOVE_DIR			(1ULL << 5)
+#define LANDLOCK_ACCESS_FS_REMOVE_FILE			(1ULL << 6)
+#define LANDLOCK_ACCESS_FS_MAKE_CHAR			(1ULL << 7)
+#define LANDLOCK_ACCESS_FS_MAKE_DIR			(1ULL << 8)
+#define LANDLOCK_ACCESS_FS_MAKE_REG			(1ULL << 9)
+#define LANDLOCK_ACCESS_FS_MAKE_SOCK			(1ULL << 10)
+#define LANDLOCK_ACCESS_FS_MAKE_FIFO			(1ULL << 11)
+#define LANDLOCK_ACCESS_FS_MAKE_BLOCK			(1ULL << 12)
+#define LANDLOCK_ACCESS_FS_MAKE_SYM			(1ULL << 13)
+
+#endif /* _UAPI__LINUX_LANDLOCK_H__ */
diff --git a/security/landlock/Kconfig b/security/landlock/Kconfig
index 9ec7593a534a..487d88328d98 100644
--- a/security/landlock/Kconfig
+++ b/security/landlock/Kconfig
@@ -2,7 +2,7 @@
 
 config SECURITY_LANDLOCK
 	bool "Landlock support"
-	depends on SECURITY
+	depends on SECURITY && !ARCH_EPHEMERAL_STATES
 	select SECURITY_PATH
 	help
 	  Landlock is a safe sandboxing mechanism which enables processes to
diff --git a/security/landlock/Makefile b/security/landlock/Makefile
index f1d1eb72fa76..92e3d80ab8ed 100644
--- a/security/landlock/Makefile
+++ b/security/landlock/Makefile
@@ -1,4 +1,4 @@
 obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
 
 landlock-y := setup.o object.o ruleset.o \
-	cred.o ptrace.o
+	cred.o ptrace.o fs.o
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
new file mode 100644
index 000000000000..10b324be3f72
--- /dev/null
+++ b/security/landlock/fs.c
@@ -0,0 +1,610 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Landlock LSM - Filesystem management and hooks
+ *
+ * Copyright © 2016-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#include <linux/atomic.h>
+#include <linux/compiler_types.h>
+#include <linux/dcache.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/landlock.h>
+#include <linux/list.h>
+#include <linux/lsm_hooks.h>
+#include <linux/mount.h>
+#include <linux/namei.h>
+#include <linux/path.h>
+#include <linux/prefetch.h>
+#include <linux/rcupdate.h>
+#include <linux/spinlock.h>
+#include <linux/stat.h>
+#include <linux/types.h>
+#include <linux/wait_bit.h>
+#include <linux/workqueue.h>
+#include <uapi/linux/landlock.h>
+
+#include "common.h"
+#include "cred.h"
+#include "fs.h"
+#include "object.h"
+#include "ruleset.h"
+#include "setup.h"
+
+/* Underlying object management */
+
+static void release_inode(struct landlock_object *const object)
+	__releases(object->lock)
+{
+	struct inode *const inode = object->underobj;
+	struct super_block *sb;
+
+	if (!inode) {
+		spin_unlock(&object->lock);
+		return;
+	}
+
+	spin_lock(&inode->i_lock);
+	/*
+	 * Make sure that if the filesystem is concurrently unmounted,
+	 * hook_sb_delete() will wait for us to finish iput().
+	 */
+	sb = inode->i_sb;
+	atomic_long_inc(&landlock_superblock(sb)->inode_refs);
+	rcu_assign_pointer(landlock_inode(inode)->object, NULL);
+	spin_unlock(&inode->i_lock);
+	spin_unlock(&object->lock);
+	/*
+	 * Now, new rules can safely be tied to @inode.
+	 */
+
+	iput(inode);
+	if (atomic_long_dec_and_test(&landlock_superblock(sb)->inode_refs))
+		wake_up_var(&landlock_superblock(sb)->inode_refs);
+}
+
+static const struct landlock_object_underops landlock_fs_underops = {
+	.release = release_inode
+};
+
+/* Ruleset management */
+
+static struct landlock_object *get_inode_object(struct inode *const inode)
+{
+	struct landlock_object *object, *new_object;
+	struct landlock_inode_security *inode_sec = landlock_inode(inode);
+
+	rcu_read_lock();
+retry:
+	object = rcu_dereference(inode_sec->object);
+	if (object) {
+		if (likely(refcount_inc_not_zero(&object->usage))) {
+			rcu_read_unlock();
+			return object;
+		}
+		/*
+		 * We're racing with release_inode(), the object is going away.
+		 * Wait for release_inode(), then retry.
+		 */
+		spin_lock(&object->lock);
+		spin_unlock(&object->lock);
+		goto retry;
+	}
+	rcu_read_unlock();
+
+	/*
+	 * If there is no object tied to @inode, then create a new one (without
+	 * holding any locks).
+	 */
+	new_object = landlock_create_object(&landlock_fs_underops, inode);
+
+	spin_lock(&inode->i_lock);
+	object = rcu_dereference_protected(inode_sec->object,
+			lockdep_is_held(&inode->i_lock));
+	if (unlikely(object)) {
+		/* Someone else just created the object, bail out and retry. */
+		kfree(new_object);
+		spin_unlock(&inode->i_lock);
+
+		rcu_read_lock();
+		goto retry;
+	} else {
+		rcu_assign_pointer(inode_sec->object, new_object);
+		/*
+		 * @inode will be released by hook_sb_delete() on its
+		 * super-block shutdown.
+		 */
+		ihold(inode);
+		spin_unlock(&inode->i_lock);
+		return new_object;
+	}
+}
+
+/* All access rights which can be tied to files. */
+#define ACCESS_FILE ( \
+	LANDLOCK_ACCESS_FS_EXECUTE | \
+	LANDLOCK_ACCESS_FS_WRITE_FILE | \
+	LANDLOCK_ACCESS_FS_READ_FILE)
+
+/*
+ * @path: Should have been checked by get_path_from_fd().
+ */
+int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
+		const struct path *const path, u32 access_rights)
+{
+	int err;
+	struct landlock_rule rule = {};
+
+	/* Files only get access rights that make sense. */
+	if (!d_is_dir(path->dentry) && (access_rights | ACCESS_FILE) !=
+			ACCESS_FILE)
+		return -EINVAL;
+
+	/* Transforms relative access rights to absolute ones. */
+	access_rights |= _LANDLOCK_ACCESS_FS_MASK & ~ruleset->fs_access_mask;
+	rule.access = access_rights;
+	rule.object = get_inode_object(d_backing_inode(path->dentry));
+	mutex_lock(&ruleset->lock);
+	err = landlock_insert_rule(ruleset, &rule, false);
+	mutex_unlock(&ruleset->lock);
+	/*
+	 * No need to check for an error because landlock_insert_rule()
+	 * increment the refcount for the new rule, if any.
+	 */
+	landlock_put_object(rule.object);
+	return err;
+}
+
+/* Access-control management */
+
+static bool check_access_path_continue(
+		const struct landlock_ruleset *const domain,
+		const struct path *const path, const u32 access_request,
+		bool *const allow, u64 *const layer_mask)
+{
+	const struct landlock_rule *rule;
+	const struct inode *inode;
+	bool next = true;
+
+	prefetch(path->dentry->d_parent);
+	if (d_is_negative(path->dentry))
+		/* Continues to walk while there is no mapped inode. */
+		return true;
+	inode = d_backing_inode(path->dentry);
+	rcu_read_lock();
+	rule = landlock_find_rule(domain,
+			rcu_dereference(landlock_inode(inode)->object));
+	rcu_read_unlock();
+
+	/* Checks for matching layers. */
+	if (rule && (rule->layers | *layer_mask)) {
+		*allow = (rule->access & access_request) == access_request;
+		if (*allow) {
+			*layer_mask &= ~rule->layers;
+			/* Stops when a rule from each layer granted access. */
+			next = !!*layer_mask;
+		} else {
+			next = false;
+		}
+	}
+	return next;
+}
+
+static int check_access_path(const struct landlock_ruleset *const domain,
+		const struct path *const path, u32 access_request)
+{
+	bool allow = false;
+	struct path walker_path;
+	u64 layer_mask;
+
+	if (WARN_ON_ONCE(!domain || !path))
+		return 0;
+	/*
+	 * Allows access to pseudo filesystems that will never be mountable
+	 * (e.g. sockfs, pipefs), but can still be reachable through
+	 * /proc/self/fd .
+	 */
+	if ((path->dentry->d_sb->s_flags & SB_NOUSER) ||
+			(d_is_positive(path->dentry) &&
+			 unlikely(IS_PRIVATE(d_backing_inode(path->dentry)))))
+		return 0;
+	if (WARN_ON_ONCE(domain->nb_layers < 1))
+		return -EACCES;
+
+	layer_mask = GENMASK_ULL(domain->nb_layers - 1, 0);
+	/*
+	 * An access request which is not handled by the domain should be
+	 * allowed.
+	 */
+	access_request &= domain->fs_access_mask;
+	if (access_request == 0)
+		return 0;
+	walker_path = *path;
+	path_get(&walker_path);
+	/*
+	 * We need to walk through all the hierarchy to not miss any relevant
+	 * restriction.
+	 */
+	while (check_access_path_continue(domain, &walker_path, access_request,
+				&allow, &layer_mask)) {
+		struct dentry *parent_dentry;
+
+jump_up:
+		/*
+		 * Does not work with orphaned/private mounts like overlayfs
+		 * layers for now (cf. ovl_path_real() and ovl_path_open()).
+		 */
+		if (walker_path.dentry == walker_path.mnt->mnt_root) {
+			if (follow_up(&walker_path)) {
+				/* Ignores hidden mount points. */
+				goto jump_up;
+			} else {
+				/*
+				 * Stops at the real root.  Denies access
+				 * because not all layers have granted access.
+				 */
+				allow = false;
+				break;
+			}
+		}
+		if (unlikely(IS_ROOT(walker_path.dentry))) {
+			/*
+			 * Stops at disconnected root directories.  Only allows
+			 * access to internal filesystems (e.g. nsfs which is
+			 * reachable through /proc/self/ns).
+			 */
+			allow = !!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
+			break;
+		}
+		parent_dentry = dget_parent(walker_path.dentry);
+		dput(walker_path.dentry);
+		walker_path.dentry = parent_dentry;
+	}
+	path_put(&walker_path);
+	return allow ? 0 : -EACCES;
+}
+
+static inline int current_check_access_path(const struct path *const path,
+		const u32 access_request)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+	return check_access_path(dom, path, access_request);
+}
+
+/* Super-block hooks */
+
+/*
+ * Release the inodes used in a security policy.
+ *
+ * Cf. fsnotify_unmount_inodes()
+ */
+static void hook_sb_delete(struct super_block *const sb)
+{
+	struct inode *inode, *iput_inode = NULL;
+
+	if (!landlock_initialized)
+		return;
+
+	spin_lock(&sb->s_inode_list_lock);
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
+		struct landlock_inode_security *inode_sec =
+			landlock_inode(inode);
+		struct landlock_object *object;
+		bool do_put = false;
+
+		rcu_read_lock();
+		object = rcu_dereference(inode_sec->object);
+		if (!object) {
+			rcu_read_unlock();
+			continue;
+		}
+
+		spin_lock(&object->lock);
+		if (object->underobj) {
+			object->underobj = NULL;
+			do_put = true;
+			spin_lock(&inode->i_lock);
+			rcu_assign_pointer(inode_sec->object, NULL);
+			spin_unlock(&inode->i_lock);
+		}
+		spin_unlock(&object->lock);
+		rcu_read_unlock();
+		if (!do_put)
+			/*
+			 * A concurrent iput() in release_inode() is ongoing
+			 * and we will just wait for it to finish.
+			 */
+			continue;
+
+		/*
+		 * At this point, we own the ihold() reference that was
+		 * originally set up by get_inode_object(). Therefore we can
+		 * drop the list lock and know that the inode won't disappear
+		 * from under us until the next loop walk.
+		 */
+		spin_unlock(&sb->s_inode_list_lock);
+		/*
+		 * We can now actually put the previous inode, which is not
+		 * needed anymore for the loop walk.
+		 */
+		if (iput_inode)
+			iput(iput_inode);
+		iput_inode = inode;
+		spin_lock(&sb->s_inode_list_lock);
+	}
+	spin_unlock(&sb->s_inode_list_lock);
+	if (iput_inode)
+		iput(iput_inode);
+
+	/*
+	 * Wait for pending iput() in release_inode().
+	 */
+	wait_var_event(&landlock_superblock(sb)->inode_refs, !atomic_long_read(
+				&landlock_superblock(sb)->inode_refs));
+}
+
+/*
+ * Because a Landlock security policy is defined according to the filesystem
+ * layout (i.e. the mount namespace), changing it may grant access to files not
+ * previously allowed.
+ *
+ * To make it simple, deny any filesystem layout modification by landlocked
+ * processes.  Non-landlocked processes may still change the namespace of a
+ * landlocked process, but this kind of threat must be handled by a system-wide
+ * access-control security policy.
+ *
+ * This could be lifted in the future if Landlock can safely handle mount
+ * namespace updates requested by a landlocked process.  Indeed, we could
+ * update the current domain (which is currently read-only) by taking into
+ * account the accesses of the source and the destination of a new mount point.
+ * However, it would also require to make all the child domains dynamically
+ * inherit these new constraints.  Anyway, for backward compatibility reasons,
+ * a dedicated user space option would be required (e.g. as a ruleset command
+ * option).
+ */
+static int hook_sb_mount(const char *const dev_name,
+		const struct path *const path, const char *const type,
+		const unsigned long flags, void *const data)
+{
+	if (!landlock_get_current_domain())
+		return 0;
+	return -EPERM;
+}
+
+static int hook_move_mount(const struct path *const from_path,
+		const struct path *const to_path)
+{
+	if (!landlock_get_current_domain())
+		return 0;
+	return -EPERM;
+}
+
+/*
+ * Removing a mount point may reveal a previously hidden file hierarchy, which
+ * may then grant access to files, which may have previously been forbidden.
+ */
+static int hook_sb_umount(struct vfsmount *const mnt, const int flags)
+{
+	if (!landlock_get_current_domain())
+		return 0;
+	return -EPERM;
+}
+
+static int hook_sb_remount(struct super_block *const sb, void *const mnt_opts)
+{
+	if (!landlock_get_current_domain())
+		return 0;
+	return -EPERM;
+}
+
+/*
+ * pivot_root(2), like mount(2), changes the current mount namespace.  It must
+ * then be forbidden for a landlocked process.
+ *
+ * However, chroot(2) may be allowed because it only changes the relative root
+ * directory of the current process.
+ */
+static int hook_sb_pivotroot(const struct path *const old_path,
+		const struct path *const new_path)
+{
+	if (!landlock_get_current_domain())
+		return 0;
+	return -EPERM;
+}
+
+/* Path hooks */
+
+static inline u32 get_mode_access(const umode_t mode)
+{
+	switch (mode & S_IFMT) {
+	case S_IFLNK:
+		return LANDLOCK_ACCESS_FS_MAKE_SYM;
+	case 0:
+		/* A zero mode translates to S_IFREG. */
+	case S_IFREG:
+		return LANDLOCK_ACCESS_FS_MAKE_REG;
+	case S_IFDIR:
+		return LANDLOCK_ACCESS_FS_MAKE_DIR;
+	case S_IFCHR:
+		return LANDLOCK_ACCESS_FS_MAKE_CHAR;
+	case S_IFBLK:
+		return LANDLOCK_ACCESS_FS_MAKE_BLOCK;
+	case S_IFIFO:
+		return LANDLOCK_ACCESS_FS_MAKE_FIFO;
+	case S_IFSOCK:
+		return LANDLOCK_ACCESS_FS_MAKE_SOCK;
+	default:
+		WARN_ON_ONCE(1);
+		return 0;
+	}
+}
+
+/*
+ * Creating multiple links or renaming may lead to privilege escalations if not
+ * handled properly.  Indeed, we must be sure that the source doesn't gain more
+ * privileges by being accessible from the destination.  This is getting more
+ * complex when dealing with multiple layers.  The whole picture can be seen as
+ * a multilayer partial ordering problem.  A future version of Landlock will
+ * deal with that.
+ */
+static int hook_path_link(struct dentry *const old_dentry,
+		const struct path *const new_dir,
+		struct dentry *const new_dentry)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+	/* The mount points are the same for old and new paths, cf. EXDEV. */
+	if (old_dentry->d_parent != new_dir->dentry)
+		/* For now, forbid reparenting. */
+		return -EACCES;
+	if (unlikely(d_is_negative(old_dentry)))
+		return -EACCES;
+	return check_access_path(dom, new_dir,
+			get_mode_access(d_backing_inode(old_dentry)->i_mode));
+}
+
+static inline u32 maybe_remove(const struct dentry *const dentry)
+{
+	if (d_is_negative(dentry))
+		return 0;
+	return d_is_dir(dentry) ? LANDLOCK_ACCESS_FS_REMOVE_DIR :
+		LANDLOCK_ACCESS_FS_REMOVE_FILE;
+}
+
+static int hook_path_rename(const struct path *const old_dir,
+		struct dentry *const old_dentry,
+		const struct path *const new_dir,
+		struct dentry *const new_dentry)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+	/* The mount points are the same for old and new paths, cf. EXDEV. */
+	if (old_dir->dentry != new_dir->dentry)
+		/* For now, forbid reparenting. */
+		return -EACCES;
+	if (WARN_ON_ONCE(d_is_negative(old_dentry)))
+		return -EACCES;
+	/* RENAME_EXCHANGE is handled because directories are the same. */
+	return check_access_path(dom, old_dir, maybe_remove(old_dentry) |
+			maybe_remove(new_dentry) |
+			get_mode_access(d_backing_inode(old_dentry)->i_mode));
+}
+
+static int hook_path_mkdir(const struct path *const dir,
+		struct dentry *const dentry, const umode_t mode)
+{
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_DIR);
+}
+
+static int hook_path_mknod(const struct path *const dir,
+		struct dentry *const dentry, const umode_t mode,
+		const unsigned int dev)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+	return check_access_path(dom, dir, get_mode_access(mode));
+}
+
+static int hook_path_symlink(const struct path *const dir,
+		struct dentry *const dentry, const char *const old_name)
+{
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_MAKE_SYM);
+}
+
+static int hook_path_unlink(const struct path *const dir,
+		struct dentry *const dentry)
+{
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_FILE);
+}
+
+static int hook_path_rmdir(const struct path *const dir,
+		struct dentry *const dentry)
+{
+	return current_check_access_path(dir, LANDLOCK_ACCESS_FS_REMOVE_DIR);
+}
+
+static int hook_path_chroot(const struct path *const path)
+{
+	return current_check_access_path(path, LANDLOCK_ACCESS_FS_CHROOT);
+}
+
+/* File hooks */
+
+static inline u32 get_file_access(const struct file *const file)
+{
+	u32 access = 0;
+
+	if (file->f_mode & FMODE_READ) {
+		/* A directory can only be opened in read mode. */
+		if (S_ISDIR(file_inode(file)->i_mode))
+			return LANDLOCK_ACCESS_FS_READ_DIR;
+		access = LANDLOCK_ACCESS_FS_READ_FILE;
+	}
+	/*
+	 * A LANDLOCK_ACCESS_FS_APPEND could be added but we also need to check
+	 * fcntl(2).
+	 */
+	if (file->f_mode & FMODE_WRITE)
+		access |= LANDLOCK_ACCESS_FS_WRITE_FILE;
+	/* __FMODE_EXEC is indeed part of f_flags, not f_mode. */
+	if (file->f_flags & __FMODE_EXEC)
+		access |= LANDLOCK_ACCESS_FS_EXECUTE;
+	return access;
+}
+
+static int hook_file_open(struct file *const file)
+{
+	const struct landlock_ruleset *const dom =
+		landlock_get_current_domain();
+
+	if (!dom)
+		return 0;
+	/*
+	 * Because a file may be opened with O_PATH, get_file_access() may
+	 * return 0.  This case will be handled with a future Landlock
+	 * evolution.
+	 */
+	return current_check_access_path(&file->f_path, get_file_access(file));
+}
+
+static struct security_hook_list landlock_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(sb_delete, hook_sb_delete),
+	LSM_HOOK_INIT(sb_mount, hook_sb_mount),
+	LSM_HOOK_INIT(move_mount, hook_move_mount),
+	LSM_HOOK_INIT(sb_umount, hook_sb_umount),
+	LSM_HOOK_INIT(sb_remount, hook_sb_remount),
+	LSM_HOOK_INIT(sb_pivotroot, hook_sb_pivotroot),
+
+	LSM_HOOK_INIT(path_link, hook_path_link),
+	LSM_HOOK_INIT(path_rename, hook_path_rename),
+	LSM_HOOK_INIT(path_mkdir, hook_path_mkdir),
+	LSM_HOOK_INIT(path_mknod, hook_path_mknod),
+	LSM_HOOK_INIT(path_symlink, hook_path_symlink),
+	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
+	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
+	LSM_HOOK_INIT(path_chroot, hook_path_chroot),
+
+	LSM_HOOK_INIT(file_open, hook_file_open),
+};
+
+__init void landlock_add_hooks_fs(void)
+{
+	security_add_hooks(landlock_hooks, ARRAY_SIZE(landlock_hooks),
+			LANDLOCK_NAME);
+}
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
new file mode 100644
index 000000000000..58b462eb7f10
--- /dev/null
+++ b/security/landlock/fs.h
@@ -0,0 +1,60 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Landlock LSM - Filesystem management and hooks
+ *
+ * Copyright © 2017-2020 Mickaël Salaün <mic@digikod.net>
+ * Copyright © 2018-2020 ANSSI
+ */
+
+#ifndef _SECURITY_LANDLOCK_FS_H
+#define _SECURITY_LANDLOCK_FS_H
+
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/rcupdate.h>
+#include <uapi/linux/landlock.h>
+
+#include "ruleset.h"
+#include "setup.h"
+
+#define _LANDLOCK_ACCESS_FS_LAST	LANDLOCK_ACCESS_FS_MAKE_SYM
+#define _LANDLOCK_ACCESS_FS_MASK	((_LANDLOCK_ACCESS_FS_LAST << 1) - 1)
+
+struct landlock_inode_security {
+	/*
+	 * @object: Weak pointer to an allocated object.  All writes (i.e.
+	 * creating a new object or removing one) are protected by the
+	 * underlying inode->i_lock.  Disassociating @object from the inode is
+	 * additionally protected by @object->lock, from the time @object's
+	 * usage refcount drops to zero to the time this pointer is nulled out.
+	 * Cf. release_inode().
+	 */
+	struct landlock_object __rcu *object;
+};
+
+struct landlock_superblock_security {
+	/*
+	 * @inode_refs: References to Landlock underlying objects.
+	 * Cf. struct super_block->s_fsnotify_inode_refs .
+	 */
+	atomic_long_t inode_refs;
+};
+
+static inline struct landlock_inode_security *landlock_inode(
+		const struct inode *const inode)
+{
+	return inode->i_security + landlock_blob_sizes.lbs_inode;
+}
+
+static inline struct landlock_superblock_security *landlock_superblock(
+		const struct super_block *const superblock)
+{
+	return superblock->s_security + landlock_blob_sizes.lbs_superblock;
+}
+
+__init void landlock_add_hooks_fs(void);
+
+int landlock_append_fs_rule(struct landlock_ruleset *const ruleset,
+		const struct path *const path, u32 access_hierarchy);
+
+#endif /* _SECURITY_LANDLOCK_FS_H */
diff --git a/security/landlock/setup.c b/security/landlock/setup.c
index 5e7540fdeefa..722cbea82324 100644
--- a/security/landlock/setup.c
+++ b/security/landlock/setup.c
@@ -11,17 +11,24 @@
 
 #include "common.h"
 #include "cred.h"
+#include "fs.h"
 #include "ptrace.h"
 #include "setup.h"
 
+bool landlock_initialized __lsm_ro_after_init = false;
+
 struct lsm_blob_sizes landlock_blob_sizes __lsm_ro_after_init = {
 	.lbs_cred = sizeof(struct landlock_cred_security),
+	.lbs_inode = sizeof(struct landlock_inode_security),
+	.lbs_superblock = sizeof(struct landlock_superblock_security),
 };
 
 static int __init landlock_init(void)
 {
 	landlock_add_hooks_cred();
 	landlock_add_hooks_ptrace();
+	landlock_add_hooks_fs();
+	landlock_initialized = true;
 	pr_info("Up and running.\n");
 	return 0;
 }
diff --git a/security/landlock/setup.h b/security/landlock/setup.h
index 9fdbf33fcc33..1daffab1ab4b 100644
--- a/security/landlock/setup.h
+++ b/security/landlock/setup.h
@@ -11,6 +11,8 @@
 
 #include <linux/lsm_hooks.h>
 
+extern bool landlock_initialized;
+
 extern struct lsm_blob_sizes landlock_blob_sizes;
 
 #endif /* _SECURITY_LANDLOCK_SETUP_H */
-- 
2.26.2

