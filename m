Return-Path: <linux-kselftest+bounces-45953-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7055CC6D40A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 08:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA6194F7046
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 07:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84333329C7C;
	Wed, 19 Nov 2025 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kcy6oKi+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4BC32692B
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538577; cv=none; b=T1Rqaxre1x/H6SvtbFXPDZbjrZKbf3tuW3yBo2xraeBkbgl/zgYrHK9iYdUpYbdNfq5aMCq0BUus0cRGJPhw4M/zP9CaNkFLN8y/mAzuhj9s773xT1be17oFzsZCtwI2dcKqjiFpPz92leOKimIA3jsp47lXQe2wrzk8WHrTMxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538577; c=relaxed/simple;
	bh=9zaqmgBwxXnLcXgUwFa+jvCmIZuwMpmmytrg0AHbbKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpLfZC2LvJqO1q5BYWFhlCII2lhaFcP9seh+YCyPm0BUczjUuVEAtjnx3TUVrhTAbgHZ4kcDYOr3MkSmYvTmLhmaVXWd9CZ0h4ovg6VRZ8M/n4FhsnRlVLnAz4+C8qiKCeeaL94iDm/m1jOPL8p6p9lOimf2608f6q3kMiab8WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kcy6oKi+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47755de027eso43415335e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538573; x=1764143373; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bAe1pwdEymBst1UNpxP2f2MyEcqzXU+P5wwloI7gzDE=;
        b=Kcy6oKi+Y3hcnV6AMMd4i0mwFzTkdgivBcVmQnM7OEjGujHxEQvUMcKHIc9YVG4J0S
         r2RrtI9odsX8Sgve6NVNzI4HMc+FD4ed/PuLNcnS1j2ep3vpmKbuH7JUcup9CPVJ0tkO
         ZymiTP+siLP4esWXz+xMYYtvD8s1IUF2D+GpOuVLwCgiTHo+b9Z1kuniTv6uy4z/OGwN
         6EjPjFXGgZ5KcRkJTbP9qZQIZdNLlaF/QTk8iNI25bRRRqCrmFqfZ66ZIFGdwin3z2mM
         3Qc8ZgZNeHDNSEJH7VzBFKa0/h6z9qGTU/QeyspkanJvamgBrmsFJNB6bCrzEPIbkWsD
         Fkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538573; x=1764143373;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bAe1pwdEymBst1UNpxP2f2MyEcqzXU+P5wwloI7gzDE=;
        b=Z3rQHA+6cEbDWVUM3iRKObn3yxa4/EAmjuQ6D3wLWYxq9O6QpTCtRtODV5KIALs0NV
         cJKwAbasS2K34jZoBEg1cafkvA49KGps+3c3jQetsApEqQkJkMy0DdBPHMWvdSGb/0h6
         5ndLpUxg3UPvEM8mj2gUV//4wAsRobPqbQRgDZ2/MPlVmRS7boUXYHYams+U6FGLXzGb
         XVdakHFhQSnfES0s7MILqJzyU6lx9DHyNXRTSnG2TRjdjS0hcRgVt1QieAfTOTctBk+l
         ZbnnJK/BVGsaZl4MUu+c8aEZ53XAAGM1rkoYO+KoeoKrTEQKYUbJ4KC+rEfSeN8asUXF
         1Eiw==
X-Forwarded-Encrypted: i=1; AJvYcCU6MfyFq3amb4UMknerKLHxQ1bhW1cMtoNpWAWS82GP3uJOC3tiVKnih9FPv+9mbuwMEFIOmyYEGRa2dV93OdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkqDMGqaapnq4CqYdXMcpoVyA8YUbekEF68eIp4LHk4QxgBovf
	2bGt4X7SEjii+uR/zAqh2x84Ah8jRfJWs6Rq57vI1oAcbc2Xj7yCCtEEmFoFKbXrfEM=
X-Gm-Gg: ASbGncujxozAHPdY0I5h94tzWthCmG+mTHJw3K8HrX3EyYIDn1HsdmY+I0OrlsEMzxw
	cJsXz8GsCw0kBOoKX7QxPiRVx2ApGmS/X7oCNpvr3IpOQ9DrRvhKBWKRBanIKkT5Yj6AlA/7lwB
	cVkxvZNXpSaHwBljgtzk3gjqbBFRLRmwpHuTh0x6C/Yvqb3kJhLaFO3/b/GrgMR38Ukjj/xLyPn
	HSYGGuYbZdxpcpCYSrnjXMdPgWxAOZuRYHUWw9mei9EE/6yDuMJK7MN1QEQgGPQDZx7kz+4wVeS
	N9dQ51wH8nGAgtcl6FImCWk09xY79Hy0Uil8BfbKO3Sgzf6uOwyWBwmQqIC1is8ntcUIxq9DoMt
	QydcSiU6kygT7KGb3dB4YTK8uhndDZLZswnME/XgY+5lzPmGXkEwXoZt1OV41o/vZI8nsW93kBK
	+9EBn87Tztw+LePO4=
X-Google-Smtp-Source: AGHT+IERVxvk5iIz8m6CmGB4RzuWyuTcJ3Fb7iPOVqXTv11jEE1NU93NJ6Ei8X7dQH2Oeu1dBUM4rA==
X-Received: by 2002:a05:6000:4284:b0:42b:30f9:79c9 with SMTP id ffacd0b85a97d-42b59386891mr17979875f8f.37.1763538573037;
        Tue, 18 Nov 2025 23:49:33 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:32 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 19 Nov 2025 07:49:22 +0000
Subject: [PATCH net-next v5 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netcons-retrigger-v5-4-2c7dda6055d6@gmail.com>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
In-Reply-To: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=5497;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=9zaqmgBwxXnLcXgUwFa+jvCmIZuwMpmmytrg0AHbbKo=;
 b=OPacxqOGj015GBSqd/r2fPzk5Qh2IxiVUdWxqAZLykyZbPI/VkNNqSECQNSbeJHz6OKsTUFtO
 yrFPCdR7KtDAolFuNZV7+p2WRUJ43o6ohF1I/9QH1WtVaPr947Klv9T
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
 drivers/net/netconsole.c | 82 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 81641070e8e2..89d997e789e9 100644
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
@@ -1445,17 +1449,76 @@ static int prepare_extradata(struct netconsole_target *nt)
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
+/* Attempts to resume logging to a deactivated target. */
+static void resume_target(struct netconsole_target *nt, struct net_device *ndev)
+{
+	int ret;
+
+	netdev_hold(ndev, &nt->np.dev_tracker, GFP_KERNEL);
+
+	ret = __netpoll_setup(&nt->np, ndev);
+	if (ret) {
+		/* netpoll fails setup once, do not try again. */
+		nt->state = STATE_DISABLED;
+		netdev_put(ndev, &nt->np.dev_tracker);
+		return;
+	}
+
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
+/* Process targets in resume_list and returns them to target_list */
+static void netconsole_process_resumable_targets(struct list_head *resume_list,
+						 struct net_device *ndev)
+{
+	struct netconsole_target *nt, *tmp;
+	unsigned long flags;
+
+	list_for_each_entry_safe(nt, tmp, resume_list, list) {
+		resume_target(nt, ndev);
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
@@ -1484,6 +1547,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				stopped = true;
 			}
 		}
+		if (event == NETDEV_UP && deactivated_target_match(nt, dev))
+			/* resume_target is IRQ unsafe, remove target from
+			 * target_list in order to resume it with IRQ enabled.
+			 */
+			list_move(&nt->list, &resume_list);
 		netconsole_target_put(nt);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
@@ -1507,6 +1575,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			dev->name, msg);
 	}
 
+	netconsole_process_resumable_targets(&resume_list, dev);
+
 	/* Process target_cleanup_list entries. By the end, target_cleanup_list
 	 * should be empty
 	 */

-- 
2.52.0


