Return-Path: <linux-kselftest+bounces-44830-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A683C37039
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534001A2247A
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5997333FE0B;
	Wed,  5 Nov 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/8UDSpS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02EE133C52F
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 17:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362434; cv=none; b=gE4gm6xOAe0fkNaCneTyVMohKuiKISonQ9lZp6NaVuFkUioSx4V8a/3w3AOGcSl7LzeVLYZ7o31XNMuzkhDrbAM0zd5i/Iznr/BFB695nPJO9xqnzX6M4VEQf/A3MAW/2zc+vg7JUpcO/OPz7mkmffIx1QZ2iO/X6LQGDRcLwRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362434; c=relaxed/simple;
	bh=eaE16VgmGggegeN1BwWmj0QHqIn4/sNyqXWlWFoejMQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S8KBmbGagjgaEg7HJqNkdUVzBiQ+oCcmwv0To6JlLi3h+xI0w92Ffk0sQQkhdiO4+q86M8hVEap6FPHBvPep03SZpfJyN7jlT1griOqbRAbJsqaM9GlDJtpk4Mzju/SNWZAEtI38cyRPspAsUIyC6riSRaLncekHEEduwt/HjHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/8UDSpS; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47754cbe1feso22285e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 09:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362428; x=1762967228; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=burJbSG4PCBpYev8kKjngMRTrj8HazTfwLvWO+aw4Hs=;
        b=a/8UDSpSYckHws8+YpKF21UDCxXaFrfcewEjDQ4QX4g33Z/8YbypR9xViGwZWHl3If
         SM++rbUaexighBgaAjXJBCUMSppd3Ibh0n8bofTEpq6py0FaEpVqMuKU36L07pREtctQ
         lap1tDrFskSxNQau0WmzFv74AHkJktg/dy383W+s6zwluCgRwyCC96ZdhF6CHaie5U3j
         LP1p0Rp2RRXa3K4YGkcJ9JKS3VXSTlM8fYPrwZE9xoAJZSRQAReITIahCQuOl4k8dDC9
         O1mahQSX5PQ3WTTsYDAQwjMlBrBoZD51m+8jqDsAIY1nBR6uG6JPAWWn4FP/DO542uNh
         1xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362428; x=1762967228;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=burJbSG4PCBpYev8kKjngMRTrj8HazTfwLvWO+aw4Hs=;
        b=KpotupkHehUgAsrTv+0s4Gqe3R5TAEZJhBIq+fIecbU/tJLFelweLFmWjSaa9TqxtW
         vagyir5k6+hS2NyYgG8An51jyqI80ABZjL82Wufsasmqyn5/Evphwg7qBVF+hGl2Wvqa
         dW77daR037tlxRIay3cEWw1RVg9T7xNBB5jH8VcmRivAJFpfVj+UOaMxG9Mhi2m03Qyg
         N4369emZawqLYI4vdEZdvBPNLeofqtnrQ1TEYpTx9mwqKUlTe1vqu8FjzhkSvMsnhXBi
         e/5Yg8JmrlBwsFjot+ti2UCqLFzHaY401LOrO7hn32rfOwGSCsdvsvJxWLPUgt1ZggcO
         sEcw==
X-Forwarded-Encrypted: i=1; AJvYcCW2Iz9Owiui7vjW5PsikAxPdZXmKGMdv9KX60Bw1E82rDHCkxcQ0y1PiKYnfpCjOB5MkyNETgH4iPtpMKXqQuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYBjvShNy2qylISp6VCtcX1jP7VQatkrRSoWljYfdcH/Pvl2XM
	CyqAuNY/DUWjhBc8vPBQ9+5LwLTgAWc5z2F9jnBvFq3hUYAWGnlxJk9h
X-Gm-Gg: ASbGncu4Ogm1mKiX/McAIO27Koyu8v32+vSamlQFDVQCqYK5guLohuPI+fMJXdqD7lT
	FouyXYqGSYeUddtlxgxQWWQ7bGaBWW4EGg3VURHvWvVJp3o0ocD6xxp38E6kZHILsgwnKPU7WLD
	sRdrm1GEtuko//VyeMjnZRps6UNpI7G1e5XuolaDyoxghHgbsCenzr2yL93NDdxS5ZOoc+54FJe
	oHaDMTv1MsP4PHHiz2hrVy7ajNpwH8WB5Sm+cZLX7CwAih87Fgc8W0j1X6v9UuCBWcLDJ1v5rA2
	EaAufV9wcfAuOxFLMCUgETehRFT/PKCrPV3PxD6OhZGqx+T2GMD+vcaeIyB3zzaUw2jIxZm/URr
	KDihvvEFsBab/ebCPuM05LrjKNB7bdP8owB/j7Ky4ugjZFM+oq/iQN4HMaR0HR4UthfPPQUH6FY
	cFcZE2
X-Google-Smtp-Source: AGHT+IHDK9t1hYzjHzU+6mjzWoH6s/etvwyCbcPLyDUSLcDVPzdD0VstKOWPkuplNrgu0TEqwF6POw==
X-Received: by 2002:a05:600c:1993:b0:46f:da97:91cc with SMTP id 5b1f17b1804b1-4775ce4b8c8mr20586985e9.6.1762362428079;
        Wed, 05 Nov 2025 09:07:08 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:70::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775ce329afsm56703195e9.16.2025.11.05.09.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:07 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Nov 2025 09:06:44 -0800
Subject: [PATCH net-next 2/4] netconsole: Split userdata and sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-netconsole_dynamic_extradata-v1-2-142890bf4936@meta.com>
References: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
In-Reply-To: <20251105-netconsole_dynamic_extradata-v1-0-142890bf4936@meta.com>
To: Breno Leitao <leitao@debian.org>, Andre Carvalho <asantostc@gmail.com>, 
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Separate userdata and sysdata into distinct buffers to enable independent
management. Previously, both were stored in a single extradata_complete
buffer with a fixed size that accommodated both types of data.

This separation allows:
- userdata to grow dynamically (in subsequent patch)
- sysdata to remain in a small static buffer
- removal of complex entry counting logic that tracked both types together

The split also simplifies the code by eliminating the need to check total
entry count across both userdata and sysdata when enabling features,
which allows to drop holding su_mutex on sysdata_*_enabled_store().

No functional change in this patch, just structural preparation for
dynamic userdata allocation.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 204 +++++++++++++++++++----------------------------
 1 file changed, 84 insertions(+), 120 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 0a8ba7c4bc9d..e780c884db83 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,8 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_EXTRADATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		16
+#define MAX_SYSDATA_ITEMS		4
 #define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
@@ -122,8 +123,9 @@ enum sysdata_feature {
  * @list:	Links this target into the target_list.
  * @group:	Links us into the configfs subsystem hierarchy.
  * @userdata_group:	Links to the userdata configfs hierarchy
- * @extradata_complete:	Cached, formatted string of append
- * @userdata_length:	String length of usedata in extradata_complete.
+ * @userdata:		Cached, formatted string of append
+ * @userdata_length:	String length of userdata.
+ * @sysdata:		Cached, formatted string of append
  * @sysdata_fields:	Sysdata features enabled.
  * @msgcounter:	Message sent counter.
  * @stats:	Packet send stats for the target. Used for debugging.
@@ -152,8 +154,10 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
-	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
+	char			userdata[MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS];
 	size_t			userdata_length;
+	char			sysdata[MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS];
+
 	/* bit-wise with sysdata_feature bits */
 	u32			sysdata_fields;
 	/* protected by target_list_lock */
@@ -802,28 +806,14 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 	return ret;
 }
 
-/* Count number of entries we have in extradata.
- * This is important because the extradata_complete only supports
- * MAX_EXTRADATA_ITEMS entries. Before enabling any new {user,sys}data
- * feature, number of entries needs to checked for available space.
+/* Count number of entries we have in userdata.
+ * This is important because userdata only supports MAX_USERDATA_ITEMS
+ * entries. Before enabling any new userdata feature, number of entries needs
+ * to checked for available space.
  */
-static size_t count_extradata_entries(struct netconsole_target *nt)
+static size_t count_userdata_entries(struct netconsole_target *nt)
 {
-	size_t entries;
-
-	/* Userdata entries */
-	entries = list_count_nodes(&nt->userdata_group.cg_children);
-	/* Plus sysdata entries */
-	if (nt->sysdata_fields & SYSDATA_CPU_NR)
-		entries += 1;
-	if (nt->sysdata_fields & SYSDATA_TASKNAME)
-		entries += 1;
-	if (nt->sysdata_fields & SYSDATA_RELEASE)
-		entries += 1;
-	if (nt->sysdata_fields & SYSDATA_MSGID)
-		entries += 1;
-
-	return entries;
+	return list_count_nodes(&nt->userdata_group.cg_children);
 }
 
 static ssize_t remote_mac_store(struct config_item *item, const char *buf,
@@ -894,13 +884,13 @@ static void update_userdata(struct netconsole_target *nt)
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
-	nt->extradata_complete[0] = 0;
+	nt->userdata[0] = 0;
 
 	list_for_each(entry, &nt->userdata_group.cg_children) {
 		struct userdatum *udm_item;
 		struct config_item *item;
 
-		if (child_count >= MAX_EXTRADATA_ITEMS) {
+		if (child_count >= MAX_USERDATA_ITEMS) {
 			spin_unlock_irqrestore(&target_list_lock, flags);
 			WARN_ON_ONCE(1);
 			return;
@@ -914,11 +904,11 @@ static void update_userdata(struct netconsole_target *nt)
 		if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) == 0)
 			continue;
 
-		/* This doesn't overflow extradata_complete since it will write
-		 * one entry length (1/MAX_EXTRADATA_ITEMS long), entry count is
+		/* This doesn't overflow userdata since it will write
+		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
 		 * checked to not exceed MAX items with child_count above
 		 */
-		nt->userdata_length += scnprintf(&nt->extradata_complete[nt->userdata_length],
+		nt->userdata_length += scnprintf(&nt->userdata[nt->userdata_length],
 						 MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
 						 item->ci_name, udm_item->value);
 	}
@@ -960,7 +950,7 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
 				    enum sysdata_feature feature)
 {
 	nt->sysdata_fields &= ~feature;
-	nt->extradata_complete[nt->userdata_length] = 0;
+	nt->sysdata[0] = 0;
 }
 
 static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
@@ -979,12 +969,6 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 	if (msgid_enabled == curr)
 		goto unlock_ok;
 
-	if (msgid_enabled &&
-	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
-		ret = -ENOSPC;
-		goto unlock;
-	}
-
 	if (msgid_enabled)
 		nt->sysdata_fields |= SYSDATA_MSGID;
 	else
@@ -992,7 +976,6 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
 }
@@ -1013,12 +996,6 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 	if (release_enabled == curr)
 		goto unlock_ok;
 
-	if (release_enabled &&
-	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
-		ret = -ENOSPC;
-		goto unlock;
-	}
-
 	if (release_enabled)
 		nt->sysdata_fields |= SYSDATA_RELEASE;
 	else
@@ -1026,7 +1003,6 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
 }
@@ -1047,12 +1023,6 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 	if (taskname_enabled == curr)
 		goto unlock_ok;
 
-	if (taskname_enabled &&
-	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
-		ret = -ENOSPC;
-		goto unlock;
-	}
-
 	if (taskname_enabled)
 		nt->sysdata_fields |= SYSDATA_TASKNAME;
 	else
@@ -1060,7 +1030,6 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
 }
@@ -1083,27 +1052,16 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
 		/* no change requested */
 		goto unlock_ok;
 
-	if (cpu_nr_enabled &&
-	    count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS) {
-		/* user wants the new feature, but there is no space in the
-		 * buffer.
-		 */
-		ret = -ENOSPC;
-		goto unlock;
-	}
-
 	if (cpu_nr_enabled)
 		nt->sysdata_fields |= SYSDATA_CPU_NR;
 	else
-		/* This is special because extradata_complete might have
-		 * remaining data from previous sysdata, and it needs to be
-		 * cleaned.
+		/* This is special because sysdata might have remaining data
+		 * from previous sysdata, and it needs to be cleaned.
 		 */
 		disable_sysdata_feature(nt, SYSDATA_CPU_NR);
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	return ret;
 }
@@ -1146,7 +1104,7 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
-	if (count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS)
+	if (count_userdata_entries(nt) >= MAX_USERDATA_ITEMS)
 		return ERR_PTR(-ENOSPC);
 
 	udm = kzalloc(sizeof(*udm), GFP_KERNEL);
@@ -1353,22 +1311,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
 static int sysdata_append_cpu_nr(struct netconsole_target *nt, int offset)
 {
-	/* Append cpu=%d at extradata_complete after userdata str */
-	return scnprintf(&nt->extradata_complete[offset],
+	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
 			 raw_smp_processor_id());
 }
 
 static int sysdata_append_taskname(struct netconsole_target *nt, int offset)
 {
-	return scnprintf(&nt->extradata_complete[offset],
+	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " taskname=%s\n",
 			 current->comm);
 }
 
 static int sysdata_append_release(struct netconsole_target *nt, int offset)
 {
-	return scnprintf(&nt->extradata_complete[offset],
+	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " release=%s\n",
 			 init_utsname()->release);
 }
@@ -1376,46 +1333,36 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
 static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
 {
 	wrapping_assign_add(nt->msgcounter, 1);
-	return scnprintf(&nt->extradata_complete[offset],
+	return scnprintf(&nt->sysdata[offset],
 			 MAX_EXTRADATA_ENTRY_LEN, " msgid=%u\n",
 			 nt->msgcounter);
 }
 
 /*
- * prepare_extradata - append sysdata at extradata_complete in runtime
+ * prepare_sysdata - append sysdata in runtime
  * @nt: target to send message to
  */
-static int prepare_extradata(struct netconsole_target *nt)
+static int prepare_sysdata(struct netconsole_target *nt)
 {
-	int extradata_len;
-
-	/* userdata was appended when configfs write helper was called
-	 * by update_userdata().
-	 */
-	extradata_len = nt->userdata_length;
+	int sysdata_len = 0;
 
 	if (!nt->sysdata_fields)
 		goto out;
 
 	if (nt->sysdata_fields & SYSDATA_CPU_NR)
-		extradata_len += sysdata_append_cpu_nr(nt, extradata_len);
+		sysdata_len += sysdata_append_cpu_nr(nt, sysdata_len);
 	if (nt->sysdata_fields & SYSDATA_TASKNAME)
-		extradata_len += sysdata_append_taskname(nt, extradata_len);
+		sysdata_len += sysdata_append_taskname(nt, sysdata_len);
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
-		extradata_len += sysdata_append_release(nt, extradata_len);
+		sysdata_len += sysdata_append_release(nt, sysdata_len);
 	if (nt->sysdata_fields & SYSDATA_MSGID)
-		extradata_len += sysdata_append_msgid(nt, extradata_len);
+		sysdata_len += sysdata_append_msgid(nt, sysdata_len);
 
-	WARN_ON_ONCE(extradata_len >
-		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
+	WARN_ON_ONCE(sysdata_len >
+		     MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS);
 
 out:
-	return extradata_len;
-}
-#else /* CONFIG_NETCONSOLE_DYNAMIC not set */
-static int prepare_extradata(struct netconsole_target *nt)
-{
-	return 0;
+	return sysdata_len;
 }
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
@@ -1517,13 +1464,8 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      int msg_len,
 				      int release_len)
 {
-	const char *extradata = NULL;
 	const char *release;
 
-#ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata = nt->extradata_complete;
-#endif
-
 	if (release_len) {
 		release = init_utsname()->release;
 
@@ -1533,11 +1475,11 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 		memcpy(nt->buf, msg, msg_len);
 	}
 
-	if (extradata)
-		msg_len += scnprintf(&nt->buf[msg_len],
-				     MAX_PRINT_CHUNK - msg_len,
-				     "%s", extradata);
-
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	msg_len += scnprintf(&nt->buf[msg_len],
+			     MAX_PRINT_CHUNK - msg_len,
+			     "%s%s", nt->userdata, nt->sysdata);
+#endif
 	send_udp(nt, nt->buf, msg_len);
 }
 
@@ -1551,30 +1493,41 @@ static void append_release(char *buf)
 
 static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
-				 int msgbody_len, int extradata_len)
+				 int msgbody_len, int sysdata_len)
 {
-	const char *extradata = NULL;
+	const char *userdata = NULL;
+	const char *sysdata = NULL;
 	int body_len, offset = 0;
-	int extradata_offset = 0;
+	int userdata_offset = 0;
 	int msgbody_offset = 0;
+	int sysdata_offset = 0;
+	int userdata_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata = nt->extradata_complete;
+	userdata = nt->userdata;
+	sysdata = nt->sysdata;
+	userdata_len = nt->userdata_length;
 #endif
-	if (WARN_ON_ONCE(!extradata && extradata_len != 0))
+	if (WARN_ON_ONCE(!userdata && userdata_len != 0))
+		return;
+
+	if (WARN_ON_ONCE(!sysdata && sysdata_len != 0))
 		return;
 
 	/* body_len represents the number of bytes that will be sent. This is
 	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
 	 * packets
 	 */
-	body_len = msgbody_len + extradata_len;
+	body_len = msgbody_len + userdata_len + sysdata_len;
 
 	/* In each iteration of the while loop below, we send a packet
 	 * containing the header and a portion of the body. The body is
-	 * composed of two parts: msgbody and extradata. We keep track of how
-	 * many bytes have been sent so far using the offset variable, which
-	 * ranges from 0 to the total length of the body.
+	 * composed of three parts: msgbody, userdata and sysdata.
+	 * We keep track of how many bytes have been sent from each part using
+	 * the *_offset variables.
+	 * We keep track of how many bytes have been sent overall using the
+	 * offset variable, which ranges from 0 to the total length of the
+	 * body.
 	 */
 	while (offset < body_len) {
 		int this_header = header_len;
@@ -1594,12 +1547,20 @@ static void send_fragmented_body(struct netconsole_target *nt,
 		msgbody_offset += this_chunk;
 		this_offset += this_chunk;
 
-		/* after msgbody, append extradata */
-		this_chunk = min(extradata_len - extradata_offset,
+		/* after msgbody, append userdata */
+		this_chunk = min(userdata_len - userdata_offset,
 				 MAX_PRINT_CHUNK - this_header - this_offset);
 		memcpy(nt->buf + this_header + this_offset,
-		       extradata + extradata_offset, this_chunk);
-		extradata_offset += this_chunk;
+		       userdata + userdata_offset, this_chunk);
+		userdata_offset += this_chunk;
+		this_offset += this_chunk;
+
+		/* after userdata, append sysdata */
+		this_chunk = min(sysdata_len - sysdata_offset,
+				 MAX_PRINT_CHUNK - this_header - this_offset);
+		memcpy(nt->buf + this_header + this_offset,
+		       sysdata + sysdata_offset, this_chunk);
+		sysdata_offset += this_chunk;
 		this_offset += this_chunk;
 
 		/* if all is good, send the packet out */
@@ -1615,7 +1576,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				int msg_len,
 				int release_len,
-				int extradata_len)
+				int sysdata_len)
 {
 	int header_len, msgbody_len;
 	const char *msgbody;
@@ -1644,7 +1605,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 * will be replaced
 	 */
 	send_fragmented_body(nt, msgbody, header_len, msgbody_len,
-			     extradata_len);
+			     sysdata_len);
 }
 
 /**
@@ -1660,19 +1621,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			     int msg_len)
 {
+	int userdata_len = 0;
 	int release_len = 0;
-	int extradata_len;
-
-	extradata_len = prepare_extradata(nt);
+	int sysdata_len = 0;
 
+#ifdef CONFIG_NETCONSOLE_DYNAMIC
+	sysdata_len = prepare_sysdata(nt);
+	userdata_len = nt->userdata_length;
+#endif
 	if (nt->release)
 		release_len = strlen(init_utsname()->release) + 1;
 
-	if (msg_len + release_len + extradata_len <= MAX_PRINT_CHUNK)
+	if (msg_len + release_len + sysdata_len + userdata_len <= MAX_PRINT_CHUNK)
 		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
 	return send_msg_fragmented(nt, msg, msg_len, release_len,
-				   extradata_len);
+				   sysdata_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,

-- 
2.47.3


