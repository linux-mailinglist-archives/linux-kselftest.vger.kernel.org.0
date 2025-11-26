Return-Path: <linux-kselftest+bounces-46572-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD69C8BD44
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 16A27341790
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587EC345738;
	Wed, 26 Nov 2025 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Eec0WZn3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EE345730
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188614; cv=none; b=gJtni4SFQ8Xy3ixbFx3Tdi2sd34zCPIu3RRyYr3EmmZHgUIvJcGrKgltec01/VIpBDt0GQOL8amWRZ4brf4Z+w0Vtz5LG39R0Y2EWyvBZB3Hg9ZvGpGtgodT7xutTNifEeDXL+6DQP2hLa6+681/A9/fztKKOJvcZNgGaqWZP2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188614; c=relaxed/simple;
	bh=U43LBa5ZqWUfnCjLm20j5ShVEuOi5TM5JaD9jZhAG9s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QJqY4yjMlJ+rb8vEzSn5G4cNqN4ClqiPjVJozyRjKl2vOagBgU1XQqK3SjghzVnUWthTEt/zM5AugoyZbfIYQzrY3H4SZQDruyQ5QyCThxuYv4pntBjUmbxa4N55392l1OFkABwj9KuEAFC2vUS6+W3yc4ex2rYOcdx83sJRfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Eec0WZn3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2955623e6faso1818485ad.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 12:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188612; x=1764793412; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ya0KpU5qQAQXJP6OAlaa47iZfPalcWrgiFV7vSpQFNw=;
        b=Eec0WZn3fYDuOBz10RoyqKMe5hipyvSD/pp4GV5T7f7dYUmxNA+yvlNHPTkuijHILb
         ttnJ3v2+t9C15Qz99Z5Kcdp/1TL8aWOpyh6kgAuj9daZh3GiMsJuaTik6dNvcftoIbYA
         zXuPbudjMgPlV4ZHZmfrrBAB0p19v9y+E9zjq1JAWqKahKV2lCCSFPl8SIfXc/tE51Kz
         4mR9O6yfr4CV8NRKBVxRbKam5EMRP9xwQ3aPPrrERPZllT/voQJ/Xh5GUteP91jB5zTo
         wbYbQIG9mHnaS0GKh4gm2qDfWhTrOdn9n6ak0nI18JCDtF3W4y7rtX/XbLfdf81fatVl
         Tjvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188612; x=1764793412;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ya0KpU5qQAQXJP6OAlaa47iZfPalcWrgiFV7vSpQFNw=;
        b=K8QCBCTQOJzdCLvmXV1VOqzkkU1wS3JVLqggkn61yO497ueKcVSQrg0IXdQHtQsSIG
         I4EQJ+lIozsEVhhp4VFT7a+vAcq0mWtC6cgfb+WjMbWqSu0RVvDk/MQK+bo5/T2VCI3Y
         DajtQTWTL84YVAvSxhVkI6lESqBD0PF0CY3QYnlYFJcBhc2JPHsqLb0flKprPFSTAXBc
         ETpo/HU9ZAQhRQdmGeJ4PwO7ARs8OFV15d8dXER7L0nQyO46j9qT/tBQhX7n9N1YtIOV
         I/Fwv5dqyp5mtTnh71oO13TX51JqQ4P39GfcOm1fVTH+Wz5Q1VaVu6FMGv8PGUpQUgnm
         S00Q==
X-Forwarded-Encrypted: i=1; AJvYcCV5e98ku+ToiGYsiEZZ8cHisEFa6fS0hv0tK2KDnJJWZkR7HjAoAe7q73OJzxvmqX5/AfmL5ZP0xzRVNcEFvlw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Bq9Ag874620iY48dlmsqXREQbfpogfVJEC/rm2hPSzWKK7w2
	548qlm4fpB+CktCebjeT4ZmR9Yt+HAAkDA1dwPA+1OHefEM1eVjg90NB
X-Gm-Gg: ASbGncuT+s71JFMytZ2g3WWEXcHxIm7bLq7OpfOQo/lJoDFCvX1s36MbwBdmxEmlV+/
	G6KyfwPdZ1huYQeG3YhuRwSVRPyyR6M87IgN+4t40rsEEx5NBKWgN+Z61rhb+YAlMRierMfvMOP
	xWGpWM69RxXos5hcV84tZuKgTAUjZD/rL7JR8e/2OYzIb05AW28E5kyixDr0psorYe8HzaZOJdu
	+Ydv/JiZB0jquFBRmVOlydx1M7WT11g8apiWDdo98nX1lzKXHT3RrxCA12pfF4byg/z+0mGrnUC
	K2YcCZDJQYAvJvWEtl2jfMQ6rfDICGb9LVtYOgu8zP5nxe1Kl0HFzjjvY7+V16XDQtFmyt1niII
	4J/ShdtWKAdKlyuwVlUndtiSJtNbbwo5EO2ON12BEyziN/sasbjYFqrtt4t+53Rk34ZeOHuvB9Q
	YG7OShsAIOP74oJxD+mpEHIyiRhO4H
X-Google-Smtp-Source: AGHT+IGhuQ5VfLX4r5MGrQDek02H0QVKLtEaRdTq+YMnWO58IGFYau5AnnIHNzbWgzOkINdjfFqGpQ==
X-Received: by 2002:a17:903:2341:b0:295:1a63:57b0 with SMTP id d9443c01a7336-29baafca153mr84562175ad.23.1764188611430;
        Wed, 26 Nov 2025 12:23:31 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm207100475ad.35.2025.11.26.12.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:23:30 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 26 Nov 2025 20:22:56 +0000
Subject: [PATCH net-next v7 4/5] netconsole: resume previously deactivated
 target
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-netcons-retrigger-v7-4-1d86dba83b1c@gmail.com>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
In-Reply-To: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764188576; l=5542;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=U43LBa5ZqWUfnCjLm20j5ShVEuOi5TM5JaD9jZhAG9s=;
 b=7xM4Oz67GhoBFxh7QGBHPZlcSHfB7mFP/4n+QH3HprC1FPAUVMqtzQIisBbNXhvdpnkHFP0kj
 uSRqANj9++vC4zPzAf+sp7Oxzgzg564oODcaouhD+a6z910/W/Eg1St
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

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 82 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 76 insertions(+), 6 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a1e5559fc0d..2dcdfb44a9e0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -138,10 +138,14 @@ enum target_state {
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
@@ -1430,17 +1434,76 @@ static int prepare_sysdata(struct netconsole_target *nt)
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
@@ -1469,6 +1532,11 @@ static int netconsole_netdev_event(struct notifier_block *this,
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
@@ -1492,6 +1560,8 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			dev->name, msg);
 	}
 
+	netconsole_process_resumable_targets(&resume_list, dev);
+
 	/* Process target_cleanup_list entries. By the end, target_cleanup_list
 	 * should be empty
 	 */

-- 
2.52.0


