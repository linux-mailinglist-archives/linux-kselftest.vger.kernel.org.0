Return-Path: <linux-kselftest+bounces-48140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7E4CF1374
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 19:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 400CD30088B1
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 18:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289D30F548;
	Sun,  4 Jan 2026 18:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PD4H8B+x"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5715E288C26
	for <linux-kselftest@vger.kernel.org>; Sun,  4 Jan 2026 18:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767552128; cv=none; b=Ke06DUR5cPDA2uSz+oCJMvLFgEdfr1X/6s5Tw3SOa77xmx8FnFAehb+fB2ksKz7E2YCR73W2iuMMRXyuc3STjq8ohPxeAL4AiOM7LXiHxROUSdUBHYupYD3YrSFnwuQhENIc1KNFFeTU7vRLeILZUSoTNBriokg83x4V8+1AOok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767552128; c=relaxed/simple;
	bh=Rne9OenFktgXKd2Im5X8TmkYvMetTiWE8HD7UVp+a2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SLKFPiUSDqpeAjCcB86E18MSH0bDVQncKyp4bME3ghllDbhScAQ8Ik5SRKn3wwK/0b/KCdo5YXnoiuFIjeKLRGgO+ib5YSBcxcTJfXOpfNxJjHmMrSVIFZxiUidaPAhIPLD3XBq6PHJj95HRYoDaO0ZmrjmbbRAgvzWSYGwRzjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PD4H8B+x; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a099233e8dso112601125ad.3
        for <linux-kselftest@vger.kernel.org>; Sun, 04 Jan 2026 10:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767552126; x=1768156926; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yMN7Y5N+F4OSqpZa8xhlO1pyo5Mfe7uJut7gn4eIGGY=;
        b=PD4H8B+xHGWV9WpmPgvzIqlEsyZhwemaNpDcaqqc9XpyL26Mlvy5bgNLieHES9BqRc
         kqebjE6To0Ht2KzcxUFGCDf8c838a7mGQSv0ofFrLytQWFL4/7zAy3xCEMff0JjyC3DA
         o8PcagspRBBIx05yi8Xfvf3OD/uzgiHaVY0kotYdBvSLhAqCpEcgeOfZ0ul6fzQspfbO
         M9VG7KvEEpiyNxZtRJs01XcTpQB9j80hA7U9zj5H31x6zpKVwTXQuDKAYmqpqNy9HMP+
         w2OqeAl3WztpFnUiNGhg0N2x3JIaZKxrFj9MJYqQFZSXpwcKUG2L/ef+OERV1aH9MpYg
         r1Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767552126; x=1768156926;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yMN7Y5N+F4OSqpZa8xhlO1pyo5Mfe7uJut7gn4eIGGY=;
        b=EaQjcnzpz2B5240qv8K4AJ77NWoqyEa8kUpg95FkAENFeXMutjbdgeN4ikZxoIvero
         j8WGrK42nA4sGxqtiSxIU7GpqUtQiEr1OWobcOO5ADoAs/AuI3T1/foQzvcEYAjAWl5z
         0/ROICPBvVT1E4QtpKVYHzYm2iTL1zqVyLUD8h9yI/7YOBKcKXYDUCdGfWFtcuzuv5L3
         mATdfSUQ/1reMoyCoczgneZZABVtlETrdP/6PuPRH5dMKvcD7kZ7FYKzMsu+vQoNasYO
         5vEqWw9Ay2WMw9ceaQMo68FMu+C+rXF/Ov4/wHOgAXEvQskqLyxqAgggd0foYGSnD/wv
         1YtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOyi7RI/7Asg8A67BUw4dTIgvdbTE2MlIIVqqh+zDrUijakrzodLYDE+pDGCd4IxLQqLwxVlJfysSojeI0UgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvAp/+ct0AL4R5ezwRiJb9S1tflh+PpsFpJ+5ArFzzT4ncCGoJ
	rZ4T3K9Q4x3xIv6XQB3sV2IMxsw0XDtgusKmtRtPqQZyeHYtRQxbHYjD
X-Gm-Gg: AY/fxX7Lr9UBhlJKklSwPmQOi3NyinehBE+tRKMbPgSzL5BC3Hpz4aYU/9tcNnKyblp
	QBp+CxKsqmnrmvn25cqFinhUDICA0ecCKPSYE/gaAyFoJjLpN5WspuBJG9ClE5b89E+tU+xi2TR
	ZVxDEoJdfDMyY+/7mDWrnMUmqIa8OV+g/UGnu86U9zSxikVbVmIpTZQS23PKtf23JUN3mywf+a5
	8rTZFnj9zLmXyzoxJBMbY64lfS9C/buDGVoKk5EpgHStOLOphUiv7kT9O1g3jibj32Xn/iXLD9E
	e1Fakwv0UCZOtolO6L3LRGgKJ+kQExNH4Qd0iQ//gELv7cYLIm+x3v6pcp+7TBwCWhsGq65AqO7
	hOZvfVBzhdv2xhgbHa6iluR5tb1cjYL2Byw7VO0fO3upzwn9hg82cSdB3/fqyEJSeVC45hgoAu/
	B1P94cH9Ody8z4v5B3
X-Google-Smtp-Source: AGHT+IGXskVPcGTm924WxFu9BX5uvR5Jg0oTJC4tonpKGeHiLitwUWK9O7FFgK0Ro1T8HPRCIBb2HA==
X-Received: by 2002:a05:7022:6992:b0:11b:d6f2:a6d6 with SMTP id a92af1059eb24-121722eb8e6mr52895123c88.34.1767552126164;
        Sun, 04 Jan 2026 10:42:06 -0800 (PST)
Received: from [192.168.15.94] ([179.181.255.35])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217254c734sm170975553c88.13.2026.01.04.10.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 10:42:05 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 04 Jan 2026 18:41:15 +0000
Subject: [PATCH net-next v9 5/6] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260104-netcons-retrigger-v9-5-38aa643d2283@gmail.com>
References: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
In-Reply-To: <20260104-netcons-retrigger-v9-0-38aa643d2283@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767552086; l=6691;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Rne9OenFktgXKd2Im5X8TmkYvMetTiWE8HD7UVp+a2Y=;
 b=LvGxaQCn3OAjWyeq/IXZVPrtLUpW0uZIIYRXXnetqVaBOzkWx6f497hk2SAnQsBS30pfMuJGw
 Qg8g2n4SzbJBN0aImd9JGRzZREJ5UAsP5e/afUHQ+JDQq2oJr578JSV
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
 drivers/net/netconsole.c | 90 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 84 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 02a3463e8d24..489fef5c3407 100644
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
@@ -248,6 +255,67 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
 }
 
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
+	mutex_lock(&dynamic_netconsole_mutex);
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
+	mutex_unlock(&dynamic_netconsole_mutex);
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -270,6 +338,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
+	INIT_WORK(&nt->resume_wq, process_resume_target);
 
 	return nt;
 }
@@ -1442,13 +1511,14 @@ static int prepare_sysdata(struct netconsole_target *nt)
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
@@ -1477,6 +1547,13 @@ static int netconsole_netdev_event(struct notifier_block *this,
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
@@ -1945,6 +2022,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	cancel_work_sync(&nt->resume_wq);
 	netpoll_cleanup(&nt->np);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	kfree(nt->userdata);

-- 
2.52.0


