Return-Path: <linux-kselftest+bounces-23339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2EF9F1614
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFA4284786
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32D1F12F8;
	Fri, 13 Dec 2024 19:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="rNrQ4oLe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B11E4929;
	Fri, 13 Dec 2024 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118546; cv=none; b=MHPE134EaiMZ3xC9TyKTgzgsZaB9LRQWGAYskh4ztRL2WhjwvQqAJoJCDqYdBFxHNXYqPG+nEnatFDOoTAYzKYVaiueUn/k/zI3fxJlAh9UxnlDoBwDplh+at9hGzbpOOzvi5CoOHdn1cBwADwCfQqC8kAKvWR3hRTFdaTH6GHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118546; c=relaxed/simple;
	bh=JwhHE1V7nFdKh1Zavz80X2jX29RBQxt2kkLYAJWpmD0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HKOBhwfj8cKLp2LLYrvVvXLTf0EyoAwbTuOM7UGtnarytOn+WBMe5X6bV1C3uX2X5tNAC/fCaFcgS7I4XKXIpR5T1ChmCU09+2goPJblWUOJtPQvusUfQoBrbn+QWgjZO9UVuQ0k1YSU5bN07YPSp95mhfZCu5ltuNBIYwEB3pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=rNrQ4oLe; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=owYdfKteh3S+7okq2vSjTHj5blSmMptwkXbUo2Qdvpo=; b=rNrQ4oLelHZteZnAkZNy30tdFT
	I+6x5iEj9Gt+UJhUHRhWY+LwWfGZfEn2e91zlLuyyMWQzAvCuX+z6nNPNsjNV5XRaTUER3U249qI6
	qdTlI8DDUeGmIc+B5hfDVlSQcGDh8UEmIT3evsS5CgoRsCatF6+TGfR37ZERCnSSRF48JCq4Co9QK
	KJDdmETBex/8TA0oFF1uHEkTInLvjQioEA5lOByF6xPcHOPudk+907g7d3/8kDYMyOjAgEicQLNCj
	fOmglW85qOQ/Wagplg9sJ4H1DVRny5k+6UK/U80G+wNeyVyZkOFdACdfjuf0oNringSJ2gKDGoIhC
	8skTxj8A==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRd-00ASsZ-1S;
	Fri, 13 Dec 2024 13:35:25 -0600
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
Subject: [PATCH v7 01/30] ntsync: Return the fd from NTSYNC_IOC_CREATE_SEM.
Date: Fri, 13 Dec 2024 13:34:42 -0600
Message-ID: <20241213193511.457338-2-zfigura@codeweavers.com>
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

Simplify the user API a bit by returning the fd as return value from the ioctl
instead of through the argument pointer.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 7 ++-----
 include/uapi/linux/ntsync.h | 3 +--
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 4954553b7baa..2e7f698268c1 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -165,7 +165,6 @@ static int ntsync_obj_get_fd(struct ntsync_obj *obj)
 
 static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 {
-	struct ntsync_sem_args __user *user_args = argp;
 	struct ntsync_sem_args args;
 	struct ntsync_obj *sem;
 	int fd;
@@ -182,12 +181,10 @@ static int ntsync_create_sem(struct ntsync_device *dev, void __user *argp)
 	sem->u.sem.count = args.count;
 	sem->u.sem.max = args.max;
 	fd = ntsync_obj_get_fd(sem);
-	if (fd < 0) {
+	if (fd < 0)
 		kfree(sem);
-		return fd;
-	}
 
-	return put_user(fd, &user_args->sem);
+	return fd;
 }
 
 static int ntsync_char_open(struct inode *inode, struct file *file)
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index dcfa38fdc93c..27d8cb3dd5b7 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -11,12 +11,11 @@
 #include <linux/types.h>
 
 struct ntsync_sem_args {
-	__u32 sem;
 	__u32 count;
 	__u32 max;
 };
 
-#define NTSYNC_IOC_CREATE_SEM		_IOWR('N', 0x80, struct ntsync_sem_args)
+#define NTSYNC_IOC_CREATE_SEM		_IOW ('N', 0x80, struct ntsync_sem_args)
 
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 
-- 
2.45.2


