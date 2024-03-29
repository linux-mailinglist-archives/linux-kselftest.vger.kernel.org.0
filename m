Return-Path: <linux-kselftest+bounces-6799-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09302890F42
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7AC428BA68
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C5747F;
	Fri, 29 Mar 2024 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ZfhQRNvN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A321E885;
	Fri, 29 Mar 2024 00:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671821; cv=none; b=Lq0AseuYQ6N9PZp3TGeC5fshz/PQMekG0Rr2+GFOTJc5TIhGeKVHmy8557Ar+amJtrtYUVzyzaK2SEzZ1GciaP1jy0CAF45aJc/B9SMhygv9+LIQ/92NfdkPIxkC1v4qJL92gtys9uScut4ZCWYbzQifVBYnznW6I4cQlO3qqUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671821; c=relaxed/simple;
	bh=CXhiKahb0eDgSiGeD4X7ssoSM82vjMLS/jKkCaqodDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xh00rTVLnby4ubgZJqGgZiNMZckKfbAX5QrrcaZdP3470zUY6BIBKmlY7dWJ62M4DDJkfqfrHhitMsNWbkOOU/weGXDBW/1aTvXp7O7Is9T7Jt739k9BZ3/OFhNIwZInXGmanzduoeW+OspjcHFzzxo/iwDRiPu/FYrCMG5yGns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ZfhQRNvN; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=7IUzCTQo6Yc6I84GM6d0m/2enQYUr8L54oRJIiZTpag=; b=ZfhQRNvN/GPu2A+nUrbWUpu20u
	9Dw/DXMB+ySwDqT4QTO5GIdNUiTX0g+CQXZ3xVf3v9BBg5CWdcZ3ydziYZjFL7jtQBmlM2ntU4tbK
	4q4KaLx/mvRHhMS2Y9WqSIZifQfsTOQnQR4BFj7k/JEbDF3twCSJ4ESz8EUia42lCpH+blXnI8q8L
	auJ9kL1VkTXeipDT3yXMC/bGTLwKilW06NDX+RiYUAawvH192NR357tVIBpPP7BONCPlAEw9LDWih
	xuVKPHf84HjT8sjMxT19suNx8fDJ0S3te0oHXFobT4FF6kyv2z8lviKRlqUmIYMoVoa9qSYN2uX2f
	D9ZIXaKA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlN-000iik-2V;
	Thu, 28 Mar 2024 19:06:29 -0500
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
Subject: [PATCH v3 11/30] ntsync: Introduce NTSYNC_IOC_EVENT_RESET.
Date: Thu, 28 Mar 2024 19:06:02 -0500
Message-ID: <20240329000621.148791-12-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
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


