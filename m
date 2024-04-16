Return-Path: <linux-kselftest+bounces-8064-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA058A5FE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 03:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35D62283ED3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 01:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEF538FA1;
	Tue, 16 Apr 2024 01:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="mkZWxMp6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97166AB9;
	Tue, 16 Apr 2024 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713229833; cv=none; b=C3JXXs7hdqTXPnKEvc83yhSZvYPtZzneHudcc3wyFl+HLG/yjVI5QytB0NF7IFAHnxwtQDlt+8Vz21pRnXsJtbzHFI+gjMybXEpgkB1GYNxZCIMl5UwaifMb9y7giGDfQ950/4KNodDEq+Igd82Uytjdb2l2MhtBBnZKm6JpQlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713229833; c=relaxed/simple;
	bh=Qydx+3xcTvNeUCPGX/oOLNK9YJQeyBhE3gI1tli3A40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGarrVB6z6+zFWxSPi1a3lgG58ETY/ox/9ibVQEwoZtWu3wPmxuv0fpTDvMubNRlLO74vQPzdx8Y3UgWS8TGrHk/XOq1YW4xAysD4x8OzZrXjYJurjXW3Q6itaSTPn2eI/T0oH2rzq63cY4ciVsxAPkradk6zITRdv+PUSrGb5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=mkZWxMp6; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Zv8h2+szdhg9EDGHBccepteFUUaEkYh+pn7zKQTBoPE=; b=mkZWxMp6ZQe3hcvQHoWyFaI8i0
	KilzSPCNkod+ULoWOaDBLMFq1DbEjG9WUa9WLTXiTxbVx9CTDflkEFECLaBxqa3opX3Fz1Iuas7Kl
	mF0e0O/IqUo7eI/NKDfAnP8E766qXM/nGGpgnlcEVYUWkDXHvDc+T407tgU1H3JEedOj3IV1PApTZ
	d05iBcgt6PJjIsHMmmtaaYcjSgpZjTAGF41F3al+gngVXE9g41NZTXVfS4blS3xuGt8FZRjrF6w9X
	Z1A5ij1OIhv0TcgSAdn9GaOcVyfTOmFut1Kf0JqZlmPOzmStj87FKhdIn/s+uDVpTT3ozjGh2F6Tc
	0g1lVLKw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rwXL0-00FbQv-1I;
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
Subject: [PATCH v4 09/27] ntsync: Introduce NTSYNC_IOC_EVENT_PULSE.
Date: Mon, 15 Apr 2024 20:08:19 -0500
Message-ID: <20240416010837.333694-10-zfigura@codeweavers.com>
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

This corresponds to the NT syscall NtPulseEvent().

This wakes up any waiters as if the event had been set, but does not set the
event, instead resetting it if it had been signalled. Thus, for a manual-reset
event, all waiters are woken, whereas for an auto-reset event, at most one
waiter is woken.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 10 ++++++++--
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index ae78425c87d1..adba4657bf26 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -473,7 +473,7 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
-static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp, bool pulse)
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
@@ -489,6 +489,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		event->u.event.signaled = true;
 		try_wake_all_obj(dev, event);
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 		spin_unlock(&dev->wait_all_lock);
@@ -498,6 +500,8 @@ static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
 		prev_state = event->u.event.signaled;
 		event->u.event.signaled = true;
 		try_wake_any_event(event);
+		if (pulse)
+			event->u.event.signaled = false;
 
 		spin_unlock(&event->lock);
 	}
@@ -552,9 +556,11 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
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
index 657542107328..57721f5d31ba 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -54,5 +54,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
 #define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 #define NTSYNC_IOC_EVENT_RESET		_IOR ('N', 0x89, __u32)
+#define NTSYNC_IOC_EVENT_PULSE		_IOR ('N', 0x8a, __u32)
 
 #endif
-- 
2.43.0


