Return-Path: <linux-kselftest+bounces-25667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D08A0A2706C
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 12:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E83188916F
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Feb 2025 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED02116F7;
	Tue,  4 Feb 2025 11:35:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F64720C46B;
	Tue,  4 Feb 2025 11:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668942; cv=none; b=HnWw1Wn0E5M8PSlp+V3DgQV47YzCTIZDt56vmdBcMgZHy4xBBo+b7jwNYhf7EY17cYnvUb41qlUzW3S5/fM1SwIfbvzjVklWjaoCJ8tPj/LvtJQeAgQd9YV4hB1mI3ObHeg7s57b5j9gAqn3BLu9ths5lKHBsYuxiYjCOfiDkxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668942; c=relaxed/simple;
	bh=xLQWYHSSQoD+EjBCSRRVdC+nRYUe+DB4GVrm5CY1At8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iKqGntA+Luopx/T4py3i+Ux69hDWHvJP9UVh8RoBGPFVlK6ZXAFoTB3t8iyDfuPEkN0TVukhngle+cpTmuYO1SPhz+c5GPIVryFWagZGgK+fRM551OoIuv9GXo8um0qDinnz8of/SRWohYEeeqM9T+701v8z6tJceQAUD+zh0Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aafc9d75f8bso1090565566b.2;
        Tue, 04 Feb 2025 03:35:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738668938; x=1739273738;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxdWjnTSMeOLZHgJdp79TxTqQugOh3yw+hsn4aWgrG4=;
        b=kPrjDzdrIiHv+xApbFsOKngnRTlIq5a5pmuAalfwlmJfatH4/dIBJnVAumOg9219zA
         FJoBD6BIROtdj5eB3DapotVqc9GTuJDBoU3wUZfLZ0hddgwLsUo5VawQQ0eiOHpjNkdA
         yZhrqUfnzTGKe7pwaSVydLpOGK0kgve9R4jmddVVelmlXxHQbbDgVs7QGRgSgIcLlIZt
         I6kpP71zVnIVc5v/+4LRJqzxXhpUkSou1rJJ+WPDn9VSpOf8wBf37WMErsOduRKgG2E7
         n1KFTfGDdPn6rvK90AF3untSgnbtB93b9v9sVEc0MH/h/ViPw9OUUFcfJx7FPayMpXri
         MEUg==
X-Forwarded-Encrypted: i=1; AJvYcCUPmiYtkRt4iooub/G3LCFSPKE/IJaHw+TWDB1HMB5xYWV5kJDRN14NS6fAQv6S4waJw35d9AO1iMB/1AOR@vger.kernel.org, AJvYcCXUlGmh+E2y3xtghZyYveIahu94DWPDN1x/DOR0yvITWWtA1mLUtVyXbcjs5YOroso+PJQVy3WgfbtGzs+XugBd@vger.kernel.org, AJvYcCXX52tzjq+NqSXqgPLHC/I7idY5j64QJ3FiPXlxYZx2mDTYeMYpJj7zatyEPc7uxcS/513RlnDsv0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vn3H3T4++JUZkCjgT7sRFTi6qRyvW+JhBb/AxeGMwntv2ZRn
	dPN7LOmUKhQmYG5ElSvHLkqqIWO5u26K/QY5hJ6uPiKClwEiSQwAM80Zbw==
X-Gm-Gg: ASbGncvYLRKaD2Vg0LFs+dNgyrsjOf5omM4a2Npt0xKAo+GkR/dTJVDFJ+ZLM3fm/wj
	cv/I6PylR1BKIZTayl+4Rw+cbWTXSJkw3Qr9NIZyivZcBt32GSNsdM85sWngCvmEOejfd5Cv6GU
	UbFoBBwqA67z2AYzBbP79ls7fq82vVCzffK1gRJlSpEX0xrsCrQRoE8xN/OHLgZZWrexPJpzUgL
	LSXyZ+e+jqtAZrocDpXRfHq2lHjehp0+awKX1T9hw6O2+YTXGJGqQS5rBhaDP0WErRuoRWFbrhK
	z1o=
X-Google-Smtp-Source: AGHT+IH9XRj50A4yWWHjc9zgZ3i8fYAw76Vwpz5S4/Yiwv9+q2T7qWWA4CbrVzAiX6iDqFPtq0TRvg==
X-Received: by 2002:a17:907:86a0:b0:ab7:4262:6851 with SMTP id a640c23a62f3a-ab74262699bmr573070566b.30.1738668938062;
        Tue, 04 Feb 2025 03:35:38 -0800 (PST)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47d0f1csm909998066b.70.2025.02.04.03.35.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 03:35:37 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 04 Feb 2025 03:35:14 -0800
Subject: [PATCH net-next v4 6/8] netconsole: add support for sysdata and
 CPU population
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250204-netcon_cpu-v4-6-9480266ef556@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4633; i=leitao@debian.org;
 h=from:subject:message-id; bh=xLQWYHSSQoD+EjBCSRRVdC+nRYUe+DB4GVrm5CY1At8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnoft+2jxbBFJnKCp+efq0T2kogcM9K60SW6ptV
 eq0EEmMhdeJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6H7fgAKCRA1o5Of/Hh3
 bZzmEACXzOz+AkTzIHdTLnqfn1+JeoKy6NlA9DuCUWnO688eiq4NDBV+QLdKuavUeewACVHhrO7
 EStLAa1L9gCn3MzvUpBhoHpvhq2yAnjXoT9lHH6hrrFxkhUDFuX0Qy4qZdptmZ3Q00ky0CXsmJA
 ITWfiRuVguNqWZTq6+91IX0BUr2j+0INb6ry4t/Yj91hYITvoJgZuYjpJHGqrM9IKof9oayaPCI
 BNYFArL8BbIFv9s3JWlyuC/LMX5GOGK+9/g8fnIoEB8R2WSu6iXQHHmyHbIVazx+URLKsM5AoZq
 QuoYTznxxIsl/MQiubF98CIB113UXpnnQy6/rN/W88b3q9NXkIQN2h4WeEETsHdXwmztcWoEUzl
 aYpoj5AFn6FZW8jphj1CJ4UPmm/4MAO58272/MDf5i+n+vkWZaAuKLt2qHrKZrgR0hABKtcKioI
 jTlqiZ97OqzjSsUYSarktRwUdtP0TtnsvNG3sffZwIk6k7zjX6D9xDttCgXbv7lBPNQHUEUcNvA
 tLfJTMh8zuwhJbjF3EpHlFBFDGc1zfs43zN/LP3a8antpK95DjhEwpFMS6EDbaEBeGhc95+SsSl
 Z1ZkPfyDJta9QrLy1nbeQmsGMzdH1sHHxDcSfw9or1OMVH46fvF4o+d84VfqN+FFP2fbXPxpb+e
 cr2l8L38ZQ6QMGA==
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
index 4255f547bdecfbdaf02ccfb28360ba6fc8b58bed..07298caa0a12b7f63e1cf9eee418a3f6a696a021 100644
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


