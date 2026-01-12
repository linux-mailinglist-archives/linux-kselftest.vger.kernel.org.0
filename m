Return-Path: <linux-kselftest+bounces-48728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4223D1191E
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 10:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4BFA30E1EDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 12 Jan 2026 09:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5472A34BA33;
	Mon, 12 Jan 2026 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQaZ/Iy6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A053491E8
	for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 09:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210876; cv=none; b=T4vixhDs/Ecq5mifAvYULQ66G7ds+LSWuWMleYJi8zGj4cAYUEKK2jSfZmLJkVmgCPzaRru+m97PIX4CBei/S0UCFmM+sRqoESB7pqIYpqCSqmcM5A2cm24/1bFXZcs7evVZdcJRewFJkMhYWvMrcHmPAKvvoNXFAykYVDXn+Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210876; c=relaxed/simple;
	bh=oZlSrKc5HSf8OTgk8Y9zCO1ND/6B7m7anVTBiZTQDCE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NRyUDSd6bL5wrvVBnZxfAMbqBToQuZqAQdjYLMcK2GVPAbyrKJCNJgm7BjHK7M+I6zAGHo2s0n0VwDeCDBKBpPuMsCyj28lNsoUhaCUzqdQYAROQlxqIYtlp8i03mWW2yqMtiMJNfm9FmfZx1l01W9Q10gI7HJPNlMokJ7fVJKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hQaZ/Iy6; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so8163643a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 12 Jan 2026 01:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768210868; x=1768815668; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=hQaZ/Iy6Dl5sfj5+mmauSTFRztpCLtxoD9hULpPz3qNgL+UIDZn0s6bTLSxwvwrPCI
         0jrwlx7a5RR7C2JoaztGTEEXwZQHWK/bOtlCYpynYSFBPmVjJ8RAk+6YKv4vR3XZ+5oM
         pvcm54a+N1khUkf+mo/+Hclh2iz7rZ0zc1aY8XZ4qh157bC1h7eQDpGWE5okbyhVSfP8
         ekT9nbeeO3+sHuQ8zydFJrESDxJQrHi39xF5CeuFqvQ3ZEi7CC+7gtV3kcWzKgSrp72W
         goKlClZGhtK658aZYtCQ4oH412UqPj35jOOWfbs3Kq6v4n4Du0a52rVae884ch6Rmqgj
         HPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768210868; x=1768815668;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J4d7URFdeCPYu3U6zdfTOnUzmMHd/kT6rS033v+6Sa8=;
        b=ttjzRusDIoQvNRDyXFvFnnyDVSnc9zwvtoUA2EMOnycL7Kt/LYFgEPuUddP3/vQcUC
         DallKsY7KRzrgcVq1rmkHBxVRJRs3cnjOiDcccIwnH38icflwgk9uxtWlKmmCp6bHqKG
         bgs5WF3InamAyNSR0hUFWm6+60k28/r4+IYZ5ZhusXEpq19L60p3l0ognlEIOn0PvW/9
         CW5ESK2ZNRj2RSK1a44bnCWOTpeq1ucAzkyi2pc7fLWS+Ojy20h8aV37ayer4Uy7TtBI
         lz8LlC2TDJ3PDDvGstZvUAZEKxDrVeB5uvpqX/nGEJYVJkFDdUkycgikgcuASv0AuFTT
         hnCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfDzY5Stv1BCsf7m8vLIITKDPknvsvJba7H0P8Vx02VKMka7QZ0OKEh4/zlnR/i/5UUocnNeQIhGEVl/rPK8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YznfKEsvhq4BLnwBoWRuJQCC35Vde+4GdUwQ3PlZExpcq1CB9PG
	BOoXJcSLr+Plf1re7BEL7+Ic8RI9GzunyCUKuSbPfqPTuWhPueKWV5Jp
X-Gm-Gg: AY/fxX47ua+xH+rAZGhlsZK5HSTcgTGEI38YHbntzIQDXy+3Z0UCKC5SHha3KLDP7wW
	jQCu9jqVmGIxvlC5N/TK3SxYwXZuChjz3/mAdaeGmQdnXUd6jjavn5z1U0Xf1H+nPrSWDiyF++U
	Vd6miqTiYQZwLJCDgbKSjgKUJIqtGYRzJB0VDQFMmAvfOln3QLJBrZ2k4J+/ryVg7oEk68THuEZ
	w+rMP27h3mrzqLnkmUs2+XFrA8LLpTcljSYJJ8OQSNMcR6JGdN6NYa/xsFI1GogS4q+sniHpJ4U
	+AvqyDKocBWWajcm88PWyC7NLHSqlv0W1uM6r6YL5WUt2FwBi/8BYm9AkNBy0vxCh0qSJNxYrlo
	uZvx0gIhtuEkBuZSPIiyd0+W4xDemWFT8GOb8kjvYZe+5AxP9GXWZ8cxDdz3VEEkvoE2GjJbNWe
	1GF+khIdoUmxTUnZiILUyNx6q6
X-Google-Smtp-Source: AGHT+IE7196ejl7yFzSqk+olKRAYnC2uk75Y2D533VodUBlVEhIaeYQfNJUulVJjCL8VsWOCEwYsAA==
X-Received: by 2002:a17:907:d64a:b0:b80:48f6:9cc6 with SMTP id a640c23a62f3a-b844500df90mr1559904666b.32.1768210867980;
        Mon, 12 Jan 2026 01:41:07 -0800 (PST)
Received: from [192.168.1.243] ([143.58.192.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b870bcd342bsm410828766b.56.2026.01.12.01.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 01:41:07 -0800 (PST)
From: Andre Carvalho <asantostc@gmail.com>
Date: Mon, 12 Jan 2026 09:40:54 +0000
Subject: [PATCH net-next v10 3/7] netconsole: add STATE_DEACTIVATED to
 track targets disabled by low level
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-netcons-retrigger-v10-3-d82ebfc2503e@gmail.com>
References: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
In-Reply-To: <20260112-netcons-retrigger-v10-0-d82ebfc2503e@gmail.com>
To: Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andre Carvalho <asantostc@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768210863; l=2409;
 i=asantostc@gmail.com; s=20250807; h=from:subject:message-id;
 bh=Bc0ee9DYK1oiSRrahxYGeDv2Y4gYudwUsG3FQq7nt2Y=;
 b=dlucml7NE6QKov7VCIJKrbKl4nY7P7ygZT0UdSvjY2SvFgYTxYH1Iq9sObh2A0E1ovc8n6xTw
 wvyp5z1BJvmCxctm7jBsrYjDXJcEvmZxerynakzqwbN8JVznlQkw3AH
X-Developer-Key: i=asantostc@gmail.com; a=ed25519;
 pk=eWre+RwFHCxkiaQrZLsjC67mZ/pZnzSM/f7/+yFXY4Q=

From: Breno Leitao <leitao@debian.org>

When the low level interface brings a netconsole target down, record this
using a new STATE_DEACTIVATED state. This allows netconsole to distinguish
between targets explicitly disabled by users and those deactivated due to
interface state changes.

It also enables automatic recovery and re-enabling of targets if the
underlying low-level interfaces come back online.

From a code perspective, anything that is not STATE_ENABLED is disabled.

Devices (de)enslaving are marked STATE_DISABLED to prevent automatically
resuming as enslaved interfaces cannot have netconsole enabled.

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Andre Carvalho <asantostc@gmail.com>
---
 drivers/net/netconsole.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index b21ecea60d52..7a1e5559fc0d 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -122,6 +122,7 @@ enum sysdata_feature {
 enum target_state {
 	STATE_DISABLED,
 	STATE_ENABLED,
+	STATE_DEACTIVATED,
 };
 
 /**
@@ -580,6 +581,14 @@ static ssize_t enabled_store(struct config_item *item,
 	if (ret)
 		goto out_unlock;
 
+	/* When the user explicitly enables or disables a target that is
+	 * currently deactivated, reset its state to disabled. The DEACTIVATED
+	 * state only tracks interface-driven deactivation and should _not_
+	 * persist when the user manually changes the target's enabled state.
+	 */
+	if (nt->state == STATE_DEACTIVATED)
+		nt->state = STATE_DISABLED;
+
 	ret = -EINVAL;
 	current_enabled = nt->state == STATE_ENABLED;
 	if (enabled == current_enabled) {
@@ -1445,10 +1454,19 @@ static int netconsole_netdev_event(struct notifier_block *this,
 				break;
 			case NETDEV_RELEASE:
 			case NETDEV_JOIN:
-			case NETDEV_UNREGISTER:
+				/* transition target to DISABLED instead of
+				 * DEACTIVATED when (de)enslaving devices as
+				 * their targets should not be automatically
+				 * resumed when the interface is brought up.
+				 */
 				nt->state = STATE_DISABLED;
 				list_move(&nt->list, &target_cleanup_list);
 				stopped = true;
+				break;
+			case NETDEV_UNREGISTER:
+				nt->state = STATE_DEACTIVATED;
+				list_move(&nt->list, &target_cleanup_list);
+				stopped = true;
 			}
 		}
 		netconsole_target_put(nt);

-- 
2.52.0


