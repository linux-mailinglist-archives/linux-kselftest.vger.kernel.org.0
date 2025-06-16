Return-Path: <linux-kselftest+bounces-35119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F91CADB79D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 19:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBDA188AB76
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 17:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB3F28936E;
	Mon, 16 Jun 2025 17:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8GBPTyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14150289354;
	Mon, 16 Jun 2025 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750093809; cv=none; b=hgl9vbL1f0sQ+teGSM0ujkfYAGt+uisFmfVD7fW73hrf6/o4YJTJ1WSylEF7vTHOz6wXcOXvF9IOMS3a318vICjzUacmy3bV4lcWQF33dBDsCWV2NhsbyNcqkCzKYEbfSgJjaSAjNqCdV25O3TkVN0dX/264dnypqQtKeWN+PGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750093809; c=relaxed/simple;
	bh=S6AXtgIwA3BqRvGaPsTmibE2Xba6Qe6qpSVC2eiIBzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pISSWv8V4jZydPwscdnH2FO9pdtJsFw6erPjmGLr/lqMgacewNbf/k0lm4Hqpxe6oXBsuprDKoti33UxOBnuIUND/HXLQFoGUI7FqojqfnHtIld3YkKTcFNKSjADvk5FTU7YGPHGrGiQNEjr3eH9l1t9ZfXVzo79Cg4UAWngMp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8GBPTyj; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7d3cc001a7eso53735885a.0;
        Mon, 16 Jun 2025 10:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750093807; x=1750698607; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK6qPYTh5w41oMuI/YiRnU1CKfEtWIdx5+AUrw0/O94=;
        b=U8GBPTyjSwyd6PRHRF1Z9yy66PNk/a6h8+Sjhaj80o1BWICESjzEXH4JTk+3MaNMCe
         dyx6mEdZrcFM4ekYGSbKmPLLusUpLdWHe51QC+tX7nfArqg17HsDbvtJPW2vPSpEFk10
         dfHsaSttdnDplbVYyBXYtV5g8G6GbFqhZf/fObapjvF3jn5lVi7IBMW8RWoPVKGCKSVo
         /CUvhCPCqj0+n0xew8FMaYA6+Qh+qRyP9yEZrTPKWIb8nrPbQkkKbIeufOGBO8sroAJE
         ucQy8J2fCBZb7squOe9c81Qz9vsB24o/Tqp1oNZwasoRuN0ksCaGP/DdENblq8XKZHpW
         q/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750093807; x=1750698607;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK6qPYTh5w41oMuI/YiRnU1CKfEtWIdx5+AUrw0/O94=;
        b=szyIXTs7u0oXNzL4M5EeyLCprJuIElZzMxTN474C9wH/UhBwfjjnHlVG9Gj549HsWE
         8LMJ3iklKhNhQ+BVoh4FOPHD9+6GpFM7tpZqE1PvuoC8iLcrxvQMJbeXyIPDVao9rNvE
         /5ZEWh67a9lFgZz+FkSWTZBI7Qs8eGX5Mb5nqSKDlUhp6oK6g8gU78qSX7v9ci+aMRKD
         0Va0SuhTB0aFf79AHmPlvdWaJQ2KsmZOROJyS6PE5FpMdV7pxeDHej8KXnGd1mEPAcb6
         UXqqZ0tjWPzwbM0knHg0TXvYb52aqQZ33aEUizsrD8i7PyYMDqp5lGyuNs8BZsQBClZm
         ZSVg==
X-Forwarded-Encrypted: i=1; AJvYcCVLPlpQuvTzkjpaKabkm0G2fY0rXthyyyrxzvOkWCEs9Ts8/9AkgBeF7PH37DxAkZ2B8iV1WfvxTJvYaW6t@vger.kernel.org, AJvYcCVu8fEt8S/8bSliXI60TxY+1/hc7FNK67kQQJ+Vc+55AXdAPi3Tp9x3B8sZEXBn/UHuHw0yA1K8mz0IIM1gcHb3@vger.kernel.org, AJvYcCWgoc6cGgiPdQbNjc0MxxLWuPaXiJFus41D4/IgJBvSvtdZwdTgtHPPWIvfuacSj+t1DGUzNKV9jUs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjae8cNTuLSHXN9TeUzBzoP16n54EPXKu7/nwMecf/2+0Yt9Ab
	UYOwfAU2YbWUvvybPG8/IDIAwVbcYEuKJm5DFDJHQCxvzvheYRE6IMj2
X-Gm-Gg: ASbGnctehd3xagGAIL7Noby9N4YtcKBX/sGKHaFssT6nqeMJkzDSnDA3wTKeQEWor0X
	I+N/CYqJcncOvzID+62Juyoe2Ni4VvfP9RJqNr7GjZ86j2NbhrbbUjB+UieanJgFjuYP5RK/57N
	sqtUUxnC5RBrp9NAchgwyfJ+N9avDc49z8qzGA+VN0Z5YW6O2X3Xd9vcWfAOpTs/4ak6sm6hA5R
	VhF4G6i5SonmEJ7CYioUIGbW9Pz2A8YkRuJldNDbJ0mu1iJ/6oJkGEn/03FIXeH8kCKvEmGaJs6
	ZhLoImm7lmQlAZRAr3pGKB93VNI4IV+w8wDFa/bNO+A1WRPEppVIzrgH
X-Google-Smtp-Source: AGHT+IFdvzba05VheCDBJxUYXSpce2kylnndfioVA1LiAxyk+2wU0m36bLaex981TUpgGBW0SxgIYA==
X-Received: by 2002:a05:620a:318f:b0:7c0:c42a:707d with SMTP id af79cd13be357-7d3c6cfbbd8mr571017385a.15.1750093806814;
        Mon, 16 Jun 2025 10:10:06 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:70::])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eacccfsm549503285a.66.2025.06.16.10.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:10:06 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Mon, 16 Jun 2025 10:08:37 -0700
Subject: [PATCH net-next v3 3/5] netconsole: append msgid to sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250616-netconsole-msgid-v3-3-4d2610577571@gmail.com>
References: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
In-Reply-To: <20250616-netconsole-msgid-v3-0-4d2610577571@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 Gustavo Luiz Duarte <gustavold@gmail.com>
X-Mailer: b4 0.13.0

Add msgcounter to the netconsole_target struct to generate message IDs.
If the msgid_enabled attribute is true, increment msgcounter and append
msgid=<msgcounter> to sysdata buffer before sending the message.

Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
---
 drivers/net/netconsole.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3bf8777fcd01..ee2bc82f81f2 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -125,6 +125,7 @@ enum sysdata_feature {
  * @extradata_complete:	Cached, formatted string of append
  * @userdata_length:	String length of usedata in extradata_complete.
  * @sysdata_fields:	Sysdata features enabled.
+ * @msgcounter:	Message sent counter.
  * @stats:	Packet send stats for the target. Used for debugging.
  * @enabled:	On / off knob to enable / disable target.
  *		Visible from userspace (read-write).
@@ -155,6 +156,8 @@ struct netconsole_target {
 	size_t			userdata_length;
 	/* bit-wise with sysdata_feature bits */
 	u32			sysdata_fields;
+	/* protected by target_list_lock */
+	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
 	bool			enabled;
@@ -1345,6 +1348,14 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
 			 init_utsname()->release);
 }
 
+static int sysdata_append_msgid(struct netconsole_target *nt, int offset)
+{
+	wrapping_assign_add(nt->msgcounter, 1);
+	return scnprintf(&nt->extradata_complete[offset],
+			 MAX_EXTRADATA_ENTRY_LEN, " msgid=%u\n",
+			 nt->msgcounter);
+}
+
 /*
  * prepare_extradata - append sysdata at extradata_complete in runtime
  * @nt: target to send message to
@@ -1367,6 +1378,8 @@ static int prepare_extradata(struct netconsole_target *nt)
 		extradata_len += sysdata_append_taskname(nt, extradata_len);
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		extradata_len += sysdata_append_release(nt, extradata_len);
+	if (nt->sysdata_fields & SYSDATA_MSGID)
+		extradata_len += sysdata_append_msgid(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.47.1


