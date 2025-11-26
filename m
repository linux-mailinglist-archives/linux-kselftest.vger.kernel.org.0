Return-Path: <linux-kselftest+bounces-46570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E20F7C8BD20
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 21:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 52C7534768B
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Nov 2025 20:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD4342526;
	Wed, 26 Nov 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6KX1/1H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5109B34251E
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764188600; cv=none; b=VpvQLieLXCuaIdI3rLJAsYNxc2ZiBofXecgWu6Ka7qY3nypgDDxC4uxJgygjMYCuS4dgpp6wWmrZQkuHCJOI0uVLFCnGSfceKT5lfT/9Rz1meU+MiieSt9qTelc1k3HBgbYD9Eu0GbTMd53CjeR8OrmHt/gqoMV7UlpjCMPb/dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764188600; c=relaxed/simple;
	bh=ptkTe+cYKKYMyCNyu+hE6VVzhConXnPLG7fL2BaD9jQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CQ5VLxkjS4INmY55QF+/oD/1i+yGNrnNZLz7DxDP/F2Zwl8EekdBjDOH4PFvC9cZ5oggfAr097HhnUjcaly8SaTzeY0BQh8JNAU6SDiwxGgn0hLyaBLXC93tcfHKBMJFQjYpuffhqox0r8L62b+Q6Whh4M3E4qcXbltF2yCd0TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6KX1/1H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2957850c63bso1345425ad.0
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Nov 2025 12:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764188598; x=1764793398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+RTp3NdTDs9G43jfmTa4TiJRQPqbtzKxkq+h8ATOJA=;
        b=b6KX1/1HG1OvL8WyPq9VoPXcVTG+CMXhjWdRm+t2e9gP/6N3TYfv+pTsDutOXR9xtU
         lVogKU+ucB4r3vWsjlz4kCU1gAG6IK4Jt6ulefTJWoUPh4har7GcTIwEULK/b0xCPG7m
         yAQZ9fKHbK9l8EL9yEzWefYpIEuaEBUTqWKnTN5H/e4TBlPz970wexSPkJIluGmTy9Zo
         VfgUQOYdG3KPWexCOJUS9HkdXc7ByODxaXu5habcMin5YXMCvqc81OiunQBady1LvrdL
         L2PlFni5VZwMy/XRrhxGojDxS+AHhhokbkNQ3ijNpkpy4Dd/mAUh7GG/O6mffFOaUfVD
         j4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764188598; x=1764793398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t+RTp3NdTDs9G43jfmTa4TiJRQPqbtzKxkq+h8ATOJA=;
        b=WDMpY1h/x6VXlAVwflC+SRZgA9ZDafRsAts9+SKikZATHwc0a++4pE6XN0+9sZ+tb3
         N9Cxig3BrjVUNOzIjNHPDX9G8SoIFs/GwJMPbbDsWPVpJdU43xRkIvSZMusefBCwyGzS
         36gboZtboXIrthMvrRkJ3zMUCkKZigBUrWAl1xWiTSlxCgcK5P1r0odmw9XILpIYjLkS
         zh2aLnoq3EgjrYP4zJdbvcYew+cNqhAWaJZwKyNC6u5/Sso0+Bbq9whL6aYn2ur/mhJi
         8GqiiWEo3Axyr87pQ2y/X6HLSF0aIELJMP/dCA6q77WPvvZg1x4lLu95LhqxPcuJxXL5
         oVCg==
X-Forwarded-Encrypted: i=1; AJvYcCWSjHPfmvQyvyKPjln11dzgq9fTUHC9OTL5UcIVfB8KkCypq8oDRtkphNJrMYdJBIwz6Xg33k7YDicp8vjjRo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyahuWVcjE27l+TNecukbY5+f6/TSbpdsrT3Cr5PbnI5Yhc7fKI
	+VFk3hWmG+XvOXF9giC4PMmbw8jH45CmJqdvpWuUe1Hn4NGipxc6f0SMj94jAFxBvEdFNQ==
X-Gm-Gg: ASbGncvrYRQc/pu8A+ewXcJf3QFIkJTv8o862ddzUvn8r1FCxdiDbJiWmSDWkH4z4Xy
	lVZYgGFM8CmlBqA/rsKr1quxbUT1lnqnKG/UX8Qqd2sUj6dq/NCgn4zYE8VTEHniR6zLz/msPpV
	UCE1l7NfSmMSoTsfTfGlVsBfJHBb9XGpZN+H7A589SBwTJoi2/rhR0oKaVbUn3aC8cDZaLrgycM
	gcpaeucJ52RbSFE70TQfn5pfpFqjzKhsppbnBRG74O/5LfDP+vxyLMJ49H2u2fjpYNFX4uGaOTm
	NWsjazLeHaV65x9trCqnUtJNEsCTcY+zOLkc1z/AGqnJVqkkJ0qfa+oG3LuLmPiDUj3JnDi6QFi
	o2hssL5U3sQIxSbr3LXUEwzRi5XkygzX1JB7Vq5I3dzgMMVKqiXuwxFmpVeluqcydbx3bkFqGkq
	KRcZHO1xyMfMBTVoSehg==
X-Google-Smtp-Source: AGHT+IHnq+hcKWMIhGOzkRicd2oIQQubAwrZjs+4Bn9HxO+O8u8npbybdXR5esWC04tApBHnxYIMqg==
X-Received: by 2002:a17:902:d485:b0:24b:1585:6350 with SMTP id d9443c01a7336-29b6bf1ae09mr238515535ad.11.1764188597316;
        Wed, 26 Nov 2025 12:23:17 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:752f:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13a80csm207100475ad.35.2025.11.26.12.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 12:23:16 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Wed, 26 Nov 2025 20:22:54 +0000
Subject: [PATCH net-next v7 2/5] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-netcons-retrigger-v7-2-1d86dba83b1c@gmail.com>
References: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
In-Reply-To: <20251126-netcons-retrigger-v7-0-1d86dba83b1c@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1764188576; l=8948;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=ptkTe+cYKKYMyCNyu+hE6VVzhConXnPLG7fL2BaD9jQ=;
 b=8RKlyRX/F54xIbVDSwkgACII+YR/FaHtjwEtK/4nTg6WIJSOw8mu+/nnUYLXKJ8GfE1jkbt7m
 fZU3pC6qrUsBnDok3OBnJY5PQH4lY8mPNld7xW6rdDDzHSexb9bfen/
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


