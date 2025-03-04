Return-Path: <linux-kselftest+bounces-28128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DA6A4D027
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 01:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809E73ADB1E
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Mar 2025 00:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F301F55F2;
	Tue,  4 Mar 2025 00:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EGL94IzQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211971EDA1F
	for <linux-kselftest@vger.kernel.org>; Tue,  4 Mar 2025 00:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741048493; cv=none; b=neqNQmT58+j37+b6RyWv9fO69MoDKJOy7e/3lHeoFFemt7NVCUtast9twRw6a9MkAxKxl9RRtRJR0BDwn4vwnYpLtUuoW7qkDXUiCZ/7MwIPGgh+r4w7GQ8NWecRI9D2C0b3m3muhUeK0qxbCfGJAylHVJFWiKx4mNTE/lpJMCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741048493; c=relaxed/simple;
	bh=KE4nFZi9+ewgg8UnAQzYdDnB7CPQVdLbyMYR68tSCVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V6sFyZhDoB7H66RbSIKnNmXBjeUdmCG+Y+4YQaa3oyUKC/1u8Le1DF7JvR6f5+cKIKtm6GSClxvh6gIveDfjatznv1XpvrARA8bKfFDq3T/8ONr4t+eWhRpDRuHzbRwEiMZseiRPZ6iVP+5/4TtUfOXrriqA7apNaw4dmOo08eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EGL94IzQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-390fb1b987fso2918216f8f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Mar 2025 16:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741048489; x=1741653289; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dy6NXYodZRtf8WbzXv2Q+yMhslp3MYvd9LoEGdpq5Q=;
        b=EGL94IzQCPI0/n3HTzSMmEAaN8oTqXIhAq5XVDbNjPE7wHzrUR3KD4maANSRB7kZQv
         gXs1GpdR3K4Ulo9kmImm8/aL583LjgWE3NM54dJi2tRdiDeMkijPe+BM2B4dU+zqUMuK
         Ho0Ziba0++2g/ei+bOQ9ArGoGqbEQZb7fBU7FJLro2a1O6Ml5nMyJGunrtmiKjsCqokO
         y+asiAj1Vh0AuCNMGuW6hibVJe1yOaqbvfV7kKFpdztsmgL0XsXNGMt2Zptzqr0ErQai
         xbePgO/P95VtPUfUk8M42uxlPAu8rfvpjXO6jhmXCOK0OKh0fCHKBxGI3rrOEwEvshx5
         yRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741048489; x=1741653289;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dy6NXYodZRtf8WbzXv2Q+yMhslp3MYvd9LoEGdpq5Q=;
        b=jPOkFCLsa4TvESSFPT8g/Zp0jRS5n37R9HHHb0JhgW54dc/lZ4TbGJXBhLfJGHe4PV
         6gkyrJEEVmaNlcdCTC5HVeEz7MLEOwdzqlelib3skn756Dpb8mh+ZWXlm8D+PPgGxvnn
         /cNKyMgq1Q7XCJa9voa5opkyqdBL3sExnkECGpfmjtG6V9/3gD6r1lFNmgYQw6Py2guE
         Tupa7GkFt6My5MtAoFKGA3tEEj2wkXBxO+3/EOGMmo6yvxrOknXGMQSKP1L4/8jgdMvf
         3qCVXBjsqLNI/NdbGFWOO7UDC4NO5kq6+6IslK/b84yCo3x9DyZOqJCeawXFtKbhN7Gj
         W+KA==
X-Forwarded-Encrypted: i=1; AJvYcCW8ZfmYG7SglEfymhymqbQWZGBZoA6nW9tAPcwHI5FJj1qr6PAMvyDJesr4uYYUqy0MpgC2AahOG8HpS4kPlIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwozzOBmyM1WFjSw3x9tS35xDIKDJD2TTpoTnzeAijrybhf9qM3
	8qH1rXjEpEHfYGMfykHs6VV2s/AjmLjlCjXsezaebezG5KLQh6zWcff3JOdhqwA=
X-Gm-Gg: ASbGncvYL6nK3O2dfTB8rT6hqfygic/fem8oj4C5pxLgYlCcW7cXCKt+2hROuhvQQLj
	pNyfFjJ6wowGPrkzeLKpkhFhcAfKLYufusmK5a5gjUl7WN21gNOTblA7Y3KTbMGp7CmU6JLM0JJ
	gG/sXwwj8X/fto4Jmm4/BquoiQKAx3Z0xv3Xrmf+QV856IpW7AtZXePY7L/swBXdfvdTfjTFeDP
	wX97Xl1CDHBUF+CRH+OAt/Nbp5Y/5eTTOI28mucAX0n48l/wyKZKimwpKfuR74awhFeChRxlKXK
	FQx+VOKvbOBxdW6jq+/xPjndkiVbYYAVan+Dj1ZuqA==
X-Google-Smtp-Source: AGHT+IH4zQbpBYRUb2nti1hs1geBAHe6f+SGB1UtGfITZrhN4G0avmDqMY+AWJgsO7PAQgKOJ8NBnA==
X-Received: by 2002:a5d:47a5:0:b0:390:fe05:da92 with SMTP id ffacd0b85a97d-390fe05dc73mr5715615f8f.1.1741048489553;
        Mon, 03 Mar 2025 16:34:49 -0800 (PST)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:49fa:e07e:e2df:d3ba])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6d0asm15709265f8f.27.2025.03.03.16.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 16:34:49 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 04 Mar 2025 01:33:47 +0100
Subject: [PATCH v21 17/24] ovpn: add support for updating local UDP
 endpoint
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-ovpn-tmp-v21-17-d3cbb74bb581@openvpn.net>
References: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
In-Reply-To: <20250304-b4-ovpn-tmp-v21-0-d3cbb74bb581@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2830; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=KE4nFZi9+ewgg8UnAQzYdDnB7CPQVdLbyMYR68tSCVE=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnxkqPbdl4UhO21UKtL8lTdQSdS7u6cV5ic+Fsg
 CBsq3uA4fWJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ8ZKjwAKCRALcOU6oDjV
 h5seCAC3Nv+5EXx9LitOJ3Pqc/07dgBei4lmhflzMQ9voAi2BfozPE1JMbGb13h6T8w+Sq3kAzy
 z2oMBRdAp3LsnsPqObRbTQHKFX3f/ZBw5ZavwdiTW2lqhBgZYrzNovBohVQglnAo5oWrE9F9lEy
 wYof/9XW9dVgYcTXWqHxog7B5v1Kxn8JgQapKK6nRa6HZU5HLsBbNREAtJ/8w6Lnacrsift+F12
 J3zcZU33+89lPyXyvIFrRqrkkAi2BKjZz9udw72mnK/ttkv8fgKKxbKsL9Xn6QvYUfqKbevyhcj
 qTFHum9+ie5dJJtPyeeAkdGF+14rAwsoDFMZmPsdJ115Lze1
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

In case of UDP links, the local endpoint used to communicate with a
given peer may change without a connection restart.

Add support for learning the new address in case of change.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/peer.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/ovpn/peer.h |  3 +++
 2 files changed, 48 insertions(+)

diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
index 45e87ac155b554044388490a403f64c777d283a6..1803359b833d5797728566fb976e253e2a85ea75 100644
--- a/drivers/net/ovpn/peer.c
+++ b/drivers/net/ovpn/peer.c
@@ -522,6 +522,51 @@ static void ovpn_peer_remove(struct ovpn_peer *peer,
 	llist_add(&peer->release_entry, release_list);
 }
 
+/**
+ * ovpn_peer_update_local_endpoint - update local endpoint for peer
+ * @peer: peer to update the endpoint for
+ * @skb: incoming packet to retrieve the destination address (local) from
+ */
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb)
+{
+	struct ovpn_bind *bind;
+
+	rcu_read_lock();
+	bind = rcu_dereference(peer->bind);
+	if (unlikely(!bind))
+		goto unlock;
+
+	spin_lock_bh(&peer->lock);
+	switch (skb->protocol) {
+	case htons(ETH_P_IP):
+		if (unlikely(bind->local.ipv4.s_addr != ip_hdr(skb)->daddr)) {
+			net_dbg_ratelimited("%s: learning local IPv4 for peer %d (%pI4 -> %pI4)\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv4.s_addr,
+					    &ip_hdr(skb)->daddr);
+			bind->local.ipv4.s_addr = ip_hdr(skb)->daddr;
+		}
+		break;
+	case htons(ETH_P_IPV6):
+		if (unlikely(!ipv6_addr_equal(&bind->local.ipv6,
+					      &ipv6_hdr(skb)->daddr))) {
+			net_dbg_ratelimited("%s: learning local IPv6 for peer %d (%pI6c -> %pI6c\n",
+					    netdev_name(peer->ovpn->dev),
+					    peer->id, &bind->local.ipv6,
+					    &ipv6_hdr(skb)->daddr);
+			bind->local.ipv6 = ipv6_hdr(skb)->daddr;
+		}
+		break;
+	default:
+		break;
+	}
+	spin_unlock_bh(&peer->lock);
+
+unlock:
+	rcu_read_unlock();
+}
+
 /**
  * ovpn_peer_get_by_dst - Lookup peer to send skb to
  * @ovpn: the private data representing the current VPN session
diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
index e747c4b210642db990222986a80bb37c9a0413fe..d90ccc313cc3af24ffa6df8bb41bca15fbb022ad 100644
--- a/drivers/net/ovpn/peer.h
+++ b/drivers/net/ovpn/peer.h
@@ -153,4 +153,7 @@ bool ovpn_peer_check_by_src(struct ovpn_priv *ovpn, struct sk_buff *skb,
 void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout);
 void ovpn_peer_keepalive_work(struct work_struct *work);
 
+void ovpn_peer_update_local_endpoint(struct ovpn_peer *peer,
+				     struct sk_buff *skb);
+
 #endif /* _NET_OVPN_OVPNPEER_H_ */

-- 
2.45.3


