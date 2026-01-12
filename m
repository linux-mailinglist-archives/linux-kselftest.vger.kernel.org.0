Return-Path: <linux-kselftest+bounces-48731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B480AD11933
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E79623103186
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C526C34C811;
	Mon, 12 Jan 2026 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MdIela76"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB5134A3DB
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210877; cv=none; b=GmtKaDlUVI3N4ewtDliL976/D7//LSkGYFfruKPuCewfNbRvT3Pl/yS0G1HwjbZNKuZAPIhD2kzh55NpNtYlpmPzRB02H+v8lHuGfGOS6E/+qnmblAFIMtucsgX/EUSjhXg5qSknP2nKEf5c9tOKugQRvCQE8PyBaRFeb4ouiCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210877; c=relaxed/simple;
	bh=r1PE8fDi2fMuVloDtOFpaMYOvsXBjkenyxTGboQyEIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5UDjLFlJMTSv31Fh/QsWf+V8GDUqPnqQfd2czugkcavgFgLFeEzMIIeHVvbuLH2ke/4CZ/D9CXNKF/PUv+J7ge/WDKv4bgpzbb6t3NiCsdtHD1pwtLfngAnmEs0m6xqRzdMQQWL5xbar+tknPGHmDKjcQak3VMYUGVNSfoRxH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MdIela76; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b86ed375d37so234229966b.3
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210872; x=1768815672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpQJfNEVMidDJUe69qz1mLAVV7hXmHzYrjKAzwHkdw4=;
        b=MdIela76AAT2CYlBY7Do6dqoG1sGrlbHvVwKqjsGpEEFWWL2ec/guT9pvBZLlHmFvW
         HqREKgrZpCuJA0lpfRyBJFA3kW7w2dS97I1QHHSaq2xeD0xEcQj3hcGvsqUNLPIUANhs
         OH2TomNRQapWIKHehocVcqazrRwyanuqquVAEpRxXCyX15NnwtjrpR/A2wv2XbXyPc2t
         o9kD9b8OtOV9uQFQhJxvd0Xmg8D2N4N3VvP7tK0ng/XHp3WxgQ+ubRUudO+7feb9GpDA
         JKT5NRcqtCqUGGSFOfYSR4dLOJCL7eUPXT1L+6Lm2VCz9kyW4spGP6dM45T7vuXMU6Da
         hI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210872; x=1768815672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qpQJfNEVMidDJUe69qz1mLAVV7hXmHzYrjKAzwHkdw4=;
        b=xH5MeElJFCl03/ki8wO4Eht1y1dTXy9TwqIrABZSfzfj0Bn4LCoKLhWLhL79Kkg38k
         0S4fvlNlfD4wTakFEo0Gfj8RDewWL9BYX4sGSODz9fRgz0SHTOAi00QBDr7X/3euRBe6
         GNhQoVHGK/Xh95r4lddTNDwJIF4hYiNSYtpf0HHLzOTFgY457VomhlztYHgH5WLK8zlB
         Z+UT49+IZUflIQ/tL1U3d2qMj9qbDPR5AgL0uXosN/gGVTAsE3IcVA0f4MqktJBI691U
         2ASReegPry/qgEzUcRrtrtS3DeoWIjI+UJxLfq1oXlcUcdZyk5ahhf5AGicxhtBh6zx/
         UnCg==
X-Forwarded-Encrypted: i=1; AJvYcCU0rbJjIf4VOJfM/HqoEog6ngrWPzMPBfg1igClKb44kNjegBhtrJACzS1WgeVltZEIBA76Fc1HUt/QT+l6mms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOND7wo2bUFWMpDmDROB52ej48NO5r7cu7/Sy1TnhKj4f57+3F
	3/iaIFm4KqF9ke5yZ/9GxKeUOjG+csQy9kWVJT7d32g7utOtJnVcF//1
X-Gm-Gg: AY/fxX7+RpC8NGrE1mHJSRyovNIWTuH63HY+5lTdl7c+ho7L2Ilj5J/qPgdQassHa3J
	lD0XwkPoc6LsOy3CJw3qX/orbX+mhM0QTa06jsdS67943FpEMQqwSEv4PsvxN0nfzmTKXlet1xd
	MiVw/HcUqKSD3eu3MQTcI3Tz8kVOKtlb3KWFF8M36456VOa2LpGFyLpesDxkJy82P/Hi99vFdH4
	5jA/xROxDhp0z/aelaOxNVBB+PkR9NwU0FayAgzkkl/5LJdFSzfT/k+2ReES8d/VyZQseLdKiOQ
	l3dqnFo1qbYkKVhaDHpGVsv6a5ULcXwORL2nTUCGlmXnEVn941hGxbVGzWKpPQcr9FBOHTgXfks
	GqojQdUiAyPXPt5Ur3l1p75Xy82u33TQ19U7pgDyvWH2OQ4SkN8tcyOdD8uDRqOubEVSR6A6452
	zO1Aqkj00GxRJ+Ew==
X-Google-Smtp-Source: AGHT+IElBQj5xgjZNMo/SofYr/1zC1dX3E6h9qPiSNrkW8u9b+CtK0Wwh85R4DKfzUJZlEY4evhbpA==
X-Received: by 2002:a17:907:7296:b0:b87:19af:3e4d with SMTP id a640c23a62f3a-b8719af3f43mr222160266b.22.1768210872003;
        Mon, 12 Jan 2026 01:41:12 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:11 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:57 +0000
Subject: [PATCH net-next v10 6/7] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-6-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=9836;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=r1PE8fDi2fMuVloDtOFpaMYOvsXBjkenyxTGboQyEIM=;
 b=tykV62ht+/NiUPNuK/wlUckVAa0RQviGHV/WkPVe4u48D/s+YWg1B9nXIYN2GmqgkfDVaS32h
 Y2P853khVqeA/P1AgbM6gR77O8MH5vX45ikblNlYA393q3X5EDq9Ewx
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_REGISTER) or when it changes name
(NETDEV_CHANGENAME) by calling netpoll_setup on the device.

Depending on how the target was setup (by mac or interface name), the
corresponding field is compared with the device being brought up. Targets
that match the incoming device, are scheduled for resume on a workqueue.

Resuming happens on a workqueue as we can't execute netpoll_setup in the
context of the netdev event. A standalone workqueue (as opposed to the
global one) is used to allow for proper cleanup process during
netconsole module cleanup as we need to be able to flush all pending
work before traversing the target list given that targets are temporarily
removed from the list during resume_target.

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 127 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 120 insertions(+), 7 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 46d990f3d904..82c232f9ede2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -39,6 +39,7 @@
 #include <linux/u64_stats_sync.h>
 #include <linux/utsname.h>
 #include <linux/rtnetlink.h>
+#include <linux/workqueue.h>
 
 MODULE_AUTHOR("Matt Mackall <mpm@selenic.com>");
 MODULE_DESCRIPTION("Console driver for network interfaces");
@@ -85,6 +86,8 @@ static DEFINE_SPINLOCK(target_list_lock);
 /* This needs to be a mutex because netpoll_cleanup might sleep */
 static DEFINE_MUTEX(target_cleanup_list_lock);
 
+static struct workqueue_struct *netconsole_wq;
+
 /*
  * Console driver for netconsoles.  Register only consoles that have
  * an associated target of the same type.
@@ -138,10 +141,14 @@ enum target_state {
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
@@ -155,6 +162,7 @@ enum target_state {
  *		local_mac	(read-only)
  *		remote_mac	(read-write)
  * @buf:	The buffer used to send the full msg to the network stack
+ * @resume_wq:	Workqueue to resume deactivated target
  */
 struct netconsole_target {
 	struct list_head	list;
@@ -177,6 +185,7 @@ struct netconsole_target {
 	struct netpoll		np;
 	/* protected by target_list_lock */
 	char			buf[MAX_PRINT_CHUNK];
+	struct work_struct	resume_wq;
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -267,6 +276,70 @@ static bool bound_by_mac(struct netconsole_target *nt)
 	return is_valid_ether_addr(nt->np.dev_mac);
 }
 
+/* Attempts to resume logging to a deactivated target. */
+static void resume_target(struct netconsole_target *nt)
+{
+	if (netpoll_setup(&nt->np)) {
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
+	struct netconsole_target *nt;
+	unsigned long flags;
+
+	nt = container_of(work, struct netconsole_target, resume_wq);
+
+	dynamic_netconsole_mutex_lock();
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	/* Check if target is still deactivated as it may have been disabled
+	 * while resume was being scheduled.
+	 */
+	if (nt->state != STATE_DEACTIVATED) {
+		spin_unlock_irqrestore(&target_list_lock, flags);
+		goto out_unlock;
+	}
+
+	/* resume_target is IRQ unsafe, remove target from
+	 * target_list in order to resume it with IRQ enabled.
+	 */
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
+
+out_unlock:
+	dynamic_netconsole_mutex_unlock();
+}
+
 /* Allocate and initialize with defaults.
  * Note that these targets get their config_item fields zeroed-out.
  */
@@ -289,6 +362,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
 	nt->state = STATE_DISABLED;
+	INIT_WORK(&nt->resume_wq, process_resume_target);
 
 	return nt;
 }
@@ -1353,13 +1427,29 @@ static struct config_group *make_netconsole_target(struct config_group *group,
 static void drop_netconsole_target(struct config_group *group,
 				   struct config_item *item)
 {
-	unsigned long flags;
 	struct netconsole_target *nt = to_target(item);
+	unsigned long flags;
+
+	dynamic_netconsole_mutex_lock();
 
 	spin_lock_irqsave(&target_list_lock, flags);
+	/* Disable deactivated target to prevent races between resume attempt
+	 * and target removal.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
 	list_del(&nt->list);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 
+	dynamic_netconsole_mutex_unlock();
+
+	/* Now that the target has been marked disabled no further work
+	 * can be scheduled. Existing work will skip as targets are not
+	 * deactivated anymore. Cancel any scheduled resume and wait for
+	 * completion.
+	 */
+	cancel_work_sync(&nt->resume_wq);
+
 	/*
 	 * The target may have never been enabled, or was manually disabled
 	 * before being removed so netpoll may have already been cleaned up.
@@ -1461,13 +1551,14 @@ static int prepare_sysdata(struct netconsole_target *nt)
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
@@ -1496,6 +1587,13 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if ((event == NETDEV_REGISTER || event == NETDEV_CHANGENAME) &&
+		    deactivated_target_match(nt, dev))
+			/* Schedule resume on a workqueue as it will attempt
+			 * to UP the device, which can't be done as part of this
+			 * notifier.
+			 */
+			queue_work(netconsole_wq, &nt->resume_wq);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1964,6 +2062,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 /* Cleanup netpoll for given target (from boot/module param) and free it */
 static void free_param_target(struct netconsole_target *nt)
 {
+	cancel_work_sync(&nt->resume_wq);
 	netpoll_cleanup(&nt->np);
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	kfree(nt->userdata);
@@ -2018,6 +2117,12 @@ static int __init init_netconsole(void)
 		}
 	}
 
+	netconsole_wq = alloc_workqueue("netconsole", WQ_UNBOUND, 0);
+	if (!netconsole_wq) {
+		err = -ENOMEM;
+		goto fail;
+	}
+
 	err = register_netdevice_notifier(&netconsole_netdev_notifier);
 	if (err)
 		goto fail;
@@ -2040,6 +2145,8 @@ static int __init init_netconsole(void)
 fail:
 	pr_err("cleaning up\n");
 
+	if (netconsole_wq)
+		flush_workqueue(netconsole_wq);
 	/*
 	 * Remove all targets and destroy them (only targets created
 	 * from the boot/module option exist here). Skipping the list
@@ -2050,6 +2157,9 @@ static int __init init_netconsole(void)
 		free_param_target(nt);
 	}
 
+	if (netconsole_wq)
+		destroy_workqueue(netconsole_wq);
+
 	return err;
 }
 
@@ -2063,6 +2173,7 @@ static void __exit cleanup_netconsole(void)
 		unregister_console(&netconsole);
 	dynamic_netconsole_exit();
 	unregister_netdevice_notifier(&netconsole_netdev_notifier);
+	flush_workqueue(netconsole_wq);
 
 	/*
 	 * Targets created via configfs pin references on our module
@@ -2076,6 +2187,8 @@ static void __exit cleanup_netconsole(void)
 		list_del(&nt->list);
 		free_param_target(nt);
 	}
+
+	destroy_workqueue(netconsole_wq);
 }
 
 /*

-- 
2.52.0


