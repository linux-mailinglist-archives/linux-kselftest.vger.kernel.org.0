Return-Path: <linux-kselftest+bounces-45194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8054C43C58
	for <lists+linux-kselftest@lfdr.de>; Sun, 09 Nov 2025 12:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5321883FAB
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Nov 2025 11:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02CE2DE6F2;
	Sun,  9 Nov 2025 11:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbkYDuwc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E922DC331
	for <linux-kselftest@vger.kernel.org>; Sun,  9 Nov 2025 11:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762686381; cv=none; b=GdQiGwIsAGq6heSJRy6+HcWH7/aBgitgEi+IKHQhmxSvDQwdoFWueDt8N7kua9T5p0eStDspgM/nbhymnQQMEc3I/i44rDHudG9tpNoyoJx7NXVeY2fgUNRd4PQSCPLjX6ldgsdGMuqK1CSxAMrRU85OpWRpGsmAEgZoir7HENM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762686381; c=relaxed/simple;
	bh=h/WMgGuer/rTaYwZTdPaPC720ScIfwyjdiEy9wHdF6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l6EO8R3pJ1U6F9EjLHRP1igvj3sEQ0/8Q9olCIn8FoOEX2wH6Zzq4NfCu3NAtqIemEdDn8dUpC6v+Z86Vz6+MtWFygv5c9janozEBv6gzUu1ZpxpLY28FpyZKjZbx4Ty98JAOn87m6eZRenk1CvyTfZ08anpmrXF3PsKL0VBVDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbkYDuwc; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso10331825e9.2
        for <linux-kselftest@vger.kernel.org>; Sun, 09 Nov 2025 03:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762686378; x=1763291178; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64c74E2vcVe9LLOPxPVEYauBTLRgO0onhWdcRTaSbWE=;
        b=DbkYDuwcrmd+SkCfRetlyfl+3I1xxmhENz4n4a8NKTOeCqE5DNTj985zoscu6z2KSM
         rw2l4SPhRx2lw6cOUzAHiHDrlrJcY8MKMEwhLKBZ1dNvh4Qthppi8GMFr5wqv04CkIhW
         fv/hUmhLpVBfcYm3CPI8yAYiGREl7wYtIvCutdmEd6j8WTjJiiqcGEAdolwHD6xYzTcZ
         o2162+U53EC7vfybHYrpPCXmezkHzxjHX5tkVS1EJW34OaHcGuz3kvpQNy29qyGpufKX
         5TCDqimIY5DJollXXH8PyokDkOZ6h8KBEKXBqoZIvjJLEw89Dr/tBkFkSaUVX9CD+30L
         gTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762686378; x=1763291178;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=64c74E2vcVe9LLOPxPVEYauBTLRgO0onhWdcRTaSbWE=;
        b=WvrC6BsNqOWFr0xT6Ci3bGUnHNSbtSVuMfHkVk8YrZu260bvJw5Om9U+ioyzgKjHDk
         pWVFDhkFxNBmXsVgQgzA6N0mwTr8V6CaMAHzbaql3HhQzC82DHzo32h6CuRUZzODMnYc
         S0J/RQdbvUrfBc/bwL3l36AAPBDAujIbVMjoeGLNvX73bzRtm7JK2ZiZvOXaA9eQtGOE
         2jqWUKjrS3ZwtNkntBKWPnWRdYyzVyksSU1sw/XkVYOt3t9lQ4u5mTW+3caTYoSzH0Gx
         Q2zriYoTpduNzi+5OaaWDrGhoE/QsG6IsQkTITDkoAqH9uxI17iECKlDGGokgvHG6pgC
         OH4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU79HEqGS64pRWi/6szaoOHI+0MKBapQwPFPpviBSuhJufZVIj/Jq6gY6XtSP8Ix4IVJNr8Jb8j1YBwZzfFJuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQR0a015zPFuM7Nhi4+PGXD218Zc5/0Hj266BmbG9XISCIVDZ
	DrztNUw1V34pOwoZ2ifbX5afcdF9pn9OXWpOV+1Hgf0bUgzjCvM3wgtZ
X-Gm-Gg: ASbGncuEf2ih5eoZLj4aLTfRj+OCcmLhx50bWhKhvK3wjk6BpmBwfkCLdxZggjXkUSt
	xBEtixacVfDCjgDLWQiO7drB8crAvJ8oTWC10r/QUl6muW6wt0Mur+xnqWhkUOUQM2mYlPJxFR5
	NOH00gWi3RSC6ocmRC4FrOuG1RG+3H+x+g0xTyU7Hgv7ZQdp+TvC9aKwZBYGwQPDsqPmpqBgYQC
	mR/+Ma47l5Azg1kaiZsOCAFtslhTX726Eb8mL01h4j9hd3rKXB1Hhsw+QQBhO19QQnf3FZ0OUbR
	7UF3xYyUjxMiFyxc5LiMMOsmLwSUXEDI4K9CTHDVxwSf+hjmO7IZDnReYC8ATRmz7N5qhMhj7rh
	WJPWCNPQG5rpS08M11gTH8o4egzBv+0nKvSGR5CjeVoyBRtE233BQf6CwJjDktHdc3VhCsm3f0s
	bUhGA1WHQcApSIOJ4=
X-Google-Smtp-Source: AGHT+IElNeJQDYPuBNLWxLepB/r6OhpxlCq+w+1c++Q3X4zRKFwmD79E2oW0gj0qD1clRNtZWMhpXg==
X-Received: by 2002:a05:600c:1912:b0:477:7946:dcf4 with SMTP id 5b1f17b1804b1-4777946df44mr12371535e9.24.1762686377258;
        Sun, 09 Nov 2025 03:06:17 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b316775f2sm6354925f8f.16.2025.11.09.03.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:06:16 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 09 Nov 2025 11:05:52 +0000
Subject: [PATCH net-next v3 2/6] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251109-netcons-retrigger-v3-2-1654c280bbe6@gmail.com>
References: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
In-Reply-To: <20251109-netcons-retrigger-v3-0-1654c280bbe6@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762686373; l=8901;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=h/WMgGuer/rTaYwZTdPaPC720ScIfwyjdiEy9wHdF6o=;
 b=VAchufCNgG/NAzO0ZRSXPzdMA+wl8320gdAokMA044REpEazAIMj2itMKFHH+aspzZ352NXxh
 o02VWDApaRaBMPOJ46tOsnp9vDclUsbecYWznIXB9EGoK7uLRYi13lV
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
2.51.2


