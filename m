Return-Path: <linux-kselftest+bounces-24573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C604A124DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 14:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4DC37A309F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 13:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD8C824225A;
	Wed, 15 Jan 2025 13:35:39 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C172419F5;
	Wed, 15 Jan 2025 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948139; cv=none; b=f5/auFki2car/Gq7M/NG0bLBEOBCdsT/aGBZ3o5Jh4sZf3V3w57uB8m4jRD0H4x7i8feLRdO7yCnFfbFKWwGMgOWeuYNAlk9KX11X11WvKgAVpttM/0CezkpVyr33qWe0FOshUeHorMoj2kAfWG1r1kmuGgXxpT5luDJnXvryHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948139; c=relaxed/simple;
	bh=I44r0ohDanmuyGUNmsb93UKVYeAjH4Ix9dgCMmolnZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLxwsiefkgTAl6/Wbq+TbCjeUaNWcDG+8soPYSShk2k8g04i9xQTAupqaZrPpXmnApOFKIIDceBhBCUyfAgVCn7kfVtJSBrr736mrsxg3RaaX2mzVE7n2yw8e09tIGXCAGiPlhLmDqCIyt/fie5r/nL7RtixWSYZ8G7viQcBuWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so10247855a12.3;
        Wed, 15 Jan 2025 05:35:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736948136; x=1737552936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df2IhOg8gjz9sUPxNfKqvMxzOJiOqxvGrLLj83bUoYA=;
        b=hLv3AFBX8ZVqbIlicnKbuUKUZeudhardmH9m5JK2G48NS9ACqjzq9Jb44cGHAEFmGG
         lMWhS071vPWTEct9fN9N3JFXC/M3aAoKnbPyEPC1cuouEIycGbXfprh2baHDHhPi2Gfp
         c7iJvi60jxArCPHcFD61rYPk8Vqe5z+6deh+DLqerjdx585tPV2yRUOtpSfI78RAeZr+
         JU6lB+mea+EiH+LwBnkocrPaFOaKDtWqM1sH6ssfcoA84vBdlwna9Isk2Hr1u0RjwZA+
         T6aOGZfw4JojmKE3mbDdk5NX+b9QXhXvrwEUW7IpCjZveeCqH6KEAmhWjOieNYaTxW5x
         tVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+8mwTy9nxE4ZUmQg9EXXxLlNB5ItuAq1/BCQpeGC1ryzHliqi0zq80ZSeXzGNjDzpAMFWMcr9tWMyasARwq/2@vger.kernel.org, AJvYcCWQpgral8UBDvNghmQyEqxqG7xnfVQ/CHAZJAduu7PZHFpDiG1Zvm6AMXK4xZ0RmsQ0kAHlia68sNOGns8g@vger.kernel.org, AJvYcCWjjTogMtORp7XEQzuCGGHOaEpn7BNCk+XT0RMY97SOEWc6rKWOcKJs289TCZ1qke3+uZEXgJFKkhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmsKY1G1RAmy3PDCCHNIWy244HeYYTqoKoj6zuiqgEnTLJHs2
	k0p28SkcJ5AB5/hbG3Ivqxe7foF5+2wvQUD6aF/okVGQk42OumUK3LMfoA==
X-Gm-Gg: ASbGncs+DIrAZ7zGa6C+gVggdBoa6AwGr1YLkQcG+n2Or3ajrYxOPraIzRN015OvhQZ
	35ih5e71w4ezQWff/ydTh9Boj2BIvRvgIAcBVv/LUyK/d+TL1AabNmIaNSWLjGK7DSJYfaKClSz
	Rh3K1m1Y3sh7NR29oFduztGn+UCPGiYQVw0ZnGZuIJQU/7FX9+EJs2AnHkN9F5Q9Ku90hUOFZ8D
	aSLS8JZCAJnhJco5Eb8hiBwXTB0L27EKzgJLScIh/w8UEw=
X-Google-Smtp-Source: AGHT+IH+jzZB+6H7tb2ufIL0iv9VO3Ke5GHd3vthkaBLWfZZiuwGOj0yB6/tLGzksHnYgKgAypln0A==
X-Received: by 2002:a05:6402:51d0:b0:5d2:7346:3ecb with SMTP id 4fb4d7f45d1cf-5d972e08366mr27860822a12.12.1736948135564;
        Wed, 15 Jan 2025 05:35:35 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d99046d7e3sm7183701a12.60.2025.01.15.05.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 05:35:34 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 15 Jan 2025 05:35:18 -0800
Subject: [PATCH net-next v2 1/5] netconsole: Rename userdata to extradata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-netcon_cpu-v2-1-95971b44dc56@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10512; i=leitao@debian.org;
 h=from:subject:message-id; bh=I44r0ohDanmuyGUNmsb93UKVYeAjH4Ix9dgCMmolnZA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnh7mjB5DwkkBvfj6RL/Z/OSwlrlFr9WV/+JG6t
 PyDuzkSsnqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ4e5owAKCRA1o5Of/Hh3
 bYqND/472GKbeKPvYgOZBGTzDezqgW2rctj19Zm5Ii0h2NlBEszHZue1/TtDEjZ/2yPIZ7h1tO5
 6vz4NkmN3vXRjDaZH/69FLVuatnWnoUrfSlwUtwiMwTwom5+SMngoK5qVZKpUnYDyruE2NY33sL
 lMwDHqtft4fos5PHEIVetAJJO94pvvHPQVllUaTkJ4Mj5quHyxN4AUT0eHECX8rd+09mEoq1eSX
 wt577hGMVMoOfK6nldzjeghgsCx5Gpxlw8ElXNxWkcuDMOZiqRWVol2eMGVFdI8jwqm5yl/fuWd
 lYYtuA7KW4Jfbqb+bvKAZxJeJFVNqLBA1OQAXdSoyQB52J2ISopeIbVJC3Yc42PPq0wZUXw18r6
 XAI/6b0PQIZ+6GNa/qeDQ39qeHdE0oxI/dbbs4xOjFsMrjQdyrQRK4tfhdXd4DCyAvqhiktiQtk
 UxkjLmGXlPZVIx3FR9lKukmWmQgFAnT1ZcY0Yn1QetZQ2q3L9GHoQwph1eX2OFEaHpEbQw8DB2z
 7fLoD1coFKFdV2CJd6elbo7EQyAzoNvgxbAbg4RGVf5antS7sJgOumW63g1eAjM6ghYtczQYW8t
 YQfGZ9zS4hYld4wcSQPYugKgrVdOIoIhy2JumPdXNK81+GoxRZxR8vYU7VRZzS0lOv2wXaJBK/S
 xKFL8+2bDe7ELYg==
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
 drivers/net/netconsole.c | 84 ++++++++++++++++++++++++------------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..5ef069e8277efa87d6f00d08277dcfe97a858cf9 100644
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
@@ -687,7 +687,7 @@ static ssize_t remote_mac_store(struct config_item *item, const char *buf,
 
 struct userdatum {
 	struct config_item item;
-	char value[MAX_USERDATA_VALUE_LENGTH];
+	char value[MAX_EXTRADATA_VALUE_LEN];
 };
 
 static struct userdatum *to_userdatum(struct config_item *item)
@@ -724,13 +724,13 @@ static void update_userdata(struct netconsole_target *nt)
 
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
 
@@ -738,19 +738,19 @@ static void update_userdata(struct netconsole_target *nt)
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
@@ -761,7 +761,7 @@ static ssize_t userdatum_value_store(struct config_item *item, const char *buf,
 	struct userdata *ud;
 	ssize_t ret;
 
-	if (count > MAX_USERDATA_VALUE_LENGTH)
+	if (count > MAX_EXTRADATA_VALUE_LEN)
 		return -EMSGSIZE;
 
 	mutex_lock(&dynamic_netconsole_mutex);
@@ -810,13 +810,13 @@ static struct config_item *userdatum_make_item(struct config_group *group,
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
@@ -1118,11 +1118,11 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      int release_len)
 {
 	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
-	const char *userdata = NULL;
+	const char *extradata = NULL;
 	const char *release;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
-	userdata = nt->userdata_complete;
+	extradata = nt->extradata_complete;
 #endif
 
 	if (release_len) {
@@ -1134,10 +1134,10 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 		memcpy(buf, msg, msg_len);
 	}
 
-	if (userdata)
+	if (extradata)
 		msg_len += scnprintf(&buf[msg_len],
 				     MAX_PRINT_CHUNK - msg_len,
-				     "%s", userdata);
+				     "%s", extradata);
 
 	send_udp(nt, buf, msg_len);
 }
@@ -1154,24 +1154,24 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 				 const char *msgbody, int header_len,
 				 int msgbody_len)
 {
-	const char *userdata = NULL;
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
@@ -1198,36 +1198,36 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 
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
+			int sent_extradata = (offset + this_offset) - msgbody_len;
 			/* offset of bytes used in current buf */
 			int preceding_bytes = this_chunk + this_header;
 
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
 
 			memcpy(buf + this_header + this_offset,
-			       userdata + sent_userdata,
+			       extradata + sent_extradata,
 			       this_chunk);
 			this_offset += this_chunk;
 		}
@@ -1285,17 +1285,17 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


