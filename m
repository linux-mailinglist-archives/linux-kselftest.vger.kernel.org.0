Return-Path: <linux-kselftest+bounces-43796-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D12B2BFE110
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 21:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 460464FD298
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Oct 2025 19:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CB734FF49;
	Wed, 22 Oct 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJBR23m/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0734CFD5
	for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 19:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761161868; cv=none; b=GrcXYqgntiMBBRVVwfz8UawTtKbsP2P6+nhxnfwRu82cMvLIiysfVLD+uLdlQhR4xja+9lRER9YOovo3JjGGCqDL3VpsHVw/XwwrTP+Kpdwib5Gg4jdc7scuLgFbFu7zujkUrgLIZwx9pYlBcSDRyY65/ZSI4HzFYP4jNMpXaHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761161868; c=relaxed/simple;
	bh=ylW0lW+wuEzlGL+hHENqSKVEnatP0qVhMDiawJdeZVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtSU9u5X3GvhSMEPew9diqVNu+isDBAgSjwymXmW1pBao/m3M80BinzXzeznrwBKzpM1u+Q57awYBRHdjZ3pHbiMWN/DPoG0GZfl0/RkIBvq3oXWcTWP3jrZ/cvX5Mqob2EfDfMurkfNwq8NJhqMXeJYySCvLSKrT6Z6ASRofZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJBR23m/; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7847f4265e3so52486947b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Oct 2025 12:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761161865; x=1761766665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivCZW/5kdODw7DGks4Fdh9OvB5fw5w/Le7nkqaVGoCM=;
        b=iJBR23m/a/4iEfx19vRkNc2zjH2dI4ddBdOzyQVwf7Z06L/eDCj8P26vbEbpviy5mT
         oYRYXpGZ7KyvaDXcLxJH5pKYFmxVPk8e4pg9LIaO2GS/jnrVSG/I2onR/Ms3bzOSSS+O
         DzM+AOibYomae44qu75X+WQTJN23dNHRs8ekFHiJ7s8v+vg6NZC7N6pHrUz+NAxWllou
         /0gI7ZMSDmhM20kc5RsorE1N9Z2bsGaTc6aC9uCLShaAZX+ElgN0FfDndkM/c1d+5qE7
         RckNzQ7l6bLuvevHkF49AigpqNX9YYSaM9psf5rSQZiLyqOlfB4gGcfgSIAMOaviwwu6
         ElTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761161865; x=1761766665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivCZW/5kdODw7DGks4Fdh9OvB5fw5w/Le7nkqaVGoCM=;
        b=kqhIwQOFhS7YCLaX4iksRjlr50N3LrxU7Lwah3xnW/YzE+e3/ZL1ek8WecpWOh36k2
         ZQ3wJoCfptVmbbI+NE3uL5n7HvzG3jmLUAuGk/24K6V08klxLshR1Db0vtXQd/RwGmk8
         0MzuejeGC+htBfF1WmH/9XY/6GOCy1hFTsqS8trl2Qqo/RT6wB2YSaN4Ywumrt4Rcwra
         VIzJKU3Y1SMITgwSCgoAGHd58MdxnMHft+Al4bFgohD7ckyEZyOodZXC04RKOB3KGWnc
         xMxvTFJ6VDl76ZmolnvTczU7tD0T+jt3/WGmCFDIzHxN5Mzt7N2NCBKonfMt6ztFo2mH
         Be0w==
X-Forwarded-Encrypted: i=1; AJvYcCU5CUVv93dwNVeX4vvT2tTqMncFYJmQPQA6HBpM1Zfb4bnmofs3Of4hsw38wlC52HKLpN6uAeiymc/h1Vnpkvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCvFLV+eUDTwuxNnERosU71zq+gDd+B2tgOMNWq0FjkXQWa2va
	LxzT9SKgd7P5dqCt1bJLpwqSQ3YIpOK9PMIFJ4XiRqRokojxCkNJaVsm
X-Gm-Gg: ASbGnctU0TZScbsavJlf1N0Kou4zXp1hHv7kjnajHh+ap1BltV1R+/IwdmrhIPr4k7I
	iTLjZoCUjmmpZFG9lQ0UyXTrspspy4cmDqYHY2rjlvJI3GpmH9V6esYF04PUSh0v/li2yo7H2J8
	Qn4DdLCwGyfELOA2NkiLXXH4Q9BJzZeIn32DOBmG2btKGVZhJoDkzFZGpGQsv1inoLF2/jtQcYs
	8KO1RNC9lirsTl/LxoW+5pn/yypC8stq0W7wakq3BTf4rfJlCQrQ39W5AKzSv2oAmT3q/p+odth
	IvP+00NTsiNaA5jvDGgvpev/ufhNgRcOBlA36WwAw7HJGf8FLKivpgBTnqO/CYo7hCAG09JvPD6
	fT+fKjgS/6R5uypcsGTtrxSW6zZMf0ha3hjcBFjUjnw+tnTjFd8418kyEHV8eEtjecMP55DNR0Y
	/5V08m+VsG5g==
X-Google-Smtp-Source: AGHT+IGjCWGo1TAspfTDu45sSrwaWKqH3Wc9qY1tqCL28A1h73pipVf/1H81/xPqRvUVY3LjX8WpnQ==
X-Received: by 2002:a05:690c:6910:b0:785:28dd:2fee with SMTP id 00721157ae682-78528dd3420mr76741147b3.11.1761161865366;
        Wed, 22 Oct 2025 12:37:45 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:49::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd5e23e4sm369957b3.22.2025.10.22.12.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:37:44 -0700 (PDT)
From: Daniel Zahka <daniel.zahka@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Shuah Khan <shuah@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 5/5] netdevsim: implement psp device stats
Date: Wed, 22 Oct 2025 12:37:37 -0700
Message-ID: <20251022193739.1376320-6-daniel.zahka@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251022193739.1376320-1-daniel.zahka@gmail.com>
References: <20251022193739.1376320-1-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now only tx/rx packets/bytes are reported. This is not compliant
with the PSP Architecture Specification.

Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h |  5 +++++
 drivers/net/netdevsim/psp.c       | 27 +++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 02c1c97b7008..af6fcfcda8ba 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -109,6 +109,11 @@ struct netdevsim {
 	int rq_reset_mode;
 
 	struct {
+		u64 rx_packets;
+		u64 rx_bytes;
+		u64 tx_packets;
+		u64 tx_bytes;
+		struct u64_stats_sync syncp;
 		struct psp_dev *dev;
 		u32 spi;
 		u32 assoc_cnt;
diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
index 332b5b744f01..3912f2611862 100644
--- a/drivers/net/netdevsim/psp.c
+++ b/drivers/net/netdevsim/psp.c
@@ -70,6 +70,13 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
 		*psp_ext = skb->extensions;
 		refcount_inc(&(*psp_ext)->refcnt);
 		skb->decrypted = 1;
+
+		u64_stats_update_begin(&ns->psp.syncp);
+		ns->psp.tx_packets++;
+		ns->psp.rx_packets++;
+		ns->psp.tx_bytes += skb->len - skb_inner_transport_offset(skb);
+		ns->psp.rx_bytes += skb->len - skb_inner_transport_offset(skb);
+		u64_stats_update_end(&ns->psp.syncp);
 	} else {
 		struct ipv6hdr *ip6h __maybe_unused;
 		struct iphdr *iph;
@@ -164,12 +171,32 @@ static void nsim_assoc_del(struct psp_dev *psd, struct psp_assoc *pas)
 	ns->psp.assoc_cnt--;
 }
 
+static void nsim_get_stats(struct psp_dev *psd, struct psp_dev_stats *stats)
+{
+	struct netdevsim *ns = psd->drv_priv;
+	unsigned int start;
+
+	/* WARNING: do *not* blindly zero stats in real drivers!
+	 * All required stats must be reported by the device!
+	 */
+	memset(stats, 0, offsetof(struct psp_dev_stats, required_end));
+
+	do {
+		start = u64_stats_fetch_begin(&ns->psp.syncp);
+		stats->rx_bytes = ns->psp.rx_bytes;
+		stats->rx_packets = ns->psp.rx_packets;
+		stats->tx_bytes = ns->psp.tx_bytes;
+		stats->tx_packets = ns->psp.tx_packets;
+	} while (u64_stats_fetch_retry(&ns->psp.syncp, start));
+}
+
 static struct psp_dev_ops nsim_psp_ops = {
 	.set_config	= nsim_psp_set_config,
 	.rx_spi_alloc	= nsim_rx_spi_alloc,
 	.tx_key_add	= nsim_assoc_add,
 	.tx_key_del	= nsim_assoc_del,
 	.key_rotate	= nsim_key_rotate,
+	.get_stats	= nsim_get_stats,
 };
 
 static struct psp_dev_caps nsim_psp_caps = {
-- 
2.47.3


