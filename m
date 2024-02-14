Return-Path: <linux-kselftest+bounces-4680-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643BD855788
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94EC81C21C71
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A8D14533A;
	Wed, 14 Feb 2024 23:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="bpGNDtTb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A08145322;
	Wed, 14 Feb 2024 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954794; cv=none; b=ctNu42FcOgumZZWhN7241FFJX28U+/Xp6DiB+YwR4SKwGfLTpbG3rV/dipAFopqlMNFoYU4hka8tXGB1HllpSF3A3fzr/2wy604WWmu9vJG5iHhVUhfecMVe/Z5CC5Ue/fZnvViICjqtfzQ2BTNaTsNBNbTGL21yw/XP7rvqCV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954794; c=relaxed/simple;
	bh=K6zdf91Wo6sPO0UUq27EuXcrBoHBiVRejjL6HL++Jxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RIiFJnRqneHpA1e/kNCoiUYX3KSbpjXSPE00ZH2m0mxI/C3CEvo07UchPMnpIJ6qO8GKta69s3s/BMYUm5shvoURgDCyKlxZ19TSCYnRddM8Vf310KcY5NqsWOl3Tg6ZKAKFtlbkDoohzkWx2bJ7zp0vOjbSsTDxgSmvdEMGl88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=bpGNDtTb; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=L7wuV3Wr5OefMrgO+45a5m75xF80Z46lGZQ4kmg1BtE=; b=bpGNDtTbcTJJ0J/whxj6D0L2A1
	klRDVFO8F1coV+KysGWJarp5tbAPsV23AbimMUIoJMETeYkr//5m1SJkkh/ylc9ts8zicfBagc1Th
	ZGlYXLAXK/aWey9R7vNErJ95iqwtrkHDwGbjNNzHHzTOXczTD43QCprtp1S9uBmm7z7+1yUGoDIDz
	1MfDZy+AmWlNIiuSlx4RrbodsajKBADsHT9xn0HvHJhmxeaDpbrEpNpjblmqsc2rf+iuyQSOx6EEH
	vSKkIFkwWi6kyiFdIO3BoFxWSLeUQoe6QxVDpy7ARayBoBc2sCmjpLQRQVww+5ZRUyqM/P7a3ZbRz
	ILeHMDVQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raOoZ-00GbiL-2A;
	Wed, 14 Feb 2024 17:37:19 -0600
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
Subject: [PATCH 07/31] ntsync: Introduce NTSYNC_IOC_MUTEX_UNLOCK.
Date: Wed, 14 Feb 2024 17:36:43 -0600
Message-ID: <20240214233645.9273-8-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214233645.9273-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtReleaseMutant().

This syscall decrements the mutex's recursion count by one, and returns the
previous value. If the mutex is not owned by the given owner ID, the function
instead fails and returns -EPERM.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 64 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 65 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 5b7f93709587..42041afd8d15 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -299,6 +299,68 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	return ret;
 }
 
+/*
+ * Actually change the mutex state, returning -EPERM if not the owner.
+ */
+static int unlock_mutex_state(struct ntsync_obj *mutex,
+			      const struct ntsync_mutex_args *args)
+{
+	lockdep_assert_held(&mutex->lock);
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
+	if (atomic_read(&mutex->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
+
+		prev_count = mutex->u.mutex.count;
+		ret = unlock_mutex_state(mutex, &args);
+		if (!ret) {
+			try_wake_all_obj(dev, mutex);
+			try_wake_any_mutex(mutex);
+		}
+
+		spin_unlock(&mutex->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&mutex->lock);
+
+		prev_count = mutex->u.mutex.count;
+		ret = unlock_mutex_state(mutex, &args);
+		if (!ret)
+			try_wake_any_mutex(mutex);
+
+		spin_unlock(&mutex->lock);
+	}
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
@@ -318,6 +380,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_MUTEX_UNLOCK:
+		return ntsync_mutex_unlock(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index d68f24fd75a2..a3f5f4f13798 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -39,5 +39,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_CREATE_MUTEX		_IOWR('N', 0x84, struct ntsync_sem_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+#define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


