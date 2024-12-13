Return-Path: <linux-kselftest+bounces-23342-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD899F1620
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBC817A1C40
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 19:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C4D1F2C48;
	Fri, 13 Dec 2024 19:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ikwTkwuS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807FC1F12E7;
	Fri, 13 Dec 2024 19:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734118548; cv=none; b=gsv7/3RDNql2aCLp8paacFU06wlShJFOIjxf7GccL8qsC0LcWPHFY6xK2uHwBakuxqq5mDvQ4EvNCfWLxPWPDb5ukezw1sjBQISBvUChZR9Q9UMgVGaxnOSHXY+iIW7BDzOc+nEy3X8/EPIxzFyYB7vz0G67pdoVi4Spc3MyMOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734118548; c=relaxed/simple;
	bh=NUDKZ9TjeGOwdhCFevsS4lEjNSOBv8WxsAHCCB/vc4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/Pdwwes8RzkIr/8/Pq3TS48JMWuCEFQCm5XVnbQ8dDZlMcgPGGoe6sA3D34KT3zIHWwBcXbRQ7FNl75LAoo/IIT7pRNiYpYPfhFy97r+Sk5/WYYrZLQC94fx+Wx+aU/qBngTobTTslPovX2zp0oi56l+WdzMfg4CL4Fk2Y0dnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ikwTkwuS; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=J8ZClNoLKwZoxJ2V9LVSMIYqYi95EJYuFbNt4v4boLs=; b=ikwTkwuSXsEkCpKfbP7UbI85On
	20GgkPpoJw48d3Se3lOwwtn20U7On+ZXDWi8xJOQOG8jnOgbQMkpWCNOKFME6nalKgOAlveMrgpCh
	kGnUaNjCmUI8bwG/3ESUAsOSmIsg+r1TKH1A8NFUbH8mx3MnA1Sc9d9K+6ehhhGePJGCH6kq02ycr
	+tMV62MN0WDndz+s0U7ka2bWFEkkxDvNkqfyt+ma/YBhjx49/LTpgokOZ6IsJM1Ttgyz+i+r2R5Ii
	S5WLT3SSysDGle/BDOlVWmGGYsCxoY+ggRYeXT3gImZd01+zyvx0jDgn+TiTcMacQ+kMH7pAesxNt
	xoCJU6tw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tMBRv-00ASsZ-20;
	Fri, 13 Dec 2024 13:35:43 -0600
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
Subject: [PATCH v7 11/30] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Fri, 13 Dec 2024 13:34:52 -0600
Message-ID: <20241213193511.457338-12-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtPulseEvent().

This wakes up any waiters as if the event had been set, but does not set the
event, instead resetting it if it had been signalled. Thus, for a manual-reset
event, all waiters are woken, whereas for an auto-reset event, at most one
waiter is woken.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 8 ++++++--
 include/uapi/linux/ntsync.h | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index b31443aa9692..141ebe8a7d4f 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -534,7 +534,7 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
-static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp, bool pulse)
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
@@ -550,6 +550,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 	if (all)
 		try_wake_all_obj(dev, event);
 	try_wake_any_event(event);
+	if (pulse)
+		event->u.event.signaled = false;
 
 	ntsync_unlock_obj(dev, event, all);
 
@@ -605,9 +607,11 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
 	case NTSYNC_IOC_EVENT_SET:
-		return ntsync_event_set(obj, argp);
+		return ntsync_event_set(obj, argp, false);
 	case NTSYNC_IOC_EVENT_RESET:
 		return ntsync_event_reset(obj, argp);
+	case NTSYNC_IOC_EVENT_PULSE:
+		return ntsync_event_set(obj, argp, true);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index d74c4e4f93d8..9eab7666b8b9 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -50,5 +50,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
+#define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 
 #endif
-- 
2.45.2


