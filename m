Return-Path: <linux-kselftest+bounces-41069-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFF3B507E6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 23:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98DFD462CF3
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Sep 2025 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C2C25CC58;
	Tue,  9 Sep 2025 21:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQnqVEnR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC719257841;
	Tue,  9 Sep 2025 21:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452369; cv=none; b=NoD4Bm7+MvaymnsdIUGtlp7bMSebPgydF09Db8gVIEElF9eYd5U1J3Mzqx5xR6kGPLTypLeRC0MH44f/nGtSrnkaLQSE9O1zuwukOEg/CoxumTG/sql8hd2cpeoC8mabhC+Hox5IFJCele95Ois8rIDDzadsJEDA0robuVKu4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452369; c=relaxed/simple;
	bh=4+rg/Gz1eysCw1FZDc5FEYkSkFXM3WUQDHMPBqpsv/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g/KfFBlLV8SC7A3WeDPa/xegI7kyZoy3n65iiu4tATdllPi5ljaFLSCSObAo6jbEpE3Kc3IWuPVAKLJRtiKVdAX05iYdB1pfD0hX1y9vSQrEDCnvzsWgigCtgGx4IWdIgLexQu34BUUPraqLv/5/JxPaBnHguts3hqeBWr0zEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQnqVEnR; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-336d3e4df3eso48310461fa.0;
        Tue, 09 Sep 2025 14:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757452365; x=1758057165; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n+8+LQrrI546X3g2e/jgKl85KVqcdJ2/SBcOSdSAmgA=;
        b=bQnqVEnR6slQzAC/+tQERGj54BDW3HB0FSH1WxBxdizYSNP0FpokKPhdr2ez45fHQ7
         UIswaoBUR6Ics2xmBW6DdbgHMV3/w8OpmXMSM6J1a0FH5x3rNzobt/pcKf4fh46aO+JD
         vosqRri5xzEYp7o7+MBRzIS1S6vALKeO+wuwfsvgwN6m2PCUJFqc0USciBBTIvGg52ti
         iOQZX9YHvzb83D2OLYb3SzInLeN4MPmOq4bCKbgH+yOMPYWLeRb/hxoZnmeEiVMBGcy/
         HUCwtZ9lMBr9aF94zCDDCR9zidwJQPZOK/fLvZoBF0qiQCQ+eAbqLm6bN6Bn2BlxScUK
         4myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452365; x=1758057165;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n+8+LQrrI546X3g2e/jgKl85KVqcdJ2/SBcOSdSAmgA=;
        b=V/r7PRIkkq+nVRNUkScN/RV01tzAJZicaVZPrKsEezQkkDx5CygoQdI2zwaUNom778
         zcYazMzRyD69p6P0XqksNcM/L+x2i6ko+I682nm+Ml8VA92x3jJZ9aX8NcbxCjGtF/fq
         H6zP6icUp1XD0TyT5i+Hk+kIVgkPIIGE6s3MwB9ZSR7WSbHRgN3gZ7/bj7yXMVChGZw8
         MPLtRjd+3tqBU+ReqbIEVI768k/00emXVOPCpET7MRi5rWdkYEZBNBFQo7eQajEXe/ja
         YPl8d2VkCPEN+dOFZR4hLqnnT6pMkQZMfjb6KQNXUeGBa0KOqPgEHXgRUj/HlfqAFM5u
         quhg==
X-Forwarded-Encrypted: i=1; AJvYcCVFCwA9TH1FNyjomJG87Jxabjmb73B/eQ2FP1qjHd66egfPDyPWgK97IPGuFeFrHcx0SmJagMzGG0ILkM+/hdqR@vger.kernel.org, AJvYcCWgJVMdYD5Yl+opRkCXNwxC2SSGJF+cNsirDlZQEGnXmaEo2c+d4s/f2xWpWxR78qMwP2ZfserM2wDCMNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLVeAZKBj2SH371XkHTds4vDfU9aPxqLFT/vJ70XuTcd9xfaia
	BuECGl50e0CK11hNb2GZixzZTH1RJtzsVgrK1LY/2LWqrHs72kupA1/H
X-Gm-Gg: ASbGncs7goXT1bGNEArJhqHmVmcMITCQenHBH5gKkILkzZXZQn4JUBqVEvTWEZBPGfj
	jIyKoi7icaOYkC2synPt1k2gSC3X7p7JWmABZyFc99FYDqw01pvn66VFwQPh43qfmv2VJ+O+Ft6
	PgS03eFv/q3Cu6S24M2WgEefyLWJnyIOnJl9hbRpyxV2rZHhuOUssuovifBf4dOjcRKHJGLHUwX
	IeFLSebM/abmkAA6p71vfnJz61MSQ4DPQSue+vqke6xZVVuBoeas3GlgVpzUuucFS1jjrbn6Gzd
	J4jntkXAzrGCrgqxqDebQ6S6mzI5ZxpWZGUHcSArJNd9ednREsO1Eq1bW3M2mNJrzu/WdTLjXnY
	IliLSwykbIt1h6Tfb/Cu6h4ZnSLF4D/1cdWADbw==
X-Google-Smtp-Source: AGHT+IFNdnuSlcCf9z5tlEG4Y+joIUPcoc8wEZ2rqt5baB6HDPfj6AWR9UB3RDUwC665DYY0yF21PA==
X-Received: by 2002:a05:6512:1289:b0:560:98e4:c986 with SMTP id 2adb3069b0e04-5625ee79705mr3899930e87.11.1757452363844;
        Tue, 09 Sep 2025 14:12:43 -0700 (PDT)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5680c424fc9sm757025e87.9.2025.09.09.14.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 14:12:43 -0700 (PDT)
From: Andre Carvalho <asantostc@gmail.com>
Date: Tue, 09 Sep 2025 22:12:13 +0100
Subject: [PATCH net-next 2/5] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-netcons-retrigger-v1-2-3aea904926cf@gmail.com>
References: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
In-Reply-To: <20250909-netcons-retrigger-v1-0-3aea904926cf@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757452359; l=8957;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=4+rg/Gz1eysCw1FZDc5FEYkSkFXM3WUQDHMPBqpsv/g=;
 b=2rxZt7WzGX4NPc/Vtrz6pbHcle5yTQBQ7lceEbPuE/xcblIIQ7w8/0BQbJGMYGSz3N8DS/Dih
 o1ysjeGuCQcAET40BsnZOpgxxA3CY9oezDqBREZvkt/WGYIqBQkKL1V
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
index b5e6a9fdc3155196d1fd7e81def584360ecbc3d2..688ed670b37b56ab4a03d43fb3de94ca0e6a8360 100644
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
@@ -1315,7 +1317,7 @@ static void drop_netconsole_target(struct config_group *group,
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
@@ -1711,7 +1713,8 @@ static void write_ext_msg(struct console *con, const char *msg,
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list)
-		if (nt->extended && nt->enabled && netif_running(nt->np.dev))
+		if (nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev))
 			send_ext_msg_udp(nt, msg, len);
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
@@ -1731,7 +1734,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+		if (!nt->extended && nt->state == STATE_ENABLED &&
+		    netif_running(nt->np.dev)) {
 			/*
 			 * We nest this inside the for-each-target loop above
 			 * so that we're able to get as much logging out to
@@ -1887,7 +1891,7 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 			 */
 			goto fail;
 	} else {
-		nt->enabled = true;
+		nt->state = STATE_ENABLED;
 	}
 	populate_configfs_item(nt, cmdline_count);
 

-- 
2.51.0


