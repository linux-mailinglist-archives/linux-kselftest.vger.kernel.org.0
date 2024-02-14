Return-Path: <linux-kselftest+bounces-4686-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00CC8557A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651CA1F213B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE361468E4;
	Wed, 14 Feb 2024 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Wip/RTMI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA585146011;
	Wed, 14 Feb 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954811; cv=none; b=uZPcYtwCRFEXSCWvvLCZDgLVZhcAgToXJOMCFUMqVvu+1NZLkYmVHPBq9Y7SroHoE0DR2ZvoRkb5lY3FARfSAp5K+VLCd+57Kqt3qygK3bWMPVTct2VEIcl5RxjZH9SINrG280Mvn2egcp8eqM+s2+ROZJl/t/t0hKSUeLDJxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954811; c=relaxed/simple;
	bh=iNoJnS47rRHG70TRY/f6nIJyk4KHDH1hiPc+CQPBb8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l599iRbnfszWVd3phbdummvC3SpW2pz29dGe6QPV65kTgxnSS0iG4m6y+yv2yytvFACn68neTqTnkMPP8UJfwfJw/Jxm6t0fbAy1i9AgKea9qgVNi8WmiJswm6FPaylcMZlpF4CZINQI5up/hj3Tler6dCBNWdiyNvdtPoGGAUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Wip/RTMI; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=ysylq2RMZIH24LbG0jmFl4YpEtJVTp+RFmS8r+eXNAU=; b=Wip/RTMI5/kTkwfD+ng/5Q49mi
	JEWcMzTNSykQPwp3F4yRheF7LDNVqT2t6kCPa7BnQYfrz+aV/Vz8TD4cIa5BQv/LDxcLtOpN2FVnw
	0091iXLF8LiN8TBBHqTJlHILupureelN8827AagDZshNTWLnJGfXYOP/+XvXLVQTTmip4k7yxablt
	J2nNW/PMfqYGHdAb0vz0gTkf8N255mOxkPMJnqRtvhjiw3huOoyc+JYvzkRM03E1ZiNgf/MNsHcpb
	E7hZQIVlKB6QR+NCSv6to58oRC67XG1trwQneqBSpS88Cdatsqw62H4463nub2UxW7GBClw+LZo8N
	tdtWeS8Q==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP45-00GcSK-12;
	Wed, 14 Feb 2024 17:53:21 -0600
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
Subject: [PATCH 11/31] ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
Date: Wed, 14 Feb 2024 17:52:46 -0600
Message-ID: <20240214235307.10494-2-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 22 ++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index bc24de02fd1c..57d78b086241 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -491,6 +491,26 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 	return 0;
 }
 
+static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
+{
+	__u32 prev_state;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	spin_lock(&event->lock);
+
+	prev_state = event->u.event.signaled;
+	event->u.event.signaled = false;
+
+	spin_unlock(&event->lock);
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
@@ -516,6 +536,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_kill(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp);
+	case NTSYNC_IOC_EVENT_RESET:
+		return ntsync_event_reset(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 782057552483..f2d7507d8438 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -49,5 +49,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
+#define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 
 #endif
-- 
2.43.0


