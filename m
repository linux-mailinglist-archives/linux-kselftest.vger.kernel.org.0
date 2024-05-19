Return-Path: <linux-kselftest+bounces-10394-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487078C9640
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABC71F21244
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4D74435;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ozbAO8d6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A66EB5F;
	Sun, 19 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150318; cv=none; b=dDAXY0IDxjluJGRYf/Kyc00mEdhUnhEOC4tnuJmriiEcBCfn13sHYIGB/1nr7oe3nk3hlMs2Kv2uOD7w2Q/Xp/xx6D0UvQd6ztrfhpFgC9463I0LC76wLDgH7Qoh9pXYCXwM7CvcDrOpxc5H16RbxOAf+wnLtNh4QFEUEsLoiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150318; c=relaxed/simple;
	bh=lBBJGgDiheSxZzqAmULQlnQ736+/Gq90V1LdkV/q+30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6dE6lg4ab7x37urIiRJpihIvceO+LBuWg+CwMIonP8OXsA7bldALrt+pZRF3dOiN/elWuu701W1UNqG63E0RRAWnHkxW/fCw9dEaaY2Ahfu4hzbbDe3SOI+gciGIJgUZFjK7/GVWRHWq38dUk5DtXm7mVXJzvagTbBOao4h63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ozbAO8d6; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Xiql2IKLoebqgT1FdXxUiO6lyiCYg36adwMvkFTJSLM=; b=ozbAO8d68F2po+Bf8a4zjpSSoN
	oZWrx76KAKK1W/IFi9SMwmGg2s9gC7eOOXXXoSQ2I2od497ZOwJabuZpyWfajjgRMhc43jjjnBrON
	N9Upg9/xl9ZZ6rpVWF5dTGfX0ZtCACb52aGPze6+kRiGIyVetapBUqvSSvGrgStqoXBTuh2EdM0PQ
	DQf03emMr1Yt7VD52D8aqnTq/OSlpmRBwWoaqzYMeVAMkTITtQlv371OPFrdOu09MIUzN5pqXEuEM
	7eUwnPcMtsuXDWICCk84GKlSPaEm2IsjGalx/dVzYlGZrYV7uTSgOzzD1ljhyv+pT400BThCysjgh
	zK8glb8g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5d-008wIn-0Z;
	Sun, 19 May 2024 15:25:05 -0500
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
Subject: [PATCH v5 11/28] ntsync: Introduce NTSYNC_IOC_MUTEX_READ.
Date: Sun, 19 May 2024 15:24:37 -0500
Message-ID: <20240519202454.1192826-12-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQueryMutant().

This returns the recursion count, owner, and abandoned state of the mutex.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 28 ++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 29 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 4c680a2b8353..622be0075ba4 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -607,6 +607,32 @@ static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
 	return 0;
 }
 
+static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
+{
+	struct ntsync_mutex_args __user *user_args = argp;
+	struct ntsync_device *dev = mutex->dev;
+	struct ntsync_mutex_args args;
+	bool all;
+	int ret;
+
+	if (mutex->type != NTSYNC_TYPE_MUTEX)
+		return -EINVAL;
+
+	args.mutex = 0;
+
+	all = ntsync_lock_obj(dev, mutex);
+
+	args.count = mutex->u.mutex.count;
+	args.owner = mutex->u.mutex.owner;
+	ret = mutex->u.mutex.ownerdead ? -EOWNERDEAD : 0;
+
+	ntsync_unlock_obj(dev, mutex, all);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return ret;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -632,6 +658,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_MUTEX_READ:
+		return ntsync_mutex_read(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp, false);
 	case NTSYNC_IOC_EVENT_RESET:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 5e922703686f..eced73d08783 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -55,5 +55,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
+#define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
 
 #endif
-- 
2.43.0


