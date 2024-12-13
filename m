Return-Path: <linux-kselftest+bounces-23347-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62B29F1634
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C149188DEB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F4E1F4709;
	Fri, 13 Dec 2024 19:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="mS2monro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E37B1F2C3C;
	Fri, 13 Dec 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118550; cv=none; b=BDjZInBde5DKhCajY72eO0fFAnwkU1rzDTahvZth2JA33LnL7qCj/9geBKYlImDuPutemlZ9FboEaxXBCK2scawj3idhsijxJmO3yEgHxbJ2HvuEsLgohKJVSV6pirR7JbU5p5wnqYjEUXTif08MRla9k7/L8NFvsJDcqU67W88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118550; c=relaxed/simple;
	bh=i1daEmnWb7IGVEOspfV0/3NZWTQyk+XfwPtJfoTbEM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0hsbVUO2p7vcnQ/JayMaj4ASTuhx9LPnzdjzYe7k0ky2ubB7WV4awnrGdhhd4EQB/7aHbvrfQRjQ/42uQlvAY6JkMxtf0TZEuag/LH4orKnWSRV0jU3IUgnY54Gh83O5Or5HyPc9WvRApt8tXfD3OEiOmqwthRYXmxEMDRU7Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=mS2monro; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=M0iP9I8yrmglZPKIGFhiwcipjFzu/U9WBtXUk5z+Pk8=; b=mS2monroiRPleZWst381TFWcfx
	HbMhrswxBDQw+uBaUh/768vFJ4HbwvJV7X3jZn1BUars/WeVcYkl8KEGyhhkduU8vyD/NFe8X68xB
	5k1NMnvSKx4ZFNjWlArox2atS8+Sim/52oKZ1/Sjehqaj5e7JvnBmxzZx2Hr0CFXc4i225pApR9QK
	MD3wMbtamfyEsWYvOK5tIL/KnDGw8ae6OjcfmCw2Fo/rdvI8O3Ekbqp1jETlW48JmQOrzVKm9YDu3
	VfoJWcOxPAXQFrnIMMGm3T3JCOmklOMOJVmI6v1vpnLNGliu6Ois8RkjyXQ8uzyBj8UfNimr+sL3H
	pm32F4cg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRx-00ASsZ-0R;
	Fri, 13 Dec 2024 13:35:45 -0600
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
Subject: [PATCH v7 13/30] ntsync: Introduce NTSYNC_IOC_MUTEX_READ.
Date: Fri, 13 Dec 2024 13:34:54 -0600
Message-ID: <20241213193511.457338-14-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQueryMutant().

This returns the recursion count, owner, and abandoned state of the mutex.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 26 ++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index b2043412c5cd..0047b13b6ebd 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -605,6 +605,30 @@ static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
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
@@ -630,6 +654,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_MUTEX_READ:
+		return ntsync_mutex_read(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp, false);
 	case NTSYNC_IOC_EVENT_RESET:
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index e36b4cfb7d34..207646e63ef3 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -52,5 +52,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
+#define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
 
 #endif
-- 
2.45.2


