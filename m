Return-Path: <linux-kselftest+bounces-45952-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CAF5C6D3B8
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 08:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 35EDF2D328
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A802DD60F;
	Wed, 19 Nov 2025 07:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2vdomgK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6661332144F
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763538576; cv=none; b=cJYK9RDIUKrdDemyq0/q8dx7dieQMWNzYTldpl6jkoYHGWyeo1dUou+ty9/ZZhdjjmijNy2GzHa7rHk5K3H0hh6jp+eW0FgOkDjEmVfsflip3NN+wzRpIOJup9ro7t844pkjJuRCQOkL60hOTTCXQ3aXBXlrfYrfekHMgWjBBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763538576; c=relaxed/simple;
	bh=oUWokIEDld4kRUmAZyFGQq5Qe4DN3K6f1rTjOieZplk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LmjwGF/u924Pa+NF45BslzjZpv+k9Fn7udvuMDzri8OtjwzPMRBkzDE2v+kjtKd59DjJ4ZGGvb4vm35D+UClzTrpqZQrHAgVjWj2qdtMf9VExy3qf/ZAELcE9ch13XhtNaN62w3Vb8T0fRuS7mIDegeUQEjsJz/qapyp2gRHEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2vdomgK; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477aa218f20so10273205e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 23:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763538571; x=1764143371; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4WXY3ERbuZSOqVEVpN2MvADbktcFwK5vzpOBLwlIIs=;
        b=l2vdomgKks5mTCwq86hl7TA7JFjMRPt7lXxrOw1rr3pERu3xgk8JjXUTTp166bSpKv
         BGfKjuF1K0Vh3LUb+NDp5UqGKHiB23nQ6XRYO0NFgX+ieQS9HJtA4DTXFpeU9s8RIg2j
         aKSYvj6fWvdLek0be69oyDf+AhgBmtg64FuwzAJMkV7/3FOni7/qM1Tu3Oa2hB9QD+RJ
         wto0aQMy6tl1CsV2RQBonso6sVI0Gik/aE8hQtHIkfHLwMikMppj2MHS6TELyf4+xXlO
         4KlV5yua9iUlGU1EZCUxb3PqOwY7DtjQqZ07dk9s3BxGJeUjUibEMeIWJ18i6FTsbIQe
         hO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763538571; x=1764143371;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4WXY3ERbuZSOqVEVpN2MvADbktcFwK5vzpOBLwlIIs=;
        b=XiQsYrSpALvZWnh5VVOv7rabsooTZMRSuuonqzh7yF89BfTRYwH4v/UiZpDvxUbffe
         lTxi3oOc2GXvRTOHDZr/nBkDViaPdSa+xV69M1y7wryc5li98vpVNwk4afwGZzJ0QqiC
         8M1ohJ6nRkUk8dGyjtvXtc5MB8GTKCfkKwbuEs5ji8OMG0rRw+zHgkLFNHRPvYlZqmE+
         c0R5Q53OfgQW/xywOd2JacBJLcZUIYJC6aXYcxAb8yZAyUWZ82LfpGBOmozs5OTZYt8i
         CI0JYBDBGfxzT2QBoPOZwNxW/TUT4HegUMXw90EgXwdB4naEPEqDZt3Wwynb8hdbl3cK
         rGng==
X-Forwarded-Encrypted: i=1; AJvYcCVe8Vz78wBpc2MLf6qbQdLkAZqf7KMBSKSDuHD53L6WTn3m6LhLCtJ6peESxxeqFvepOU8GCuG5EOv0sXue9XA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuLarHZ0Qa+ZzKbeNxCdNGxDcDQDfSFqM61Cb5t9Rot8GIOlpK
	jLGDwckVIRngo/PdNT4tAR+VF5l0a1g/vs7GJ5y/+rFYPjRQCuQiitv02q6OjW/Umtc=
X-Gm-Gg: ASbGnctUDkeEtU3e4rkZch+B0k6ZPch+rPbsQwkqLPVLy/+90Qoi/6uf3/6Ilvt5r4P
	j714LlmT3sz5L309hAlFoA7zvgdIF97uCdJCF5RSnHT1ilz6Qurs7YOKM8VmIOLMKTPc5QqMNpm
	QzosPKJhiKyj8qVqY/cX/fQED9QhsHc2w7JiY6rJJrVUFrypsVtAvzMWCQFFwQqzrC7dZLXQ3+F
	fbI4ftvStAbH3GoIHGprqX7Bfnm8Ap3rESU9MolfIE5cmp9GeWEAm1aB7BTJ5S6nWx6163RFWM6
	Ba05I95+IP1yr+KDL/AJ/6SqGhl2xIZLbCgE7DpHcKgrGQKYNCOZLb5Y66aTUny5S/rdMScmcrH
	W1keE8XuESazcAyIi9TuCLclwcNPTB4lCr4CHEFPIJN3/xMQCcbxcyfnKBzs2Es94+RSj/b/og1
	Fn6vB/s56ytKFOJNM=
X-Google-Smtp-Source: AGHT+IFLd20SEJufI6QIgNtFmAW/AlUvVsJ88uQFqanHuPhGS7kxwB6+3ppHJvfHNtUdevByTF89/A==
X-Received: by 2002:a05:600c:3b8c:b0:477:afc5:fb02 with SMTP id 5b1f17b1804b1-477afc5fbd5mr26258475e9.21.1763538570691;
        Tue, 18 Nov 2025 23:49:30 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e91f2dsm37461146f8f.19.2025.11.18.23.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 23:49:29 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 19 Nov 2025 07:49:20 +0000
Subject: [PATCH net-next v5 2/5] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netcons-retrigger-v5-2-2c7dda6055d6@gmail.com>
References: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
In-Reply-To: <20251119-netcons-retrigger-v5-0-2c7dda6055d6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763538567; l=8901;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=oUWokIEDld4kRUmAZyFGQq5Qe4DN3K6f1rTjOieZplk=;
 b=llAlo5ccn8ilJJIowC8V7B9nxxnfNcvliY64HiEOIuJvdQzdkEkFzxD+QCzmUHBhD8WZEMP83
 n4iV0w8u+AdCVOjBgqDLY9ON66w+sVh8GDj6IIYYyEvom/mTMi5/kHo
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This patch refactors the netconsole driver's target enabled state from a
simple boolean to an explicit enum (`target_state`).

This allow the states to be expanded to a new state in the upcoming
change.

Co-developed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 52 ++++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7a7eba041e23..2d15f7ab7235 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -132,12 +132,12 @@ enum target_state {
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
@@ -165,7 +165,7 @@ struct netconsole_target {
 	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
-	bool			enabled;
+	enum target_state	state;
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
@@ -257,6 +257,7 @@ static struct netconsole_target *alloc_and_init(void)
 	nt->np.local_port = 6665;
 	nt->np.remote_port = 6666;
 	eth_broadcast_addr(nt->np.remote_mac);
+	nt->state = STATE_DISABLED;
 
 	return nt;
 }
@@ -275,7 +276,7 @@ static void netconsole_process_cleanups_core(void)
 	mutex_lock(&target_cleanup_list_lock);
 	list_for_each_entry_safe(nt, tmp, &target_cleanup_list, list) {
 		/* all entries in the cleanup_list needs to be disabled */
-		WARN_ON_ONCE(nt->enabled);
+		WARN_ON_ONCE(nt->state == STATE_ENABLED);
 		do_netpoll_cleanup(&nt->np);
 		/* moved the cleaned target to target_list. Need to hold both
 		 * locks
@@ -398,7 +399,7 @@ static void trim_newline(char *s, size_t maxlen)
 
 static ssize_t enabled_show(struct config_item *item, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", to_target(item)->enabled);
+	return sysfs_emit(buf, "%d\n", to_target(item)->state == STATE_ENABLED);
 }
 
 static ssize_t extended_show(struct config_item *item, char *buf)
@@ -565,8 +566,8 @@ static ssize_t enabled_store(struct config_item *item,
 		const char *buf, size_t count)
 {
 	struct netconsole_target *nt = to_target(item);
+	bool enabled, current_enabled;
 	unsigned long flags;
-	bool enabled;
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -575,9 +576,10 @@ static ssize_t enabled_store(struct config_item *item,
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
 
@@ -610,16 +612,16 @@ static ssize_t enabled_store(struct config_item *item,
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
@@ -648,7 +650,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -675,7 +677,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	ssize_t ret;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED)  {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		ret = -EINVAL;
@@ -699,7 +701,7 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 	struct netconsole_target *nt = to_target(item);
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		mutex_unlock(&dynamic_netconsole_mutex);
@@ -720,7 +722,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -742,7 +744,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -765,7 +767,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -790,7 +792,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -839,7 +841,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	if (nt->enabled) {
+	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
 		goto out_unlock;
@@ -1330,7 +1332,7 @@ static void drop_netconsole_target(struct config_group *group,
 	 * The target may have never been enabled, or was manually disabled
 	 * before being removed so netpoll may have already been cleaned up.
 	 */
-	if (nt->enabled)
+	if (nt->state == STATE_ENABLED)
 		netpoll_cleanup(&nt->np);
 
 	config_item_put(&nt->group.cg_item);
@@ -1459,7 +1461,7 @@ static int netconsole_netdev_event(struct notifier_block *this,
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
 			case NETDEV_UNREGISTER:
-				nt->enabled = false;
+				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
 			}
@@ -1726,7 +1728,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
+		if (nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev))
 			send_ext_msg_udp(nt, msg, len);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
@@ -1746,7 +1749,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+		if (!nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev)) {
 			/*
 			 * We nest this inside the for-each-target loop above
 			 * so that we're able to get as much logging out to
@@ -1902,7 +1906,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 */
 			goto fail;
 	} else {
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.52.0


