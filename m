Return-Path: <linux-kselftest+bounces-3801-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3534D843372
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4BA5B21D52
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E3D1863A;
	Wed, 31 Jan 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="lpcSbMyS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683F5695;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667368; cv=none; b=hK578cHLBN6EfK5rHZoKdGCnJc4768hXHMSnqBUSW1F9XzYD5KoUgj+IZRV1dJYljK25jQA/BDs6L0SHGXr1QnxsJJmDhigxJPIhL0SagRQxGjZPFKcmid/5sr1B6sLVP2uVlCHOc9z/pZBYp/RlkFWr3skOfxYMij6CTmGLp5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667368; c=relaxed/simple;
	bh=45PqITAzyzIslRj+cjwBpNV+ix/PAFx0emApGk3uvpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sah1QeBdl0myQ3L+AFrMOjlxrvTjC4IsC6Pvel0ej6Rhf/VqNxy2vc0sS6y4B4CNadhlAZ2Xs2jeYYQz3AELPEEM5HpGYphEGvDtNfwN8d0R72pbND92oIPiYkgqy3pOMb43v6VdNZ48Ro906fPKDCt7bAQt9F3598AILKP9+9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=lpcSbMyS; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=1xZgCEZhzxRQI2+IlVlEkSHYGEMNkBdz9sAcroCJGdM=; b=lpcSbMyScOJWYO4kppnSqPKmGr
	EaO+lS+KIQOmdcVEYpJhRwlbzFSwRvmRefH9Fu4PkQYiSvGYk8YjCnGnZY7Lv17eErv12Cfv90WWd
	hvjuvXbNYFBL/4iwGEDOyzmXQr9J8ueETNyZlebBoNEsjDHbqc6NPYMSh4Gv33j90DxtKMvyq5AvQ
	nodXk6X8k/+5YuU4/eSvBlWEYM7NXP4M3sge2THw9EusP0qE4qWiGdApUAXGvmAQHb1ym++iSfZtC
	CPzeuixY0bvojhKqwahga9gz42e2VJNF9LMAOu5+O13s96SF+CfQlQQ0pLtPsFJXa1z+m57sDXV6F
	0hUjftJg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08o-0038Kv-1J;
	Tue, 30 Jan 2024 20:15:54 -0600
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
Subject: [RFC PATCH v2 14/29] ntsync: Introduce NTSYNC_IOC_MUTEX_READ.
Date: Tue, 30 Jan 2024 20:13:41 -0600
Message-ID: <20240131021356.10322-15-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQueryMutant().

This returns the recursion count, owner, and abandoned state of the mutex.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 23 +++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 24 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 6dccfbfb2512..7f5f96ec7c69 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -525,6 +525,27 @@ static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
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
@@ -550,6 +571,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_MUTEX_READ:
+		return ntsync_mutex_read(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp, false);
 	case NTSYNC_IOC_EVENT_RESET:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 6017f621687e..a1d0ef581212 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -52,5 +52,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
+#define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


