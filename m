Return-Path: <linux-kselftest+bounces-46151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D22C76BF3
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 01:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 76EF635E909
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 00:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F548241679;
	Fri, 21 Nov 2025 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Lq2B9E49"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7154239072
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684461; cv=none; b=j+A9mgujupazt3vgzOP7ff7DM7GBiJ/O/10XC7qKt5aUCXiESk9MLbMTujOfXZoltZF0+I2LBgTjMw2an+G9tJJQMV4Yq48CoK7MWvdcgq5jhJXFiCCc+XPQ6oNqw76HyUybWSJFdDiB/o0dGtynK/DbwEEyiBFkE4AkxPsJzOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684461; c=relaxed/simple;
	bh=SQr5tFLgyqdFgaxXIQiGqdGYtlI91c8reoAvg3ay9iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djNCmcK759rxHIvqIBgJGHJ8OrjocmIv5bB/cPKFkwqF+pJy6JqABqZMYfG8h2ES2Ojj6YsnX27ImZ6r26fB8cY7JhO84JnggDHxSZWD7PjdnmI5qQxyKbpn/RPWQYxNyUG+h/aAennO+tIjRVlfJq3zifRwUmnkmHrbuHneTug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Lq2B9E49; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4779a637712so9751205e9.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 16:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684457; x=1764289257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KCT//YQTHijb5eKzD95V+Wg1fIosKBqiDeTxZ+jvvds=;
        b=Lq2B9E49f4J2XRPgbpxLkRBJRQZr5aTy0TOAcRPtpYy43upxciaRFVQNS5ChDGGibd
         XtYWDJkWWg+nOWqT0HKAz7ORZoWt0dP3D7M5MwIkTaqE0SzQxihkiVcxzh6+UMX6yUxp
         Slb2qLOXwEG8Z7J0N/1tMX2ggufbKgDBaRo9aDOd0iXz9GBle8mPjOtmsSzbzrkba+TB
         NLrWuK0nLu0zTUXNg479hAkvI4tpGZq5YwVaUsmsBCJA6vjJ6tMqzdAD/P48PlO/Rm/J
         mHnbMfgAhlZ4Flhp3fqBR0AFRTAGJHY9fqgzrBoYUYaswLB9M/+340xtHz3f2pez54D+
         1Fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684457; x=1764289257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KCT//YQTHijb5eKzD95V+Wg1fIosKBqiDeTxZ+jvvds=;
        b=LmgfPOTeCLe6zHwgBKU/hw1HIRF2n6L6RHf2ZpPCHdLK5v8zP3iwoDbhTP8oDcJ3jd
         f1Oq0vgsCqPxdlSA6EglIXaBUKXiFo9HUx5Xn0YkAWtrdN0iRWWEndAI7y27J7kvBVJt
         GMLOhkhmQ8znk5brNXBZD/X0QCeHMuFNxsYhSjvJiw8bsV36oKMMpyy18s19rEkF8RZb
         OXd22vihnvBHvNRC2O+rUR8qlPBh4zL4twMioF34knxpyz9QSK8MMeWnmrDQjtMFLI05
         +qVkANn0+WAHYSNXP4nRxO7cClVQN9oBlvWpWN77DitSCzMW6WiHQ7wm3nXTjpOJ/BuO
         cVAA==
X-Forwarded-Encrypted: i=1; AJvYcCUS0C8zLJTD02af8IrJkWMeC0nYqZUi5uj1emC3DgisbLKQynwsl412hu0lSl2i2NYP6BWG1OWyYJdkZ9OyslI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXGHY4O4IhtQ+p2VK/F8qvZepK1UbsGNGV29d1mscq/WlPryAh
	hZfxHhHpPBzfslTChK51QoZpO9i5FGTxppz+tdda7Lzv03uV4K9P7AFxPLLFwRyqfqGJ//P2rWJ
	rBijR5K4Eia9LhOieXRZCpFsNGp/WRUcdInuStefbRIu4khtwYKaP9VeWCIDQWPnrwXfOlyC3Ia
	dvKz4=
X-Gm-Gg: ASbGncvtH9e3a6bGRPGFkeY1PJzkVfwblNUtyx5qEClogg6ZstMnIt1Oil4tGux/4vk
	nLGVXN2qOO4nmu9HwbPyPQfCN20h83dQkm8vpvnX4+SrJIXYHL/9Zq1kf65JCrTR7GCbucYC2HQ
	l+Rnj0mgCHVfdPh8YRHGp1PR2h8X1Cf9JQh8smJk4ZxYMvTRp8rFrFTUloFqndme+e+c67wNAMH
	shBLgJy9ubGoka1qpgmrUaB2340lamVCXx2kSBZEkOxdtHk8TMNEOW2eyKtI4Y9HyfH7fHWHZzh
	Gw0QHCdCvz5FySVXTIavxe3OX92E5kIh7Kx/7vuQL8oYo5qKotmLBSuoF0B2SxQyHTY1YJUQGDL
	E3CO2ptxWGegT507VmM06v+w3xuemYyu/8K/ut6uXzm03MPt9YCVd/TzKv+6A76bj1yu6eXV+v6
	2TKaAbKDinpCySHxY1LKwP0jwt
X-Google-Smtp-Source: AGHT+IFceabA3ARZ0Jtb9z2iRinnBTkuBeaNhsd5xXlRe9ahmVdyJGhXpvKNah8DEV9Au5W5PDvrRw==
X-Received: by 2002:a05:600c:450f:b0:46d:ba6d:65bb with SMTP id 5b1f17b1804b1-477c01eb9bdmr4160915e9.31.1763684457291;
        Thu, 20 Nov 2025 16:20:57 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:20:56 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Qingfang Deng <dqfext@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Ralf Lici <ralf@mandelbit.com>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 04/13] ovpn: pktid: use bitops.h API
Date: Fri, 21 Nov 2025 01:20:35 +0100
Message-ID: <20251121002044.16071-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qingfang Deng <dqfext@gmail.com>

Use bitops.h for replay window to simplify code.

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Qingfang Deng <dqfext@gmail.com>
[antonio@openvpn.net: extended commit message]
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/pktid.c | 11 ++++-------
 drivers/net/ovpn/pktid.h |  2 +-
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ovpn/pktid.c b/drivers/net/ovpn/pktid.c
index 2f29049897e3..f1c243b84463 100644
--- a/drivers/net/ovpn/pktid.c
+++ b/drivers/net/ovpn/pktid.c
@@ -65,7 +65,7 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 	if (likely(pkt_id == pr->id + 1)) {
 		/* well-formed ID sequence (incremented by 1) */
 		pr->base = REPLAY_INDEX(pr->base, -1);
-		pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+		__set_bit(pr->base, pr->history);
 		if (pr->extent < REPLAY_WINDOW_SIZE)
 			++pr->extent;
 		pr->id = pkt_id;
@@ -77,14 +77,14 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			unsigned int i;
 
 			pr->base = REPLAY_INDEX(pr->base, -delta);
-			pr->history[pr->base / 8] |= (1 << (pr->base % 8));
+			__set_bit(pr->base, pr->history);
 			pr->extent += delta;
 			if (pr->extent > REPLAY_WINDOW_SIZE)
 				pr->extent = REPLAY_WINDOW_SIZE;
 			for (i = 1; i < delta; ++i) {
 				unsigned int newb = REPLAY_INDEX(pr->base, i);
 
-				pr->history[newb / 8] &= ~BIT(newb % 8);
+				__clear_bit(newb, pr->history);
 			}
 		} else {
 			pr->base = 0;
@@ -103,14 +103,11 @@ int ovpn_pktid_recv(struct ovpn_pktid_recv *pr, u32 pkt_id, u32 pkt_time)
 			if (pkt_id > pr->id_floor) {
 				const unsigned int ri = REPLAY_INDEX(pr->base,
 								     delta);
-				u8 *p = &pr->history[ri / 8];
-				const u8 mask = (1 << (ri % 8));
 
-				if (*p & mask) {
+				if (__test_and_set_bit(ri, pr->history)) {
 					ret = -EINVAL;
 					goto out;
 				}
-				*p |= mask;
 			} else {
 				ret = -EINVAL;
 				goto out;
diff --git a/drivers/net/ovpn/pktid.h b/drivers/net/ovpn/pktid.h
index 0262d026d15e..21845f353bc8 100644
--- a/drivers/net/ovpn/pktid.h
+++ b/drivers/net/ovpn/pktid.h
@@ -34,7 +34,7 @@ struct ovpn_pktid_xmit {
  */
 struct ovpn_pktid_recv {
 	/* "sliding window" bitmask of recent packet IDs received */
-	u8 history[REPLAY_WINDOW_BYTES];
+	DECLARE_BITMAP(history, REPLAY_WINDOW_SIZE);
 	/* bit position of deque base in history */
 	unsigned int base;
 	/* extent (in bits) of deque in history */
-- 
2.51.2


