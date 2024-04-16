Return-Path: <linux-kselftest+bounces-8050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A94298A5FB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156EDB21908
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAAD11C92;
	Tue, 16 Apr 2024 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="dsntb5iW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5787523D;
	Tue, 16 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229831; cv=none; b=CsakYweMWytl0GLZZu44Cb++WojtrZmsWn0RvKJhxsp8sJ/XVBX6GkkPmkaCbDqzMiMF92JT1dBJjzLmM9a6rcw8/ym93Y+taEs6abvGfFcYB4ewE5y+JNqs52mzI1uf9zuVZniZzLHn35obXXBA3jvBxfMoun3VXBzmXHj70/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229831; c=relaxed/simple;
	bh=CXhiKahb0eDgSiGeD4X7ssoSM82vjMLS/jKkCaqodDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMDqnBSGjY1Xt4GCxFJoECA3bpovwhVhdRsGb29l36A3d12pr2ggTEdBmT2pQiiIeXluej/lIwgQerjS/VFveIkRZEUGQ3SWkVIBD6kHxXdU53jY+JchiHlrLEiPR/w6BR++pa7Mxry69U3SZToVCl7aSy808WkSt8IDrSKLop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=dsntb5iW; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=7IUzCTQo6Yc6I84GM6d0m/2enQYUr8L54oRJIiZTpag=; b=dsntb5iWwqLlHEsFg7GCRVwW41
	cV8GEjsbWEaALvnV1s0/aP+waWGYsLaiH6GotVEKTBOg/N76dfLrUlboryK/VBzG9vZ9vL6PZef38
	LnV7yo/K5gQ2w1VhNgbW6qPNDjOdo/N1U3K8LZTODyb/ucWtBh7SizwxtuUm3NHoFix8T30tsmX5B
	vpsTC1VSZKzD+TG0QqSO65fxepK7knEITaFLsjGYituc9SrBVw6VfZYdOnBkIBv8C3L7HWbhxNtwD
	NmGBkuRuJs67++5b3wuWTN0GOI3EfOi9BflrRkYedjTJIH9uPtQDjBwYK2LlMVBbN7IwQo3Gd1Dwo
	BnE0bBhA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL0-00FbQv-0q;
	Mon, 15 Apr 2024 20:10:18 -0500
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
Subject: [PATCH v4 08/27] ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
Date: Mon, 15 Apr 2024 20:08:18 -0500
Message-ID: <20240416010837.333694-9-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240416010837.333694-1-zfigura@codeweavers.com>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
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
index 69f359241cf6..ae78425c87d1 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -508,6 +508,26 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
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
@@ -533,6 +553,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_kill(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
 		return ntsync_event_set(obj, argp);
+	case NTSYNC_IOC_EVENT_RESET:
+		return ntsync_event_reset(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 65329d15a472..657542107328 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -53,5 +53,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
+#define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
 
 #endif
-- 
2.43.0


