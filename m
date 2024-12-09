Return-Path: <linux-kselftest+bounces-23080-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B62C9E9F07
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 20:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24DB91616E2
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 19:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5137F19D082;
	Mon,  9 Dec 2024 19:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="hiYmEJgi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C553B19C561;
	Mon,  9 Dec 2024 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770978; cv=none; b=qspKqpe109QN/Sm4LYbHPLPHaMW3W1opR8p2fEPmTz4hu9rk4yFheeX46tMzmPpcRcF1l8ATvjt1h2VUeMMqiYJcRgZ0z49M7DobKb0raowVig9Zlfi8xkdlM2pi1HfD0LFErDk7EqoWG4etipoGKbVW3Zas6OkIRBdZm33DseI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770978; c=relaxed/simple;
	bh=7i5E4uFe34oquEMewE/pLncQW1byrNS5NnsfpLRwUo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKU6wNuFJleSRfFmY/dqJzM5TqVpZEt0CSorG1zpq1ZzoPS0jfjCcoLRkcec2SROjmeN7xt0vab7dhPKTF7n3pBcWFh7Svvjs8nnYs7yBRs6jLazZa+baRxDgkeCimUbHFb6VzuUsZvzYqdia7Xt50vg4iJfMmjRkxh4wY/PEU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=hiYmEJgi; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Content-Transfer-Encoding:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UpBPK/F1HsD4cQEIcsfdrWRgX1ty6ZDxQwnbUJGmyMA=; b=hiYmEJgi3E9BhoRAHMWzxVx4an
	RqS+294dbsQtgJXm8kfBuEOrCtunfFefLXVbDwoRTYah2bUv76XScq5mGxeOED/dZuaFuzKGsux9j
	zkKVmXR157GHmW4XI0DzXr5ZzUT6KKd8Jkb/rm6eOA4tecUWEQgcTepaX/at1ugDQYJUOP/wxVSuw
	nTM7y/uwZDdKE9pI6SBPpSeHNzclXkWMHyXzg32KoxstNpMAmSoo8H6mmGOAzZKHTjTgsIGYRWUH2
	FilzUNuBmGXGH7XmYxWYRf7P6xvMdu7Xr0CWlTjFjkOOhrDPNEisguSl+iCqG07XCnNYVHXH8VESR
	QAkDAlZA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1tKiya-001Gd5-2M;
	Mon, 09 Dec 2024 12:59:24 -0600
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
Subject: [PATCH v6 09/28] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Mon,  9 Dec 2024 12:58:45 -0600
Message-ID: <20241209185904.507350-10-zfigura@codeweavers.com>
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
index 092133699193..6b8352270874 100644
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
index 7fdf79729b20..5586fadd9bdd 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -53,5 +53,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
+#define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 
 #endif
-- 
2.45.2


