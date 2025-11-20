Return-Path: <linux-kselftest+bounces-46032-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 60035C71865
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 01:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C7D9F350030
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 00:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B506B1C5D59;
	Thu, 20 Nov 2025 00:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVdymMPL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DC819FA93
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 00:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763597734; cv=none; b=YYwLvlsrs7qWz4yNowRr2dGmVgunt2s8l3dwK2mDPlqC7OtWQVmow09ARsgBVn0vyXk0Ep738Wvojr0eCVoaYQXLKW00eSLQliZURStLXYYQfZGlue/Ay49650czRKqMYxIxfDo9LC+ksInYQlZ/p4Rqq6b2j9YvWMIbZ3OygGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763597734; c=relaxed/simple;
	bh=kiLZnB7V3oRRKyDtpxL+bmJ91OS8alTGnIrM+Xg3Y10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TnQXBqFemmAWzc5loycs+5HktRxubASnJpWPhi2mY5xMkUgAwz7mIVhwM6meWKQwMWdZUCMQZSr2Bmu7LmViuAej0RgGR1RlmZdhFQIY4ZSxHBdyzJslHW/s448oJADhEmGySI0HRf1fEF8nyEG5TA71ceVKKnByy9qfulUH7Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVdymMPL; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429c8d1be2eso38593f8f.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 16:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763597731; x=1764202531; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2vhVpii8LgsowqvzzxuLZsno7LX3ZQOMIJUlQ5i2ZhQ=;
        b=PVdymMPLRK3rYHMgVA9zo1XHncyicNba6T0wenwrtTxWfhMCp4XvccL6+u4W8ytXTb
         ocR5l8dFA1CR4phfYE/xnfI8gVI/LuoOZfvlHFu0LKWezunf51XyOT06YZj0bx6ELh2U
         oPikoXEuQ+P2x8j5mIEBM6+Uc6493o8UEOfkC8O9gOWgGkxKrliq39cKu/9yHVLnuiyY
         sYPDPeq/miTkO76B9G/xFUV5XYSiubfEl3vAsolQ4fxx2R2YYD+G1BvGDApOPHfhdSh0
         9RFJsCcarfogSOeukRqwGdZnN+SJDVoEh+l9RKiRQeEZyx1vWUFSvqlBI6M6ARB2Yijx
         9ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763597731; x=1764202531;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2vhVpii8LgsowqvzzxuLZsno7LX3ZQOMIJUlQ5i2ZhQ=;
        b=aJ+4ZRLtvteWyAEmwjYywXTl7QVvi/jYxpfmLasMpKQzlZCG0svobqoxdQGRRwYya/
         dfuH/Gw/wZq8kYS6XP0UCvuVVVJ5XuKcEx09LP317VpKiWYoreH/9iQ45xAjPLxf7RYJ
         X0hPFTnsp4oVczLcbfIO+M79pmRyBJC31Ty8RWfXnDp86869OZDsq+Dj/cO2//4f6NxF
         K7zw8RduUc+Dwuwt3fmidlGM9ghrMPOk8lhU/WWmrTyjGpnkff9x90WyGpORkiKDQCYi
         5Z54cSUjIY9yQzyTtnSc1heH5VnIlUpjn9+xQPREIYnGmiUjcXUqFDt1MfeU1v1eTLPO
         y2gw==
X-Forwarded-Encrypted: i=1; AJvYcCXNJV3xrzZzd6YFlHUmjRlIUEOBY/jwu0qUG/Du3NGjwbaW2zGjah2FjhNJKrWLCsS7JCTJAcp0JdttSNIdUpk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg1U0CKGQvBc8DtO0p5LaugD6IMoozrV4gsGKzhuSlfFgI9Rif
	jurDRPhRV9l9gFVKPWxIiC4vqqQWDVJU2DVidu9LqyEYKLdOzkvPbe2C
X-Gm-Gg: ASbGncv7Lmti1vtY+GlvWtvtx+Y7Ly1ywOY2TwRiyHIkv/xFD+JynOoZbGv6PH44z1J
	pQFeg1srpjEHFPTbNNs/mBTlWbhaKlJan7UUA6TIe6VWNNr40JIbWkJ1wlS6caA4w+5+mjVZna6
	fBJOR7kcfVWwk+PfZO+oiXvVDYYEMqQLV/XvLlNK5b4nwvEyZxOX9Zz7vInzyCAkqrSCLdXXgDx
	6iUvdtn1LSe4ZTqDjqvh103YraZdRFLoUbjKvxljdg11pHP2ApKpUrISXBvnyHVVR8yNGgJBK2f
	6tAfaBWux74i0/sLcDxefjx7iuYPke4QFRsmOrkFxK+KWQQBnCyW6599inJlMKODRj8e6ZyC/IX
	eIOrJa9B8fQnNqVBYaUthaDBFs1PnB6Fyp11TZ5Upn1BGJrzbdcIIQXMzqVH6sWkyo3L1bA8SKr
	KF/5ED8xUQ1DlYG4PTqf58mYZZTfbmj4nKFMvG
X-Google-Smtp-Source: AGHT+IF2MRiH1UMlf7EeKR28jq1KCEB+qNGWKKavy66pwwS77hnOtqSMicugRf/j58+WJYPncLzdPQ==
X-Received: by 2002:a05:600c:1d1d:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-477b8da2349mr5176775e9.6.1763597730861;
        Wed, 19 Nov 2025 16:15:30 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:5::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10804c8sm76579615e9.15.2025.11.19.16.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 16:15:30 -0800 (PST)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 19 Nov 2025 16:14:51 -0800
Subject: [PATCH net-next v3 3/4] netconsole: Dynamic allocation of userdata
 buffer
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-netconsole_dynamic_extradata-v3-3-497ac3191707@meta.com>
References: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
In-Reply-To: <20251119-netconsole_dynamic_extradata-v3-0-497ac3191707@meta.com>
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
 drivers/net/netconsole.c | 100 +++++++++++++++++++++++++++++++++--------------
 1 file changed, 70 insertions(+), 30 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1bd811714322..0b350f82d915 100644
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
 
@@ -875,45 +875,77 @@ static ssize_t userdatum_value_show(struct config_item *item, char *buf)
 	return sysfs_emit(buf, "%s\n", &(to_userdatum(item)->value[0]));
 }
 
-static void update_userdata(struct netconsole_target *nt)
+/* Navigate configfs and calculate the lentgh of the formatted string
+ * representing userdata.
+ * Must be called holding netconsole_subsys.su_mutex
+ */
+static int calc_userdata_len(struct netconsole_target *nt)
 {
+	struct userdatum *udm_item;
+	struct config_item *item;
 	struct list_head *entry;
-	int child_count = 0;
-	unsigned long flags;
+	int len = 0;
 
-	spin_lock_irqsave(&target_list_lock, flags);
+	list_for_each(entry, &nt->userdata_group.cg_children) {
+		item = container_of(entry, struct config_item, ci_entry);
+		udm_item = to_userdatum(item);
+		/* Skip userdata with no value set */
+		if (udm_item->value[0]) {
+			len += snprintf(NULL, 0, " %s=%s\n", item->ci_name,
+					udm_item->value);
+		}
+	}
+	return len;
+}
 
-	/* Clear the current string in case the last userdatum was deleted */
-	nt->userdata_length = 0;
-	nt->userdata[0] = 0;
+static int update_userdata(struct netconsole_target *nt)
+{
+	struct userdatum *udm_item;
+	struct config_item *item;
+	struct list_head *entry;
+	char *old_buf = NULL;
+	char *new_buf = NULL;
+	unsigned long flags;
+	int offset = 0;
+	int len;
 
-	list_for_each(entry, &nt->userdata_group.cg_children) {
-		struct userdatum *udm_item;
-		struct config_item *item;
+	/* Calculate required buffer size */
+	len = calc_userdata_len(nt);
 
-		if (child_count >= MAX_USERDATA_ITEMS) {
-			spin_unlock_irqrestore(&target_list_lock, flags);
-			WARN_ON_ONCE(1);
-			return;
-		}
-		child_count++;
+	if (WARN_ON_ONCE(len > MAX_EXTRADATA_ENTRY_LEN * MAX_USERDATA_ITEMS))
+		return -ENOSPC;
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
+	nt->userdata_length = offset;
 	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	kfree(old_buf);
+
+	return 0;
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
@@ -937,7 +969,9 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 
 	ud = to_userdata(item->ci_parent);
 	nt = userdata_to_target(ud);
-	update_userdata(nt);
+	ret = update_userdata(nt);
+	if (ret < 0)
+		goto out_unlock;
 	ret = count;
 out_unlock:
 	mutex_unlock(&dynamic_netconsole_mutex);
@@ -1193,7 +1227,10 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 
 static void netconsole_target_release(struct config_item *item)
 {
-	kfree(to_target(item));
+	struct netconsole_target *nt = to_target(item);
+
+	kfree(nt->userdata);
+	kfree(nt);
 }
 
 static struct configfs_item_operations netconsole_target_item_ops = {
@@ -1874,6 +1911,9 @@ static struct netconsole_target *alloc_param_target(char *target_config,
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


