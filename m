Return-Path: <linux-kselftest+bounces-36288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C42AF112B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6769D1C23E1C
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97549253B60;
	Wed,  2 Jul 2025 10:06:49 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82672A1AA;
	Wed,  2 Jul 2025 10:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751450809; cv=none; b=JU4OddMg7qWayFepp/+imPzfdnW7AJdNnUZe8YtaMBFRG+2NErtycDxNscRkftSTp1aJzJbWcDmtQ1wkmSW6vMydNA2HqHCzkKCY/ND9HmejI1Qv9Yo/MeTISvN780vh2jZlo3E3zYmEecI69itERs+TawGzZ+1eMKd6UjF0rxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751450809; c=relaxed/simple;
	bh=jbCjWV/h7n2SHM7aPePgMluwf8TLq/orMZ98gJOmxn8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fM+VrCm1zuyWbqOUDSTT9kcEUtKYR3wQYTjub0gZKQN9bQs3GwKborCNxr2WH5Alb3327JdUNmrfAqoFnBeEm8idrVIUNoVDXv+VpbjvSftPdXNKJxVaK+DLM7KKqRZXA/MYR6fsGbtxL7wPT6hdYJJMV6ulqRdGe8po2b+pLlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c60f7eeaaso11050592a12.0;
        Wed, 02 Jul 2025 03:06:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751450806; x=1752055606;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BdAqTjFNYTelvz4grTCp7T82BdTogW49IVN7Iv0xIeg=;
        b=UuXr8jZ+sqF9z621GySBnQy3CddAJb72sAeooMEnHqoejz410zC4AzzxwEOLeJ7wKk
         qv9+ynTkj8zDl3OllU0wuh5y39I9lVKTKFDjYvTX2N3BWQmLJbkH/oYHoo1o0A7dsztr
         9ZUIJKmgAEoODOR/MaE76EXs7kvnWd/LewIRUxtAeHkhVzZNMrEGpjqitgkEICryqE2b
         HEHBquegfD219ZaB8Qpcy5cSSGPXY1pKEOBNPXfHFkjLtH8UHILiB0smkkdbNkrAUWcb
         jrNWfD8OQSkzx0YZmp6MI1fUDwyiemv6tKQNoNq0SHWHLBXR1FYIaMe5GRhoRs4td3/6
         +OHg==
X-Forwarded-Encrypted: i=1; AJvYcCVL3pQwfYQFWRPY2QlOHtby/OThJb9VW3y2PoDnfu1WgJLTN1Br0mr08kzlnZTqGGrr2lXCLU4Qq6yQwW3KB97H@vger.kernel.org, AJvYcCXe5uTLSL6Nccm2/+gEs3M5sywb1ZI5aHeZXKLw5JUI87ya//sltEmkd+dxW26X8wy8/+FgBC16UOAqCRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4WaAyn+Xnt/Jz1D/BDjz4LyUAC0LgWDeoaBn1tyUBUk2Wacfk
	atMxyC9NytJXLAobrQRTgTxmTLhdhLTFRiqQF/LVLvX/huni8PRKbfgK
X-Gm-Gg: ASbGncvkK1zKYXxIDhrXyf8anmwo2rQW0V9H0xQQXCQWIF+Y6aUKuUwWkHuzUbjQn7h
	OlhO7hr5m7qLjZfLOvJLVW1s0xi8knedcgQ0WGEoM3eIudk7SnEl/DijqzdaHUhLF/ngHk7/XQj
	8upsm5vPdy6bV0nEi4/DeZW+VrQX9BYaY+B37VQLMc1lIFqjlbYVBPfqQ+HWhXfxWVkgnMiX4YW
	vpNK+gO5kESMnqkPVqSVHZ7kPFGddssdMqZx6ef6TPF37ZNqTfGVbPY7PvTQBfofjwIXfpWu0Lz
	uKrFNMhWN8aCORYxEdwxc1zDooHknRJhvWXLLClBuj5zZEuNqYwO5A==
X-Google-Smtp-Source: AGHT+IFfl328+IlYGpptBsWQ455Ds8A/oKtoUN3qUBUcC1BpoxDjsVdMAlR+Sgxscnzkzq+ufFr2Lg==
X-Received: by 2002:a05:6402:909:b0:604:e602:77a5 with SMTP id 4fb4d7f45d1cf-60e52d0457cmr1978769a12.15.1751450805619;
        Wed, 02 Jul 2025 03:06:45 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c8319f50bsm8720744a12.50.2025.07.02.03.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 03:06:45 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 02 Jul 2025 03:06:33 -0700
Subject: [PATCH net-next v2 1/7] netpoll: Improve code clarity with
 explicit struct size calculations
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-netpoll_untagle_ip-v2-1-13cf3db24e2b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2146; i=leitao@debian.org;
 h=from:subject:message-id; bh=jbCjWV/h7n2SHM7aPePgMluwf8TLq/orMZ98gJOmxn8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoZQSyHxec+z/U1kefZ+yfGIkFInKDJ8GFFZDP4
 FZAEQzvLIaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaGUEsgAKCRA1o5Of/Hh3
 bS/iD/4l46DQVLcMEnWfnS6wuhf87uD8ChGV6CCtToYw3pqYzoha931JvB6USs18PfwvIz5GWaL
 mDTclwfuzyWIb7xqEBWlHgjPD/iYBc6X+j9KPZUWmcM5CSosJt0XbVi48v5Ss+TxnvIJG2LnzZU
 YuvQFJUZXG0iwN7MDKuT9duMOrVkGhiMmdWdOMs1m4+Z+QApFzNiPq2rZFqUJIsGRpC+JQ/HMLi
 i1iZQ8+tU45WppTAIo6PXAOhLuYoC0AjOKv7J7+H7hh9PHt5StC4pvo9nq2+oYIcLHlDTq61k5s
 iOG8iv/OK8mVy8wvKj7Fl/PAr5tmV776UQzT2rLgAG5GsatBGi6+0DsOPj5uc4KKCfo0Rvftw0T
 oEM+g86XrViKxTXQDD5az25xn8E1BZKexLikzoWAPDifKyYl7wZ6vZiu84t/GL9gjZ8Is0smLlT
 2R3XlhSBY2dN/Y7Cm4j3RmEvkgt9fAJ7j6XWGgejS6OoYutGd5qFvlg8SRLN2Sqb6qYzjjAUd0Q
 Nekqxenz0gaL7/HdbcGAtDo6EOgUP41ujRo2ikr1N5eIk5sVbMD259Ry/MT0kpzpgB5BRcFMzB0
 69hCMMFo1lXDwaI0TZr8iQ73WrWhyfATXYKDm4xgSGlfFz+nmQe8OCjhc8/A4wDwIWmI8tz18ek
 wF8X+Ur20qvRnaQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace pointer-dereference sizeof() operations with explicit struct names
for improved readability and maintainability. This change:

1. Replaces `sizeof(*udph)` with `sizeof(struct udphdr)`
2. Replaces `sizeof(*ip6h)` with `sizeof(struct ipv6hdr)`
3. Replaces `sizeof(*iph)` with `sizeof(struct iphdr)`

This will make it easy to move code in the upcoming patches.

No functional changes are introduced by this patch.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 54f9d505895f6..ac0ae9630654a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -402,11 +402,11 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
 		WARN_ON_ONCE(!irqs_disabled());
 
-	udp_len = len + sizeof(*udph);
+	udp_len = len + sizeof(struct udphdr);
 	if (np->ipv6)
-		ip_len = udp_len + sizeof(*ip6h);
+		ip_len = udp_len + sizeof(struct ipv6hdr);
 	else
-		ip_len = udp_len + sizeof(*iph);
+		ip_len = udp_len + sizeof(struct iphdr);
 
 	total_len = ip_len + LL_RESERVED_SPACE(np->dev);
 
@@ -418,7 +418,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 	skb_copy_to_linear_data(skb, msg, len);
 	skb_put(skb, len);
 
-	skb_push(skb, sizeof(*udph));
+	skb_push(skb, sizeof(struct udphdr));
 	skb_reset_transport_header(skb);
 	udph = udp_hdr(skb);
 	udph->source = htons(np->local_port);
@@ -434,7 +434,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		if (udph->check == 0)
 			udph->check = CSUM_MANGLED_0;
 
-		skb_push(skb, sizeof(*ip6h));
+		skb_push(skb, sizeof(struct ipv6hdr));
 		skb_reset_network_header(skb);
 		ip6h = ipv6_hdr(skb);
 
@@ -461,7 +461,7 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len)
 		if (udph->check == 0)
 			udph->check = CSUM_MANGLED_0;
 
-		skb_push(skb, sizeof(*iph));
+		skb_push(skb, sizeof(struct iphdr));
 		skb_reset_network_header(skb);
 		iph = ip_hdr(skb);
 

-- 
2.47.1


