Return-Path: <linux-kselftest+bounces-30050-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E22A79F83
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31033A66A8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 09:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6C6253B5B;
	Thu,  3 Apr 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EULITbMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55C82528ED;
	Thu,  3 Apr 2025 08:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670778; cv=none; b=rWs2fsZuVDyj+Cv5Ilh/c7hcc+h4SzqnelQOSd6wue86gjyRD2btUuxsBDI2zYQJJn6xHWxyfSQwrN6OSv3Hp9uqjLeEUE/FSo3h1lK8ah+4w9UqUVopKq2kl9MXv2b/DL5Ks/yZWdG3+yIkiVIAzhFR0PndEEfO0f7L4ZpL9jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670778; c=relaxed/simple;
	bh=w8cQtBawdUaAqCpYXbsmsYiG8edovPzgJurB2JGwAZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mvz0txWiJIiSMTB1GwyFFFXlGNZBUggaZsPYaJ28CCRy0KU4XK1XeFianPjN1MVhUVy/EwGnXHd/mKNCWb0t9yw4s9WoiLIAC/oOKDsOajFFdVA/0G2X5trLxTNrnW7zOoVrG6zsnwDNXINctBYyjmonqkJLgJjOuTzcRuQ844A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EULITbMH; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3014678689aso507301a91.0;
        Thu, 03 Apr 2025 01:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670775; x=1744275575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJGPTm3btHcG976NDsvjiyR29asJDHlycsrQUrhba3s=;
        b=EULITbMHSbh4QnhdO3aieAE2n/mCPzNC1f0M6kZiFDZ7RJcUiU7SvoPeU8xbJCs7rK
         GEIdGhs0mGcURwf2xHXtRLmIUK6ytdXQfrFG97376P6BbkjYcj0MFeWKvfVjxJEX3JVd
         ZKN/s1OPPiUpkgikJoQmhk1vMVNGqPbOKHVT49kq1Rxyzq4u5yhdicrDN4tbE8PXXFrr
         qeqnIIStbL2ftsfC4O/Potv+E3BpCRX8hAUD8MB7x/6o34raER4RU6EJG7L0pmWqiOWr
         rhl9ZZkD2kXZALHnNaNjwPTqCWpAAO9pSeOTJcVrsmBuMMetI38++ayPQk53t6EJm5EB
         DVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670775; x=1744275575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJGPTm3btHcG976NDsvjiyR29asJDHlycsrQUrhba3s=;
        b=I9xljG3vrJf9f3ibio/Y1P+05ib9T55qnG6pDhWQyloKQwUd6fa7uVykpgSTzhoUP7
         lpKOQv9ik30NlsB85ITvMI8mX1EN/wUAWwOz8Hi76ba2fdxv7eswR5rHBfkVn91f8Kmz
         Z8K1x7WdKyA5SN0IdhDN0UK3rGum6SuEPT8tFmOMJ9KwETCL35AhtMfdfQp9Kv3QE8ZC
         IFSROwKfmWqHxGPc04t+bZ7Mj13SQtQYhQcQuWyEcWBnA4Iy5DiJYfJ2kSsPKlwGR0ue
         OQFJa22ruOz1w0pA8K3CR6ob6AAS+GFPB5cwqY96hBCAWOFl0goHNV4SDM1Lpmu1SJ0c
         UiPw==
X-Forwarded-Encrypted: i=1; AJvYcCW77fWgo8Fa6/pNPmv72lgYDT1rFr3csUWxwpTp7KYyrl0VMPJjwaBtBFx7pC1hLGLGi5V+PVe9M/2+L8+ygow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwceXSXGdtPA0j6DVSDM/LmjX4c4iBzV6MLp+nFPKcaaa1ILffT
	MKAoYwqze8/KO93Xey7gz3CnDlx3BK6fmvLOcmT2aouVERvgo9gCUvf21mGDl00=
X-Gm-Gg: ASbGnct+XyGrr75Ed52JjIgHg//jaMVdyw4H8VCpUzynCp5Re/o7VPVkMda78DN+ZcX
	rIik3bBPTa+XsRScg0Vd9HARxh/08KjF5+fD+ltQUtF/I+UqqDsk3b41hbHOBwZ5zGeN905QAtT
	j71gQEwl2QQH/pWOYj1OSrOHaIAl5RzLcJgdgFT6HUtQ67T4YmAgMSXiI9xu4SG+qSWSwWseFb1
	yMlj/Ac10AvAn7S0LdYxSiSzXIm7iM1QRYuo+GXtiHut3l8x/pkhlVqMwKMSAEx8zwwUAg0HVmH
	YORSczK3xnnJ8bJH5klerw0eUkLMsA4UryvlUXwNpeg5Dw2nt+k8TyuKEjSPtFAb
X-Google-Smtp-Source: AGHT+IHWkfoVo6WCWWAnAD9KHbcxlFrJYCdT9xQcwQ44aqdL+YYj+H8SE029RdrX+kpIOTQKmx3LZw==
X-Received: by 2002:a17:90b:534d:b0:2ee:b6c5:1def with SMTP id 98e67ed59e1d1-3057cb3237amr2650398a91.8.1743670774796;
        Thu, 03 Apr 2025 01:59:34 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305827d710csm937620a91.10.2025.04.03.01.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:33 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Etienne Champetier <champetier.etienne@gmail.com>,
	Di Zhu <zhudi21@huawei.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Travis Brown <travisb@arista.com>,
	Suresh Krishnan <skrishnan@arista.com>,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net 2/3] macvlan: fix NETDEV_UP/NETDEV_DOWN event handling
Date: Thu,  3 Apr 2025 08:58:56 +0000
Message-ID: <20250403085857.17868-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250403085857.17868-1-liuhangbin@gmail.com>
References: <20250403085857.17868-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Setting the link down does not necessarily change the carrier state for
virtual interfaces like bonding. Therefore, handling the device up/down
event via netif_stacked_transfer_operstate() is not sufficient.

If the lower link and macvlan are in different namespaces, the upper link
state may become out of sync. Fix this by updating the handling logic to be
similar to VLAN.

Fixes: de7d244d0a35 ("macvlan: make operstate and carrier more accurate")
Fixes: 80fd2d6ca546 ("macvlan: Change status when lower device goes down")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/macvlan.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index d0dfa6bca6cc..f254cda14dac 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -1781,10 +1781,12 @@ static void update_port_bc_queue_len(struct macvlan_port *port)
 static int macvlan_device_event(struct notifier_block *unused,
 				unsigned long event, void *ptr)
 {
+	struct netlink_ext_ack *extack = netdev_notifier_info_to_extack(ptr);
 	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
 	struct macvlan_dev *vlan, *next;
 	struct macvlan_port *port;
 	LIST_HEAD(list_kill);
+	int flags;
 
 	if (!netif_is_macvlan_port(dev))
 		return NOTIFY_DONE;
@@ -1793,7 +1795,25 @@ static int macvlan_device_event(struct notifier_block *unused,
 
 	switch (event) {
 	case NETDEV_UP:
+		list_for_each_entry(vlan, &port->vlans, list) {
+			flags = vlan->dev->flags;
+			if (flags & IFF_UP)
+				continue;
+			dev_change_flags(vlan->dev, flags | IFF_UP, extack);
+			netif_stacked_transfer_operstate(vlan->lowerdev,
+							 vlan->dev);
+		}
+		break;
 	case NETDEV_DOWN:
+		list_for_each_entry(vlan, &port->vlans, list) {
+			flags = vlan->dev->flags;
+			if (!(flags & IFF_UP))
+				continue;
+			dev_close(vlan->dev);
+			netif_stacked_transfer_operstate(vlan->lowerdev,
+							 vlan->dev);
+		}
+		break;
 	case NETDEV_CHANGE:
 		list_for_each_entry(vlan, &port->vlans, list)
 			netif_stacked_transfer_operstate(vlan->lowerdev,
-- 
2.46.0


