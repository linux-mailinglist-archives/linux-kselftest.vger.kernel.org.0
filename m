Return-Path: <linux-kselftest+bounces-23338-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104E89F160E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242B8165616
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FEFE1EE7A5;
	Fri, 13 Dec 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="h5qzMmFc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17BE1E2838;
	Fri, 13 Dec 2024 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118546; cv=none; b=fzdOt/kCHuGBhpIQ4AG9Eq+K/PWem6mApSHegLrhmP54hiOSWHirLhhCzHFZGcCo70iNOq6s5DK9V7D0ArS0aWrbf02R5A6lUXZTug9KBJdT/OwmTeSz9oH8H9Ih1uf4lFixllxhlfj2M5h3bqk+7i94LJRmqsjLg7u+hY9bfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118546; c=relaxed/simple;
	bh=IUdYcaI2Vpmw8umSLTDWs+zlcb5U7mXQoBLUtLWRHbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo0ytkwxiwDzxCbZ7jJiJzLinPONIdKL4nOimEGEJk2Uws5nrsyd/Pjl68u10G229r79y0ncq1GJeI8rUorcKpgpQMCgLc1dDURod/xj8hcp4cJRFpmIv8PuMZkj3VXzed5FZ6MP8ZCXXluhu9clK+o2Muj4QUVFFcBc9LCVJuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=h5qzMmFc; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PrCrT5IKJmuSSkRmrNdUlthX6eAv49ao1GMOy8SkkcI=; b=h5qzMmFc+c4QjcEW3FJ58O0+nL
	M4OqXqzo9HQ6v0NEeCbbK4obkOugTG4I1lPT9ugXoc8x3rJbWcLa3HMljcClADwestBHei34obMKM
	KDpwfIxE1sriQBV4ua+PWm2Dfti6/Ebe2GE8Qu76RL1H9bmwueqpBnOW2feYS2MKLfpcEfeYQKtRK
	7b3R3GlpcNkSQbUyhKMWf/o/hH+6TM0AFAjwmn3HRm4t+6Eolr5mpgPS4KnjihZqzqr6vq/anAohC
	kxgSUjnww5LJ7wi9bZwXCAZE2B/M6jgmpUBERRNH/CI1nCcrfsjN46Jpf9rTh/3fB0PlLGHqH638c
	+gQEVG2Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRi-00ASsZ-0X;
	Fri, 13 Dec 2024 13:35:31 -0600
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
Subject: [PATCH v7 02/30] ntsync: Rename NTSYNC_IOC_SEM_POST to NTSYNC_IOC_SEM_RELEASE.
Date: Fri, 13 Dec 2024 13:34:43 -0600
Message-ID: <20241213193511.457338-3-zfigura@codeweavers.com>
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

Use the more common "release" terminology, which is also the term used by NT,
instead of "post" (which is used by POSIX).

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 10 +++++-----
 include/uapi/linux/ntsync.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 2e7f698268c1..cb3a3bd97ba0 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -57,7 +57,7 @@ struct ntsync_device {
  * Actually change the semaphore state, returning -EOVERFLOW if it is made
  * invalid.
  */
-static int post_sem_state(struct ntsync_obj *sem, __u32 count)
+static int release_sem_state(struct ntsync_obj *sem, __u32 count)
 {
 	__u32 sum;
 
@@ -71,7 +71,7 @@ static int post_sem_state(struct ntsync_obj *sem, __u32 count)
 	return 0;
 }
 
-static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
+static int ntsync_sem_release(struct ntsync_obj *sem, void __user *argp)
 {
 	__u32 __user *user_args = argp;
 	__u32 prev_count;
@@ -87,7 +87,7 @@ static int ntsync_sem_post(struct ntsync_obj *sem, void __user *argp)
 	spin_lock(&sem->lock);
 
 	prev_count = sem->u.sem.count;
-	ret = post_sem_state(sem, args);
+	ret = release_sem_state(sem, args);
 
 	spin_unlock(&sem->lock);
 
@@ -114,8 +114,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)parm;
 
 	switch (cmd) {
-	case NTSYNC_IOC_SEM_POST:
-		return ntsync_sem_post(obj, argp);
+	case NTSYNC_IOC_SEM_RELEASE:
+		return ntsync_sem_release(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 27d8cb3dd5b7..9af9d8125553 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -17,6 +17,6 @@ struct ntsync_sem_args {
 
 #define NTSYNC_IOC_CREATE_SEM		_IOW ('N', 0x80, struct ntsync_sem_args)
 
-#define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
+#define NTSYNC_IOC_SEM_RELEASE		_IOWR('N', 0x81, __u32)
 
 #endif
-- 
2.45.2


