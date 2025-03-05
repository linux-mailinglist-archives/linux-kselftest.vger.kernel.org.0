Return-Path: <linux-kselftest+bounces-28345-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2271A50DAD
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 22:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E823AF4C3
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 21:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3559125A358;
	Wed,  5 Mar 2025 21:35:21 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBB52580F7;
	Wed,  5 Mar 2025 21:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741210521; cv=none; b=SI0Nnghe/3IxJ1OOYzrGzAMuXdJ/aidH7psee+UICFEuQdyWutdfI7x/lNzobntZxWvr2AitfQjDtYudQ+jQKw8hAFWJJKlzCmTz8XfrrYXQAkpLIdNdi5Z+Mx2FZcjPgIaBchq7hqux8lWHNY1yX6vJOOlOb0dHP/ZKO7H4XKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741210521; c=relaxed/simple;
	bh=SqEnaK+MvxXR6Rdu8s12RiSEt6JOkLY1YRco0lsyCv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtMutx7uxFsLmugVehgOK/iYfVW/sGMkV00+gcReorGjdBSM7sICD8hWyuiIfTptZ+tOsJAyrU6EJPye+TGawUCtRZa2peCvTvj+d3OndYLVEUo7WdIcojQYOau8tSvgjsy4kyrdjnf/iana3gTMTFFaB4E8fsajI9LuW8rRqKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO3-000K1K-50; Wed, 05 Mar 2025 22:34:43 +0100
Received: from [78.47.5.107] (helo=sdn-nic-test01..)
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tpwO2-000MHO-0a;
	Wed, 05 Mar 2025 22:34:43 +0100
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
Subject: [PATCH bpf-next v5 3/6] selftests/bpf: move open_tuntap to network helpers
Date: Wed,  5 Mar 2025 21:34:35 +0000
Message-ID: <20250305213438.3863922-4-marcus.wichelmann@hetzner-cloud.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
References: <20250305213438.3863922-1-marcus.wichelmann@hetzner-cloud.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27568/Wed Mar  5 10:48:48 2025)

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
index 80844a5fb1fe..fcee2c4a637a 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -548,6 +548,34 @@ void close_netns(struct nstoken *token)
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
index ebec8a8d6f81..9235976d0c50 100644
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
@@ -85,6 +86,8 @@ int get_socket_local_port(int sock_fd);
 int get_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 int set_hw_ring_size(char *ifname, struct ethtool_ringparam *ring_param);
 
+int open_tuntap(const char *dev_name, bool need_mac);
+
 struct nstoken;
 /**
  * open_netns() - Switch to specified network namespace by name.
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


