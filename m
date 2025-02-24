Return-Path: <linux-kselftest+bounces-27357-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A46FA42649
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 16:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FD1C1790E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E65D24EF96;
	Mon, 24 Feb 2025 15:29:44 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9973E23BCEA;
	Mon, 24 Feb 2025 15:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740410984; cv=none; b=KYvb5poL7qQpeCMV+TcgJ4xS10NakK7Ns1bdmVGnvb0kkuAo1ELqXnNebOFl6N2dvtHJRRWNBPvuTF7SIboJmuGeSmBPa7wAy9nbg3yyVjDye2UgORCGrE60HcUEurXit4zFaBxe3vSwp5pywx3zxxc/uYpplWnS8zFymw+0DOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740410984; c=relaxed/simple;
	bh=riH3QIs5pbvGJv1C6PfdADXMONR4L91TV2bzn26/NZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDajG7DBoT28U0OE6HWapEaGgQVo51pSKGWwvJ04fvUY7p4doWqEkvWvIQZdDqKgFt+2Hwv1CMDJTq7MQL3zVLMwL6y2UwYZrtFTb6BKsglVoTjC00FmzQUXbvZn1Et+U0D0NMrI4wKX9wZTO5QMsFDVh9gZc+X3Qy7wSvqlhFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-000A2D-TI; Mon, 24 Feb 2025 16:29:14 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tmaOQ-0005Hj-21;
	Mon, 24 Feb 2025 16:29:14 +0100
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
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de
Subject: [PATCH bpf-next v3 3/6] selftests/bpf: move open_tuntap to network helpers
Date: Mon, 24 Feb 2025 15:29:06 +0000
Message-ID: <20250224152909.3911544-4-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250224152909.3911544-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27559/Mon Feb 24 10:44:14 2025)

To test the XDP metadata functionality of the tun driver, it's necessary
to create a new tap device first. A helper function for this already
exists in lwt_helpers.h. Move it to the common network helpers header,
so it can be reused in other tests.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
---
 tools/testing/selftests/bpf/network_helpers.c | 28 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 ++
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 29 -------------------
 3 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 737a952dcf80..e1cfa1b37754 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -565,6 +565,34 @@ void close_netns(struct nstoken *token)
 	free(token);
 }
 
+int open_tuntap(const char *dev_name, bool need_mac)
+{
+	int err = 0;
+	struct ifreq ifr;
+	int fd = open("/dev/net/tun", O_RDWR);
+
+	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
+		return -1;
+
+	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
+	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
+	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
+
+	err = ioctl(fd, TUNSETIFF, &ifr);
+	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
+		close(fd);
+		return -1;
+	}
+
+	err = fcntl(fd, F_SETFL, O_NONBLOCK);
+	if (!ASSERT_OK(err, "fcntl(O_NONBLOCK)")) {
+		close(fd);
+		return -1;
+	}
+
+	return fd;
+}
+
 int get_socket_local_port(int sock_fd)
 {
 	struct sockaddr_storage addr;
diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 9f6e05d886c5..99d1417c1d8b 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -8,6 +8,7 @@
 typedef __u16 __sum16;
 #include <linux/if_ether.h>
 #include <linux/if_packet.h>
+#include <linux/if_tun.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/ethtool.h>
@@ -98,6 +99,8 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes);
 int make_netns(const char *name);
 int remove_netns(const char *name);
 
+int open_tuntap(const char *dev_name, bool need_mac);
+
 /**
  * append_tid() - Append thread ID to the given string.
  *
diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
index fb1eb8c67361..ccec0fcdabc1 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_helpers.h
@@ -5,7 +5,6 @@
 
 #include <time.h>
 #include <net/if.h>
-#include <linux/if_tun.h>
 #include <linux/icmp.h>
 
 #include "test_progs.h"
@@ -37,34 +36,6 @@ static inline int netns_delete(void)
 	return system("ip netns del " NETNS ">/dev/null 2>&1");
 }
 
-static int open_tuntap(const char *dev_name, bool need_mac)
-{
-	int err = 0;
-	struct ifreq ifr;
-	int fd = open("/dev/net/tun", O_RDWR);
-
-	if (!ASSERT_GT(fd, 0, "open(/dev/net/tun)"))
-		return -1;
-
-	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
-	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
-
-	err = ioctl(fd, TUNSETIFF, &ifr);
-	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
-		close(fd);
-		return -1;
-	}
-
-	err = fcntl(fd, F_SETFL, O_NONBLOCK);
-	if (!ASSERT_OK(err, "fcntl(O_NONBLOCK)")) {
-		close(fd);
-		return -1;
-	}
-
-	return fd;
-}
-
 #define ICMP_PAYLOAD_SIZE     100
 
 /* Match an ICMP packet with payload len ICMP_PAYLOAD_SIZE */
-- 
2.43.0


