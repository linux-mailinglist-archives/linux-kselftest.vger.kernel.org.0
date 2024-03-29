Return-Path: <linux-kselftest+bounces-6803-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD14E890F54
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20F65B207E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439CE2C68C;
	Fri, 29 Mar 2024 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ogWE+GQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0854335C7;
	Fri, 29 Mar 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671832; cv=none; b=QBiYY2KTfiETWkpZJvkxyKg5jp6pDuvoPVWIdHLN1RFBVVskW38IZJde5poTgjfkVel3zvZ2MSWF32+UNfzCiMe6HTG2w1l9/Az5jHRm49d99FGP2ytYCc3b/R1eAgyyK9l42JKhNED4aSZzu5xTazLNpN7nnVvMpuY6UFs9CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671832; c=relaxed/simple;
	bh=Qydx+3xcTvNeUCPGX/oOLNK9YJQeyBhE3gI1tli3A40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VSi7W1KvdWKjluL+9CtrOeGYlABatPusg51aFYcxCZlHTy/WLnu+uXQ2rsGHvxnfM8tal/5yaiVj4Zs/GfgtLSrQis7DcFuNvkSnMbPLxjmnAU9M0Rgq5bwzyK9b1l4QGNmigAmBmPCzp29ppxLRsXYhWUzJT/cfAnco1F5WstY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ogWE+GQE; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Zv8h2+szdhg9EDGHBccepteFUUaEkYh+pn7zKQTBoPE=; b=ogWE+GQEMN0HSO0WytKAwiLoaR
	vTt6XEXOg1owF+ezjw3ATMODGPfSfBSWhs5aYBEDdc5qzyv2HYHNc84FC8p6jmjvI81kOzxojPhFC
	4PIqRH8Y03zjJfwzJCc87TR7M0efCOYRyeuxmXvfQATD06re0ydmwv6GiI/1x3gJg0avp+vIj8LMz
	NzM7i1Ug436LT54w1QyaR6EaxTC9bswtzO1iBpuqavZFalxo/BfK1yFdbziP+1MdtgQ0lPoarJNal
	jobeRb9IZbv4QpVIXoyRm+g5Lt7MThokk2hLxOVUsJ0y0cgQEBGNMqJZCenjvI1+wF5NSD9AcN8nm
	NEcGvqPA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlN-000iik-2w;
	Thu, 28 Mar 2024 19:06:29 -0500
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
Subject: [PATCH v3 12/30] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Thu, 28 Mar 2024 19:06:03 -0500
Message-ID: <20240329000621.148791-13-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
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
index ae78425c87d1..adba4657bf26 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -473,7 +473,7 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
-static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp, bool pulse)
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
@@ -489,6 +489,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		event->u.event.signaled = true;
 		try_wake_all_obj(dev, event);
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 		spin_unlock(&dev->wait_all_lock);
@@ -498,6 +500,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		prev_state = event->u.event.signaled;
 		event->u.event.signaled = true;
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 	}
@@ -552,9 +556,11 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
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
index 657542107328..57721f5d31ba 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -54,5 +54,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
+#define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 
 #endif
-- 
2.43.0


