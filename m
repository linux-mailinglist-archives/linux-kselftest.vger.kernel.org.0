Return-Path: <linux-kselftest+bounces-25213-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CECDA1D0C0
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 06:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4874F188797C
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Jan 2025 05:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB361FBEAF;
	Mon, 27 Jan 2025 05:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="O+Sk+vqn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4537DA73
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Jan 2025 05:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737957473; cv=none; b=ukiq3qkF1X0TtmN/I4NZNdl+jTakrDafCzjEuUCNkJmuomJ4Le6n9oO4FhG0u6uc4Zh2Aw78f9exF9LilFiYApv7DtFGNOAGCjaeVhoVdmzswio4zghznQKLKRw6HFMi3ve+a/Se5wXRGuXD7EvG/8da34kcBNW4A/HLCneA8rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737957473; c=relaxed/simple;
	bh=g9tKZKUVtgad6iryP4gNw2rOnw73AjN2VWCn9Ts74a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uVUq447tFlA0Jc/8sqvB99nFmT6aodLjPVDqaffoLpbkCIIi0VyqpUs+Hk3pSOkHHhlVAkW3Mi2bAGmUId31iXwS+XQG4FZv2PyAd82s8IIYUJ7dzWnnQ42cN6IaxtJDKT0jL9g1lmApkk674GdM6JPvR2Q10ZeO7gbdyCrbeV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=O+Sk+vqn; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be8efa231aso413745885a.2
        for <linux-kselftest@vger.kernel.org>; Sun, 26 Jan 2025 21:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737957470; x=1738562270; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/ZAOjkuxXZ0U1ZP58rurbsd7EJpXrywFMWXYNm47nyk=;
        b=O+Sk+vqnleBqMu5phrqH4llVcsGyCjPafoKombpOr7YP29b1aZFPk+YK1bFRFFvCfY
         hEZA65Ovul4OC3h/yhgd6MY6NPMAwlpbOBopYUbV57pV034O+gEUKlL+T8tk5sLCJwhv
         engZ0rHVOm5YgoXXTV8QSn40pbbRcMcBSbLUFNwNhxIOfO/kCOM9aDWcYsQyPnC6bsIf
         1iaDmNb3N0VpKWUJh0hJCCaktibxq+dv3W4d2TZCpj+pP25yTcAveU1S0LZjVPxw3Znj
         lpLc2q46QDIStzgnRQuLzRqsLeq1X/Ot8j+leK2ysmLfm2OgXipqFl+RqiXbXW50dN1U
         kErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737957470; x=1738562270;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZAOjkuxXZ0U1ZP58rurbsd7EJpXrywFMWXYNm47nyk=;
        b=SfhktulA7b6wYTH4giK+dwqYDMprY+Z389g3r4d6MtC2QMGeekThCDthzcgdjEQcKp
         7eAFjme+sAnj4kSZkOtbifuT0niL6U1Dk46hG4ycYroW8G/bqnf87fCOMeKFr2PjU5k6
         UHk+ibumB1q9kYAOf/56qEHBAyDRky33WwRARE6zGoixX14K7Wvg36O+ra6R+loVI8lN
         Onbadd/FXz+2w2FF0ucwpA6aP+U6uQWfXFJ0r61q39Ufn2hOoguaCeB0V9oj/T+lpZW3
         250VWd6OGL2ihi5V60iYLNjvNWaSYL0XJ1wVJvUfQKni2eN8N829rEIWJ1JghcPchCyP
         SDSA==
X-Forwarded-Encrypted: i=1; AJvYcCX/iY1Fd04LENJwOmF10hhU4xPYd7ex0Tjf1ae61szursstiFKGff4CdW4dJeQ2i37aSaou1DA4BP46U1ASWKk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4cuK0jOdLesAxI5Ko3btPi8TCuOSPOhG1whn/uZvlplGuFeLX
	/FAVkJFuvkpcH5q8ft9SzXzTbCt4ZXJQ3QEFYeHXqfXqL7FiHxYoDgEylmJO4FY=
X-Gm-Gg: ASbGncuArfAubuvzQm+rWlxjRsKzRAEJJm45pjgjSeYiwrqWUvYhQFxNhvhVHtt8T+A
	CrihPk4XiS4H8kWXflNvfEihfp8twOer4QAuBKRxDyN/85ii+ETzOwnVaPHJCAFGJtKHD7iu5r2
	MAWPJuYEi4zXrtXtg1ob9DOLI0eK/mnE4wZM9jCJDVPIWhN7l1XxBKvFTGt6svYBSStAf+WeL4S
	fBgpKNp8VVfKuNY+QKYdWrOvobg04CwNMXo890bb1D+vZu9e+bygXXXSYH6PGOeWJyZyA==
X-Google-Smtp-Source: AGHT+IELkxXy4dXj25hoHt7K6wCR+2fW9w4bJEKm+BZlWFP0UcOIGCcS7Emm1gOZ6sT74otzIxA/qQ==
X-Received: by 2002:a05:620a:44d5:b0:7b6:d1f6:3dc with SMTP id af79cd13be357-7be6321bf8cmr6759762985a.18.1737957470302;
        Sun, 26 Jan 2025 21:57:50 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79d9:f9b::18e:180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7be9aeedefesm355991085a.78.2025.01.26.21.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 21:57:48 -0800 (PST)
Date: Sun, 26 Jan 2025 21:57:46 -0800
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Josh Hunt <johunt@akamai.com>,
	Alexander Duyck <alexander.h.duyck@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] udp: gso: fix MTU check for small packets
Message-ID: <Z5cgWh/6bRQm9vVU@debian.debian>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
for small packets. But the kernel currently dismisses GSO requests only
after checking MTU on gso_size. This means any packets, regardless of
their payload sizes, would be dropped when MTU is smaller than requested
gso_size. Meanwhile, EINVAL would be returned in this case, making it
very misleading to debug.

Ideally, do not check any GSO related constraints when payload size is
smaller than requested gso_size, and return EMSGSIZE on MTU check
failure consistently for all packets to ease debugging.

Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 net/ipv4/udp.c                       | 18 ++++++++----------
 net/ipv6/udp.c                       | 18 ++++++++----------
 tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
 3 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c472c9a57cf6..9aed1b4a871f 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1137,13 +1137,13 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 	uh->len = htons(len);
 	uh->check = 0;
 
-	if (cork->gso_size) {
+	if (cork->gso_size && datalen > cork->gso_size) {
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
 		if (hlen + cork->gso_size > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
@@ -1158,15 +1158,13 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 			return -EIO;
 		}
 
-		if (datalen > cork->gso_size) {
-			skb_shinfo(skb)->gso_size = cork->gso_size;
-			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
-			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
-								 cork->gso_size);
+		skb_shinfo(skb)->gso_size = cork->gso_size;
+		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
+							 cork->gso_size);
 
-			/* Don't checksum the payload, skb will get segmented */
-			goto csum_partial;
-		}
+		/* Don't checksum the payload, skb will get segmented */
+		goto csum_partial;
 	}
 
 	if (is_udplite)  				 /*     UDP-Lite      */
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6671daa67f4f..6cdc8ce4c6f9 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1385,13 +1385,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 	uh->len = htons(len);
 	uh->check = 0;
 
-	if (cork->gso_size) {
+	if (cork->gso_size && datalen > cork->gso_size) {
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
 		if (hlen + cork->gso_size > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
@@ -1406,15 +1406,13 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 			return -EIO;
 		}
 
-		if (datalen > cork->gso_size) {
-			skb_shinfo(skb)->gso_size = cork->gso_size;
-			skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
-			skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
-								 cork->gso_size);
+		skb_shinfo(skb)->gso_size = cork->gso_size;
+		skb_shinfo(skb)->gso_type = SKB_GSO_UDP_L4;
+		skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(datalen,
+							 cork->gso_size);
 
-			/* Don't checksum the payload, skb will get segmented */
-			goto csum_partial;
-		}
+		/* Don't checksum the payload, skb will get segmented */
+		goto csum_partial;
 	}
 
 	if (is_udplite)
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 3f2fca02fec5..fb73f1c331fb 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -102,6 +102,13 @@ struct testcase testcases_v4[] = {
 		.gso_len = CONST_MSS_V4,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V4,
+		.gso_len = CONST_MSS_V4 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V4,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V4 + 1,
@@ -205,6 +212,13 @@ struct testcase testcases_v6[] = {
 		.gso_len = CONST_MSS_V6,
 		.r_num_mss = 1,
 	},
+	{
+		/* datalen <= MSS < gso_len: will fall back to no GSO */
+		.tlen = CONST_MSS_V6,
+		.gso_len = CONST_MSS_V6 + 1,
+		.r_num_mss = 0,
+		.r_len_last = CONST_MSS_V6,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V6 + 1,
-- 
2.30.2



