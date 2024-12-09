Return-Path: <linux-kselftest+bounces-23082-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7DFA9E9F12
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD20A188A839
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ECC19E96A;
	Mon,  9 Dec 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="mBKG3zDR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7D19CCEC;
	Mon,  9 Dec 2024 19:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770986; cv=none; b=PMZKaDyUlEZ6y20ZPDQyR8mpXog4DEdkvhKn0+WoNHK/NTuP/ys36OByiA13Vjw4jwTGU+Wjh2hguQ1FtTTE4l5G4B865Y6VbXQ8OK+hHA672uMJQcnrMefhiJa2FnT+eTbrajkUhVK+ZnstjSVfZbklj8QVuN/zqaJQRg0h9qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770986; c=relaxed/simple;
	bh=dt45LmJEiSiP1XR8v8MoEfPn0UTXtfiHExBuAta6jms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ru8dIk1uoVWxjwTjo05KXu9FSe7cWmvrm+PAWEfej0+3Atyt1cJJcV8kp+3fKvu76OopbjkdTYX4k79ZUgB/nwwvmdMQFRnTcjlpD5bSmQbFTiT8vS3Gc+2EPcrq3zC3hfOfL/+pYQeGCMwR4BW1El6eQZ/cvJVs12WUN7FvDHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=mBKG3zDR; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SKJGtwUzzUoLxIjVaNdwAGBQ/Tls5kq3VYxfQTvAUCE=; b=mBKG3zDRx3Cte99YBlfx06TugW
	yO7hWSOCG/3CS8SW6B2I5lBxMd5vC3Byeo/F4smbdaGwe16UWF/lIzMT8qTZ3G+ZbGLYWtArnFyd7
	C0uKAtheMfj+t8/61BkEwQZTX+fvE9IVmykAwGTbtg29R6eebbH+hTrqpFj7t/t5Pw7a0diVjIpFR
	N/sLwZjpr42ReaAEYT/c3lDmsevM0DuLXp2BmsUzyeG+7CGwza93N4+EdOrSP4I3LJUOnxcASjPjO
	ChrzDi+AxYYG6Kk3ZtMx4CsnDUzQCLypfQUcWzgBfWRZnoNpN891RJC6QlHbKJB+IgA1MjfzilEVH
	+mAEKy2g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiya-001Gd5-2q;
	Mon, 09 Dec 2024 12:59:24 -0600
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
Subject: [PATCH v6 10/28] ntsync: Introduce NTSYNC_IOC_SEM_READ.
Date: Mon,  9 Dec 2024 12:58:46 -0600
Message-ID: <20241209185904.507350-11-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 26 ++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 6b8352270874..d6e8a4bde1d0 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -583,6 +583,30 @@ static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
 	return 0;
 }
 
+static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
+{
+	struct ntsync_sem_args __user *user_args = argp;
+	struct ntsync_device *dev = sem->dev;
+	struct ntsync_sem_args args;
+	bool all;
+
+	if (sem->type != NTSYNC_TYPE_SEM)
+		return -EINVAL;
+
+	args.sem = 0;
+
+	all = ntsync_lock_obj(dev, sem);
+
+	args.count = sem->u.sem.count;
+	args.max = sem->u.sem.max;
+
+	ntsync_unlock_obj(dev, sem, all);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -602,6 +626,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_SEM_READ:
+		return ntsync_sem_read(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 5586fadd9bdd..5e922703686f 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -54,5 +54,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
+#define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 
 #endif
-- 
2.45.2


