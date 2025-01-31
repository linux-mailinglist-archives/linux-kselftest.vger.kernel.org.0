Return-Path: <linux-kselftest+bounces-25481-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D84A23AA9
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 09:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7BC167A3F02
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2025 08:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216FB190692;
	Fri, 31 Jan 2025 08:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GYUQwEdQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C39176242
	for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 08:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738312306; cv=none; b=c6C/qnx90sOGtKtzW/wEU3uVhLKsUVvjs794BgwqJ8r1/2NoX6iY7Il0jX3zVgIpCwMGSi7IxolCbn3FngFF7p/THXevGmjGa1bBpOUaUOi1lXMarZdi/kI/RDb/u2HnHeYO7XFNut5Pgd16KdkeqatKm5lgXsRntEpNl028VMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738312306; c=relaxed/simple;
	bh=mLVZo1nn0u2stAiG+4QhFqVXxWnxquoZHj9Efr03O4g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EM1teBPpHrpnL2hKj8bqofmXzmWx6nDXD60Yx6DL8tmwQx5w/WlZUcWQx+wIWjaHoBHV+o+AY4tFcSo98TD8SOCaq0ca+v9HZbQvWeusFzEh/i5rvrYyM2cpORblw753Hfksh08citd0yVZjCeS5aykjInEieJNyiZPNI0xtDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GYUQwEdQ; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6eb531e13so93931885a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 31 Jan 2025 00:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738312303; x=1738917103; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iVTB8TWnA94KcBdPT26vLjAJb4R6rb8WNvZVBBonljQ=;
        b=GYUQwEdQgTr8tG8u+EMr4mRmKtxnqu+fFp9QQoU6rgTfQQe9Fc9xPKRwcfh2WzXzAG
         AQMOODBTxzxtB0BT2CzoxO1e3vct7UcPHDrPhyvWADYVrxXto0MfahZRue+sb73bCitb
         ONBFDb7pWCijWD4t3R6/tIbciZ1h/sCg8DpBLLjPpyfyAPjbiSbw3LxrwbevE+iA3nbh
         +nFItzdYpjajpKsu9tgDcSriVwSH3sxJXDg7R+N00Kem251SJ58TQQVFz4BXqJd3NjGg
         6gXBPXw+2jrrwEkkItWq6RWhwOTB1Q61sgKxskX9rqOuiyFmbdtUT/fR8nyPGLAH0FR8
         0vtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738312303; x=1738917103;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iVTB8TWnA94KcBdPT26vLjAJb4R6rb8WNvZVBBonljQ=;
        b=qDMz4NdzZSlr0T83gZiOW3F5dHouOGa5HFxfCjjURW0+aRTMwToA9sVWI5Hbp3Bv2Z
         LTj6gHv09drZftXev6lMTAolTwTkL3f5DmDNLRH9CvvcE08FzQnY/RYgsj9ACVVr6BNc
         dy0IHMv7ZimkfKUvLHDtxyew5Zec/l/1A+eKOMu2Iof54tutF1QvNt3p4c+v4wRK+Ofj
         45co9Fvbx9y1jFLjsFXSsG6yzM8jm9YI38EmMHUxwO9AwBooEB1wAFplEGLU6Stq91HI
         yFB3xvop2Kbb51SJaQouvbm+10Mb2GtfowXlxa3xLcoPs1DucYsiu7MAEiqNky6IFy05
         tCLw==
X-Forwarded-Encrypted: i=1; AJvYcCVv6z+MaOnPg2y5C2+36RtA6WKB3w4+ORAk0KrP1mWQtgjmiQKY9EGwSaNz7/TSmoMyXcVgNz4Jkf2ETvgv13Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5fSOSanypVXuwhOdbo2eMB7bAsYkQVnRfF4cSUm9aNMOuLXIx
	QHvMf+NOu0ImLLuB8oJd9yIz8Vj2MuXmOFWBnsJgIm56K1iNGDveJhRdT+g10QU=
X-Gm-Gg: ASbGncvvuGWYuQLH8X4Ywuo8tsF3GtN+q5wvneIdsGJnELWq6ddU2A0bydgQ5GPqGBD
	KDMIGGGMAdO9q6EB22cG8E+4uOctOIK8LGJ+3ytg6EVSpj9O5sbhv3gm6v6KdJ6CqgmMoKdUwJE
	7ttHHj5eLe/R9QjdRv2iB1AF1xjvMeXG7fNfiymdLPgrgGSqcjXquUqAKPFMiggwNpv8rbFczdu
	wo/sCaPr8NDVxQmXSJ/iSoVDbnLX6do+dXOd2bvzASfYWKnTRpkiB+ukWnz+naF9RkjYkIZCYAk
	UN0=
X-Google-Smtp-Source: AGHT+IECgy6pI27TV4mOjPfWNfcpUPo5je3fvGRUoMvMP18x9oJ1PwnxKMKsqqWESyJPQNOF9GWOug==
X-Received: by 2002:a05:620a:1911:b0:7b6:cd90:c0e1 with SMTP id af79cd13be357-7bffcd903b1mr1532377685a.37.1738312303155;
        Fri, 31 Jan 2025 00:31:43 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e254819f92sm15782546d6.48.2025.01.31.00.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 00:31:41 -0800 (PST)
Date: Fri, 31 Jan 2025 00:31:39 -0800
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
Subject: [PATCH v3 net] udp: gso: do not drop small packets when PMTU reduces
Message-ID: <Z5yKa7gz72+JEOXr@debian.debian>
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
Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
---
v2->v3: simplify the code; adding two test cases
v1->v2: add a missing MTU check when fall back to no GSO mode; Fixed up
commit message to be more precise.

v2: https://lore.kernel.org/netdev/Z5swit7ykNRbJFMS@debian.debian/T/#u
v1: https://lore.kernel.org/all/Z5cgWh%2F6bRQm9vVU@debian.debian/
---
 net/ipv4/udp.c                       |  4 ++--
 net/ipv6/udp.c                       |  4 ++--
 tools/testing/selftests/net/udpgso.c | 26 ++++++++++++++++++++++++++
 3 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index c472c9a57cf6..a9bb9ce5438e 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1141,9 +1141,9 @@ static int udp_send_skb(struct sk_buff *skb, struct flowi4 *fl4,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 6671daa67f4f..c6ea438b5c75 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1389,9 +1389,9 @@ static int udp_v6_send_skb(struct sk_buff *skb, struct flowi6 *fl6,
 		const int hlen = skb_network_header_len(skb) +
 				 sizeof(struct udphdr);
 
-		if (hlen + cork->gso_size > cork->fragsize) {
+		if (hlen + min(datalen, cork->gso_size) > cork->fragsize) {
 			kfree_skb(skb);
-			return -EINVAL;
+			return -EMSGSIZE;
 		}
 		if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
 			kfree_skb(skb);
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index 3f2fca02fec5..36ff28af4b19 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -102,6 +102,19 @@ struct testcase testcases_v4[] = {
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
+	{
+		/* MSS < datalen < gso_len: fail */
+		.tlen = CONST_MSS_V4 + 1,
+		.gso_len = CONST_MSS_V4 + 2,
+		.tfail = true,
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V4 + 1,
@@ -205,6 +218,19 @@ struct testcase testcases_v6[] = {
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
+	{
+		/* MSS < datalen < gso_len: fail */
+		.tlen = CONST_MSS_V6 + 1,
+		.gso_len = CONST_MSS_V6 + 2,
+		.tfail = true
+	},
 	{
 		/* send a single MSS + 1B */
 		.tlen = CONST_MSS_V6 + 1,
-- 
2.30.2



