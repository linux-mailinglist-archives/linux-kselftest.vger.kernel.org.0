Return-Path: <linux-kselftest+bounces-29145-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8F8A6322C
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 21:01:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A038174350
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 20:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A054919F464;
	Sat, 15 Mar 2025 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+0PXWhc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC29819E804;
	Sat, 15 Mar 2025 20:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068860; cv=none; b=X7sWSS7M/+ZG+Q99EPZG0YlFlwRAlDS98OyxncFvs465Izew1BSA6hBlPSTZlezMUkD4x43z/NuuR/PMiJJwW2yFxVpDLF3aE+yrek2KYuRZYbSu971Vm8yfuf4IG9NAmM/JwKdK5rXhtXrS2dRCZBWWhBsXWv/vnmdnNZW77eE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068860; c=relaxed/simple;
	bh=uRS6L652Q8U04wSm9vVBsJo+AraqGWbdvUpqcrlUEAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Exm1oT46QdT/ZTZbyq9rFkOkDtsLaRLcKbUPZ8eUpsWAU/jDueBuH5nJvSJz6OIfdndimfREihvm78XsDndKd+5lhy3f0G/FSkdDxI9HU4AR6feD/6ldakwS/qqHYy8Tr29Qm1EbatBMkC9YoG9hckgjoiUcBx6fZpo6rwjYIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+0PXWhc; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7430e27b2so600888566b.3;
        Sat, 15 Mar 2025 13:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068857; x=1742673657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=C+0PXWhc5ryGLuZd5Z7aOjoFSGKTmC1AMk7eeOoCyZ7ID4/3A8Y5gvOQuodICEsi45
         CrRbDQz08c6zfJrCT/33PO9x73B++mXQ5bcXVPAyV5PjeArkKXGQoKlZq8cogPjLAwUP
         D2SdH1QboiAhPShPQeNE9+tshDHcAyfpJ6YTRoA8buzxRW5KYeh3xAcQsjhnEyxOBi5/
         eLWT3Hlsl+1UQB3IWfkTBDHirSjpzD82FLE2+phtVioZpbrQttWpRCp0esGX02ehJUqo
         6v0N3mulZ2NE77H/sI4IxzoZ26gwuze6mr0k1sYN0AIMc8zu6uVBuMl07AzUESCvpufo
         qlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068857; x=1742673657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWKZKslFax2kV4u5PDGKsv4N0lJQ1f1k8yO/foh+po0=;
        b=LIpeV0fGccxijkCWHjHzX3Y2cyYoE2L091MBYakNQIA44T+IF0nxgqE1uR31Zm3ltl
         Yluya/UROD+9R5StJucf0AjVJVWgXT2ch7GbyTkuSYVeKFYBTHJcgGVTviHW3xPN2gjV
         BGU9wshSL/G3CTxyX9vVNPWRGhSEyZl+L/d4NiZfk8rJd84lBDRV2ihe8tSkodjOOeLR
         vfu+Mkw6g7GjNhjju443F6H00TaBbkvr1GEHWpU/V9uDLY0jB251Uqnet1AV0imTAuEB
         W4bjKlNJIMkAEfWP4ZX5jQm1dfXClds55eY5f6HIpSEH9FmocFzzXKKM3AT4rYDB8a4z
         Zxpw==
X-Forwarded-Encrypted: i=1; AJvYcCUMhpZ0B2WC0Bk+mt8iomDb0Xzhgu0bnm8Z98LQ62Zxk2S7j51ShIXLwFxMZD+wa42TgDAOnB8L@vger.kernel.org, AJvYcCXYG3fFGLRDF2dw6yJf98+RRo/eZI8kKKaP6JITwz60Zy8wpT7kCYJxl3HYjW578TPwYzxC5taqXtf0GyaX6nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8rBECCrfKVLe37wMYhelWQY6fGJjdITONtCrYmfYhVi0tKwdG
	XMfVVTtbLCXKHQXdZ3Fif/PGnfshPKEPtURGTAG8GszaAr7tPtt1
X-Gm-Gg: ASbGncu4FxqavOm3ZjI834JO8X5/uBqCWZlIBXkhiuAiR7WhX3fAiIyexhtZAX8jSVn
	BFDKbs3/L2AriaC5y+ekzb6tJeFjQOqVJbiUCGN0MVHMaIr7CqkLdYUpIWeuMQ46/+9mpRwpyGC
	6IvBa9Ve8HOXUdJvj/WZYgK6o0+mSIB1H6Iwfh/n70Uk8vrcYsqeoi3O3STrUkYughiK+SnVrty
	caHFxZjuDI2p/+5ANQq+gSDl99+Sr6aSp40AOCQEa0mCqo3wsn39//6kFJYuzc/Px0Lx2Oynh/I
	0hkFGKPm542KFhrIDM1sM5sLqMIQW7AiQmMj9d7Y3n/LwTK4CYNGFwm3ZrM39hJzeQd7pTEEBon
	AXmO7Xg4EeFc8ICTeLIFf2gejPnIti8PtkCls+g8Ts/z6+KkOoumLGRf/n5quG5Y=
X-Google-Smtp-Source: AGHT+IHmdpDrN39o/IkwTJNEru1TccCo+dNGWNgs5Efv+MeU9fbRfzseyMtpshQDwMjKn08rtN8PEA==
X-Received: by 2002:a17:907:94c7:b0:ac2:1c64:b0a with SMTP id a640c23a62f3a-ac3301940d2mr675256966b.14.1742068856975;
        Sat, 15 Mar 2025 13:00:56 -0700 (PDT)
Received: from localhost.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9bc6sm405908066b.49.2025.03.15.13.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 13:00:55 -0700 (PDT)
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
Subject: [PATCH v10 nf-next 1/3] netfilter: bridge: Add conntrack double vlan and pppoe
Date: Sat, 15 Mar 2025 21:00:31 +0100
Message-ID: <20250315200033.17820-2-ericwouds@gmail.com>
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

This adds the capability to conntrack 802.1ad, QinQ, PPPoE and PPPoE-in-Q
packets that are passing a bridge.

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 net/bridge/netfilter/nf_conntrack_bridge.c | 83 ++++++++++++++++++----
 1 file changed, 71 insertions(+), 12 deletions(-)

diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index 816bb0fde718..4b4e3751fb13 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -242,53 +242,112 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 {
 	struct nf_hook_state bridge_state = *state;
 	enum ip_conntrack_info ctinfo;
+	int ret, offset = 0;
 	struct nf_conn *ct;
-	u32 len;
-	int ret;
+	__be16 outer_proto;
+	u32 len, data_len;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if ((ct && !nf_ct_is_template(ct)) ||
 	    ctinfo == IP_CT_UNTRACKED)
 		return NF_ACCEPT;
 
+	switch (skb->protocol) {
+	case htons(ETH_P_PPP_SES): {
+		struct ppp_hdr {
+			struct pppoe_hdr hdr;
+			__be16 proto;
+		} *ph;
+
+		offset = PPPOE_SES_HLEN;
+		if (!pskb_may_pull(skb, offset))
+			return NF_ACCEPT;
+		outer_proto = skb->protocol;
+		ph = (struct ppp_hdr *)(skb->data);
+		switch (ph->proto) {
+		case htons(PPP_IP):
+			skb->protocol = htons(ETH_P_IP);
+			break;
+		case htons(PPP_IPV6):
+			skb->protocol = htons(ETH_P_IPV6);
+			break;
+		default:
+			nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
+			return NF_ACCEPT;
+		}
+		data_len = ntohs(ph->hdr.length) - 2;
+		skb_pull_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		break;
+	}
+	case htons(ETH_P_8021Q): {
+		struct vlan_hdr *vhdr;
+
+		offset = VLAN_HLEN;
+		if (!pskb_may_pull(skb, offset))
+			return NF_ACCEPT;
+		outer_proto = skb->protocol;
+		vhdr = (struct vlan_hdr *)(skb->data);
+		skb->protocol = vhdr->h_vlan_encapsulated_proto;
+		data_len = U32_MAX;
+		skb_pull_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		break;
+	}
+	default:
+		data_len = U32_MAX;
+		break;
+	}
+
+	ret = NF_ACCEPT;
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		if (!pskb_may_pull(skb, sizeof(struct iphdr)))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		len = skb_ip_totlen(skb);
+		if (data_len < len)
+			len = data_len;
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		if (nf_ct_br_ip_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV4;
 		ret = nf_ct_br_defrag4(skb, &bridge_state);
 		break;
 	case htons(ETH_P_IPV6):
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		if (data_len < len)
+			len = data_len;
 		if (pskb_trim_rcsum(skb, len))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		if (nf_ct_br_ipv6_check(skb))
-			return NF_ACCEPT;
+			goto do_not_track;
 
 		bridge_state.pf = NFPROTO_IPV6;
 		ret = nf_ct_br_defrag6(skb, &bridge_state);
 		break;
 	default:
 		nf_ct_set(skb, NULL, IP_CT_UNTRACKED);
-		return NF_ACCEPT;
+		goto do_not_track;
 	}
 
-	if (ret != NF_ACCEPT)
-		return ret;
+	if (ret == NF_ACCEPT)
+		ret = nf_conntrack_in(skb, &bridge_state);
 
-	return nf_conntrack_in(skb, &bridge_state);
+do_not_track:
+	if (offset) {
+		skb_push_rcsum(skb, offset);
+		skb_reset_network_header(skb);
+		skb->protocol = outer_proto;
+	}
+	return ret;
 }
 
 static unsigned int nf_ct_bridge_in(void *priv, struct sk_buff *skb,
-- 
2.47.1


