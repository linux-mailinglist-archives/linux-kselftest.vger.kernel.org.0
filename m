Return-Path: <linux-kselftest+bounces-25663-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93EB7A27057
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F85D3A19C1
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468EC20D504;
	Tue,  4 Feb 2025 11:35:37 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0838620CCF2;
	Tue,  4 Feb 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668937; cv=none; b=ZZQdVUx8nFr9mpklRGHkN7PCmkmQfOnc2ARnitQ9Tt20RG/EBxKRg1WO06p0GYH5P9TAsbJFq68A3Uu41meMtED1vh0O4oXVxmffvDxZy2GzZWGt+pitmoD+VBAedYFqMKRMK9UnpXXe2QbHjD8YeExYaWCqSXXt5Iw+ff7wfMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668937; c=relaxed/simple;
	bh=kU8C8umM4ScJz96Y0T3yehh2t5lXosZmarZW34y+f9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDem9Hrqabgx5dalPs7Ye6TkFAk69+1S3LPBhTto/asO6ehhkiRmnT0N5dB9l2LHfsHv70Ji60uVpYtZ0oXKHLzESPg7loxORG3w/cu/tI8Btf8hTyfkCcAqfcBJq95slsoqZk7HKoLrzpVD2phHSasJCYPCTuqVLO/5+OikZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e9a88793so8697019a12.1;
        Tue, 04 Feb 2025 03:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668932; x=1739273732;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48ZpelgdFKqZGLj2HNZNkwbEfh2/EultLZjsM1GK/BM=;
        b=K8MBSe/UzcpLA1grLdPk6Vw8ZOnDs6Vl4JQfMmy3l7W7QT3B3DPn0fZQMgDWHIigAb
         qBUMcURzALdYfsHrd5B9VLb0N5tBWHeqSO4LkzVRnHWremXWbVD6CyiTnF1U3ToyrHvd
         auGVlGPf59hpMEMTW8HU86lxnuW+97OVoPVChRAyqe8Bcn4viABRIpzlJ/x4YBvYnGtg
         98VPiWKII5F7/6qJDLfbRNpIqomNVkh9U/m+BEOkkJEVCpy+rMinXYtj9kc+u/cH93vc
         J4glOn+coy+S0jPWUCVS7M7nh0g9CW5icY38tNpDl6hkWU6eV6XgZ7+EPyjdMZoQxnlM
         uD+g==
X-Forwarded-Encrypted: i=1; AJvYcCVw2UyDe2F/gM0zYJDKWlC9EoiMDqev0WGj1RWb1pPY9G3s6+Tcq6LIr4WgSuYLDcYFe5meGaBd+2U=@vger.kernel.org, AJvYcCXBnC9TRX7BZ9NnZGmNTEbB9taOZylH2pYDV8N1uiN8vZaoQ13p72m8niavDV30lWdMkevnOXeC49xl9nyi@vger.kernel.org, AJvYcCXgHbOV1TE6BeGwAVIo0BzIRZgUwY0wDNq+GrWCc3ljF24CX5paU0dSYZ8b0JoT9oFpgtBgMjSWYG4LtFWY0WkG@vger.kernel.org
X-Gm-Message-State: AOJu0Yyahah1XeymHpipU1Bg0lmnOjMr7taq3Le9v/2ykCXZNwNiBqcr
	mGQDtqfHGt9kdkpwPbKzyTRpF3cKw4EuLbMHeLfU5NeinZ1FzBP4zBwG4A==
X-Gm-Gg: ASbGncsI+/EFQi86dy0oTizARqJPr+U4CkDxh5Y3OJ/8qpq46q3SzeOLpRO778uOwK2
	Gxfy+glDc36+dz5yvzz1mxvWXfA0OthjcrGr4h0CMG/fs3tTcfKtmLWHI2puwm3sogWMyCfJOoX
	Lnz7DrIz1nfh2zJZfQf1Fhlz6v1x2+oatunlY9qBjwBOplCas1NjGArVJkNbEaLixUdJwUVBPiv
	ESr7+xthexAp/0yy9KNzC28LvyTgsxjnjQZ2rg7YblxgrGZXf76/OhJsMlMJ3qUpW61vXQ6J5t0
	7HeT2w==
X-Google-Smtp-Source: AGHT+IGvRv/eP9TGPyI7DwFHf3/4D3BAqUMT6k83pkkDZK7O6Klwz0N2QElC8P0BP2fqUpFjs/WQ4Q==
X-Received: by 2002:a17:907:6d18:b0:ab7:b30:42ed with SMTP id a640c23a62f3a-ab70b3042f7mr1506615066b.0.1738668931717;
        Tue, 04 Feb 2025 03:35:31 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e4a553c6sm897157766b.165.2025.02.04.03.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:31 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:10 -0800
Subject: [PATCH net-next v4 2/8] netconsole: Rename userdata to extradata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-2-9480266ef556@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10589; i=leitao@debian.org;
 h=from:subject:message-id; bh=kU8C8umM4ScJz96Y0T3yehh2t5lXosZmarZW34y+f9k=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+oqg50bGFHSc+yPkfpUHetG+24kGloJXvG
 EAVkXFq7VWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bbGbD/0eIbqQDD+E6BUznhOLU9YdpuM6AV6wT0HZJdUeKEKPkI6aAkRXNECb5DD+BmX2Jh/CzNb
 ZtSxShU+S0jr2p443GaqgInsZollLHUvTA7/28FwRHGXwXYgoG6S/LYDPL/5b6Tr+xp57/IwRQc
 wL/paX38vn0W5zSNk7G5wHCC9qFbOvalM1DkdDt0GA/0SGxn/nEqH/eHbpNFSBnxZ83Pm55shbk
 oS0xmxymuldUBhoFMC/0nwJFe2Q+Cz3I4aiBzMKQ78d4tbG5doA+dl3TtT1Reky2ZzuQaVBNV9h
 hUt2uaYLAYqfOTOTgcO0BwQ7lpvZn0wgq5P3s4NyuGYdieSAMv8X15anAUs4c1qeFy2034Lcu+f
 O1fwecnt9xkygcaKIKNcVIjDgbpxMmnp+gQ/L438JWA+kyArqTqEhgOmMxzouaa7UBXbf8TlHZF
 MQb+AuyDhCWcZn6tOEdeT4MS7anvvpakbC8SSIS1J1CWPAFl06SonJkMa81KEjb08z9WPKndyEq
 cFihwLXoC84Csd5blI/aSfE+tO7zEbY+bGlpx41lIwEd/cRZDG59faPdJjrBssDxBB01McB+akA
 gDDK9r4Z9kUwHJ2WDm/7JCI3uJSbLLahZcEt0kQnKR+xA4EVFGVfpjm9fcxkHi6mOP31bcbDOlL
 dQIYLUnwga1L/5w==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Rename "userdata" to "extradata" since this structure will hold both
user and system data in future patches. Keep "userdata" term only for
data that comes from userspace (configfs), while "extradata" encompasses
both userdata and future kerneldata.

These are the rules of the design

1. extradata_complete will hold userdata and sysdata (coming)
2. sysdata will come after userdata_length
3. extradata_complete[userdata_length] string will be replaced at every
   message
5. userdata is replaced when configfs changes (update_userdata())
6. sysdata is replaced at every message

Example:
  extradata_complete = "userkey=uservalue cpu=42"
  userdata_length = 17
  sysdata_length = 7 (space (" ") is part of sysdata)

Since sysdata is still not available, you will see the following in the
send functions:

	extradata_len = nt->userdata_length;

The upcoming patches will, which will add support for sysdata, will
change it to:

	extradata_len = nt->userdata_length + sysdata_len;

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 87 ++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index c1ad54d99438dbd14e8288d39ad6bcc6f8ff5ad1..15867bb481e226cbb4164642e470baecca730a40 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -45,12 +45,12 @@ MODULE_DESCRIPTION("Console driver for network interfaces");
 MODULE_LICENSE("GPL");
 
 #define MAX_PARAM_LENGTH		256
-#define MAX_USERDATA_ENTRY_LENGTH	256
-#define MAX_USERDATA_VALUE_LENGTH	200
+#define MAX_EXTRADATA_ENTRY_LEN		256
+#define MAX_EXTRADATA_VALUE_LEN	200
 /* The number 3 comes from userdata entry format characters (' ', '=', '\n') */
-#define MAX_USERDATA_NAME_LENGTH	(MAX_USERDATA_ENTRY_LENGTH - \
-					MAX_USERDATA_VALUE_LENGTH - 3)
-#define MAX_USERDATA_ITEMS		16
+#define MAX_EXTRADATA_NAME_LEN		(MAX_EXTRADATA_ENTRY_LEN - \
+					MAX_EXTRADATA_VALUE_LEN - 3)
+#define MAX_EXTRADATA_ITEMS		16
 #define MAX_PRINT_CHUNK			1000
 
 static char config[MAX_PARAM_LENGTH];
@@ -102,8 +102,8 @@ struct netconsole_target_stats  {
  * @list:	Links this target into the target_list.
  * @group:	Links us into the configfs subsystem hierarchy.
  * @userdata_group:	Links to the userdata configfs hierarchy
- * @userdata_complete:	Cached, formatted string of append
- * @userdata_length:	String length of userdata_complete
+ * @extradata_complete:	Cached, formatted string of append
+ * @userdata_length:	String length of usedata in extradata_complete.
  * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
@@ -130,7 +130,7 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
-	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
+	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
 	size_t			userdata_length;
 #endif
 	struct netconsole_target_stats stats;
@@ -690,7 +690,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 struct userdatum {
 	struct config_item item;
-	char value[MAX_USERDATA_VALUE_LENGTH];
+	char value[MAX_EXTRADATA_VALUE_LEN];
 };
 
 static struct userdatum *to_userdatum(struct config_item *item)
@@ -727,13 +727,13 @@ static void update_userdata(struct netconsole_target *nt)
 
 	/* Clear the current string in case the last userdatum was deleted */
 	nt->userdata_length = 0;
-	nt->userdata_complete[0] = 0;
+	nt->extradata_complete[0] = 0;
 
 	list_for_each(entry, &nt->userdata_group.cg_children) {
 		struct userdatum *udm_item;
 		struct config_item *item;
 
-		if (WARN_ON_ONCE(child_count >= MAX_USERDATA_ITEMS))
+		if (WARN_ON_ONCE(child_count >= MAX_EXTRADATA_ITEMS))
 			break;
 		child_count++;
 
@@ -741,19 +741,19 @@ static void update_userdata(struct netconsole_target *nt)
 		udm_item = to_userdatum(item);
 
 		/* Skip userdata with no value set */
-		if (strnlen(udm_item->value, MAX_USERDATA_VALUE_LENGTH) == 0)
+		if (strnlen(udm_item->value, MAX_EXTRADATA_VALUE_LEN) == 0)
 			continue;
 
-		/* This doesn't overflow userdata_complete since it will write
-		 * one entry length (1/MAX_USERDATA_ITEMS long), entry count is
+		/* This doesn't overflow extradata_complete since it will write
+		 * one entry length (1/MAX_EXTRADATA_ITEMS long), entry count is
 		 * checked to not exceed MAX items with child_count above
 		 */
-		complete_idx += scnprintf(&nt->userdata_complete[complete_idx],
-					  MAX_USERDATA_ENTRY_LENGTH, " %s=%s\n",
+		complete_idx += scnprintf(&nt->extradata_complete[complete_idx],
+					  MAX_EXTRADATA_ENTRY_LEN, " %s=%s\n",
 					  item->ci_name, udm_item->value);
 	}
-	nt->userdata_length = strnlen(nt->userdata_complete,
-				      sizeof(nt->userdata_complete));
+	nt->userdata_length = strnlen(nt->extradata_complete,
+				      sizeof(nt->extradata_complete));
 }
 
 static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
@@ -764,7 +764,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	struct userdata *ud;
 	ssize_t ret;
 
-	if (count > MAX_USERDATA_VALUE_LENGTH)
+	if (count > MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -813,13 +813,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
 	struct userdata *ud;
 	size_t child_count;
 
-	if (strlen(name) > MAX_USERDATA_NAME_LENGTH)
+	if (strlen(name) > MAX_EXTRADATA_NAME_LEN)
 		return ERR_PTR(-ENAMETOOLONG);
 
 	ud = to_userdata(&group->cg_item);
 	nt = userdata_to_target(ud);
 	child_count = list_count_nodes(&nt->userdata_group.cg_children);
-	if (child_count >= MAX_USERDATA_ITEMS)
+	if (child_count >= MAX_EXTRADATA_ITEMS)
 		return ERR_PTR(-ENOSPC);
 
 	udm = kzalloc(sizeof(*udm), GFP_KERNEL);
@@ -1120,11 +1120,11 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      int msg_len,
 				      int release_len)
 {
-	const char *userdata = NULL;
+	const char *extradata = NULL;
 	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
+	extradata = nt->extradata_complete;
 #endif
 
 	if (release_len) {
@@ -1136,10 +1136,10 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 		memcpy(nt->buf, msg, msg_len);
 	}
 
-	if (userdata)
+	if (extradata)
 		msg_len += scnprintf(&nt->buf[msg_len],
 				     MAX_PRINT_CHUNK - msg_len,
-				     "%s", userdata);
+				     "%s", extradata);
 
 	send_udp(nt, nt->buf, msg_len);
 }
@@ -1156,24 +1156,25 @@ static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
 				 int msgbody_len)
 {
-	const char *userdata = NULL;
+	int sent_extradata, preceding_bytes;
+	const char *extradata = NULL;
 	int body_len, offset = 0;
-	int userdata_len = 0;
+	int extradata_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
-	userdata_len = nt->userdata_length;
+	extradata = nt->extradata_complete;
+	extradata_len = nt->userdata_length;
 #endif
 
 	/* body_len represents the number of bytes that will be sent. This is
 	 * bigger than MAX_PRINT_CHUNK, thus, it will be split in multiple
 	 * packets
 	 */
-	body_len = msgbody_len + userdata_len;
+	body_len = msgbody_len + extradata_len;
 
 	/* In each iteration of the while loop below, we send a packet
 	 * containing the header and a portion of the body. The body is
-	 * composed of two parts: msgbody and userdata. We keep track of how
+	 * composed of two parts: msgbody and extradata. We keep track of how
 	 * many bytes have been sent so far using the offset variable, which
 	 * ranges from 0 to the total length of the body.
 	 */
@@ -1201,36 +1202,36 @@ static void send_fragmented_body(struct netconsole_target *nt,
 
 		/* msgbody was finally written, either in the previous
 		 * messages and/or in the current buf. Time to write
-		 * the userdata.
+		 * the extradata.
 		 */
 		msgbody_written |= offset + this_offset >= msgbody_len;
 
-		/* Msg body is fully written and there is pending userdata to
-		 * write, append userdata in this chunk
+		/* Msg body is fully written and there is pending extradata to
+		 * write, append extradata in this chunk
 		 */
 		if (msgbody_written && offset + this_offset < body_len) {
 			/* Track how much user data was already sent. First
 			 * time here, sent_userdata is zero
 			 */
-			int sent_userdata = (offset + this_offset) - msgbody_len;
+			sent_extradata = (offset + this_offset) - msgbody_len;
 			/* offset of bytes used in current buf */
-			int preceding_bytes = this_chunk + this_header;
+			preceding_bytes = this_chunk + this_header;
 
-			if (WARN_ON_ONCE(sent_userdata < 0))
+			if (WARN_ON_ONCE(sent_extradata < 0))
 				return;
 
-			this_chunk = min(userdata_len - sent_userdata,
+			this_chunk = min(extradata_len - sent_extradata,
 					 MAX_PRINT_CHUNK - preceding_bytes);
 			if (WARN_ON_ONCE(this_chunk < 0))
 				/* this_chunk could be zero if all the previous
 				 * message used all the buffer. This is not a
-				 * problem, userdata will be sent in the next
+				 * problem, extradata will be sent in the next
 				 * iteration
 				 */
 				return;
 
 			memcpy(nt->buf + this_header + this_offset,
-			       userdata + sent_userdata,
+			       extradata + sent_extradata,
 			       this_chunk);
 			this_offset += this_chunk;
 		}
@@ -1287,17 +1288,17 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			     int msg_len)
 {
-	int userdata_len = 0;
+	int extradata_len = 0;
 	int release_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata_len = nt->userdata_length;
+	extradata_len = nt->userdata_length;
 #endif
 
 	if (nt->release)
 		release_len = strlen(init_utsname()->release) + 1;
 
-	if (msg_len + release_len + userdata_len <= MAX_PRINT_CHUNK)
+	if (msg_len + release_len + extradata_len <= MAX_PRINT_CHUNK)
 		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
 	return send_msg_fragmented(nt, msg, msg_len, release_len);

-- 
2.43.5


