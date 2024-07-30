Return-Path: <linux-kselftest+bounces-14486-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FF1941FE3
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463C01C23344
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694481AA3DF;
	Tue, 30 Jul 2024 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="N+Pw+dTI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712E01AA3E8
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364912; cv=none; b=gnds9rFg+L9kII4aUNEriB2e4oJO2I88CalZ59ZgEN516N3/Udr6dLf+pldSnOwMG/Ywonfo/1x9rD7DES1XKbHLGn8XTRtRCu8mU6yNZVdk/PJCsPYJM1WC3QJWCjScbSA9FG/aV44tpOGUrZLBsaaoPLna1W3fKpdy41XRDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364912; c=relaxed/simple;
	bh=8U98s/x9klh3R1w6W5giSFPu50LKMrDr3xkDem20ovU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F7mzSSxrlXjVBNuAja4OlUEaDM10L+z2tAzqP4yuIOEOfSi7ZXINp/VxfHWoNEgglzB5I2u6DGNgFshrMyqWHX8Kr2ZKZ2h8MVhfFc2oeT1tgci0mKQTRJbJfMHBYXRfIN80xWVDaf9rOUfG6ttaKSMoK4+k9hAgRReTRoeYDbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=N+Pw+dTI; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3db16129143so2852148b6e.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 11:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722364909; x=1722969709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BikDbh1/9SQRd/kB9M3Eiu6ynP/hqf/DKnY/EEbSCvw=;
        b=N+Pw+dTIBOonZAMRwaWpPTXXLjcLZGhKYt7Qw15QeFMjczQ0OtfUyzUtKaeD7SP91g
         kqdajdep9ypI8z34Ug+5Wizauo+xpj53/G5cMquY8odJjl1GUWdxtP62ez8Nskh8pZi+
         KWz3Bde3bFQ75tgrhQzj2CzfiK+udABX4Zc5te8o4Pt5R5OahuhXQ1DzrEZC5tzwxoE0
         geghNVldj/RVAaFNIlm9j/UYHF5AIOD5iHk9Ii7jq237ssoPBpKsR6YsKlNJCpgcvps9
         vvqb7oekb3mW/CXRwN5gILDqf+iCQGj4XrgKo1DLQ4sI4nwnGXE140J/iOAMxdqIGXeR
         pEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364909; x=1722969709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BikDbh1/9SQRd/kB9M3Eiu6ynP/hqf/DKnY/EEbSCvw=;
        b=uDzZ74Y8SiVVo8w4m8TYtd+502p89aOOq4g3vpyvHuPQ3aobwwBM2BgbmEkh6rUc6C
         eUsv0lsaC80keKO2bCrYf6Bt9yJTSDP4L5Xdo4OO82w0rlzOB+l/e9NUywFgx/MWe0xJ
         2uAitrNHr4lDCavemydpaHThItPeBHDy92kpZKixeQgGk1a6G1rTW0b+T/Obj2dS24Pl
         7GgYz9/mVjUR7C1KUYcPm20YpoTKdHc8T/pCcq8S6gxGSGd7esbalgPaHTkLE9rqwKSn
         3RS6zIlIGUSW7ZNV3EgY+KUzshdMHDRjVP7uPyJuB9fLBF50CimN1JdNZhWSvbcZrPYY
         1bKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzSbQ8uO0KqXgQGO1EXknstQozNt8qUqWuR78brZiYNIB9U3E8NyfTTkx7gbfdVFqBW7MNYRFAzkrVuBXJYFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd0W0pag8z6F8IwVRidjHpCRyHPHPUO2aiSL62QlAz9m6ibZ88
	cD+XIhgrsw+2or/P5jD8mc7eznDhk5WFBP0oZeXQ2Fgr58OBq5BzLp4l61ZJSZU=
X-Google-Smtp-Source: AGHT+IHmEFKIeORqg/Jp5LW/faNuIRskuviRnwXbCec0ZGE8Hd/p/5viL9PkgWoYAhj4ZtwgZOhnlQ==
X-Received: by 2002:a05:6358:591a:b0:1ac:671a:f39f with SMTP id e5c5f4694b2df-1adbe30dbcbmr1511840855d.11.1722364909193;
        Tue, 30 Jul 2024 11:41:49 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb07bf7sm66132716d6.137.2024.07.30.11.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:41:48 -0700 (PDT)
From: zijianzhang@bytedance.com
To: netdev@vger.kernel.org
Cc: linux-api@vger.kernel.org,
	willemdebruijn.kernel@gmail.com,
	almasrymina@google.com,
	edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	axboe@kernel.dk,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	cong.wang@bytedance.com,
	xiaochun.lu@bytedance.com,
	Zijian Zhang <zijianzhang@bytedance.com>
Subject: [PATCH net-next v8 1/3] sock: support copying cmsgs to the user space in sendmsg
Date: Tue, 30 Jul 2024 18:41:18 +0000
Message-Id: <20240730184120.4089835-2-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240730184120.4089835-1-zijianzhang@bytedance.com>
References: <20240730184120.4089835-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zijian Zhang <zijianzhang@bytedance.com>

Users can pass msg_control as a placeholder to recvmsg, and get some info
from the kernel upon returning of it, but it's not available for sendmsg.
Recvmsg uses put_cmsg to copy info back to the user, while ____sys_sendmsg
creates a kernel copy of msg_control and passes that to the callees,
put_cmsg in sendmsg path will write into this kernel buffer.

If users want to get info after returning of sendmsg, they typically have
to call recvmsg on the MSG_ERRQUEUE of the socket, incurring extra system
call overhead. This commit supports copying cmsg from the kernel space to
the user space upon returning of sendmsg to mitigate this overhead.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 include/linux/socket.h |  8 ++++++
 include/net/sock.h     |  2 +-
 net/core/sock.c        |  6 ++--
 net/ipv4/ip_sockglue.c |  2 +-
 net/ipv6/datagram.c    |  2 +-
 net/socket.c           | 63 ++++++++++++++++++++++++++++++++++++++----
 6 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/include/linux/socket.h b/include/linux/socket.h
index df9cdb8bbfb8..40173c919d0f 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -71,6 +71,7 @@ struct msghdr {
 		void __user	*msg_control_user;
 	};
 	bool		msg_control_is_user : 1;
+	bool		msg_control_copy_to_user : 1;
 	bool		msg_get_inq : 1;/* return INQ after receive */
 	unsigned int	msg_flags;	/* flags on received message */
 	__kernel_size_t	msg_controllen;	/* ancillary data buffer length */
@@ -168,6 +169,11 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 	return __cmsg_nxthdr(__msg->msg_control, __msg->msg_controllen, __cmsg);
 }
 
+static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
+{
+	return 0;
+}
+
 static inline size_t msg_data_left(struct msghdr *msg)
 {
 	return iov_iter_count(&msg->msg_iter);
@@ -396,6 +402,8 @@ struct timespec64;
 struct __kernel_timespec;
 struct old_timespec32;
 
+DECLARE_STATIC_KEY_FALSE(tx_copy_cmsg_to_user_key);
+
 struct scm_timestamping_internal {
 	struct timespec64 ts[3];
 };
diff --git a/include/net/sock.h b/include/net/sock.h
index cce23ac4d514..9c728287d21d 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1804,7 +1804,7 @@ static inline void sockcm_init(struct sockcm_cookie *sockc,
 	};
 }
 
-int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
+int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
 		     struct sockcm_cookie *sockc);
 int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
 		   struct sockcm_cookie *sockc);
diff --git a/net/core/sock.c b/net/core/sock.c
index 9abc4fe25953..b2cbe753af1d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2826,8 +2826,8 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 }
 EXPORT_SYMBOL(sock_alloc_send_pskb);
 
-int __sock_cmsg_send(struct sock *sk, struct cmsghdr *cmsg,
-		     struct sockcm_cookie *sockc)
+int __sock_cmsg_send(struct sock *sk, struct msghdr *msg __always_unused,
+		     struct cmsghdr *cmsg, struct sockcm_cookie *sockc)
 {
 	u32 tsflags;
 
@@ -2881,7 +2881,7 @@ int sock_cmsg_send(struct sock *sk, struct msghdr *msg,
 			return -EINVAL;
 		if (cmsg->cmsg_level != SOL_SOCKET)
 			continue;
-		ret = __sock_cmsg_send(sk, cmsg, sockc);
+		ret = __sock_cmsg_send(sk, msg, cmsg, sockc);
 		if (ret)
 			return ret;
 	}
diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index cf377377b52d..6360b8ba9c84 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -267,7 +267,7 @@ int ip_cmsg_send(struct sock *sk, struct msghdr *msg, struct ipcm_cookie *ipc,
 		}
 #endif
 		if (cmsg->cmsg_level == SOL_SOCKET) {
-			err = __sock_cmsg_send(sk, cmsg, &ipc->sockc);
+			err = __sock_cmsg_send(sk, msg, cmsg, &ipc->sockc);
 			if (err)
 				return err;
 			continue;
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index fff78496803d..c9ae30acf895 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -777,7 +777,7 @@ int ip6_datagram_send_ctl(struct net *net, struct sock *sk,
 		}
 
 		if (cmsg->cmsg_level == SOL_SOCKET) {
-			err = __sock_cmsg_send(sk, cmsg, &ipc6->sockc);
+			err = __sock_cmsg_send(sk, msg, cmsg, &ipc6->sockc);
 			if (err)
 				return err;
 			continue;
diff --git a/net/socket.c b/net/socket.c
index fcbdd5bc47ac..4b65ac92045a 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2537,8 +2537,49 @@ static int copy_msghdr_from_user(struct msghdr *kmsg,
 	return err < 0 ? err : 0;
 }
 
-static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
-			   unsigned int flags, struct used_address *used_address,
+DEFINE_STATIC_KEY_FALSE(tx_copy_cmsg_to_user_key);
+
+static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
+				     struct user_msghdr __user *umsg)
+{
+	struct compat_msghdr __user *umsg_compat =
+				(struct compat_msghdr __user *)umsg;
+	unsigned int flags = msg_sys->msg_flags;
+	struct msghdr msg_user = *msg_sys;
+	unsigned long cmsg_ptr;
+	struct cmsghdr *cmsg;
+	int err;
+
+	msg_user.msg_control_is_user = true;
+	msg_user.msg_control_user = umsg->msg_control;
+	cmsg_ptr = (unsigned long)msg_user.msg_control;
+	for_each_cmsghdr(cmsg, msg_sys) {
+		if (!CMSG_OK(msg_sys, cmsg))
+			break;
+		if (!cmsg_copy_to_user(cmsg))
+			continue;
+		err = put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
+			       cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
+		if (err)
+			return err;
+	}
+
+	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT),
+			 COMPAT_FLAGS(umsg));
+	if (err)
+		return err;
+	if (MSG_CMSG_COMPAT & flags)
+		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
+				 &umsg_compat->msg_controllen);
+	else
+		err = __put_user((unsigned long)msg_user.msg_control - cmsg_ptr,
+				 &umsg->msg_controllen);
+	return err;
+}
+
+static int ____sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
+			   struct msghdr *msg_sys, unsigned int flags,
+			   struct used_address *used_address,
 			   unsigned int allowed_msghdr_flags)
 {
 	unsigned char ctl[sizeof(struct cmsghdr) + 20]
@@ -2549,6 +2590,8 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 	ssize_t err;
 
 	err = -ENOBUFS;
+	if (static_branch_unlikely(&tx_copy_cmsg_to_user_key))
+		msg_sys->msg_control_copy_to_user = false;
 
 	if (msg_sys->msg_controllen > INT_MAX)
 		goto out;
@@ -2606,6 +2649,16 @@ static int ____sys_sendmsg(struct socket *sock, struct msghdr *msg_sys,
 			       used_address->name_len);
 	}
 
+	if (static_branch_unlikely(&tx_copy_cmsg_to_user_key)) {
+		if (msg_sys->msg_control_copy_to_user && msg && err >= 0) {
+			ssize_t len = err;
+
+			err = sendmsg_copy_cmsg_to_user(msg_sys, msg);
+			if (!err)
+				err = len;
+		}
+	}
+
 out_freectl:
 	if (ctl_buf != ctl)
 		sock_kfree_s(sock->sk, ctl_buf, ctl_len);
@@ -2648,8 +2701,8 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 	if (err < 0)
 		return err;
 
-	err = ____sys_sendmsg(sock, msg_sys, flags, used_address,
-				allowed_msghdr_flags);
+	err = ____sys_sendmsg(sock, msg, msg_sys, flags, used_address,
+			      allowed_msghdr_flags);
 	kfree(iov);
 	return err;
 }
@@ -2660,7 +2713,7 @@ static int ___sys_sendmsg(struct socket *sock, struct user_msghdr __user *msg,
 long __sys_sendmsg_sock(struct socket *sock, struct msghdr *msg,
 			unsigned int flags)
 {
-	return ____sys_sendmsg(sock, msg, flags, NULL, 0);
+	return ____sys_sendmsg(sock, NULL, msg, flags, NULL, 0);
 }
 
 long __sys_sendmsg(int fd, struct user_msghdr __user *msg, unsigned int flags,
-- 
2.20.1


