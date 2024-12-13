Return-Path: <linux-kselftest+bounces-23343-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDD9F1621
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12C6164055
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6961F12ED;
	Fri, 13 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="hKwLrbS6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D1B1EBA16;
	Fri, 13 Dec 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118549; cv=none; b=NrmI/AYZYACDjED3/SoRqKlEFidfz8JxL6VutZa95rO6XdUACPaNI/2itSThrowSPiUyWIoxnxObzlzm/txwUwcCvhfIW60D1nDcWA9mOfxUeJ7FJz1n2/oANjQB/kjrjR41LMve2KjRhQk8X5P6TWBLxv9P5D3PtLfT5sWKe+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118549; c=relaxed/simple;
	bh=Ekx/4ZKUe+lS0t7d85GMrDHBggTvQnpAGwVvTY92/lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nce+bOWfyTek3iqL+05NhIghXPxgwreIL2gGPyT3ueSD/6Myjz/Ct0afOuPQKYTof2yS0ZZQEikxjp7Gdqai0ZHUaggsHxTuDZzjnlA36Yusz1THfB/XmMlVBb3V/TkjvTNG7B9HHVn8KWTRMn6kFegWSXHTn3fN7+r7q0t7sQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=hKwLrbS6; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jTuymXozP9oLG2lZYuspwou+A4SfkrRmIYiwZWf4Du8=; b=hKwLrbS6PrXEtzDJMg0P/FQvR9
	gWaEeGj7FxdW22n3UW0vi8v4Dt47yaaSszTNPwhf3LPiokp3d5i2XEKPrHClj9UcS5CGOtRhrI4ez
	eiC8vCNXuI3oZTW3FRdA3pLf4+ZKARRZP3vNPWSKBbOOsmPGFGRvSiL+EfsIThEmROXU9Q8JN/ePJ
	8iUhUvCOKUznqwdLK5QeJQLrluEqOLOOMrsPiDD8/Gz2ecyWpQy5eGXFppDEXg3TgfVcy7n4SM36o
	UmaPXxzvbOcfLocVKjAG96L19Y0M2fyG1CiQvowNconVHjSRqhS8VAV7qcVzCPhFOGq+g/cBumMF2
	NCuC16+w==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRw-00ASsZ-1p;
	Fri, 13 Dec 2024 13:35:44 -0600
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
Subject: [PATCH v7 12/30] ntsync: Introduce NTSYNC_IOC_SEM_READ.
Date: Fri, 13 Dec 2024 13:34:53 -0600
Message-ID: <20241213193511.457338-13-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213193511.457338-1-zfigura@codeweavers.com>
References: <20241213193511.457338-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 24 ++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 141ebe8a7d4f..b2043412c5cd 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -583,6 +583,28 @@ static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
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
@@ -602,6 +624,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_RELEASE:
 		return ntsync_sem_release(obj, argp);
+	case NTSYNC_IOC_SEM_READ:
+		return ntsync_sem_read(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 9eab7666b8b9..e36b4cfb7d34 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -51,5 +51,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
+#define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 
 #endif
-- 
2.45.2


