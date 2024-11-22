Return-Path: <linux-kselftest+bounces-22447-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8EF9D5E46
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 12:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FE77282099
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 11:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AADD1DE883;
	Fri, 22 Nov 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq/Zws1m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF711D0143;
	Fri, 22 Nov 2024 11:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275495; cv=none; b=tB7lUayHgMlRGBYy4HIolcuUypuQG3U5MP7bqY8sFZGgZmDeV08IbSKnvTgmX2bEF3t1EEnkQn6ioLTr1thaZ4oX+tpoyLnRLAQVg4CsWkAw5mi/iWyK+oE6yCHkktbxQlgzF1zIfkm7l+pnpbQzteqdYLlR1ZwiZ0ROtvExchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275495; c=relaxed/simple;
	bh=oKtNeEnFrwFN8m26dW4XRnqFv2VmwvnXrV1YXsQ42DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fo6Q4ZUGgs3GdOetAG5WiC2BVZ4cP0GWIpE69pBhO0CVu2x9LCcWQx1n7aobw28Yz1xKHsa84FLwYhH/0GA7fCSF9vMf5Z3kHsi84wXWBNUcJ6+ttRJjx5FKAwEx3F8QZ3rGfcYDo2U+2aGDXp0FtkkAF+iAUtZnVKWXjD17cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq/Zws1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5686C4CECE;
	Fri, 22 Nov 2024 11:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732275494;
	bh=oKtNeEnFrwFN8m26dW4XRnqFv2VmwvnXrV1YXsQ42DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Sq/Zws1mLJEcRyYZDx5I+LzFS/iSxrxjEWcga78S0p+dndq9aw8KHYGc8D8dO9ObM
	 pnqkj37WOr6XCQe9ipIyAZmfvD5XXPcT5Tmg5bdoAnXVwuVk1BPLwZsLrXHagmc0d7
	 +aaXM4seSE4cqVVEiCdVa1uQ0sviyFAAxE1xBRvNGyRzCGFenL58YucRPIh6E/lAhV
	 oGbahnxjJx5oA9QVamCqSwS815Dt+FPNt5CdM7l4wLyWi8EwdNygtgIl1wZY/zDBJ8
	 aST5+GmtiAZNYcc489NqLijN3xGgI/lwuGras8wBnu2pj/h0pPsFvSu0vPRwgr5x+0
	 Oax+b6h4s6/8w==
Date: Fri, 22 Nov 2024 12:38:05 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: stsp2@yandex.ru, almasrymina@google.com, asml.silence@gmail.com, 
	axboe@kernel.dk, cyphar@cyphar.com, davem@davemloft.net, edumazet@google.com, 
	gouhao@uniontech.com, horms@kernel.org, kees@kernel.org, krisman@suse.de, 
	kuba@kernel.org, kuniyu@amazon.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, mhal@rbox.co, netdev@vger.kernel.org, oleg@redhat.com, 
	pabeni@redhat.com, quic_abchauha@quicinc.com, shuah@kernel.org, 
	tandersen@netflix.com, viro@zeniv.linux.org.uk, willemb@google.com
Subject: Re: [PATCH net-next v3] af_unix: pass pidfd flags via SCM_PIDFD cmsg
Message-ID: <20241122-selbstsicher-wurschteln-fbf73aa9459c@brauner>
References: <20241116101120.323174-1-stsp2@yandex.ru>
 <20241121125732.88044-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121125732.88044-1-aleksandr.mikhalitsyn@canonical.com>

On Thu, Nov 21, 2024 at 01:57:32PM +0100, Alexander Mikhalitsyn wrote:
> >Currently SCM_PIDFD cmsg cannot be sent via unix socket
> >(returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
> >The created pidfd always has flags set to 0.
> >
> >This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
> >can be used to send flags to SO_PASSPIDFD-enabled recipient.
> >
> >Self-test is added for the propagation of PIDFD_NONBLOCK flag.
> 
> >This is mainly needed for the future extensions, like eg this one:
> >https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
> >where it was suggested to try solving the supplementary groups
> >problem with pidfd.
> >
> >Changes in v3: specify target tree in patch subject
> >Changes in v2: remove flags validation in scm_pidfd_recv(), as
> >  suggested by Kuniyuki Iwashima <kuniyu@amazon.com>
> >
> >Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> 
> ...
> 
> >diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> >index 75bdf9807802..c4c5c1a0c2ad 100644
> >--- a/include/linux/pidfs.h
> >+++ b/include/linux/pidfs.h
> >@@ -2,7 +2,16 @@
> > #ifndef _LINUX_PID_FS_H
> > #define _LINUX_PID_FS_H
> > 
> >+#include <uapi/linux/pidfd.h>
> >+
> > struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
> > void __init pidfs_init(void);
> > 
> >+static inline int pidfd_validate_flags(unsigned int flags)
> >+{
> >+	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
> >+		return -EINVAL;
> >+	return 0;
> >+}
> >+
> > #endif /* _LINUX_PID_FS_H */
> >diff --git a/include/linux/socket.h b/include/linux/socket.h
> >index d18cc47e89bd..ee27d391e5aa 100644
> >--- a/include/linux/socket.h
> >+++ b/include/linux/socket.h
> >@@ -178,7 +178,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
> > #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
> > #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
> > #define SCM_SECURITY	0x03		/* rw: security label		*/
> >-#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
> >+#define SCM_PIDFD	0x04		/* r: pidfd, w: pidfd_flags (int) */
> > 
> > struct ucred {
> > 	__u32	pid;
> >diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> >index 63129c79b8cb..4bc197548c2f 100644
> >--- a/include/net/af_unix.h
> >+++ b/include/net/af_unix.h
> >@@ -62,6 +62,7 @@ struct unix_skb_parms {
> > #ifdef CONFIG_SECURITY_NETWORK
> > 	u32			secid;		/* Security ID		*/
> > #endif
> >+	u32			pidfd_flags;
> > 	u32			consumed;
> > } __randomize_layout;
> > 
> >diff --git a/include/net/scm.h b/include/net/scm.h
> >index 0d35c7c77a74..1326edcacacb 100644
> >--- a/include/net/scm.h
> >+++ b/include/net/scm.h
> >@@ -48,6 +48,7 @@ struct scm_cookie {
> > #ifdef CONFIG_SECURITY_NETWORK
> > 	u32			secid;		/* Passed security ID 	*/
> > #endif
> >+	u32			pidfd_flags;
> > };
> > 
> > void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> >@@ -154,7 +155,7 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
> > 	if (!scm->pid)
> > 		return;
> > 
> >-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
> >+	pidfd = pidfd_prepare(scm->pid, scm->pidfd_flags, &pidfd_file);
> > 
> > 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
> > 		if (pidfd_file) {
> >diff --git a/kernel/pid.c b/kernel/pid.c
> >index 2715afb77eab..b1100ae8ea63 100644
> >--- a/kernel/pid.c
> >+++ b/kernel/pid.c
> >@@ -629,10 +629,12 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
> > SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > {
> > 	int fd;
> >+	int err;
> > 	struct pid *p;
> > 
> >-	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
> >-		return -EINVAL;
> >+	err = pidfd_validate_flags(flags);
> >+	if (err)
> >+		return err;
> > 
> > 	if (pid <= 0)
> > 		return -EINVAL;
> >diff --git a/net/core/scm.c b/net/core/scm.c
> >index 4f6a14babe5a..3bcdecdacd7e 100644
> >--- a/net/core/scm.c
> >+++ b/net/core/scm.c
> >@@ -23,6 +23,7 @@
> > #include <linux/security.h>
> > #include <linux/pid_namespace.h>
> > #include <linux/pid.h>
> >+#include <linux/pidfs.h>
> > #include <linux/nsproxy.h>
> > #include <linux/slab.h>
> > #include <linux/errqueue.h>
> >@@ -210,6 +211,19 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
> > 			p->creds.gid = gid;
> > 			break;
> > 		}
> >+		case SCM_PIDFD:
> >+		{
> >+			unsigned int flags;
> >+
> >+			if (cmsg->cmsg_len != CMSG_LEN(sizeof(flags)))
> >
> 
> Hi Stas!
> 
> Hmm, it is a bit unusual that SCM_PIDFD message format is different in case
> when you send it and when you read it.
> 
> I mean that when you read it (on the receiver side) you get pidfd file descriptor number,
> while when you write it (on the sender side) you are only allowed to send one integer and this time it's
> a pidfd file descriptor flags. I personally have nothing strictly against that but just found this
> a bit unusual and probably confusing for userspace programmers.
> 
> Compare it with SCM_CREDENTIALS, for instance, where we read/write the same structure struct ucred.
> 
> >+				goto error;
> >+			memcpy(&flags, CMSG_DATA(cmsg), sizeof(flags));
> >+			err = pidfd_validate_flags(flags);
> 
> pidfd_validate_flags allows PIDFD_THREAD, but what's the idea behind this if
> scm->pid is always a thread-group leader? (see maybe_add_creds() function).
> 
> Sorry if I misunderstand something just want to ensure that we are on the same page.

The sender will not be put in control of what flags the pidfd will be
created on the receivers side. That's just an invitation for subtle
bugs. The receiver can always toggle O_NONBLOCK via a fcntl() on the
pidfd once it received it. The whole flag thing should be dropped.

The format change is also an api break which is another reason this
won't happen.

