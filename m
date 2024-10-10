Return-Path: <linux-kselftest+bounces-19434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66D8998387
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 12:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8B41F22FB7
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 10:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63CA1C1AB6;
	Thu, 10 Oct 2024 10:26:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F871BF324;
	Thu, 10 Oct 2024 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556012; cv=none; b=H1FIG+7BxK9xlnAUDyVuhlyLQcLDwj2BR4jWeL9ry2Vnj3HaJnlRl4/gReAjZdKgAVaFFe1xid1yFvfoD49CyJ+iQpb7uepr5ju2ypVwXWirsm4JdkPPJR9deNFZWjsW0u0CazELdsc9FqqfA5yFlgX7DdsFnMyn7+dR9VieH5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556012; c=relaxed/simple;
	bh=n6Pyknfvtq8jCstOTEB1lqtTghs0zco2bDfrzky9UhI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bskAck0AQi6v7TKIZKzFGYFu1FY9U6mjLsLXTbHWdTHws8oovNyh86HqRIja36So5HOhKzsJ38q9Lm03Xq9M3/50Xrc8/4tGYAvv3hBmXosVuGNUp8uKLqUBvnuOUUJM230dR4JZK0TlYGvOmQ9HZ2oDzswZPAxGShdol6gCIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XPQmh115qz6LCfc;
	Thu, 10 Oct 2024 18:22:28 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id BFBF9140A36;
	Thu, 10 Oct 2024 18:26:48 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 10 Oct
 2024 12:26:43 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v03 2/3] selftests: net/psock_fanout: socket joins fanout when link is down
Date: Thu, 10 Oct 2024 13:25:13 +0300
Message-ID: <f4c7ff8569359219a952c72ff461ebe43eb0c7e2.1728555449.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728555449.git.gur.stavi@huawei.com>
References: <cover.1728555449.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 frapeml500005.china.huawei.com (7.182.85.13)

Modify test_control_group to have toggle parameter.
When toggle is non-zero, loopback device will be set down for the
initialization of fd[1] which is still expected to successfully join
the fanout.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 tools/testing/selftests/net/psock_fanout.c | 42 ++++++++++++++++++++--
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index 4f31e92ebd96..acdfae8f8a9a 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -48,6 +48,7 @@
 #include <string.h>
 #include <sys/mman.h>
 #include <sys/socket.h>
+#include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <unistd.h>
@@ -59,6 +60,33 @@
 
 static uint32_t cfg_max_num_members;
 
+static void loopback_set_up_down(int state_up)
+{
+	struct ifreq ifreq = {};
+	int fd, err;
+
+	fd = socket(AF_PACKET, SOCK_RAW, 0);
+	if (fd < 0) {
+		perror("socket loopback");
+		exit(1);
+	}
+	strcpy(ifreq.ifr_name, "lo");
+	err = ioctl(fd, SIOCGIFFLAGS, &ifreq);
+	if (err) {
+		perror("SIOCGIFFLAGS");
+		exit(1);
+	}
+	if (state_up != !!(ifreq.ifr_flags & IFF_UP)) {
+		ifreq.ifr_flags ^= IFF_UP;
+		err = ioctl(fd, SIOCSIFFLAGS, &ifreq);
+		if (err) {
+			perror("SIOCSIFFLAGS");
+			exit(1);
+		}
+	}
+	close(fd);
+}
+
 /* Open a socket in a given fanout mode.
  * @return -1 if mode is bad, a valid socket otherwise */
 static int sock_fanout_open(uint16_t typeflags, uint16_t group_id)
@@ -264,17 +292,22 @@ static void test_control_single(void)
 }
 
 /* Test illegal group with different modes or flags */
-static void test_control_group(void)
+static void test_control_group(int toggle)
 {
 	int fds[2];
 
-	fprintf(stderr, "test: control multiple sockets\n");
+	if (toggle)
+		fprintf(stderr, "test: control multiple sockets with link down toggle\n");
+	else
+		fprintf(stderr, "test: control multiple sockets\n");
 
 	fds[0] = sock_fanout_open(PACKET_FANOUT_HASH, 0);
 	if (fds[0] == -1) {
 		fprintf(stderr, "ERROR: failed to open HASH socket\n");
 		exit(1);
 	}
+	if (toggle)
+		loopback_set_up_down(0);
 	if (sock_fanout_open(PACKET_FANOUT_HASH |
 			       PACKET_FANOUT_FLAG_DEFRAG, 0) != -1) {
 		fprintf(stderr, "ERROR: joined group with wrong flag defrag\n");
@@ -294,6 +327,8 @@ static void test_control_group(void)
 		fprintf(stderr, "ERROR: failed to join group\n");
 		exit(1);
 	}
+	if (toggle)
+		loopback_set_up_down(1);
 	if (close(fds[1]) || close(fds[0])) {
 		fprintf(stderr, "ERROR: closing sockets\n");
 		exit(1);
@@ -489,7 +524,8 @@ int main(int argc, char **argv)
 	int port_off = 2, tries = 20, ret;
 
 	test_control_single();
-	test_control_group();
+	test_control_group(0);
+	test_control_group(1);
 	test_control_group_max_num_members();
 	test_unique_fanout_group_ids();
 
-- 
2.45.2


