Return-Path: <linux-kselftest+bounces-10391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C3C8C9636
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03FB81F204C3
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF71373509;
	Sun, 19 May 2024 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="TCuZIzEy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A94D9E8;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150317; cv=none; b=BtKz5ftharH8IWCDqsGwXNIgXQOby048M96zZ7Y9svLMNhvdUEyq+lcktlCdAvCE9n0XcQTxgnBi3zeKhaX7PheV0PCwVhgZUhhv6Fobz3OgLwmNJDYG2Nd+wElTxrVCSzJfd6lBwndO6DxrTqoiAVjeS22Agnyiuf7tOtLgCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150317; c=relaxed/simple;
	bh=JPwpOPm0N9ZgjW13Ej2at6+3IKaszLDWcChcGhTd/AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy4XZjGdq2ue8SUMs4v3pSs8/gf3rGIWlfG0A68Bo+wAFH//RJDWgFT1P7JDtrEIJpQS5Pc2KvI9vZKc0IW9cYgM6dt+Lv44qwGKCaTFKo2pSYRUcMeM++SDDiizQR25BsxoU70DuawmXKjbrdgX/gVH13tYHsvalEYHG7MTuUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=TCuZIzEy; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=pL6Tm6skS7blT8ASXZCJbM/G11ZABjcrsi4h3uCYUDs=; b=TCuZIzEyY6Inx8fJfGoY0fLzif
	vH4r3Tn/3RcEvV0fYPReUkW9BRj5/FgdzDuKMUiI24ZxB5W+ZhvB9wX6YFja22SzACI/0jKMgFzDs
	NO7RlqAB5a6NV66QA/aNPAAu2pNzaOgCY5wfOqHobSM4EmwF4xelJnIlnOAfU+FP5f6GL8gdircZx
	WmsT70btUZsjLYtsCJplvxG/Xct1Cm4/frFVGAs9oKpAigdX6cbqQtIehQNUtlbFPbbY5X10nqWYz
	WbZRdgumYu7jkK25jBJUPL/9vF4LcZ5L4IQXtnhPdR7bEhmfVS4tQ4OU8EYxIAWpb5j4KVPe6x8Bf
	Kv7uuIDg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5c-008wIn-0O;
	Sun, 19 May 2024 15:25:04 -0500
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
Subject: [PATCH v5 07/28] ntsync: Introduce NTSYNC_IOC_EVENT_SET.
Date: Sun, 19 May 2024 15:24:33 -0500
Message-ID: <20240519202454.1192826-8-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtSetEvent().

This sets the event to the signaled state, and returns its previous state.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 27 +++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 2bce03187c17..97d9b6047fbe 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -534,6 +534,31 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_device *dev = event->dev;
+	__u32 prev_state;
+	bool all;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	all = ntsync_lock_obj(dev, event);
+
+	prev_state = event->u.event.signaled;
+	event->u.event.signaled = true;
+	if (all)
+		try_wake_all_obj(dev, event);
+	try_wake_any_event(event);
+
+	ntsync_unlock_obj(dev, event, all);
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
@@ -557,6 +582,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_EVENT_SET:
+		return ntsync_event_set(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 4c0c4271c7de..36d903521bbe 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -51,5 +51,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
+#define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 
 #endif
-- 
2.43.0


