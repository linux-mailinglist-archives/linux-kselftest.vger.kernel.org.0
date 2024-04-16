Return-Path: <linux-kselftest+bounces-8043-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD748A5F9E
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D41E1F217B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF48F5A;
	Tue, 16 Apr 2024 01:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ebhd41BF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B165D4C98;
	Tue, 16 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229830; cv=none; b=sjJBZ7AGmxURuci1CjRrqIupLaUPiF34u9Mo9xJ8pQj92vwxp84sRSByZD13DJQd9iUApZzgrKWHYX26hsbofunCRoq/FuH0KeZeOcyZuhMdTlEum5XWhdAJwYsUCiCVOcemM/JKXTfcNy9GumVPDjPuJ6F2Ec/PXwkXSggtWSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229830; c=relaxed/simple;
	bh=kZr4HBZT8xR7smvBRwRPi+gHQeVpDhR6SAAtaJhyuDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mgrn4iD2zKp+LxCbQFXUE5YPtjJEdt3oKOV1vUYhM9q+JW8HvZGSoQWV0h7j0QsJC6L6UH4WULqVHY8fw0qcplw8/i8ouLG+0ZyFVyxJKswvMnDgFNS7DMUZq2Tfd1bcz1mmdsMPG4yLg/MuYNBGAQS6hk+cZnDuiFi8t8Mx+18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ebhd41BF; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Dqvt4R2zo6YXU5BiQKahqTvL9Mp5x1vDJQ1/oaltxP8=; b=ebhd41BFE4X+6ld3nf3OmRqxsd
	GKn23Y+w2ftPJf6d4VZo3UCaSBYIko3ahRpKVitTkxazQSoehdY8aojXEW3Jj79OTovc51y7AUcsF
	fzZMrhz5RycfN6sJ0pVyjuidk0XhTfwL9c0KrzpF4nGKOAvqNqsl2cDeiU9w1Ima8j7tXVVtBQ9Hz
	V66q1FPhm/HEoZAcKL1yjcMRipTC8+/62ZgGxvyEwKxLVEZZ3lQzBzAWJEBBJt5G/X/xVEd6fqIjF
	PfPWTX/NXkXEQc3+LJ3KreksvkFwmNgremiKt0bG7ZRpZeSIyJfOjGRkLtALsM7fYI3sLbgO0NW8D
	NWw66RXQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL0-00FbQv-2k;
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
Subject: [PATCH v4 12/27] ntsync: Introduce NTSYNC_IOC_EVENT_READ.
Date: Mon, 15 Apr 2024 20:08:22 -0500
Message-ID: <20240416010837.333694-13-zfigura@codeweavers.com>
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


