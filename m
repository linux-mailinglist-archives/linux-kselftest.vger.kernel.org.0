Return-Path: <linux-kselftest+bounces-4688-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A88557A9
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371371F21619
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DEBC1474A6;
	Wed, 14 Feb 2024 23:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="rZGFSYLg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB26C1468FD;
	Wed, 14 Feb 2024 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954813; cv=none; b=jZthh6JyxuGC+L6fGwPyhRZOaSD3yQdpOde6wKFcfkUW0pb4dSG6ExbdonzMyiMaig2NKPIeQIpCoNwcsj2BT2HG8AupdcyO1RJul4f+uK99Rlnj+pJPJ9LNGHSuqTB9h5h161g/2MIwlwXEnxaQs5ctgTIPgNxpmEgC1VVz+QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954813; c=relaxed/simple;
	bh=BWsVN5Nd9zC4qkmCZzbH4sC7w+cs5Ze1LqiDpK6tZ0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdXvBi048mKZNHK/5xeQo82BJ6XgPJ4fwX9UN9Ykgqdy2K9dxPNTwMzC97CKYvsFZ9br+OX2bnzecHQmtLwyjMGI5KATbNaPlXgbUvRSnJ+bu6zUKeqoEQE08keHlE0iVQsjKOwolJlxif98WikcTPEsLrW9DnX7NVC/OOr8T8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=rZGFSYLg; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Uw+YvaVU15ffM3A3JgczPQnnrN3QpOwwpO53Okg4P4E=; b=rZGFSYLg4jw4IbY3qq5tAfHU0M
	I8lUpi9v35Z1C0x6h1K/qIfE83vQHpzglujzeV/J9BXQfALYoOkN9JuaVu/NH9FYYhvhgd/9E6BMy
	8+KAsZP12ETBWY4diDpnKaIY0l8EPyflu6I/ODD3kNq8FEAY4cDBXDMgSBUNyaE5EaH6TLCpay1yq
	GW5skFY49cUDu2q72spUKxQd6OOC1U1f49R68P6y+HSAHQj8E5rjwd1AS+U0pjR/qisKN6SppgDba
	gFxXuD5m6w5mUW/Hgx6zy07lx6zGXnRAp7WnBTa7SfDs3+a3iQooq9VA65wG5ARSzv0ptLGJEBeMa
	Torntyrg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP46-00GcSK-1f;
	Wed, 14 Feb 2024 17:53:22 -0600
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
Subject: [PATCH 12/31] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Wed, 14 Feb 2024 17:52:47 -0600
Message-ID: <20240214235307.10494-3-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
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
index 57d78b086241..e8e58274e4e8 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -456,7 +456,7 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
-static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp, bool pulse)
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
@@ -472,6 +472,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		event->u.event.signaled = true;
 		try_wake_all_obj(dev, event);
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 		spin_unlock(&dev->wait_all_lock);
@@ -481,6 +483,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		prev_state = event->u.event.signaled;
 		event->u.event.signaled = true;
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 	}
@@ -535,9 +539,11 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
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


