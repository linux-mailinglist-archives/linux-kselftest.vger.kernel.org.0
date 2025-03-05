Return-Path: <linux-kselftest+bounces-28341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E27A50D9E
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F93F3AF38B
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0BE2571DC;
	Wed,  5 Mar 2025 21:35:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BB256C80;
	Wed,  5 Mar 2025 21:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210518; cv=none; b=qLhPLXcs+gTAcxvYKuTVsJRK7lbqS9H58JAs+1bSoEJ04R6b2T0j7nwKJeOIiYbrPKimDJnBYea2kVMh+7+r0Ie4Rrk3hqXeoLVqE1pUN/rxOmHhq+ZcFHCdggzazU0OB6YZzm5UGJ+U6Hj/0hRZfnKmx9b5XMvDhfX9it0ojdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210518; c=relaxed/simple;
	bh=HK9tUjpKjlh8AHpLnIYiP+IwFPaxfnXc6zK1qugt4s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzWwyWruTHus/a9LXCtiiBJ/yCQIdS5Gpf7kPoc5RvGWMZ/Puk7/BDd+koEalfU3bMEtVFWo5ReH5GxIcjWKcB8JiFmkezuQmcolzjxDY+ItLXHcwr7MwVzP6xVrvgnOeUZZdGQTbxUmFFqSeq/wURBCuU/SL8EQh9bfsIY0Zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000K1E-SX; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO1-000MHO-33;
	Wed, 05 Mar 2025 22:34:42 +0100
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowang@redhat.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v5 1/6] net: tun: enable XDP metadata support
Date: Wed,  5 Mar 2025 21:34:33 +0000
Message-ID: <20250305213438.3863922-2-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27568/Wed Mar  5 10:48:48 2025)

Enable the support for the bpf_xdp_adjust_meta helper function for XDP
buffers initialized by the tun driver. This allows to reserve a metadata
area that is useful to pass any information from one XDP program to
another one, for example when using tail-calls.

Whether this helper function can be used in an XDP program depends on
how the xdp_buff was initialized. Most net drivers initialize the
xdp_buff in a way, that allows bpf_xdp_adjust_meta to be used. In case
of the tun driver, this is currently not the case.

There are two code paths in the tun driver that lead to a
bpf_prog_run_xdp and where metadata support should be enabled:

1. tun_build_skb, which is called by tun_get_user and is used when
   writing packets from userspace into the device. In this case, the
   xdp_buff created in tun_build_skb has no support for
   bpf_xdp_adjust_meta and calls of that helper function result in
   ENOTSUPP.

   For this code path, it's sufficient to set the meta_valid argument of
   the xdp_prepare_buff call. The reserved headroom is large enough
   already.

2. tun_xdp_one, which is called by tun_sendmsg which again is called by
   other drivers (e.g. vhost_net). When the TUN_MSG_PTR mode is used,
   another driver may pass a batch of xdp_buffs to the tun driver. In
   this case, that other driver is the one initializing the xdp_buff.

   See commit 043d222f93ab ("tuntap: accept an array of XDP buffs
   through sendmsg()") for details.

   For now, the vhost_net driver is the only one using TUN_MSG_PTR and
   it already initializes the xdp_buffs with metadata support and
   sufficient headroom. But the tun driver disables it again, so the
   xdp_set_data_meta_invalid call has to be removed.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 drivers/net/tun.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index d8f4d3e996a7..cd463833a0ad 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1644,7 +1644,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		u32 act;
 
 		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
-		xdp_prepare_buff(&xdp, buf, pad, len, false);
+		xdp_prepare_buff(&xdp, buf, pad, len, true);
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
@@ -2368,7 +2368,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 		}
 
 		xdp_init_buff(xdp, buflen, &tfile->xdp_rxq);
-		xdp_set_data_meta_invalid(xdp);
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
-- 
2.43.0


