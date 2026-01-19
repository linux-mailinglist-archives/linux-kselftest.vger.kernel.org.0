Return-Path: <linux-kselftest+bounces-49322-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CF1D39DFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 06:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BE553010FFC
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 05:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2770A331202;
	Mon, 19 Jan 2026 05:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YaDxe0x9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003F8330D35
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768801254; cv=none; b=g5d//oOXde5Ogxwj53Jwaplg7QmbfiqnrmYiNULvpeIWNwvX6bfXBsHflTmERS/8JjjiG/id23YubL9r/MO/VcjHqSDFjyfDB5KxIhXqb3PBjeneMqPpBe3n58u1vtA+kqIEY/tlSKgiKj2mfSHilNsSknUOyU5vHLaTzysTW40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768801254; c=relaxed/simple;
	bh=YAvQxpdgt1WKlRFO7jvB0fVvQE9KxlMsOksUbfY7JkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gSzCiA3QfgfeYCTRtjxvx8TDQ/zrWg/VjPgq+AilmWT4IEX/b+hs+So6PbaV3PY05gYsx0v/RDXh9WVwuP3g1wm+EFn1mJz2ieQ6DDcxpsd71UE8Yl5qiS4iBRBnoA3uOd6vBtygSrMS8glI4+/EF1CijPtFjeg+7m35w5ACCZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YaDxe0x9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768801250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TSymtOAz4BKjHE60zeB8jOJnB2lXibwng+Q6/NjtkGw=;
	b=YaDxe0x9kN3P1zK/ZgCEXFJjvVOs1RtSf7yhvk95Vuvl2nG+yZ7f6AyXVYAqqXUJBPI2M6
	6sUeWmj82SEd6utbOOfBdrj9uIbjByy9Pb3ZK+LJxlnd6mILMMHyVWzCru1XZtlVljQLFK
	Shw4IRcIhWL3ft4G3vvG4ebjgsmvWoE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-jK19atPxOFq02Fkrudv-UA-1; Mon,
 19 Jan 2026 00:40:46 -0500
X-MC-Unique: jK19atPxOFq02Fkrudv-UA-1
X-Mimecast-MFC-AGG-ID: jK19atPxOFq02Fkrudv-UA_1768801245
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D21EA1800350;
	Mon, 19 Jan 2026 05:40:44 +0000 (UTC)
Received: from xudu-thinkpadx1carbongen9.nay.csb (unknown [10.72.116.28])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4261818004D8;
	Mon, 19 Jan 2026 05:40:38 +0000 (UTC)
From: Xu Du <xudu@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 3/7] selftest: tun: Refactor tun_delete to use tuntap_helpers
Date: Mon, 19 Jan 2026 13:40:00 +0800
Message-ID: <58c5767a8a82352fb784d8d51ec844055b6d7ff2.1768800198.git.xudu@redhat.com>
In-Reply-To: <cover.1768800198.git.xudu@redhat.com>
References: <cover.1768800198.git.xudu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The previous patch introduced common tuntap helpers to simplify
tun test code. This patch refactors the tun_delete function to
use these new helpers.

Signed-off-by: Xu Du <xudu@redhat.com>
---
v4 -> v5:
 - Delete device using the new ip link YNL API.
 - Linked YNL library to the tun program.

 tools/testing/selftests/net/Makefile |  7 ++---
 tools/testing/selftests/net/tun.c    | 39 ++--------------------------
 2 files changed, 6 insertions(+), 40 deletions(-)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..64e941e6a88f 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -180,7 +180,6 @@ TEST_GEN_PROGS := \
 	tap \
 	tcp_port_share \
 	tls \
-	tun \
 # end of TEST_GEN_PROGS
 
 TEST_FILES := \
@@ -192,7 +191,9 @@ TEST_FILES := \
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller
-YNL_GEN_PROGS := netlink-dumps
+YNL_GEN_PROGS := \
+	netlink-dumps \
+	tun \
 TEST_GEN_FILES += $(YNL_GEN_FILES)
 TEST_GEN_PROGS += $(YNL_GEN_PROGS)
 
@@ -203,7 +204,7 @@ TEST_INCLUDES := forwarding/lib.sh
 include ../lib.mk
 
 # YNL build
-YNL_GENS := netdev
+YNL_GENS := netdev rt-route rt-addr rt-neigh rt-link
 include ynl.mk
 
 $(OUTPUT)/epoll_busy_poll: LDLIBS += -lcap
diff --git a/tools/testing/selftests/net/tun.c b/tools/testing/selftests/net/tun.c
index 128b0a5327d4..d9030bdd2e06 100644
--- a/tools/testing/selftests/net/tun.c
+++ b/tools/testing/selftests/net/tun.c
@@ -8,14 +8,12 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <linux/if.h>
 #include <linux/if_tun.h>
-#include <linux/netlink.h>
-#include <linux/rtnetlink.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 
 #include "kselftest_harness.h"
+#include "tuntap_helpers.h"
 
 static int tun_attach(int fd, char *dev)
 {
@@ -66,40 +64,7 @@ static int tun_alloc(char *dev)
 
 static int tun_delete(char *dev)
 {
-	struct {
-		struct nlmsghdr nh;
-		struct ifinfomsg ifm;
-		unsigned char data[64];
-	} req;
-	struct rtattr *rta;
-	int ret, rtnl;
-
-	rtnl = socket(AF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
-	if (rtnl < 0) {
-		fprintf(stderr, "can't open rtnl: %s\n", strerror(errno));
-		return 1;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.nh.nlmsg_len = NLMSG_ALIGN(NLMSG_LENGTH(sizeof(req.ifm)));
-	req.nh.nlmsg_flags = NLM_F_REQUEST;
-	req.nh.nlmsg_type = RTM_DELLINK;
-
-	req.ifm.ifi_family = AF_UNSPEC;
-
-	rta = (struct rtattr *)(((char *)&req) + NLMSG_ALIGN(req.nh.nlmsg_len));
-	rta->rta_type = IFLA_IFNAME;
-	rta->rta_len = RTA_LENGTH(IFNAMSIZ);
-	req.nh.nlmsg_len += rta->rta_len;
-	memcpy(RTA_DATA(rta), dev, IFNAMSIZ);
-
-	ret = send(rtnl, &req, req.nh.nlmsg_len, 0);
-	if (ret < 0)
-		fprintf(stderr, "can't send: %s\n", strerror(errno));
-	ret = (unsigned int)ret != req.nh.nlmsg_len;
-
-	close(rtnl);
-	return ret;
+	return ip_link_del(dev);
 }
 
 FIXTURE(tun)
-- 
2.49.0


