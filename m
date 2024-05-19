Return-Path: <linux-kselftest+bounces-10393-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 671A78C963E
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11FCB20BED
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D7F74413;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="dLTUVJxV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C3C6E61A;
	Sun, 19 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150318; cv=none; b=W27RmSsnIH+mB4X3O7CNT1dCEuU01HbKIgjtb+3DifOxsdzPMNtv7VFj72m+80BKHNL2Jd47WZmo9EdoGj1ViSHPLpW4Tyft4BsReJj/g+LA2omY/ZInhvtO+XNl8Hsvd09H4MmG6E2KwQ0dok9i+NQZXU+PLcvXnWkvKLiHVRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150318; c=relaxed/simple;
	bh=oMapuKPenFTpinOVOD0tbTg6ULyTL1PTui+UWvCHueQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCWMOkq4qRrKENcf0snp7W+dydAuymL71rNTs0pcO98T2GA8yvwPJ4Rvj/Ra2AFevNtwdhgR68T/oYq/9FbhZXA3TeNPGLHenQy8QNgm1Tcnl7+GDu69ibUKDCOKkw7vqVt8v+t6VxTIyR8Mkl931zEid03cNDR/B+DncQqTWAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=dLTUVJxV; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=PF2vH8n2a0SUqAmtsVo3n+FbtCkuTlLPVMtq6Luw9QI=; b=dLTUVJxVMWgzMFG4BxNRM6Shcd
	J2lKH7bur0EC2yaoPLy4cGqAfY+FCEFcbDQRDJjB3kwSxcEe3JCEM6VrQ2cxdQRKA8Znt8EdJbJk9
	8ZFNbZJRDXLfqj+PK0r5EH1ZsoctWg9XbTAP69/ppmuiS+anKmHhA3jOHUK9VQyv6VxsvSxEWQmo5
	kW+TRPAnE8rMVWOSBRQMixP0uoO6cIIedC0FSKcRRPLXUCK0gZPDdUaztGp4CkzQzD7cKoAHwxSR8
	DH5UvBFBgFIbeuX/NYU1SE7Io4vqAa4VIy0QOKeQA9/e1K2jmVFQbw5p8LxcPdOlARJ6J0boV0q1g
	+D3vqTyg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5c-008wIn-27;
	Sun, 19 May 2024 15:25:04 -0500
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
Subject: [PATCH v5 08/28] ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
Date: Sun, 19 May 2024 15:24:34 -0500
Message-ID: <20240519202454.1192826-9-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtResetEvent().

This sets the event to the unsignaled state, and returns its previous state.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 24 ++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 97d9b6047fbe..b070ceccc3af 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -559,6 +559,28 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 	return 0;
 }
 
+static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_device *dev = event->dev;
+	__u32 prev_state;
+	bool all;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	all = ntsync_lock_obj(dev, event);
+
+	prev_state = event->u.event.signaled;
+	event->u.event.signaled = false;
+
+	ntsync_unlock_obj(dev, event, all);
+
+	if (put_user(prev_state, (__u32 __user *)argp))
+		return -EFAULT;
+
+	return 0;
+}
+
 static int ntsync_obj_release(struct inode *inode, struct file *file)
 {
 	struct ntsync_obj *obj = file->private_data;
@@ -584,6 +606,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_kill(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp);
+	case NTSYNC_IOC_EVENT_RESET:
+		return ntsync_event_reset(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 36d903521bbe..7fdf79729b20 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -52,5 +52,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
+#define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 
 #endif
-- 
2.43.0


