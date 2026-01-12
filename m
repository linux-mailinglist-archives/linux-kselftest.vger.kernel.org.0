Return-Path: <linux-kselftest+bounces-48726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA6DD1190F
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ED7730DB576
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0535134A766;
	Mon, 12 Jan 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CP1W1YRB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068B934A794
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210875; cv=none; b=ACXpT0UoMcRYInGh9YBRCsHbRPbktEUJWKamxwYQyXDSNd8AqvbCsyv/6CW1gGNFsRyR6JDZ15MdHRafA3Vm2HLs90cKuVXEuFDSuwhuCfZz1BYYgD2HGLxWq7ra811m19hvYTH1ZXxBy4jbwctyjiIBHsj384Z13lyUhQf4wys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210875; c=relaxed/simple;
	bh=4PDwzlCI+jgQG2jAxOz1RlldCa/d+sKTSpqV/8xAtWQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z+xfDs7yykuBNZs3OROpHoPfdD1HeAAbU3DHbbdmmSIDolFVyN3De1UsR6J0z8hs6qm8LL2vClGMBl6X4RAVNbdArnTLPrpazkSs4ixvS+JD1uoy384lGrCKpmvgmEdbPR7Hazyh+wNM+6KFAReV4In3I5yjlqy2Eb8Dh35Xj6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CP1W1YRB; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b87108066c3so126399566b.2
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 01:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210871; x=1768815671; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JUk5UFagcf4IlgTEQ/iWJeI/RTRWAeLpBdR/nh29wa0=;
        b=CP1W1YRBqH28++jUkgZTj8LAkP/GZMUv9QQ0U11NTSCox8u1JhWxFo4w5mNlsD3Bbn
         ef1NAZ1ZMDEfPr1thjg/8lkqcklFsI6Rrrsa7YySNtLv3xkIs4TPaapPg7FgoTXV0i2b
         JFQeerSzvitrCC2GIgDzVLmSblTXkr7rQ66iWbyezsAmGlexfPn4QoTZNZNu1byp1Xw+
         ytblnP3PS+BLIL5MxuNniJg96VJEiAr/Q9BL3hcVGaw2gEfMhfhpNjakJ0UY3vrvyLoE
         6UFqm0iSTwnCqDFjtolT4g1P+Y5U4NrqyUss7WGjE+AH1u175g4mOZWF+O+dqey5kApw
         UB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210871; x=1768815671;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUk5UFagcf4IlgTEQ/iWJeI/RTRWAeLpBdR/nh29wa0=;
        b=EX4R21vHY3k5SAEjIn35mKuSO6cH6UAYIf/X++imqWDkp1MDrrkFE/8nfU9TDsD0xV
         UorbPN5Q9FqkeeQUFAODNf5miF514yEQAQZlvmDxIVZjfcgxb2ChdRBUTuhrlu36Vaq7
         FN1L8e8bSYpwQQYb8vA6l/ISv5rLcbCF5pTLO6AXkncqgtgyguwa/Ic7b4f3CKb0xXNp
         827hU7+S457ZRQs2X8Nul7ESwj9uKis4sARGOao8lt5hq1ig5xHCX1voArqXMRuzWpR+
         gCDsGBgrzE/qgOvMWKCEVZsJJegKaBLUILSDJ0X/5E8aCPNW5zbfHR//HY8mnLE9QPOG
         ngqA==
X-Forwarded-Encrypted: i=1; AJvYcCWnW6/52AupHjY0b3LfRk6z2cHZAjtTJS6r50hl0CWgClhKH/xiRYdBGsL6GX1u8vvdsd3Xn0r2b18OKv7zGn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIG6bJdtfwQZemAzoV7Z9zs0e4HuWytOBiVXUDgTmTTtc8PBrs
	zwffZ8ZSkk1QM4x5rmY4kcnIca8TRGgJ2xs5CSgK71JMW+ZFWRi1lYsk
X-Gm-Gg: AY/fxX5O0DfkXpWgRCwdVuOAhwBO66OzTiSk0eslUAk6OcKYAp2VWENdvuyGXkofxjJ
	r76bYhQYGlRsjhjU8/gsXXNVMHwnbIR5L05hapP8Nr15QEmSbrmadyszi9t4A4APxz+TNTuIKyP
	D8VscTSRKLFMcMjPOFID2krsS9J4i7UwJasQeszH6HpIqtIBibsfdxL6x/fA0CzjI+Y3WklFJr4
	5XLQhn0flipmQr0bQuMkH0OicqKV8+px7DEhP2MkxvRFvzTJTSJjWJ3ur12J3M/BpDj7AlzD+t4
	dm0yvpV2DyGxbT9/gWAyip4yF+Vulhyca+yJfpewGbENh5p8QSqIIMzMGByO3HhYUWX6Kr8OCwt
	AqpMquDFKo31KwGJzEbyag5yCv7ODhtwYHUwT6yHXLjsY8P4iy0LGqWoNZTqzqbq5ovGvC1Y04Z
	PksA84aXMsm4htfg==
X-Google-Smtp-Source: AGHT+IGfu0MEaKm02og4PRIdkU25LNt7R3xUh98/HDOVupGAYQsgmsCOt8w9NasdgiB0ElxW68uXrg==
X-Received: by 2002:a17:907:728f:b0:b87:2410:594d with SMTP id a640c23a62f3a-b8724105abfmr146423566b.49.1768210871030;
        Mon, 12 Jan 2026 01:41:11 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:10 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:56 +0000
Subject: [PATCH net-next v10 5/7] netconsole: introduce helpers for
 dynamic_netconsole_mutex lock/unlock
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-5-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=12692;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=4PDwzlCI+jgQG2jAxOz1RlldCa/d+sKTSpqV/8xAtWQ=;
 b=+aIjU9q1palonE6THhW2JxSM5iks+VY4Hy6k9bvifYU19Y8u2cvrbdd/JHqCM78jR0shHr5eF
 if39/p0L9EPCBkPld4+rruohaANKPVlHcGPZ7FtdhVmp6BX/A3XxKBD
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


