Return-Path: <linux-kselftest+bounces-35996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90225AEBEBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 19:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC6E61C624BA
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 17:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A862EE607;
	Fri, 27 Jun 2025 17:56:02 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EFA2EE27C;
	Fri, 27 Jun 2025 17:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751046962; cv=none; b=p3uU53l7IO9xHfblxYgpQAkOqPxPOnTfLggCW0ZYWtLtKaz9Hlo8IGHCHzj/0sxOBWQzdXI6ekMjRsS02FMR2I0/1Sf4rfsKiWyfo0DaGDqu6eaBThEJiTiQRHHUMId5brasEEbWhbnuQoUOx1w3w0m61JD85AdXvAHWXhaS5P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751046962; c=relaxed/simple;
	bh=oMOUjvb17dkMjNgn7pjR5NW3PcafE7gyNJxjq175LMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g1frpkS1K/ZF8QHY1pMBl7yT0dNmfBSxkZo6slWqg+7xf2OajSn3ETQ3fMDxNLaRgXHox4dDckPObjGEns3QBnbDtuAJO+hKeSx1z3Cvcc7Es+0PmgMSViFYNSIMnAKYpbUTcY7X2ifkqUsVyrQ0Llr1C01TkwZPZmhOX6ApWvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso4504783a12.0;
        Fri, 27 Jun 2025 10:56:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751046959; x=1751651759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYDZVXt1K3tFXA7SAWfw+XZ1JpA27F2JTM3+wG8ec70=;
        b=PL+/BbyNyfXPVkQLh85mKRBP6erMfxcEbBDoGEQaeYxjM3SBWk1ISBAxAldJPOW17C
         ebCFK0oU6V168iPhwwYqiBJTH26Ya1xSEHP43vIkOezVeFP/dZJguuf7fZ4olUboisyw
         akjgbJxpRF+ROC4KD+tATy2d5AXHjMQCIzast/XNhgBV2eZA36ZgTKTWf4VhPBVVgcsd
         dGJPLotkrO+Mjdw2SMMi+vPuakZi0FvPsa7pDlMM53jb/pYLd7Mip0FKghRC4bMnda69
         6iEt+vhA+1viVRh3EpmY1ROzyqU5mVzuTELx8SFbxRFQkDJr6sN99fpcJmDInXaOyNRS
         IDMA==
X-Forwarded-Encrypted: i=1; AJvYcCVGd8rvZdxyivEnnK4+r4QvZc3ofY7XEBpH9+UqnfnlgIzzODsPlr4pWlvQVNyzWoWruvXHq8fDNvn13qa1HDCv@vger.kernel.org, AJvYcCVwPnly0BycKjnkfsP4t8crsNtEJjJFlGsiNJ5aePZeox7Rg0LlYzRWYCvYPnKtuYrA1wMYZAOvKa62G1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN+NVAS113MPUN2WayA7W+ejo7wbI9ZUXRkQoW3vATN7AOSK7j
	wwzUpbSwRarEZ3Ek/CtAvvmGY2HNwzOcAkOt8/g4LJiX/htsYfzPd/X9
X-Gm-Gg: ASbGnctdWef4O3jEyNN+FBf7MmJFJAQBcA/lcF2W5mo8yN0X7OM7399I1ep2BdrbfHd
	LyMqrN4vjcyhFVVkV4EHy4oZPe1X2ppK/ffg71pSChqNJQMizZjgblP2cE+SwyJ+sN0wn7ReR5n
	w2tLwZ6SPww5LTgxA3Rqk36oq5FmfvejXmXo52E+TnRmhl2E5WqUk79GcGJYAX+07rP35wL2zyv
	kO5CoepwVfMVZSkz90PiWHzRcaC0avvsE43Bsfe+q1ad0Nitxb66OztzKnZqjCZLylY9a51U9Sr
	QPkIVCU5o2kD8A+FVuKPeFoh4oVc1rTLkJK+LeK3zsYlMKu7Xh7sSrZrj+Oa9vo=
X-Google-Smtp-Source: AGHT+IGPMfxBFzdVtmU6aO7sJzDek40Zxc8CFLGTkaONoG0scZ4/v3uLaSR8KfrkjV+J42HjmwVJHQ==
X-Received: by 2002:a05:6402:350c:b0:607:ea0c:65b2 with SMTP id 4fb4d7f45d1cf-60c88e64bfbmr3638601a12.31.1751046958559;
        Fri, 27 Jun 2025 10:55:58 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319b333sm1774197a12.40.2025.06.27.10.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 10:55:58 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 27 Jun 2025 10:55:51 -0700
Subject: [PATCH net-next 5/7] netpoll: factor out UDP header setup into
 push_udp() helper
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-netpoll_untagle_ip-v1-5-61a21692f84a@debian.org>
References: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
In-Reply-To: <20250627-netpoll_untagle_ip-v1-0-61a21692f84a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 gustavold@gmail.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2123; i=leitao@debian.org;
 h=from:subject:message-id; bh=oMOUjvb17dkMjNgn7pjR5NW3PcafE7gyNJxjq175LMk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoXtslxabGqvLOoJi0qm6WxO4hE9T21yO8n1ukf
 faiLPw4UuOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaF7bJQAKCRA1o5Of/Hh3
 beCRD/0cMNoa6KRm++iPV10N41fFdDxCu8dmG/Wf0Zt8yOGcvaPOmi23B0L7em9uZycjGGokSgO
 cHiwhkj8DSBW3YTrlj1w11MLdlWD4ig4LH2tLK7wxE3gf4NFGwCJ29hDd/RVx+u0ocZymZNPHdw
 5N0qi5Xcin6rCDTN2dYFjf+r6cfLZSudmYRiCCHAl1eYb6QVrHDu3f0ObmJ5KzYgDgTEvxbVDHc
 q5xzfCi9mTI2FJUFFAEmaPjNeEUhuLGljZ7oCs1REJqfaId9xzwhqQHk8v7DZf+D5HT1cldFAvR
 qGtaXIVTuth7UfU6/3IveAMsHsZfCGO73cWjNGbRV29knLDE1ETv4f43AjFQGrlkfLt97QAVENy
 IJYtxWsayXZW3BZqViKwJ9OMEB0/mw8XuoX0/CXWB8XTyG4En9+tqKLEHfESLh77ed5/VWbk0Vq
 p65Kwkm8W7R6QqaX2cNZ+cvuUlKzhUx/gkQLWi5MvwvljRJ+491K79ATbhd3QpA+4TRRUDZoI0e
 88P/22SOO1MjNgoz9EvrJKVyOosyxq4hKg8hQJWMyvzcTQ870zXA2cZUx0ralFL29tb+LOLj9p+
 z3eF8qx6TfuQkxu5FY7FGcW82tt+VZxmrFBLk0c3L+HQQOl4krZaZDB8tafZxegk5+aLZc1ICvn
 D9xn5Ur1w26tqYQ==
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


