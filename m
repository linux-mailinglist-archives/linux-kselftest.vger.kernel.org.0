Return-Path: <linux-kselftest+bounces-25665-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC54A27061
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBB018869FF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAA220E6E7;
	Tue,  4 Feb 2025 11:35:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7B202C39;
	Tue,  4 Feb 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668939; cv=none; b=OHccwCw2Gn8Wt7PntSTzvejry9NaQtttuVslYyAShewX3FG/bZpYWuP4/9Z12qprwr9NC+/H4bT7dNx5S+kC4paMCnUpeQLEQfwiKF/obnmxmbaD/Pl3Z3FbvYc+Fdn99JRyxicx/sqXTUCsPgYhQiIIWvOW6RGhlFzrBVIUU5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668939; c=relaxed/simple;
	bh=hLy9TXg6nIhPoxfmNDiJnIiiKr4KfKw97Pj0OjO2JcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QxniTx7p4UGqeG1RQsdWT2g6Yz+5sKskbbQWfwXbuTyaRpOfHYcTd9f239UQ51UB5QsRkkdC25a5L8dVy9SHCGe7LAywm92+8DS2V5nNGG4/tIPKybJR5cGheDusv8NHfC0/sdZtlNlr2owWVEmiqqj78eHRZ7A7otmflHYqVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab69bba49e2so825153466b.2;
        Tue, 04 Feb 2025 03:35:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668935; x=1739273735;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kshh9gQrmmrR38vR7SN8goBhjS3FcwE1q+QpkHqdKgc=;
        b=fH84EUtRciqPaLTaslvnnbG7/2OSqckJzE4O8vRUzJBp6N/EQRYtbdyzDV6cqocz2z
         tjI/PCHfkTG0XcC7nnMYvyfp5GaG8qY8cRCIEIc0XXVHaDKLpmC7vtdTwVlcSe4H+VNF
         5sclBvOn9kRutgAuWrEusd/wYkI4rjppiBTDdZDDPJ1rarAjG3zwRsUUa688g4Vdt+nR
         W9xCg38AHS9lP9i8/vIomoWCH9DVR8AeLIDSGMQmi4ogWgBMJ/OqWpl5Cz/VCMWskuhU
         +WpWntn/xGRXwDlJR4UNzv+ELvnYhdCOaefURMzJIeRGt5FSsh8GokfkUYSJOMVrNH9W
         z2bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9OcuqmkJ6m6ueSCGSxhugFdPTtcLIGdfIiwCo4FJ9G8QUyZ59zKFwIOeUyBwWN9n6ItGbsbkDtLE=@vger.kernel.org, AJvYcCViZ3junonCzN4ZYxJffQfNFK8OXQmB/7xcioKsx7ZI6k90u1h6R2WSIHAvoibZeinl6oimHgCyQDvQTCZt/UPz@vger.kernel.org, AJvYcCW0IGzhxGrx1c2V0l1mB+9Imk1k3VvOXbMmZqJRNzBTbx6YpCl8Z2ReARq2m7EIXBNDYgn6Qfm0PawjcTYT@vger.kernel.org
X-Gm-Message-State: AOJu0YyPAmEpSyc8bWnANtB8NFhPYey5b+AHGw+SO1zlohzLKKo6dzYp
	Mpb8mh5/faz9J7NqdQwD7t7pITn+5jB5jtROB9SAofSIpMobYKMwYCJiLQ==
X-Gm-Gg: ASbGncvjFe1YmE9geBALQjuOzhd8Ky9II5XCmvGjeGFAKdB9L56FmV8KlXd25zAhp/h
	EZZqdWNNnXRQr5hGTOtB2sdByiM1abrPnhesR5bI+UZ5nBicIVmNQfYxqfFTY6/FSd6QLvx4w4Q
	Pic7JA4wjCAmaCUztZ+IiictS8gMzQ8G/J0Tlc+m9o7xluoMFZzbf9hsts2taZYMf/1jURTkFbw
	AbhYcmynEgYflCu5mdjsoPlaxHvIannuGZ0/nR6pz1tJ6lUtTJDp2yhwVffvpuf7+9PF7OTQIYl
	BwLMnTU=
X-Google-Smtp-Source: AGHT+IG0XavFggy1ISsJG6VB35Gu5B1/c8zqrZxhlnydqXQkX7DYqvzpjkc/mOlahVuoSIfLSS0/ZA==
X-Received: by 2002:a05:6402:268d:b0:5dc:740b:3cdb with SMTP id 4fb4d7f45d1cf-5dc740b3efcmr57278528a12.29.1738668934851;
        Tue, 04 Feb 2025 03:35:34 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:72::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc8eaafa38sm6186948a12.76.2025.02.04.03.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:12 -0800
Subject: [PATCH net-next v4 4/8] netconsole: Introduce configfs helpers for
 sysdata features
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-4-9480266ef556@debian.org>
References: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
In-Reply-To: <20250204-netcon_cpu-v4-0-9480266ef556@debian.org>
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
 h=from:subject:message-id; bh=hLy9TXg6nIhPoxfmNDiJnIiiKr4KfKw97Pj0OjO2JcU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+aeYylxjwv7smperkJBzhfNt2VPWfmzY6A
 9lBq3yREzaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bcmWEACoZXzE+YK8lTIJ8bOFalVamkfp/Pr73MhtK5oJbL5nfgcvfgIwkinquGr/QRs+jpI90s8
 qNZv1K6HAyvdXJIHp5XZBrFroH1f5Je50GeR5tESc7beXxJKgOBiQSTRhkhClNXTGY7lnAL8hLD
 yY8x9FynMYscpTDr4R3hpAd3BIbdEpu52/pahhwlLvpXmAqd0q1yhDKUua70aPSqXBri6BjtRR/
 G33tfIAcXRxy/7VJ1+u/ur0v5mQGGphTcFW3nmPIoswZT95I7ftKHaZz71xWvPDzCQtCgH3soqi
 VQZ32lXf35EpNLOMBUv+7R/yuSPSwPhgmEArk9OsLBR/g7O4orL3mBYFGL20aGc931UfWM7Ch8L
 QxExSE/VHFiJqK0RUh3hvDRsPiltPe0RLHCpw215tQQ9wz9/clmJw8F9uAvHmMBxOos82XGJD+n
 HDcqZNIQxY9H4jl3QzcWbiyhXv6CLwDYRS7pZL09uDnUaet+P8ozQqDWMkMIyZvbW9cq9227dbq
 0Fbk0tFv0uitenuJyKHNWHjiIAgb+lV0PC7l816M87+rKXk2o7VD2E4pDYypHgkXFQfVoFcvvzy
 1C1+A0RPN7bUeKagv70o6e+Z3Kw5qlqhyfX2JCEPYxS8sOzDu9/77CBAPJfWtvinnGz+dgeMRmd
 iOLiIdVVIqbGFEw==
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
index bfcc3809f4b5fa351c8e7e6340a54e93d525aa2e..c3f31b15ab8108f6be80d747ffc64a1eeb59a5a9 100644
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


