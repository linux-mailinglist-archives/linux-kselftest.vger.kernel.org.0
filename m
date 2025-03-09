Return-Path: <linux-kselftest+bounces-28562-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D276A5849B
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 14:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6657A5089
	for <lists+linux-kselftest@lfdr.de>; Sun,  9 Mar 2025 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBFA1DC04A;
	Sun,  9 Mar 2025 13:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlCOSR9q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C122F15E5DC;
	Sun,  9 Mar 2025 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741527834; cv=none; b=q6RF5vx/IviSJARJwxkr3I4rSihEmEPO77LziViQZaZtBGhFxzr6LA5BJ2RtkLWDnflbBBhpvkTMbuNTG6hmZqsnLFaNYdCEnVGgYdxspT3DRzPNLMjGLRf/4KtIcyw8UeBEDCYLo58/G9l7OLkjIV6S6rHrFxALTCxWqGxIJC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741527834; c=relaxed/simple;
	bh=lQ5S/kN0Y9lAPBWG/yhiZ9p9p0eQ1F0mtQlFxflp1OU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dJR5G2AgbHJWAaU3URsVIHy/YRkVq3IaU35O6PFdpwTzHHr6J9vtwDpYb95+9ANHPsijr6rEIUCA9uE4aSJ4yEiLaJ9xg6rp0UxnWW76RCYhJ04do/vBkaMWiz4lWEFeMAUJtbaFEEuJjFQ1QA3osIC3RIMDUfNk0gjVj6897Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlCOSR9q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224341bbc1dso29251835ad.3;
        Sun, 09 Mar 2025 06:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741527832; x=1742132632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU2SZskl0GXhd/8iJGI8QszFt2TGbZrtsEMkr1I4oGI=;
        b=XlCOSR9qDB9FjXRQp3Mh1nqc+qJ5iRrfn0RQ6DQlQTtjBvl7b/2oKa/0yVoQOTYHyB
         bzDNv9dg/hyx1N0WivWW0d9MDoqDGAAqvsDnXcpIkr98oW0f5UchhrCI6poQ7h+A+ama
         O7pB9wLPjjM+mcVAq2J/rg+z7RB1M8WRd6FgUELRU7/pIDiKf2LvCQG7NvBGnr3sKyy7
         p16hlfVm4OwSe8bGAngyl8ReU9lG5MWEf/Nh6XpaYed1aiYn+RNBpgTYaZieKCe+hT+Y
         0cH9Uo9iStntU//HE+OwtJtmbAMyzgpTHJ0uiQ/hYvFv5WC37DdiM/X/tl72dfaiyL73
         Xc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741527832; x=1742132632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qU2SZskl0GXhd/8iJGI8QszFt2TGbZrtsEMkr1I4oGI=;
        b=wByEmme6kdphdGua/bagqx/+W9/EiuVbb+JvyEjvfn9gQm6/USGJtp+sFo9w5rFFf+
         ecJ6e88c/UOX8d5SAeg8fWsWfZGZbaI5XGDrfNycpPX5R4lybJgLD43RpK5p4UCQ/OvZ
         dGCLLEuZsADDEndvfXx1W80R60TUEQZcOtn/cuX3PdZdDXuZlJN9xjWcbE0AfFAVHfEh
         HArQvCWntPmvVkI4dR3bHSCdYsycivd1YFWmRyrPe7NK9PiEJlqh9k5aA+PyFeQ4Rx0f
         tYOcaPKjqesfUwB5oXqCOIquZbdoT/ThJ1g8+EEwWC17HESyxuH/jzGs05Qep6k2lMWl
         h8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUlwZ/6gHaNmuHs/cMy0gXyxBEwq0UHPjMsCKs/BOE6KlmAgur7/GLBUW+9ioWTiAdezE9dW+FQ@vger.kernel.org, AJvYcCWHoTupo04Gm4KwdvrZRCljGkt0/F4vM0MJpyRDoiBrHCoCIFggz8wveWedMw+0KBrCj0rBXv6aR5lob7Dyq3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwPnhq5b2hUNhAJmOOfssqp6LyOec65xvyn+n58/ed3A5afhvg
	i7JYkTHgxHc3mwT/6VBiUr289cTEvKRc8vojj0wma/DPm7km0QMX
X-Gm-Gg: ASbGncvWSUGttwRe9ARdmupfNSKbOghG9GS1xlKQ8YFw0K0cPaGNZhjedOoNdZFbAmj
	fAUoM9EDFps2bYuQ5wOa4Ddk/EZDZyJgvwV4a/comWYHtbO8s2zkpL7jzY7no7toUKOox35zN1O
	z5sGgpok4K/LIujTvRt/Jg20FbtuAzizO/Y/R6//BJbiWHWG4d2jZbi6nzBFDjSiuTC+Evyi46z
	QiHAfDf0xqPHxbfcxPhPpAyOld4ppBJVgGBbN3yRLNvk8ud84FPbBQVLYCvPCRiBiMsAZ4kvFaP
	V3qmcQ+FQO/GNtQoy4/cEky7Ss5YzVRlkw==
X-Google-Smtp-Source: AGHT+IGnOC2yuJ6Fl659YA5Q65aYXCdzj2lJFnXehH21t3WzXdK8aw4qcSC78ND3kWQG/kGoU+IUVA==
X-Received: by 2002:a05:6a00:1703:b0:730:9801:d3e2 with SMTP id d2e1a72fcca58-736aa9df8afmr16125103b3a.8.1741527831922;
        Sun, 09 Mar 2025 06:43:51 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736c41dda7csm2296841b3a.85.2025.03.09.06.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 06:43:50 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	horms@kernel.org,
	shuah@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: almasrymina@google.com,
	asml.silence@gmail.com,
	willemb@google.com,
	kaiyuanz@google.com,
	skhawaja@google.com,
	sdf@fomichev.me,
	gospo@broadcom.com,
	somnath.kotur@broadcom.com,
	dw@davidwei.uk,
	amritha.nambiar@intel.com,
	xuanzhuo@linux.alibaba.com,
	ap420073@gmail.com
Subject: [PATCH v3 net 6/8] eth: bnxt: fix memory leak in queue reset
Date: Sun,  9 Mar 2025 13:42:17 +0000
Message-Id: <20250309134219.91670-7-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250309134219.91670-1-ap420073@gmail.com>
References: <20250309134219.91670-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the queue is reset, the bnxt_alloc_one_tpa_info() is called to
allocate tpa_info for the new queue.
And then the old queue's tpa_info should be removed by the
bnxt_free_one_tpa_info(), but it is not called.
So memory leak occurs.
It adds the bnxt_free_one_tpa_info() in the bnxt_queue_mem_free().

unreferenced object 0xffff888293cc0000 (size 16384):
  comm "ncdevmem", pid 2076, jiffies 4296604081
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 40 75 78 93 82 88 ff ff  ........@ux.....
    40 75 78 93 02 00 00 00 00 00 00 00 00 00 00 00  @ux.............
  backtrace (crc 5d7d4798):
    ___kmalloc_large_node+0x10d/0x1b0
    __kmalloc_large_node_noprof+0x17/0x60
    __kmalloc_noprof+0x3f6/0x520
    bnxt_alloc_one_tpa_info+0x5f/0x300 [bnxt_en]
    bnxt_queue_mem_alloc+0x8e8/0x14f0 [bnxt_en]
    netdev_rx_queue_restart+0x233/0x620
    net_devmem_bind_dmabuf_to_queue+0x2a3/0x600
    netdev_nl_bind_rx_doit+0xc00/0x10a0
    genl_family_rcv_msg_doit+0x1d4/0x2b0
    genl_rcv_msg+0x3fb/0x6c0
    netlink_rcv_skb+0x12c/0x360
    genl_rcv+0x24/0x40
    netlink_unicast+0x447/0x710
    netlink_sendmsg+0x712/0xbc0
    __sys_sendto+0x3fd/0x4d0
    __x64_sys_sendto+0xdc/0x1b0

Fixes: 2d694c27d32e ("bnxt_en: implement netdev_queue_mgmt_ops")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bee12d9b57ab..55f553debd3b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -15539,6 +15539,7 @@ static void bnxt_queue_mem_free(struct net_device *dev, void *qmem)
 	struct bnxt_ring_struct *ring;
 
 	bnxt_free_one_rx_ring_skbs(bp, rxr);
+	bnxt_free_one_tpa_info(bp, rxr);
 
 	xdp_rxq_info_unreg(&rxr->xdp_rxq);
 
-- 
2.34.1


