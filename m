Return-Path: <linux-kselftest+bounces-25410-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E737EA22952
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 08:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F48A1886E38
	for <lists+linux-kselftest@lfdr.de>; Thu, 30 Jan 2025 07:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DBF1A4F2F;
	Thu, 30 Jan 2025 07:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QxjwJ781"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FA198E84
	for <linux-kselftest@vger.kernel.org>; Thu, 30 Jan 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738223762; cv=none; b=lVDAheBCLSPuEtzmpxJ+RcWOusoHZKUvUczwxetQ2npTN5kg3k8Vi4KmhfS330thrTesc6lXOlVb+weotebCI10Mw7yZBjmKtsixC+RCYh2hQqAsipebgMjx1sPpKz/Uw7/Ohais0lz6wjh9QpsJH4dzvXsroUhbI+/z4zV6lb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738223762; c=relaxed/simple;
	bh=SahFX2KFPBl9owsYWpi3lFqwrzYFVVWPeBWDKwYl7dY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=joUfjcPOyv22cxjz6LuuH5K1D6L535v1b8F+JiULDZSN3tyXeDndmh2/jI3HORuwQzivVdR/UI83eV7NBBH9h084sRzFv+aDRcfitjYrJ7brJOzSnxbj6S1HX6UQ9srLF4vLmAXqJt8s1NM0k9WNxNkc3xaXsFRLsrdm6OtAqTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QxjwJ781; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8fd060e27so3626296d6.1
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 23:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738223759; x=1738828559; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1G1O7K0l1YuMoDNXIHAxVpiayqI4GueBHWvDpZUuxvg=;
        b=QxjwJ781O7A3L4H5brsS5E19B6LR+OGFPU1AjkleyJxCxO0nTRr3ztnssO5/76IHfU
         RFy9Sn6BiCU2AP6zSELLLtL7WSCqmqX9T72PxUu89kv7AoipTPkBBs99kLfD36AsvVPV
         LiFboZlrooUhS/hrCcO9ocK88ZSHCMkwm1w+eXGQ8gveHRaHgsZ/Z3OuecFLurcWLGeC
         lOGfRV4AfEmjGhr4wB08HxsWzN0LTtdl5xgB9oj/NJpeEc02xYgeKp/9eevazld5PjKd
         26C+eFfpMbZX44e6vwBl6w0rccqdsPvVaDrFT3gKy63+xjLc02lxbtQJ+h/aCQZLBJkc
         Vc3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738223759; x=1738828559;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1G1O7K0l1YuMoDNXIHAxVpiayqI4GueBHWvDpZUuxvg=;
        b=Qj+aJEVyiQW5PISjH3zkHNGgDfL3NWGoECi74+GapBBPE1KJfa1kyLp0qtOvCkZuLx
         L4Rfxo4DC8cVJFr9t9vhFUZ7Xo61lrEjX7zrT/Lr5jO8vWw97EawTOMlBp5u+SaQizUj
         CO+GR7zPLDCNiinTWFqfScQT1mQcVGsmvN0FueFL5svHITTaNcf57vO+KiwTUOSyQ1r/
         uBeSs0g5Xoxz9CmekRF1oW8AZhdDTFkZD6RPfZhtJ6GkXkJ+2rkK5K4QIK5kFH4tZbGI
         g9UPkvN9Q1tJDgXnFysnaCUImcELfdQz9oxsmZ0RWSrouDxWHOvtrV9SZ0cD8+zw/oSd
         jQag==
X-Forwarded-Encrypted: i=1; AJvYcCWC98zZQ3wegRE3/vl6I78bRbaqQE2x8TmwUQbxlmxoR2EcnJzI+LbXEV2aWd++bBlgHgLtAHKvK6lD4GvMEdE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiydlz83kHui/pTZLKiBeuz2hfUFMYT7qTwo9/eOxrG5xOI3q
	cWiCmdQzpzw5152W+VE4KA+jqimhU3NV4SigvttrdAh0FMg0nxXgqntuaS0Rk6o=
X-Gm-Gg: ASbGnctauE3reUmQN9uBPPkV3RAI8DFz9eNdv+mfCVV0ZFtACtV3Fhn1jLQjgOK9Fxe
	dDhhAJq7dYYLctjuvybyIOXrVhFkoHRq6kdfA8V5depf+/YA27tzlZcx5+NRpVp/Vps+8x1guS4
	MLFe7s1pY7aSXSlN9C/Iz6lmlH59a695l3giJdlE2XAUtCUTHG/1cQNfMlETnvPxWF3GIqeG86v
	8jgK35aMWpHCebyPtlGaLxV7JiBfgnX7Ul2EmvWDafxRty6rtwmjyM0NvCATCnHbFJOWIfGS3i5
	2kI=
X-Google-Smtp-Source: AGHT+IH3PTHfqvB2vqnMrZMRHGh6PBHBVrM91TtJJ09yAJbOCgQlAe8MytjqcZnxZHDIm0iRGYObCg==
X-Received: by 2002:a05:6214:19eb:b0:6d4:1e43:f3a5 with SMTP id 6a1803df08f44-6e243c15524mr94797886d6.13.1738223758452;
        Wed, 29 Jan 2025 23:55:58 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254819f92sm3656896d6.48.2025.01.29.23.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2025 23:55:57 -0800 (PST)
Date: Wed, 29 Jan 2025 23:55:54 -0800
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
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
Subject: [PATCH v2 net] udp: gso: do not drop small packets when PMTU reduces
Message-ID: <Z5swit7ykNRbJFMS@debian.debian>
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
after checking MTU/PMTU on gso_size. This means any packets, regardless
of their payload sizes, could be dropped when PMTU becomes smaller than
requested gso_size. We encountered this issue in production and it
caused a reliability problem that new QUIC connection cannot be
established before PMTU cache expired, while non GSO sockets still
worked fine at the same time.

Ideally, do not check any GSO related constraints when payload size is
smaller than requested gso_size, and return EMSGSIZE instead of EINVAL
on MTU/PMTU check failure to be more specific on the error cause.

Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
Signed-off-by: Yan Zhai <yan@cloudflare.com>
--
v1->v2: add a missing MTU check when fall back to no GSO mode suggested
by Willem de Bruijn <willemdebruijn.kernel@gmail.com>; Fixed up commit
message to be more precise.

v1: https://lore.kernel.org/all/Z5cgWh%2F6bRQm9vVU@debian.debian/
---
 net/ipv4/udp.c                       | 28 +++++++++++++++++++---------
 net/ipv6/udp.c                       | 28 +++++++++++++++++++---------
 tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
 3 files changed, 52 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c472c9a57cf6..0b5010238d05 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1141,9 +1141,20 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
+		if (datalen <= cork->gso_size) {
+			/*
+			 * check MTU again: it's skipped previously when
+			 * gso_size != 0
+			 */
+			if (hlen + datalen > cork->fragsize) {
+				kfree_skb(skb);
+				return -EMSGSIZE;
+			}
+			goto no_gso;
+		}
 		if (hlen + cork->gso_size > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
@@ -1158,17 +1169,16 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
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
 
+no_gso:
 	if (is_udplite)  				 /*     UDP-Lite      */
 		csum = udplite_csum(skb);
 
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6671daa67f4f..d97befa7f80d 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1389,9 +1389,20 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
+		if (datalen <= cork->gso_size) {
+			/*
+			 * check MTU again: it's skipped previously when
+			 * gso_size != 0
+			 */
+			if (hlen + datalen > cork->fragsize) {
+				kfree_skb(skb);
+				return -EMSGSIZE;
+			}
+			goto no_gso;
+		}
 		if (hlen + cork->gso_size > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
@@ -1406,17 +1417,16 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
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
 
+no_gso:
 	if (is_udplite)
 		csum = udplite_csum(skb);
 	else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
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



