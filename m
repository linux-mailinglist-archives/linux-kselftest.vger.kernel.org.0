Return-Path: <linux-kselftest+bounces-3813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D80843396
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6C2AB2187C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEE838DCD;
	Wed, 31 Jan 2024 02:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="cGd8qBhZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9673B5684;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667370; cv=none; b=dNSWOSW9+NSGAG0lHvJTbBGTyuLbQWCmY48BWRnwQQLw6CnL/JmJRQQ1s8yM12+xsX5JfesgBQP/xkJ37eGBMnRzMgQHUBCwzAWKSsPoy7rQg+Hb/iJQ0rSHtXt0fIExpA+CUN1GMQXDmRxKro+JtatNmjd0l/DnxGLVqfwxOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667370; c=relaxed/simple;
	bh=hMJdmUKFkzno0ji8YpHS/pTDnN+SSVTCS/COoDL60fA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0DQoUu4ONfr246CUyFXllTJt55e4jHG+a8Iv8p38D9NlZTEJlVEuRrjacjOyj/J04xW3e47bszp9TO3GbpK6y1/g8Si4Ooj9xzZeBNNhAPVhFqOgtVmCmCTsRyrYmtNZGuCnl7Eivq6ZnbzFKdxBItTCj7Bs4aW9JuydjdPODU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=cGd8qBhZ; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=WRk28nnebpEDG8oEow/kRhN8Lt9f1MHcVAwX3iEhD18=; b=cGd8qBhZDagdmZQ+X2glRs5nfU
	Q5ih2Dm2wM0UtHrDeoXrMVb7Xwsv941ueKGPsMxFzgLUTFBnQHqALtbJDFZJJZAS8dikbRTQIvNj+
	zHgd68xeIF8AF9Fke5W8wjGsVf84dCqgFTmRA5k3pm/pJWqeONOi+yQp1vHZheaKDcPTa5WOwCYrb
	7FCOFONgURxnnIVkgmHPiTTZR7Xp5/qON9z19WrFdYp6u7K4kM/3zS+sTBt0/8jujstRe/8K37lci
	EkjToTagxoqBiq0xkJd5vc3iJj5E3IM47k0x0lJE1wZm1VMlPKs3dRbbtrjcT4eb/gwo1dGhQIxME
	jdiLKuHw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08o-0038Kv-0N;
	Tue, 30 Jan 2024 20:15:54 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [RFC PATCH v2 12/29] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Tue, 30 Jan 2024 20:13:39 -0600
Message-ID: <20240131021356.10322-13-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131021356.10322-1-zfigura@codeweavers.com>
References: <20240131021356.10322-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtPulseEvent().

This wakes up any waiters as if the event had been set, but does not set the
event, instead resetting it if it had been signalled. Thus, for a manual-reset
event, all waiters are woken, whereas for an auto-reset event, at most one
waiter is woken.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 10 ++++++++--
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 009d927739b8..240ae858fa96 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -447,7 +447,7 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
-static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp, bool pulse)
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
@@ -463,6 +463,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		event->u.event.signaled = true;
 		try_wake_all_obj(dev, event);
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 		spin_unlock(&dev->wait_all_lock);
@@ -472,6 +474,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		prev_state = event->u.event.signaled;
 		event->u.event.signaled = true;
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 	}
@@ -526,9 +530,11 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
-		return ntsync_event_set(obj, argp);
+		return ntsync_event_set(obj, argp, false);
 	case NTSYNC_IOC_EVENT_RESET:
 		return ntsync_event_reset(obj, argp);
+	case NTSYNC_IOC_EVENT_PULSE:
+		return ntsync_event_set(obj, argp, true);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index f2d7507d8438..598f894f868d 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -50,5 +50,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
+#define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 
 #endif
-- 
2.43.0


