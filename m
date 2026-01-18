Return-Path: <linux-kselftest+bounces-49258-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0625D39466
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 12:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D2A430492B9
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 Jan 2026 11:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DAB32BF43;
	Sun, 18 Jan 2026 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzeORgji"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587D32AADA
	for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768734039; cv=none; b=FjHdAbAqgAxvNfB+E09+pV0E2zpAFMJnowIGTj9H73lBloGUHLEeBKvg4MJcQwbJZANm5nPdZavU1V6j9MenFdX0kzQo0EBo5cczxcmZframQO/VeXdorBvDERSDTf28NJlzqQYRaKztXBzd/58+pwMSxdbrvjuZO0l3ts55+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768734039; c=relaxed/simple;
	bh=4PDwzlCI+jgQG2jAxOz1RlldCa/d+sKTSpqV/8xAtWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GpWTovHZom1MEpYWzS8KrzhK1cE1Dq0qCDh4TV8edAnbd5sLnLvFuVQ5aC6y0ARqDRvOZdzBNbWOOFBdlx/xO8BCr5icw6JG3xmA+4lt4o2lQ9WP5nC+tbh3VfIR0zuNQVH/bmM+ojRiOtZG03l4ImETFqbWO5w5xDX3+gTVUCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzeORgji; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so3073236f8f.2
        for <linux-kselftest@vger.kernel.org>; Sun, 18 Jan 2026 03:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768734033; x=1769338833; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUk5UFagcf4IlgTEQ/iWJeI/RTRWAeLpBdR/nh29wa0=;
        b=kzeORgjiISvpqKR3m8sKjLUxWRqK13aUdgUcsnmPrhk6UWBGpX6b5UFKyUB5YE207n
         KLikJVpV/jJZZV26tn8o3OXz1hRbVbRN9a2s/La/XY54DKu3R6/XUj6iFS4U+VFAONlQ
         6TDpl5DhvG8mnoypQ1CEUIozWY7raGEbAgc5SvYn2rKubHV/outZuCIZZKNLtR7+kxQl
         dJwnZzeEDeEF+8DlOnAz/h58i2bUSrIC/xlFo+cRogTSgpF2KCAU3dziIW/ocF2T8MWX
         f5qANr+ozzA+23GdKkAxYOjIAHct1RX+4VSUdqbgw6rPMHPVmftzbxaBU444hPUTI+Ew
         sLDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768734033; x=1769338833;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUk5UFagcf4IlgTEQ/iWJeI/RTRWAeLpBdR/nh29wa0=;
        b=uX0Fs/UnpnAvxtaXmbqSIa8tWROVszHsrgq+3dR6CLQqYv5a7ZxkV+okrPlIX+NoOG
         mmShxpTyYbs78Kx1znEe2JOMe9JCruDwYDurLgpxb70ZKIddqJ53BjxoIwaStVdai8Lp
         RX6fRVhTFQ6u9F89flUqMeu08hzEO0hbeuMxfsTB77VApOrpoI50UI7jKCJr/tecZFg4
         GNsZI7MmaJ0N1VAE5/WR2CuskeSDJt0F72Itfn4QjWtoJNfq8lMwiSexn6wcomUb8Dqp
         CGRPl3E37M6ZZbwylaSHF5Zb0NUauHG4kjg3nzKZDkB+8hpYEcQeEVGm/c9J1HQFHhhM
         NQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiwYwngUP6ltPfo56oo5hKmgOHqagpnF84PsUOT6x5pZ1X7ohOokwCrHGvR0tlCPxSoN7+DN749rxFMR9Un+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx96ldyj1sL1xsjaDlgmn2Z/ao3MZ5LtNLrQxMXReNL28bclxw
	phmY+O2J90hfVqOpxdHl6J5N4/y0+OADNCzDgNik9++GNZnsOYjew1rG
X-Gm-Gg: AY/fxX5GsWZwJePSCMP+VXQKA6Ts7oEI44X2ADkSjQuEJfFHIbw9/0GT8v68zd2X15x
	SRgR3pw9jrDDwvmgKUhqMh5LZzw0l2NWddhoQ/Neo+pmQrrUN5eOpxa96tii4+itMBFK9YGtukh
	9+HyvSPnn6KMe8e7Sro3wgWR4f1gtIFRhnTjBCKTeopOfh4hc3ffRYGKoekV+QYdDEUU5uj4zvk
	BRCUaC6FHixxmSbcsy8OvYJVtIza/Q+VhwPgMLG6Wz5FqUh25QzeH5FNqsaJWRFD1MjkFRsYWyn
	BlrFbGCeWBEshEJ4SpHJRjvlrY2XwnGr3TDjYuEc3vrAESSjJZVGvnSn9IjzJ2G//ZvSmHJz62/
	FpHUPuGGe53rDV+T3Q+lfCdKldTcDvy1fYh8bGZ3vNXCKn1wBcDjJ2p4LPb39+M8vD+7pOhxGRO
	svWsqqVKKDSqTQag==
X-Received: by 2002:a05:6000:2893:b0:430:f72e:c998 with SMTP id ffacd0b85a97d-43569bc59abmr9967735f8f.51.1768734032489;
        Sun, 18 Jan 2026 03:00:32 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm16864635f8f.2.2026.01.18.03.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 03:00:31 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Sun, 18 Jan 2026 11:00:25 +0000
Subject: [PATCH net-next v11 5/7] netconsole: introduce helpers for
 dynamic_netconsole_mutex lock/unlock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260118-netcons-retrigger-v11-5-4de36aebcf48@gmail.com>
References: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
In-Reply-To: <20260118-netcons-retrigger-v11-0-4de36aebcf48@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768734024; l=12692;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=4PDwzlCI+jgQG2jAxOz1RlldCa/d+sKTSpqV/8xAtWQ=;
 b=n1tlGfJ0dqCeUafoiYG6d53iNV8/9mZo3d2HkLXyTSrR59v/rV15yYLeNpuN8h7pvpZl5SjU4
 rjVFCtHsJ4yAdxfW/UQctV6IqTzCJi77U7G6Q9MF3GqUmsPz0MXBv6K
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

This commit introduces two helper functions to perform lock/unlock on
dynamic_netconsole_mutex providing no-op stub versions when compiled
without CONFIG_NETCONSOLE_DYNAMIC and refactors existing call sites to
use the new helpers.

This is done following kernel coding style guidelines, in preparation
for an upcoming change. It avoids the need for preprocessor conditionals
in the call site and keeps the logic easier to follow.

Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 97 +++++++++++++++++++++++++++++-------------------
 1 file changed, 58 insertions(+), 39 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 02a3463e8d24..46d990f3d904 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -213,6 +213,16 @@ static void netconsole_target_put(struct netconsole_target *nt)
 		config_group_put(&nt->group);
 }
 
+static void dynamic_netconsole_mutex_lock(void)
+{
+	mutex_lock(&dynamic_netconsole_mutex);
+}
+
+static void dynamic_netconsole_mutex_unlock(void)
+{
+	mutex_unlock(&dynamic_netconsole_mutex);
+}
+
 #else	/* !CONFIG_NETCONSOLE_DYNAMIC */
 
 static int __init dynamic_netconsole_init(void)
@@ -240,6 +250,15 @@ static void populate_configfs_item(struct netconsole_target *nt,
 				   int cmdline_count)
 {
 }
+
+static void dynamic_netconsole_mutex_lock(void)
+{
+}
+
+static void dynamic_netconsole_mutex_unlock(void)
+{
+}
+
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Check if the target was bound by mac address. */
@@ -495,9 +514,9 @@ static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
 	struct netconsole_target *nt = to_target(item->ci_parent);
 	bool cpu_nr_enabled;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	cpu_nr_enabled = !!(nt->sysdata_fields & SYSDATA_CPU_NR);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 
 	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
 }
@@ -509,9 +528,9 @@ static ssize_t sysdata_taskname_enabled_show(struct config_item *item,
 	struct netconsole_target *nt = to_target(item->ci_parent);
 	bool taskname_enabled;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	taskname_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 
 	return sysfs_emit(buf, "%d\n", taskname_enabled);
 }
@@ -522,9 +541,9 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	struct netconsole_target *nt = to_target(item->ci_parent);
 	bool release_enabled;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 
 	return sysfs_emit(buf, "%d\n", release_enabled);
 }
@@ -562,9 +581,9 @@ static ssize_t sysdata_msgid_enabled_show(struct config_item *item,
 	struct netconsole_target *nt = to_target(item->ci_parent);
 	bool msgid_enabled;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	msgid_enabled = !!(nt->sysdata_fields & SYSDATA_MSGID);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 
 	return sysfs_emit(buf, "%d\n", msgid_enabled);
 }
@@ -584,7 +603,7 @@ static ssize_t enabled_store(struct config_item *item,
 	unsigned long flags;
 	ssize_t ret;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	ret = kstrtobool(buf, &enabled);
 	if (ret)
 		goto out_unlock;
@@ -660,7 +679,7 @@ static ssize_t enabled_store(struct config_item *item,
 	/* Deferred cleanup */
 	netconsole_process_cleanups();
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -671,7 +690,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 	bool release;
 	ssize_t ret;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -687,7 +706,7 @@ static ssize_t release_store(struct config_item *item, const char *buf,
 
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -698,7 +717,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	bool extended;
 	ssize_t ret;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED)  {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -713,7 +732,7 @@ static ssize_t extended_store(struct config_item *item, const char *buf,
 	nt->extended = extended;
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -722,18 +741,18 @@ static ssize_t dev_name_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
-		mutex_unlock(&dynamic_netconsole_mutex);
+		dynamic_netconsole_mutex_unlock();
 		return -EINVAL;
 	}
 
 	strscpy(nt->np.dev_name, buf, IFNAMSIZ);
 	trim_newline(nt->np.dev_name, IFNAMSIZ);
 
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return strnlen(buf, count);
 }
 
@@ -743,7 +762,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -755,7 +774,7 @@ static ssize_t local_port_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -765,7 +784,7 @@ static ssize_t remote_port_store(struct config_item *item,
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -777,7 +796,7 @@ static ssize_t remote_port_store(struct config_item *item,
 		goto out_unlock;
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -788,7 +807,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 	int ipv6;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -802,7 +821,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -813,7 +832,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	ssize_t ret = -EINVAL;
 	int ipv6;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -827,7 +846,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -848,7 +867,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 	u8 remote_mac[ETH_ALEN];
 	ssize_t ret = -EINVAL;
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	if (nt->state == STATE_ENABLED) {
 		pr_err("target (%s) is enabled, disable to update parameters\n",
 		       config_item_name(&nt->group.cg_item));
@@ -863,7 +882,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 	ret = strnlen(buf, count);
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	return ret;
 }
 
@@ -984,7 +1003,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 		return -EMSGSIZE;
 
 	mutex_lock(&netconsole_subsys.su_mutex);
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 
 	ret = strscpy(udm->value, buf, sizeof(udm->value));
 	if (ret < 0)
@@ -998,7 +1017,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	ret = count;
 out_unlock:
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
@@ -1026,7 +1045,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 		return ret;
 
 	mutex_lock(&netconsole_subsys.su_mutex);
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	curr = !!(nt->sysdata_fields & SYSDATA_MSGID);
 	if (msgid_enabled == curr)
 		goto unlock_ok;
@@ -1038,7 +1057,7 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
@@ -1055,7 +1074,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 		return ret;
 
 	mutex_lock(&netconsole_subsys.su_mutex);
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	curr = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	if (release_enabled == curr)
 		goto unlock_ok;
@@ -1067,7 +1086,7 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
@@ -1084,7 +1103,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 		return ret;
 
 	mutex_lock(&netconsole_subsys.su_mutex);
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	curr = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
 	if (taskname_enabled == curr)
 		goto unlock_ok;
@@ -1096,7 +1115,7 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
@@ -1114,7 +1133,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 		return ret;
 
 	mutex_lock(&netconsole_subsys.su_mutex);
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	curr = !!(nt->sysdata_fields & SYSDATA_CPU_NR);
 	if (cpu_nr_enabled == curr)
 		/* no change requested */
@@ -1130,7 +1149,7 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
 }
@@ -1192,10 +1211,10 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
 
-	mutex_lock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_lock();
 	update_userdata(nt);
 	config_item_put(item);
-	mutex_unlock(&dynamic_netconsole_mutex);
+	dynamic_netconsole_mutex_unlock();
 }
 
 static struct configfs_attribute *userdata_attrs[] = {

-- 
2.52.0


