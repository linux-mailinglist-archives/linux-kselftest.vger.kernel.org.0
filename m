Return-Path: <linux-kselftest+bounces-30049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA46A79F7A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 11:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86D481896FA0
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2133F2512DA;
	Thu,  3 Apr 2025 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSLDXR2V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77424A065;
	Thu,  3 Apr 2025 08:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670774; cv=none; b=UIT5qyWL5K07ZEMC9hn9wLh9m5672aRQV5gEl0XhSkk2K9eKWwelHmEsavHblTiaOKpKgR2Y8qbciLPcPKN5GyiRkknTNDZvn0kVumfUKg/Mxucf44s6DEwPf+E9z5rf/PehJ/vXHe+tT0g6aa3+MC9UxA2xzv24zsHGqgbK/wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670774; c=relaxed/simple;
	bh=F3/khe7Gf2Fu87OAksPK044g1enLY+64dR3IRRdxLn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1yo/bc9C4yfYz/3SNo2mFF1Y6iP1jc9CM2fPSilApcnj3pbk0XAbU7JLPXr0HT7/TRemi69AbzZ0gc3fn41xjp5SNJmM9Ne0j17lSAmAe6KcEVhiC+dKd2resK/dAlVEMpU4wSkNyph/6rpaYmj6Lcxo9PkkJFNKHRzMH0jD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSLDXR2V; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ad51e7235beso626506a12.3;
        Thu, 03 Apr 2025 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670766; x=1744275566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYVKhBJVpiVETzgPiPMXrHXmtB1Bi2m8eMZNmHrFojo=;
        b=NSLDXR2V6De0mvu3RsqUTGJoXSfqwJRzqs9JqwT8feSel9sq99jO6f8HesmL0r6vRV
         E8qlKKVQSSuqZTrgu6qwncfHTig/otMkPov+u05E2Dbkm2rDiluDnM8EoKYL9K85w6Oq
         ocE1iFBg+ZLyI/bGBIXbjpfPrbtW8ckQ+GBfB/37HGtw3f5kjzic0Jsn0iyi0LBKatM7
         E4O+r0rSEQuqflVC3X9arwSayioMh47HMvFAPsj+NOJo8MV4HfF39T4jyoMzdCwnMbu8
         bgFk6LSDKUmwu3XokwvbzmdKHUUL8NwSOdKvrQLZ2aCp3rHJE/jJ5cEEYBCzyM/8kKxR
         j77Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670766; x=1744275566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYVKhBJVpiVETzgPiPMXrHXmtB1Bi2m8eMZNmHrFojo=;
        b=VUiHIvMrmokVAidsYNX1bclWC9Tag7CoG1JIVlMauG+OujLKBpGidRXhJxSQQZmmaZ
         tq/pzDqGziVAsICLOpuEq02QTKiDMYNdsRox5Z82TdvIjJAmoS6JLM+JlSlI7hIKWpRm
         jMRGrc1mVKOn8HMQYt91CBiOiIfWHmazUpHsTjDAdojHWyBxgs7Y3yXYWmiqcrmG6xgk
         OjT80Vm1Bn1s5KB12BC/+F3R/wzpPMvJeNkKxVj5+xYKw6XlKnahSqpva1qQMLHeS8H2
         epFEeg02QBwyZBGA4DdNV3qh0ZvWsZnVBsNJGbqHwSlUMCqeEkIPpG6zAJEdEMEckKk9
         dInQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNDfwRDwBbq/YQGi5RLP5ug3xltxtjh83kiRfdl5fp3igH2QwfiQ36mbvYFsnasXOK83B/XxXMrKrCr1dNkqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YydBR08KsZVuldlapNSugjAwQa6SxCwQjEaF+OHv0JtvIEvqmGC
	bIWOll5BMKzmG0wK5hA/dPh4CWiCn1U2FvUo3Udw7jUfNXe3PrQVSKG4UYZaFTc=
X-Gm-Gg: ASbGncuaQk0TzAstXKqxpkFLDzawns7GTjO4EWOdjXI/aJZahHNVic7Vkrie4L6UYWo
	MhDN3k8hmrpBHlL2t2mjOVDPfMCMYjxfJKLdmt6NU4AHx2GQPlFz4wHPkZe2Ju+GvUV2v3+duj0
	7D87/soMD3GpSh0WDlUmvUaDOJTYCnyRitpuSA1O3iXlVlP3mNq5MFXq4LOcKcQRT5s4b+gM5rm
	SQZKcRl1sIjZtRXsdS7TpRr7IBRbcVVQtiL/WdfAVzw9/QvOyRq4TeEgDpQfM6SVBJXgnBs8PxE
	Bq4dwxrG1vqimoq/CviyPzxGhyBKNvWvZfcQtuNnRUHaGZglMQlve34XFLegTkZf
X-Google-Smtp-Source: AGHT+IHZqQ9zJvuvZ8pGS4Y1LwNjv1ZtGbAzJZCE4hHdZmWYrWWpp5dIQxvB/OAFNhgXUnwHTREvsg==
X-Received: by 2002:a17:90a:c888:b0:2ee:5bc9:75c3 with SMTP id 98e67ed59e1d1-3056ee221eamr7205975a91.5.1743670766562;
        Thu, 03 Apr 2025 01:59:26 -0700 (PDT)
Received: from fedora.dns.podman ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-305827d710csm937620a91.10.2025.04.03.01.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:59:26 -0700 (PDT)
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
Subject: [PATCH net 1/3] ipvlan: fix NETDEV_UP/NETDEV_DOWN event handling
Date: Thu,  3 Apr 2025 08:58:55 +0000
Message-ID: <20250403085857.17868-2-liuhangbin@gmail.com>
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

When setting the lower-layer link up/down, the ipvlan device synchronizes
its state via netif_stacked_transfer_operstate(), which only checks the
carrier state. However, setting the link down does not necessarily change
the carrier state for virtual interfaces like bonding. This causes the
ipvlan state to become out of sync with the lower-layer link state.

If the lower link and ipvlan are in the same namespace, this issue is
hidden because ip link show checks the link state in IFLA_LINK and has
a m_flag to control the state, displaying M-DOWN in the flags. However,
if the ipvlan and the lower link are in different namespaces, this
information is not available, and the ipvlan link state remains unchanged.
For example:

  1. Add an ipvlan over bond0.
  2. Move the ipvlan to a separate namespace and bring it up.
  3. Set bond0 link down.
  4. The ipvlan remains up.

This issue affects containers and pods, causing them to display an
incorrect link state for ipvlan. Fix this by explicitly changing the
IFF_UP flag, similar to how VLAN handles it.

Fixes: 57fb346cc7d0 ("ipvlan: Add handling of NETDEV_UP events")
Fixes: 229783970838 ("ipvlan: handle NETDEV_DOWN event")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 drivers/net/ipvlan/ipvlan_main.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 0ed2fd833a5d..2abe6ddc4d15 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -730,7 +730,7 @@ static int ipvlan_device_event(struct notifier_block *unused,
 	struct ipvl_dev *ipvlan, *next;
 	struct ipvl_port *port;
 	LIST_HEAD(lst_kill);
-	int err;
+	int flags, err;
 
 	if (!netif_is_ipvlan_port(dev))
 		return NOTIFY_DONE;
@@ -739,7 +739,25 @@ static int ipvlan_device_event(struct notifier_block *unused,
 
 	switch (event) {
 	case NETDEV_UP:
+		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
+			flags = ipvlan->dev->flags;
+			if (flags & IFF_UP)
+				continue;
+			dev_change_flags(ipvlan->dev, flags | IFF_UP, extack);
+			netif_stacked_transfer_operstate(ipvlan->phy_dev,
+							 ipvlan->dev);
+		}
+		break;
 	case NETDEV_DOWN:
+		list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
+			flags = ipvlan->dev->flags;
+			if (!(flags & IFF_UP))
+				continue;
+			dev_close(ipvlan->dev);
+			netif_stacked_transfer_operstate(ipvlan->phy_dev,
+							 ipvlan->dev);
+		}
+		break;
 	case NETDEV_CHANGE:
 		list_for_each_entry(ipvlan, &port->ipvlans, pnode)
 			netif_stacked_transfer_operstate(ipvlan->phy_dev,
-- 
2.46.0


