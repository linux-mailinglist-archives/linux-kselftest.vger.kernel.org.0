Return-Path: <linux-kselftest+bounces-32574-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC672AAE099
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 15:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85FF04E6541
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99107286D7A;
	Wed,  7 May 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ks+efcaR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0728620CCD8;
	Wed,  7 May 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623974; cv=none; b=btRPuDrLeKAv31ghK10+9AWi2NxZg1N/zUCHiVwIJxu01zYYA18grL3iabQB7Hxxw2/wOLv1v54gyKABujCa1WPQmtCqVxeTy3lU+ZRgnNUYBmyZqgsz7gzR7H+ah0/P4YhUrb6PXfv86Sv/19vx00cUsXZwavi0Pr2aufhjI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623974; c=relaxed/simple;
	bh=fYBZ3e80lB7pnNPogmHpxRb6JLRnBdbF4Ja5yF5QpuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6Gcj+V8Xxz50wAlPcmtt4cINUpV2lTOJAITo7VimtGcWaP/8wrmlilf7CPlZIKFAyrRzW75TwnxtumVvZ2jACSO/MUkFBQ6Ge/McxiZbb7vB1/fnrThoRClZcT0U9VE8tuM/AsHFWu112nYL5AX80FBoRCFwv3jvwNTM+9VUPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ks+efcaR; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22e4db05fe8so17435495ad.0;
        Wed, 07 May 2025 06:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746623971; x=1747228771; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OYrEDWYc5BP3GcwX3PUi68NFmiVIngMEPgSuDqL8ai8=;
        b=ks+efcaRH2IpGpbya8yKD5Z6yWzVIOFKsNxpXMWBQhBm32V7kih650B8HPNrDmX7bL
         nUrTj0YdTbkkbXGgVczYYC3QE3LyUiHgBWlU/rfERPVcadXVpZv15n+I2lX5rzTenycx
         k5VhdszulQbdVZuH0A88ZM3IRYwk3VqMwh/i3CQxtYWbA1VNNqjalOos+nSqx6y84XD9
         csbBGDEszoA6GYO2ijLSvpXQi5zHOrHr29J097lLPTxd9uix4xCRMzzrPECkn28zkbJZ
         PgzZoK4bti4FJrQRR+noFJ/zYR4rrtqECbuUu63n7aSETCE5xVw3VrAuNUd2ONm2XPih
         VQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746623971; x=1747228771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OYrEDWYc5BP3GcwX3PUi68NFmiVIngMEPgSuDqL8ai8=;
        b=Qm8kF2NHOQd+Le+SA6OnHf/GlcSe6+ppQMbHLjbVNjzgQSlKXwX17WJTHsHrQ+nha8
         Ny+XNc0tLp8BEr+YaGdtapzpBEXrKDHyVikebwohVLABV9rXCHLXfX9AHDtA2R4jrkC9
         xNfZqSWvIoPIaG+okBedJU3T0poPSEGFG6YdQE2ZT8KeIeipG4Xn/TSzCS9/jWElpl50
         2qqTySWfSvnUkAmqXR3okBfJXcMvKopRFKPwHBXH79ieh2zc3OvnZSKtutRWB06C01tA
         JkiVYeBpmuqceYcfilsKcyWCUUpTJds1CAO4bHXKuJUc450XOO7zr0WGyheXJRedS2cn
         81ng==
X-Forwarded-Encrypted: i=1; AJvYcCUWi7yO9hrbFM/9rna5s8p9UX0cUFr/aGdpHSpHPSjVRW6kar2objr/uJEDPYGWaYbj5ofzvefLJ878ElUkjdRT@vger.kernel.org, AJvYcCX6aLc4La17pa2t29n9aA1fLqGkx0AUCWyB4XhQBDYFlk+jqcHT2AZUIPN9qabGk+7r07lTPC8AJAaHp1jgLKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uFLk85FFmrMgKqLt+DvUvmTFwEtbD2Och+RrCgKtOjR3/JZc
	9cJbfnMjLp1yoXclE1yUpWT14S5ZHPynbowE8C+c9w2xWmaevWLMpsZ2EKpL
X-Gm-Gg: ASbGnct6lWBgNxUq+cJcoUhXicGuvDF6BRbBUmq2XC9kORlGrzQlWs5GLdUOVV7yKQO
	uVo/1vvRwo00ZhtFIGMpet10XhlN8xL/gLkbZx0n8fSBBwxyJQ1RHT/IwUoFL5Ixr+3Q4OMIpwZ
	IHrwhVQ2hLTTFpaVIFrqilwyFGG/ryxcO2cvqmL34Im5eAuLBcVzAQytdpR6sIAF9QKGFV+Q8tR
	XQUWi8MYioP+kpV+1xsoZZRS0gqZnt0AyDl8k5S8zKy3DijKF9QXi1E8lp2/g6HXIxALNhSJpRs
	k/Y0Xxgu7SToX0zjy/1dL0TU+i7z2r4ip2KX7ws+5nYiN3a9peLdt9ET86+K
X-Google-Smtp-Source: AGHT+IFcB8rrpPc/W8GojrdBVj5ziaCC/Up0DBiCXkXM+BRizqruSdRdtXgKjxFcs3ANOlkhgNgW1g==
X-Received: by 2002:a17:902:ef08:b0:22e:485a:b45 with SMTP id d9443c01a7336-22e5ede6e43mr49600015ad.46.1746623970937;
        Wed, 07 May 2025 06:19:30 -0700 (PDT)
Received: from fedora.dns.podman ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e5e93ee88sm17414765ad.86.2025.05.07.06.19.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 06:19:30 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next 3/6] selftests: net: use setup_ns for bareudp testing
Date: Wed,  7 May 2025 13:18:53 +0000
Message-ID: <20250507131856.78393-4-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250507131856.78393-1-liuhangbin@gmail.com>
References: <20250507131856.78393-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch bareudp testing to use setup_ns, which sets up rp_filter by default.
This allows us to remove the manual rp_filter configuration from the script.

Additionally, since setup_ns handles namespace naming and cleanup, we no
longer need a separate cleanup function. We also move the trap setup earlier
in the script, before the test setup begins.

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 tools/testing/selftests/net/bareudp.sh | 49 ++++----------------------
 1 file changed, 7 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/net/bareudp.sh b/tools/testing/selftests/net/bareudp.sh
index f366cadbc5e8..4046131e7888 100755
--- a/tools/testing/selftests/net/bareudp.sh
+++ b/tools/testing/selftests/net/bareudp.sh
@@ -106,26 +106,16 @@
 # |                                                                       |
 # +-----------------------------------------------------------------------+
 
+. ./lib.sh
+
 ERR=4 # Return 4 by default, which is the SKIP code for kselftest
 PING6="ping"
 PAUSE_ON_FAIL="no"
 
-readonly NS0=$(mktemp -u ns0-XXXXXXXX)
-readonly NS1=$(mktemp -u ns1-XXXXXXXX)
-readonly NS2=$(mktemp -u ns2-XXXXXXXX)
-readonly NS3=$(mktemp -u ns3-XXXXXXXX)
-
 # Exit the script after having removed the network namespaces it created
-#
-# Parameters:
-#
-#   * The list of network namespaces to delete before exiting.
-#
 exit_cleanup()
 {
-	for ns in "$@"; do
-		ip netns delete "${ns}" 2>/dev/null || true
-	done
+	cleanup_all_ns
 
 	if [ "${ERR}" -eq 4 ]; then
 		echo "Error: Setting up the testing environment failed." >&2
@@ -140,17 +130,7 @@ exit_cleanup()
 # namespaces created by this script are deleted.
 create_namespaces()
 {
-	ip netns add "${NS0}" || exit_cleanup
-	ip netns add "${NS1}" || exit_cleanup "${NS0}"
-	ip netns add "${NS2}" || exit_cleanup "${NS0}" "${NS1}"
-	ip netns add "${NS3}" || exit_cleanup "${NS0}" "${NS1}" "${NS2}"
-}
-
-# The trap function handler
-#
-exit_cleanup_all()
-{
-	exit_cleanup "${NS0}" "${NS1}" "${NS2}" "${NS3}"
+	setup_ns NS0 NS1 NS2 NS3 || exit_cleanup
 }
 
 # Configure a network interface using a host route
@@ -188,10 +168,6 @@ iface_config()
 #
 setup_underlay()
 {
-	for ns in "${NS0}" "${NS1}" "${NS2}" "${NS3}"; do
-		ip -netns "${ns}" link set dev lo up
-	done;
-
 	ip link add name veth01 netns "${NS0}" type veth peer name veth10 netns "${NS1}"
 	ip link add name veth12 netns "${NS1}" type veth peer name veth21 netns "${NS2}"
 	ip link add name veth23 netns "${NS2}" type veth peer name veth32 netns "${NS3}"
@@ -234,14 +210,6 @@ setup_overlay_ipv4()
 	ip netns exec "${NS2}" sysctl -qw net.ipv4.ip_forward=1
 	ip -netns "${NS1}" route add 192.0.2.100/32 via 192.0.2.10
 	ip -netns "${NS2}" route add 192.0.2.103/32 via 192.0.2.33
-
-	# The intermediate namespaces don't have routes for the reverse path,
-	# as it will be handled by tc. So we need to ensure that rp_filter is
-	# not going to block the traffic.
-	ip netns exec "${NS1}" sysctl -qw net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${NS2}" sysctl -qw net.ipv4.conf.all.rp_filter=0
-	ip netns exec "${NS1}" sysctl -qw net.ipv4.conf.default.rp_filter=0
-	ip netns exec "${NS2}" sysctl -qw net.ipv4.conf.default.rp_filter=0
 }
 
 setup_overlay_ipv6()
@@ -521,13 +489,10 @@ done
 
 check_features
 
-# Create namespaces before setting up the exit trap.
-# Otherwise, exit_cleanup_all() could delete namespaces that were not created
-# by this script.
-create_namespaces
-
 set -e
-trap exit_cleanup_all EXIT
+trap exit_cleanup EXIT
+
+create_namespaces
 
 setup_underlay
 setup_overlay_ipv4
-- 
2.46.0


