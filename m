Return-Path: <linux-kselftest+bounces-4696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF208557C8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B4CB2AB22
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B201D14901A;
	Wed, 14 Feb 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="FkwuwuiO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C741487FA;
	Wed, 14 Feb 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954819; cv=none; b=igYhffPJgUKXYBbs+v/21JlRZrx4KYkqwRajUEwfdRH4hQ0V0mxIGlN7J9wbkV5XrtjvjNiSIA1D5iVZPK+O6H23QcCfPCGiAoHbE4ZrmZCRF6726TqTRhOErLcoBDiF05WIOZZT4a7My9ro70a+mQDmqcQyZSgxfH6Cm0ihP44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954819; c=relaxed/simple;
	bh=aBdrEJ9OoB7TRKIOn6djUqNQcuFcE/19mZ3vUSewMWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jyiF7WHzhiHUK1XtFHEAWq8C5Yf0N32gRmViPxIZbebK0pPGVCpVi9PC/PFnIoH0LFzRAaCPTQg0py/EwPyJswWmn5ydaPmFoRBD5rJ+7py7rhp86t+BsC10hGzixD0T7JmZTe2glKIHVyZl8j6N0rN3lYp3Yhj09uLQNKEyugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=FkwuwuiO; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=38M0BRywykSfrPjqrIMMa7pA+nqCF6Vo5IqJFLs5TlI=; b=FkwuwuiO3cvXXaJgkbKStjEbOa
	CPxS+dprY1NOaHTBE4HePTIl41Lf2/oSkyR0j33yTzzBAIOm400uc6aR0VYfiCNLha7j9n4+xhvjn
	ucFQ9SFztf8htvJFg31Wq7MvvikBSvSOwGPNcWYOzrNZxwESKxbvWAkNZR0/nvLPmmcHwLrbFPfyz
	HEwUza1kfrl6ivN6DkYT8vbXu/2E9bZdZ76LUQX5W7QPCZHhCpdU3UpS1bCADVHlv+sJ/BVOZH397
	WOI6kYpdfo9r2PdXKyaEGvwBQTtQkVb1d3kCtQmaSCTe4QwHeqwLxnU4WxSnlsawn2gB1hNoKYJJR
	9S69igyg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4H-00GcSK-2B;
	Wed, 14 Feb 2024 17:53:33 -0600
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
Subject: [PATCH 17/31] ntsync: Allow waits to use the REALTIME clock.
Date: Wed, 14 Feb 2024 17:52:52 -0600
Message-ID: <20240214235307.10494-8-zfigura@codeweavers.com>
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

NtWaitForMultipleObjects() can receive a timeout in two forms, relative or
absolute. Relative timeouts are unaffected by changes to the system time and do
not count down while the system suspends; for absolute timeouts the opposite is
true.

In order to make the interface and implementation simpler, the ntsync driver
only deals in absolute timeouts. However, we need to be able to emulate both
behaviours apropos suspension and time adjustment, which is achieved by allowing
either the MONOTONIC or REALTIME clock to be used.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 9 ++++++++-
 include/uapi/linux/ntsync.h | 4 ++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index 0773602cc86d..496704268603 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -765,11 +765,15 @@ static void put_obj(struct ntsync_obj *obj)
 static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_args *args)
 {
 	ktime_t timeout = ns_to_ktime(args->timeout);
+	clockid_t clock = CLOCK_MONOTONIC;
 	ktime_t *timeout_ptr;
 	int ret = 0;
 
 	timeout_ptr = (args->timeout == U64_MAX ? NULL : &timeout);
 
+	if (args->flags & NTSYNC_WAIT_REALTIME)
+		clock = CLOCK_REALTIME;
+
 	do {
 		if (signal_pending(current)) {
 			ret = -ERESTARTSYS;
@@ -781,7 +785,7 @@ static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_ar
 			ret = 0;
 			break;
 		}
-		ret = schedule_hrtimeout(timeout_ptr, HRTIMER_MODE_ABS);
+		ret = schedule_hrtimeout_range_clock(timeout_ptr, 0, HRTIMER_MODE_ABS, clock);
 	} while (ret < 0);
 	__set_current_state(TASK_RUNNING);
 
@@ -804,6 +808,9 @@ static int setup_wait(struct ntsync_device *dev,
 	if (!args->owner)
 		return -EINVAL;
 
+	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
+		return -EINVAL;
+
 	if (args->count > NTSYNC_MAX_WAIT_COUNT)
 		return -EINVAL;
 
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 7c91af7011e4..074f26423426 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -28,6 +28,8 @@ struct ntsync_event_args {
 	__u32 signaled;
 };
 
+#define NTSYNC_WAIT_REALTIME	0x1
+
 struct ntsync_wait_args {
 	__u64 timeout;
 	__u64 objs;
@@ -35,6 +37,8 @@ struct ntsync_wait_args {
 	__u32 owner;
 	__u32 index;
 	__u32 alert;
+	__u32 flags;
+	__u32 pad;
 };
 
 #define NTSYNC_MAX_WAIT_COUNT 64
-- 
2.43.0


