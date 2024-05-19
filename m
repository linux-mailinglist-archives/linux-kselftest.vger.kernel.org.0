Return-Path: <linux-kselftest+bounces-10396-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C99B08C964E
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E0B20DEA
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEF274E3A;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="NiaODcDz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A795FD2EE;
	Sun, 19 May 2024 20:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150318; cv=none; b=nOie80YtpMW46JvrihZLKMKn5oamtdW+f2H79BFmR48j8nu8GgLw48W6574gXE+U/RW9Akec32RNm/sU2NDIrdwNRtJSoUvE2hiC6lvpCXwyH1k2YPUHowpcX/PnVzvjfCcJnrGREIOIoVEUb0r4oOTdlPEUUK6FheuN6D/wHIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150318; c=relaxed/simple;
	bh=Gd1tpusTbSbI8AbBBLGNjkRaHaUPl9s4W+WpkKEI2/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcsOxX+WS357QuSZlGD3+GV11MIydWKtZ4HGGyHEACMtIfm1IhgjDHgq9U89Bh8TQLNb5W61MQ7YPL/C6PszVBM/EVSxrE/Dd65AuPkadqKMBxFSJCj3vJMLtqlHAhgFv+78jRjBpbj+AkBmR0sVOPaGp4P3YZbZ0CSVjb581FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=NiaODcDz; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=SXcqtGNCLa8ZwRK5oOBNmkOan2B17nwyjfjgs8uki1U=; b=NiaODcDzU8ZWsWB359bWxa1KAl
	HcPRFvAijl1UkMDDqzMtziEsQv330IW4dTu5iBRwWME8MnAa9kF5rSnhUk7HXKKslKEH9r89/rfEM
	KSdEPu5+KFuOUPgKYSO499n5Ajg0w702h6zIKax0//l9Rfetw6J9SJ67XDaiK0lRCrUqo12x87Of/
	NvM6cXXvVhYQ+7VMVX1VUV64y2d7tixd2f3ng4jPnSwsTEQldY7MPUppFP8H47sZejx6eVvznWEAP
	abx3x6TqifJg9OSZsqZpcOdO0Z7u+a65vsYAtmSZXukhzV82farOU+bIGGex4N0OZcvkbuL0D5YND
	vwd+ZKrA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5b-008wIn-23;
	Sun, 19 May 2024 15:25:03 -0500
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
Subject: [PATCH v5 04/28] ntsync: Introduce NTSYNC_IOC_MUTEX_UNLOCK.
Date: Sun, 19 May 2024 15:24:30 -0500
Message-ID: <20240519202454.1192826-5-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtReleaseMutant().

This syscall decrements the mutex's recursion count by one, and returns the
previous value. If the mutex is not owned by the current task, the function
instead fails and returns -EPERM.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 53 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 54 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index cfe802c79d7d..f00af9b15164 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -396,6 +396,57 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state, returning -EPERM if not the owner.
+ */
+static int unlock_mutex_state(struct ntsync_obj *mutex,
+			      const struct ntsync_mutex_args *args)
+{
+	ntsync_assert_held(mutex);
+
+	if (mutex->u.mutex.owner != args->owner)
+		return -EPERM;
+
+	if (!--mutex->u.mutex.count)
+		mutex->u.mutex.owner = 0;
+	return 0;
+}
+
+static int ntsync_mutex_unlock(struct ntsync_obj *mutex, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_device *dev = mutex->dev;
+	struct ntsync_mutex_args args;
+	__u32 prev_count;
+	bool all;
+	int ret;
+
+	if (copy_from_user(&args, argp, sizeof(args)))
+		return -EFAULT;
+	if (!args.owner)
+		return -EINVAL;
+
+	if (mutex->type != NTSYNC_TYPE_MUTEX)
+		return -EINVAL;
+
+	all = ntsync_lock_obj(dev, mutex);
+
+	prev_count = mutex->u.mutex.count;
+	ret = unlock_mutex_state(mutex, &args);
+	if (!ret) {
+		if (all)
+			try_wake_all_obj(dev, mutex);
+		try_wake_any_mutex(mutex);
+	}
+
+	ntsync_unlock_obj(dev, mutex, all);
+
+	if (!ret && put_user(prev_count, &user_args->count))
+		ret = -EFAULT;
+
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -415,6 +466,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_MUTEX_UNLOCK:
+		return ntsync_mutex_unlock(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index d5e5a2fbcb4d..a633db34f284 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -42,5 +42,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+#define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


