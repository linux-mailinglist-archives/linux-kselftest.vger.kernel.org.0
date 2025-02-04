Return-Path: <linux-kselftest+bounces-25662-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3614A27055
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7805F18868E9
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A6E20C496;
	Tue,  4 Feb 2025 11:35:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633F202C39;
	Tue,  4 Feb 2025 11:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668934; cv=none; b=jDKv6w0QTCkvXF5zTfgeMSVpnSKzD/BylmvNzddKMiHRESEgtPr7pw/3gRSd9OAAr/iJEnkqiwaOkxSAr7ZjsX6tiAHRHpXr2MN/dcUgbGiQ+NrQ4YXn4ACzVP5P41wgXba61v/vK1sWMI1+nYW4qcOMq98GLOIw73zOGOlqYBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668934; c=relaxed/simple;
	bh=HUz4qbhG1xocbRDA0LuqGzXg2iC7UrsL31cULRzZ+ms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sidyJindlGMSPoqFFzl/JlVGLTlnRX/PBQyqDS3BkeHyPwsLFoylftynkhgdZ6TPvGlKNuYVN8OMU+y5+WlsB1+sYw50raDz6b2dVU1V/nYIY+lr2hT/q5eVMbO5iG+XXmQn46q0T/6Zn85K2EhCDFJTXEViJpsil+7TY7kyFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccc90a4f1so699779a12.2;
        Tue, 04 Feb 2025 03:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668930; x=1739273730;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRyFXvBfkvZSawDf3OnbAefq+WNb8zfIFJyUMwy5ouo=;
        b=CbFtwl9D+d9ENh92D0R/7kM9w5kp3hv9WeLG0lxSzYz7OzMmQX5GtlEvtIgcl7/5lp
         VV/q/D9pgRW6fks8o0HPg/ghHumjzlkC0eVul0VdBSNxgzNupHNG9C5a9OtVd29WcH6U
         Ge6xTdndgu4R0vErLy6WgAvRUndiUKcSfNaCgmbB/yQzOgJYBGSP7RVp604NCAbCDFFd
         NBY2CzsE05SNCs3eY3n5E2KvWN4vby5K8V21QHQLBbhsYLLPhERhAkPRT92b27vZQUAd
         wkESvhzeXANk35nUxuip2ZgvRzyQy9MB9Ptn360o242Axq3DgGOKHRMFF+YxSuhAUkQy
         WAXA==
X-Forwarded-Encrypted: i=1; AJvYcCUn2X3Lt/ba2Z30szBeT6zdG2qLsrX1nPYPZs7McqQP/QgecBnaz3duggF3zBYrl+8pUOPc2fxyXLc=@vger.kernel.org, AJvYcCWaSDHayTKcHEWbRyn4SjPa4mdIeG1Iat7hSXiPqGa3pffuPVaON36NQTNYiWdIXmBi54bOWiHbUOzu8q7duMe1@vger.kernel.org, AJvYcCXZE7o0Vg46NWWjuy28sc5SqrfK9YMODarVIfQ7yXNCbhui6+j53mELR1nM0VjTc6ToXD0MYKdw5AKZ/lTP@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxp5MnItIxs06rRiGIHRjoWX3XFhrXiGGxjehy3RjGsD5h+da6
	V0AmCgo6OtItMbXahJQ4kcDPaCTwhSfQ4w3067pchh+/K+NTJI8lPhYFDg==
X-Gm-Gg: ASbGncvDrkr+ubt4k0KCOh6iCFQTVMAecdtlygXrD/Jjeh296+PPZfFIIQPx2XDJJrF
	bP1DJR7vsybg5QyDlz+FkgwgMScDc/FAFBcuP/VdLT5Wj4HVBSxHjj9VtwS5u7PSDAEznNE0vxa
	kLtQQfiTIYBen7h2h3ReWzntNsF+9X6cYX2ivKoV/KVcCK3PkzTbYdqK4a9hW0NnS7bXz7ohFbE
	BQx6audhuYvic6SOW6DRsdDV+qLXw8BJ5z8NoamTRH/RfSv4J8Y6MQQytDKfM9MzNciuM6Bm9Z/
	LgLORg==
X-Google-Smtp-Source: AGHT+IEXZc+B+4scL804n7B5G3JYdJzlqnzlB1FiPy0G03GBltXaClsQfdHhrJ5lSAv9veWJemSPRw==
X-Received: by 2002:a05:6402:51d4:b0:5dc:cf9b:b043 with SMTP id 4fb4d7f45d1cf-5dccf9bb32cmr885910a12.11.1738668930042;
        Tue, 04 Feb 2025 03:35:30 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724056casm9445854a12.43.2025.02.04.03.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:29 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:09 -0800
Subject: [PATCH net-next v4 1/8] netconsole: consolidate send buffers into
 netconsole_target struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-1-9480266ef556@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4811; i=leitao@debian.org;
 h=from:subject:message-id; bh=HUz4qbhG1xocbRDA0LuqGzXg2iC7UrsL31cULRzZ+ms=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+ZJMVLABta5NuZHzKL6S9uxASM+F7H4+1D
 PeC54p1aqKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bf1LEACUN1qkm0gAgx8GO7gdBvDpcNcrBMGA8bxHXw+GfFDIj9SBIfdVLpyLWHWd3GCFHrBg21q
 5PkERB1EkpGi1VVbx5eDoT5BZE+nj1N9NqTwKumAt8DqJ1Nc2c50S4ofQmc0WNwyuaGukLXRemf
 Df2H3/yMWAYb6iGf5p6J09xcaJuLKqyr7mRDgXiKPnxBBIpR+n05WyQtShkK9YxGqLw1zK1ZBFQ
 7KWSKlw9jlid1tDY/15/0rbzKPWjah22zfY8iBGykKyT8yr8zbNKMqNsEk/mkXFiTuSa+AXSjxR
 fXT7pBFUwEJyiEAvJyQaWHHMg15yYHfj1e4AfoXJzN8GCm/QMkfFsq/jDCiw5NGpHxNRlu/XkWl
 wTYwrpRp/uc+m09r987XqlVxKIi9N2awXzODc8VnCu/ht10CPFVdt6R6sZTbr5ZYkGTyKxHbgLh
 DlSIBy+b55uY2XFz4ZPLtp0s4foc5ehhROe8STNu9xOEyIEIL8xtj9VzSXXIKTCDRlxcZ4SheJX
 vwBMUVT7wcarZMym2NzFhSLic11nMA8RlegIyVwNAuUfMB/tkKbpRDlCOsOnF6ObXr6RHKjfz2L
 w6flnBokzg0LlC2X0Kr4fQAgJC6Hi9msi3YbDFM9zq5l2dLAEu9QArHpTo4pKZkOKdtg4dCATnI
 4fXdNezEbv+8ovA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move the static buffers from send_msg_no_fragmentation() and
send_msg_fragmented() into the netconsole_target structure. This
simplifies the code by:
- Eliminating redundant static buffers
- Centralizing buffer management in the target structure
- Reducing memory usage by 1KB (one buffer instead of two)

The buffer in netconsole_target is protected by target_list_lock,
maintaining the same synchronization semantics as the original code.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..c1ad54d99438dbd14e8288d39ad6bcc6f8ff5ad1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -123,6 +123,7 @@ struct netconsole_target_stats  {
  *		remote_ip	(read-write)
  *		local_mac	(read-only)
  *		remote_mac	(read-write)
+ * @buf		The buffer used to send the full msg to the network stack
  */
 struct netconsole_target {
 	struct list_head	list;
@@ -137,6 +138,8 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
+	/* protected by target_list_lock */
+	char			buf[MAX_PRINT_CHUNK];
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -1117,7 +1120,6 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      int msg_len,
 				      int release_len)
 {
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	const char *userdata = NULL;
 	const char *release;
 
@@ -1128,18 +1130,18 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	if (release_len) {
 		release = init_utsname()->release;
 
-		scnprintf(buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+		scnprintf(nt->buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
 		msg_len += release_len;
 	} else {
-		memcpy(buf, msg, msg_len);
+		memcpy(nt->buf, msg, msg_len);
 	}
 
 	if (userdata)
-		msg_len += scnprintf(&buf[msg_len],
+		msg_len += scnprintf(&nt->buf[msg_len],
 				     MAX_PRINT_CHUNK - msg_len,
 				     "%s", userdata);
 
-	send_udp(nt, buf, msg_len);
+	send_udp(nt, nt->buf, msg_len);
 }
 
 static void append_release(char *buf)
@@ -1150,7 +1152,7 @@ static void append_release(char *buf)
 	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
 }
 
-static void send_fragmented_body(struct netconsole_target *nt, char *buf,
+static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
 				 int msgbody_len)
 {
@@ -1181,7 +1183,7 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 		int this_offset = 0;
 		int this_chunk = 0;
 
-		this_header += scnprintf(buf + this_header,
+		this_header += scnprintf(nt->buf + this_header,
 					 MAX_PRINT_CHUNK - this_header,
 					 ",ncfrag=%d/%d;", offset,
 					 body_len);
@@ -1192,7 +1194,8 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 					 MAX_PRINT_CHUNK - this_header);
 			if (WARN_ON_ONCE(this_chunk <= 0))
 				return;
-			memcpy(buf + this_header, msgbody + offset, this_chunk);
+			memcpy(nt->buf + this_header, msgbody + offset,
+			       this_chunk);
 			this_offset += this_chunk;
 		}
 
@@ -1226,13 +1229,13 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 				 */
 				return;
 
-			memcpy(buf + this_header + this_offset,
+			memcpy(nt->buf + this_header + this_offset,
 			       userdata + sent_userdata,
 			       this_chunk);
 			this_offset += this_chunk;
 		}
 
-		send_udp(nt, buf, this_header + this_offset);
+		send_udp(nt, nt->buf, this_header + this_offset);
 		offset += this_offset;
 	}
 }
@@ -1242,7 +1245,6 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 				int msg_len,
 				int release_len)
 {
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int header_len, msgbody_len;
 	const char *msgbody;
 
@@ -1260,16 +1262,16 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	 * "ncfrag=<byte-offset>/<total-bytes>"
 	 */
 	if (release_len)
-		append_release(buf);
+		append_release(nt->buf);
 
 	/* Copy the header into the buffer */
-	memcpy(buf + release_len, msg, header_len);
+	memcpy(nt->buf + release_len, msg, header_len);
 	header_len += release_len;
 
 	/* for now on, the header will be persisted, and the msgbody
 	 * will be replaced
 	 */
-	send_fragmented_body(nt, buf, msgbody, header_len, msgbody_len);
+	send_fragmented_body(nt, msgbody, header_len, msgbody_len);
 }
 
 /**

-- 
2.43.5


