Return-Path: <linux-kselftest+bounces-6048-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37081874FF2
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 14:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C697B21112
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 13:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4533612C7EC;
	Thu,  7 Mar 2024 13:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzsIZS2o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3C8126F3E;
	Thu,  7 Mar 2024 13:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818100; cv=none; b=Xrm4WJ+zNS7N9+gWH7bsaiRB+bnRafU+CAjLU/ON2l779FsljGD8qnJlyIgJKzkcSYGYCifijcOPTJQxUjAsMujRDxNTiRwhxX1QSeqDyYLPQjEwkSXsVKSn5Xmhx5ULXeFzw4z0diR5hJy5zEdCNIlOZKygrvP3dwnlQntbf6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818100; c=relaxed/simple;
	bh=H34phMo1Atfx0irKNYHu1Z0c09BKNGoKMtu7ACfIvfs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=QH6p8dm3JbgqN4+kxp4MAnQLgaSog3R0GksPULI1UQwRPuIkY1mS9/feKbDl27QV6eB34Gh/DjSNqDFRtKH4Xah0Iv1CwaWXNVxKboqDMY41uF2NC2VaYTcwvrQBN2aS29hKIARxlM84i4+PfvupWaBdWYEmvYvMhXt7JEoT1Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzsIZS2o; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4130fefef75so4794335e9.2;
        Thu, 07 Mar 2024 05:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709818097; x=1710422897; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zug56gnYP4edUOhon4euq+t2Tt8A1M9UWWLis3j8gVE=;
        b=kzsIZS2ovw+OvfiZEzSo9FQbCtgF6TzN2Ab/muH+M76lcfWJeiq/46VTHOEd7Oj0rl
         cDX/qY/MPvWnDUdTmcIbr+23wPa5Oh2yxmbNKw9IsaBMOu39KjVifvZv9m/fJIp7It5j
         Q7WEyp9iSkcI3kn1SlPQz9pgostiHoJivhNhorJK++NMx6asF9NgOJcnR8h/ZS8/dOWw
         s5so5r+uLquSo98vL7BllE8v4BF2bRg4XPvcRkT1sEigQNLyVpzKGhhaaKPdn60kvsBO
         hBV7Y0w6kzvXmf9+nxgRmva/sXUixlD41zfHGYSGwI38zjDggZRw/KJM6gGxQWNg1OWY
         b8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818097; x=1710422897;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zug56gnYP4edUOhon4euq+t2Tt8A1M9UWWLis3j8gVE=;
        b=uFWFHf9Sa9nOieAAf410YTVMxvTe4JYSC9iRmiVl0LaFXuPyti2RG/O8/Sf+nbrbqh
         kJ74yMhkq+GJpTjIaj4+rMJWrRwlY4xGVrWcP7CaBDEFrNLmqMJjnYGSrw0mTPfciojP
         YF1mvGTvk4zeDsPYq/fKdLoHkizyqPA3UDdJw08knIclrw66nSKAj5RmFlwQ8At+SZHF
         mTfFVBW6PhhAjo9rrpj1vrmhi0idTM4wJ1DTiW5emkXd2NQ+1OYeRPbguoUDwnuL+HuF
         iJmf6FjJv9Elr+SbXpZtFQ2/VDvJSP2d2zThev0IkqUiIxOB1UaYxUQ/qfrzPyF7Deyb
         MnmA==
X-Forwarded-Encrypted: i=1; AJvYcCU2BVMSE8JWavGY6RsWeJKHVCnPZaobZE804GSvViTInGbdNIjhIMvy9oQo3G2rlmtIYAiXTjzFN86DGkcIV1lUjJoeQ2JCS8XlawS4VqO3ycNQiuTnwnTJcWTuGk28npaALLkKr72SmjKWoyYlVFhbwyZAN0qhnjQz4l1VXH3zAxB7xeUs
X-Gm-Message-State: AOJu0YxkoW28eoZA876IWWAnAMERNaxEtzaW2+pEVWwvakpD9Vl90E8Q
	I9qfuGi724dSiccF2Aneq5qcg9lN+eQRukQzoR2ObEXJOvXtbUbS9hrfUNnV
X-Google-Smtp-Source: AGHT+IGh3WGkG/RgtYYGwrcgMs+hylyeHFtt14ZtJd16Kp4hzp7Ye9HMJxibeHbkttCrryZVNrvBaA==
X-Received: by 2002:a05:600c:4fc3:b0:412:dc02:9824 with SMTP id o3-20020a05600c4fc300b00412dc029824mr10426997wmq.9.1709818096732;
        Thu, 07 Mar 2024 05:28:16 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id m37-20020a05600c3b2500b0041312c0cc45sm1208587wms.0.2024.03.07.05.28.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 05:28:16 -0800 (PST)
Message-ID: <2076d2ff-cd17-4ab0-b1db-4875d96bf9a6@gmail.com>
Date: Thu, 7 Mar 2024 14:27:54 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next v2 3/4] net: gro: set inner_network_header in receive
 phase
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, dsahern@kernel.org,
 shuah@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
In-Reply-To: <2ce1600b-e733-448b-91ac-9d0ae2b866a4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch sets network_header and inner_network_header to their respective
values during the receive phase of GRO. This allows us to use
inner_network_header later on in GRO. network_header is already set in
dev_gro_receive and under encapsulation inner_network_header is set.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 13 +++++++++++--
 net/8021q/vlan_core.c  |  5 +++++
 net/ethernet/eth.c     |  1 +
 net/ipv4/af_inet.c     |  9 ++-------
 net/ipv4/gre_offload.c |  1 +
 net/ipv6/ip6_offload.c | 12 +++++-------
 6 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
index 7515e6bcbb7d..db27b6851360 100644
--- a/net/ethernet/eth.c
+++ b/net/ethernet/eth.c
@@ -441,6 +441,7 @@ struct sk_buff *eth_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	skb_gro_pull(skb, sizeof(*eh));
 	skb_gro_postpull_rcsum(skb, eh, sizeof(*eh));
+	skb_set_inner_network_header(skb, skb_gro_offset(skb));
 
 	pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
 					    ipv6_gro_receive, inet_gro_receive,
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 9334b563a88b..09ab9ac4420b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1567,10 +1567,6 @@ struct sk_buff *inet_gro_receive(struct list_head *head, struct sk_buff *skb)
 
 	NAPI_GRO_CB(skb)->is_atomic = !!(iph->frag_off & htons(IP_DF));
 	NAPI_GRO_CB(skb)->flush |= flush;
-	skb_set_network_header(skb, off);
-	/* The above will be needed by the transport layer if there is one
-	 * immediately following this IP hdr.
-	 */
 
 	/* Note : No need to call skb_gro_postpull_rcsum() here,
 	 * as we already checked checksum over ipv4 header was 0
@@ -1596,6 +1592,7 @@ static struct sk_buff *ipip_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	skb_set_inner_network_header(skb, skb_gro_offset(skb));
 
 	return inet_gro_receive(head, skb);
 }
@@ -1648,10 +1645,8 @@ int inet_gro_complete(struct sk_buff *skb, int prior_off, int nhoff)
 	int proto = iph->protocol;
 	int err = -ENOSYS;
 
-	if (skb->encapsulation) {
+	if (skb->encapsulation)
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IP));
-		skb_set_inner_network_header(skb, nhoff);
-	}
 
 	iph_set_totlen(iph, skb->len - nhoff);
 	csum_replace2(&iph->check, totlen, iph->tot_len);
diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
index d4520c3f7c09..bfc3a0cbb3a3 100644
--- a/net/ipv4/gre_offload.c
+++ b/net/ipv4/gre_offload.c
@@ -224,6 +224,7 @@ static struct sk_buff *gre_gro_receive(struct list_head *head,
 	/* Adjusted NAPI_GRO_CB(skb)->csum after skb_gro_pull()*/
 	skb_gro_postpull_rcsum(skb, greh, grehlen);
 
+	skb_set_inner_network_header(skb, skb_gro_offset(skb));
 	pp = call_gro_receive(ptype->callbacks.gro_receive, head, skb);
 	flush = 0;
 
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index e3a05b84c76a..29601be9fa90 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -67,7 +67,7 @@ static int ipv6_gro_pull_exthdrs(struct sk_buff *skb, int off, int proto)
 		off += len;
 	}
 
-	skb_gro_pull(skb, off - skb_network_offset(skb));
+	skb_gro_pull(skb, off - skb_gro_network_offset(skb));
 	return proto;
 }
 
@@ -236,8 +236,6 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	if (unlikely(!iph))
 		goto out;
 
-	skb_set_network_header(skb, off);
-
 	flush += ntohs(iph->payload_len) != skb->len - hlen;
 
 	proto = iph->nexthdr;
@@ -259,7 +257,7 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_receive(struct list_head *head,
 	NAPI_GRO_CB(skb)->proto = proto;
 
 	flush--;
-	nlen = skb_network_header_len(skb);
+	nlen = skb_gro_offset(skb) - off;
 
 	list_for_each_entry(p, head, list) {
 		const struct ipv6hdr *iph2;
@@ -327,6 +325,7 @@ static struct sk_buff *sit_ip6ip6_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	skb_set_inner_network_header(skb, skb_gro_offset(skb));
 
 	return ipv6_gro_receive(head, skb);
 }
@@ -342,6 +341,7 @@ static struct sk_buff *ip4ip6_gro_receive(struct list_head *head,
 	}
 
 	NAPI_GRO_CB(skb)->encap_mark = 1;
+	skb_set_inner_network_header(skb, skb_gro_offset(skb));
 
 	return inet_gro_receive(head, skb);
 }
@@ -355,10 +355,8 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb,
 	u32 payload_len;
 	int nhlen;
 
-	if (skb->encapsulation) {
+	if (skb->encapsulation)
 		skb_set_inner_protocol(skb, cpu_to_be16(ETH_P_IPV6));
-		skb_set_inner_network_header(skb, nhoff);
-	}
 
 	payload_len = skb->len - nhoff - sizeof(*iph);
 	if (unlikely(payload_len > IPV6_MAXPLEN)) {
diff --git a/include/net/gro.h b/include/net/gro.h
index cb7282bf3d63..923cbcc4c2fa 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -171,12 +171,21 @@ static inline void *skb_gro_header(struct sk_buff *skb, unsigned int hlen,
 	return ptr;
 }
 
+static inline int skb_gro_network_offset(const struct sk_buff *skb)
+{
+	const u32 mask = NAPI_GRO_CB(skb)->encap_mark - 1;
+
+	return (skb_network_offset(skb) & mask) | (skb_inner_network_offset(skb) & ~mask);
+}
+
 static inline void *skb_gro_network_header(const struct sk_buff *skb)
 {
+	const int offset = skb_gro_network_offset(skb);
+
 	if (skb_gro_may_pull(skb, skb_gro_offset(skb)))
-		return skb_gro_header_fast(skb, skb_network_offset(skb));
+		return skb_gro_header_fast(skb, offset);
 
-	return skb_network_header(skb);
+	return skb->data + offset;
 }
 
 static inline __wsum inet_gro_compute_pseudo(const struct sk_buff *skb,
diff --git a/net/8021q/vlan_core.c b/net/8021q/vlan_core.c
index 247704cf70af..a61bfcff6250 100644
--- a/net/8021q/vlan_core.c
+++ b/net/8021q/vlan_core.c
@@ -478,6 +478,11 @@ static struct sk_buff *vlan_gro_receive(struct list_head *head,
 	if (unlikely(!vhdr))
 		goto out;
 
+	if (NAPI_GRO_CB(skb)->encap_mark)
+		skb_set_inner_network_header(skb, hlen);
+	else
+		skb_set_network_header(skb, hlen);
+
 	type = vhdr->h_vlan_encapsulated_proto;
 
 	ptype = gro_find_receive_by_type(type);
-- 
2.36.1

