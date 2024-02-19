Return-Path: <linux-kselftest+bounces-4958-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A11AE85AEBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EAFB1F23C7A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D1757339;
	Mon, 19 Feb 2024 22:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="HasNCES3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0301956756;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382380; cv=none; b=klfyJ8JM59A/moW+WDLkw6qSpIlHsh+JTb1Rq5C2nSWoUPJSILXD4zqxU/xwbTuqhnBziRB5VS/FjZQVlSINDd2gBWti9a09Rd/uCEPJolnWRES7+s43krv/CDeBEvm9CQKrgAEjlttMIdbk9H82GG0aBa8QbxGu/mT9Rzx5jq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382380; c=relaxed/simple;
	bh=JQFvbdQ3WTwEsVrsFXyNcm8fJYqqIYVgs75ah6Rl1uA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0X+UDORKdy4yvTn/jylME6G2i4H5sp5M2Q4W8brMnS8TkenNeFgvj2VPs6hhf/q+jM3DfkRmiZjkTB/11PVPpobIFSnmaRjsLDvZPsO9EXGF/Q3S4dFBswKxItlejivcKZAA1JnbwK9IcTl51q/fq+8BnLayXL/I7Gn/kl8ijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=HasNCES3; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=BFNtqlFDBUjcBXNMOPIpSEYmwboigNzB4lierY0STj4=; b=HasNCES3vI0in8Dy94cKwdwJYV
	TgK9YAwmpfSCLe9K1qjKWkYErCEP5mCD8AgMT6YpPlCs1iTmwHooCVS5Q7OVkITocw8TGKoemBg3/
	atT4gaxiM8VldC6BoqWB5D15t3seHbhuL7MqKCpU0YJBxs+4P45AaZ7MIlC+B9nVlXNpbEY/+n5dZ
	HAq//ArfX1nXEkoOvm2ayo61RxCUbxrIIov1+bwbJ1KLJiH/2l8tUW5FKCWdMhJ9iLV02MjLJmeaZ
	b1BKWwy2NeGeM3LJyGnjPYd6AKlf+2rDsgqd5x7GCNLPLbGqMJ6h6qF9F+eNGdnTHo6zXcztpTelo
	Qj4VBMEg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIM-0037Oz-2h;
	Mon, 19 Feb 2024 16:39:30 -0600
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
	Randy Dunlap <rdunlap@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v2 12/31] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Mon, 19 Feb 2024 16:38:14 -0600
Message-ID: <20240219223833.95710-13-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
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
index fa4c3fa1e496..b9b4127a6c9f 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -469,7 +469,7 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
-static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp, bool pulse)
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
@@ -485,6 +485,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		event->u.event.signaled = true;
 		try_wake_all_obj(dev, event);
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 		spin_unlock(&dev->wait_all_lock);
@@ -494,6 +496,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		prev_state = event->u.event.signaled;
 		event->u.event.signaled = true;
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 	}
@@ -548,9 +552,11 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
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
index 6963356ee3f7..72047f36c45d 100644
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


