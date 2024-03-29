Return-Path: <linux-kselftest+bounces-6815-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 496D1890F87
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEA1BB249BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2EEE42044;
	Fri, 29 Mar 2024 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="orugvxFr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6D040BEF;
	Fri, 29 Mar 2024 00:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671864; cv=none; b=WZpaMorRzBhiZTutpRFMLtFOBZWLU1NIYhhXmGAVRm/6hiIHYU59z0F/VCiiEu37xodsBaNUccR4mDJgh8e9pkKN9fDJfhlCzIV4jlazxapryvjwJRZIwZpDvwVITgkdYrvHBJfCkr66n6vc385kySD40ncwL6W7YWBgTJ0Juvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671864; c=relaxed/simple;
	bh=bmx/mjxmP+wxiumn+/Tiz1HBWW1Q3cStxbW7MoSrITg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1veZI4w5m8jE+JZvVvEYOzoLIzMLmR+WXLRy3uDzpJvKRnx6DQyVXE0wgBcPY0Vh3S3tOtwUkB5Zb3SwUUCVdIQ9uoR4G3XWFtuoW36UXAe9fZG74mjyzC5YDuNBVKJ8VPtPJtebOiAIEFDfCA166OsshHC5XnRqN+AUvHwiaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=orugvxFr; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=heeemJvwrhCJxAnq8AGmVdPeOZmh1g4TMNOtT+KYUp0=; b=orugvxFr4TkS8mdOIjQ2g4EU2y
	uKvSt5qj/1o48KE1CsL81gxA648y9dgb9fAHm9CVTzlbaLfN3lXckHC7C9VRBgOcRAWx8yyVseTMc
	eMNbJqsundhGIDakxv2IdaNSzI0xElypXbw9VT4bdH0OtNusJ961SLinzS//moiFpaDWRj5xkn5fj
	8PJb2xzjfrfZM8J5Ax2oe7XUjhVgldK5apamAvDP+9E3vws8ohvwmV9SEsu509NTabFA4Ph5ygDkd
	O8PHjnVkiYHgiNyTpatCimWaJPxBeI4Vc0/RHFC+wHUspyqgx6vOEjPBrFUfhoHOpo4+ptk6V2ITj
	rDjoPuuA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlO-000iik-0h;
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
Subject: [PATCH v3 14/30] ntsync: Introduce NTSYNC_IOC_MUTEX_READ.
Date: Thu, 28 Mar 2024 19:06:05 -0500
Message-ID: <20240329000621.148791-15-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQueryMutant().

This returns the recursion count, owner, and abandoned state of the mutex.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 23 +++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 961e8d241602..bd043dccc9fa 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -551,6 +551,27 @@ static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
 	return 0;
 }
 
+static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_mutex_args args;
+	int ret;
+
+	if (mutex->type != NTSYNC_TYPE_MUTEX)
+		return -EINVAL;
+
+	args.mutex = 0;
+	spin_lock(&mutex->lock);
+	args.count = mutex->u.mutex.count;
+	args.owner = mutex->u.mutex.owner;
+	ret = mutex->u.mutex.ownerdead ? -EOWNERDEAD : 0;
+	spin_unlock(&mutex->lock);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -576,6 +597,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_MUTEX_READ:
+		return ntsync_mutex_read(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp, false);
 	case NTSYNC_IOC_EVENT_RESET:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index e298400bf25a..797e8df10a3a 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -56,5 +56,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
+#define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


