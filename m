Return-Path: <linux-kselftest+bounces-34962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 943A3AD9659
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:33:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C5D17BDE6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CA5253F31;
	Fri, 13 Jun 2025 20:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH+2W0c6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68859235065;
	Fri, 13 Jun 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846810; cv=none; b=E8IbsO4vDyGrt3TNa0xipjJEu7uNAquxpWYnuNxe0dy1F4NZKVlTHJT7SBsGYzms7M94It7dIPin3lrdOzYc8/aFbZXf9TUrW/cK540T9WSS5Pbcc52J3hl6jBDl5y0cP1Kl9XbEhl74OnjJt3dwvx2LvnZdgzwMfkRtuMqWIzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846810; c=relaxed/simple;
	bh=JkoN2dWrcEqUNM0emlkw41oWkqb12RsAg6lhxUAnLNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VP0Omrlsyhoz7ZfoKXMhDFARUVVAXXSctx9WGwGPcP+ykyyY3TBS6EZsmN/c9K0l0S5Tfrs8L6wYl60aZxVGKwJ7gt2F6cb20F9witA9YVMef/OD6kWLMHXos6RY9fUZvDRsto9vUESOU6lm2HibxgLLeeRN7wuqZ9AMV0tMBFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH+2W0c6; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3116db72bd7so2766153a91.2;
        Fri, 13 Jun 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846808; x=1750451608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBk8y2WrRSYe0+qd1bXdlKUoFp7dWqpBPCvB8ZCmdDU=;
        b=PH+2W0c64/GA5O4zdma2Qtg9hJdZEMY8qc+A/n/+fSOL3J4sZLu34tbrRK9X55rHhn
         NO0KLmo0IcPjozxMRAlICoPYwKqAViPqWhVHJGlEGz08fb40Cali1OJw/V2iN187bwYa
         UzyHbLvyzrklI1eXmBBdxNS/uKHaoZdJhf6CytTM7Dv04V61UGM71lGv7eedN1gNqLle
         Ljx8ZAAvU614Bcd8UzkbX1hWsqBrdQjtqTwCIIe174V52zR1hd8g27gCY0pW6K2w4n6D
         wMGK7QPWhiv5sWwynVg1LYBzsefj6n2ec4CsCH98KtXDkOiLshfnbgxqRMWaFc+xINy2
         WKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846808; x=1750451608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBk8y2WrRSYe0+qd1bXdlKUoFp7dWqpBPCvB8ZCmdDU=;
        b=DOWCE1OmtfmuFNZrZvZZj4AUye42aBnOA1THNMDdl2Mxz1TVL69nksLGURXLSQAH0Y
         75eiyawvLZsLv29jOosNYU8siHeJhxTizPin2PzCD/02rjNlN5Lae8OJIlf3h/tRm2z0
         /3uu+DvhRpqs0rXTwzjNXKgp5lOYnoYGcR9Yu++ffNMp22Xj39BPCm3RcQoTfi8ZW9dD
         BbMI9uTj4DK+k8lzTpWX0G8kwjFctG+RdQ7AD++Nr1VtNGWhn01xV7yiOKJO7LVthV44
         m0zRNpaAdJJBlGgImEvKM2NssRMp2uggTO5WDBQRL7t5bD82Nlx/sAD1ARSRGx97Hhd6
         RbDw==
X-Forwarded-Encrypted: i=1; AJvYcCU/I/LE1WrdlijGkKJDeRg4tMs3wCPTq44FWIXxZKg911uje643OiYoNxF6EFoHCdiVjbcXssdi604OEw==@vger.kernel.org, AJvYcCUn/dX8LmYYCREX4H/mGsLgAJXXzmGiX7CBWFP4cdGbB033GugRvQglT8MLM5h4LmGwb0eUhlJ+E99SdJA=@vger.kernel.org, AJvYcCUpuRXjlIvxVjVJuugtdZ1XRfoxtUfYH4T2EvDGrmrK9++Fo+R22ePdtQ199wTlHE7Oai9DQPdRFv8+3+ePjj0f@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2cVZEPuDI24vnnn5+F2IcTJWJbUNloemF2H1vo2/VovX8u4kW
	jdQ1pEBbFE6mVqXAPuMAy79ZZttw06B20H7ls69iKeX6q928c68ETM0mD8rV
X-Gm-Gg: ASbGnctDbJTHzIM85EKoVKj6UXPtk6SMiNFJ+4+MXQIQmQA7KEr88VC15qOdNKbbZMP
	JaGJFjL2jpnTFtLR6vF+dsgH46R5dHvqZQAc6yVek+YIrUV2EqTuVa/CQt+tXFNtHCdUDYVpFsw
	rD/UmUmkT1VwApsCL0fEniGty428Jy7qUVJA5HqbbjVIs5BpntLhU1UKGkTnTNxkPyjJCQ2JOve
	kLmcxGRzzMqd/uRB/6xtjHWqhZV6RvQFVP1nVS2kSp0weE3W9/zcpNk+AkNr2Ds6nEIRZJh7f9E
	jzdjk7YwKeTkVaA5lYwxq9gBp9KWG5Hc8wRX4cTf0Ai8j95kPhdc5zNDk5nwTti/2qAQzyA93U2
	P02FI/slv1DTOtDCbw6IZ9J8=
X-Google-Smtp-Source: AGHT+IHoQe9kZNmiwFgO4UN/YI6LxV+FrHuaz2eiRSh2X5ivyPpLydz1ZML9qM0wZPZU19hVvxBN7A==
X-Received: by 2002:a17:90b:58e6:b0:312:db8:dbd1 with SMTP id 98e67ed59e1d1-313f1ca7bb8mr1421800a91.5.1749846808151;
        Fri, 13 Jun 2025 13:33:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365deaa9dfsm18866135ad.172.2025.06.13.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:33:27 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	skalluru@marvell.com,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	tariqt@nvidia.com,
	saeedm@nvidia.com,
	louis.peens@corigine.com,
	shshaikh@marvell.com,
	GR-Linux-NIC-Dev@marvell.com,
	ecree.xilinx@gmail.com,
	horms@kernel.org,
	dsahern@kernel.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	mingo@kernel.org,
	ruanjinjie@huawei.com,
	idosch@nvidia.com,
	razor@blackwall.org,
	petrm@nvidia.com,
	kuniyu@google.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v4 1/6] geneve: rely on rtnl lock in geneve_offload_rx_ports
Date: Fri, 13 Jun 2025 13:33:20 -0700
Message-ID: <20250613203325.1127217-2-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613203325.1127217-1-stfomichev@gmail.com>
References: <20250613203325.1127217-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

udp_tunnel_push_rx_port will grab mutex in the next patch so
we can't use rcu. geneve_offload_rx_ports is called
from geneve_netdevice_event for NETDEV_UDP_TUNNEL_PUSH_INFO and
NETDEV_UDP_TUNNEL_DROP_INFO which both have ASSERT_RTNL.
Entries are added to and removed from the sock_list under rtnl
lock as well (when adding or removing a tunneling device).

Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/geneve.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index ffc15a432689..9efedc6758bf 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -41,6 +41,7 @@ MODULE_PARM_DESC(log_ecn_error, "Log packets received with corrupted ECN");
 /* per-network namespace private data for this module */
 struct geneve_net {
 	struct list_head	geneve_list;
+	/* sock_list is protected by rtnl lock */
 	struct list_head	sock_list;
 };
 
@@ -1179,8 +1180,9 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_sock *gs;
 
-	rcu_read_lock();
-	list_for_each_entry_rcu(gs, &gn->sock_list, list) {
+	ASSERT_RTNL();
+
+	list_for_each_entry(gs, &gn->sock_list, list) {
 		if (push) {
 			udp_tunnel_push_rx_port(dev, gs->sock,
 						UDP_TUNNEL_TYPE_GENEVE);
@@ -1189,7 +1191,6 @@ static void geneve_offload_rx_ports(struct net_device *dev, bool push)
 						UDP_TUNNEL_TYPE_GENEVE);
 		}
 	}
-	rcu_read_unlock();
 }
 
 /* Initialize the device structure. */
-- 
2.49.0


