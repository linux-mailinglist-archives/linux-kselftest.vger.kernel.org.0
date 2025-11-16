Return-Path: <linux-kselftest+bounces-45705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4800AC6192C
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 18:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 236743596C1
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Nov 2025 17:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D8330FF23;
	Sun, 16 Nov 2025 17:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFPL9+Mq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C33730F805
	for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763313261; cv=none; b=slMv7oafFoujiZ5j3SG88AkQyFn6T78+tP64KsVmDyaji4yu9ejQAtOYerMwfJocEkwPV/tluTfBEzNoWTaHUD5wUjF3EMDuE9vmrcuZNzyDn9Ibs4soJJgKk3EtRiQddRYmFZH4XB72p2rHsHeoiXmvTtW+D4NX6tGcPfbM2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763313261; c=relaxed/simple;
	bh=460Otk0eYLOBQe5n8jsdt5eu5Fafrt2266A8G3HE0cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbP/3NvdWHOfeBxoQgkXfBgxS+qq1WrVkhTiuJAeltOEqHdrodozU2dKcTEShK7j8t01YepcImLWsLVJKXbasWok51TWij3yWM9ZDDtwQotrfdlb+zEGHsq4fh7Ch3LPlZViMG23oGRdbO7Zb9Ker9CTUwwAoKkCkLueGlZnKJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFPL9+Mq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso18256365e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 16 Nov 2025 09:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763313257; x=1763918057; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L+8nDgOH9ap03TaeT/Llb/5RzbyThgcaKGFiGWwimp4=;
        b=PFPL9+Mqnxvpw2pCM/67w1ELFM7N1MeCSwlO1N4Xsacve8SIHsCa+0wAe2KMLNRCPH
         MoGgxKIjQBLTuDosaVuPTQXmMKCVJQ6QdMJ1V9YuLoafwJcT7C8xjB670A4BoRCReh91
         5qCdVWUYnm54XhEAqC5LcZbHSYKM5LAenz76P1kVCBO9cLDI95Xl2qakkkwdnf9JWC0W
         uagEtsW4ek4/bikZRK7/9otavOsCaNbZou26LlFZNNgNAAwwbH5MFKlhwc0AxwqVXJVc
         kgTUE9Isl6mjMxjT1Kl0gDDecBbVXpVTdrGdDUpJlcnpzMtRw84ys9Hdj2eoVh8S2hT4
         dOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763313257; x=1763918057;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+8nDgOH9ap03TaeT/Llb/5RzbyThgcaKGFiGWwimp4=;
        b=jkE1EYF+/kU4a4oN6uY5qdIob1iWo4XzrO3aJwwWu2K90XPg07RlKJOiRVvChdhskE
         btReNX0Hs5olxuzVAvd2M9GF+UXSKa6+T9E/QdMN6xTGtN2D3DYAn7x96vI1yAwccrTb
         px+ni73H5TiPmfa8DA8LONDd3HheLQp2bOV8BXE/3VGh9VpMhT58y+MMXCY3CuvpeG1C
         MWQzsCSD1jq3GB+cpvoQhXvd90mkG7WSbxTTf5ByUf+datKqZB/r78oxWh8rwkms6m85
         mudcv71/lObC02b38Hw0kAAoo3GDvWBooGZpkTsvDnqQUFOIQNuHXN/Ka6KttBeJnsyY
         jHrA==
X-Forwarded-Encrypted: i=1; AJvYcCUlvrjfnVJ+jNPAj+klHlW+ve1U9BYCkBfT+nz2awX/8Y7ubX7Fh70IZSXfiWYKiZk9JeWbEd5qyjMc0zKPCJw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2BHS6bh942XtK5au2/JhOfhSTMDh3krs6hTP8z9n+YW9eCyC
	dP+dh1DXUrH3bQh3BPx51Tun2gUBHRNKm3RDmm8GV4ypugzvRrRMaEpNSED5qiwb6AY=
X-Gm-Gg: ASbGnctDm4c4XeNFoucFTJc5JR92NSlnwGc/fSD1GrqyGKH21hVc/WAZc4qDoGhgCJ3
	27DLe1D0gD50XYxFYJUXPSL6dGBJIPBwZkrTDOhBMPnKACodGUkc2Aw2BbTwiFolFDyG3YT4+CT
	WGAbS16Fw3lO7zGKBTtBWZxbHXd0STDPJguzowOu4ZlxiWINzZHjm9xXi7/1sdyKG9cr6uhExs2
	3fg39JZ8PO03zBnDuQhlBhVFgDEfZsROnN8023SkIjZ8DNOTHjYiEjmf1dq/GSgtgUr9FAAGe4m
	IXJ2Xk2U55nwSFE1uS5bEfP4O7w1Q4JHpKDIAF/rpBVNeZbRb3I58bA7RqmSzE/4sJIRGVGPqIJ
	aKeyKnR4RwJMLkU7QciMGnGkIc+SQApHLQyWjKmwDAnzXgyz3xZtrl50M9htXoUeaikX/1aEz//
	IvBejjcrCGNawEQ/JEoWna83Y/tQ==
X-Google-Smtp-Source: AGHT+IGK0rAtMtP6hsyUp9naDX0gb61WIUxqt3FZA3VMgbYKJWFNkqUjmzpMgqUlSvpS3r54c3sCww==
X-Received: by 2002:a05:600c:c83:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-4778feaa58fmr88355385e9.34.1763313256458;
        Sun, 16 Nov 2025 09:14:16 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4779d722bc5sm70874245e9.2.2025.11.16.09.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:14:15 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 16 Nov 2025 17:14:04 +0000
Subject: [PATCH net-next v4 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251116-netcons-retrigger-v4-4-5290b5f140c2@gmail.com>
References: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
In-Reply-To: <20251116-netcons-retrigger-v4-0-5290b5f140c2@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763313249; l=5456;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=460Otk0eYLOBQe5n8jsdt5eu5Fafrt2266A8G3HE0cs=;
 b=NcSaQKOVCR/gsjazYAkiddvDuHd2P8FgRdD/zscLpWEgP0cZCyevhm4GZ47MTLQ98CDgR1bK4
 DjHs6Ql7+GRATqfvF5e/1xo7m4vp0OfuixIXO2hW+bfAOwoiB2JyZ7+
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

Attempt to resume a previously deactivated target when the associated
interface comes back (NETDEV_UP event is received) by calling
__netpoll_setup on the device.

Depending on how the target was setup (by mac or interface name), the
corresponding field is compared with the device being brought up.

Targets that are candidates for resuming are removed from the target list
and added to a temp list, as __netpoll_setup is IRQ unsafe.
__netpoll_setup assumes RTNL is held (which is guaranteed to be the
case when handling the event). In case of success, hold a reference to
the device which will be removed upon target (or netconsole) removal by
netpoll_cleanup.

Target transitions to STATE_DISABLED in case of failures resuming it to
avoid retrying the same target indefinitely.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 81 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5a374e6d178d..2a5c470317b5 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,10 +135,14 @@ enum target_state {
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
@@ -1445,17 +1449,75 @@ static int prepare_extradata(struct netconsole_target *nt)
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void maybe_resume_target(struct netconsole_target *nt,
+				struct net_device *ndev)
+{
+	int ret;
+
+	ret = __netpoll_setup(&nt->np, ndev);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+		return;
+	}
+
+	netdev_hold(ndev, &nt->np.dev_tracker, GFP_KERNEL);
+	nt->state = STATE_ENABLED;
+	pr_info("network logging resumed on interface %s\n", nt->np.dev_name);
+}
+
+/* Check if the target was bound by mac address. */
+static bool bound_by_mac(struct netconsole_target *nt)
+{
+	return is_valid_ether_addr(nt->np.dev_mac);
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
+/* Process targets in resume_list and returns then to target_list */
+static void process_resumable_targets(struct list_head *resume_list,
+				      struct net_device *ndev)
+{
+	struct netconsole_target *nt, *tmp;
+	unsigned long flags;
+
+	list_for_each_entry_safe(nt, tmp, resume_list, list) {
+		maybe_resume_target(nt, ndev);
+
+		/* At this point the target is either enabled or disabled and
+		 * was cleaned up before getting deactivated. Either way, add it
+		 * back to target list.
+		 */
+		spin_lock_irqsave(&target_list_lock, flags);
+		list_move(&nt->list, &target_list);
+		spin_unlock_irqrestore(&target_list_lock, flags);
+	}
+}
+
 /* Handle network interface device notifications */
 static int netconsole_netdev_event(struct notifier_block *this,
 				   unsigned long event, void *ptr)
 {
-	unsigned long flags;
-	struct netconsole_target *nt, *tmp;
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+	struct netconsole_target *nt, *tmp;
+	LIST_HEAD(resume_list);
 	bool stopped = false;
+	unsigned long flags;
 
 	if (!(event == NETDEV_CHANGENAME || event == NETDEV_UNREGISTER ||
-	      event == NETDEV_RELEASE || event == NETDEV_JOIN))
+	      event == NETDEV_RELEASE || event == NETDEV_JOIN ||
+	      event == NETDEV_UP))
 		goto done;
 
 	mutex_lock(&target_cleanup_list_lock);
@@ -1475,6 +1537,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (event == NETDEV_UP && deactivated_target_match(nt, dev))
+			/* maybe_resume_target is IRQ unsafe, remove target from
+			 * target_list in order to resume it with IRQ enabled.
+			 */
+			list_move(&nt->list, &resume_list);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1498,6 +1565,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			dev->name, msg);
 	}
 
+	process_resumable_targets(&resume_list, dev);
+
 	/* Process target_cleanup_list entries. By the end, target_cleanup_list
 	 * should be empty
 	 */

-- 
2.51.2


