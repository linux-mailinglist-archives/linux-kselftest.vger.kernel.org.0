Return-Path: <linux-kselftest+bounces-24575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A80A124E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C12188C596
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 13:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBEA52442C5;
	Wed, 15 Jan 2025 13:35:43 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127C243845;
	Wed, 15 Jan 2025 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948143; cv=none; b=DrLHXtJ7iaIS7urW08W890nbGFpxZHJZeb60GGIo/ctctJ/vj/ILr8vrj1z4Occ/YAqh5+N5j465GN2+ddbmSoZt16Ho3Lfg7rpVVH44Nknc/dlwoiMK495bnzmSSoYrUow9DYX0KG9TVVpFPIHQp+Lq27xuRW6J2xw5ow/liW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948143; c=relaxed/simple;
	bh=zGKQnOePCXNnK2ujFJnG9eBNvBf38hWpuFyKGZ6MIqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WcGAthzXJNEv3Wk2ALt7Rsjf4+Veu2/9eHJe+WDBNtLx575mW7dhPwFSLlH+aq3v+7E8aRP0msSoP320Mcwoc+IX9Yy68xvityTk+d7JfCIjKMBcbmxLKkKU7OiDDgCcMO8kgKWuIA/8FMzjWR//1+2LQAnm33yzuprJws2vOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aaf6b1a5f2bso176284266b.1;
        Wed, 15 Jan 2025 05:35:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948139; x=1737552939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N+TRFdUSlvt3nSzhQ5Uy/fXS/5eMuJmBJc92CYoce4k=;
        b=JaC2LaUZ6pgbVWJ2j5weA+Pke6hUAzhnz4XQSAKpI4GmXQSoMQoBDRXG5vP1f6/UjZ
         k72+RgeqhCyUifZgeg32rp9bw8YxptvYFcShoEhp3KTpI7KKrANpQG+EI3DUMV77EetV
         Yo3gZ3PN6EuNPNmSySNn4SLs7/oQ4ALNPT6rqqqKRRKN83wDr3wtxrzuE3I5jJVIojYF
         dNzUxYQaIH8QgHmCpFoiUC8OfHcMkYJpw8A6pqFvWpmESfrNku4qpQM5BzJPjzlz8sq3
         qLdxGGeAFwFlfJoVhZT7GN2L0sGcY5giVMKMjMbYjggaaOUhsk4c++9WjS6HJ6jcDH6g
         3lnw==
X-Forwarded-Encrypted: i=1; AJvYcCUWji81Mn6Ul+gNKxH373yOZp5/JobLpZns149J1MsNrsktlY4CgIfZKagx8nBCm6RshqJOfrP1vN4uBZ7i@vger.kernel.org, AJvYcCVkKrRYE+V5maaIOq17Z17IGNKIGH+zgjG16AdCdFFdrzlgMQ+wR35IJZUOn2Aurpxnhd4Laf1R+XjNVm5AVLVg@vger.kernel.org, AJvYcCXwcfQ6QTFktFeJshus+Pi3uQxgQ0v/Obe4OAy4n3aSmn0kxSbYeUKMGBiNbKCj+jYtxYOonp7ftR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVtbhS+NgxB31hCNzDnTI+O3l7JGbz9ZwJP8qziGic4HxpY+6U
	OiwR2yXcb0V1/PvYzXLa7K4JowCAftOk6lL1Fqt1dfeQKTFHN/pzwEa4SQ==
X-Gm-Gg: ASbGncuGKvN9Gsp11Go3q4bahxlUO3t0fpBNM+j9uXud/kKeGTYfyqKoqz0tW/LkHZ+
	0gayFEoBz1AZNIXe9OXKBC+d/R8Tpjkgevoz6tKEDbcymnb3H0xFtKzaGhMAW0VP6sK3EVSXZzG
	Hg+UQYohx0EgO/4GseXMDYGuuYx2qmUoO9A2t+CTTCszWZGVscfRm2F6zum+jfupCt4Be2WA4JO
	Gc2fKEQH8EbyPKf49VTsbSH2j6pCdZIPtgk9/zn9hEFyLo=
X-Google-Smtp-Source: AGHT+IGervku6gALvYqjlFtTDOMMJ3EL5hGs4iGmf8CmlSrkSwlNt97sYb+GEdPUk5c+zg56oqeD6Q==
X-Received: by 2002:a17:907:7282:b0:a9a:6c41:50a8 with SMTP id a640c23a62f3a-ab2c3c79cf5mr2294578966b.17.1736948138826;
        Wed, 15 Jan 2025 05:35:38 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c906200dsm756582666b.40.2025.01.15.05.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:35:38 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Jan 2025 05:35:20 -0800
Subject: [PATCH net-next v2 3/5] netconsole: add support for sysdata and
 CPU population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-netcon_cpu-v2-3-95971b44dc56@debian.org>
References: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
In-Reply-To: <20250115-netcon_cpu-v2-0-95971b44dc56@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, max@kutsevol.com, 
 thepacketgeek@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7758; i=leitao@debian.org;
 h=from:subject:message-id; bh=zGKQnOePCXNnK2ujFJnG9eBNvBf38hWpuFyKGZ6MIqY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnh7mjKcrs721+URaAHjhCOYEErnoTQN/9CMR1Z
 CIMWWGb116JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4e5owAKCRA1o5Of/Hh3
 bW83D/93fIxXz5O5vE0EkqwHKgMlp0mMD6NoSAulr9H9juei42e3nM4yyhECsJpNAzwAkrvet/u
 F7r3bKmARuwtPaUGRtRXL40bolOK1SVjM5ouWsxT8/U4JrvQk7PZh6LYFcCz8uxZuhMFM7ayHFW
 DaLf5YU5Qb4CXooo5jUlSj2VTwJgcSUbm1yxL1jhAcJ56BvgE00eL/rwck4fsdm5drRceTbcBQX
 dj90OS5KFrCGygx6XIqUq+mBx/tMzXCGK0zNMEdhC7X+zLBMTfklu81o0lffoNgZGCVS+ODOpUw
 PXO6RZjHa6TNEjUd1d2WR8e1OwUXdmItXJK0Cd6zh7/tdJ10wzy8PoLpjd9/f8afI3D0PMTbRjQ
 xnK4iokOQXSqc1jQdQF/IKKjvDxMTpArr4JOT0pnD4RsiZq8g5CYKnraLZfcSG9XU2FNJGYFLbN
 nAaAGVr9O48chyNctROhzQvkITyTfmtwj+38m+AbfH5CygGqio8dzms7MfysIZ3jZAJQXyBweIN
 zquUCPF0H67F+PDAN8Dw0KoMbaQkHNdGWU+jBQ4HA/mT6r9qYq4AfnyC0XYbaDmp0J77mxYqMHw
 Y15jsvUq9EOSPY0kpl28FjBzwrAfGWa6pT707ZvZZtcpL9RXXtLtAiUPW/IWTCmGYEpYjfme7jF
 K7KWx0g3gUMHqOQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add infrastructure to automatically append kernel-generated data (sysdata)
to netconsole messages. As the first use case, implement CPU number
population, which adds the CPU that sent the message.

This change introduces three distinct data types:
- extradata: The complete set of appended data (sysdata + userdata)
- userdata: User-provided key-value pairs from userspace
- sysdata: Kernel-populated data (e.g. cpu=XX)

The implementation adds a new configfs attribute 'cpu_nr' to control CPU
number population per target. When enabled, each message is tagged with
its originating CPU. The sysdata is dynamically updated at message time
and appended after any existing userdata.

The CPU number is formatted as "cpu=XX" and is added to the extradata
buffer, respecting the existing size limits.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 131 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 108ec4f836b62860832c601768546c0ecbdb1153..d89b4ef23965ac0a25090d0a1e461de4e56c5fa7 100644
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
@@ -104,6 +113,8 @@ struct netconsole_target_stats  {
  * @userdata_group:	Links to the userdata configfs hierarchy
  * @extradata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of usedata in extradata_complete.
+ * @sysdata_length:	String length of sysdata in extradata_complete.
+ * @sysdata_fields:	Sysdata features enabled.
  * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
@@ -130,7 +141,9 @@ struct netconsole_target {
 	struct config_group	group;
 	struct config_group	userdata_group;
 	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
-	size_t			userdata_length;
+	size_t			userdata_length; /* updated at update_userdata() */
+	size_t			sysdata_length;  /* updated at every message */
+	u32			sysdata_fields;  /* bit-wise with sysdata_feature bits */
 #endif
 	struct netconsole_target_stats stats;
 	bool			enabled;
@@ -396,6 +409,19 @@ static ssize_t transmit_errors_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%llu\n", xmit_drop_count + enomem_count);
 }
 
+/* configfs helper to display if cpu_nr sysdata feature is enabled */
+static ssize_t sysdata_cpu_nr_show(struct config_item *item, char *buf)
+{
+	struct netconsole_target *nt = to_target(item->ci_parent);
+	bool cpu_nr_enabled;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	cpu_nr_enabled = nt->sysdata_fields & CPU_NR;
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return sysfs_emit(buf, "%d\n", cpu_nr_enabled);
+}
+
 /*
  * This one is special -- targets created through the configfs interface
  * are not enabled (and the corresponding netpoll activated) by default.
@@ -666,7 +692,15 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
  */
 static size_t count_extradata_entries(struct netconsole_target *nt)
 {
-	return list_count_nodes(&nt->userdata_group.cg_children);
+	size_t entries;
+
+	/* Userdata entries */
+	entries = list_count_nodes(&nt->userdata_group.cg_children);
+	/* Plus sysdata entries */
+	if (nt->sysdata_fields & CPU_NR)
+		entries += 1;
+
+	return entries;
 }
 
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,
@@ -790,7 +824,67 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
+/* disable_sysdata_feature - Disable sysdata feature and clean sysdata
+ * @nt: target that is diabling the feature
+ * @feature: feature being disabled
+ */
+static void disable_sysdata_feature(struct netconsole_target *nt,
+				    enum sysdata_feature feature)
+{
+	nt->sysdata_fields &= ~feature;
+	nt->sysdata_length = 0;
+	/* extradata_complete might have sysdata appended after
+	 * userdata. Clean everything, and it will be re-appened
+	 * when a new message is sent.
+	 */
+	nt->extradata_complete[nt->userdata_length] = 0;
+}
+
+/* configfs helper to sysdata cpu_nr feature */
+static ssize_t sysdata_cpu_nr_store(struct config_item *item, const char *buf,
+				    size_t count)
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
+CONFIGFS_ATTR(sysdata_, cpu_nr);
 
 static struct configfs_attribute *userdatum_attrs[] = {
 	&userdatum_attr_value,
@@ -850,6 +944,7 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 }
 
 static struct configfs_attribute *userdata_attrs[] = {
+	&sysdata_attr_cpu_nr,
 	NULL,
 };
 
@@ -1025,6 +1120,35 @@ static void populate_configfs_item(struct netconsole_target *nt,
 	init_target_config_group(nt, target_name);
 }
 
+/*
+ * append_runtime_sysdata - append sysdata at extradata_complete in runtime
+ * @nt: target to send message to
+ */
+static void append_runtime_sysdata(struct netconsole_target *nt)
+{
+	size_t userdata_len = nt->userdata_length;
+	size_t sysdata_len;
+
+	if (!(nt->sysdata_fields & CPU_NR))
+		return;
+
+	/* Append cpu=%d at extradata_complete after userdata str */
+	sysdata_len = scnprintf(&nt->extradata_complete[userdata_len],
+				MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
+				raw_smp_processor_id());
+
+	WARN_ON_ONCE(userdata_len + sysdata_len >
+		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
+
+	/* nt->sysdata_length will be used later to decide if the message
+	 * needs to be fragmented.
+	 * userdata_len cannot be used for it, once next sysdata append should
+	 * start from the same userdata_len location, and only overwrite old
+	 * sysdata.
+	 */
+	nt->sysdata_length = sysdata_len;
+}
+
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Handle network interface device notifications */
@@ -1297,7 +1421,8 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	int release_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata_len = nt->userdata_length;
+	append_runtime_sysdata(nt);
+	extradata_len = nt->userdata_length + nt->sysdata_length;
 #endif
 
 	if (nt->release)

-- 
2.43.5


