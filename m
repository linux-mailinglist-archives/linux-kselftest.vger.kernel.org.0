Return-Path: <linux-kselftest+bounces-4950-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A606985AEA8
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F582285298
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E9D56777;
	Mon, 19 Feb 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="oRX3cA7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1244282E1;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382378; cv=none; b=u8gkG9inRyQnyyHuu5ceZ9I71wS7FaegAfI5a7JGH5WKvKSeunkq3FerMbm/fl3DPwdomN+/NotmUny9RYtJ2y3b5kg6W3ZKDsXgbtHYvnt0PZ6WJ93FMTKNRxhY0HjV/zV8XocU7g/PUGxlEIqyAr8tKjLer56Od5Vw03mVX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382378; c=relaxed/simple;
	bh=U+f6gfVGJpZBwQ+lJ3ca0RBWe/TIQZ+fd784DpNhuE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUTfdBg9UKd7AtI1qJNxLcrG7x0P1o8phfQ/k/+XrX0LXj7HkA6INqDlTXC6Pf5kqU7ivhkelZY9nqfU3Pln+cnmXq25ZktKrX/vC4SDegjJ6D7OFjAbIDK7KsctW0nFT94e05DosRWs8GzruHuFQI/a15S0+KRE5qQ1SbZ7NWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=oRX3cA7H; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=WioaNR4nUnvUEz8Ifo6nqOHOR9VQ5/vSfrgEU6sTQKs=; b=oRX3cA7H2bAqOtJL8o4idZalSe
	DMr4yxzxYiB0XLmtD0Yf5hMke7tMoixAS6VKbBy1bYU+6eONXbe3PEBp1oQxPMWBhD9TxX7iIg4JG
	hyUbs3u+TAE1fiEVjjxVeC3eVM3b7sskwn1QI7RQqlJQy/17/BMzKq8qDpFRRPhkrZstWdOOIidcn
	uW7BqC4DxZw7nztxGTt/RlHQ1lnPUNgjCkWsPbV6+06Judm3nk/CgfYUerSX0U28LBrHK8ZPdRffL
	FzOA4d8yHwADmELKqdyHif86mvQ5T3DR2xWuzpzyFjHRRGbSTw94fNNnSKeiRG2b4tsmOrbK1LxyU
	zepqUKiw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIM-0037Oz-3C;
	Mon, 19 Feb 2024 16:39:31 -0600
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
Subject: [PATCH v2 13/31] ntsync: Introduce NTSYNC_IOC_SEM_READ.
Date: Mon, 19 Feb 2024 16:38:15 -0600
Message-ID: <20240219223833.95710-14-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
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
index b9b4127a6c9f..0daaeeeba051 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -528,6 +528,25 @@ static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
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
@@ -547,6 +566,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	switch (cmd) {
 	case NTSYNC_IOC_SEM_POST:
 		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_SEM_READ:
+		return ntsync_sem_read(obj, argp);
 	case NTSYNC_IOC_MUTEX_UNLOCK:
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 72047f36c45d..42f51dc4e57e 100644
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


