Return-Path: <linux-kselftest+bounces-23349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D909F163B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A92DC188E2A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914141F4E35;
	Fri, 13 Dec 2024 19:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="nAeehgDO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23201F4260;
	Fri, 13 Dec 2024 19:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118551; cv=none; b=tfv5vQ0Q84byhsaon0G0PEWsxrZJdWrYx5AlI95VEPNRBDJq0mf9i30+O1GakzBqzZysCj8BNelNnKy6FtGjDs/Av06NqIu0Nn0R7i2mKTYJyZyTCsM8Sm+MkjR7C8z1svX+c6VFYmIhzAC/MC5CjQx8yBsy/UgtwJBudxlDlaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118551; c=relaxed/simple;
	bh=5u67zKVa5RU7MQlgLiJDfF2It3YHbhWWFlwjw/F2oBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKt+HDhuuDDj+ZsQkOH5D6Zk+24CKnkkFrozpQKq+6Rpfl25i0FtcwUun+Fl2W9mfNE/Pp8XRs7xEgWePne/CW4sjaLO7umaSK35QejsfvHPNn2jgiKg/m4eNh83742v1BRHs6oxGF+0d8VLzS7tx7B0hbjrJ69F2bWt6FMn0Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=nAeehgDO; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GjqmdWYcY3chHGsxf2lTHkmxX9CvoUQ42FGe/WL091E=; b=nAeehgDOaumNetvmXiJsSK+3qp
	Q+ToS2FRd5DAPMe2fn+UoTiF60W/7HtoYFnuZN9hpJ9q2Ot3g2Clh8RtECtfBI11Wf4kjpZDoX0mF
	Zvr57Dv+M/RhbnnZFiFikH33pOI2+Aav2w395zLfROAhG+nkSmuWp42fePquwP8DH2kmBLUSQFvci
	xYKwlJLUXoMZbex/CGxx1CNVPIyjUmFFTxtCr9di+JnMIuB0QV/PBOaZShkh60YJhQHDKd82u3hpy
	avv/Q7nLrmyw189rLVxjB9Yat4TGQfpG/jeNTJ8fD67hr+9upPWT9u2EsJQEYtu6/zmQhyOri9tjY
	D9OrTl0Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRx-00ASsZ-1w;
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
Subject: [PATCH v7 14/30] ntsync: Introduce NTSYNC_IOC_EVENT_READ.
Date: Fri, 13 Dec 2024 13:34:55 -0600
Message-ID: <20241213193511.457338-15-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtQueryEvent().

This returns the signaled state of the event and whether it is manual-reset.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 24 ++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 0047b13b6ebd..78dc405bb759 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -629,6 +629,28 @@ static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+static int ntsync_event_read(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_event_args __user *user_args = argp;
+	struct ntsync_device *dev = event->dev;
+	struct ntsync_event_args args;
+	bool all;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	all = ntsync_lock_obj(dev, event);
+
+	args.manual = event->u.event.manual;
+	args.signaled = event->u.event.signaled;
+
+	ntsync_unlock_obj(dev, event, all);
+
+	if (copy_to_user(user_args, &args, sizeof(args)))
+		return -EFAULT;
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -662,6 +684,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_event_reset(obj, argp);
 	case NTSYNC_IOC_EVENT_PULSE:
 		return ntsync_event_set(obj, argp, true);
+	case NTSYNC_IOC_EVENT_READ:
+		return ntsync_event_read(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 207646e63ef3..b9d208a8c00f 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -53,5 +53,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 #define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
+#define NTSYNC_IOC_EVENT_READ		_IOR ('N', 0x8d, struct ntsync_event_args)
 
 #endif
-- 
2.45.2


