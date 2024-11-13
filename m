Return-Path: <linux-kselftest+bounces-21970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1CC9C7D53
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 22:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58D71F230B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Nov 2024 21:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417492071E9;
	Wed, 13 Nov 2024 21:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="NjWQB3AD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from forward201d.mail.yandex.net (forward201d.mail.yandex.net [178.154.239.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB17206067;
	Wed, 13 Nov 2024 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731532146; cv=none; b=SWE225AsXDLcF41YHpxqNKVxGd+uOAJibsmT86qedzBnTp3lLq5H69op2Dj4BobufrG1zHf3yOoG+9WE9DZvxijFN0Mo+fUlhG4fJ0U6RElcAdJeRFoOL+i4OX6esjEN5t9xHZloKxEoX01yk38+1jU4Kz1hIM5Es9w/AnPDDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731532146; c=relaxed/simple;
	bh=DLr2vnINqZVj5aaMJifgR8ShHCLwIiZPOPT0DwCv5S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=He/GtPXLd6nFerRxoa1+0kUqST1NJA8eEkE4XA+T8W5Vqg2n1V6Em//yrinaeGjbp5Ykl1cUxbXo5bZoBXaPprZSxJIevLFo4eA1dv0+uf/NzE/XF+Mvex/ORhZGgI13PBL1+9nHQLcuAlnu+/Fukv6MDpwFbryQkBDW0hok64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=NjWQB3AD; arc=none smtp.client-ip=178.154.239.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d103])
	by forward201d.mail.yandex.net (Yandex) with ESMTPS id 2F6F667CD7;
	Thu, 14 Nov 2024 00:02:51 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:864f:0:640:bfcf:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 89DFC609E9;
	Thu, 14 Nov 2024 00:02:43 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id d2Tv0AUOqSw0-Q4dHx0kH;
	Thu, 14 Nov 2024 00:02:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731531761; bh=EQpp/xKTJGsUtdCCDtGntRJK9oexOt07DdCvE8bCIi0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=NjWQB3ADl1exQnTPcEm0ZPnpTSG7MsV71G34FtwSt3I7XjewpREyALeJrcvub3ju9
	 3Y4j75ptGfDk2qbQCKmturZOenOl+eA5mTABEMH0EfX+v8li0F67TZXN4oufvV/nPl
	 +oWbrabBPjk9dFay0gzcNiPgEfykrBzwj7cHvx5U=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Willem de Bruijn <willemb@google.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Gabriel Krisman Bertazi <krisman@suse.de>,
	Mina Almasry <almasrymina@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Gou Hao <gouhao@uniontech.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Michal Luczaj <mhal@rbox.co>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] net/unix: pass pidfd flags via SCM_PIDFD cmsg
Date: Thu, 14 Nov 2024 00:02:05 +0300
Message-ID: <20241113210206.3440784-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently SCM_PIDFD cmsg cannot be sent via unix socket
(returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
The created pidfd always has flags set to 0.

This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
can be used to send flags to SO_PASSPIDFD-enabled recipient.

Self-test is added for the propagation of PIDFD_NONBLOCK flag.

This is mainly needed for the future extensions, like eg this one:
https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
where it was suggested to try solving the supplementary groups
problem with pidfd.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Shuah Khan <shuah@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Jens Axboe <axboe@kernel.dk>
CC: Willem de Bruijn <willemb@google.com>
CC: Pavel Begunkov <asml.silence@gmail.com>
CC: Gabriel Krisman Bertazi <krisman@suse.de>
CC: Mina Almasry <almasrymina@google.com>
CC: Oleg Nesterov <oleg@redhat.com>
CC: Tycho Andersen <tandersen@netflix.com>
CC: Al Viro <viro@zeniv.linux.org.uk>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: Gou Hao <gouhao@uniontech.com>
CC: Abhishek Chauhan <quic_abchauha@quicinc.com>
CC: Michal Luczaj <mhal@rbox.co>
CC: Kees Cook <kees@kernel.org>
CC: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
CC: linux-kselftest@vger.kernel.org
---
 include/linux/pidfs.h                         |  9 +++
 include/linux/socket.h                        |  2 +-
 include/net/af_unix.h                         |  1 +
 include/net/scm.h                             | 10 ++-
 kernel/pid.c                                  |  6 +-
 net/core/scm.c                                | 14 ++++
 net/core/sock.c                               |  1 +
 net/unix/af_unix.c                            |  3 +
 .../testing/selftests/net/af_unix/scm_pidfd.c | 70 +++++++++++++++++--
 9 files changed, 106 insertions(+), 10 deletions(-)

diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index 75bdf9807802..c4c5c1a0c2ad 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -2,7 +2,16 @@
 #ifndef _LINUX_PID_FS_H
 #define _LINUX_PID_FS_H
 
+#include <uapi/linux/pidfd.h>
+
 struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 
+static inline int pidfd_validate_flags(unsigned int flags)
+{
+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
+		return -EINVAL;
+	return 0;
+}
+
 #endif /* _LINUX_PID_FS_H */
diff --git a/include/linux/socket.h b/include/linux/socket.h
index d18cc47e89bd..ee27d391e5aa 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -178,7 +178,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
 #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
 #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
 #define SCM_SECURITY	0x03		/* rw: security label		*/
-#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
+#define SCM_PIDFD	0x04		/* r: pidfd, w: pidfd_flags (int) */
 
 struct ucred {
 	__u32	pid;
diff --git a/include/net/af_unix.h b/include/net/af_unix.h
index 63129c79b8cb..4bc197548c2f 100644
--- a/include/net/af_unix.h
+++ b/include/net/af_unix.h
@@ -62,6 +62,7 @@ struct unix_skb_parms {
 #ifdef CONFIG_SECURITY_NETWORK
 	u32			secid;		/* Security ID		*/
 #endif
+	u32			pidfd_flags;
 	u32			consumed;
 } __randomize_layout;
 
diff --git a/include/net/scm.h b/include/net/scm.h
index 0d35c7c77a74..bc64d516b226 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/pid.h>
+#include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
 #include <net/compat.h>
@@ -48,6 +49,7 @@ struct scm_cookie {
 #ifdef CONFIG_SECURITY_NETWORK
 	u32			secid;		/* Passed security ID 	*/
 #endif
+	u32			pidfd_flags;
 };
 
 void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
@@ -137,6 +139,7 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 {
 	struct file *pidfd_file = NULL;
 	int len, pidfd;
+	int err;
 
 	/* put_cmsg() doesn't return an error if CMSG is truncated,
 	 * that's why we need to opencode these checks here.
@@ -154,7 +157,12 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 	if (!scm->pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+	err = pidfd_validate_flags(scm->pidfd_flags);
+	if (err) {
+		msg->msg_flags |= MSG_CTRUNC;
+		return;
+	}
+	pidfd = pidfd_prepare(scm->pid, scm->pidfd_flags, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
diff --git a/kernel/pid.c b/kernel/pid.c
index 2715afb77eab..b1100ae8ea63 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -629,10 +629,12 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
 SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
 {
 	int fd;
+	int err;
 	struct pid *p;
 
-	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
-		return -EINVAL;
+	err = pidfd_validate_flags(flags);
+	if (err)
+		return err;
 
 	if (pid <= 0)
 		return -EINVAL;
diff --git a/net/core/scm.c b/net/core/scm.c
index 4f6a14babe5a..3bcdecdacd7e 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/pid_namespace.h>
 #include <linux/pid.h>
+#include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/slab.h>
 #include <linux/errqueue.h>
@@ -210,6 +211,19 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 			p->creds.gid = gid;
 			break;
 		}
+		case SCM_PIDFD:
+		{
+			unsigned int flags;
+
+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(flags)))
+				goto error;
+			memcpy(&flags, CMSG_DATA(cmsg), sizeof(flags));
+			err = pidfd_validate_flags(flags);
+			if (err)
+				goto error;
+			p->pidfd_flags = flags;
+			break;
+		}
 		default:
 			goto error;
 		}
diff --git a/net/core/sock.c b/net/core/sock.c
index 039be95c40cf..d1fce437c035 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2930,6 +2930,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
 	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
+	case SCM_PIDFD:
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 001ccc55ef0f..8b19dfec0221 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1892,6 +1892,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	UNIXCB(skb).uid = scm->creds.uid;
 	UNIXCB(skb).gid = scm->creds.gid;
 	UNIXCB(skb).fp = NULL;
+	UNIXCB(skb).pidfd_flags = scm->pidfd_flags;
 	unix_get_secdata(scm, skb);
 	if (scm->fp && send_fds)
 		err = unix_attach_fds(scm, skb);
@@ -2486,6 +2487,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 	memset(&scm, 0, sizeof(scm));
 
 	scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	scm.pidfd_flags = UNIXCB(skb).pidfd_flags;
 	unix_set_secdata(&scm, skb);
 
 	if (!(flags & MSG_PEEK)) {
@@ -2873,6 +2875,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 			   test_bit(SOCK_PASSPIDFD, &sock->flags)) {
 			/* Copy credentials */
 			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+			scm.pidfd_flags = UNIXCB(skb).pidfd_flags;
 			unix_set_secdata(&scm, skb);
 			check_creds = true;
 		}
diff --git a/tools/testing/selftests/net/af_unix/scm_pidfd.c b/tools/testing/selftests/net/af_unix/scm_pidfd.c
index 7e534594167e..1e70ff253a1d 100644
--- a/tools/testing/selftests/net/af_unix/scm_pidfd.c
+++ b/tools/testing/selftests/net/af_unix/scm_pidfd.c
@@ -5,6 +5,7 @@
 #include <stddef.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <fcntl.h>
 #include <sys/socket.h>
 #include <linux/socket.h>
 #include <unistd.h>
@@ -15,6 +16,11 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+/* There are problems including linux/pidfd.h, so define. */
+#ifndef PIDFD_NONBLOCK
+#define PIDFD_NONBLOCK  O_NONBLOCK
+#endif
+
 #include "../../kselftest_harness.h"
 
 #define clean_errno() (errno == 0 ? "None" : strerror(errno))
@@ -126,7 +132,7 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
 	return result;
 }
 
-static int cmsg_check(int fd)
+static int cmsg_check(int fd, unsigned int pidfd_flags)
 {
 	struct msghdr msg = { 0 };
 	struct cmsghdr *cmsg;
@@ -136,6 +142,7 @@ static int cmsg_check(int fd)
 	char control[CMSG_SPACE(sizeof(struct ucred)) +
 		     CMSG_SPACE(sizeof(int))] = { 0 };
 	int *pidfd = NULL;
+	unsigned int flags;
 	pid_t parent_pid;
 	int err;
 
@@ -197,6 +204,13 @@ static int cmsg_check(int fd)
 		return 1;
 	}
 
+	flags = fcntl(*pidfd, F_GETFL, 0);
+	flags &= ~O_ACCMODE;
+	if (flags != pidfd_flags) {
+		log_err("SCM_PIDFD flags mismatch: %x != %x", flags, pidfd_flags);
+		return 1;
+	}
+
 	/* pidfd from SCM_PIDFD should point to the parent process PID */
 	parent_pid =
 		get_pid_from_fdinfo_file(*pidfd, "Pid:", sizeof("Pid:") - 1);
@@ -227,30 +241,49 @@ FIXTURE_VARIANT(scm_pidfd)
 {
 	int type;
 	bool abstract;
+	unsigned int flags;
 };
 
 FIXTURE_VARIANT_ADD(scm_pidfd, stream_pathname)
 {
 	.type = SOCK_STREAM,
 	.abstract = 0,
+	.flags = 0,
 };
 
 FIXTURE_VARIANT_ADD(scm_pidfd, stream_abstract)
 {
 	.type = SOCK_STREAM,
 	.abstract = 1,
+	.flags = 0,
 };
 
 FIXTURE_VARIANT_ADD(scm_pidfd, dgram_pathname)
 {
 	.type = SOCK_DGRAM,
 	.abstract = 0,
+	.flags = 0,
 };
 
 FIXTURE_VARIANT_ADD(scm_pidfd, dgram_abstract)
 {
 	.type = SOCK_DGRAM,
 	.abstract = 1,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(scm_pidfd, stream_nonblock)
+{
+	.type = SOCK_STREAM,
+	.abstract = 0,
+	.flags = PIDFD_NONBLOCK,
+};
+
+FIXTURE_VARIANT_ADD(scm_pidfd, dgram_nonblock)
+{
+	.type = SOCK_DGRAM,
+	.abstract = 0,
+	.flags = PIDFD_NONBLOCK,
 };
 
 FIXTURE_SETUP(scm_pidfd)
@@ -335,7 +368,7 @@ static void client(FIXTURE_DATA(scm_pidfd) *self,
 
 	close(self->startup_pipe[1]);
 
-	if (cmsg_check(cfd)) {
+	if (cmsg_check(cfd, variant->flags)) {
 		log_err("cmsg_check failed");
 		child_die();
 	}
@@ -375,6 +408,27 @@ TEST_F(scm_pidfd, test)
 	int err;
 	int pfd;
 	int child_status = 0;
+	char iobuf;
+	unsigned int pidfd_flags;
+	struct msghdr msg = { 0 };
+	struct cmsghdr *cmsg;
+	struct iovec io = {
+		.iov_base = &iobuf,
+		.iov_len = sizeof(iobuf)
+	};
+	union {
+		char buf[CMSG_SPACE(sizeof(pidfd_flags))];
+		struct cmsghdr align;
+	} u;
+
+	msg.msg_iov = &io;
+	msg.msg_iovlen = 1;
+	msg.msg_control = u.buf;
+	msg.msg_controllen = sizeof(u.buf);
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type = SCM_PIDFD;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(pidfd_flags));
 
 	self->server = socket(AF_UNIX, variant->type, 0);
 	ASSERT_NE(-1, self->server);
@@ -414,12 +468,16 @@ TEST_F(scm_pidfd, test)
 	close(self->startup_pipe[0]);
 
 	if (variant->type == SOCK_DGRAM) {
-		err = sendto(pfd, "x", sizeof(char), 0, (struct sockaddr *)&self->client_addr->listen_addr, self->client_addr->addrlen);
-		ASSERT_NE(-1, err);
-	} else {
-		err = send(pfd, "x", sizeof(char), 0);
+		err = connect(pfd,
+			      (struct sockaddr *)&self->client_addr->listen_addr,
+			      self->client_addr->addrlen);
 		ASSERT_NE(-1, err);
 	}
+	iobuf = 'x';
+	pidfd_flags = variant->flags;
+	memcpy(CMSG_DATA(cmsg), &pidfd_flags, sizeof(pidfd_flags));
+	err = sendmsg(pfd, &msg, 0);
+	ASSERT_NE(-1, err);
 
 	close(pfd);
 	waitpid(self->client_pid, &child_status, 0);
-- 
2.47.0


