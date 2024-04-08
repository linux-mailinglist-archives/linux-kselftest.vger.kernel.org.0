Return-Path: <linux-kselftest+bounces-7399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2765589C6C3
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 16:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B3A1C238C6
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 14:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209C2129A8E;
	Mon,  8 Apr 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDfYiL35"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D14126F11;
	Mon,  8 Apr 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712585909; cv=none; b=kLUT4I2950Mz+YwVLMom+iD3jkOcqDtLu3+feAAh/NA6+BjU15ItVseaQHyov8emvRYpc9UJ/chmaS6RDWOXn3oga01PqZ/SWL/f3paJG8zhjbnsk1DAqQabiVGAj3Dnz1Pu1yhRKcmRcH5xgbeGdmuaSEXJoQ1cAwtQURibKL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712585909; c=relaxed/simple;
	bh=3UzV0UOZOjy3JtO3wdK62tyyxKBmlnga1vPlyrqfpSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mk2vorVZph1w8XKT3iyTf40z3uO1RXXVdVYStWgBrDp4nWEJV4dURTF2EWilr/w1CM3bi4wvUVr5dIqNlo5pWOR9R74ong39V7GUsW+OZigHweD1U/kOBrmyXF/qkhfjt7r5vXYpP0RMwmLUuroHemWP1fZvxOeFT6eUdxtOhcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDfYiL35; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-416422e2acbso8932475e9.1;
        Mon, 08 Apr 2024 07:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712585905; x=1713190705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfFYVChXPcbDou1VfhqYcnGp2/xfKZ8N+NQj6tQE/JQ=;
        b=ZDfYiL35jr9uFyx9bmhoUDSbrsOMiXgV+TwhmdkcgKH/9HyHrhYi2GhdQvsqXOBiDH
         LgRIoDMW2DU0E9PTlHjjDtWpAxIwKwA0m39uGlmeQnzx/j1ven8fmi73BSHmUQHYM36v
         9cnpyUNGSRjsFjgLUXo4hLy2TA7EpRFxDxmeWRGBTZP+Q08jKw0CHZ61LixafpnUjmuz
         q+TfLcuo2vQ+KozKfLC4cK6+6s49ZHG9RQatk2t8yCTaTNRJgyQP0SjNGmgaCPsIGYiD
         ruwjADVOOxRWL6ZjkWLxck9Iu0T1Ypi8sLO/Ek1cnvJclU1L0YPZdWC+WgY5gJerZ4AL
         Plbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712585905; x=1713190705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfFYVChXPcbDou1VfhqYcnGp2/xfKZ8N+NQj6tQE/JQ=;
        b=LtKNpygrrKSJ0aVAjw3xvjSZ1hBNfAQ8Z0TYaQtrq34rPOzUC9qk9lW9F5plE13mMe
         fogqZs6pQ0cbTCVa5FxASuXqWTq4CuJrW0XzP9JkfK8JGHwK8e/KJOsUOnvfq24CUmac
         OFDFQ4q6eBnIHpne5lCx2yQDc22uxIyF66GQzfReHBIVxITC6aXYl9QqovZnxe6knm+F
         jFOYd2pro+Gdp2lKcUIbJMZf435u4plk+zjUzCVNk6rnWvaxgjxN5JbkdRAClkXMPai7
         u6cknaMa1psO1zv8W+HcQCnovOAw6I/BRFlxHzZO0lMyzLQSijao/ug/05zaZMYFvRbg
         AVWA==
X-Forwarded-Encrypted: i=1; AJvYcCVap/xtXr+MaeyMaVeoix2btSCQWWHBHvkPmU4QwECruBU6DM4wQY7o9EW2r4JG/+x71s4S1x+cfFCa/BQR9NoLnXWhecy6WGdB34lwcbUKhm8o3pmRuF1/Sl4LhYHpWUkkEuH8TxDKOEzoqbIPJOzMR6S/MPtoTJ7cYy9YXN0fq3GGkx8K
X-Gm-Message-State: AOJu0Yz1lIblTE9z8FRjnlZhJp9hu9/Ntuasw7OiBXiUGWNFYmQayQIk
	VYBxwbdPBaKjF9OCYTNkqDESKn05qnjq1CwhRFTkQELU0ps9YOda
X-Google-Smtp-Source: AGHT+IGFSSbBd8XYoB84N0vtmb7X579DGGFjZgnnHVjl8X8i+pfqtf0WuWRSbcTqG/Az7bduDB0P8w==
X-Received: by 2002:a05:600c:3ba7:b0:416:2abe:b886 with SMTP id n39-20020a05600c3ba700b004162abeb886mr8544919wms.0.1712585905543;
        Mon, 08 Apr 2024 07:18:25 -0700 (PDT)
Received: from localhost ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id p13-20020a05600c468d00b004163059bb53sm12323389wmo.16.2024.04.08.07.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:18:25 -0700 (PDT)
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Richard Gobert <richardbgobert@gmail.com>
Subject: [PATCH net-next v5 1/6] net: gro: add flush check in udp_gro_receive_segment
Date: Mon,  8 Apr 2024 16:17:15 +0200
Message-Id: <20240408141720.98832-2-richardbgobert@gmail.com>
In-Reply-To: <20240408141720.98832-1-richardbgobert@gmail.com>
References: <20240408141720.98832-1-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GRO-GSO path is supposed to be transparent and as such L3 flush checks are
relevant to all flows which call skb_gro_receive. This patch uses the same
logic and code from tcp_gro_receive but in the relevant flow path in
udp_gro_receive_segment.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 net/ipv4/udp_offload.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 3498dd1d0694..1f4e08f43c4b 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -471,6 +471,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 	struct sk_buff *p;
 	unsigned int ulen;
 	int ret = 0;
+	int flush;
 
 	/* requires non zero csum, for symmetry with GSO */
 	if (!uh->check) {
@@ -528,7 +529,17 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 				skb_gro_postpull_rcsum(skb, uh,
 						       sizeof(struct udphdr));
 
-				ret = skb_gro_receive(p, skb);
+				flush = NAPI_GRO_CB(p)->flush;
+
+				if (NAPI_GRO_CB(p)->flush_id != 1 ||
+				    NAPI_GRO_CB(p)->count != 1 ||
+				    !NAPI_GRO_CB(p)->is_atomic)
+					flush |= NAPI_GRO_CB(p)->flush_id;
+				else
+					NAPI_GRO_CB(p)->is_atomic = false;
+
+				if (flush || skb_gro_receive(p, skb))
+					ret = 1;
 			}
 		}
 
-- 
2.36.1


