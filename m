Return-Path: <linux-kselftest+bounces-26795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE3A38AC3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 18:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530AB172F0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 17:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF1E22A80F;
	Mon, 17 Feb 2025 17:39:45 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B119E22A4D9;
	Mon, 17 Feb 2025 17:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813985; cv=none; b=NO7eqgsQhLRz8uTv2bFYmYI8ZYuqmOzM2dJkSO+pTf4sDcTHosvUuQITs67h6zSwwn10PxY6WLs7QPRSusexeJLxhBA81x7T2epghxu9WPvyHNJYFZnxnrVMI1lA/B1oPOzOSNksN+l5I9mYcel6qEA4VdAYUvUD6JwVGYKwqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813985; c=relaxed/simple;
	bh=wQKbgH/16KYErhD2+MqGDiWsCkrPGh3gbISR5a85Q24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeN6ULCuROT+S5qi6joufiXaNZOubxbawDyjEnTy7SiQWQI9q+W1zWNaKS/8H1DhO/jNL+YAr8UXZZjCxqxL9ntJZC7cZYR2VA7R7gJt3pBCOnt7DqJ0CzmNDHWZxV0hGc/Lya1F4UQGGA+JNRM7Smc+aSWGqYlA2RpQCtDOFBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-0001wf-Le; Mon, 17 Feb 2025 18:23:13 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tk4pt-000Opa-1F;
	Mon, 17 Feb 2025 18:23:13 +0100
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
Subject: [PATCH bpf-next v2 1/6] net: tun: enable XDP metadata support
Date: Mon, 17 Feb 2025 17:23:03 +0000
Message-ID: <20250217172308.3291739-2-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250217172308.3291739-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27552/Mon Feb 17 10:47:21 2025)

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
---
 drivers/net/tun.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 28624cca91f8..c95ab9c46bd2 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1713,7 +1713,7 @@ static struct sk_buff *tun_build_skb(struct tun_struct *tun,
 		u32 act;
 
 		xdp_init_buff(&xdp, buflen, &tfile->xdp_rxq);
-		xdp_prepare_buff(&xdp, buf, pad, len, false);
+		xdp_prepare_buff(&xdp, buf, pad, len, true);
 
 		act = bpf_prog_run_xdp(xdp_prog, &xdp);
 		if (act == XDP_REDIRECT || act == XDP_TX) {
@@ -2471,7 +2471,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 		}
 
 		xdp_init_buff(xdp, buflen, &tfile->xdp_rxq);
-		xdp_set_data_meta_invalid(xdp);
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
 		ret = tun_xdp_act(tun, xdp_prog, xdp, act);
-- 
2.43.0


