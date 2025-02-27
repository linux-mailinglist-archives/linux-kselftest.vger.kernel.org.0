Return-Path: <linux-kselftest+bounces-27763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805FA48109
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CFA3A974B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B77B2233D7B;
	Thu, 27 Feb 2025 14:23:50 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C689522FF44;
	Thu, 27 Feb 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666230; cv=none; b=h59bi6RgXv5hEhAWzW49F35ZpHzBVtu/bD4hlnDeY6llsj9d6Yz/SyDeddlKzbJLmCDoTIwiwj0bP/ESShRQfZjEUDj5xnWQ00GSGo1dwn8GkR5HcqnT431y8mrjV31TNfRftoZHSwZildugj0o6O6NKQy7as+mgxStHz+6ogzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666230; c=relaxed/simple;
	bh=O1jqIhih0khqRmLUd7meOzR1XpmI7T4vdcXWxTYYyCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhwqZQjj4OHqjdHvIfpnDiAHA+ISUJaWRJewVWyLL/APM982K7F7cX8Rhph1gIdRXWXmIYBPX9pj6DiQaGqIcq29YRhisAHt0zBEH+VbbcEIRFvjEglA1/QOsuhBOGZLQcUEwsDGfo5PAbUdQ1NZg1QIJPtQeGQCeU8KAvV9ItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-0005ES-NL; Thu, 27 Feb 2025 15:23:33 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-000B1d-2m;
	Thu, 27 Feb 2025 15:23:33 +0100
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
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v4 1/6] net: tun: enable XDP metadata support
Date: Thu, 27 Feb 2025 14:23:25 +0000
Message-ID: <20250227142330.1605996-2-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27562/Thu Feb 27 10:48:50 2025)

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
index acf96f262488..4ec8fbd93c8d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1709,7 +1709,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		u32 act;
 
 		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
-		xdp_prepare_buff(&xdp, buf, pad, len, false);
+		xdp_prepare_buff(&xdp, buf, pad, len, true);
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
@@ -2467,7 +2467,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 		}
 
 		xdp_init_buff(xdp, buflen, &tfile->xdp_rxq);
-		xdp_set_data_meta_invalid(xdp);
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
-- 
2.43.0


