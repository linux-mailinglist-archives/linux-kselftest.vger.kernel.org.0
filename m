Return-Path: <linux-kselftest+bounces-49256-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C873FD39456
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8AAE2300D54E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5432ABC1;
	Sun, 18 Jan 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCXWFaEi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B05C32AAA5
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734034; cv=none; b=rWCw1lXAz4qd1PWGRLQcp0IPCQvM2LxYxfHaAxvjfQP+vrapJK6r/kAzp0Ke04kAMcOfQwhK7kK0PC+CmDbTWaj6dBBafg1dXhNO3DawCtCBUbR3nF19wdejKsP0wxhq7AUBva4f8CdLEp1zbH4ofIYH6dRoEDzyDmbVu3a3Zjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734034; c=relaxed/simple;
	bh=ptkTe+cYKKYMyCNyu+hE6VVzhConXnPLG7fL2BaD9jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5g1cTrrXGHY4u8fMLEYG4gfmT29tX2YudvtvchLsZ/8FzQFmy5TyyUN2SpyPX2hu6BuP545fpfOS8nZ+OMpx0Zj/J3ixVmxnw0TxWCQ0w2ARTUeOiDeT71pidQgbcN2JpoVC/FePKm5/mnft3irLyVSuKWOUSs8rJ6rjcYtD24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCXWFaEi; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-430f9ffd4e8so2015662f8f.0
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734029; x=1769338829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+RTp3NdTDs9G43jfmTa4TiJRQPqbtzKxkq+h8ATOJA=;
        b=GCXWFaEizNjPk3nUN3oRWy/U6/l7axdHJlrUkVEhHhuSZyXIP4RT15Op/aGEEmEnkN
         dWO+gFBE0llbV21nSM1HeJZviBGozM6pJO8UObRxfRlz8nZ96xinW1rj/NCRgxuhoRAc
         nesN1AqcHqHj8GM6n2IiLyTD/OP6zASOi1A4e9n5UloHNi6dZvKeRzcjeA2PxrfyhSX1
         RcdpaiFGrwqt11FzOxyN6mJSs5mmOZKH6pRk/yMWGtFUV1DdTKCdE3LVyuuOMXib3bQt
         CkYIvsZDrRbYe/ae+JJHkmf7TDpNdVjsrOIYlL+ilI2Bv1UmQGMRjeZwKbTdDCj8YZEL
         WPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734029; x=1769338829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+RTp3NdTDs9G43jfmTa4TiJRQPqbtzKxkq+h8ATOJA=;
        b=DwTGzau1Cse4aNVPWAjooi1RQhUQBIhvhLUcrSfHI6Rs8eLkY7L4J46wpBx0mVtTz5
         MfX4Ls6gMDGCXGBqqFnn+tRdVVRk9j+aRLRwEV8p7btpHxc7TmGwnUe7yv0ctQrhuAIc
         9PMD0jOqT7+BXvKdlgmA1pn3seLdwi9J0+DRXjP3CvNsuupo+Ddvh916O3S+uyHvJ04m
         5ZosKp/TVu5af//ecTRD/o+phEKdG/9IfvNt5VJrfAEFi5WH5Q7Z8YxQPupFOFvWzcLF
         +hDW224F9aUNLynBrVvfZYef1bdnDGoM+dtyXaQaUmVaPUzMwd5XZCRdQPRiM9WZnzuH
         Wqgw==
X-Forwarded-Encrypted: i=1; AJvYcCXRcMNAJXXCHHTqcT1MzdhO7S0jGty58cJtA0Heh2n25IKG9SWUotDYfKXbeQ/BxPxpbZnL2MGcKjco8p+3ACA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6O5nLRIhfqciOK1ptOe5v7AuwhI+lQUjCp2/tjGephGPbMWdw
	h8gz7fS9zBelCv2kpAobTeusRRUXjHIlBTDsV3unuPlLpuWGQOVwUYY4/CejTPMh1Bk=
X-Gm-Gg: AY/fxX7Hp1a2RantdQtm+5Bm9kyAK/hAr4uqN7DGFAJuVrACKEHHCTyndsQBVpb2M3I
	xuQH6TQPFrnJ55076vl1MC89jXZ/PKbNGRnZPCAI1kRZljIQ9h64vjGehpVw3fyMBPdE+U1igDN
	MxPu4nEObkDjcF2W7hplCACbbIHxCu13iIN7vIQa9TbYl7BTwL+0puTCEvQFAfq00idLIE0eemO
	cjzjtI6ln9va+yfptkUNlj8sXB+Xhrldt6VwKN3MJJSlQkI3RKIwqcXc84FJ6QjDs0wMl5FhUN1
	M7QPKAiA2b0SwGzbMPDD27NQnEg+B5S7CbKNVPzBbD0R0Jaf621/cT/dnutaeOZoyQ8hR1fwY4B
	SBpCRI6saRHYMeBWWKCNwmtEGTYhDZuq3A+Y02GEKP26ImKtHct6sUoz/d193Sv+47aWDQaFRt9
	HxcJSETGSgCOgEyg==
X-Received: by 2002:a05:6000:184b:b0:431:de5:93c7 with SMTP id ffacd0b85a97d-434cc998542mr16989547f8f.2.1768734028487;
        Sun, 18 Jan 2026 03:00:28 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:27 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:22 +0000
Subject: [PATCH net-next v11 2/7] netconsole: convert 'enabled' flag to
 enum for clearer state management
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-2-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=8948;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=ptkTe+cYKKYMyCNyu+hE6VVzhConXnPLG7fL2BaD9jQ=;
 b=6Psep5ulEf30penn26h1zF9CxK41ii8nal/NEfAH/R3RYXYQhPQRQLIJLdNLSlaRic7O3Kiv1
 UwgbCSZgAd9C4HPFiu4cbY4XbnuznbSkE6uA/CDzaaXeJqdbb0toHCI
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch refactors the netconsole driver's target enabled state from a
simple boolean to an explicit enum (`target_state`).

This allow the states to be expanded to a new state in the upcoming
change.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 52 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e2ec09f238a0..b21ecea60d52 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -135,12 +135,12 @@ enum target_state {
  * @sysdata_fields:	Sysdata features enabled.
  * @msgcounter:	Message sent counter.
  * @stats:	Packet send stats for the target. Used for debugging.
- * @enabled:	On / off knob to enable / disable target.
+ * @state:	State of the target.
  *		Visible from userspace (read-write).
  *		We maintain a strict 1:1 correspondence between this and
  *		whether the corresponding netpoll is active or inactive.
  *		Also, other parameters of a target may be modified at
- *		runtime only when it is disabled (enabled == 0).
+ *		runtime only when it is disabled (state == STATE_DISABLED).
  * @extended:	Denotes whether console is extended or not.
  * @release:	Denotes whether kernel release version should be prepended
  *		to the message. Depends on extended console.
@@ -170,7 +170,7 @@ struct netconsole_target {
 	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
-	bool			enabled;
+	enum target_state	state;
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
@@ -262,6 +262,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.local_port = 6665;
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
+	nt->state = STATE_DISABLED;
 
 	return nt;
 }
@@ -280,7 +281,7 @@ static void netconsole_process_cleanups_core(void)
 	mutex_lock(&target_cleanup_list_lock);
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
-		WARN_ON_ONCE(nt->enabled);
+		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
@@ -403,7 +404,7 @@ static void trim_newline(char *s, size_t maxlen)
 
 static ssize_t enabled_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->enabled);
+	return sysfs_emit(buf, "%d\n", to_target(item)->state == STATE_ENABLED);
 }
 
 static ssize_t extended_show(struct config_item *item, char *buf)
@@ -570,8 +571,8 @@ static ssize_t enabled_store(struct config_item *item,
 		const char *buf, size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	bool enabled, current_enabled;
 	unsigned long flags;
-	bool enabled;
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -580,9 +581,10 @@ static ssize_t enabled_store(struct config_item *item,
 		goto out_unlock;
 
 	ret = -EINVAL;
-	if (enabled == nt->enabled) {
+	current_enabled = nt->state == STATE_ENABLED;
+	if (enabled == current_enabled) {
 		pr_info("network logging has already %s\n",
-			nt->enabled ? "started" : "stopped");
+			current_enabled ? "started" : "stopped");
 		goto out_unlock;
 	}
 
@@ -615,16 +617,16 @@ static ssize_t enabled_store(struct config_item *item,
 		if (ret)
 			goto out_unlock;
 
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 		pr_info("network logging started\n");
 	} else {	/* false */
 		/* We need to disable the netconsole before cleaning it up
 		 * otherwise we might end up in write_msg() with
-		 * nt->np.dev == NULL and nt->enabled == true
+		 * nt->np.dev == NULL and nt->state == STATE_ENABLED
 		 */
 		mutex_lock(&target_cleanup_list_lock);
 		spin_lock_irqsave(&target_list_lock, flags);
-		nt->enabled = false;
+		nt->state = STATE_DISABLED;
 		/* Remove the target from the list, while holding
 		 * target_list_lock
 		 */
@@ -653,7 +655,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -680,7 +682,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED)  {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -704,7 +706,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	struct netconsole_target *nt = to_target(item);
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		mutex_unlock(&dynamic_netconsole_mutex);
@@ -725,7 +727,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -747,7 +749,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -770,7 +772,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -795,7 +797,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -830,7 +832,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -1326,7 +1328,7 @@ static void drop_netconsole_target(struct config_group *group,
 	 * The target may have never been enabled, or was manually disabled
 	 * before being removed so netpoll may have already been cleaned up.
 	 */
-	if (nt->enabled)
+	if (nt->state == STATE_ENABLED)
 		netpoll_cleanup(&nt->np);
 
 	config_item_put(&nt->group.cg_item);
@@ -1444,7 +1446,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->enabled = false;
+				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}
@@ -1725,7 +1727,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
+		if (nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev))
 			send_ext_msg_udp(nt, msg, len);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
@@ -1745,7 +1748,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+		if (!nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev)) {
 			/*
 			 * We nest this inside the for-each-target loop above
 			 * so that we're able to get as much logging out to
@@ -1901,7 +1905,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 */
 			goto fail;
 	} else {
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.52.0


