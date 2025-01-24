Return-Path: <linux-kselftest+bounces-25102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AABA1B8BC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FDF316B0C7
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85E16DEDF;
	Fri, 24 Jan 2025 15:17:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B20158DD0;
	Fri, 24 Jan 2025 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731829; cv=none; b=PHwmTCoPoS0Vh7O3powAMiJm7obtSL1BwanmOTqKfwv/ms2LCIVxih1SIHMQmCuHTpZidEDtibrA6HliPi9VZnIREtnCXRQoBf3twBJK5FeZ99JkdCGE3Ryz8Cbz3WMxOwx0h8jgCYqHtwB0g3PpkSplc+dkyPQlNNnkWEDLa2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731829; c=relaxed/simple;
	bh=Ao8Bs78JWxllxyF30dJaAHCQnMH5vPji5urPY0Ka0W8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6xQUxj6YD7/34Fsw500ssuPkbICU+Mx6l64QkMpkZLgltdd+bLjDFIofSA05aBSagSCWYNBgnbCTuFybhHtyxDY4Z9puMyZV7nrGj8iOCwQLawaLPTqkuV3rj75seTKsJhrmHS6bkvJDFhjvl7ka4UlD5ZXv2r9L1z4OMqURoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dc149e14fcso2615897a12.2;
        Fri, 24 Jan 2025 07:17:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731825; x=1738336625;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Q9FA5+y3TSH0h6S+zIICHxD3JLDLno9rduHb4UMqf0=;
        b=hBJhqHs0j7t2jFN6B/3++sCKM5TajvU303Ee3k3L8aNUM3HqtltZ43vpntc11blv5y
         qzIn+rj8MpMBmf8Dnve0Jqu5UBNN+Ep6nlIp29Fs2emalb6K1/y4yVRC8pCLyGMVXHS1
         SfZf5eEDGCGIzSIsvOhTPe3u6D2rCg8VuAnDWwC1gxFLNDfkvlq2+ngQOAqxK9k6gn5E
         IODh5Mvti+EjH1C4+QUEWKZYIedg7t3Yrctm5sz4S61qYblH6dzXzcMD7jvNsvajmESs
         uxrvFSqQzUCC6ycJisR1E0q1ivtJPWZEDcX0dIZwuCQ3W6g0EehUtHvC1Ym59KbjBa7/
         qeiw==
X-Forwarded-Encrypted: i=1; AJvYcCUq7PHSNfU9wpx/VHp18QdglpvyzQj2ephEGmj67cUtYE+AJobJuYdqCOlFmCCEGfB/qDD2TMebLO6ERhLo@vger.kernel.org, AJvYcCVp9/KUxWrsHt2rIoR3Mayyl54802VFHbFdpgN4mrlFXuwk2+qdy08LXEli3XJnT8r7iX8SbuN/qfdGME08GrOO@vger.kernel.org, AJvYcCXRuK2MssxOUgZWGx76mzp5Og/HuF8Wf0t6tzBOOobQclRJYbj7+tVN8U5aufhh4yqgdTNkB7s9W+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4SxGMLs74tyqhAMrX8a8NB5Rpwhy5JuIeYO4nDguC8TMAbGQ
	1B1pUFB78UNON38vGPP+HtjppaIT09pffCBDF+i+jFWLixSOqlrgzaqtfg==
X-Gm-Gg: ASbGncvkM6Y4RCzrCWxGXvT6LIjxpAvoqmos2kjfOeC6Hz+H6IuZeGjy7sBDvVaTJ8k
	DY6PvekDkA2tKdydtvBjVCSkurfr8TtQeLmExwg1lsOnZCOlPT/s4hNH53f+lgKG0W+fIJLyy8C
	Y6HN2GwwDSacRv83JGtvPKNgMfah/vDTyEyV2QzfWK4xLfQ3ZgS7NLc2YHEZMhOj4btAToguO6J
	du9fJSkMOm9ycNyXyXu83EMe4iPHACgzMRUjmhl13yTHQzZiKnmEMVDmVXyP4bYPn3XNCt5
X-Google-Smtp-Source: AGHT+IE7lfd6ufDq6KEasiaxTyo2iyPX7uokoc5vrLMqpxurzW91F3yIHafzjcKEZ0VRjFY3rl9yFg==
X-Received: by 2002:a50:9346:0:b0:5db:d9ac:b302 with SMTP id 4fb4d7f45d1cf-5dbd9acb39dmr13142408a12.32.1737731825099;
        Fri, 24 Jan 2025 07:17:05 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18638e5asm1306413a12.34.2025.01.24.07.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:04 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:41 -0800
Subject: [PATCH RFC net-next v3 2/8] netconsole: Rename userdata to
 extradata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-2-12a0d286ba1d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10543; i=leitao@debian.org;
 h=from:subject:message-id; bh=Ao8Bs78JWxllxyF30dJaAHCQnMH5vPji5urPY0Ka0W8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67qXBmoHzqGCGTV2/I/ITdvFfR/2ePnXlROy
 8ZW4TKJsJ+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6gAKCRA1o5Of/Hh3
 be8FEACv146PdRzT9mbtAvM78UjmRn7AkzwdqfF312qPijIdjbxhygkuIk7Mc31kI+V0tQemBSx
 9m8yKH8ZBWtMEEjHjpEGr/H+pQ2aBAIhSE192mk6IP2pTLvwQ6wPzVH75PO6kTu0xlbc3Ijjk/0
 tMU+10bKaWnYIwdGd5GbZ1Q0idiW9BoK3nVd0FXtNmmLxicuRhl1Mwy8abP6nxM2ip0h29LwaWi
 vSk2LnyHYVWYLEzZh05jQ+cs0fzZqQJcWpwbJ8BYvrdOhWnj+KJOUPMzD7hs8S4S07VcsLh6mnG
 iAV5TlX57bFTxRNI+LwV+EhJAtFmS8YHSqe/+frPe3uw03kFZZi9CC63TTnCcM8X88xj9Hc45Vh
 33CQ/tTgNRxKdsg0JV7j7PTo+yh7KleFPf3p5b52iJ3Pbhy11GrShO5INuFFhyk7W4ePq+Mtpzf
 1LWbR0owKURHLu/H2cZVusBEaWVxtbIzRSqLmSvsIiQ9lyxcFRx73Wfq5ldkeA1uWQ2lBBrkbmK
 fxphbdPzEp3PI+V5IjDqhVFx8/pW7mTLD+EMUycl+T4uYza/3bF/ZQu7VDnJlcQiOBqn5CzLJPp
 3iIOK4I2wMwFyp2rIROJcC6VQ96AucifrMklGcYPO0fT7u5QuybXblDjmttRC4AGSOKnVAU3MGh
 k05H17jyBNcvQRg==
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
---
 drivers/net/netconsole.c | 87 ++++++++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 1a78704681184673f5c1ba8ae665e46751384293..6c67840e583a295e4f357bd19be0dd0ae3b76627 100644
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
@@ -129,7 +129,7 @@ struct netconsole_target {
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 	struct config_group	group;
 	struct config_group	userdata_group;
-	char userdata_complete[MAX_USERDATA_ENTRY_LENGTH * MAX_USERDATA_ITEMS];
+	char extradata_complete[MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS];
 	size_t			userdata_length;
 #endif
 	struct netconsole_target_stats stats;
@@ -689,7 +689,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 struct userdatum {
 	struct config_item item;
-	char value[MAX_USERDATA_VALUE_LENGTH];
+	char value[MAX_EXTRADATA_VALUE_LEN];
 };
 
 static struct userdatum *to_userdatum(struct config_item *item)
@@ -726,13 +726,13 @@ static void update_userdata(struct netconsole_target *nt)
 
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
 
@@ -740,19 +740,19 @@ static void update_userdata(struct netconsole_target *nt)
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
@@ -763,7 +763,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	struct userdata *ud;
 	ssize_t ret;
 
-	if (count > MAX_USERDATA_VALUE_LENGTH)
+	if (count > MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -812,13 +812,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
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
@@ -1119,11 +1119,11 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
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
@@ -1135,10 +1135,10 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
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
@@ -1155,24 +1155,25 @@ static void send_fragmented_body(struct netconsole_target *nt,
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
@@ -1200,36 +1201,36 @@ static void send_fragmented_body(struct netconsole_target *nt,
 
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
@@ -1286,17 +1287,17 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


