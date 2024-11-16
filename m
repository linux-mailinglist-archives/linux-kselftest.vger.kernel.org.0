Return-Path: <linux-kselftest+bounces-22132-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B36E9CFBF0
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 02:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24AF284406
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Nov 2024 01:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107EC74421;
	Sat, 16 Nov 2024 01:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pK2LrKLI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104F345003;
	Sat, 16 Nov 2024 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731719454; cv=none; b=I10LSz2SWR+GwApwO/8dNohiDBEuy38+3j/TqkOzDoH+gyv4tA1f4lHWnJb0YotLACb5cFXeVUDw1wgM2nPAeBDsYIsMaP5kcs5fZ8fCNLl22XyuR8fpdErRAEpRaeusgeWDPWVzZRBEDQeUTV/cmJPbR+flnQyoPXGpMWE9XvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731719454; c=relaxed/simple;
	bh=s8FsK55RfNkPVlqWqVt25Ac+d5jXBqfa1XLJHTT7q7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4n9nAyR3gT3iFep1xkRa8LPA4uzYilgXdOx7AxF0cV40+cqvrjBjChtE91Sr8rRNJwWGvNenrycaHNwIcCuAY2DYbXAiwd/OmHmuUgvc1+PjZr7joGxV+4I7mslMWjmp4vzrtShPo9qBTYwSe/qEiwk2RZpiwIo5gstVAtbfFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pK2LrKLI; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731719452; x=1763255452;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oZf83NcSi94ctWC30Z+k813YHX+uNN8Tlt2tor25DCQ=;
  b=pK2LrKLI/rP8W41eJ4XYq9+NPW2lhkn912GGcP01MvVBqYdMOsHhl4pv
   r6LOsbE8gPyn+dS9103YTgpeYRWCPurnKGSa/OKV/ThRJD6YvvXudvLTA
   vrOuJinO0Q7nKbJw00gOMuiZ0V2928mCotD653eH+d4/5Uz9s20IUloFg
   0=;
X-IronPort-AV: E=Sophos;i="6.12,158,1728950400"; 
   d="scan'208";a="385827814"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2024 01:10:46 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:7363]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.147:2525] with esmtp (Farcaster)
 id 98dd0642-8156-4c38-bcef-9c8974a3a191; Sat, 16 Nov 2024 01:10:46 +0000 (UTC)
X-Farcaster-Flow-ID: 98dd0642-8156-4c38-bcef-9c8974a3a191
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sat, 16 Nov 2024 01:10:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Sat, 16 Nov 2024 01:10:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <stsp2@yandex.ru>
CC: <almasrymina@google.com>, <asml.silence@gmail.com>, <axboe@kernel.dk>,
	<brauner@kernel.org>, <cyphar@cyphar.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <gouhao@uniontech.com>, <horms@kernel.org>,
	<kees@kernel.org>, <krisman@suse.de>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<mhal@rbox.co>, <netdev@vger.kernel.org>, <oleg@redhat.com>,
	<pabeni@redhat.com>, <quic_abchauha@quicinc.com>, <shuah@kernel.org>,
	<tandersen@netflix.com>, <viro@zeniv.linux.org.uk>, <willemb@google.com>
Subject: Re: [PATCH v2] net/unix: pass pidfd flags via SCM_PIDFD cmsg
Date: Fri, 15 Nov 2024 17:10:38 -0800
Message-ID: <20241116011038.94912-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241114091909.3552288-1-stsp2@yandex.ru>
References: <20241114091909.3552288-1-stsp2@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> [PATCH v2] net/unix: pass pidfd flags via SCM_PIDFD cmsg

Please specify the target tree; net for fixes, net-next for others.
https://www.kernel.org/doc/html/v6.11/process/maintainer-netdev.html

  [PATCH net-next v3] af_unix: pass ...


From: Stas Sergeev <stsp2@yandex.ru>
Date: Thu, 14 Nov 2024 12:19:09 +0300
> Currently SCM_PIDFD cmsg cannot be sent via unix socket
> (returns -EINVAL) and SO_PASSPIDFD doesn't support flags.
> The created pidfd always has flags set to 0.
> 
> This patch implements SCM_PIDFD cmsg in AF_UNIX socket, which
> can be used to send flags to SO_PASSPIDFD-enabled recipient.
> 
> Self-test is added for the propagation of PIDFD_NONBLOCK flag.
> 
> This is mainly needed for the future extensions, like eg this one:
> https://lore.kernel.org/lkml/8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru/T/#me1237e46deba8574b77834b7704e63559ffef9cb
> where it was suggested to try solving the supplementary groups
> problem with pidfd.
> 
> Changes in v2: remove flags validation in scm_pidfd_recv(), as
>   suggested by Kuniyuki Iwashima <kuniyu@amazon.com>

You can put this changelog and the following CC: under '---' so
that they will disappear during merge.

> 
> Signed-off-by: Stas Sergeev <stsp2@yandex.ru>
> 
> CC: "David S. Miller" <davem@davemloft.net>
> CC: Eric Dumazet <edumazet@google.com>
> CC: Jakub Kicinski <kuba@kernel.org>
> CC: Paolo Abeni <pabeni@redhat.com>
> CC: Simon Horman <horms@kernel.org>
> CC: Shuah Khan <shuah@kernel.org>
> CC: Christian Brauner <brauner@kernel.org>
> CC: Jens Axboe <axboe@kernel.dk>
> CC: Willem de Bruijn <willemb@google.com>
> CC: Pavel Begunkov <asml.silence@gmail.com>
> CC: Gabriel Krisman Bertazi <krisman@suse.de>
> CC: Mina Almasry <almasrymina@google.com>
> CC: Oleg Nesterov <oleg@redhat.com>
> CC: Tycho Andersen <tandersen@netflix.com>
> CC: Al Viro <viro@zeniv.linux.org.uk>
> CC: Kuniyuki Iwashima <kuniyu@amazon.com>
> CC: Gou Hao <gouhao@uniontech.com>
> CC: Abhishek Chauhan <quic_abchauha@quicinc.com>
> CC: Michal Luczaj <mhal@rbox.co>
> CC: Kees Cook <kees@kernel.org>
> CC: Aleksa Sarai <cyphar@cyphar.com>
> CC: linux-kernel@vger.kernel.org
> CC: netdev@vger.kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---

^^^ Here


>  include/linux/pidfs.h                         |  9 +++
>  include/linux/socket.h                        |  2 +-
>  include/net/af_unix.h                         |  1 +
>  include/net/scm.h                             |  3 +-
>  kernel/pid.c                                  |  6 +-
>  net/core/scm.c                                | 14 ++++
>  net/core/sock.c                               |  1 +
>  net/unix/af_unix.c                            |  3 +
>  .../testing/selftests/net/af_unix/scm_pidfd.c | 70 +++++++++++++++++--
>  9 files changed, 99 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 75bdf9807802..c4c5c1a0c2ad 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -2,7 +2,16 @@
>  #ifndef _LINUX_PID_FS_H
>  #define _LINUX_PID_FS_H
>  
> +#include <uapi/linux/pidfd.h>
> +
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
>  void __init pidfs_init(void);
>  
> +static inline int pidfd_validate_flags(unsigned int flags)
> +{
> +	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
> +		return -EINVAL;
> +	return 0;
> +}
> +
>  #endif /* _LINUX_PID_FS_H */
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index d18cc47e89bd..ee27d391e5aa 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -178,7 +178,7 @@ static inline size_t msg_data_left(struct msghdr *msg)
>  #define	SCM_RIGHTS	0x01		/* rw: access rights (array of int) */
>  #define SCM_CREDENTIALS 0x02		/* rw: struct ucred		*/
>  #define SCM_SECURITY	0x03		/* rw: security label		*/
> -#define SCM_PIDFD	0x04		/* ro: pidfd (int)		*/
> +#define SCM_PIDFD	0x04		/* r: pidfd, w: pidfd_flags (int) */
>  
>  struct ucred {
>  	__u32	pid;
> diff --git a/include/net/af_unix.h b/include/net/af_unix.h
> index 63129c79b8cb..4bc197548c2f 100644
> --- a/include/net/af_unix.h
> +++ b/include/net/af_unix.h
> @@ -62,6 +62,7 @@ struct unix_skb_parms {
>  #ifdef CONFIG_SECURITY_NETWORK
>  	u32			secid;		/* Security ID		*/
>  #endif
> +	u32			pidfd_flags;
>  	u32			consumed;
>  } __randomize_layout;
>  
> diff --git a/include/net/scm.h b/include/net/scm.h
> index 0d35c7c77a74..1326edcacacb 100644
> --- a/include/net/scm.h
> +++ b/include/net/scm.h
> @@ -48,6 +48,7 @@ struct scm_cookie {
>  #ifdef CONFIG_SECURITY_NETWORK
>  	u32			secid;		/* Passed security ID 	*/
>  #endif
> +	u32			pidfd_flags;

Now we consume 40 byes of cb[48].

If we need more storage in the future, we may want to save
converted flags in __scm_send() and restore that in
scm_pidfd_recv().

No need to do so now, just a note.


>  };
>  
>  void scm_detach_fds(struct msghdr *msg, struct scm_cookie *scm);
> @@ -154,7 +155,7 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
>  	if (!scm->pid)
>  		return;
>  
> -	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
> +	pidfd = pidfd_prepare(scm->pid, scm->pidfd_flags, &pidfd_file);
>  
>  	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
>  		if (pidfd_file) {
> diff --git a/kernel/pid.c b/kernel/pid.c
> index 2715afb77eab..b1100ae8ea63 100644
> --- a/kernel/pid.c
> +++ b/kernel/pid.c
> @@ -629,10 +629,12 @@ static int pidfd_create(struct pid *pid, unsigned int flags)
>  SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
>  {
>  	int fd;
> +	int err;
>  	struct pid *p;
>  
> -	if (flags & ~(PIDFD_NONBLOCK | PIDFD_THREAD))
> -		return -EINVAL;
> +	err = pidfd_validate_flags(flags);
> +	if (err)
> +		return err;
>  
>  	if (pid <= 0)
>  		return -EINVAL;
> diff --git a/net/core/scm.c b/net/core/scm.c
> index 4f6a14babe5a..3bcdecdacd7e 100644
> --- a/net/core/scm.c
> +++ b/net/core/scm.c
> @@ -23,6 +23,7 @@
>  #include <linux/security.h>
>  #include <linux/pid_namespace.h>
>  #include <linux/pid.h>
> +#include <linux/pidfs.h>
>  #include <linux/nsproxy.h>
>  #include <linux/slab.h>
>  #include <linux/errqueue.h>
> @@ -210,6 +211,19 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
>  			p->creds.gid = gid;
>  			break;
>  		}
> +		case SCM_PIDFD:
> +		{
> +			unsigned int flags;
> +
> +			if (cmsg->cmsg_len != CMSG_LEN(sizeof(flags)))
> +				goto error;
> +			memcpy(&flags, CMSG_DATA(cmsg), sizeof(flags));
> +			err = pidfd_validate_flags(flags);
> +			if (err)
> +				goto error;
> +			p->pidfd_flags = flags;
> +			break;
> +		}

Now this allows sending pidfd without SO_PASSPIDFD, so you need to
add a validation for "if (!msg->msg_control)" in __scm_recv_common().


>  		default:
>  			goto error;
>  		}
> diff --git a/net/core/sock.c b/net/core/sock.c
> index 039be95c40cf..d1fce437c035 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -2930,6 +2930,7 @@ int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
>  	/* SCM_RIGHTS and SCM_CREDENTIALS are semantically in SOL_UNIX. */
>  	case SCM_RIGHTS:
>  	case SCM_CREDENTIALS:
> +	case SCM_PIDFD:
>  		break;
>  	default:
>  		return -EINVAL;
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 001ccc55ef0f..8b19dfec0221 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1892,6 +1892,7 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
>  	UNIXCB(skb).uid = scm->creds.uid;
>  	UNIXCB(skb).gid = scm->creds.gid;
>  	UNIXCB(skb).fp = NULL;
> +	UNIXCB(skb).pidfd_flags = scm->pidfd_flags;
>  	unix_get_secdata(scm, skb);
>  	if (scm->fp && send_fds)
>  		err = unix_attach_fds(scm, skb);
> @@ -2486,6 +2487,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
>  	memset(&scm, 0, sizeof(scm));
>  
>  	scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
> +	scm.pidfd_flags = UNIXCB(skb).pidfd_flags;
>  	unix_set_secdata(&scm, skb);
>  
>  	if (!(flags & MSG_PEEK)) {
> @@ -2873,6 +2875,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
>  			   test_bit(SOCK_PASSPIDFD, &sock->flags)) {
>  			/* Copy credentials */
>  			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
> +			scm.pidfd_flags = UNIXCB(skb).pidfd_flags;
>  			unix_set_secdata(&scm, skb);
>  			check_creds = true;
>  		}

