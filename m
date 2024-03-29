Return-Path: <linux-kselftest+bounces-6816-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD478890F89
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92501C2916C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2091241C84;
	Fri, 29 Mar 2024 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="bVr+NXkv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B8742073;
	Fri, 29 Mar 2024 00:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671867; cv=none; b=Pmu+YDVGDZOPbXN5IJmS/LpEAOeXbXHVF9xOI8Zd90Vxr7cBya7yPV/JmjIwQcrUfHoZwRSAbR8tElAxXUoEgeFOnOXgsl96TiTn+tzninR4Ve3DR6+sKizxCw5Gdm1BXEcGWy53P/1xGQ78SAJpxKgd/zVRXtyFiRhCk/p7gzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671867; c=relaxed/simple;
	bh=UN9Nfe2JCeuY40Ye1bxTcEPn0D03/ofONdhjgUU8g/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9J4NHebrsuO04tXnSd9SzDUUysn4RnPRjt69FuuA7rInmvyB0nOZnNMLqnjSVxFaii7Djoufu9wjwImRgjjUybb5p9OmoROviH5ZEplm0mLhmCOUxBwOjcIAt3k8OutsLBlIr9wn57eape1yOK7PxVaTKyP6uN6Nxqlj13X+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=bVr+NXkv; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=xoCW3VfT0NsdMSW0YV9u0WiyZ8B+glBSEOsX8z5MC4I=; b=bVr+NXkv6ulPYz/XUe44hbmsG7
	PdHQxsxOnEtWWTYILtoFs8tDrW8SRt7Jrd2ENa2TVhuQPLJxJ1s8LTX+092yAgG0wmkH7yA+nKA3P
	Q8r2JIh8U0kj2DslR1AqkTzv+S9mhXmsaRQOA2YlM9YFyqNVeRJpGriPAKwqIATKCT9UDHFlXHMW2
	2+936uWKyVJ3NlIMzZfWiTIL2Xa5m1rJWuS4OvRVZKEYTG+LelVpyRXNOSH5k1prJHShN8OBDq+JD
	yFQxbu/DAIWPxiRktp7ogDpGzPpBo8+/DoqcNeqXzMvMoST7PzO21Hx6nGX+IAAcWzz69wM/QBS+T
	v8gkfc4A==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlO-000iik-0C;
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
Subject: [PATCH v3 13/30] ntsync: Introduce NTSYNC_IOC_SEM_READ.
Date: Thu, 28 Mar 2024 19:06:04 -0500
Message-ID: <20240329000621.148791-14-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQuerySemaphore().

This returns the current count and maximum count of the semaphore.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 21 +++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index adba4657bf26..961e8d241602 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -532,6 +532,25 @@ static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
 	return 0;
 }
 
+static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
+{
+	struct ntsync_sem_args __user *user_args = argp;
+	struct ntsync_sem_args args;
+
+	if (sem->type != NTSYNC_TYPE_SEM)
+		return -EINVAL;
+
+	args.sem = 0;
+	spin_lock(&sem->lock);
+	args.count = sem->u.sem.count;
+	args.max = sem->u.sem.max;
+	spin_unlock(&sem->lock);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -551,6 +570,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_SEM_READ:
+		return ntsync_sem_read(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 57721f5d31ba..e298400bf25a 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -55,5 +55,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
+#define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 
 #endif
-- 
2.43.0


