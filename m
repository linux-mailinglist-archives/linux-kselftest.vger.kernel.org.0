Return-Path: <linux-kselftest+bounces-4687-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA29C8557A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ACB6B2683B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4431468EF;
	Wed, 14 Feb 2024 23:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="CFdUGGkj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9AA145339;
	Wed, 14 Feb 2024 23:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954811; cv=none; b=e5GFkaDO2OFHtt8ht048vdgy2OfrXmkgNow3rg7QHaZwGMEB8qAplU2fq1ytyvc2DZDuFP/YaMdBAiQcF+7RT0K7trsC09UlorByvPfgORBtJLp5/bGq9rgq3kDwEozvP0pJO/RHb7EFcuEKbpWv4T92CND02KkpzvDkiHrL2O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954811; c=relaxed/simple;
	bh=ZiDY1OWbO8A0kyxcTCRHN/56efSCVGBgAzSPdarUcgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gt9zdVd22Jb3P3D/vGZW/aATriHxr9wqxTgDUPiEUTfWnKyTSOMrTHUQ1Pw19Y0iiYUl3p0z6cGUzn7qzdh201ptUrndAxgsqgHglfWaFf3BI/c8t0fJ0Vhew9fdeBdHo4FXLU+nSp51ccOopyOCctFW+A2GBPYZ50v+YM18kuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=CFdUGGkj; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=MxsYi41f9tZrdqx7LdjDj8QNEYN8tm/gWSuMV4y4n5k=; b=CFdUGGkjQyLXTB63BQqeAVx/nF
	OgHHDlxUvcWp7eyR0LFIOiW9KbDJpkZOmSWVx2nVdMmYXajdxxw9kWteTYttNqmhcDAKurOsmNoso
	I8T+8wXHVReHmp1ybHGZ6O2dpAai0UOhwik6mfxccoimLGc+SJy6fKym7I3sD4wnJojK1Zl3O3M1G
	7qX49a0WaEbm4Is2jzreGuZjdTcsZ19zxKS87PUiGsTWEtuJL8GEYnrV4zcHSNwP3mGvA4+LNCerr
	ZBnul6auuecHximlbnC66y/bUYuA14yrKgXnVTh9qFS0YivKHODLM00AmcmAgPs5uvoGJjLSN1MO0
	nmMhsyGg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP44-00GcSK-1d;
	Wed, 14 Feb 2024 17:53:20 -0600
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
Subject: [PATCH 10/31] ntsync: Introduce NTSYNC_IOC_EVENT_SET.
Date: Wed, 14 Feb 2024 17:52:45 -0600
Message-ID: <20240214235307.10494-1-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214233645.9273-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corresponds to the NT syscall NtSetEvent().

This sets the event to the signaled state, and returns its previous state.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 37 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/ntsync.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 2a21e7b0982a..bc24de02fd1c 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -456,6 +456,41 @@ static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 	return ret;
 }
 
+static int ntsync_event_set(struct ntsync_obj *event, void __user *argp)
+{
+	struct ntsync_device *dev = event->dev;
+	__u32 prev_state;
+
+	if (event->type != NTSYNC_TYPE_EVENT)
+		return -EINVAL;
+
+	if (atomic_read(&event->all_hint) > 0) {
+		spin_lock(&dev->wait_all_lock);
+		spin_lock_nest_lock(&event->lock, &dev->wait_all_lock);
+
+		prev_state = event->u.event.signaled;
+		event->u.event.signaled = true;
+		try_wake_all_obj(dev, event);
+		try_wake_any_event(event);
+
+		spin_unlock(&event->lock);
+		spin_unlock(&dev->wait_all_lock);
+	} else {
+		spin_lock(&event->lock);
+
+		prev_state = event->u.event.signaled;
+		event->u.event.signaled = true;
+		try_wake_any_event(event);
+
+		spin_unlock(&event->lock);
+	}
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
@@ -479,6 +514,8 @@ static long ntsync_obj_ioctl(struct file *file, unsigned int cmd,
 		return ntsync_mutex_unlock(obj, argp);
 	case NTSYNC_IOC_MUTEX_KILL:
 		return ntsync_mutex_kill(obj, argp);
+	case NTSYNC_IOC_EVENT_SET:
+		return ntsync_event_set(obj, argp);
 	default:
 		return -ENOIOCTLCMD;
 	}
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index b8cf503365ef..782057552483 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -48,5 +48,6 @@ struct ntsync_wait_args {
 #define NTSYNC_IOC_SEM_POST		_IOWR('N', 0x81, __u32)
 #define NTSYNC_IOC_MUTEX_UNLOCK		_IOWR('N', 0x85, struct ntsync_mutex_args)
 #define NTSYNC_IOC_MUTEX_KILL		_IOW ('N', 0x86, __u32)
+#define NTSYNC_IOC_EVENT_SET		_IOR ('N', 0x88, __u32)
 
 #endif
-- 
2.43.0


