Return-Path: <linux-kselftest+bounces-34966-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F3ECAD966B
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 22:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48493BC80E
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 20:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D3B25CC42;
	Fri, 13 Jun 2025 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqmj+nhv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06AF25B664;
	Fri, 13 Jun 2025 20:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846816; cv=none; b=H6c008Q7er0n9HqUW5X5jHtPr6HgUqMksso7+BVzZZXtmrtrZvKI5iipp/AEsi3+JlRspXUyr9D3e/BR+bRChPJjGo8Pg1mNPf1JOTfZYJu5iy70Tf9QrqZzXWQey/w/ijjrqUjUFfFn7rS4+W+9fsqEBngwlBrtnVIImfTw/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846816; c=relaxed/simple;
	bh=jrPADGdQVSlhHaHu88CYeq9ejs0dqL4pa8LW21dVeyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pP7QwjwgM/9b9l0gfwYnCXI9m3w0JyEJv4UNBE67FKuMM/VMjZC7EYtkPAaY+/aGIFBu1NqbrzbBS3gdCucOmryCF2ni2ggwxnUHP3pQtHaSJy3cM1kQISKPsDS8Q99Gd/+wQrG9HGw96Tt4Lt0jL6Wxf3pv1Kp+CAQEPTHUhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqmj+nhv; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23649faf69fso26303725ad.0;
        Fri, 13 Jun 2025 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846814; x=1750451614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO4neuwpUVoDLsDzSFLxxvkPcabDlga25iey737Q9/w=;
        b=gqmj+nhvhiobfC523fjbPUv349X+6Wx9ymuY38DNzRlD/FWx/ZcCnN/StpTvIeEBhJ
         8WNAI6XQD7IgejMOjh9sM2hGuPDx+De37rV0QQgvpZHtQI13kxQ+xX5C/Ok1TZnflenB
         dwJIQfvhf5OeYyZTmI4A1LSUxG4yzW3TAwdMETx5yS254qmZS1JsL3YAlReRJ693PSx+
         zA8eRRbhekCJ1vot44trsSuq/yhJT43AQRW/cGQTF+lyu9+e1/y8RO7QYFRU6Aqunuy3
         3CrvvNDUMHUhFccAIwvYZurjKBsAdFZ5YTE0btRhCaZ8KseEfiG39L2iTesgf36sZrE0
         umIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846814; x=1750451614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sO4neuwpUVoDLsDzSFLxxvkPcabDlga25iey737Q9/w=;
        b=kM9JDbqlim38a+/2IDprJUHJePNlLlcAYEz+pmeaWBcwYjcEqEIXGaINKgFXz3CXex
         Y9sBUSsohMUOfpgmulY2eJrrWCwn8pdSmSlLUA61hMMp49aCu1VCMPMsT56hh5iVPS9d
         A5dT+yJiyXmDwJLEkCyWaUzngk20rCYP0Os37qKtv8A28t4/N1vWUWlMB+4Q3V1eOj3P
         DlfGVt6HIhwdIY6OBc9JC7mVgkAsbVfAkJREwKXy4EfpIxeq4MgSM3lhvRiPv9ck4NMq
         UYZOCH1NCiJyDJw9v1WF8VJ/ZcizpDTdyyIJfYUTiIC0nyHkJY7qLW9luZqjweHQs8Ee
         yFsw==
X-Forwarded-Encrypted: i=1; AJvYcCUWicRxKPGE4vtvAv6fwR80Lu/hlJgsqGxrLc13JL64HsUOCuYEAceb0Qtxs5O/zt9wsHZyl+AdI2aOXvoMCaQF@vger.kernel.org, AJvYcCV98WpnesI7guM5DdWR5QUlIges0SNCK3Qx0MUBpT965lw/ReyB2l3tGMVxjT1Dwwit0cyp0C8lnamYE3E=@vger.kernel.org, AJvYcCVEfKrTk/n5LLkguKpr6tasVBVcOCELLu4fwR1ZQdMUW51UhMLcmbjTeRYnuMbzfhNKtVHt24kNIxsIgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzbR2PJtdgTg5dkqiIk/CBc7YEZjF+krJ6Tq8Dacs7e4yDrTQfR
	5MxT37A4sB6c8T72d/bvDVLHUI46K0qB90p3RhtLWI0tAhT/+rUwbzhyraJQ
X-Gm-Gg: ASbGncviMAqSWFPLBesuAu9oDrJiFtjA0zHXz17+HYHQ7wgVqNXhEedlpkOE2DgZ8zP
	Az3lZUsabdZdN/jDLqdAjQ2JV0xyZi2jWKWCCRgGkCCPn7pN9iZOAivw0OrtYtZoQpJuipgPxQY
	6pSfpwKWW+Q9azgJ/+cU9gS/tr05QRxt5mlQxxvfaCpIiCFTcxGsm0rT8IJb7Djjud2o20US2Ue
	X5cryAcaK65qyBJBw7OA9aLcz8w8ELOiuhbueQg1vLPxU9aG39EATEw6IqiqPkg+q9cH9p66Ao7
	Nz69IUkbA2ASyZ/kifxVWL5r8W02CaiP6rpTp61y/dIklIbgeSZbVdMujCzk7U1ro/BrTdmwPvd
	oduQrLzsiKEh3jCCzx4iwLHg=
X-Google-Smtp-Source: AGHT+IH5KSH74XNPTSPHdCujlQcvG0U2V8ijxMyrMSSqm8nH1nuhDyFXVZRKnCpTPZUKyX4y5fvPiA==
X-Received: by 2002:a17:902:f690:b0:22d:b243:2fee with SMTP id d9443c01a7336-2366b005d10mr10990035ad.13.1749846813619;
        Fri, 13 Jun 2025 13:33:33 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365de781b1sm18939625ad.89.2025.06.13.13.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:33:33 -0700 (PDT)
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
	leon@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v4 5/6] netdevsim: remove udp_ports_sleep
Date: Fri, 13 Jun 2025 13:33:24 -0700
Message-ID: <20250613203325.1127217-6-stfomichev@gmail.com>
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

Now that there is only one path in udp_tunnel, there is no need to
have udp_ports_sleep knob. Remove it and adjust the test.

Cc: Michael Chan <michael.chan@broadcom.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/netdevsim/netdevsim.h             |  2 --
 drivers/net/netdevsim/udp_tunnels.c           |  8 -------
 .../drivers/net/netdevsim/udp_tunnel_nic.sh   | 23 +------------------
 3 files changed, 1 insertion(+), 32 deletions(-)

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
index 92c2f0376c08..4c859ecdad94 100755
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
@@ -350,23 +349,11 @@ old_netdevs=$(ls /sys/class/net)
 port=0
 echo $NSIM_ID > /sys/bus/netdevsim/new_device
 echo 0 > $NSIM_DEV_SYS/del_port
-echo 1000 > $NSIM_DEV_DFS/udp_ports_sleep
 echo 0 > $NSIM_DEV_SYS/new_port
 NSIM_NETDEV=`get_netdev_name old_netdevs`
 
 msg="create VxLANs"
-exp0=( 0 0 0 0 ) # sleep is longer than out wait
-new_vxlan vxlan0 10000 $NSIM_NETDEV
-
-modprobe -r vxlan
-modprobe -r udp_tunnel
-
-msg="remove tunnels"
-exp0=( 0 0 0 0 )
-check_tables
-
-msg="create VxLANs"
-exp0=( 0 0 0 0 ) # sleep is longer than out wait
+exp0=( `mke 10000 1` 0 0 0 )
 new_vxlan vxlan0 10000 $NSIM_NETDEV
 
 exp0=( 0 0 0 0 )
@@ -428,7 +415,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -486,7 +472,6 @@ echo 1 > $NSIM_DEV_DFS/udp_ports_sync_all
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -543,7 +528,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -573,7 +557,6 @@ echo 1 > $NSIM_DEV_DFS/udp_ports_ipv4_only
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -634,7 +617,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -690,7 +672,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -750,7 +731,6 @@ echo 0 > $NSIM_DEV_SYS/del_port
 for port in 0 1; do
     if [ $port -ne 0 ]; then
 	echo 1 > $NSIM_DEV_DFS/udp_ports_open_only
-	echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
     fi
 
     echo $port > $NSIM_DEV_SYS/new_port
@@ -809,7 +789,6 @@ echo $NSIM_ID > /sys/bus/netdevsim/new_device
 echo 0 > $NSIM_DEV_SYS/del_port
 
 echo 0 > $NSIM_DEV_DFS/udp_ports_open_only
-echo 1 > $NSIM_DEV_DFS/udp_ports_sleep
 echo 1 > $NSIM_DEV_DFS/udp_ports_shared
 
 old_netdevs=$(ls /sys/class/net)
-- 
2.49.0


