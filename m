Return-Path: <linux-kselftest+bounces-35103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A08ADB692
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 18:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B5116C834
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF5B286D7A;
	Mon, 16 Jun 2025 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKV+K8WO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1270B20C030;
	Mon, 16 Jun 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090882; cv=none; b=ogg1PLD7jiNZ4SOoaHeV4mVk08Ha40s0BCL/Wi2/n4Tim4F48EczC5Ito6lgI3MYvH+WRHDqbAOBmQ7Bf42bV+8SmgnMrqMRDjT0Sgo/uMgyZAxs1IWn6ww2rTzKfeAzhfIyLOSh2w1hKJc9ivC4sIZqA6pljfhjvldc6QpbccI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090882; c=relaxed/simple;
	bh=JkoN2dWrcEqUNM0emlkw41oWkqb12RsAg6lhxUAnLNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOfbvJHeV8Dh7NIuh5cRxWkb5iQTaIJT4+/uvuozekYbDyDjNYWST/n/Zj8u6Lm/V593yZEuWtsWTp9ZEQ41CMrqRBdtd8j1j5yEda0GGXdjU4Z4ikZP34R+q2QdjmybeiXVruzPMXW71SQmCXRRBOfsaaCNUZe2g8W85Wvt0jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKV+K8WO; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b2c4476d381so3920983a12.0;
        Mon, 16 Jun 2025 09:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750090880; x=1750695680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBk8y2WrRSYe0+qd1bXdlKUoFp7dWqpBPCvB8ZCmdDU=;
        b=XKV+K8WOm0jGD5QyKsFUwfAfRfz9SHvQCmmhLFpypVJnS1aZHge14zf4UoT0SZRxmh
         t0YGba0YnmsZD6Yp6DGY7eS+Vz5Ny6Yc7xGIbC/tkSZBnyQCggNijeVWk6dEhY6d6pO5
         V0nSr1BteNC7P2uAYCKQEi3hzDlcWeFc403BZg9Bw06hIm2F76rM8xHgc8TDf4ioqngt
         BxvdmQc+XljNHZd+hpWHJcE34kmUwQKHj7yMN87h7BkbdFbQFOb0MYffA/+8CvZOT6bc
         FUxQe6LRF8AeFHxt+xaUj3fooZpjEWT4n2c22d2IJej0T634D9ybdLyHZFGLh1oqGoRB
         tNjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750090880; x=1750695680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBk8y2WrRSYe0+qd1bXdlKUoFp7dWqpBPCvB8ZCmdDU=;
        b=k1QyztUKAzrjep3LiXQ1tkQzXpDUxyNaBit/UkOYTcTeG8ydYgwXPE+3Ku8EVwexYY
         rpBmFPubhH6+QstkwrrqRi5O2pZopNHTFB/kMeYUZCcaDZgN5Ybpfo+wv4566J6N+6VK
         yNTCZwR6RR6ezXLN/pFCKM231qlahw2YMYCOaZAqyeupiWGl8oLP/2TtrlYb3UGjpByv
         B066tDAhSIkvFhXtf4YyFG3Kgl9l9R+SnzpVbRjaTgs6l5wPa/WmpjzriuhK2W2QGQ0F
         q1Iw3OWIbW3xSMqMoGzvltWZLF0azT94Za4Vphjz3dwyw7Z/+tyTtuTQ1QLNIaDJjM9l
         EDHA==
X-Forwarded-Encrypted: i=1; AJvYcCW6bY/k0XwiNTh/giyNbWvjlFMBMQgosuBjCFE7jLeuFPBeFGhkmse9ME+Uw0lB2VnKr/9FU0w6SoYHBxM7GmIW@vger.kernel.org, AJvYcCWNPiNBhCAd8lTZW4Yt4U/NQsfJmusRR58qd82CuuDFdzKZs58UUtUZeQuMvPO80Xu8BXJDMasWw/vCbEs=@vger.kernel.org, AJvYcCXJiUZoRMdo2J3deafRvYglrdyHNTL2OMeYpmaHYAX5s0utFL/s06bD8U6ePwb0a59QwvL0JP3nh7y7Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwxLw/a687Kcpum+kgVJXXXxFDEiMJMS3GwA3AwcRC0sa+/CEur
	iIk0SBzk//cKF+cLiYh3MGRnFtZ7FCTfK0mO38m0V7X+ywlavReoTfS6mrvj
X-Gm-Gg: ASbGncul6fGmiYFwlpUw1zZaASLPkPKW53HxGW5w6wJoVJ6v1q7dSmFzqb9X/NGUvTK
	9t2jKVljwxvZnBMidHiBqrIqbsIrBLeiUl0cCAs4bmWbQiqzhoUPgIW+BeAFOdgSLkhDaMwKze4
	P2r9GzgEBhkx2lW0U3JUS7MBoPbfIyf7qSjyoTLN54BSENqd4qGVC9ZgWYbcUDXnWnQVG1XO3aH
	W5xKMRQzSf5M6R4FatysEebXddfIZUqa3XtRcOIPWHYBkfuXIBRqwuUl4sX1IsiCwwh8Jri7nLx
	r13OVmlokuLrFWHJqnHQzQe2UYoVGAy3RhExsfNYUGuJudh972lQ2Ta9FOqSmdEcuLPiIngC4iP
	RqgakSzzGQS43QhgP9QDgxv4=
X-Google-Smtp-Source: AGHT+IHyoBgAUnwaUWLXy/Vb8z5LsefTqBIJ7QsHNJx+nbM6WP3gEInOzLa9AqIKcqN8pQhevPrvfA==
X-Received: by 2002:a05:6a20:7487:b0:218:f95:f84a with SMTP id adf61e73a8af0-21fb8e7a542mr18650975637.4.1750090879810;
        Mon, 16 Jun 2025 09:21:19 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b2fe1689814sm5944845a12.51.2025.06.16.09.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 09:21:19 -0700 (PDT)
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
Subject: [PATCH net-next v5 1/6] geneve: rely on rtnl lock in geneve_offload_rx_ports
Date: Mon, 16 Jun 2025 09:21:12 -0700
Message-ID: <20250616162117.287806-2-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616162117.287806-1-stfomichev@gmail.com>
References: <20250616162117.287806-1-stfomichev@gmail.com>
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


