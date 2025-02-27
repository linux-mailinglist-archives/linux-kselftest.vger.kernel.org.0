Return-Path: <linux-kselftest+bounces-27765-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 830B6A48171
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B121171DCA
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Feb 2025 14:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9FA2356DD;
	Thu, 27 Feb 2025 14:23:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90923314A;
	Thu, 27 Feb 2025 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740666232; cv=none; b=QFqYiMGLr/k1H6nGXXTd8N3ln1eP+1m5IvgVX+0yssKSxFeDvO4EtVidbfNG+J8nf7At8/jyX78lBTLfU09dodteyJ/aga8okisJzJ1W7FgVj6uzcvgErE+JfY30Fh34OYQM3dnLB5BxaJXZmWZ+4n0K1qyj4M1Mg4nyey6j3sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740666232; c=relaxed/simple;
	bh=03sAEGF3NOk7mjI1ev2+8BtpFDYJbhutU/3ZJkMU0hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWnDlXrdZybTdmteFbh8otu1cfsnCUPPjBR2WFMNX6bQ5zvuuj/8D+EWiaDFQ35uhU1w3YTu1Q4sIQXiNbbdP1m7WbGVTO0LpVe2plzgVib877J4ZGtawxGRUbDZAjs3vba3SYKQIz9uFM6prwaWGB3KSrI6QLszQeD3r4c5NbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenV-0005EW-Um; Thu, 27 Feb 2025 15:23:33 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tnenW-000B1d-0J;
	Thu, 27 Feb 2025 15:23:33 +0100
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
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	hawk@kernel.org,
	marcus.wichelmann@hetzner-cloud.de,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH bpf-next v4 3/6] selftests/bpf: move open_tuntap to network helpers
Date: Thu, 27 Feb 2025 14:23:27 +0000
Message-ID: <20250227142330.1605996-4-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250227142330.1605996-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27562/Thu Feb 27 10:48:50 2025)

To test the XDP metadata functionality of the tun driver, it's necessary
to create a new tap device first. A helper function for this already
exists in lwt_helpers.h. Move it to the common network helpers header,
so it can be reused in other tests.

Signed-off-by: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
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


