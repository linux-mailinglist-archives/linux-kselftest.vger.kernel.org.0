Return-Path: <linux-kselftest+bounces-25904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BFAA2A6D4
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:07:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF913A9122
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1010122DF82;
	Thu,  6 Feb 2025 11:06:12 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C567C2288D0;
	Thu,  6 Feb 2025 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839972; cv=none; b=UiiUDH7uDYN7aWamuUmjHlvuOUr20yGVenrlqun4aYQeQIPxYRxvPqIcX0fHVeWKRdMEpryhJJ2vE2CHtUI2TcEM0HEhq5+ERYRCzZvQaDUXLXD3v5jxEPdKYEbOTZzVIR2O1+2dM0BDCtt9xsPZvVH6sPPPz8rUchvntulbCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839972; c=relaxed/simple;
	bh=s3o30XJqTZd4IAwBHkjaql//dyYsAJ8dD3R0opkOV9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pkt7DcIAXQMNR+KwaXGvZrXxos+XSa7o7DEWm9YDyp8yoEu9pwdqLphJDfkcxP+o/NJ5XHq07dRQgZEplr6mXgPC/twu0vVG2bUtpv6FFALVarIqYG42lczYPd4JlaD8NeYUqIoVpScQoO8JWh2Ui6pEKIrtCG9/ENf5ldnfNBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ab698eae2d9so144303366b.0;
        Thu, 06 Feb 2025 03:06:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839968; x=1739444768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T+iQNYrKRhquwRZ3wZW9DgvaA0aTVYyApstD6smfbSM=;
        b=RkPjpcgeoXviRvdvSDrHhvgHWifVz8KcslxiOyiDqJyMdNIGgMv9mEoCzEk+xCginp
         7GS9IblgTtPwysKU9sgMq30hO7q6Np+cIJCOi74jAnY/bgkJnUL8CJaFVYFEcwNuCCST
         Uk024/tRgrthTnBCj7NlsQzvpNvl0if7/4EkEy90jeJwWEMMP8oxbE7Gzz00kiV+OCEk
         VYXg66PZ3ChtIq7A+w3GASV87yC7QgmgisAeAcmCJ8vwVmZNIKZ6jHd9/vUg782LIHSU
         hJkN8psI2EOXeTtztikTiXpZeJqH3Hhug1xoY3hxj2JFu5223row2osiqlTTFGRjDk8V
         aE0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVUxk/52YvTb1dVIG3/3neYMkvrPObs5MePSMSSoeqAsFYYqhhc9gCn+7Bg6TSpe+g+zDUjea1rxvOjpYOH0SO@vger.kernel.org, AJvYcCUypR8epUsEKPi2/g6mI5/d419z1A8Lyc2Goiipl15rhiuRVLLaGo5O3JgUMPgtjRd+urryvLtBvh0=@vger.kernel.org, AJvYcCXgWKVCen8TOh6igzu4r3spUT6BqsBL+6pPlFiTtdAHD/ARDy3RbnQvxSd2gtA6gs+OnlVvIV90+QariGxn@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb/iBw0cFBvSkCpPwur5YOniMVK2ImYAVUIKMWmAm461DrLkK8
	r4dtFgz1/k4R/r9ts6ywe/kFMIiDcdxji+7MAt87RwrXX5Hz8M2F
X-Gm-Gg: ASbGncvZ+8cN/NtvO9GACl+kXnPnlyZutJ2O1GatbkNYuY/ShWRn9iOD6MxQgzkL/c8
	c64EXjl/gzfSmrx5lJTkcFaNdgCHyvMD9+sH1zejt+QR3YhrTP4Gy0XgsFBb9JR8SHtJKaTwSCV
	WYYkcKudntIgKYQtX8ua5ea158sf/TBjFy+qijgkRS7ns3xBebgkx1w3e6yIVkERfznZTGitkkP
	hVGMx2d1TbIYlW8AKkhObHHY6i57AyiXy4nGG0tUAms/66H2zoiVOyhmJLR+iExp/BN3FFHbcsf
	tV4=
X-Google-Smtp-Source: AGHT+IE9aB4a488ge8KLh4aVgnhJ7it4TMKbMKIugIlJdalRqklBgO5JsMPaimLa0p2Noga12ny/Aw==
X-Received: by 2002:a17:906:794c:b0:ab6:d575:3c53 with SMTP id a640c23a62f3a-ab75e213fd5mr731889066b.11.1738839967857;
        Thu, 06 Feb 2025 03:06:07 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f89277sm83693066b.58.2025.02.06.03.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:07 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:53 -0800
Subject: [PATCH net-next v5 2/8] netconsole: Rename userdata to extradata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-2-859b23cc3826@debian.org>
References: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
In-Reply-To: <20250206-netcon_cpu-v5-0-859b23cc3826@debian.org>
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
 h=from:subject:message-id; bh=s3o30XJqTZd4IAwBHkjaql//dyYsAJ8dD3R0opkOV9Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJeaNuMPkgEGAsdqOpTbpT6MA9JWbcqbt1tbU
 xHA/cR5fSmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bWdxD/9WZVt4n+ch1NDHNPDLgGZTEyu9pEE8SyRBomlHtysv5xsVzWz/Vttlf6CHTlvRKqbon4u
 f0w59NIxAZU/uh6ez5V+6J2Nf3AQ0QOGioUKseRoG4wBrhZIuFgK+bNkPGj8WlS7X2A/iCvPTGj
 DaMhBm5pex7a/wfZNiYjf1JvdWVlQESa7BmrXCZKkUaQ1lcp9oGI4A5hlXkmP2g5azEUYM3cz5E
 m2LM2tbw0R4CLoODI9mr8w24FG8uVHfYEG1fBh7Hr6DNv7ozgRtgu6vNRqTSPOZXAOqqUrvpXXf
 eWn0wjg0WjXeKdpAKLjEjJyIbXtdW3cFL2VAQVkS3JfNm4bh1FJc6XTNgdnIHi76jrfbwoN744w
 RUGPpavSVY4+mt646VNIjqHCOVRvXACFRs0yujHZxT5T6xHtWOgvQI4F/DeoLPn/heugHdUqghv
 mBvCocNaDqWvQDNMJXstI84UKUjuCHLcM2qE7UKSXcjsi2KpNhkUIvxozg/9CJb58ns9OCdifEw
 RPQlWQ4Cd4DwHHVe5sA6/QoXrKnOy86Z2bUcLJ3a3Wnlf6usOkzjvPQ2ud8f0yMMP2dxXu/I+z2
 3NsVeHMWw0FXhv2RBQ1pBL60RJ8S3hJcuaZS8Y0iMV2bsk2CCcusvbmvFa4SixwNFBaQoEicmdP
 48KLSn+q1sSo4xQ==
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
index 034caaa26563504357f859000678af2037003c25..7f05c7f74c31ce26a7329c784bd99305b7bea0e8 100644
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


