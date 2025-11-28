Return-Path: <linux-kselftest+bounces-46706-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 52FA3C933AD
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 23:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2992F34DF1D
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 22:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE3D2F39AB;
	Fri, 28 Nov 2025 22:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvR96LBC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4D2F12A7
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 22:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764367716; cv=none; b=OdCgZa5wBJVnnD4512V6UhHsswK8G6MzS2s5IBedMkSsRYX0WR5KuiPbwdvnHdVDJyAeb4N1P8yZTVkjXrBli5ZHLlzreEzf56vrvgS5nTaPFYUGYSbHGU+wtKuhOFa1Qo7PSTOmHkIj6W/OBQUvZiQRNdz5jS7dOzGoMyZ16bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764367716; c=relaxed/simple;
	bh=uRxi3ExLlnech7TAng7vW1n1AwVuV0imGtM6odd89oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rh5em1ABRssA0hbZXmG5Pk+nZ45n9Ujr8GT9SP4o2G17K56YL0Xz9uP9HmPVLHgG0hzjTR/dfOsV+5HBcCANXWnR1FtasDPVCWv4faqnrjPJIiVnKscbz6pFV4qF9dqRjWyt3sAlQGA6G6icaYE1WN4bCqn4QS3zur6nrrw6dS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvR96LBC; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bab7c997eeso2792754b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764367713; x=1764972513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qDEZdi1tgBa9T8trLOVAUVe2SLe1h53tBsuf6xYe7Gw=;
        b=OvR96LBCEuLEs9iorkIUlykmtzVgQZKMsTfp0lY38ObY/tNzfC5c7imFzwRpQPvK6R
         AikL4RQ5uCA7xW2ZAJvz2KEQAhdB6g1vj81edaGpNAciBDTHBdNyBIb9bhXt+JptWYmz
         jIVZL9AH7mj2ISVXowiHaOOGDDp2FojHW6r9/Uwik1FDIfzKqFxSICn94wJWPrAOdqDA
         p6yTXiWenkjOpUR4uxpnTo6/4tSku0BTfDhGEyyYWZ6jXXpd5s5KS854TEcsGk5FAkti
         ia30q87LvhiPkMTNcry2DmJYYtGmGjtYnpcnQNhb7x8TDL9HicRPbg3nuKu3TOiH6CdJ
         YNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764367713; x=1764972513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qDEZdi1tgBa9T8trLOVAUVe2SLe1h53tBsuf6xYe7Gw=;
        b=riChBodc27JWRx7zuGn0+m6GzbTj1/su1v4lvUebssXb0rB3v4rgB+VGXszzAoEGT6
         O8D4CKPZGSr7kpxJsxPm1b+9J+5sxQ6aJD4I7dChteth1nr59Zh/2GH6WZDXvQeppfGg
         VKBdYsRt+4cLQ1IG9WeKY3atMtYU3nJCdpO8zm2hHlvoJSy4vWXHq0eL/EzgSexqX1y4
         4GT7b0dhvc/hsY5901imd45yldAhkqWeH12Z5DhDjb+viT0dFZhZRvdMIBDqHSe3ofS4
         AnNWylHtXYaAb4dWHnqN9L7pp571lnQ8XNSsn4o/HLhHGj+QJSBHfqavOW0ObSJtCYcP
         PQUg==
X-Forwarded-Encrypted: i=1; AJvYcCWX4XMzf6D6P8hosathiKSv0vCm/GJotloGXQK7Odi85DfIgv0e279DmJWPRbKRLPbEqgzpU+5NSMu6VYQKrBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlfAvwiwbv6NqZRWrS6v+8k2HKaBME5rcgRMTa7IQEG0YJwxhJ
	HOW0vU247O0W7oqaf7LF4v2baLf0IqjzHwFAkk1+CmylYE8TVWBmfMdr
X-Gm-Gg: ASbGnctnYB765bHMp2z2doy5EguP6ON1HX88azxmeAeW9Ub4IgcLwKdznnUMkxqXiJN
	y0CtYlvJK0of2+1O0zRUQXjpo/vE6T7Fan14rLjNZzbheAMuSa1wPt0z0WaF2RKGPalCOCZ+7Wc
	aC9E78yWFpGTdei92NS/Bh91hQa5+Y52IUtGFj3NW+1BrSeFdmET/H0FPY2uV+kf2CdtnfG50hc
	enzYODqHK0OjMYI/gLABFDXB4yW4IihHxzG4pkv5JJccsm4lXybs8U43SrSe3QXJBRVOayWbUbD
	aJcxMw2Z5YKbZm18PuMctmtvx9iZnQ9zPcLc84ucdWRj/jJBUgRR6vvdkbx10qlxw6a5d04aZsQ
	HB+4ZcL+Cvg0g6bJTjH/3ABKLHWK9Fo+Sl1bBETUx8oT9MKRH+0GlqqFSrIErF2X1lhnGDPdklM
	kj85h0fVel/PIj8jmP3w==
X-Google-Smtp-Source: AGHT+IFA9W0tMqiQpDtVLv/EbbD8yYhv0beq+7UKoKsKuyIshhuFT7CV1u/tP795KYKT7Al+rnAVxw==
X-Received: by 2002:a05:7022:e19:b0:119:e569:f262 with SMTP id a92af1059eb24-11c9d7185c7mr23676868c88.11.1764367713091;
        Fri, 28 Nov 2025 14:08:33 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaee660asm26824205c88.3.2025.11.28.14.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 14:08:32 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 28 Nov 2025 22:08:03 +0000
Subject: [PATCH net-next v8 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netcons-retrigger-v8-4-0bccbf4c6385@gmail.com>
References: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
In-Reply-To: <20251128-netcons-retrigger-v8-0-0bccbf4c6385@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764367687; l=6908;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=uRxi3ExLlnech7TAng7vW1n1AwVuV0imGtM6odd89oA=;
 b=w3CNQpU1d93HMFlJIEbcCmw4xQefnx6kAgjeL7PNL7v2SW3IdsAcZMJzYuuaAGa0ZVkmwlMrp
 ISLZAq7BdS8C3Vvg3+B6oERZ7/3BwR4XG2LEP4vPgdYbEeUCcO8Xgcb
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_REGISTER) or when it changes name
(NETDEV_CHANGENAME) by calling netpoll_setup on the device.

Depending on how the target was setup (by mac or interface name), the
corresponding field is compared with the device being brought up. Targets
that match the incoming device, are scheduled for resume on resume_wq, so
that netpoll_setup is able to force the device UP.

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 98 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..b31762f2ee45 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -39,6 +39,7 @@
 #include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 #include <linux/rtnetlink.h>
+#include <linux/workqueue.h>
 
 MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -138,10 +139,14 @@ enum target_state {
  * @stats:	Packet send stats for the target. Used for debugging.
  * @state:	State of the target.
  *		Visible from userspace (read-write).
- *		We maintain a strict 1:1 correspondence between this and
- *		whether the corresponding netpoll is active or inactive.
+ *		From a userspace perspective, the target is either enabled or
+ *		disabled. Internally, although both STATE_DISABLED and
+ *		STATE_DEACTIVATED correspond to inactive targets, the latter is
+ *		due to automatic interface state changes and will try
+ *		recover automatically, if the interface comes back
+ *		online.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (state == STATE_DISABLED).
+ *		runtime only when it is disabled (state != STATE_ENABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -155,6 +160,7 @@ enum target_state {
  *		local_mac	(read-only)
  *		remote_mac	(read-write)
  * @buf:	The buffer used to send the full msg to the network stack
+ * @resume_wq:	Workqueue to resume deactivated target
  */
 struct netconsole_target {
 	struct list_head	list;
@@ -177,6 +183,7 @@ struct netconsole_target {
 	struct netpoll		np;
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
+	struct work_struct	resume_wq;
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -242,6 +249,75 @@ static void populate_configfs_item(struct netconsole_target *nt,
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
+}
+
+/* Attempts to resume logging to a deactivated target. */
+static void resume_target(struct netconsole_target *nt)
+{
+	int ret;
+
+	/* check if target is still deactivated as it may have been disabled
+	 * while resume was being scheduled.
+	 */
+	if (nt->state != STATE_DEACTIVATED)
+		return;
+
+	if (bound_by_mac(nt))
+		/* ensure netpoll_setup will retrieve device by mac */
+		memset(&nt->np.dev_name, 0, IFNAMSIZ);
+
+	ret = netpoll_setup(&nt->np);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+		return;
+	}
+
+	nt->state = STATE_ENABLED;
+	pr_info("network logging resumed on interface %s\n", nt->np.dev_name);
+}
+
+/* Checks if a deactivated target matches a device. */
+static bool deactivated_target_match(struct netconsole_target *nt,
+				     struct net_device *ndev)
+{
+	if (nt->state != STATE_DEACTIVATED)
+		return false;
+
+	if (bound_by_mac(nt))
+		return !memcmp(nt->np.dev_mac, ndev->dev_addr, ETH_ALEN);
+	return !strncmp(nt->np.dev_name, ndev->name, IFNAMSIZ);
+}
+
+/* Process work scheduled for target resume. */
+static void process_resume_target(struct work_struct *work)
+{
+	struct netconsole_target *nt =
+		container_of(work, struct netconsole_target, resume_wq);
+	unsigned long flags;
+
+	/* resume_target is IRQ unsafe, remove target from
+	 * target_list in order to resume it with IRQ enabled.
+	 */
+	spin_lock_irqsave(&target_list_lock, flags);
+	list_del_init(&nt->list);
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	resume_target(nt);
+
+	/* At this point the target is either enabled or disabled and
+	 * was cleaned up before getting deactivated. Either way, add it
+	 * back to target list.
+	 */
+	spin_lock_irqsave(&target_list_lock, flags);
+	list_add(&nt->list, &target_list);
+	spin_unlock_irqrestore(&target_list_lock, flags);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -264,6 +340,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
+	INIT_WORK(&nt->resume_wq, process_resume_target);
 
 	return nt;
 }
@@ -1434,13 +1511,14 @@ static int prepare_sysdata(struct netconsole_target *nt)
 static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
 {
-	unsigned long flags;
-	struct netconsole_target *nt, *tmp;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netconsole_target *nt, *tmp;
 	bool stopped = false;
+	unsigned long flags;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
+	      event == NETDEV_REGISTER))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1469,6 +1547,13 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if ((event == NETDEV_REGISTER || event == NETDEV_CHANGENAME) &&
+		    deactivated_target_match(nt, dev))
+			/* Schedule resume on a workqueue as it will attempt
+			 * to UP the device, which can't be done as part of this
+			 * notifier.
+			 */
+			schedule_work(&nt->resume_wq);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1937,6 +2022,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	cancel_work_sync(&nt->resume_wq);
 	netpoll_cleanup(&nt->np);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	kfree(nt->userdata);

-- 
2.52.0


