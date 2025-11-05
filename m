Return-Path: <linux-kselftest+bounces-44831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8FC3700B
	for <lists+linux-kselftest@lfdr.de>; Wed, 05 Nov 2025 18:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F28C3627AAA
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Nov 2025 17:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C17033FE18;
	Wed,  5 Nov 2025 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nk235gMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5C339B4E
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Nov 2025 17:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762362434; cv=none; b=XRw19sawuYpT5MDcGx1fWBSpwiSSeFoelh4DTNSzpZ5bzMMFp43dF22ADNCb2lwJy40/DaxE7OLqvYPQUMjEpCA3LcUeofSLMOFkW7ZFeKvDBWaUjEEt8mIBMkJbqnaeSy3fDR6NkHxRfUk4M6PgXIpnTjr//YQ+W82dIBj6mP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762362434; c=relaxed/simple;
	bh=DFNz/ejJkffO4oOSwMvau6qAbhIyxUbFeMtY00HZjvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eER23Unohrk/vo+msghWlP6LIkDqj65QeR2+s4f6tiQR5sBDKr4N9ZiwBLZKIg9d55fKzUssj2CoWc5RXzKLzWYz3N7e4gho4kh9UWxfQJCsBKKDX9LVWIrTaqGXu5SzQEmFoiWkPSoy3uAVgajCkVxUS3dv7yedGJEpMfdSV4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nk235gMz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710653ac03so13265e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 05 Nov 2025 09:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762362430; x=1762967230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSpTpNA8dU2VgWFE2OXhins+HfyeU+CDDzVZ8NCLtPo=;
        b=Nk235gMzsSxCkwjjC6gJFqR0dYM+XO7iGmS7RizM4Cp2HQyKOUkMbV1ntKBuy/P5W2
         jszk4k1qaVs6zP/O8JSHUV07oVO0wDokOlAB35RdDtzttEgw/W+UBUgFu21CVjbO+UNw
         VJXDGIiapk29HPwwQrnFL1XIr0IEC2G1gmY/CXY5DXglPYnrAF0TgWwe5q6HFXhqGlry
         +Q/eSZ9VI5NCBoNXTV2+ziaEj0JBAFwnoZIPtPh7WuPc99Lv99y+8vzy6qtJClb7Mb3C
         bOIinhzUYwk77EOUiUnM0gBu/MW7Ogp9CILtbWdF5Ot/UCcpn2DhF2pWu3VzNwmAvXfN
         3uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762362430; x=1762967230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VSpTpNA8dU2VgWFE2OXhins+HfyeU+CDDzVZ8NCLtPo=;
        b=Il17105IhRRi7QrLd6glEUNJGsYd338jWiIZusSyMWR2YOlwtS1sMNO/g1NEnmCG7U
         akmZMD+mSbwBJa/aOlWKFX1Z07DbN9iY0V8m8zQSBgEPOCvBhGQ0tw+6VITtNlhMa0Df
         cRPZutVBsliJTyVs4Ene5wrLbdftdTzjmVWx6jro6MkBp8Pf3ZVsWo6EPuFhQdEuXGzo
         gQtOHsWgIJDqbeCL5jqkhyX+ofodh+D/NiEAc9mfwVabrCtcRpHhiQoJCC+2024RPPxB
         SjdNWGQlp4CVkTPql9A5mUPx8eBzp5BgiE5jZLZMn4t3bPVMYFAhBnMfHnzKIL3T/mDg
         2/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVagGBY8QbOluva/2ksdYrxaAf023hXUk3hToqDaUMDo12gDPMnuU5hVOt6AQ0x38LxiSY1AMB8+WqWkvSz8yM=@vger.kernel.org
X-Gm-Message-State: AOJu0YythkaGBDPoZ7EVpQVXTqRoqNnQE2wuCkquMCxPNSsLiTOTAmvD
	nJYsQFmYLzEhVblAcf/3zRlJ/gjgL3trsr2DLjGHB6hHuX86jXuPMr1w
X-Gm-Gg: ASbGncvc9ZKdNG74bS3fCKBfltBEUmXuul4kKiSRP8dFHsXrU7na+oDYBcqWKA+7hBM
	mo6Re4KG9YjEipDV16ppiFKPpD/AE70xUx5mLSz9hrAcqZfJ4iAMOA6dP3UIlXRzlH/Q9Hk2AO6
	Lm7fey9FSFxkNuzt2wYupnaud8TSX801W7dqcrjBTfLfvBFyDxrtt4wOJMZssvMfaToxCRufpxv
	Dz5l5yA0WyjbMRh590WcDvnT6nEdplDi071M28h4Y+SdACs+qM78GjyRXqHDfMRT6Ked/U5XECn
	2bCz+HJ2OXyi7Hn/6SQeIbfamdnvhbVfuLz+yI3MV67daM6PROlZRpMWg7N0fyQj2nO5fHeBQgJ
	+MwhmrtF+vSmTcqhszwDhfnG1E5QuS2PGgPwpf+bJMD7cAiJHAmIICQh2ja0ZGrOTTC4tTFC9ry
	emaPMZqxy827OqQ84=
X-Google-Smtp-Source: AGHT+IGnZ+2VvaWa5GyWqJqzkHv1KLVSFIQGStAfdtAnK0L8qP0/HIRfoQhdMFNTRaDwvqH7Ca/tkA==
X-Received: by 2002:a05:600c:198a:b0:475:dc06:b5a8 with SMTP id 5b1f17b1804b1-4775ce24f38mr19442805e9.7.1762362429569;
        Wed, 05 Nov 2025 09:07:09 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dbf53e86sm11553010f8f.0.2025.11.05.09.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 09:07:09 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 05 Nov 2025 09:06:45 -0800
Subject: [PATCH net-next 3/4] netconsole: Dynamic allocation of userdata
 buffer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-netconsole_dynamic_extradata-v1-3-142890bf4936@meta.com>
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
 drivers/net/netconsole.c | 87 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 31 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e780c884db83..8a11b3ca2763 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -154,7 +154,7 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
-	char			userdata[MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS];
+	char			*userdata;
 	size_t			userdata_length;
 	char			sysdata[MAX_EXTRADATA_ENTRY_LEN * MAX_SYSDATA_ITEMS];
 
@@ -874,45 +874,61 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
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
@@ -935,7 +951,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 
 	ud = to_userdata(item->ci_parent);
 	nt = userdata_to_target(ud);
-	update_userdata(nt);
+	ret = update_userdata(nt);
+	if (ret < 0)
+		goto out_unlock;
 	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
@@ -1182,7 +1200,10 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 
 static void netconsole_target_release(struct config_item *item)
 {
-	kfree(to_target(item));
+	struct netconsole_target *nt = to_target(item);
+
+	kfree(nt->userdata);
+	kfree(nt);
 }
 
 static struct configfs_item_operations netconsole_target_item_ops = {
@@ -1478,7 +1499,8 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
 	msg_len += scnprintf(&nt->buf[msg_len],
 			     MAX_PRINT_CHUNK - msg_len,
-			     "%s%s", nt->userdata, nt->sysdata);
+			     "%s%s", nt->userdata ? nt->userdata : "",
+			     nt->sysdata);
 #endif
 	send_udp(nt, nt->buf, msg_len);
 }
@@ -1841,6 +1863,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
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


