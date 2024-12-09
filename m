Return-Path: <linux-kselftest+bounces-23077-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91E39E9EF6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9888F1688D6
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F581991C8;
	Mon,  9 Dec 2024 19:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="EISCRrI1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F41990AE;
	Mon,  9 Dec 2024 19:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770970; cv=none; b=GseySMlRwxQ6Shzp6S40+kyZWncXSvVtVhE2pAY1SdECq8b6fa6Nkr7CcA/eY9cHjlXznjs89kLBrlX+OaGafEbbgXjtisHXOX+xmmewmkpIwBOkYtmcBuGh/VK8BhCOqx2w51MDyOj+2emlzlwT8YaxjAo/JTAdEaFh5Znvr1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770970; c=relaxed/simple;
	bh=4yOT8a3cRB0qPmY52n+VNg+UNalreY7d0UFkF/4P5FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qv7SHA1z7k7QBaEDAeZPMiXGmOCWIx+vYoD+VVscNAUO6XEr5XWgiQ3fGdlggeas2qWz6oZ/IFEpiCW32fmtc9Qx8kNHDCDuozoqStsoVo4vegLLSbaVFKcMWfWTJWeJQBggq775SK21InenwyWsjCjqWRPE0xD7+azkYiAlymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=EISCRrI1; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oqAQ/CwNvC8HZlzmlY8JFR6LjLHJED15lmj9ttZU4/g=; b=EISCRrI1pnaRvKYeLYpcEKr1tq
	u+u4lq5yGdcTDf4JSJQkNH5Vulc/ullAl1Rd3UIUaVbPiL7ZGOzqVEIIbU2vNWhEJO2QmUxliG2/J
	JSdzJirgkkbcGBtMYETS1L/RYx1IIRQprwj8SggQCbv/4rtPlMfifu3lxYlLzrAirISpSrR+SsLFg
	ANdE3ph3RTV5nLUm94PTUr9T/X6+Q5sW9Q6vbDq1JsSYRsCFaJhh7i5+CYYKiT6j6jTK/R5prWc3b
	51t4jju1LrG75QyeYDcJ2cPxePTK9LI2NQJzsyqmNl34GD+iYRamv6D2nHALHSm/ewXfWeNGJJlK+
	77hdUYJA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiyb-001Gd5-0f;
	Mon, 09 Dec 2024 12:59:25 -0600
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
Subject: [PATCH v6 12/28] ntsync: Introduce NTSYNC_IOC_EVENT_READ.
Date: Mon,  9 Dec 2024 12:58:48 -0600
Message-ID: <20241209185904.507350-13-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241209185904.507350-1-zfigura@codeweavers.com>
References: <20241209185904.507350-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 26 ++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index cff2627c1efe..5a5ee7b6ee92 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -633,6 +633,30 @@ static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
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
+	args.event = 0;
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
@@ -666,6 +690,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_event_reset(obj, argp);
 	case NTSYNC_IOC_EVENT_PULSE:
 		return ntsync_event_set(obj, argp, true);
+	case NTSYNC_IOC_EVENT_READ:
+		return ntsync_event_read(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index eced73d08783..74abeba832f7 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -56,5 +56,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 #define NTSYNC_IOC_SEM_READ		_IOR ('N', 0x8b, struct ntsync_sem_args)
 #define NTSYNC_IOC_MUTEX_READ		_IOR ('N', 0x8c, struct ntsync_mutex_args)
+#define NTSYNC_IOC_EVENT_READ		_IOR ('N', 0x8d, struct ntsync_event_args)
 
 #endif
-- 
2.45.2


