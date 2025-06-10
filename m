Return-Path: <linux-kselftest+bounces-34616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4770DAD403C
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 204D13A51A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8E724678B;
	Tue, 10 Jun 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxf/ALbo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B652459C9;
	Tue, 10 Jun 2025 17:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575731; cv=none; b=dqfPC1too3vOFj1wBUNsIg29Oq688j3NkscMOfdSU0IMb66GFqoRfh93nxYWInUksFIUfaRFDJ2IHxme4zfMIofjesoJ/Qab3/k5m3y3PRjSwX1tz4QCMFPF3Su+Ai42hwD6b2+nH0V4ifct2lXVkyIbPY3TE6tJMduq/Hqb1Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575731; c=relaxed/simple;
	bh=jrPADGdQVSlhHaHu88CYeq9ejs0dqL4pa8LW21dVeyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eDBmFEcwQQihMes4abNHVPkEILL5MGLwtBiwRp+QmYYcwyVMXfrgD0WefSjrs75j53YfmVF/vvMCPhsz0nVVAE0Q++m26D75/Mr5cLIgNRLsCtKSCF4KGEV2eW9MC99g45gQyGex/vusqeAFw7vBNMRbb5onNw8yy3quOrn9b0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qxf/ALbo; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-742c3d06de3so6566391b3a.0;
        Tue, 10 Jun 2025 10:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749575728; x=1750180528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sO4neuwpUVoDLsDzSFLxxvkPcabDlga25iey737Q9/w=;
        b=Qxf/ALbomQba8c+yLlzKIhnzhpheLJWTJmRPh47Dm35AzjH9qtAmVWTPXQTtwFCSzp
         jHwpDVppw3Mrgp/+XfV3mbEbEhJzTSh9HytMrlZcYF3VQ5ZQqyHeg0qDT9JOv7H4vV61
         Ros1eot/mGhnokYatGsxmmyUchlh5L9GNfDL4MXzvR0Xl9akzKX5/rLBDcTn9uiTKmLD
         72U6+tHmsVcYQgFdlYTfYyYOPWO6Q8NthPXLRpkQisdp9fVSaNY3trMgY5Z/TT7pjfIb
         wYoOj23DdtzhcsdEuAuJh6XoUgShdG/5WIF7qONPE0e4yy9XM/Nqd/ednyknIlkSsd78
         LfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749575728; x=1750180528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sO4neuwpUVoDLsDzSFLxxvkPcabDlga25iey737Q9/w=;
        b=HAqXdkYvwzpMuQm7jKd5u+VfliLRIK7aZcQF7ESVp5s4OraYBd0hmpkrGQqAg2NFZi
         S8fpCR++k6kLXAukGXRkM1+UX7XgWgmhG3MzrRLIEK3m1wiW+SEfWTojKDmZqOUbYTx/
         +9zWgKxK1Z27XvYshT7nlzFDJYn1Kezz07UOWZKNjL2m5TZZaxVpD4nF+5EU41jP+xa9
         V0GF3/1hbiEMrVTg2/gW7bFbyn1I9tDSu2uDujQmdq7HEA4W65g1G0nodBr+PkUXPBUG
         TKLtDVCUHmi2P6dUbsokHwDlp/x8WAeby6l+e7xapY0xXkZVaBh7RGJeH6fKAQLMPXvT
         DMgA==
X-Forwarded-Encrypted: i=1; AJvYcCW8zmAfm8oqnJQOJxKL05RJT1cm89re531AL4OduPsnYt03G7Zg8BvmOav/wbGI5UOiMZ1XW2GqfzXNsi8=@vger.kernel.org, AJvYcCWSagzO6wSk0Qxf+UpsXbqqpEiiIOifKFKaGmSBZv5sqchpA4lrwrJH+294R56oGwyfFL0/A7mkveqw1R2tttdv@vger.kernel.org, AJvYcCXARO625jr7pbx5GIWQDO2mV7plT7XpNDrSEAe+FPrdnwPbE0n/Ivzw8wIc9JU7EAnvPC2KqgjEYeodcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/E3KOO4qgx812abV5nqSjl8k0u5H1mhMmJ2cqAmRfuRTH17o+
	IlblrInJll/hQKWSgOK7UqketqDQd40zbxMplpvqm5t3ULeUIIEUbpJJ08U6
X-Gm-Gg: ASbGncvfGloED0o3TVd8UUUOJDpsUWi+zxY5hyYZoTcNipKzFsWs8vJ8vyiwYtG8Ilj
	4Wb36O7WQZBxymH1/8Qj2FkoSQD//dayqOlsrq+NojviIno5mZbEnG1DmynIoJVj/M5t0yPDQmH
	GUP12VMrIF+PJCkMR76+GRWCvuumCbWpY65mAWuFMRUpHAnn3CbodyhsVOC6k5l6hDe5cwWfb4y
	Ru4EdeI4LQvMIMFDcLB0wnQZLu46J4dXLnAACfzy0vt0VfJx60TdHTD9lE0s7fPkeILyho/xuka
	NzG8SxnrYPtYQFe2iq1cwAla+SvlOfD/OPnlxM0wuSjbYntDAsMe/nSs4W5croE5IPws+z0gYO/
	+hidE6tkaNqSpg83Xv4zRZTw=
X-Google-Smtp-Source: AGHT+IHQwD6S166ldxXHEAmMKaFIErFHVt3BndZz352NvZiGIWSykeBPCm21SoRRvyVBIk1bASc9ZA==
X-Received: by 2002:a05:6a21:3289:b0:21f:4459:c032 with SMTP id adf61e73a8af0-21f86618eccmr614511637.18.1749575728142;
        Tue, 10 Jun 2025 10:15:28 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7482b0c212fsm7901253b3a.135.2025.06.10.10.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 10:15:27 -0700 (PDT)
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
	ruanjinjie@huawei.com,
	mheib@redhat.com,
	stfomichev@gmail.com,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	oss-drivers@corigine.com,
	linux-net-drivers@amd.com,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v3 3/4] netdevsim: remove udp_ports_sleep
Date: Tue, 10 Jun 2025 10:15:21 -0700
Message-ID: <20250610171522.2119030-4-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610171522.2119030-1-stfomichev@gmail.com>
References: <20250610171522.2119030-1-stfomichev@gmail.com>
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


