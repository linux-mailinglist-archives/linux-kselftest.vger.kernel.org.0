Return-Path: <linux-kselftest+bounces-25104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD2CA1B8C8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B5D16BC7C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EBE1ACE12;
	Fri, 24 Jan 2025 15:17:13 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD9C1991A8;
	Fri, 24 Jan 2025 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731833; cv=none; b=opSrCPXqisMl9MIw4WGJYPjU7zKd496HmlhDShgfPBR3hwJBm4h7wexgSzHShSaRM47Vlqz2zL+vGCWiLoXjZBT2zR2pVSpKN/cfuzXB6JIdzQu5Odmj0FHyKbhpQTr507EyhkgBXfJ4hUsSs0uVdvrXPbD6saCr92VnWXvE4eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731833; c=relaxed/simple;
	bh=VvYhMqUAo0V8kDZW6fMOYa/jXGpxQtZ/+oVgd6D3HQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AUSeYXWmS3w7iBoYRkgfwBoyQnga2L9qJNTkKKLnFd7Lsz3PZJNqLSecx+736TINGfzVyuuP20YbeMW1vOr1z0pcL09Bsn2mJ0lErszevjwSyijr6hysmt/zyY8qoPlPQBVKQs8tb6YYTeWuxXNMC+uoT+UgB/wcENzbHUE0mb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaef00ab172so370884466b.3;
        Fri, 24 Jan 2025 07:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731829; x=1738336629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9uBJBavnRRbXIEPgvkqqS5e1E1VX0ZLnO/5iP3vrGQ=;
        b=vIC41ywEOsrCw2QRiPLcfIDL9Hby4AnKfgPuBFdkY3NCIvEeR1Ld0Irb34YxFmH5yb
         8noTdih5Luv/ZCwx27yjLjV8q3e8KrPu7Nu2+wlEnHnz5oFcEvR3ysdxF3ostEgaybco
         qlEptvms6YkVpaLqBCehmIMm2s1ORRQxXuD18iV0KQSLBLROsFfFAMO4g++WEsqg1LdW
         7bhpu+JkzqZF0loFz6lsKbLEdTYKkQHh2nowz3FVlx+4AgzklUNaGgPuIsRsr8UWwjOh
         K+w5HAYCjAZMAOBS841nk/Xljf2Jxbudk3SqI037gb+vhJMih0PY7pHb07FFutqPQwpy
         zk4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWUSTmq9vUanUYnHFcM+/glTbI6OsZfpWsb07iWn0uYUwgF5K+s093ZCA53IBU7P3EdgPRv1iahlu+QEqL@vger.kernel.org, AJvYcCUfwTmc5wMx+LyoZ19WHOtQIt54EsEOU/F4fnxKVSpUmousZwyxrkg7Zm8nzQptjYpUkXz7q5RNaP9uq6SJDI7Y@vger.kernel.org, AJvYcCWpAkq2Qpv/4KQYdA4K+NlfxiVZmoHIauVNj9sJyDCpLiBArL1irS1ksVLaXOcPXxldWlyuXmIy5ME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0QUvHY2CsDni8T5y54JeGz113kK8AC4kQI8H4hpDuvRHX6gcg
	HsWlEU8gWWldsFoe0C5ilJzth0Uw/aGvDmuHtRtPyxqat67ekHvo3SYy6A==
X-Gm-Gg: ASbGncuNIFUUfX9FZ4dWok9NFXrfyVyH1q2D427uzR2BboY3ED/LUU/zTgKu3hQjjgQ
	mjHwJ6V22LIREXgdTpHYQWmcBZZYeqNZNAJVftx311vjC8gDzUu2OoEiAVxJEidkY+qXyXdhtRX
	3PwXx2+8HFVelBR2sKwP5ANmsArezQDbCSewa5Mmrvg5Lq23DZVu9tApLVpshFRVjHxT/phsAIK
	Pu1y/lrTL26mfKrjwuVg49sB8acExys4sy8tn4chIUpcE5Dejl6FKc+/zsyW0m2hHrGFyks3/Mh
	TTcTVA==
X-Google-Smtp-Source: AGHT+IEtcR7IbsNgiEZoxO8P72iS4HBHIFewAeqmpjE95N0eZ9X9crJzrzP+IyCJm8KJY/SMqxlI4g==
X-Received: by 2002:a05:6402:4313:b0:5db:f5e9:6760 with SMTP id 4fb4d7f45d1cf-5dbf5e96a10mr25922157a12.2.1737731829217;
        Fri, 24 Jan 2025 07:17:09 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1862a17fsm1274712a12.32.2025.01.24.07.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:43 -0800
Subject: [PATCH RFC net-next v3 4/8] netconsole: Introduce configfs helpers
 for sysdata features
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-4-12a0d286ba1d@debian.org>
References: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
In-Reply-To: <20250124-netcon_cpu-v3-0-12a0d286ba1d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4808; i=leitao@debian.org;
 h=from:subject:message-id; bh=VvYhMqUAo0V8kDZW6fMOYa/jXGpxQtZ/+oVgd6D3HQo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67rBC45BX5/8jV+gS22yCwvBKhXPUEbbUuWg
 qf77RGudMeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6wAKCRA1o5Of/Hh3
 bR0LD/4pg0J9MtjO2Qsu392AGhrbPGLkcj9ixQYU+4XWAksjxUBgY4Fg5ZbiX1TW3qgY4ccJkO6
 lhB18cMsoYHLw1UrK1nRCP+IXDydppUxwx7cYHY+L/+g3c8a1CJUDChB6bhmY8HPEczwtdTOwcn
 QK/fJfwtwPkW7W07/p5u3QJzFlpOHO4VQ2o4HO33uEZqZ2igUf56CuxGUlSLBWwJMKIhEycy9u9
 yHHhR/+udTfPs5a+HOp2UETKSF+DQuqP2VyP93xkOQloDMxqQDXnlNjvT8CwYnhsEO3e7Sj+RLZ
 nVYKotdD1dk/8gRqeTIwrYb+OMrSfPqb1cbF6WIZPL+5BjFzDW3qj0B45kMm92neX78ef6OqOTy
 x7VtSWQ9TTUIoT0D0pH7k64jl+Tbbovke4wJbP7oQ2t0c7LmQ7d/rIE6UFV0UUApxlQZbCNefaH
 zQTRNiQVMWjyd4XAohGODuV1ht+AVaqbNvZQQILT3hPEyIBc+4JZrDR36xZt3JSzaillCIRodG0
 vciUIVSZMFACesBCB88OnkS71CNBaIJNzId/dgjC8S0yVH5/QaCJ3nhwp3RvncQBMqmRXHdySAN
 FMnb9qzONPo6MFBFoTef8lhw7UWwdNZHD5uLYh63E+OrOjuHxqgNqHEtCIYsvxxkJxvNL0oXDWZ
 CZbcz6kfFojCdqQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

This patch introduces a bitfield to store sysdata features in the
netconsole_target struct. It also adds configfs helpers to enable
or disable the CPU_NR feature, which populates the CPU number in
sysdata.

The patch provides the necessary infrastructure to set or unset the
CPU_NR feature, but does not modify the message itself.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 81 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1c197da806962a751a3da8794def6a97cff5f701..4cefa43555aada25769b705dd8c8c89964f51a52 100644
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
@@ -131,6 +141,8 @@ struct netconsole_target {
 	struct config_group	userdata_group;
 	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
 	size_t			userdata_length;
+	/* bit-wise with sysdata_feature bits */
+	u32			sysdata_fields;
 #endif
 	struct netconsole_target_stats stats;
 	bool			enabled;
@@ -398,6 +410,19 @@ static ssize_t transmit_errors_show(struct config_item *item, char *buf)
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
@@ -792,7 +817,62 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
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
@@ -852,6 +932,7 @@ static void userdatum_drop(struct config_group *group, struct config_item *item)
 }
 
 static struct configfs_attribute *userdata_attrs[] = {
+	&sysdata_attr_cpu_nr,
 	NULL,
 };
 

-- 
2.43.5


