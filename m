Return-Path: <linux-kselftest+bounces-34494-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC064AD23DB
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 18:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BD33AEE32
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD05921C9F4;
	Mon,  9 Jun 2025 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjcUoWWo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2F21B9D9;
	Mon,  9 Jun 2025 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486350; cv=none; b=N2tE6Wi/bMismdjAsPgFyC0SmCIP/Pch1Bud4Dk8x9mxjA4YZeHkifWDuNxODIpt6UrBHkmJTgk2A+H2KSBsrmm7HTT6da9cFRo9vxY0/cl7yxYbScXMCYyoRJbaK5neJrdcxnK8hYQncy/UmqtpU0+1Nh1mIKUNln0jWJaJwZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486350; c=relaxed/simple;
	bh=z7qmWniBIonNdhZeh8JAak8HTSJvBo7rSJQuyxUQ31g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RyZM9O0LnTPbhfiWIdRJM0lxIwkliKXoSTjSGPSVpmJVdc5Oi/V+15CBhfanGwbityfA0v5EfhxjxrU7kdeDNrRfKaQvHAxcuZJe4YQznjcZL9VK2RVghF1JXHF22nVbzAtpMAu/wcqJrTs6yM7DL/Q6JVAMz6yUC8hB7PwH+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjcUoWWo; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-231e98e46c0so41712375ad.3;
        Mon, 09 Jun 2025 09:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749486348; x=1750091148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7EpK0zw2/veQxMvxmxEv0B+FifXXBoF9kaDm9Vzf5w=;
        b=WjcUoWWosoYi/cg2837blpt0TkKpX40HFJiGp4o93AvwR8YfHkTJXVrRiMH2jWyfyg
         UOWG3rxEkW1fDMEiYNtW8LU6lSUu5y7q9Ht9J+TLN3COCVXYX72BIU+/owpnhK57oTS5
         i3IqP4J0V9pg78v1cRT59+BKu75OCi7WfKAYxdxlJy9ElKD3NjM32Je6rnOmuZUzdUlY
         xZSkTWw8ziy/AguB7sTSY2YWR4ifE229BI4X7d7/YDeTynIULSrzcyUjnSomhJn/+UTR
         eehagIYMfkb3HpBsw2ZJThCT7TYw8OC5V+ZIQlAs4Zv13Zo5hVl5Hu6fX+TO6jMw8TQH
         CTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749486348; x=1750091148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7EpK0zw2/veQxMvxmxEv0B+FifXXBoF9kaDm9Vzf5w=;
        b=WrHs4SFN1yRL8s1Vu0ZKUGy9o8Mnw0Wu0ADpkXuOtLQiyQYxyZM/LTvL84/5DwONFR
         Z1IASJvq9LcR0Q0nDor4f+zs4ohAJktuNrCjdEuQ4xCM9gjEp1duyA4jwWBrgGAYuyOy
         TwHP1Z4/PNRpKsTg7tEbsUrNT05VgFUzVtEV/ZJ1GO5Mq/4mqf1ZTNJsd3waSHPTPjha
         WjcM95qViXhn/GszNeaOeYPofdnbIaRXKJNLrGk/iLyURj/HQSCutTBUe0uWlcTI8HD8
         IBFc0aKICLkzUWkhZFxLSALG/RtloIhtKPCYE98PVcsbNLImdj2iONMz7xPvK6UJGjUH
         mcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfHAqnOKxSmPnRPCPB1yWBfqLUCqmjqpuJCJHO0H0k03Y1hXk7ycdUHH4aveKFmKC9EoYD2rHci5+JL/e4b/mX@vger.kernel.org, AJvYcCVr6cCPzX8Z+rQoQk98M59jwaFjrOe57yH5Bw4b73Wz6F86EPcDmnOfPYQzne4SWjpw84ZIs+Hf/vOWg5k=@vger.kernel.org, AJvYcCWutOl/Ud/4ALkgcRFDwOPcyW3yw3cgL3rJ3J1pDkQ/2Io0AE4ezRhICGW5u+05cQ8+Oh0J/VT/g/S8hg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTnEAnI8tdhhpZsJruqVcfbsV9A4qnWt0ZnUlXoVnp2saqDcgJ
	5s//YQMhVGdtw6gSoDeI7NQDg/Cr76To0z6WsNuQfM5/+2IxW2GtRQTMETYB
X-Gm-Gg: ASbGncuGsX+Bs3f2Cn7lej1BUx4E7SrKFABLR+gmEDMzZPqzsL6nziEyJ2hKe3j1X4Q
	C3TVOrjgy8eJ8xhgj+A55Wlnwq3/X78ngkqfaBKU0JmsX48kUHveS06jP+Uo3MgXEkCvGdND7Vj
	1VC42ezF3VTgIQ5v7F5UhqBkb+1++iTV1EFrOXM1QzOwxGN10Zp3u8IcyW6UN0erdM9wk9Qx3xS
	zcl2kBDquuae7jKMBBpJS/MsdcRnct2bLrgErIF5zQ27xjjUGhiJ+aVNZcUPzUpKo3NXladQ6Jr
	8uQVleP1DAz0NztNQHIt10uRua1VSp3yAah1XcWdW659OkVyIWLcb05pfV4hFBDgd5vBBzuADAC
	Li2BzL6QyZiN7
X-Google-Smtp-Source: AGHT+IGapDPv1cHR0dWqimNSNGAmR6AOYZGplgx4b+X7CrIfkEPxGuAl3kbxQrojEm2Tk0pvayZItw==
X-Received: by 2002:a17:902:f688:b0:234:b41e:378f with SMTP id d9443c01a7336-23601cfdb18mr199068395ad.15.1749486347764;
        Mon, 09 Jun 2025 09:25:47 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-236032fcfccsm56699935ad.101.2025.06.09.09.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 09:25:47 -0700 (PDT)
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
	mheib@redhat.com,
	ruanjinjie@huawei.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 3/4] netdevsim: remove udp_ports_sleep
Date: Mon,  9 Jun 2025 09:25:40 -0700
Message-ID: <20250609162541.1230022-4-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609162541.1230022-1-stfomichev@gmail.com>
References: <20250609162541.1230022-1-stfomichev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that there is only one path in udp_tunnel, there is no need to
have udp_ports_sleep knob. Remove it and adjust the test.

Cc: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h                      |  2 --
 drivers/net/netdevsim/udp_tunnels.c                    |  8 --------
 .../selftests/drivers/net/netdevsim/udp_tunnel_nic.sh  | 10 ----------
 3 files changed, 20 deletions(-)

diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index d04401f0bdf7..511ed72a93ce 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -131,7 +131,6 @@ struct netdevsim {
 	struct nsim_macsec macsec;
 	struct {
 		u32 inject_error;
-		u32 sleep;
 		u32 __ports[2][NSIM_UDP_TUNNEL_N_PORTS];
 		u32 (*ports)[NSIM_UDP_TUNNEL_N_PORTS];
 		struct dentry *ddir;
@@ -342,7 +341,6 @@ struct nsim_dev {
 		bool ipv4_only;
 		bool shared;
 		bool static_iana_vxlan;
-		u32 sleep;
 	} udp_ports;
 	struct nsim_dev_psample *psample;
 	u16 esw_mode;
diff --git a/drivers/net/netdevsim/udp_tunnels.c b/drivers/net/netdevsim/udp_tunnels.c
index 10cbbf1c584b..89fff76e51cf 100644
--- a/drivers/net/netdevsim/udp_tunnels.c
+++ b/drivers/net/netdevsim/udp_tunnels.c
@@ -18,9 +18,6 @@ nsim_udp_tunnel_set_port(struct net_device *dev, unsigned int table,
 	ret = -ns->udp_ports.inject_error;
 	ns->udp_ports.inject_error = 0;
 
-	if (ns->udp_ports.sleep)
-		msleep(ns->udp_ports.sleep);
-
 	if (!ret) {
 		if (ns->udp_ports.ports[table][entry]) {
 			WARN(1, "entry already in use\n");
@@ -47,8 +44,6 @@ nsim_udp_tunnel_unset_port(struct net_device *dev, unsigned int table,
 	ret = -ns->udp_ports.inject_error;
 	ns->udp_ports.inject_error = 0;
 
-	if (ns->udp_ports.sleep)
-		msleep(ns->udp_ports.sleep);
 	if (!ret) {
 		u32 val = be16_to_cpu(ti->port) << 16 | ti->type;
 
@@ -170,7 +165,6 @@ int nsim_udp_tunnels_info_create(struct nsim_dev *nsim_dev,
 		       GFP_KERNEL);
 	if (!info)
 		return -ENOMEM;
-	ns->udp_ports.sleep = nsim_dev->udp_ports.sleep;
 
 	if (nsim_dev->udp_ports.sync_all) {
 		info->set_port = NULL;
@@ -213,6 +207,4 @@ void nsim_udp_tunnels_debugfs_create(struct nsim_dev *nsim_dev)
 			    &nsim_dev->udp_ports.shared);
 	debugfs_create_bool("udp_ports_static_iana_vxlan", 0600, nsim_dev->ddir,
 			    &nsim_dev->udp_ports.static_iana_vxlan);
-	debugfs_create_u32("udp_ports_sleep", 0600, nsim_dev->ddir,
-			   &nsim_dev->udp_ports.sleep);
 }
diff --git a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
index 92c2f0376c08..8c5fe7bdf1ce 100755
--- a/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
+++ b/tools/testing/selftests/drivers/net/netdevsim/udp_tunnel_nic.sh
@@ -266,7 +266,6 @@ for port in 0 1; do
 	echo $NSIM_ID > /sys/bus/netdevsim/new_device
     else
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
 	echo 1 > $NSIM_DEV_SYS/new_port
     fi
     NSIM_NETDEV=`get_netdev_name old_netdevs`
@@ -350,7 +349,6 @@ old_netdevs=$(ls /sys/class/net)
 port=0
 echo $NSIM_ID > /sys/bus/netdevsim/new_device
 echo 0 > $NSIM_DEV_SYS/del_port
-echo 1000 > $NSIM_DEV_DFS/udp_ports_sleep
 echo 0 > $NSIM_DEV_SYS/new_port
 NSIM_NETDEV=`get_netdev_name old_netdevs`
 
@@ -428,7 +426,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -486,7 +483,6 @@ echo 1 > $NSIM_DEV_DFS/udp_ports_sync_all
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -543,7 +539,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -573,7 +568,6 @@ echo 1 > $NSIM_DEV_DFS/udp_ports_ipv4_only
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -634,7 +628,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -690,7 +683,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -750,7 +742,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -809,7 +800,6 @@ echo $NSIM_ID > /sys/bus/netdevsim/new_device
 echo 0 > $NSIM_DEV_SYS/del_port
 
 echo 0 > $NSIM_DEV_DFS/udp_ports_open_only
-echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
 echo 1 > $NSIM_DEV_DFS/udp_ports_shared
 
 old_netdevs=$(ls /sys/class/net)
-- 
2.49.0


