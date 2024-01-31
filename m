Return-Path: <linux-kselftest+bounces-3791-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B880E84334C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7538F289D4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54821EAE4;
	Wed, 31 Jan 2024 02:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="aFCpal0D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962A05663;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667367; cv=none; b=Dtu6w1oNlkoXj5GeoeDbf9fyI7/4a8s71xNH8SOKgmptVm57vNyRRcgiGzBQS7P4lopekNSE8z9j6hHZR4IEAlBt3YmFoI5K1AjZqgoudcAXE9i3/iAHiQYNzLHwJ9NlEwWZcPAlFANizP+QuYvQWzZwWu6AF1OOaP9wpjZ8Scs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667367; c=relaxed/simple;
	bh=H5jdJoivK98burrP8xFN4UKk2ngubL7t2Klv7uTHt/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCInXXZre0KNBwz+5Y8x9QcTILPDUCshcAQ3zbNX6RfgK+vFZmRbOnMIcbfjA3GDNg72jiFqWFXuozQHnFJWJTn0z/pgcqJNRFEKKqxZedNCkvl1rgqV2fKgH4EpUPpkdY3jYkbYRZOIDeEHcqgYSYBbWhAC/j1vWk3sfG/IEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=aFCpal0D; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Sv1UBqSdU6l/6/nEOSf6bUGNGonnKGWUzciaQ82gPQo=; b=aFCpal0DxG3QwuWB7FE2qo+bBU
	VgYKfDLIIoB2SPWPAwTgvMa5xG04P2vtU203k0XbJ+mr48iKZpuFGuEsyPb9Bc8b0qaEbVCeM9dO2
	e7EF1v3hu1z2K5XYQL8Gc/zrh3k79yNRhbZsJZfCDUoVmJemaeiSi07cSx2BCxdjoD3C5xe1YqkHl
	Wldb/7uO9D/91/2e4gxwPbz/UoLt3jb2baXibB7Hk9WYsHwK9TkObELGaGCK1V/Nq53BUJK5n2vZJ
	GYZrsWxvsTYZrGtanAX7ASyt7M8MqRhj5lUiMSpReqs2eJbV9bd59nlI6dQ8XvCgHFL2xDICddmwu
	lfC+vPtA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08n-0038Kv-2f;
	Tue, 30 Jan 2024 20:15:53 -0600
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
Subject: [RFC PATCH v2 10/29] ntsync: Introduce NTSYNC_IOC_EVENT_SET.
Date: Tue, 30 Jan 2024 20:13:37 -0600
Message-ID: <20240131021356.10322-11-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtSetEvent().

This sets the event to the signaled state, and returns its previous state.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index c719ddd9f6d7..b2da50989953 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -447,6 +447,41 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
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
@@ -470,6 +505,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_EVENT_SET:
+		return ntsync_event_set(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index b8cf503365ef..782057552483 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -48,5 +48,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
+#define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 
 #endif
-- 
2.43.0


