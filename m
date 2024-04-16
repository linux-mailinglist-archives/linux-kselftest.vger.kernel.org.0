Return-Path: <linux-kselftest+bounces-8059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146928A5FD2
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18F528336D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A4322F1E;
	Tue, 16 Apr 2024 01:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="NnUpG/0f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0976AC2;
	Tue, 16 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229832; cv=none; b=TfgJxp4glqo+qXzo83CEVdHVyqAglzO6QjWrG84a2HN0FPSrRcJslFUscCXuh1uuerbW9AhHrtR1jcxJv71cMbRplhTF3AQCMGHnQVv3kAu2tx0gjfqMvkpuuhh9+wURFriBIykApHc7kCjBe4LukroXMMRgPQX/7dQIz2rpBTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229832; c=relaxed/simple;
	bh=c+LLrvBoCuPfC4CclqS/TQ4HIIJMP43vsE7lYq1LxX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpHaxGh+kGauSoY/f24ZCAtlEzEM4cHN20ggkCSz8O+hjNJkk62aruT+NNmK+NQIDarrAoybYVcEIFODcLHwmrovd9vpBDwRaohr4sSIvkUxDhID220wVOeLEI9t0IFj/zsmr+Rpsb5GCdAfPRUxZOyUi6RzE9+RXYoFgfgiycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=NnUpG/0f; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=JMqQ+0LCTlI6uyQYIwA0XTuobJBuM0j6P3qXqvgCk9c=; b=NnUpG/0fLKDcjGxOL5VGKlqWps
	2Q6i4CkWE8imrbZt95QfIye1NvdHugB/jv5dNhvOiKFLZue1DT3mVtG9lYeuuL0noJiJEggRJC7aY
	Y5KeICnYWVIbtz4lUL0BjzpKiMK27PYSzKJG6cYiCsEYMrtZW7Rd2dMnjcDT3DKqzktnyM0GyO4O6
	Ge7wi0ic90zseCCY+5MvZCW1Wkn+DnHzXfTDq/TeYpaWhxzu4qKNvovLKi0jMCdoqbA+vlRnv3bcS
	EaF2oFk+DebKD7bCyBtqrwS5IwWqB+25M8H3fCtwTZZ7tPBwLm/0dl1Bv1HQ+ydKBop1lyNx02KgF
	RCHx0F9Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL0-00FbQv-0G;
	Mon, 15 Apr 2024 20:10:18 -0500
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
Subject: [PATCH v4 07/27] ntsync: Introduce NTSYNC_IOC_EVENT_SET.
Date: Mon, 15 Apr 2024 20:08:17 -0500
Message-ID: <20240416010837.333694-8-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
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


