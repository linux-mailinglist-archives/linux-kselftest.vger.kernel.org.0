Return-Path: <linux-kselftest+bounces-46226-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E236C790EE
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 13:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A518036342A
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 12:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E09334C32;
	Fri, 21 Nov 2025 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu9wWn16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAECD30CD8E
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763729369; cv=none; b=DCRp9w9bi19wdkuMOubg3H9Xa0oG0CmMWxvTZ/13Vy62RiBPJGJ5iBxCvPqrakjL76W614m6VEfQM3JnD893aSNp/d3rQl2MpAwRUctQxh0zCJQuo3HOh/GCockM60DRqsZhOaH7NkW93hYOAfYgBpTguo7B0y7JuzvtkgXmHGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763729369; c=relaxed/simple;
	bh=943o/E3WhvuTJbGcZYEZLtSogyGbkwqMFYHMQzSvjCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtPI86Z86LySqVen6V1nLt/8YTyBrZqk7VJ/WjAbH0oX16rfcb16tBGNeEREdwSzZCD6bA14m5WYrq0DoYQqfCbsmD+foEu9hkaGUbKZx4reb7jU//89yRSCwsydRCDLF1jv/0c4/pLFWNUthxzrKTyTaTx4CMYtimvcbY3Djtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lu9wWn16; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2958db8ae4fso20131625ad.2
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 04:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763729367; x=1764334167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XOi063mzQTa4JvkotZ6ma8LlWFlm5oJE+mks/V5WdV8=;
        b=Lu9wWn16PVB6a9HoxOwq5W6bKhvhTF3aj3Spc33BeHpTWNRVYQ2corj3IPAKX84LLj
         Ea67JUHp7QYtttIQvje6OmkM7OjUOPzGlZ4VwLg7+SrPW+3FI8EA7ATCkX7XlzTN1sAE
         6JYREnbkVKTTRvWGYBOVPOE37ACs7Jo//z1IRNqhyGkIhoeOXDLLJnAa+2/OZW7UPGvJ
         96A7Ga6epPN3AXSNYcs7cUyfjiCQZvRpD7YkvKLe9geAdebfq6knNmdQZVqtrTGD4DsO
         Gw2k1Yduq50gZLQWMw/PakySb4i6AxVZFRpQB+jovCYDN22OQmDN9+It5+9n1L9jX2qc
         +lSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763729367; x=1764334167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOi063mzQTa4JvkotZ6ma8LlWFlm5oJE+mks/V5WdV8=;
        b=ribudimv6ZXBbMT7Y/4VR3Y8YpINn9UrSOp+KpTm8zLlnq00mkD180+wppiTtfWpFd
         OtqFkbg3I4v9BFdRyRr6HxpecBhohcRhs5Yu0/vQNqp7nxV12Gt2RbSSdw46DRnmzStW
         Ny4xqc8haV8T5rMoB8n+HdisJD7mOlmmxRpPQ9J48tgIqSoXaj99pwf2JzmTBNRFOU10
         KlEEiyPpz5vb6oCKf4qdHx056T0QJrroQzS5iomB8qiIyzDCt0E9NV+yxYV6cxt6uf5b
         MBKJuwNlnA6Xz215QvtPihJ8wRXud9vFwFIGP1LDo7khAh8IcdZQS1iS1RqZxleJp8R4
         3cog==
X-Forwarded-Encrypted: i=1; AJvYcCWzRhoI1nuRR0Wn1WfF8t4Mc6cKoxpAP538tGTpzUprRrrsgwDe9peTC/iHh1I9jz0n2z7n7ARY/Qi6B63Ab0E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymaks5js8qdW2vMJjLjKVtlEFAbKPvQf0fx2LEBTN7s6avnhrE
	OMJCnRV2Jgl84yKQe4FYEl02dfIuc68FL/Zz9mEq48bj14fb0XZldSvu
X-Gm-Gg: ASbGncu3/4mr3r1ppxAq7+xjWSlhrPBJZ0hA/k4tUEPELiEBPkPmfVMaC1ZivsSBPt2
	rKuojYK5Mh0B/V5iYnD9Si4hfXl5f30FGsXh3wq2XR15IdEtZ49aUyPvGAkdH45PY7oNYd3suBU
	hC1mu2MbfNdfruvsLnzSYdTrJ068scV1XWepcn0HOu+eboOi8yYQ0Rkhs1GUBVtf6TNR0O27UO6
	ve2fIDVLYDHbbVnu1sJQ6SvgwAczpiY/Xt61dhvpWIlny7HylP9VtiMdEhUrBHgQnsQnpWYiuxY
	tbWGa00s6QJJdBriVQJRornSskznfv16IwEtPphKeTCLBW0A3ZDUrX6MD57qxsBqVr7oHOKExUB
	p3wRZg64IW6j1+RyNbNS8KAbfJnGSjH+MTjFNYq9gwaG+zwXjCwhsUIo+HVALPn9+y0oY3Xgo6s
	gAwllmBG7IX+PKIQaG
X-Google-Smtp-Source: AGHT+IHZjut3DLUP7fZbcavzB1Ab59YsXD493M8mvRve2OHuj9woOxQFvnDZ0vVYtMS9y3UkFMvdhQ==
X-Received: by 2002:a17:903:40cf:b0:295:105:c87d with SMTP id d9443c01a7336-29b6c571898mr26619785ad.32.1763729366824;
        Fri, 21 Nov 2025 04:49:26 -0800 (PST)
Received: from [192.168.15.94] ([2804:7f1:ebc3:6e1:12e1:8eff:fe46:88b8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b274752sm56644045ad.75.2025.11.21.04.49.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 04:49:26 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Fri, 21 Nov 2025 12:49:01 +0000
Subject: [PATCH net-next v6 2/5] netconsole: convert 'enabled' flag to enum
 for clearer state management
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-netcons-retrigger-v6-2-9c03f5a2bd6f@gmail.com>
References: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
In-Reply-To: <20251121-netcons-retrigger-v6-0-9c03f5a2bd6f@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763729347; l=8901;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=943o/E3WhvuTJbGcZYEZLtSogyGbkwqMFYHMQzSvjCQ=;
 b=1HmsMOFjyC4EL1ONKMO0gUZ6h9k6a8xv0LG/leSVTvarJv5GXc1J14zSO1Kr33ZWmyYhtl+SF
 M1QmWAvoBb7C8+03LdQJI2K3v/VzlgOsmJDl8W8J9qx2PUEXmuNoah1
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


