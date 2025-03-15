Return-Path: <linux-kselftest+bounces-29146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F50A63232
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 21:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C218A3B8AE4
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 20:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADBA1A08BC;
	Sat, 15 Mar 2025 20:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvtNczB4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE6019F127;
	Sat, 15 Mar 2025 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068861; cv=none; b=KfcvUs0Sht2j9S2EB1w6Sh52JU9e1/Viy+sjNOI3cwCN5xzyyVPTtsJvGNLDqjQzsMGB+R5H5lK5J/k3RQlAvp8k6awOdiKU5Sgxw5C/098TgAu/jyEV4l8Hj/jL8EOjwdZfCc8x5aMtWjOc008ViLNWPMwBAOEhUbolZZvqxUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068861; c=relaxed/simple;
	bh=WOvVk2IW6QUSaxpGvpwW6W6ywpdv9Y60/i896yobQ+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sgvcZt8Vi3uuJ3KmSLZf4fzQyUwB08Uqoy1PDeVYVdXaf8XSLyXsrHW51UMxoNhmI4ewQ2CeNRZEzbpUEHKhr8TITl5CTT5NgnUIkbQxRL2/KTHLmdurKZhk0lTqFa7m73rCSAMW0TplGzr2bQqS1xFR5nKvUX1thYa+kSV78/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvtNczB4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso587929966b.1;
        Sat, 15 Mar 2025 13:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068858; x=1742673658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=CvtNczB4hoVbwdIG4YkYzWfrZt9c8A2OA7c8mMkEme0i5bWuNn3/BBJrBXKldVmzqF
         lW9gBtCd7iTkDQfBu20AzjgnEvTs460FLbutTIUZWt+sEOYWOAb3uoAhsPGLv99j7h4z
         8HyygT30kesF++MC4Qt3h59selAH+nh1F7DtZxKmYSrDX1GDAYVw6gyGuhyxTeQzDj6x
         LWPrHD/aalQMGyy2vBZmiOujt4dV9eM9rNVbwho6fXE9w+2vMKknGIkRD2WUNEaneRZs
         Yd9jl4S8PEFPBk1KkR+aIcUNttgb41ryJFEKdmIEIYFAwjGpmBSLQtoItKY4YOutV1tj
         LH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068858; x=1742673658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ukwtTV0ExXBJKM7v4LhbJXSMG6hQJqW8GgzzDxNF23M=;
        b=kxsBN7++go5hqNBKpwpc2BObyZdVWg/A3WUJhK4CKvK6MvC1ZkOkAEANkoypuYcuIc
         c3psXTjSr96Nsqy14AJWvzPNKKrK95vyZDAQRImOoJ6NFXNwrfgUCi2i/vk9e2SO1Pqq
         Bq6OBYuiqfziGqEM0/vSjfklu0bcQqrjBzT1INlVjWSha0CBo4PrVPMEkVwecS+7IyCm
         ynZ4M8cyrw1+cLjGwFQLPFHE+wSrB5Gky3nKJSLHuZYetQMHNrs+DjswqruzkY6Ig+QP
         h8D+jEvlHRudvMWi6/fnjeFGTA8Zgn+56edFl8q8MHzN7+sl8nl+3+JXUOq2Tu6dc25r
         DnAw==
X-Forwarded-Encrypted: i=1; AJvYcCVX3n2fjH70jay+4T6GjzJrbDcFF/9NHw77oMI0HG3m4AtP/wK4XWHOtz7/qkztnDKAtnUIoFoc@vger.kernel.org, AJvYcCWAP0vkZNY7mp+ag1DH1b941K7cAcpZ6yNd0faZlvtQatbt+g30tEDY7yUNRZGoIQZ3hLIBw/nMxBO1zpzrvW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv6N8Q75yuFNlXoeSNVeNGo4/IYgvHOvkkIhCQdLDB4tW22Vc2
	ZPZZjSq8Tj3bOGR2Z24tl/wqPxNXTBw2NHRpYlljOKlqSDaqFkrM7PRXjA==
X-Gm-Gg: ASbGncuoLZi4T4vUsIQ3YPh+ZkjjcW/676Z2cOIXuSTttxaKDHWykI4o8FSbMcToXii
	7NNZY8piJEyGsaR7hasBDXXXNl//6CZfagdt8Alb8Ntkz4KV7xPCEsGWFQ+QCbYt6QqGWjqaGXr
	A+FMOxxviaC702rh3UCtWTKHarwQAVF17tS/CYrYjtr46+sXPrAQt9gPnNAVp6mQnqFXx4FAVt5
	aCgNmHyDXeC05IUBfEkqE6Nik6Jku+PrPMN6aDxyowMpSY29PjFy3hehjHrrW7Y6RXwbiSyxjRF
	BMOn9yklXsBkjZkPG5iHIwZniqj4v0wkIynJ9+06E0whzfXFsOeCRmuXQM/hKFBNFmO9gqHT/eX
	Avjs/6hhVO9JOXi10xHOk/LduJKn3TmBUTns0z7Qdz/GO05V/wY7ZnORmfGCph3E=
X-Google-Smtp-Source: AGHT+IHUG1k/HafScItz7647c4vgB0uWfWGe/KDk6+6POY+YOWwiV4SdbYmPp+R4rwe/RASZYCq8Yw==
X-Received: by 2002:a17:907:7290:b0:ab6:362b:a83a with SMTP id a640c23a62f3a-ac3301dd62cmr796461766b.8.1742068858019;
        Sat, 15 Mar 2025 13:00:58 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:57 -0700 (PDT)
From: Eric Woudstra <ericwouds@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v10 nf-next 2/3] netfilter: nft_chain_filter: Add bridge double vlan and pppoe
Date: Sat, 15 Mar 2025 21:00:32 +0100
Message-ID: <20250315200033.17820-3-ericwouds@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250315200033.17820-1-ericwouds@gmail.com>
References: <20250315200033.17820-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the capability to evaluate 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets in the bridge filter chain.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/netfilter/nft_chain_filter.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nft_chain_filter.c b/net/netfilter/nft_chain_filter.c
index 19a553550c76..7c7080c1a67d 100644
--- a/net/netfilter/nft_chain_filter.c
+++ b/net/netfilter/nft_chain_filter.c
@@ -232,11 +232,27 @@ nft_do_chain_bridge(void *priv,
 		    struct sk_buff *skb,
 		    const struct nf_hook_state *state)
 {
+	struct ethhdr *ethh = eth_hdr(skb);
 	struct nft_pktinfo pkt;
+	int thoff;
 
 	nft_set_pktinfo(&pkt, skb, state);
 
-	switch (eth_hdr(skb)->h_proto) {
+	switch (ethh->h_proto) {
+	case htons(ETH_P_PPP_SES):
+		thoff = PPPOE_SES_HLEN;
+		ethh += thoff;
+		break;
+	case htons(ETH_P_8021Q):
+		thoff = VLAN_HLEN;
+		ethh += thoff;
+		break;
+	default:
+		thoff = 0;
+		break;
+	}
+
+	switch (ethh->h_proto) {
 	case htons(ETH_P_IP):
 		nft_set_pktinfo_ipv4_validate(&pkt);
 		break;
@@ -248,6 +264,8 @@ nft_do_chain_bridge(void *priv,
 		break;
 	}
 
+	pkt.thoff += thoff;
+
 	return nft_do_chain(&pkt, priv);
 }
 
-- 
2.47.1


