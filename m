Return-Path: <linux-kselftest+bounces-6814-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F29EE890F81
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EED1C272E2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1094085F;
	Fri, 29 Mar 2024 00:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="EZmgBC2G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682F33FBBB;
	Fri, 29 Mar 2024 00:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671862; cv=none; b=H8cIEdUU83vYtBGoXaSKA8wYD4zrOzFfkNaJ/FGX/waHRHJooWcQFmsLYlGbawNNWO5E/DboD1A8qcPmZr+UC7lf0/tOBAW6ADlVdhXky0aSM9uc9IBcice5ZMyxYiX9JIPdf6jmjK+CI7wkl4n2XnV+OIu3IvRd2m4BNKQl5U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671862; c=relaxed/simple;
	bh=kZr4HBZT8xR7smvBRwRPi+gHQeVpDhR6SAAtaJhyuDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlkPh2pdtkzWy+i1KqMMZ80NLlApvUYNhdmdsYj0t4D3rP0U7X9bmXc3MPhsz+axr7BFucm0uP2/QDT97Txjks/XJ5vIVGrQKv+0ZBPMjAeRzDRUfm+8bssj0J3NyTi+1dwWcqGiqGnaTD9BQkD7Wkw3hTGJs64nsf5WkEJJl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=EZmgBC2G; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Dqvt4R2zo6YXU5BiQKahqTvL9Mp5x1vDJQ1/oaltxP8=; b=EZmgBC2GTpheVHmPBFhvXlZvbB
	N7evtxCidBrZO2HrEIlhUrJpFqNCMop7gqVh0IiYzuh54UbWLAEVcbabTIUpRRJYQjjFWbUmx/wM+
	HvQCWJitagKRaLWCZBcaNKqInzs80qtTuZJG50FFgJqvuSUEmiH4IWGREC+jpHTeKs+V2WYoLWKx3
	zw6CZitvkpr6m4S6dZEaT884en6IOnGh7rHA/E02Hrxv2PghgYdZe5oZDooDJ4vld48HuyhYyUO5e
	Utm3vV/1f9HWdc7zHGENK1dqm0tUttSZjT+mIy5Zao3oOMcgYOW1Ct4+QgblwMs0R02YxezYyzwec
	T5eXsjuw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlO-000iik-1E;
	Thu, 28 Mar 2024 19:06:30 -0500
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
Subject: [PATCH v3 15/30] ntsync: Introduce NTSYNC_IOC_EVENT_READ.
Date: Thu, 28 Mar 2024 19:06:06 -0500
Message-ID: <20240329000621.148791-16-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQueryEvent().

This returns the signaled state of the event and whether it is manual-reset.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 21 +++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index bd043dccc9fa..a03c6fceb518 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -572,6 +572,25 @@ static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+static int ntsync_event_read(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_event_args __user *user_args = argp;
+	struct ntsync_event_args args;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	args.event = 0;
+	spin_lock(&event->lock);
+	args.manual = event->u.event.manual;
+	args.signaled = event->u.event.signaled;
+	spin_unlock(&event->lock);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -605,6 +624,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_event_reset(obj, argp);
 	case NTSYNC_IOC_EVENT_PULSE:
 		return ntsync_event_set(obj, argp, true);
+	case NTSYNC_IOC_EVENT_READ:
+		return ntsync_event_read(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 797e8df10a3a..80f36de46a75 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -57,5 +57,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 #define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
+#define NTSYNC_IOC_EVENT_READ		_IOR ('N', 0x8d, struct ntsync_event_args)
 
 #endif
-- 
2.43.0


