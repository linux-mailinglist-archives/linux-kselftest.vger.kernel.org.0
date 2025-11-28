Return-Path: <linux-kselftest+bounces-46692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D26C6C92498
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04F83A94F1
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Nov 2025 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713E3259C92;
	Fri, 28 Nov 2025 14:21:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACA2727EA
	for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764339662; cv=none; b=W/V/tkkJ0YtInKr4xFa9oQ99KI0oBJlhJt4aYZUQAyQmqU/BmdRznahkP54+z/6O2RykbDLWIgCHRiPKqgM6pQimpgBeo8s443YeVKMFABnlP2S4PJE2t1rfll7MQYZ/QejYJgS07eUbl/71WhborApH4xY3V+XKnjKqdVF+xeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764339662; c=relaxed/simple;
	bh=dn83itIlZUWLQ+U+eA+BuY6G1TrO1GUvpGmFX9B58mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkWJAAGCGzYz4assZNWs4Hm1+N3v6XpSo7RQZBR+c52g672At5KFEL+lZOsg389iguQWcccDcTw4U698Z/TN8ZUlikDgkPvn8I0oABaorAK6YCdWMocVcsRSNNsB6u7nsDFr8pN0Bn6VAtBLyRahz2hbkZa9Fw02zoqYJgVnqx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-45033024e45so746619b6e.0
        for <linux-kselftest@vger.kernel.org>; Fri, 28 Nov 2025 06:20:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764339659; x=1764944459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xVc8Vi5dk8JoHKkvwNwpd9Rz/OBPsAa4UA1kUPWE0N4=;
        b=bttM/Rr5W8iy4csb4Y605KMaXO7BieFzj/RSA7pUkYCLfa8V85QC/cgXqsUFnj8VJC
         +ir9xvUvn4aZmHJJ+sSTQRsfTgeqBfjCgGCMKKTHuMfp9Q9/e5IA4H69j5iUbqvcQiYA
         Vg0UKVsW5jvk7/M+XyrZ7xbRvML6h5WgH28B6mkXD1ah3wRaf3wHetwvukzwMbxRraDu
         kWPBCVvOs9XHiRbq+h8U/EIJLCjcm8rB/8YjPtSTEufljed22rphZ3UDY6ftljpAP7Qc
         V1118461jzlv0hEne1XDQwXWTn3369TU+39MLv2c1lLoNFD8xsszGwH6uPWjruVTSTHH
         pYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPZ3dzq0IGhx86F6nRNUjFxTaNv/qgbaz6VXDOxuh8VjMBVVDxfwf9HkZhQcNFDwUYQvVc1TXxt1vBs7KQRbI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBsiD88zwSbdo5xDOMFFpLkc049lrWhyc27l+U+me1mTmIXqVs
	co7uNmAIXkjy1p58j6u1UJZA7s8zJCzgfGo6Jjrv5NOVGCEt2iHBsixz
X-Gm-Gg: ASbGncvoN0QKYfxnQyJWzQBxzx3jeFOlB4yZnIeNoaPkv2oFN7vF1v8g0fQv4A1cUa4
	CpjEmP/b/T4SXCiZcy+/SHUybwgy4o7i4D8csaOrblOjOHyEY22duRuk4c7jB6z25WOLwQ88CiN
	pw8p5tEs72qLT9o3pvzlBeg+5G4TpJR3bbGo1vM3fMNvzEINUJPStxmeiFIY4hJ5IdBRSn81hkO
	ZDhhB4KUJzYoiG+c/G+H9HXaHTeq63JB4RKtbkFq+cJ2D2+O3hvqkcauKg9dtZ5565jG4MWPmYP
	L3bY9oOR+hNzkum3g75Zgys/sqPutVQ5OE2aehGmFHhNfswUYhMxiQdsx56aNPavbBp9SaEsfFK
	lJA0aVNAHkGQiMln21ALFmkFPN1w6JI3mVhrL3o8P8ux/Fetr4F3e4mxpOsqUKxHfmOy9nkvVhG
	XmcT7rmlbVd47K6w==
X-Google-Smtp-Source: AGHT+IFwD7RpsIfEFgpcmxfYEZy5hKSIijVY3yZmFrgV5YRT+F+kpxQb8bm0YGtDkXzW4eF+67kIXw==
X-Received: by 2002:a05:6808:894c:b0:450:3ff9:f501 with SMTP id 5614622812f47-4511290fd1dmr13040281b6e.7.1764339658257;
        Fri, 28 Nov 2025 06:20:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-659332e1480sm950537eaf.7.2025.11.28.06.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 06:20:57 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 28 Nov 2025 06:20:47 -0800
Subject: [PATCH net-next 2/4] netconsole: Add configfs attribute for direct
 message sending
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251128-netconsole_send_msg-v1-2-8cca4bbce9bc@debian.org>
References: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
In-Reply-To: <20251128-netconsole_send_msg-v1-0-8cca4bbce9bc@debian.org>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 gustavold@gmail.com, asantostc@gmail.com, calvin@wbinvd.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2745; i=leitao@debian.org;
 h=from:subject:message-id; bh=dn83itIlZUWLQ+U+eA+BuY6G1TrO1GUvpGmFX9B58mE=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpKa/FqDVOsFZ8329Lx8kfljFJl1ghgku9drY0/
 AXGcDnSjzWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaSmvxQAKCRA1o5Of/Hh3
 bRTFD/0Tu3SmDZIjSP/ODQfN9yDeyLXcHnrAF9W8o4lc9Z5qBaMIegPzgfCChdgS4l0zwd2IwHD
 LD3CsR5N+YvzA30Thp+Zu8F7Q2Re3L+6ai1dieyBHutSl/V9LfSLR7WU8GVswYP+d5iETinR3jC
 hhhzf4d98d/0kd6pExSOKwsFlT19wEIH3T2Bad7IWqrnZALyLVQwzfkVEcJW7W0dmiClW+VdYid
 rVdeqld6a7zkqCrdHf6DZsZ/y7YUzgJsNi09EeqT3k+HABD/KQXvRsPKIJK1zSOwsrhhpKwOaFG
 JiDNBwUkmb7wCwPV+GkwkFCyb6jwMMR8qaL85HSE2QuazfTw1rrAFRI9V5kvGjCuvf1zrVcjrOd
 QlIYi8A1zHyl6Zk5dleTIzrdzHLogwj301mKRxgEFMtEBq6BzUBo1GNkIsFW1dAvYmZ8G9vF7+s
 Kdv99GHXtSx3FpdDJi11tcBG9ZVc30lFu9qQJ85JVCPeFteXYbMf9H9zQt/4ern0fmEB2OKDVBb
 JTnjaEZ6LnW6nm06keF2OWv1BTxSoUBIFG0Rss0jMdlOG+8QEsylTV2MqHocI2X3ABuqB0zKF89
 UGyX96WZIHo4WpkIORZgwXMdsOTTXup0GSNZIsuMpsWpS5GsUkk9ejOhT+cc7l/GSWTwAlSL4Z+
 PD3Ybkt+pdrnXMg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add a new write-only configfs attribute "send_msg" to netconsole targets
that allows sending arbitrary messages directly through netconsole.

This feature enables users to send custom messages through netconsole
without having to go through the kernel logging infrastructure. Messages
can be sent by simply writing to:
/sys/kernel/config/netconsole/<target>/send_msg

The implementation:
- Checks if the target is enabled before sending
- Verifies the network interface is running
- Handles both basic and extended message formats
- Fragments large messages when needed for basic targets
- Reuses existing send_msg_udp() and send_ext_msg_udp() functions

Unfortunately this patch has two forward declaration, which is not
ideal, but, moving send_msg_udp() functions earlier would cause too many
changes, and this could be done in an idependent patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index dc3bd7c9b049..245ed2584bbb 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1194,6 +1194,39 @@ static const struct config_item_type userdata_type = {
 	.ct_owner	= THIS_MODULE,
 };
 
+/* Forward declarations */
+static void send_ext_msg_udp(struct netconsole_target *nt, const char *msg,
+			     int msg_len);
+static void send_msg_udp(struct netconsole_target *nt, const char *msg,
+			 unsigned int len);
+
+static ssize_t send_msg_store(struct config_item *item, const char *buf,
+			      size_t count)
+{
+	struct netconsole_target *nt = to_target(item);
+	ssize_t ret = -EINVAL;
+	unsigned long flags;
+
+	mutex_lock(&dynamic_netconsole_mutex);
+	if (!nt->enabled)
+		goto out;
+
+	if (!netif_running(nt->np.dev))
+		goto out;
+
+	spin_lock_irqsave(&target_list_lock, flags);
+	if (nt->extended)
+		send_ext_msg_udp(nt, buf, count);
+	else
+		send_msg_udp(nt, buf, count);
+	spin_unlock_irqrestore(&target_list_lock, flags);
+
+	ret = count;
+out:
+	mutex_unlock(&dynamic_netconsole_mutex);
+
+	return ret;
+}
 CONFIGFS_ATTR(, enabled);
 CONFIGFS_ATTR(, extended);
 CONFIGFS_ATTR(, dev_name);
@@ -1205,6 +1238,7 @@ CONFIGFS_ATTR_RO(, local_mac);
 CONFIGFS_ATTR(, remote_mac);
 CONFIGFS_ATTR(, release);
 CONFIGFS_ATTR_RO(, transmit_errors);
+CONFIGFS_ATTR_WO(, send_msg);
 
 static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_enabled,
@@ -1218,6 +1252,7 @@ static struct configfs_attribute *netconsole_target_attrs[] = {
 	&attr_local_mac,
 	&attr_remote_mac,
 	&attr_transmit_errors,
+	&attr_send_msg,
 	NULL,
 };
 

-- 
2.47.3


