Return-Path: <linux-kselftest+bounces-3802-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 053DB843376
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 03:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51049B20FEC
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jan 2024 02:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8BF1A708;
	Wed, 31 Jan 2024 02:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="b/wDzQH6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D05394;
	Wed, 31 Jan 2024 02:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706667368; cv=none; b=SKS+kiLgsNDXrMECF40owruN6ivU3pJIOnYkR4Ii0Mv36xnEjtOLBA5Yw49nfW1SWVIP89lwAmmIC3IPCGMydUIqKPO2M7UcRH3e8fVUSoukRzIVR503HMZsiMs4FThBrLGJQo8Rl89Ek8jwhykn4sa0Ws1tRnN5YEoIjFufWG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706667368; c=relaxed/simple;
	bh=HCJDXrbbClLe54itl4O3me4eGm27hgSAHGhToE6sjJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMSkGJpPyqfaY/LD//lwg5hjR3/Fey7Y5sXE18a171cBns6MNjzJbAXONZ+7LEmtf8TXQn9QNpNsPInEa7TRbD4MX/sbixe1AViKA9fg6Q5YNvfA51/639O5hAl4bzlb9q59FDAiOuEe3o5OdIFV8Y4LUAB92VPWnXmfljOUN0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=b/wDzQH6; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=R39lGOqTNBMRXbRmwXOtAWXBwOD9NggROFCJWXViCO4=; b=b/wDzQH6Mzut/tAITEPLUTaKVE
	k9IamG8XOeeE3ntHS0bXtYmBvDn97GUEB/LVGXkFeCg0/6Rzb2j+YrUrg1+RUD2pskQOLaGMKA775
	hjqKMmHp/Z15IzDSmXc9Hd16oW8zqJxgwF3fS7cVoeppiyvFvclwsfBUo2IykJkzjoxmVchrLxyaM
	Ds3s6WMIULYiGME82YQS/MHw/rqV236Z/EhhefrGN63zbwnhhtN+kllp/K1EZh8RXU+5Fo19E+W7+
	jXAbN2VLiPjFRxpwvHjMccMdMbO/iVZrsND7y3hWzSDk+iP9Wiz2bXQRhyRheboNYWLmI2SRMdJfp
	yRew08zw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rV08o-0038Kv-0p;
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
Subject: [RFC PATCH v2 13/29] ntsync: Introduce NTSYNC_IOC_SEM_READ.
Date: Tue, 30 Jan 2024 20:13:40 -0600
Message-ID: <20240131021356.10322-14-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQuerySemaphore().

This returns the current count and maximum count of the semaphore.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 21 +++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 240ae858fa96..6dccfbfb2512 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -506,6 +506,25 @@ static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
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
@@ -525,6 +544,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_SEM_READ:
+		return ntsync_sem_read(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 598f894f868d..6017f621687e 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -51,5 +51,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
+#define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 
 #endif
-- 
2.43.0


