Return-Path: <linux-kselftest+bounces-25906-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A3A2A6DE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93BE27A2EBA
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC32422F149;
	Thu,  6 Feb 2025 11:06:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC45122DFA7;
	Thu,  6 Feb 2025 11:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839975; cv=none; b=G06rOyTbymzwTC70+RViq3SoWShZ6C8hbVj/r5/TofGa73btozFS0KzrH7gRKvHCUJhTsYjo4uijYdQkyu+tk/f2ED0F79yEVOr6Xzhx3U1c5XnXuALMGFcxtNdhiuhrZno/KK0DBrnF4w1WSPFEuMUUI0IrTqq9q3n5egSbe9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839975; c=relaxed/simple;
	bh=8WgGoItVdHl9J4C57gZoEzhi4IxKCuC308ZMbUO/wIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X6fIRa3p81XWEy3Pwg2mBEvl9G6c8s3kglzHG/xcBDAX2qvukX/8j/loN9o9YU+koB6cuNlu28o/fAKgQKHrbmXG6w5YA8sJdtKHSVAxfWwR/EDaLB3NdZ7Gt61oJx3bbK/OQJJJSRFXvxboom8Am7rQ9LKN0VcIJ1m3zgeiwZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ab77db6334dso34595466b.0;
        Thu, 06 Feb 2025 03:06:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839972; x=1739444772;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHcRRqsjgJ8c783nCO10r0mtRcmvTaVMkiSUk9PgkzI=;
        b=Ny/98S8H2ilpBjqJ/simBTSshAgnTn3qqPTRPvcx51GW4oaNibyQ22wlDZbWxwUpjq
         YJZviBpC756elLbqNEjbcYnBPvW3AkNfwfwtLYS+rkbTkPT39LQSHCkSmZ1iidLemVxk
         QmCpNtdwlsSOrBTTQ6Al9OcBC7NCZEjLxsRCXssMNS84+jKWdTTAmBifBsar4ZRCRi9u
         mwN4JAPMFO0fZo2TpVBE2CEcK76pNUbesTqvbW8A+0l3PCZSz8koyEgoAKDErCAM3C4Y
         hhxhi8umJDsDYQ3iHxBacYLELsLRFXIOFVIProMTtr2FDPwu0R4kA5OKf+PfudqmAiH/
         +ZUA==
X-Forwarded-Encrypted: i=1; AJvYcCUhlksNvKF2KwjkO66SFjqVHiAZWTWjlmzW0anP/iZYY4n4JWBpe4ttiRhwvtGDtNgfdNn73YUHv1U=@vger.kernel.org, AJvYcCWbTRJQfJAgwUvEugt2VxKNR5DT8CNbIWWgg9bGCCbeFDj9RamSj62UbR1VDfGks6HhvnncWUbQ9ELq9hZcRqOH@vger.kernel.org, AJvYcCWeRHDJtl7OZ++8BHBxEsIWj8YX9ziQRKLaijmM3haMyfb7Qem4Kivimw8OnzrYXrT9qC7q9RWcGhYnerNk@vger.kernel.org
X-Gm-Message-State: AOJu0YzpuoOf+m4G5t9biLMkhz1RQimvnmOnst2T+Oq9BdHveFgAtyMF
	/7djF+W8GgMm4q2g3Nj+ibdXaaW81j62tl9LJq/YsNHKKwKzf8o0
X-Gm-Gg: ASbGncspJMHZV4UnuRyVXVDYl9FeITiTuQBirkIyuRMND4ob1AsOsmxxyOR3RJ8h5X9
	dHH3blnmqiyvULHERsy2RiGxCL/hnx5B8GmOQf6MhDANFKBr9ry7c93GCuE/j0V1Ao1CceUQf6l
	Wgs4Mh93BUq0/dvHU2uLaGGJ3kti0wuQrPpgKlVfJhQVSjYnVa57cSf0Nae2uDTsBQN1OGJ63wi
	L4DA4C+HMbR0norBBb7HkjBoBkyTHr9rVRPUpJBJ8Prky9ebD8CQQlf+vzMuPFOOykCyo8Ahkny
	VxhhLA==
X-Google-Smtp-Source: AGHT+IEmud3FIGHF+4SlFQt9myGTdAuU9koYy2fbnT1VzOIXCMCZuOxnotksKZ4hI1YdwSdONukCTA==
X-Received: by 2002:a17:907:2d22:b0:ab6:d7c4:fc7d with SMTP id a640c23a62f3a-ab75e35dc0dmr574486666b.39.1738839971703;
        Thu, 06 Feb 2025 03:06:11 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f8443asm81985066b.45.2025.02.06.03.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:55 -0800
Subject: [PATCH net-next v5 4/8] netconsole: Introduce configfs helpers for
 sysdata features
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-4-859b23cc3826@debian.org>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
In-Reply-To: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 rdunlap@infradead.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4892; i=leitao@debian.org;
 h=from:subject:message-id; bh=8WgGoItVdHl9J4C57gZoEzhi4IxKCuC308ZMbUO/wIg=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJea7DpL0dTgVy9ZzQ+YDcCrGJI1xzHR3Jf6S
 DbeMYlrtaSJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bdL9EACsc4YLfh9tGNjOu2UWrTiEItHZwD40NFC4t44Q1UvzOkuHhzdmfrg1Pd+Djj6XVOCZVdA
 Vc9q0bsz/zw0IlhzBqzmfiQgBmfldc6aBwG8dTviX0KHqYBkkM9n63T+2MJwmzmo+Fe0Wh9UQS2
 EjMRwBF/UB/IburBYZ0YY/9DNUn83Y0b7FOZnG4+3WoZwDvXycO5MpMusmMTAgKGrJU9hVQ7Z/J
 OAZQmf9FzruWJ2gfz7xP0UGZvtHjPpkh9UeWSkwDorHu8+/Lrd9/4c655Ghqs6eG7w2G9072773
 oTS95Ffg/73LJ0Wm4+41pDh/7JRCAA1xd25wfIRDugPoYeKRwXj20Mq+Fyo0SRu1YfRofhQ5bMm
 wxnLPBWv8jUQBcegpbhZoCYc0ECFbw9y0A00PYxU/uf7i8jVSK3Y52g2zPVM8d2bqcgpLXzb/Vz
 tVHWVrH9s1HjBYtzvqc3T6AhPJBiE2TMsvX6wrTaz21y1av+ASm0VskXmJWF2T1ar2wZC264huc
 uuSD0U6qLrj96RRPq8anY2431QuLq7FxaJ32I2vEP4vgOf0QE6imNZvjYpW4eiSoAj+5SR4SCsR
 V+d5p41jM+KeQOx2sh79p1812wfmoCzgm2V1OUxQpg0GUMJhbNeUUn3jcAbShZDOJoljs6OkONX
 OpZxU9Haqi6G7Zw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch introduces a bitfield to store sysdata features in the
netconsole_target struct. It also adds configfs helpers to enable
or disable the CPU_NR feature, which populates the CPU number in
sysdata.

The patch provides the necessary infrastructure to set or unset the
CPU_NR feature, but does not modify the message itself.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 15daaba65c8827bf399f0623cc42d310626cbf68..710330ae8ee462083dbb4aa889cb0ba0cb5a7475 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -97,6 +97,15 @@ struct netconsole_target_stats  {
 	struct u64_stats_sync syncp;
 };
 
+/* Features enabled in sysdata. Contrary to userdata, this data is populated by
+ * the kernel. The fields are designed as bitwise flags, allowing multiple
+ * features to be set in sysdata_fields.
+ */
+enum sysdata_feature {
+	/* Populate the CPU that sends the message */
+	CPU_NR = BIT(0),
+};
+
 /**
  * struct netconsole_target - Represents a configured netconsole target.
  * @list:	Links this target into the target_list.
@@ -104,6 +113,7 @@ struct netconsole_target_stats  {
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @extradata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of usedata in extradata_complete.
+ * @sysdata_fields:	Sysdata features enabled.
  * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
@@ -132,6 +142,8 @@ struct netconsole_target {
 	struct config_group	userdata_group;
 	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
 	size_t			userdata_length;
+	/* bit-wise with sysdata_feature bits */
+	u32			sysdata_fields;
 #endif
 	struct netconsole_target_stats stats;
 	bool			enabled;
@@ -399,6 +411,19 @@ static ssize_t transmit_errors_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%llu\n", xmit_drop_count + enomem_count);
 }
 
+/* configfs helper to display if cpu_nr sysdata feature is enabled */
+static ssize_t sysdata_cpu_nr_enabled_show(struct config_item *item, char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool cpu_nr_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	cpu_nr_enabled = !!(nt->sysdata_fields & CPU_NR);
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -793,7 +818,62 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
+/* disable_sysdata_feature - Disable sysdata feature and clean sysdata
+ * @nt: target that is disabling the feature
+ * @feature: feature being disabled
+ */
+static void disable_sysdata_feature(struct netconsole_target *nt,
+				    enum sysdata_feature feature)
+{
+	nt->sysdata_fields &= ~feature;
+	nt->extradata_complete[nt->userdata_length] = 0;
+}
+
+/* configfs helper to sysdata cpu_nr feature */
+static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
+					    const char *buf, size_t count)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool cpu_nr_enabled, curr;
+	ssize_t ret;
+
+	ret = kstrtobool(buf, &cpu_nr_enabled);
+	if (ret)
+		return ret;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	curr = nt->sysdata_fields & CPU_NR;
+	if (cpu_nr_enabled == curr)
+		/* no change requested */
+		goto unlock_ok;
+
+	if (cpu_nr_enabled &&
+	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
+		/* user wants the new feature, but there is no space in the
+		 * buffer.
+		 */
+		ret = -ENOSPC;
+		goto unlock;
+	}
+
+	if (cpu_nr_enabled)
+		nt->sysdata_fields |= CPU_NR;
+	else
+		/* This is special because extradata_complete might have
+		 * remaining data from previous sysdata, and it needs to be
+		 * cleaned.
+		 */
+		disable_sysdata_feature(nt, CPU_NR);
+
+unlock_ok:
+	ret = strnlen(buf, count);
+unlock:
+	mutex_unlock(&dynamic_netconsole_mutex);
+	return ret;
+}
+
 CONFIGFS_ATTR(userdatum_, value);
+CONFIGFS_ATTR(sysdata_, cpu_nr_enabled);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -853,6 +933,7 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 }
 
 static struct configfs_attribute *userdata_attrs[] = {
+	&sysdata_attr_cpu_nr_enabled,
 	NULL,
 };
 

-- 
2.43.5


