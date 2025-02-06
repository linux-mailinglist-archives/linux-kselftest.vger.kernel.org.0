Return-Path: <linux-kselftest+bounces-25908-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C97DAA2A6E6
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56D2E7A4088
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 11:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA23D22FAEA;
	Thu,  6 Feb 2025 11:06:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E866522F174;
	Thu,  6 Feb 2025 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839978; cv=none; b=Rp6QA8mbEcLVg1Dezo/MbFEXXG2IHkn/dbZp5BGtf5eCGmn3tdxNVeZ5hsAevLvcZrMY+2Qs1I8HbsQHoMF3MUDu+ETIW3RKxpEmXt4TSBwemAnSlt293imwRPgj4sjfW2lrzLxv4LIKszkn4wDaS+7LerV144cXQNm59O7Oi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839978; c=relaxed/simple;
	bh=olLcX7TZ87eKML1mxWhKNcr/zAKRgSsVekl7MomH2Qs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HTCbIU3S6H1WdOA7sR/5MNrYlUa3TBbrB8IhAJqW897/2Z9MZAuIpNkyL/dJf/eyaX9IV9iThuWzdMPb93otXnhYT2ItdFBY8BgagdesVbymoM1kB7UfQTtZs9Xo7e3pavci5E0z/zCppPRwN5FsVJzn1mjx9DYRmJZPUXP9V7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso143759466b.1;
        Thu, 06 Feb 2025 03:06:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839975; x=1739444775;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=922Jb88ShsF9zojgqCt8nRBp87kqrei03/FNLDK7/cg=;
        b=NsDWQQZ1jpDtDvVJ4fHn3RvRYuTit94vH1pPno9aegeEGjRnrCzFQ1EizojZa/aGyq
         Mq4OoS+W4MXfO2M45FbsFqbZR73TNQ+UPpdupelyMXc6pQZUrDQC2v8uabPQ4kGgLNvA
         BZXRPa9fZOWfBgvmwPdVE2ZtxLjhyDv1orCCEwT9Z5AGPPnqjeXIFZj2VpWAnXZpaWVv
         zSTJSmrkFl+Ktivgps+h3+y4oSeaBM/WfPdg7bOZkN2i0FgHOA9L5oICwN+T+6nqwWul
         lfegwa+xPcmkFQZjx7hbMbiSRVGT0Pl3PuncX0Jd8rOz0butrREttz4VhPqJ0yWtjT2w
         gN2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUiQ7V2m2SyUO0+jUOcWGfBlH5jyxbnC+9g/e37nAYnQjmI5TDVK/InL7NxLsQ1AI+c0EeMZU/MkiU=@vger.kernel.org, AJvYcCW5pmX2+UPQm3Iye3wAtr+soATvCuO3NfTt+1kxJp7c0yaUoVRW59KCtq8l7RfdB8HEHtW2sf4NNGejbgzYwuxv@vger.kernel.org, AJvYcCWFia55KpNSs6MmIW7DLWNRZzI867Li1xMVI3yUy1HqfNVcqw62wt8wUziY7nv1zzY49Bo+GMzBJ4SSbO6l@vger.kernel.org
X-Gm-Message-State: AOJu0YzjObA/zgog6mKkPcNSvbWK04+kSuJsyBHLTq0gOCawGn+qY1wu
	7+yKHlWQuGc8ln1oJhCrPdABE3r/3q06D5z8cITcb/eeSde8NcD+
X-Gm-Gg: ASbGncsRmVq5/0AP60Mv4TrUGJn4JVwIk3z6L676JY1w7YeYkhAXTqVt45V/B/C6oSa
	OXQqEUW7ZFnL9DKK2XiG+RzfE0LdB0suI1z5/lM4VgAA+wgRqqE+ku37CT1ooemlASaHr6CcRLA
	3f+DDbzvPdWBKF7GPksBQq6mhtn2LHCbLx1Q+cT6vcsANjwf0UDibOZaXXxsiiLAhW16rWQusO9
	gR7XCmFLf5sxP2wdXJYq41cAy8HFXLO/Z86pkkM+DDbT9pAJpmHSlwHTV95YKovg4rJlhuZ1JRi
	GziZLqk=
X-Google-Smtp-Source: AGHT+IGaOLyDWXs3isW8mPzjr6+u3htmzKnxq7KaPaQzcrNY8/tWhK/7aukZ9QcsmSza8UIalg0Pzg==
X-Received: by 2002:a17:907:3da7:b0:ab3:47cc:a7dc with SMTP id a640c23a62f3a-ab75e2467a4mr473420866b.22.1738839974855;
        Thu, 06 Feb 2025 03:06:14 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b739e2sm681568a12.14.2025.02.06.03.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 03:06:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 06 Feb 2025 03:05:57 -0800
Subject: [PATCH net-next v5 6/8] netconsole: add support for sysdata and
 CPU population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-netcon_cpu-v5-6-859b23cc3826@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4633; i=leitao@debian.org;
 h=from:subject:message-id; bh=olLcX7TZ87eKML1mxWhKNcr/zAKRgSsVekl7MomH2Qs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnpJeaoPh0XqVo6dmiv+D53ntcP9S/lWj6AsTNI
 NeyPQWL7iOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6SXmgAKCRA1o5Of/Hh3
 bVnuD/oDIPREbP6z4qEwICvlcekZXZksYvvamSH9siqOQzzyRe546G5o+ozC0d/ZO3JmMP2FfAW
 R35PjCvn/BANLupgJMkWx7BCy9qzhX4C/VauvxzcMnpNQIhVDuGz7vi3xGHWa4nti+LDLBu6Vef
 J3brK58mwkN7Esm2BuPBgpIPo8E55lith66if1MlqhAq+Orhu620cpOdxuKZOrq0RjJlIJMSNH0
 fekjQdDPx9AOlPaafG1P/KFIxwWVCZ2gBxbGynK8e7EPdVx+x1er3p1g0hq9ndwAal1JZpL1EHm
 8JuySEBZyVx9s+rfHTHjGhDvQHWJr1gjXKmNhHN4iCYkePtyBGVW/fPiK8fCEiiMfcyn0JHZNpC
 8f7U1KjnBQp5TwIZFsllHsOTCXrQj24nltv4Np5m1AS1bFYKVEPbwjHuLxx4Xj37rHyGHjfzanR
 t/nnLqvaOPPyt5+JDKBQTp42um6U1YGGzzYLdVzOnWy5jTfp2xheLgLsfydK8pmMouTakmMTLdV
 lThkkLJTqKVGfEqWZPdNxu8u1cJY/WIlzpdRNZM2pvaKSjRzpdBUOYkt+8BeAbqFjY6zYLlzrXg
 tXzBdQJyiNbdNqVOvYJ6i9rm+mx7HxQbeOLis11pJQi1/Wbu52JKxMZOatS9SlMK+Td55QoUTvA
 h7Scz99TKnVzyTQ==
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
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 53 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 50739c7dbfb6ad5b1a65ef33325cf4dd6ed02031..f77eddf221850fe2778cd479e49c91ad695aba3c 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1117,6 +1117,40 @@ static void populate_configfs_item(struct netconsole_target *nt,
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
@@ -1251,16 +1285,14 @@ static void append_release(char *buf)
 
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
@@ -1341,7 +1373,8 @@ static void send_fragmented_body(struct netconsole_target *nt,
 static void send_msg_fragmented(struct netconsole_target *nt,
 				const char *msg,
 				int msg_len,
-				int release_len)
+				int release_len,
+				int extradata_len)
 {
 	int header_len, msgbody_len;
 	const char *msgbody;
@@ -1369,7 +1402,8 @@ static void send_msg_fragmented(struct netconsole_target *nt,
 	/* for now on, the header will be persisted, and the msgbody
 	 * will be replaced
 	 */
-	send_fragmented_body(nt, msgbody, header_len, msgbody_len);
+	send_fragmented_body(nt, msgbody, header_len, msgbody_len,
+			     extradata_len);
 }
 
 /**
@@ -1385,12 +1419,10 @@ static void send_msg_fragmented(struct netconsole_target *nt,
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
@@ -1398,7 +1430,8 @@ static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
 	if (msg_len + release_len + extradata_len <= MAX_PRINT_CHUNK)
 		return send_msg_no_fragmentation(nt, msg, msg_len, release_len);
 
-	return send_msg_fragmented(nt, msg, msg_len, release_len);
+	return send_msg_fragmented(nt, msg, msg_len, release_len,
+				   extradata_len);
 }
 
 static void write_ext_msg(struct console *con, const char *msg,

-- 
2.43.5


