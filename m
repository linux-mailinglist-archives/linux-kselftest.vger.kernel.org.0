Return-Path: <linux-kselftest+bounces-25903-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1C0A2A6CF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E6D7A20F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E854A22CBC8;
	Thu,  6 Feb 2025 11:06:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046A22689C;
	Thu,  6 Feb 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839969; cv=none; b=Q+T7PW+lUlEsfBUYW9Wn46BNnErgLlb9kTwxoSX7LzMJQjm7lZQEqaNmiFZcCL2cjeqj814Ktjwgx07Ogfpo4K2zSn/vGzyvxKSPWy/ks5/5/cTuaD4b/vqQoHyIzrzRDPBmdvlDIjj57dtoRWQwvGzrRAeuoDGvoXK7PBgZyiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839969; c=relaxed/simple;
	bh=lTnjo5M9mcX1w/bC55hH7D4u1Aef58AcXKWP+fHpObA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOqluIEWuTJHNZb2a8/XCi+lDFgOjn77fh1TMcFVN1h9nh0SmHsBP/vAYKYCgIBh+ssmHx3zMrzjbSpNLJQoq2Y/0arE+tRpc7p2O5B9lmKetCUIjjyZl5Bi7ph45kuJIQayvQSQMCBFRoPRFlitTHfeFWb6/RsicZW02eV6Lws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so159360266b.3;
        Thu, 06 Feb 2025 03:06:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839966; x=1739444766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REdEcbQPl65CW/hCmXFtnxh/44oJYC9fdWTnOSTALpY=;
        b=YujFAx22HE/lalpzqFUl0ySTxWypWJ60pTD4gyqIiKM4BbtPK3dBgzLhwsC0BkitZz
         d9kUlDPWc27aTGPkQ1jPVzx6RPCoPlfYQtxDrLF2N87/5Y/4MoPWyq6ZzZ5JYru2q2uM
         MTGmLlVCt/lwp7k7wE8ClW4VLeYn09Y4Ldb0z5oRoFbuI4nZ0u9un3CXkFJ1sOROUf8Q
         5khb4HRPf3QAEnX0gJlVxsvSfPNU7Gk8DJSvOVmHtV3OKum7qWfFblLhXdjEc7ACHlB6
         ZM7oTriZ5B01GaV5WJyKm3aHlmqjj1jOb8DMzHLwjhOHzdobvWVs7e9yoJdNi323g8mY
         dvfg==
X-Forwarded-Encrypted: i=1; AJvYcCUi3WRDNfmAOaFJkXPM41ex2Ym5Snsbhq2q8N5jG53Q6Qk8ILjNSpULjrcWbGLGoZr9Il1u4ahKKqqofrCWbUsc@vger.kernel.org, AJvYcCV3sdAfo07EmnA3siKsinm3Pi/HroFd3Ry6O+1DIGbjPU59mePbmvq75mBQNs3qFeXZkZ7rdP0o9/ioiFPY@vger.kernel.org, AJvYcCVjprekuI+HCTbBjyLrpaamVLTXD/VVv+2BHVrlVodevySJc+oXiUKbjHkZmF+wDjELDzvD/KZJWlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2cTGNL9KKP2OO8WkwZ0Nxy8Z/uwHSqjDzFo3hJoDTbxr8JFGH
	WpvKWgbNmh+FZAPveFDrnuuI/ROGV55FKwZOho0Kw8M+GNNoDqQx
X-Gm-Gg: ASbGncvoln5yBUskCsc/cRtX6hoaUi5Hd+B9ZP3YQFfUorNBSQP0u9pqSnMA/B3VSbm
	TRPpn5AhM3Pgj7AFbmkRtLQ6OIatu3cIRUPuH/uj0c50GXfK6vRyMTuya7uqVaYjaeCZKn5qjaH
	VFzJ9/Wx3aqxVfXp4mqiuuoOftw8xVkE+CRcY/cYtOPphcUA/g+ox0M2LhM4odGwpU4MCB8DYRH
	IZA/poOwdS6GlTdNassdjioEaLCYDlEM2BN6dBYQWsssdvlD2jBDVKuX6fXVrsTgzexdujGA4om
	f7f40Bo=
X-Google-Smtp-Source: AGHT+IEFzu5552xmMut4eBQ8kM3b60OXc28m+jdCkEYJPO9PAppMuzlTkh2nqwHMk+eoNVzhpAoigw==
X-Received: by 2002:a17:907:6ea3:b0:aae:fb7c:50df with SMTP id a640c23a62f3a-ab75e34596bmr695893466b.36.1738839966138;
        Thu, 06 Feb 2025 03:06:06 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7736468e7sm82392066b.172.2025.02.06.03.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:05 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:52 -0800
Subject: [PATCH net-next v5 1/8] netconsole: consolidate send buffers into
 netconsole_target struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-1-859b23cc3826@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4811; i=leitao@debian.org;
 h=from:subject:message-id; bh=lTnjo5M9mcX1w/bC55hH7D4u1Aef58AcXKWP+fHpObA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJeaSHEqxfpJAHBDX/XAsm+QM37Keoj68KRD6
 efCzMD0xJGJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bQaHD/9Mik8uaIvAZXqH3Lzr9pYTkgMo9nePIxRDKYKLYt8QCieeE6Ql1BBeOCB51SUsbNXjwS7
 fvoMcUa73HfqYe1xbBavt0oG+hAyc4IXb08NRheg5/1h2uI+N75YN2sNWlBp2GumkjGkof4RLKx
 L5yAEyYfxrnF4+Pj895icG9jrZxgWmOgzC9onZbMbSoAYzCwdkue25v4Vo/hhCRuS16LvjP8vtf
 j3UdAUq5+zLiiX+BYBRFOTgKV9PSLzLbq2H0aL7U1CMW8vMJTfWR810rKjs6nEgGrOJ/Yo/O6Tz
 OJUofUqU+G2Lim2q5NXJsuCdjdPScaEUCyt2zqdan/sprHNe0tPIg5tYMUqMxxRLP3NG9Res22S
 30puhnoDAi1GkJfpA4+vEd7e4zBqfBnlKaOkXRafUAXTUJNp6GMSCxZED3J4wD+r87aRsKgtjkc
 Yu9yygv4fK7FEhlRsrKX1rT2Gfd+gmnY144QOQszuOJFEfO3cSysgPXHAxl5P62xXjcNVhBI8UP
 /7ME1a1lNCOoPER6W196JqTgoC5hvG4FfVreUfYd3zjIJTzhDiLi5cVF+98CeBYyXprsFImL7L7
 jCjilz1kKoMAPdy40qD8grfm+SWB4LeAG11Jwb4J9BSvS6Djn62zrGZFCOoWNnYe+N28uSd4HrD
 21dqHSK2o/XWBfA==
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
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..034caaa26563504357f859000678af2037003c25 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -123,6 +123,7 @@ struct netconsole_target_stats  {
  *		remote_ip	(read-write)
  *		local_mac	(read-only)
  *		remote_mac	(read-write)
+ * @buf:	The buffer used to send the full msg to the network stack
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


