Return-Path: <linux-kselftest+bounces-10385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AEA8C9623
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DECBD1C20845
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBAE6F06F;
	Sun, 19 May 2024 20:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="YSZZSg8Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A1850241;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150316; cv=none; b=JarNI089KMf2ry1I37D7neLRF+NguPkxr3X5FI8dOxm3DO2J4qU5Ms6IyYQCfQhN0orb7/WdTNqxr7fxpI2OqRE9zQiN3FFYXmKLyB7zpqNWUCNJnnw6R2GlV9gm/M2jgZ81/Z7aazFCgxEgkurje6ucEUyYdlA7m0Qfhk/esHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150316; c=relaxed/simple;
	bh=XbjtbEE6y+QkCwnZQcjxEYutHqA57QPfgn6+mSDQKvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHHs9VARRMeEW0FdosXtmXnEOoYbtGRjp6s82AWZ5BhW03t1HSgtV1m7MkZOA0NqZs+1v8Yx+t2ItiLuCENcsnUeSO/KAptGBm+8hPvtQMvqS6ECqW91n29H7xxeJcVxqD9DBz/aqSG5E5rpoFCusOGkwrHpPsgBWbIEx5+7wes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=YSZZSg8Q; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=rdMijym+G5sdTUVMU3W8p4D7kqVB/VBKMuu3j157kus=; b=YSZZSg8QPAazFVZ/fqCZhf/zyB
	iTkKB7v72+I/GfJvYfIXLcjNr4H192NDRr7iQsi+wT6QwcIueun/RRsXdAcuMlpvT0FYTGzpibpN9
	i+w3UOsYVSWsK/Uzlu44kGXBLyiUFFC4VuqOgDhAUbdvaY3PGOTVVBd0kHAW1cZ5AsMIaGyAGcJJz
	EMeREFCxFiAonzpZW1WCk82F+/aCi7XOwbj/j84eBxh2Fbozp0mpzdobRP8syk942nia+1fEE8kES
	aqeWyPNY6PxS6qSGwiQwKQEU9ae+tbp3HdQ/NyvFL5E5cQ1ipT/88Nhi4/z+ThUq4dFT4s6zqxSBK
	4fDziHCA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5d-008wIn-14;
	Sun, 19 May 2024 15:25:05 -0500
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
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v5 12/28] ntsync: Introduce NTSYNC_IOC_EVENT_READ.
Date: Sun, 19 May 2024 15:24:38 -0500
Message-ID: <20240519202454.1192826-13-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtQueryEvent().

This returns the signaled state of the event and whether it is manual-reset.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 26 ++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 622be0075ba4..a11fe2469841 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -633,6 +633,30 @@ static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+static int ntsync_event_read(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_event_args __user *user_args = argp;
+	struct ntsync_device *dev = event->dev;
+	struct ntsync_event_args args;
+	bool all;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	args.event = 0;
+
+	all = ntsync_lock_obj(dev, event);
+
+	args.manual = event->u.event.manual;
+	args.signaled = event->u.event.signaled;
+
+	ntsync_unlock_obj(dev, event, all);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -666,6 +690,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_event_reset(obj, argp);
 	case NTSYNC_IOC_EVENT_PULSE:
 		return ntsync_event_set(obj, argp, true);
+	case NTSYNC_IOC_EVENT_READ:
+		return ntsync_event_read(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index eced73d08783..74abeba832f7 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -56,5 +56,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 #define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
+#define NTSYNC_IOC_EVENT_READ		_IOR ('N', 0x8d, struct ntsync_event_args)
 
 #endif
-- 
2.43.0


