Return-Path: <linux-kselftest+bounces-6802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E029E890F4E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9644A1F23DFF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D26249E4;
	Fri, 29 Mar 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="VNGddvTb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C342D607;
	Fri, 29 Mar 2024 00:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671828; cv=none; b=Eqxf25Ugb4tokBQ6ZB7nF0CiBfC7m7LSJbPfI2KFoc9MNVQbWcoKBhGyK5FFNBFbuCjH3qfTsXL1qivaAjLmnR1FGsTSdF6pJBiUlvbANT6lAwyOHHKYOdxMxqSrscnVF5nRWYa6Qk+UVsgIEW7I+/9HuPuocXw/FE0UKihdjfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671828; c=relaxed/simple;
	bh=c+LLrvBoCuPfC4CclqS/TQ4HIIJMP43vsE7lYq1LxX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMHSTc1mAi+DGwJ9gHZRY3BekC3YR9cqfowOgFTTA0tcGgH+irrTUDLc/i0dmr1gBK/f64Jopo4FtU8OtYin4V3QRe2SpcsOOzYuuLkAscSPh8yoEV+8QTYRxeZchhB0W4jfCJ87wpxLFCqgK9pN61fylbZs7Jtt3t8dREWbKMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=VNGddvTb; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=JMqQ+0LCTlI6uyQYIwA0XTuobJBuM0j6P3qXqvgCk9c=; b=VNGddvTbuRKa8ippqtioxqA1Q7
	qTov5UjGUx7jEE7mg8111Fwme3cIcIidH5TaRLrPiPJBeOOkyUX83H10Gu595W639yzegPhqIL11H
	hONnZhEDSSA+TueBNmGgkJcQ1t/lGJ3PKC1DTWXfNkLTHytzKiubun4nI3+kD/jGpY5xARwG9syAw
	vMrtYoK3isYymUAZcWZLAYdt2dWIFlVqdztXdaRqrz21AVVbwjChvSN9Z9VblaRrLqycrjaR6Rmxx
	10V13ddC+cEL2IauQY8WDbZ8q810uMZ8VdHXi8fO6oVM8wbjHRs/SUeWNVLXPttZKLL8OnGFZ2dsN
	7y5xN2Dg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlN-000iik-1r;
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
Subject: [PATCH v3 10/30] ntsync: Introduce NTSYNC_IOC_EVENT_SET.
Date: Thu, 28 Mar 2024 19:06:01 -0500
Message-ID: <20240329000621.148791-11-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtSetEvent().

This sets the event to the signaled state, and returns its previous state.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 3e125c805c00..69f359241cf6 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -473,6 +473,41 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_device *dev = event->dev;
+	__u32 prev_state;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	if (atomic_read(&event->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&event->lock, &dev->wait_all_lock);
+
+		prev_state = event->u.event.signaled;
+		event->u.event.signaled = true;
+		try_wake_all_obj(dev, event);
+		try_wake_any_event(event);
+
+		spin_unlock(&event->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&event->lock);
+
+		prev_state = event->u.event.signaled;
+		event->u.event.signaled = true;
+		try_wake_any_event(event);
+
+		spin_unlock(&event->lock);
+	}
+
+	if (put_user(prev_state, (__u32 __user *)argp))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -496,6 +531,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_EVENT_SET:
+		return ntsync_event_set(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 0d133f2eaf0b..65329d15a472 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -52,5 +52,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
+#define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 
 #endif
-- 
2.43.0


