Return-Path: <linux-kselftest+bounces-25106-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD949A1B8D1
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 16:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C916A16EB92
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Jan 2025 15:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD061CF5EA;
	Fri, 24 Jan 2025 15:17:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE131C54B1;
	Fri, 24 Jan 2025 15:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737731836; cv=none; b=cOAf2wzfiHUR/PZpylJ3+7TL1vvv8M3IgaswzdAstcHS80/CP3CjbI/JKUr6uYU5qyW3xlU72UlSXFIb2lns3YMM2XgcmD56YQ8YIJguCjFo2767HRptlVvM4k8Pfs/ym3s/ze4vlFu1W7v/ngr4d3TOKcB8KWVdRk6yWWMJEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737731836; c=relaxed/simple;
	bh=k3Texaptxd22qXRsu+lfUttY8c8569tjrYrumyuXOQQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LRAAcskZWpRQ6E/vXsp6AzJqZQCNoZDIGy6Wbxu/oPhN9QLdHEAzYL6iXCnG55iAmDLCY4IYeGmO8P+/hMyCYWOjX9WJJUmHePHT5VHc6M/j2UjsAnVAR8xSne9KfRH77i32BEunFaBuNBUpbvpYUkGjui5al2qRpGqJRcMx+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a88ba968aso2172480f8f.3;
        Fri, 24 Jan 2025 07:17:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737731833; x=1738336633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLbfgzlUkX2+ckF9tJQz6U58wXcO4TEKMtUAALJyc1s=;
        b=TDKwDyxuf7ezXq5QJTWiaP35JQ9Zf/ybWWMNJhFTH6+04Vh2vJVfDtJmKsTKPgM3iS
         L6FNMnl7L+2vgMNAioywUR6UmxF3Ot4p8jHDjxCH4NfOADvhyVeUM/36jfFDh5YHsGhZ
         FjRmnVKUOGJ8UDeXHuZ2SKx7RccApBpNeyItWVug9gvvjmW2ILBglPCrP4xgw7/1OiBi
         TDDanzq8tA6I5ao1CjyOkADzI73hsxe0jam0xsoLytb4OzAfcPbYyldwhNx0eNaCKMf4
         gc0ll5+UFaAOGtgamf7kitgvGd+FV5eKzx48/Dah0AXvzfgRlQHKfqJLJJuqVR9kNquI
         aCnA==
X-Forwarded-Encrypted: i=1; AJvYcCWDAQ6JyOB9pDH7FU51QmFlOq4crnIoR+MEBFIkBAIOZn/gyWVAiCZhWqwNlaG6x8E8jNR2T2MnUgRE5eTx@vger.kernel.org, AJvYcCWSzJnwtGT9IcXtr1C2iRDrgpBpGECYx8NvQ9VjfoX8xPimcjfGDgcNBjJobjJJ+qzWybX6DAdTw6o=@vger.kernel.org, AJvYcCXp5YwTPOcFpwucDjNGIetMYSbf5BlouH1yw3/VdnGH6RhnsPlf8QcP7U+3MS+nJJz9GuXVEG3yA7pqEMOsU6rY@vger.kernel.org
X-Gm-Message-State: AOJu0YxmOBE0ja0y9WyrZKuR7W/E/L48ycjtLHHvC2ORBVl2/LRCwcAv
	SUN7BNyLOn3SIAHed6tp5PNM2+8FGwr/a4v8rbIslqAB1l2PpnMzPgo+Zg==
X-Gm-Gg: ASbGnct+3MZUKv6RlsApP6g2Ibo4oi7rcoDZypIk9I9UdxJgN0fe1sAlR337W+mGgwM
	7GQZ2+WdyU/HQEP15kTNmZtIBD1f8hsAvFzg5hvYzhXiMWSW/mapeXL0TIDU4oftbMV2skOck2g
	lqhVl8kgS89QYby3UuawV6WpW8IlZMtiEAqKRkcgZVfoRFZZnVnnh44mkyg7ESnz0OQLAk97TaZ
	b66laJbTXvdtUkJJ4Ai66FZTdEYGPzzdjeUsFwDOtPLCuDuQAvfpKPuzbPUHFFmT1LMVfo=
X-Google-Smtp-Source: AGHT+IHQeHLYO/ldVpqwDP81gBGqP3wI9099dRFqEk0Tt6sgnCe4046i/kqKcqXf01nR74DXkisUTQ==
X-Received: by 2002:a05:6000:1acc:b0:382:4ab4:b3e5 with SMTP id ffacd0b85a97d-38bf55bbddemr29154234f8f.0.1737731832649;
        Fri, 24 Jan 2025 07:17:12 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab682f55facsm21014166b.63.2025.01.24.07.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2025 07:17:11 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 24 Jan 2025 07:16:45 -0800
Subject: [PATCH RFC net-next v3 6/8] netconsole: add support for sysdata
 and CPU population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250124-netcon_cpu-v3-6-12a0d286ba1d@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4587; i=leitao@debian.org;
 h=from:subject:message-id; bh=k3Texaptxd22qXRsu+lfUttY8c8569tjrYrumyuXOQQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnk67rRmy+WsXHjKvs4jNjI4xrad3pzdyWXhl2I
 4in48AGdLmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ5Ou6wAKCRA1o5Of/Hh3
 bX7KEACFJW2po0YvttLAEY3ZeIgm6BcUjCjS/QYL4bcWCveTbPIDgLMZC9TnSKptJPF56oFSr0+
 BwGm4OIScH0j7QBThdzQjC/5FbCaI4IGEVqb6eRITrKMbSjCuyaUf2el2BAvDWq7NBLfxnTiiK5
 FZuwoiTwkrivC0tCnNsQBkNLfgBXmNvOocQHRrPbQ6kUDgf5lmdvIbnhiqCMrkpd05PDFjHNPkU
 GwdoiahHK98veeRZg8yOgMUrGzJy++pXEZw3spkW4nOZUd/Rz6/T9E6Hhhc8f0NfRMNjpJuFkLT
 59J8rPB53z3Xh6Y4j7qnxi64rXlR0Bux65yGF8KoHhWW1+c4UkmTlHaZrZlsQNf5PJlX4tAOEc/
 ZaExxu/zPBAm0IoAZ++5lCCDniFOIkmmtdLLAFImOOtBUAMU3MXecFXjnLAzGOJIzhqcqoYJAV8
 3DWRJaLuK4JrHntekgmvw9Pz+bWTnQGeC5HwG7ZehS7GVhl+LCDZpRSt8eTzo2MdmfkilsuGJOM
 U+JLt/mh4YbaGLJrwKgIEYOgs9FcdM0APVL6D5zq97pDLnE6BC0jgRebS01yHBGd15PqWWemxHa
 EjQRNKuuVwRV4hWLIQaU3E5Wxb8Kv1SW5Pn81eSXLxxosneaybVgUYAXj4FTO/5/J59n0/OyLRc
 p/g1W4odKabeBYw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add infrastructure to automatically append kernel-generated data (sysdata)
to netconsole messages. As the first use case, implement CPU number
population, which adds the CPU that sent the message.

This change introduces three distinct data types:
- extradata: The complete set of appended data (sysdata + userdata)
- userdata: User-provided key-value pairs from userspace
- sysdata: Kernel-populated data (e.g. cpu=XX)

The implementation adds a new configfs attribute 'cpu_nr' to control CPU
number population per target. When enabled, each message is tagged with
its originating CPU. The sysdata is dynamically updated at message time
and appended after any existing userdata.

The CPU number is formatted as "cpu=XX" and is added to the extradata
buffer, respecting the existing size limits.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 53 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2f1aecdf2a47f246e75061d09b9ca524a82ec994..d3df66de9a352678bff011024922c63ef6f1b0ef 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1116,6 +1116,40 @@ static void populate_configfs_item(struct netconsole_target *nt,
 	init_target_config_group(nt, target_name);
 }
 
+/*
+ * prepare_extradata - append sysdata at extradata_complete in runtime
+ * @nt: target to send message to
+ */
+static int prepare_extradata(struct netconsole_target *nt)
+{
+	int sysdata_len, extradata_len;
+
+	/* userdata was appended when configfs write helper was called
+	 * by update_userdata().
+	 */
+	extradata_len = nt->userdata_length;
+
+	if (!(nt->sysdata_fields & CPU_NR))
+		goto out;
+
+	/* Append cpu=%d at extradata_complete after userdata str */
+	sysdata_len = scnprintf(&nt->extradata_complete[nt->userdata_length],
+				MAX_EXTRADATA_ENTRY_LEN, " cpu=%u\n",
+				raw_smp_processor_id());
+
+	extradata_len += sysdata_len;
+
+	WARN_ON_ONCE(extradata_len >
+		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);
+
+out:
+	return extradata_len;
+}
+#else /* CONFIG_NETCONSOLE_DYNAMIC not set */
+static int prepare_extradata(struct netconsole_target *nt)
+{
+	return 0;
+}
 #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
 
 /* Handle network interface device notifications */
@@ -1250,16 +1284,14 @@ static void append_release(char *buf)
 
 static void send_fragmented_body(struct netconsole_target *nt,
 				 const char *msgbody, int header_len,
-				 int msgbody_len)
+				 int msgbody_len, int extradata_len)
 {
 	int sent_extradata, preceding_bytes;
 	const char *extradata = NULL;
 	int body_len, offset = 0;
-	int extradata_len = 0;
 
 #ifdef CONFIG_NETCONSOLE_DYNAMIC
 	extradata = nt->extradata_complete;
-	extradata_len = nt->userdata_length;
 #endif
 
 	/* body_len represents the number of bytes that will be sent. This is
@@ -1340,7 +1372,8 @@ static void send_fragmented_body(struct netconsole_target *nt,
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				int msg_len,
-				int release_len)
+				int release_len,
+				int extradata_len)
 {
 	int header_len, msgbody_len;
 	const char *msgbody;
@@ -1368,7 +1401,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	/* for now on, the header will be persisted, and the msgbody
 	 * will be replaced
 	 */
-	send_fragmented_body(nt, msgbody, header_len, msgbody_len);
+	send_fragmented_body(nt, msgbody, header_len, msgbody_len,
+			     extradata_len);
 }
 
 /**
@@ -1384,12 +1418,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 			     int msg_len)
 {
-	int extradata_len = 0;
 	int release_len = 0;
+	int extradata_len;
 
-#ifdef CONFIG_NETCONSOLE_DYNAMIC
-	extradata_len = nt->userdata_length;
-#endif
+	extradata_len = prepare_extradata(nt);
 
 	if (nt->release)
 		release_len = strlen(init_utsname()->release) + 1;
@@ -1397,7 +1429,8 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	if (msg_len + release_len + extradata_len <= MAX_PRINT_CHUNK)
 		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
-	return send_msg_fragmented(nt, msg, msg_len, release_len);
+	return send_msg_fragmented(nt, msg, msg_len, release_len,
+				   extradata_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,

-- 
2.43.5


