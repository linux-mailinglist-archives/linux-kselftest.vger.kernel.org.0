Return-Path: <linux-kselftest+bounces-4952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B32A85AEAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 23:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26F721F225E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4C056B6D;
	Mon, 19 Feb 2024 22:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="VhJmEACI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E634655E6A;
	Mon, 19 Feb 2024 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708382379; cv=none; b=h0jaJ/jPMqe2gAIokWMpsuEIty+cHyRnTD+eUax6JOUXXI1csp0U9rB7qmqb6f+Lq4n31M0eg34IPJCJE7+IV5qUlllyLmbvg2+oWtcKORXv9H/4Oz4zQCe0udpKVYJhOUguCZpenR5eSBzF+YETr3Ie4jJWrnYQn9lbEheMcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708382379; c=relaxed/simple;
	bh=7fJ6tEVjQ//DMRv80I4Gvuw3MluKYB52RJIgE3rpH1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UarDRhwak+/51LWrqfZ21UWlWRyLHVReBjdLiu7q/6HC084WDZuFY+VP9f41x8Svo+Fpu4191aTpuJ/436LUTJEmCmgoKqPLULitElVuvSaJVQWFG/zrwNSWM3YcAx1316eacAJNto8+i2+zA/4Un5ylmnGzKm2qhqOhOxgvk5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=VhJmEACI; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=ZaTIvinKwnA9UOjIwRZ0J2/EfkQks0gyNSQlfU0+6jg=; b=VhJmEACI8232Id/lDusYTQzNaU
	Am36gNLPUGtod/W92H6TKcbMl+dWkljg56jz7Hm+kprGb61G43k36pxkAKbQxALm/SFR+pKH9obQg
	1MEs3nQmWsckZLlt48XIdQ4NvC4v+/d7x5fW8dhyOikdIn8V6YWTOfXKsgZ1ksR0fEK1lSF8oszH9
	6bV58n3ENA6eh56swceubCBHZDo+vYwEu5BRpvIRV29Vhggva5szRVUR39+70jFYoQCAd0bzHXE6O
	5RQYmkRrq/rdMj8WHfyZEXkKy7aIcpG4eJHF+NlYXZNt7+RqM4BK2RxSiHCvRJZq59/osNfOaRwsC
	ovOtl+Iw==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rcCIN-0037Oz-1m;
	Mon, 19 Feb 2024 16:39:31 -0600
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
Subject: [PATCH v2 17/31] ntsync: Allow waits to use the REALTIME clock.
Date: Mon, 19 Feb 2024 16:38:19 -0600
Message-ID: <20240219223833.95710-18-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240219223833.95710-1-zfigura@codeweavers.com>
References: <20240219223833.95710-1-zfigura@codeweavers.com>
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
index 0055b4671808..f54c81dada3d 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -778,11 +778,15 @@ static void put_obj(struct ntsync_obj *obj)
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
@@ -794,7 +798,7 @@ static int ntsync_schedule(const struct ntsync_q *q, const struct ntsync_wait_ar
 			ret = 0;
 			break;
 		}
-		ret = schedule_hrtimeout(timeout_ptr, HRTIMER_MODE_ABS);
+		ret = schedule_hrtimeout_range_clock(timeout_ptr, 0, HRTIMER_MODE_ABS, clock);
 	} while (ret < 0);
 	__set_current_state(TASK_RUNNING);
 
@@ -817,6 +821,9 @@ static int setup_wait(struct ntsync_device *dev,
 	if (!args->owner)
 		return -EINVAL;
 
+	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
+		return -EINVAL;
+
 	if (args->count > NTSYNC_MAX_WAIT_COUNT)
 		return -EINVAL;
 
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 555ae81b479a..b5e835d8dba8 100644
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


