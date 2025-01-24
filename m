Return-Path: <linux-kselftest+bounces-25101-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E5A1B8B8
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAA016AD79
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F3415A86A;
	Fri, 24 Jan 2025 15:17:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C715855C;
	Fri, 24 Jan 2025 15:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731828; cv=none; b=ox+tjWctlgOsJhjdvAueO1NSsmqo4uARzRMIYGyUfemPBtu2GFLhXZmzqiUnxfA2ZW2vCBKw7doip1e4RDOvdDTudsC2OnSIdmzMEP1HyI1O4lTAj72e3+DR4AyITcSaes0elBz0y7Fa6URiwq+zGw7JTImU1JSu3/WiM3uDibA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731828; c=relaxed/simple;
	bh=ENMcuvIsrdXzGn7P4VLTgINjgrDPhJIrowbcEwJHEo0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U006X6+hEiUd4RQyWLIGIFbZ3J1q4q/wAJBnds3XHJkg0BSpDVtceX4FXiu9U43kabJVvCJChNNt4sci/R7BK+DYqOYSbuCytICuJkCASJsu8RZtovH6RRIxpd0e8lwK45x2TsBoomeB3BHPqQVooHIw53dT/XJW9EfrgdolDSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaef00ab172so370870366b.3;
        Fri, 24 Jan 2025 07:17:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731823; x=1738336623;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ol560JIslRN34pYLB85RMI+8P1oXDamnShUUezaavwE=;
        b=f8jiDJvd0FOtpiQ6105PAEU3OLnvD9bV6AfNFU78tjoycXogsF47P+dqJAcfNuepRa
         YfKhyOLNsCKdaZd6640yGSX2+rYPHXCj+3veWKTGVhNP1fvRdTA7KCSZ0GLCm+FWqzUY
         RdRu27KRWUyqn8MbAeOOyNpWnFAfqjqHjPsSgmCi2mLQLb3HORCI/IX++GekJ8t1k3ew
         Er1XwiF6egfVouXECXifoHbCZDLUUuYm/YCPS7mYnNnmPILn5i6lOyWuahtie53BrKyZ
         5KHz/lp+Qa2A1nDD0R6NueS25IwaSKS+B1IIbreqIxsGEj3Me9ze7V8CIX2ebUI34JQH
         yMkA==
X-Forwarded-Encrypted: i=1; AJvYcCUgheSh4oSUoB0VK4Shb2bJwwr72pH6zBEvpyoux0renNGPjwpf56+7x6wPnf0i7mmQUBE/4kJSd+0=@vger.kernel.org, AJvYcCUtEUue4ViM2rb4O8gyuLKbe0BRSFxR0NJAjj11XEVWFN4qNWSy9OhcNJCuTCnEyPp10zJ8dWj5PGbLQwwi@vger.kernel.org, AJvYcCVkyTBNuOLZDwl1scVgoymvtf50w1ISu8umKjzdceg30U9pv16/oMJQ1pglcZObr9ovASdw+yXO2lIIqGaBsZK0@vger.kernel.org
X-Gm-Message-State: AOJu0YxOmsCNrzt4YDfidCZTiSYOQfwFJQMv/v6SfVR2zkJTCBDJQKZl
	Td5HqPPH7/9oza1vkv0KYPog280xEx3o7BwsVWBCJwVruv/nhSWMMjhlzQ==
X-Gm-Gg: ASbGncuptW8SwlBENI5sHLcTHs/sBMWQobQ76BH2a4LdALOGeelf6UoMxBdcMf2MojI
	7aj1d2EKRPKAJ6ubhNhaCz8iQRygMVI94BLqDLo2a65/XxADgrY0k3uRWOuYDWKL+smosJycXkG
	Nrt1LQrwO4/7sqNpMZB04aHDj96memJmLRCJhRlE1DLZIia5LDgOQQ/7vuLIiibweyaOQrqxyvX
	ymjYJp8TIKogbzBHZ2tCE1TB9Jv/eIDyPmWS4HF7jYyu7xWKp1jgXBdU4I5VIytgfkdErMnN//N
	bMusSxo=
X-Google-Smtp-Source: AGHT+IFYcvq+4BZS/Q+jN4NHKzsrtIDVvOLEvozHFTBHU6IaarhtSUN51Fg/eibXdmI6KV5WjA6WSg==
X-Received: by 2002:a05:6402:84c:b0:5d0:d818:559d with SMTP id 4fb4d7f45d1cf-5db7d2f5e2amr76281354a12.11.1737731823233;
        Fri, 24 Jan 2025 07:17:03 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6760fbce4sm140758066b.127.2025.01.24.07.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:02 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:40 -0800
Subject: [PATCH RFC net-next v3 1/8] netconsole: consolidate send buffers
 into netconsole_target struct
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-1-12a0d286ba1d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4492; i=leitao@debian.org;
 h=from:subject:message-id; bh=ENMcuvIsrdXzGn7P4VLTgINjgrDPhJIrowbcEwJHEo0=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67qig4CR5eQggAxvsdzT1pNLm7U0rBSCynFB
 vH3i3F/armJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6gAKCRA1o5Of/Hh3
 bWd4D/9SoNAX/fMQrR7Xx3v+5bh+uYdApQWUvPnBHfLTvFzSP6DPCjToWM0hRHiLcTLUgYXSL56
 xJv9Dd8a/mdj+CPsT5H5Vgt2iMBqXuqA2On617sv9Sq6kljcGudw+ar2jC3zAsbBUvqqQqQgCZu
 S8KtdKsozMIrCcSC1o1nrnhjZpCVqnlHRg1Rcxe3WitwiYQPKyuUPBcdetj8gtT9y5zArT1wC05
 wB9gHCiCxcL1q8JGoYe2JUYsSrjsnc2ZqH6HeTrNMaAzYTSWICUwjyabg2qir++JXeTMANbCeew
 wLZQSTPdiHkYERmhgDajOxPCIGl4+PVIUY9/Rym4B3prhHMpypRjyqIlkJCgVbgCMe59mT71eRa
 jsaaQ5dTJ1ijiZsUSk6I9EGYRxk6Y9lUz8QHtWNlCE21UjfCWsntjwvtP7x74NsjnD2tJDaOVZi
 TtS/tXQrOb7LZKpZoLC6U4ethwJIzAxSVTcJ9pdI7D/iEPLmUxg4gVZPlp2YaqN1JH7+au7wyU8
 w8ySPAeZTZHUpLVZWZLF06RcHRtQ72ZUxr2S6pm1+JHbtsx3LQ7gwmDvmYVoupAeVFgS3TchzF/
 TyfjJtsoB0Aq0HWpaoImmf8y0gPVGUxWKBixroo5LQbwArsO+bWLlR75n4n8zA5VMeinGHpVQBY
 jJiZNt+pEbbiNhw==
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
---
 drivers/net/netconsole.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 86ab4a42769a49eebe5dd6f01dafafc6c86ec54f..1a78704681184673f5c1ba8ae665e46751384293 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -137,6 +137,8 @@ struct netconsole_target {
 	bool			extended;
 	bool			release;
 	struct netpoll		np;
+	/* protected by target_list_lock */
+	char			buf[MAX_PRINT_CHUNK];
 };
 
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
@@ -1117,7 +1119,6 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 				      int msg_len,
 				      int release_len)
 {
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	const char *userdata = NULL;
 	const char *release;
 
@@ -1128,18 +1129,18 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
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
@@ -1150,7 +1151,7 @@ static void append_release(char *buf)
 	scnprintf(buf, MAX_PRINT_CHUNK, "%s,", release);
 }
 
-static void send_fragmented_body(struct netconsole_target *nt, char *buf,
+static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
 				 int msgbody_len)
 {
@@ -1181,7 +1182,7 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 		int this_offset = 0;
 		int this_chunk = 0;
 
-		this_header += scnprintf(buf + this_header,
+		this_header += scnprintf(nt->buf + this_header,
 					 MAX_PRINT_CHUNK - this_header,
 					 ",ncfrag=%d/%d;", offset,
 					 body_len);
@@ -1192,7 +1193,8 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
 					 MAX_PRINT_CHUNK - this_header);
 			if (WARN_ON_ONCE(this_chunk <= 0))
 				return;
-			memcpy(buf + this_header, msgbody + offset, this_chunk);
+			memcpy(nt->buf + this_header, msgbody + offset,
+			       this_chunk);
 			this_offset += this_chunk;
 		}
 
@@ -1226,13 +1228,13 @@ static void send_fragmented_body(struct netconsole_target *nt, char *buf,
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
@@ -1242,7 +1244,6 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 				int msg_len,
 				int release_len)
 {
-	static char buf[MAX_PRINT_CHUNK]; /* protected by target_list_lock */
 	int header_len, msgbody_len;
 	const char *msgbody;
 
@@ -1260,16 +1261,16 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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


