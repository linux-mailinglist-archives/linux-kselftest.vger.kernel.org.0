Return-Path: <linux-kselftest+bounces-34842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6719AD7BCC
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 22:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C1F1897FE0
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A042E336D;
	Thu, 12 Jun 2025 20:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMwlhDGW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE702E2F1B;
	Thu, 12 Jun 2025 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749758605; cv=none; b=su12do5IIc5e2DWTnX0C00qqW2vFPfSdB1mxaU07uApWkvIP9qVaNrNekUnjaBTdH0tY5sK8O0xCebHE/mPQRYmbG5TQTGUaM0blKBBty4rgXQwXh5iAbBl33IBxycYOqvjhVlgAMkgoOltqKKfirBKU+wHKTwpg8GdImXsJShQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749758605; c=relaxed/simple;
	bh=nhD7nQP1armvamJAdav9d2T+px7RNCdUFLeEb9HZweo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lZNQDkyw9QZwIkhchDYuG6nms7W+a+hieqZ5Ef7Qbim3WG9mgDE983q4UGaZTfjCNNRGN+olINscVUA/YM7qBwRNLIEU877XKXCdlaB25/s1UWJjv90SS39QzqJCIsuxiMqRCE9coLjPZHPJ5PZ0dUasOdZdlf1bEg45aU6/Sco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMwlhDGW; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fb0ac80aaaso409946d6.3;
        Thu, 12 Jun 2025 13:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749758602; x=1750363402; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ss/uhQhN6lUEhvR/FJ2esBhszQQF0E4wT4q6/teIq64=;
        b=cMwlhDGW//LYV29l/hO/0NhoWb1BjmsBQzLdmLyr2K9+gI3Z4F2v3iAYfqFOMKWSHZ
         KFctZUFz+4Fnc1Yh5LQcdjo2oMSB9hB8TasfJ/+R5OAB5Wx6dX0eFvF97uXX+SO1c6n1
         ogTSTO/LC5KWo7D6UDA+n94+j1CGYW2U75/5mKC5mROqdMsWxzU38QHOEA59L/Ws8wTj
         J+9sW/+KLw/Y9pXhFQSQEqUUom2znq5l/0DSL5m0jatvxLN2hLL0LTldVvxN9/Th0cNn
         SOwc5WMuScDCeX16HOzgRTKk36htkEpzBFmz5Y3mO7lkt3rB6kpHUXiZ2yR3md2NqBsS
         cAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749758602; x=1750363402;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ss/uhQhN6lUEhvR/FJ2esBhszQQF0E4wT4q6/teIq64=;
        b=uH1sSgdWXWu7vai6Hx8FRTJ9JuyNLPZYJemP09PcgwHXP/0UUZr+g3A0WgyjS4IHX7
         qDC6m0nq2ZOzqnxtf5O5kW6STvRi6in0uCNLwnrhNhEzqT2hPIIxA9TJGRbFGpec2mS9
         m82+dkWaf460T/kj0N8gCP2VNc3pTbo/LOw+seBqMzI8bdVa3QLf5bUewxG+7P/ka3Kh
         7aD4g+LpWujc65/k/HGYMzA5dmAQyWfcQ/dnWo683xpIae251eGnxHhJKSy+hE4qAC+a
         qecf5bvV9AFbKdM63TSJiQeDCKk/v984wSkA2h5u745K4BjN+pLQIgkAPoXC0XXsBpSw
         6TQA==
X-Forwarded-Encrypted: i=1; AJvYcCUQtIwBroEqnkpN91qQcSkFCxFLm5aVwVV8z513obOuwfGclbk8MdZzVM6qpBUloUXCST1Xv0+cUv18H65a@vger.kernel.org, AJvYcCWUPYMYsGY6LWWp18QBoDOHgmEPp4RBlUbdGXGhZsDgBbe36mQZbc3S5RyCqogqKg122X8ZmaNRmtcbhHXc2dY3@vger.kernel.org, AJvYcCWnFQ2STlBi0HbF6Po+mdmRYjHuKjZ+FOOsymvYM9sHRonbslRnyxXpjj12joxP8xYbJv7nVjqYEGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3xUQOnm/QPOky7o81I6LBwmgrEBc9gcvoBf3vZMSMfXNoSYxO
	Ex+AxbyOKBAJ2gvV2kzYUkdvupCFw29dzpoFUO+626i78BVFGpHxmrgixjr0OzcecCQ=
X-Gm-Gg: ASbGncsKiC5qn6Vwb4sHgoN8OHAFoqlLNWxkPVxCK5gX3EMO8FQwHW2T6fOYKZKI1+K
	9LfmmRepd6E5kWdPc41foLEW3td39TosaW1gsGgy2Efj3sjbuV/GvF4hOIZPh5EEd81P5XmUV5K
	bMWtmKGZo02HLqJpZ0pdAzlO5ulFjkXyjVewdEK4HGaPdeQR6PqtFYk9pV8vALKOisZXoJnIwwJ
	f0UuPBPDabEu1eDziBouNrapYjzwQOVjwKaxorwn+fjMOfAP6UYU67Pl4lu0+C7NPdllETdhE5H
	GD3wg0sFsTOoT2D7WkZLbfTRMRln04R9pyAWYrQ/+D58dXDR7qBE+EY=
X-Google-Smtp-Source: AGHT+IH9GjdEeMuR/Q5I7mjdit9VX01tOQlZz5H6NKrZw+S6Pvq9hyczKt6X5IFUSwrczAifaz1J0A==
X-Received: by 2002:a05:6214:2462:b0:6fa:c22c:f10c with SMTP id 6a1803df08f44-6fb3e665ea8mr837136d6.7.1749758602131;
        Thu, 12 Jun 2025 13:03:22 -0700 (PDT)
Received: from localhost ([2a03:2880:20ff:5::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb35b20f5csm13824086d6.21.2025.06.12.13.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 13:03:21 -0700 (PDT)
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 12 Jun 2025 13:02:16 -0700
Subject: [PATCH net-next v2 3/5] netconsole: append msgid to sysdata
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250612-netconsole-msgid-v2-3-d4c1abc84bac@gmail.com>
References: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
In-Reply-To: <20250612-netconsole-msgid-v2-0-d4c1abc84bac@gmail.com>
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
 drivers/net/netconsole.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3bf8777fcd01..baa9862c1bc3 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -155,6 +155,8 @@ struct netconsole_target {
 	size_t			userdata_length;
 	/* bit-wise with sysdata_feature bits */
 	u32			sysdata_fields;
+	/* protected by target_list_lock */
+	u32			msgcounter;
 #endif
 	struct netconsole_target_stats stats;
 	bool			enabled;
@@ -1345,6 +1347,14 @@ static int sysdata_append_release(struct netconsole_target *nt, int offset)
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
@@ -1367,6 +1377,8 @@ static int prepare_extradata(struct netconsole_target *nt)
 		extradata_len += sysdata_append_taskname(nt, extradata_len);
 	if (nt->sysdata_fields & SYSDATA_RELEASE)
 		extradata_len += sysdata_append_release(nt, extradata_len);
+	if (nt->sysdata_fields & SYSDATA_MSGID)
+		extradata_len += sysdata_append_msgid(nt, extradata_len);
 
 	WARN_ON_ONCE(extradata_len >
 		     MAX_EXTRADATA_ENTRY_LEN * MAX_EXTRADATA_ITEMS);

-- 
2.47.1


