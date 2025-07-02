Return-Path: <linux-kselftest+bounces-36292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6F4AF1139
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C34166E06
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C81725DD12;
	Wed,  2 Jul 2025 10:06:55 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B6F25B2E7;
	Wed,  2 Jul 2025 10:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450815; cv=none; b=qkNS2eWOBKSFveZ6gm6cgBYY6J6iL8w8bGFPBXTFRKqMhNqYhgXZfHwqKZx72FNl3Nd0kMbshGTudLBx3k5RG76M94gZftu6dOA+AnTjudaP6WtMMH/9+wv/yi/rx2EY2L4dVEJ7SfI/l1eIWRHUtIChFZhojwDaJIldHBVlUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450815; c=relaxed/simple;
	bh=oMOUjvb17dkMjNgn7pjR5NW3PcafE7gyNJxjq175LMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSBryDN7tke4PlSJU+NRDhuK3l2CEFpbKMCG7R+BdRl43CmZYdyHzMri8DXpsx62C/+aLb/YfJpnWTuzSfuT/ZMG0IwFRIT80pPdM1orPtRLpj1VrkOJcA03flP/YhN+g9LSB4PVYQLIBzpYnmr/7Wd7xC9cyQl8gmn9luM+CTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-60c5b8ee2d9so14336578a12.2;
        Wed, 02 Jul 2025 03:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450812; x=1752055612;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYDZVXt1K3tFXA7SAWfw+XZ1JpA27F2JTM3+wG8ec70=;
        b=a1u+cGG0AFhFzVmAWPs1Bt0cMG9q0hcmHlJjYDzdi+uKXk9l0SATKAlpk4A8W0lnmu
         RQCJNY3UZLuYvZ1JTQ2syCF66wFWB+3AIeZqsZFJt6sae0ABiofEP6w73urKGipw2aMH
         hpImXTO1tq8Lswfcm/vq1FgsV42+fKMptOlqJqSkqtJnxJ0doSLYGbmfWIko+Qanzvur
         lFrhy+x7KCZZrmwIiWgua/SoOthuPZI7lFK2FSEAHY6f0Pq4jvbSiv9uA6q8z5QGcCyF
         2syuyZPtvCO39qfLBSlyDnM30GHf87/67xLLYmZ/wD0U8totTAvdXcQetyyqjwwqkzvZ
         HA0A==
X-Forwarded-Encrypted: i=1; AJvYcCU++h0ZgNByAKJNlQJA/u7ti3u1rycoPRdgVGuUC564cAhGWyhO6wPDEGxmyDLV2K53rwbUZ3m49DCTJ+k=@vger.kernel.org, AJvYcCUlQcdgmTFr7hHLWIFM3EjYe6l6zbLT4YBPfeQgJCoIOVUT8QY4y2Psi40IoN3hwsSSKx0qUQ4TWJ6G/PsNgtBT@vger.kernel.org
X-Gm-Message-State: AOJu0YwNxSOxKeO3QBkXGAhAmtjlio7hMSQY/7sGRo4wx6N9ZlNLCTsC
	SqFmBufMTnhMbNQSsLWVkTG3yXQW9JSV5LMM618c0Dm1nywntIbWvgrz
X-Gm-Gg: ASbGnctopeNXAMSVX1DExjNA82arCSNU6y9OK6Ab3PWIXML4OUiFmlkIVnsBnW/fHlL
	8Fg8KHjlmJ32ve6Un3x+yxHBiGu8qWmkqabBN6T3AuE8cxJc1xeIY8MU9ywqWFfsgwhYbj4kf+e
	HybhZsXp7gJgcCgOzmOWAF6GQULfLDQVHpGtIi+MG1kz232iejA59h/T/EFnipNNVDiAqqXnsgl
	bRjnkatWb2GrPGkiKtMnFI8zlkkgm/CWhP2MKm0i2nER+WK/eBUCVIWK6AaveRtAJZKsCLTBAHW
	fLfqORTo8XoGReE1n3GSWEXbnpl2hG5ENfZL1oUmeAMcO81qU3orZw==
X-Google-Smtp-Source: AGHT+IGLvkSbIcm/mfbJ+4gubk6cb7/AvlNNnXZdZh//1fmXsRceD9x5Iy3vrthD/0W6F9pTA5bL/g==
X-Received: by 2002:a05:6402:3198:b0:60e:4157:5922 with SMTP id 4fb4d7f45d1cf-60e536028ddmr1504392a12.34.1751450811572;
        Wed, 02 Jul 2025 03:06:51 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319f4d0sm9175363a12.44.2025.07.02.03.06.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:51 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:37 -0700
Subject: [PATCH net-next v2 5/7] netpoll: factor out UDP header setup into
 push_udp() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-5-13cf3db24e2b@debian.org>
References: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
In-Reply-To: <20250702-netpoll_untagle_ip-v2-0-13cf3db24e2b@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=leitao@debian.org;
 h=from:subject:message-id; bh=oMOUjvb17dkMjNgn7pjR5NW3PcafE7gyNJxjq175LMk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyYSEZGBhGA9/pFF1KG/lEfJzCVnTqsDI4x
 a62WnrCzAyJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 bctqEACauk9TlH2dLQLApUx/pP00mMdAFEBKrE04SIdamFcjXZdXfviDgj9c0lCLAe0f0Dj0khu
 H5RvCuAUwJGwdpO6F/OxQGa13yHaqakxnJDL+JXBA6oZLdMFUbLyMN0EVSPeMNWYFhmvW1s0o7o
 DWNji5DtDYzEEWHNkaNh5Nc6dC4Mb9LvIpyVQn6KxrLRkIzIhIP72RN2zNQrbi+FS70tem+ANoR
 /S9pTM259ynF3BK2VonIqm3q5nB35NYHq9XGFXDjsJeqHRWbH8yMdmISUTBOkhLQz3PebmCWVlF
 Dwl4XPPs9eJhTrwwIpNhYmmj1y4d67uZkCoGbAywvkmCmT9TVZUSFqshlx7ZgAg8pRKiYrz1sss
 UFQhtpDuJESyD2c1rlyF0m2zPX9Ak8/ghIx5Dwf2ssKWS2gQ/Da1FzbsLYBcJMcHKMcgajkTaxx
 RwQzJoHkgWhdxLT4KHgwyRrqxMYrgQ1XZ4SmPQxcVtbINFK1KEWqKm/7oU2vnNbRM9GgIUeqdUo
 0nGgApAz4CmqfA9bFPJpDX1JDDB0ao9Uxe3tcaZPbsSWn6tAxqy1eGzRJNjjp2E3rZDleq7Lj25
 PrmJ2KiE0+R+tKIGzHD2bnAmMzux6abJC0hTRe3/32Y3LeXDPi0ktqybxxr2HuEU1/ySiJDIX4C
 2bs84ycp4YIU+wg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move UDP header construction from netpoll_send_udp() into a new
static helper function push_udp(). This completes the protocol
layer refactoring by:

1. Creating a dedicated helper for UDP header assembly
2. Removing UDP-specific logic from the main send function
3. Establishing a consistent pattern with existing IPv4/IPv6 helpers:
   - push_udp()
   - push_ipv4()
   - push_ipv6()

The change improves code organization and maintains the encapsulation
pattern established in previous refactorings.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index ff64e94df5351..70035e27d91cc 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -473,11 +473,28 @@ static void push_ipv4(struct netpoll *np, struct sk_buff *skb, int len)
 	eth->h_proto = htons(ETH_P_IP);
 }
 
+static void push_udp(struct netpoll *np, struct sk_buff *skb, int len)
+{
+	struct udphdr *udph;
+	int udp_len;
+
+	udp_len = len + sizeof(struct udphdr);
+
+	skb_push(skb, sizeof(struct udphdr));
+	skb_reset_transport_header(skb);
+
+	udph = udp_hdr(skb);
+	udph->source = htons(np->local_port);
+	udph->dest = htons(np->remote_port);
+	udph->len = htons(udp_len);
+
+	netpoll_udp_checksum(np, skb, len);
+}
+
 int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 {
 	int total_len, ip_len, udp_len;
 	struct sk_buff *skb;
-	struct udphdr *udph;
 	struct ethhdr *eth;
 
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
@@ -499,14 +516,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
 
-	skb_push(skb, sizeof(struct udphdr));
-	skb_reset_transport_header(skb);
-	udph = udp_hdr(skb);
-	udph->source = htons(np->local_port);
-	udph->dest = htons(np->remote_port);
-	udph->len = htons(udp_len);
-
-	netpoll_udp_checksum(np, skb, len);
+	push_udp(np, skb, len);
 	if (np->ipv6)
 		push_ipv6(np, skb, len);
 	else

-- 
2.47.1


