Return-Path: <linux-kselftest+bounces-4961-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B0985AEC6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DBF1F23C45
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C43358208;
	Mon, 19 Feb 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="hzGcbG7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D6E55E60;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382381; cv=none; b=ZsX4SUC1FUXKmURhjNJZkiEDFaY+xCdB1tkU7eODs1OgqWYuIGgmO4Q8l7j/xhNUbqci1lyABCwCq0k9wY75HazkpRgEhLxxYf5Jgt3GbePqtM3Cd+8K2ok9295iDBdCmSsLBszRUay7E2CAF1dQyCJ6C/eWVmEYHPVLlvw9AbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382381; c=relaxed/simple;
	bh=I8ziftNmVebQ4+7/x6/7j/jlpEI+Ceu8QdugfllIwJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJHF5k2i+EBX07XtrdCj9pPuhO7j8HHe6F6zMNtsf813JI5wFZ0v9m2STvvLIdi5sJSdZy/+tk9AZEHPz/5pxqz6v9BqG+k5dRov6hpaUBaDBrBqBKwUcSnXKiFbsie5MBPbuHfWJrkqK+fjNhlyyJmYbTRW5RYf64Lka6Y31z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=hzGcbG7d; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=glfLDRv/3XY37fbznHkzZJx66tLy2zaGV1ONv1JLlIM=; b=hzGcbG7d3pobkx+DNgudLBeoMK
	ZvG20YoYVQZTQlBAWpuB4T63xM6di+SPMeejeRv0X5La8BhpYvY1LGYkIYED+fSorRE4pwYPXld5f
	Io9BhWav2eEtZsxMPG2cJVoJAHRP/l9ZNv7BpSs4pZyyUs7PcZUZBtaqZwQ/0CHg9rVZQ0rxAgtJP
	k7d9cgJeRez3opDpjJ00vpMZxitnTVRwTRUmpP7gSbLwitgb9WD6PHeDK30W0Bip2SSISUvwFoq8K
	qP/4oveBwbvlM+c2G81RRN9w0HB3Na1FzRQBZ9yvVmE95IqIpXRtbJX2zOs/3w5JNPTZqe0avRMox
	itdK6jWQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIM-0037Oz-2B;
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
Subject: [PATCH v2 11/31] ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
Date: Mon, 19 Feb 2024 16:38:13 -0600
Message-ID: <20240219223833.95710-12-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtResetEvent().

This sets the event to the unsignaled state, and returns its previous state.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 22 ++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index edfbf11cafe0..fa4c3fa1e496 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -504,6 +504,26 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 	return 0;
 }
 
+static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
+{
+	__u32 prev_state;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	spin_lock(&event->lock);
+
+	prev_state = event->u.event.signaled;
+	event->u.event.signaled = false;
+
+	spin_unlock(&event->lock);
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
@@ -529,6 +549,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_kill(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp);
+	case NTSYNC_IOC_EVENT_RESET:
+		return ntsync_event_reset(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index af518530bffd..6963356ee3f7 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -49,5 +49,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
+#define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 
 #endif
-- 
2.43.0


