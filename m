Return-Path: <linux-kselftest+bounces-14487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F9941FE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 20:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AB701C23266
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB91AA3D5;
	Tue, 30 Jul 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="azuwJn1D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A86F18A6C6
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722364915; cv=none; b=s8/vqMnYl6cm0id1WujOgkOGFq7JJiV59qva4QUr+6Ovlv0nq0Me1+pl4y63y5IMQec+qlVu8q7AS/0D3zJluknUlNKR/bRqZAHoVzx37sKehZtdY3DflSGCr6eyosv2YydtKUDU6zzLk7tAS4w2zUin9bHXiSct5Jyfnv6jBP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722364915; c=relaxed/simple;
	bh=dRcVp0Z7DoqqrWdM+KQxiL42PINqxpG662XC4ml1djE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYQmb7cMOCmMoIUQ18B6fE6ogn7dqYOTVakXrR2N1np+Jzb7FkTmYyck7QSGOELxRh2IZvZZYmRA1EU57orXeiiU2r2NdV7Bnk5y+DjPY9gOcJnfVy992r3go4Rn+2ui6PKXOGHuPAsnBr7gnUlGEKcHJWhAdG0jHQ/CeE1bA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=azuwJn1D; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-65f9708c50dso38813967b3.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722364913; x=1722969713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rPnJjIq98SiA+JXhukXzURjAkFL/DxtFbjsUcIfNX/M=;
        b=azuwJn1DruXA7Z3idgopnUCvXwCiQkBpIVYex79mAflg36qoatXMT+BBcedHxltL9H
         DEqQByKt5NFTjm/mNC6l/3IyVsLJk50ijryFoGvmGLRhN7nKYleRBCF5coeYAEZDOklG
         k562fT6wYRcNEo/wTl+Itlpetx2aD3Y493d5ZKJNHgZLcgZnA2GAejq2yW2eCcf4kxn7
         y1mjaCjNZiHKKebRHgf8IlV8umEHvUshGgSRuPHJrEfTT6CyaDZrsB8FZ9gxVd6XbFn+
         DePdaJqzFhwaZByxSW+PanVwoOVmxfEBiDY7ZmnNFWkn7D967g0OocTg6+ml+8PlozM3
         OBHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722364913; x=1722969713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rPnJjIq98SiA+JXhukXzURjAkFL/DxtFbjsUcIfNX/M=;
        b=bU6i3YM6JEpi3wuXHnzLcQ4dXtoXri029rvVtb+Y0p1w6ENEOVQtTZ4DGwNiLtUiQt
         2cac+7HiMaWmIkLKnuUT2SmsiPjpwhTpIfySLbiK6xjcs0iK56Jf7fUNNjC/u38H2fCY
         eXPUc+XlpAZpLvJLmyD4r+DBq5lSqziIzBVk1bqJAuRTVGIogD+yrs/tGIniwclnwp/H
         LhpLOy9GjMmvC9+u/b2juWsChUG6OX1023fO3/8V3jSmd1W/hkgzwkdmIbz2YtFQc91L
         cjEB/YVWZDcBFE4nrOo/4wmYur7vvIS/Q5ZyqGcwiP3soACgyOZtpzAKdzKMucJsnpJW
         4QYA==
X-Forwarded-Encrypted: i=1; AJvYcCW4OgoAff5DIBC2jJigeGVNmzAfjS3NhjFLAFrABHcURRYO3Us8Ex+OS10gfN0TL7n9oTgLqn22vVrJzxIxSWMNgBGgYAqCNzaTh1r84WkP
X-Gm-Message-State: AOJu0Yy0d5IBMU8th/Pa7HLC7k1RbWOh/gMfk9IgGXJw/14KOFhCTCSj
	NOz1pM+QlO5alhMrOOHQS4rDcNFGMb/weSvNr1vEEPwe9haFW/mBjMuiC2iumkc=
X-Google-Smtp-Source: AGHT+IEryLVpO7mWHAYjPE/Ggq/E9tDXYa/U1l8LGbTJENtvyJIBzIceolRcnGS9FGQKyr5d7l2SVw==
X-Received: by 2002:a05:6902:1029:b0:e0b:4aa4:1704 with SMTP id 3f1490d57ef6-e0b5446cb77mr15436368276.18.1722364912943;
        Tue, 30 Jul 2024 11:41:52 -0700 (PDT)
Received: from n191-036-066.byted.org ([139.177.233.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fb07bf7sm66132716d6.137.2024.07.30.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 11:41:52 -0700 (PDT)
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
Subject: [PATCH net-next v8 2/3] sock: add MSG_ZEROCOPY notification mechanism based on msg_control
Date: Tue, 30 Jul 2024 18:41:19 +0000
Message-Id: <20240730184120.4089835-3-zijianzhang@bytedance.com>
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

The MSG_ZEROCOPY flag enables copy avoidance for socket send calls.
However, zerocopy is not a free lunch. Apart from the management of user
pages, the combination of poll + recvmsg to receive notifications incurs
unignorable overhead in the applications. We try to mitigate this overhead
with a new notification mechanism based on msg_control. Leveraging the
general framework to copy cmsgs to the user space, we copy zerocopy
notifications to the user upon returning of sendmsgs.

Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>
---
 arch/alpha/include/uapi/asm/socket.h  |  2 +
 arch/mips/include/uapi/asm/socket.h   |  2 +
 arch/parisc/include/uapi/asm/socket.h |  2 +
 arch/sparc/include/uapi/asm/socket.h  |  2 +
 include/linux/socket.h                |  2 +-
 include/uapi/asm-generic/socket.h     |  2 +
 include/uapi/linux/socket.h           | 23 +++++++++
 net/core/sock.c                       | 72 +++++++++++++++++++++++++--
 8 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
index e94f621903fe..7c32d9dbe47f 100644
--- a/arch/alpha/include/uapi/asm/socket.h
+++ b/arch/alpha/include/uapi/asm/socket.h
@@ -140,6 +140,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION	78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi/asm/socket.h
index 60ebaed28a4c..3f7fade998cb 100644
--- a/arch/mips/include/uapi/asm/socket.h
+++ b/arch/mips/include/uapi/asm/socket.h
@@ -151,6 +151,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION	78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/uapi/asm/socket.h
index be264c2b1a11..77f5bee0fdc9 100644
--- a/arch/parisc/include/uapi/asm/socket.h
+++ b/arch/parisc/include/uapi/asm/socket.h
@@ -132,6 +132,8 @@
 #define SO_PASSPIDFD		0x404A
 #define SO_PEERPIDFD		0x404B
 
+#define SCM_ZC_NOTIFICATION	0x404C
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64
diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/uapi/asm/socket.h
index 682da3714686..eb44fc515b45 100644
--- a/arch/sparc/include/uapi/asm/socket.h
+++ b/arch/sparc/include/uapi/asm/socket.h
@@ -133,6 +133,8 @@
 #define SO_PASSPIDFD             0x0055
 #define SO_PEERPIDFD             0x0056
 
+#define SCM_ZC_NOTIFICATION      0x0057
+
 #if !defined(__KERNEL__)
 
 
diff --git a/include/linux/socket.h b/include/linux/socket.h
index 40173c919d0f..71e3c6ebfed5 100644
--- a/include/linux/socket.h
+++ b/include/linux/socket.h
@@ -171,7 +171,7 @@ static inline struct cmsghdr * cmsg_nxthdr (struct msghdr *__msg, struct cmsghdr
 
 static inline bool cmsg_copy_to_user(struct cmsghdr *__cmsg)
 {
-	return 0;
+	return __cmsg->cmsg_type == SCM_ZC_NOTIFICATION;
 }
 
 static inline size_t msg_data_left(struct msghdr *msg)
diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic/socket.h
index 8ce8a39a1e5f..02e9159c7944 100644
--- a/include/uapi/asm-generic/socket.h
+++ b/include/uapi/asm-generic/socket.h
@@ -135,6 +135,8 @@
 #define SO_PASSPIDFD		76
 #define SO_PEERPIDFD		77
 
+#define SCM_ZC_NOTIFICATION	78
+
 #if !defined(__KERNEL__)
 
 #if __BITS_PER_LONG == 64 || (defined(__x86_64__) && defined(__ILP32__))
diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
index d3fcd3b5ec53..b5b5fa9febb1 100644
--- a/include/uapi/linux/socket.h
+++ b/include/uapi/linux/socket.h
@@ -2,6 +2,8 @@
 #ifndef _UAPI_LINUX_SOCKET_H
 #define _UAPI_LINUX_SOCKET_H
 
+#include <linux/types.h>
+
 /*
  * Desired design of maximum size and alignment (see RFC2553)
  */
@@ -35,4 +37,25 @@ struct __kernel_sockaddr_storage {
 #define SOCK_TXREHASH_DISABLED	0
 #define SOCK_TXREHASH_ENABLED	1
 
+#define ZC_NOTIFICATION_MAX	16
+
+/*
+ * A zc_info_elem represents a completion notification for sendmsgs in range
+ * lo to high, zerocopy represents whether the underlying transmission is
+ * zerocopy or not.
+ */
+struct zc_info_elem {
+	__u32 lo;
+	__u32 hi;
+	__u8 zerocopy;
+};
+
+/*
+ * zc_info is the struct used for the SCM_ZC_NOTIFICATION control message.
+ */
+struct zc_info {
+	__u32 size; /* size of the zc_info_elem arr */
+	struct zc_info_elem arr[];
+};
+
 #endif /* _UAPI_LINUX_SOCKET_H */
diff --git a/net/core/sock.c b/net/core/sock.c
index b2cbe753af1d..37b1b12623ee 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1481,10 +1481,12 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EOPNOTSUPP;
 		}
 		if (!ret) {
-			if (val < 0 || val > 1)
+			if (val < 0 || val > 1) {
 				ret = -EINVAL;
-			else
+			} else {
 				sock_valbool_flag(sk, SOCK_ZEROCOPY, valbool);
+				static_branch_enable(&tx_copy_cmsg_to_user_key);
+			}
 		}
 		break;
 
@@ -2826,8 +2828,8 @@ struct sk_buff *sock_alloc_send_pskb(struct sock *sk, unsigned long header_len,
 }
 EXPORT_SYMBOL(sock_alloc_send_pskb);
 
-int __sock_cmsg_send(struct sock *sk, struct msghdr *msg __always_unused,
-		     struct cmsghdr *cmsg, struct sockcm_cookie *sockc)
+int __sock_cmsg_send(struct sock *sk, struct msghdr *msg, struct cmsghdr *cmsg,
+		     struct sockcm_cookie *sockc)
 {
 	u32 tsflags;
 
@@ -2863,6 +2865,68 @@ int __sock_cmsg_send(struct sock *sk, struct msghdr *msg __always_unused,
 	case SCM_RIGHTS:
 	case SCM_CREDENTIALS:
 		break;
+	case SCM_ZC_NOTIFICATION: {
+		struct zc_info *zc = CMSG_DATA(cmsg);
+		struct sk_buff_head *q, local_q;
+		int cmsg_data_len, i = 0;
+		unsigned long flags;
+		struct sk_buff *skb;
+
+		if (!sock_flag(sk, SOCK_ZEROCOPY) || sk->sk_family == PF_RDS)
+			return -EINVAL;
+
+		cmsg_data_len = cmsg->cmsg_len - sizeof(struct cmsghdr);
+		if (cmsg_data_len < sizeof(struct zc_info))
+			return -EINVAL;
+
+		if (zc->size > ZC_NOTIFICATION_MAX ||
+		    (cmsg_data_len - sizeof(struct zc_info)) !=
+		    (zc->size * sizeof(struct zc_info_elem)))
+			return -EINVAL;
+
+		q = &sk->sk_error_queue;
+		skb_queue_head_init(&local_q);
+
+		/* Get zerocopy error messages from sk_error_queue, and add them
+		 * to a local queue for later processing. This minimizes the
+		 * code while the spinlock is held and irq is disabled.
+		 */
+		spin_lock_irqsave(&q->lock, flags);
+		skb = skb_peek(q);
+		while (skb && i < zc->size) {
+			struct sk_buff *skb_next = skb_peek_next(skb, q);
+			struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
+
+			if (serr->ee.ee_errno != 0 ||
+			    serr->ee.ee_origin != SO_EE_ORIGIN_ZEROCOPY) {
+				skb = skb_next;
+				continue;
+			}
+
+			__skb_unlink(skb, q);
+			__skb_queue_tail(&local_q, skb);
+			skb = skb_next;
+			i++;
+		}
+		spin_unlock_irqrestore(&q->lock, flags);
+
+		i = 0;
+		while ((skb = skb_peek(&local_q)) != NULL) {
+			struct sock_exterr_skb *serr = SKB_EXT_ERR(skb);
+
+			zc->arr[i].hi = serr->ee.ee_data;
+			zc->arr[i].lo = serr->ee.ee_info;
+			zc->arr[i].zerocopy = !(serr->ee.ee_code
+						& SO_EE_CODE_ZEROCOPY_COPIED);
+			__skb_unlink(skb, &local_q);
+			consume_skb(skb);
+			i++;
+		}
+
+		zc->size = i;
+		msg->msg_control_copy_to_user = true;
+		break;
+	}
 	default:
 		return -EINVAL;
 	}
-- 
2.20.1


