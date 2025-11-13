Return-Path: <linux-kselftest+bounces-45568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D855DC58E7D
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF20E4E51BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F903659F0;
	Thu, 13 Nov 2025 16:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOVZCASF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0410C358D07
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052154; cv=none; b=Jw6QVz8CkbxkBLsPJIJh9x0iBMMvFb/b/FRnTLvzUcwVR/3Wd471TdO3Q5eVweuM/9aeKXDDlcHIXZ+xER6h0V73m0ZWDGxEA6v/0NlPHy+ezZhGWoi2hEd5Xd2ehpxW8j1TprwoqYctHFYqmENPDp+073WzBXyketWoxf56Gjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052154; c=relaxed/simple;
	bh=XnSl+e7Mv0ReQ70IMR8QE8vWBucnxfNkshrw+tadZ5A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFKrKxmd5dXx81BMStOzhYj77KB2yEzEkrCyIQ7AWiZXdFbtB75Y2L6pQBxBtpHzayauMhtZsTlfSY0VzuIpgbwJXq436qPv3bNFZJGckBCKkqMMFdHBH54Ao5hEF+DdLLo1tjgkXe23z9DZzaSKV7EB8e3BbUOgbvQcvJlYPkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOVZCASF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3288fc31so105202f8f.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 08:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052150; x=1763656950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5xz0y3KJ6p5IbueJDXB+2l4hCwWH/Yg3kMmdcZegJCU=;
        b=MOVZCASFrywk+g3DYPysbcOUXBZk79hhoPXhdKc1oywlfiHhBTvOBLlvAVdfE2iLcB
         n4/2ztT4DAJx6ciUI6Guj2ezpO3UqbE2IA29VbpOl5nnHJDwyayeAeqizA2aRGvI5H2t
         Gg+lb+buSPJwYQRTeIthxnC9b0Tv+4MqQTFz6pQvPxRW5Fmrq2yiBfTHAQmtT2zJtBNF
         RytorvBPMGxwYQNTcdLM22FXPK9Ygg3dQYx94HMndM/gt20EIcxB2SAo8OjodBRac1LO
         HFH5n/CSoFp/AlSQyle1gIc1OYu1aQLPu7sv9DoTz3NAnXWroIVmOIlfIpfLJXelI3Z2
         h2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052150; x=1763656950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5xz0y3KJ6p5IbueJDXB+2l4hCwWH/Yg3kMmdcZegJCU=;
        b=QAfjUvEwjTp/X4ktohCjlX0ix0KEV+2OCf+wvY3VH5ALS37PQ/j8e2Mex2z7svAGK/
         U1cWOMf34WPzxNRWsGNAVk7LdG53JgFNdAg39gaEWRCYhYyX/Pw9UGpf48JSmWjHOz3m
         yS0qyhKVXKI4d6fzSqdZjgbkTRfp0CZvde2/qy74yxpeNbixGLlzDcj89cpDFGxLIndT
         LRbTV/skYgI+c7Mj9PdmNdZAthD2plUkn8qmTpl2GkxJUSZBkSWzJFuy/XQdNHq1eZdF
         QP5i3OHM1Ia6Y1FApqEq9HVP3g7BKpbBAEhrhONfs7FbA/v1Ns6hLNWzKVpqJaGN4hwx
         Iy5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbNOhq2gwDltqUbVpjg0hrpjIvhd/Rk7Yv+rFGmXqL+ugQ67mrkCFQtXVBSXNKHCG+INt+xNnqD4YvWzd+Rgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTijzDcC8322CqorFgo4+0wZ/UR7qo9GE9EYFDw6IHglZ8SxGy
	zmhCd7YU9WfuuETL52wJEcNPcS8cFFzOneGiWv/9wkrLkN744gpWXB+e
X-Gm-Gg: ASbGncv8/BgAdURQvVLhIS3MV71WloeVx4k7mAE+MehRNWAvFTJS15ZZMoWz2iLktaC
	19JqJLWyleDM9dPnIBSoIWenTsdgdbtGnb5aLFHao5LziiBK0DZx74ZhsLNg0cvZA9Jn5YE/gx9
	1bruebvzp8KhYmto1OTH95Cjsyg2cQfHfaf/AQiGbuFFPWqx1O8OqlXTTFyXKKWncSK7yr/QidB
	Ekphrb4hMSG6ooqsI4+qk+3DpGEt9JMdjwvSAw3Jx2GYX4cyDIcGvvAdMEuPrIhIjoUocSD0KDC
	eUGskd7M7BgraDnQG4lltpV+vMOyZ/WdR1z9OE37zut4ZEpJBykTuzrwce/tOJjUMUiMuHdcZvG
	d/iKbCJv7LaD2HZX5wV4yHtA/+NKV5pFl7s91EeH88iEGG612xrioOLJPBFXjL2gAHbTNlquSlR
	TZEW0nMD27hwrPMwlJ8mfmz7p86wsTh01JSqsl
X-Google-Smtp-Source: AGHT+IGhNnEPec5+FBsAp3vnSvc0/M3J1MuNwenJpEDSVtVn66SukqVhYMOMxe9+CaO1VBCpTTSGMw==
X-Received: by 2002:a05:6000:2509:b0:429:c8f6:587c with SMTP id ffacd0b85a97d-42b592d61d3mr53101f8f.0.1763052150134;
        Thu, 13 Nov 2025 08:42:30 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:40::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e84a44sm4617135f8f.14.2025.11.13.08.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:42:29 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 13 Nov 2025 08:42:19 -0800
Subject: [PATCH net-next v2 2/4] netconsole: Split userdata and sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-netconsole_dynamic_extradata-v2-2-18cf7fed1026@meta.com>
References: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
In-Reply-To: <20251113-netconsole_dynamic_extradata-v2-0-18cf7fed1026@meta.com>
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
 drivers/net/netconsole.c | 215 +++++++++++++++++++++--------------------------
 1 file changed, 98 insertions(+), 117 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 5fe5896d6ff5..1bd811714322 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -50,7 +50,7 @@ MODULE_LICENSE("GPL");
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
 #define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
 					MAX_EXTRADATA_VALUE_LEN - 3)
-#define MAX_EXTRADATA_ITEMS		16
+#define MAX_USERDATA_ITEMS		16
 #define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
@@ -115,6 +115,8 @@ enum sysdata_feature {
 	SYSDATA_RELEASE = BIT(2),
 	/* Include a per-target message ID as part of sysdata */
 	SYSDATA_MSGID = BIT(3),
+	/* Sentinel: highest bit position */
+	MAX_SYSDATA_ITEMS = 4,
 };
 
 /**
@@ -122,8 +124,9 @@ enum sysdata_feature {
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
@@ -152,8 +155,10 @@ struct netconsole_target {
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
@@ -802,28 +807,14 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
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
@@ -894,13 +885,13 @@ static void update_userdata(struct netconsole_target *nt)
 
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
@@ -914,11 +905,11 @@ static void update_userdata(struct netconsole_target *nt)
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
@@ -962,7 +953,7 @@ static void disable_sysdata_feature(struct netconsole_target *nt,
 				    enum sysdata_feature feature)
 {
 	nt->sysdata_fields &= ~feature;
-	nt->extradata_complete[nt->userdata_length] = 0;
+	nt->sysdata[0] = 0;
 }
 
 static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
@@ -982,12 +973,6 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
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
@@ -995,7 +980,6 @@ static ssize_t sysdata_msgid_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1018,12 +1002,6 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
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
@@ -1031,7 +1009,6 @@ static ssize_t sysdata_release_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1054,12 +1031,6 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
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
@@ -1067,7 +1038,6 @@ static ssize_t sysdata_taskname_enabled_store(struct config_item *item,
 
 unlock_ok:
 	ret = strnlen(buf, count);
-unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1092,27 +1062,16 @@ static ssize_t sysdata_cpu_nr_enabled_store(struct config_item *item,
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
 	mutex_unlock(&netconsole_subsys.su_mutex);
 	return ret;
@@ -1156,7 +1115,7 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
-	if (count_extradata_entries(nt) >= MAX_EXTRADATA_ITEMS)
+	if (count_userdata_entries(nt) >= MAX_USERDATA_ITEMS)
 		return ERR_PTR(-ENOSPC);
 
 	udm = kzalloc(sizeof(*udm), GFP_KERNEL);
@@ -1363,22 +1322,21 @@ static void populate_configfs_item(struct netconsole_target *nt,
 
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
@@ -1386,46 +1344,36 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
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
 
@@ -1527,11 +1475,13 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      int msg_len,
 				      int release_len)
 {
-	const char *extradata = NULL;
+	const char *userdata = NULL;
+	const char *sysdata = NULL;
 	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata = nt->extradata_complete;
+	userdata = nt->userdata;
+	sysdata = nt->sysdata;
 #endif
 
 	if (release_len) {
@@ -1543,10 +1493,15 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 		memcpy(nt->buf, msg, msg_len);
 	}
 
-	if (extradata)
+	if (userdata)
 		msg_len += scnprintf(&nt->buf[msg_len],
-				     MAX_PRINT_CHUNK - msg_len,
-				     "%s", extradata);
+				     MAX_PRINT_CHUNK - msg_len, "%s",
+				     userdata);
+
+	if (sysdata)
+		msg_len += scnprintf(&nt->buf[msg_len],
+				     MAX_PRINT_CHUNK - msg_len, "%s",
+				     sysdata);
 
 	send_udp(nt, nt->buf, msg_len);
 }
@@ -1561,33 +1516,45 @@ static void append_release(char *buf)
 
 static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody_ptr, int header_len,
-				 int msgbody_len, int extradata_len)
+				 int msgbody_len, int sysdata_len)
 {
-	const char *extradata_ptr = NULL;
+	const char *userdata_ptr = NULL;
+	const char *sysdata_ptr = NULL;
 	int data_len, data_sent = 0;
-	int extradata_offset = 0;
+	int userdata_offset = 0;
+	int sysdata_offset = 0;
 	int msgbody_offset = 0;
+	int userdata_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata_ptr = nt->extradata_complete;
+	userdata_ptr = nt->userdata;
+	sysdata_ptr = nt->sysdata;
+	userdata_len = nt->userdata_length;
 #endif
-	if (WARN_ON_ONCE(!extradata_ptr && extradata_len != 0))
+	if (WARN_ON_ONCE(!userdata_ptr && userdata_len != 0))
+		return;
+
+	if (WARN_ON_ONCE(!sysdata_ptr && sysdata_len != 0))
 		return;
 
 	/* data_len represents the number of bytes that will be sent. This is
 	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
 	 * packets
 	 */
-	data_len = msgbody_len + extradata_len;
+	data_len = msgbody_len + userdata_len + sysdata_len;
 
 	/* In each iteration of the while loop below, we send a packet
 	 * containing the header and a portion of the data. The data is
-	 * composed of two parts: msgbody and extradata. We keep track of how
-	 * many bytes have been sent so far using the data_sent variable, which
-	 * ranges from 0 to the total bytes to be sent.
+	 * composed of three parts: msgbody, userdata, and sysdata.
+	 * We keep track of how many bytes have been sent from each part using
+	 * the *_offset variables.
+	 * We keep track of how many bytes have been sent overall using the
+	 * data_sent variable, which ranges from 0 to the total bytes to be
+	 * sent.
 	 */
 	while (data_sent < data_len) {
-		int extradata_left = extradata_len - extradata_offset;
+		int userdata_left = userdata_len - userdata_offset;
+		int sysdata_left = sysdata_len - sysdata_offset;
 		int msgbody_left = msgbody_len - msgbody_offset;
 		int buf_offset = 0;
 		int this_chunk = 0;
@@ -1608,13 +1575,24 @@ static void send_fragmented_body(struct netconsole_target *nt,
 		buf_offset += this_chunk;
 		data_sent += this_chunk;
 
-		/* after msgbody, append extradata */
-		if (extradata_ptr && extradata_left) {
-			this_chunk = min(extradata_left,
+		/* after msgbody, append userdata */
+		if (userdata_ptr && userdata_left) {
+			this_chunk = min(userdata_left,
 					 MAX_PRINT_CHUNK - buf_offset);
 			memcpy(nt->buf + buf_offset,
-			       extradata_ptr + extradata_offset, this_chunk);
-			extradata_offset += this_chunk;
+			       userdata_ptr + userdata_offset, this_chunk);
+			userdata_offset += this_chunk;
+			buf_offset += this_chunk;
+			data_sent += this_chunk;
+		}
+
+		/* after userdata, append sysdata */
+		if (sysdata_ptr && sysdata_left) {
+			this_chunk = min(sysdata_left,
+					 MAX_PRINT_CHUNK - buf_offset);
+			memcpy(nt->buf + buf_offset,
+			       sysdata_ptr + sysdata_offset, this_chunk);
+			sysdata_offset += this_chunk;
 			buf_offset += this_chunk;
 			data_sent += this_chunk;
 		}
@@ -1631,7 +1609,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				int msg_len,
 				int release_len,
-				int extradata_len)
+				int sysdata_len)
 {
 	int header_len, msgbody_len;
 	const char *msgbody;
@@ -1660,7 +1638,7 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 * will be replaced
 	 */
 	send_fragmented_body(nt, msgbody, header_len, msgbody_len,
-			     extradata_len);
+			     sysdata_len);
 }
 
 /**
@@ -1676,19 +1654,22 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


