Return-Path: <linux-kselftest+bounces-49259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB40BD3945E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9F08302AAFF
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBBE32AAC2;
	Sun, 18 Jan 2026 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9nrEp5j"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C4E32AAA1
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734043; cv=none; b=nPNCclseTPuxkjt8pXd334+ccTXeotXR7CH2bPbmYwwQyhPZSgczt1PHN4786RRmSif8nPKfUhjqZhEE1v4RKhEZciy64IhDPFkE3hy5Lb205hf+XiQOy4Xh2PuL2BGNLb2NQQexFtzyIzAzIyRWectehqoMypFyQ4sgNGp6xrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734043; c=relaxed/simple;
	bh=r1PE8fDi2fMuVloDtOFpaMYOvsXBjkenyxTGboQyEIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YxrLK+48ZS2mx7rrSqBuUghM5OdpJYkOPJG4Z43dTElXWJsFs+4XcUo2W6Ke0uU9p0LoFwcKlzCSBwGw9HSsA79l+dNTEwriYe4/W9J1Vkb/ZiYmvddFsPWfsDnyzX9YBJdiRKH26Wm+rBAbnvO0CWlPs3/pKcOGAkvJOAqYfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9nrEp5j; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-432d2c96215so2803812f8f.3
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734035; x=1769338835; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpQJfNEVMidDJUe69qz1mLAVV7hXmHzYrjKAzwHkdw4=;
        b=K9nrEp5jIWTBBgj9T/JNu9q85QG6fJg4I3inV1Nm72IeD3O0J8s9cKq2sNMXDrigP0
         U9+LvkjVOkO/9nazF9g1nA+QEYk5E3JG+UsJGjDSVJ4bgXNsbZChtFi5nIUkoNn+IphP
         H/Be7Pw66L2eGVNigThCelxQ+djzUrhprIZsGAz4KPt0utXpY+jcPE2Ts2HjwKvb5G86
         i1HXk32XHtxpDVtwCzi4JqPtABje5UXQ3XxWzW0FNeylQybi8bosA7xhTctQP+sYkyvQ
         wiYBQJ7Urazmfeuqq3rJLIQF5LqOQ4KQ1dIPH5aDFJx3MFoPo3NsyLPi/HGQErHWAu86
         CLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734035; x=1769338835;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qpQJfNEVMidDJUe69qz1mLAVV7hXmHzYrjKAzwHkdw4=;
        b=ZdaXalZwU3U4MpFhTO1RGxwFOdovHGzpHYFWwXiMDVKuW8TyDxzLHlPjQAKvzWdJSS
         JlD4r4i/weM0QC/c9b22zbMbrPygSdMOZiU0+bj2t1xZ8nCC6aZmLZ2kXZoLhyyIMxwh
         4+1cYLPis8lWzFCtGaJ4J3Tj4pxxoKJfEKlN6IX/A8ffd9hMWYc5qFIBbE6naY91wIK3
         BnRf046c1PmtpSKq4bZBg4HB9GatWl92QJTI2T6vuVgdYfaL0yF98McNXIIUbsobo8IA
         6uVWU/BMN6J2ytChTHowBDykLb152bkFBjfmc/FFhSvS0N6EWftTRe5U39zpuWL+dqBw
         /0Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUkicftJWyrzhMoZ+OjqALNKlxAYsY8B2ydI3AiiUmQIbqbCH92akkFNi85BzPlkuBJgau1EA3ZxyAmCEruCfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpQvK+Vj3pnoezIPc3Xxa4Dy6AJIsg2iVs2njLHnX5TwCQ4/J1
	72tbT0dZXtJJlAU8GGHdsDBRCiFypwRI95RxSazZCYoCKWt6AtaTQv3k
X-Gm-Gg: AY/fxX5lpPXBDnTMT6GGRma+XfxmZSWA2Z2+jpzPudZ4KJS4ZX4f0lt598uLMxhFiUm
	pPom6L1qbq19Fa953TASjdwWphfEPtUDuFzOU6yEDYqpSu5uMD8Nwvbzmh3ol54gYw8PsM+9MAA
	ZSNi06NaH4mtyRdQqYXnfhikTjt3RN01b+RTqRRIG7nTzEr3KJVkN5mMi3Vuk5n/JJnUmnnBWAZ
	Hq+1T/WgiVZBBtQovi1Xvr8Tf6x6LZY6dQmsPkZVkkUEVwpfMkMgtdfMetyR7N9o9U23VqWAiZP
	m/FqVfPbS43+FCbl4meNjdxbL8UzdNmJwlsEAn23V1smdYeWLtRXREp0zX+jeOCN9EumQw/V/+t
	G4wScgMqxHbXwq/RyAag/UoQT4Wr2PjyJjk8fSb+t6lnO73VVmpC74mTG0SWF0x1CJnHanilCqu
	PYPF5VnyljyDfubg==
X-Received: by 2002:a5d:5886:0:b0:430:f9c2:8500 with SMTP id ffacd0b85a97d-43569bcdf8bmr8324359f8f.43.1768734034340;
        Sun, 18 Jan 2026 03:00:34 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:33 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:26 +0000
Subject: [PATCH net-next v11 6/7] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-6-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=9836;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=r1PE8fDi2fMuVloDtOFpaMYOvsXBjkenyxTGboQyEIM=;
 b=ZNi18xocRfYTkc/kQ5yZlD1bOBS69EKqwGAfehdKI2VvIDsd8NIwVBTm1nMIEzNi1sEkKNQup
 skNA0Bf7zFuA+a7oNCL3H1sTMjmRdsi8Zi6x6EYI1mR27S6Fz4W1mxz
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


