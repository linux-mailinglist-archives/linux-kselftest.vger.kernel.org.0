Return-Path: <linux-kselftest+bounces-45569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 109A5C58FAA
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 18:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D78F424B56
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 16:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D7365A14;
	Thu, 13 Nov 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWEFJ+4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88B93659E0
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 16:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052156; cv=none; b=nC0hveNEbPb+RYEd/s9LY0WEt6isdO89lEhRmVNj+oOFOdLD2f+ZbYW1etvbg+xew2tZ/JNEjsA1yF3Leur53j9vM4kFZWj7Q1DHi5LeQoq/4SJr+fKW4ewoU2PLa98e4ozGRRuCKYm9jbfGbMtXe8RLWWxgxC3WlW243PNQTPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052156; c=relaxed/simple;
	bh=Weou4cUBuJ16J994m9Jw12hAclJS9i+Gx49oiGHsCsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tVMYmD6xvEv6MA/9ZWFK0dnfEB7xG2pZCaujnpYyDS1qRlJWaNU0IoYEhOnICvfWYPslog0ZbN6sPWtKI8vVJP6XhnCFH6l+SnbhmsZkg6nNMim3LzWOHb3H5wKzJZTaCW0cGTv18wBZUcuNKb0HzdeppsMv09h5SMO+91Nw1ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWEFJ+4D; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4775c4197e1so438785e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Nov 2025 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763052152; x=1763656952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1hVzY4UcjZPSPLTWhsYT/R2QUElmT1sTuICo+mmiFn8=;
        b=IWEFJ+4DL/wy3+wN8YGUOIG92GC4IQERsK6S5w9DEXeTpZvWgW8LNzLpcld8NKSNlJ
         sCHbTEwdYzYj8dvXDUyPS2geINyWQ0i1MzVFsnfeKiupBzxwEVsdmX54tf0mQOwZeUQe
         CmRkRIbxpKCiO8i1R30QSUETpS4yNU4J31j/ZU6U+vRLawShMFL1wf/1lF272CrmcNdS
         E8Dmf94Js9XpgQKXZO3JB6QprrT+jiwziO2zKzPAdkAjwy7RNeaYhxq0gvWEfiOcrSYL
         jlzHGaNCdgup6jo4XcXS1C5yD7H0IpSY0rIQayexy8k3bO8HevF1368UObB150h3+wic
         cenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763052152; x=1763656952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1hVzY4UcjZPSPLTWhsYT/R2QUElmT1sTuICo+mmiFn8=;
        b=rnL99Uje8vSbhzoIyhqAVQazictpx3AwHxPMEPwKn7DVeWmuts/OnW0olxsDby5Day
         zmIMVH3kTgQh3pctbqPHAmJve8OYhSLGaRN5X1OGOamwnG1joUjf6Pf/IBDj1W0ySyE8
         Q7raAq8s1+H5NTPC/4s6ebY0kuoV0ln1yigP+yvob6Wrk4qn51QiIWePHxJatgaR5/NT
         nQtOKgeHkL0aQvKX24WOdR748c8a9++vHlHGNw1kryDO+2cNtFJagqz1LpyI9VzL6/xm
         2UVRa2Vocl/h5UP7CEp7eBEPBi9SKB3aEFsaLh2RQNQo2a17XG88NJUbn8lvdUrtIPZc
         U+hg==
X-Forwarded-Encrypted: i=1; AJvYcCX8xr0pZ/5Wrr7JYY45rkw8t3WFbiPYHahF2q8bOkcrvD+s0dQlh7Nzxnza48kTYUFFlE0TBdpmZl+0dzS5IGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUFvB5W2OIjcbCN2ZPX6LIkxt96hyg9zKPN9v2UqhHQH465hl
	vaHzAZiWOGre7W2dPDXGGEMFZEyfmHyQjuorc99iW8aBxV0l7GmIo01m
X-Gm-Gg: ASbGncspQ+1kF3RQyX4KOvqlWUgl2s5aqcgb7lT3Zy4TQTh68wJAgVKYcz0boaUeAKP
	HtwSsX/7Qzf/TK+nUODqSQ5YzE+Yh4amE6oKqT3sKw9bT6K0sXjsLohYFmKNJvzPQgBwKXao0hn
	BIgwTZc0ZRol+/TmkQ80uvhDS22weuHbfOFOPLAGFARQ5dcMmSk6ed2aZ1DhWL3DsQwjik4wa7D
	Lylw2NV1kJZfHaPphE2I/LVnYcOlhbP8Ssbp0XQdxsD64gz/LvfEcc9Lcn5iLPrkiwIC/ySrKTU
	TEch+Ro5nJBTBQgMEx6G5tvKYXkAM8JmOE5vDpkqgRYI0vi5hYxOPobFTgdtqggd3b3j4kWQ+/s
	66AICkbA9FIbuzUbQLLlZmcMb6hHQbgg3p5uMcjwIe+uNatdrFshtZCdK0Wd+v1hlb6QcMVVOQS
	/0rhcLVlUtbuHdlLV5RorR69JeRA==
X-Google-Smtp-Source: AGHT+IGL/X4HO9I7flrMiWlzkMQGvXs40YCMrVJCpAD7fTFYE/9mwv7lP2H6UO+hyYu+NjKatOjUZQ==
X-Received: by 2002:a05:600c:3b19:b0:477:555b:3411 with SMTP id 5b1f17b1804b1-4778fe5c885mr734175e9.1.1763052151844;
        Thu, 13 Nov 2025 08:42:31 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:43::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47787e8e6a1sm96002735e9.11.2025.11.13.08.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:42:31 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 13 Nov 2025 08:42:20 -0800
Subject: [PATCH net-next v2 3/4] netconsole: Dynamic allocation of userdata
 buffer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-netconsole_dynamic_extradata-v2-3-18cf7fed1026@meta.com>
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

The userdata buffer in struct netconsole_target is currently statically
allocated with a size of MAX_USERDATA_ITEMS * MAX_EXTRADATA_ENTRY_LEN
(16 * 256 = 4096 bytes). This wastes memory when userdata entries are
not used or when only a few entries are configured, which is common in
typical usage scenarios. It also forces us to keep MAX_USERDATA_ITEMS
small to limit the memory wasted.

Change the userdata buffer from a static array to a dynamically
allocated pointer. The buffer is now allocated on-demand in
update_userdata() whenever userdata entries are added, modified, or
removed via configfs. The implementation calculates the exact size
needed for all current userdata entries, allocates a new buffer of that
size, formats the entries into it, and atomically swaps it with the old
buffer.

This approach provides several benefits:
- Memory efficiency: Targets with no userdata use zero bytes instead of
  4KB, and targets with userdata only allocate what they need;
- Scalability: Makes it practical to increase MAX_USERDATA_ITEMS to a
  much larger value without imposing a fixed memory cost on every
  target;
- No hot-path overhead: Allocation occurs during configuration (write to
  configfs), not during message transmission

If memory allocation fails during userdata update, -ENOMEM is returned
to userspace through the configfs attribute write operation.

The sysdata buffer remains statically allocated since it has a smaller
fixed size (MAX_SYSDATA_ITEMS * MAX_EXTRADATA_ENTRY_LEN = 4 * 256 = 1024
bytes) and its content length is less predictable.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 84 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1bd811714322..12fbc303a824 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -155,7 +155,7 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
-	char			userdata[MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS];
+	char			*userdata;
 	size_t			userdata_length;
 	char			sysdata[MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS];
 
@@ -875,45 +875,61 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
 }
 
-static void update_userdata(struct netconsole_target *nt)
+static int update_userdata(struct netconsole_target *nt)
 {
+	struct userdatum *udm_item;
+	struct config_item *item;
 	struct list_head *entry;
-	int child_count = 0;
+	char *old_buf = NULL;
+	char *new_buf = NULL;
 	unsigned long flags;
+	int offset = 0;
+	int len = 0;
 
-	spin_lock_irqsave(&target_list_lock, flags);
-
-	/* Clear the current string in case the last userdatum was deleted */
-	nt->userdata_length = 0;
-	nt->userdata[0] = 0;
-
+	/* Calculate buffer size */
 	list_for_each(entry, &nt->userdata_group.cg_children) {
-		struct userdatum *udm_item;
-		struct config_item *item;
-
-		if (child_count >= MAX_USERDATA_ITEMS) {
-			spin_unlock_irqrestore(&target_list_lock, flags);
-			WARN_ON_ONCE(1);
-			return;
+		item = container_of(entry, struct config_item, ci_entry);
+		udm_item = to_userdatum(item);
+		/* Skip userdata with no value set */
+		if (udm_item->value[0]) {
+			len += snprintf(NULL, 0, " %s=%s\n", item->ci_name,
+					udm_item->value);
 		}
-		child_count++;
+	}
+
+	WARN_ON_ONCE(len > MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS);
+
+	/* Allocate new buffer */
+	if (len) {
+		new_buf = kmalloc(len + 1, GFP_KERNEL);
+		if (!new_buf)
+			return -ENOMEM;
+	}
 
+	/* Write userdata to new buffer */
+	list_for_each(entry, &nt->userdata_group.cg_children) {
 		item = container_of(entry, struct config_item, ci_entry);
 		udm_item = to_userdatum(item);
-
 		/* Skip userdata with no value set */
-		if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) == 0)
-			continue;
-
-		/* This doesn't overflow userdata since it will write
-		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
-		 * checked to not exceed MAX items with child_count above
-		 */
-		nt->userdata_length += scnprintf(&nt->userdata[nt->userdata_length],
-						 MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
-						 item->ci_name, udm_item->value);
+		if (udm_item->value[0]) {
+			offset += scnprintf(&new_buf[offset], len + 1 - offset,
+					    " %s=%s\n", item->ci_name,
+					    udm_item->value);
+		}
 	}
+
+	WARN_ON_ONCE(offset != len);
+
+	/* Switch to new buffer and free old buffer */
+	spin_lock_irqsave(&target_list_lock, flags);
+	old_buf = nt->userdata;
+	nt->userdata = new_buf;
+	nt->userdata_length = len;
 	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	kfree(old_buf);
+
+	return 0;
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
@@ -937,7 +953,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 
 	ud = to_userdata(item->ci_parent);
 	nt = userdata_to_target(ud);
-	update_userdata(nt);
+	ret = update_userdata(nt);
+	if (ret < 0)
+		goto out_unlock;
 	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
@@ -1193,7 +1211,10 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 
 static void netconsole_target_release(struct config_item *item)
 {
-	kfree(to_target(item));
+	struct netconsole_target *nt = to_target(item);
+
+	kfree(nt->userdata);
+	kfree(nt);
 }
 
 static struct configfs_item_operations netconsole_target_item_ops = {
@@ -1874,6 +1895,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 static void free_param_target(struct netconsole_target *nt)
 {
 	netpoll_cleanup(&nt->np);
+#ifdef	CONFIG_NETCONSOLE_DYNAMIC
+	kfree(nt->userdata);
+#endif
 	kfree(nt);
 }
 

-- 
2.47.3


