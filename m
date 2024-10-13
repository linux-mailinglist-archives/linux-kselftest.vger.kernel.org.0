Return-Path: <linux-kselftest+bounces-19613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0DE99B8B7
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 09:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B5BA1C2123C
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Oct 2024 07:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6667C139579;
	Sun, 13 Oct 2024 07:17:47 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A845770E4;
	Sun, 13 Oct 2024 07:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728803867; cv=none; b=IMvANobNtglzxTMlBaUBXi5RH8IShF5i8Y8b90IyxjQUtoehr6scvxfYHsXjAyJHUGSMmwa4GX0S8QskP6gBp1uaIyjN/T2iusiL7PSnH9xQiMm23pG42pKI6hxXCdV5+WbtgLsFxCN5ROi/mH52YhtVg0qtxls0vmfi8QmZ1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728803867; c=relaxed/simple;
	bh=CFzNbzW1eEnEF6SnRyQ57jkQR8QwGYNI0Fag43gdHio=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTzxAb6i5tyQwiboaawtr34/JFsykv7yeh80RsAawQ3M5asYmwBqWWWOfLOwiw/DbqeTenM4B2aTEMK74DmKtD4b9suOlp45O1sUoxoAvxwrJ67rCJ3IPJi32EkEWZCiuTmTcaNoQqNbgfBwuXi/AlS6+uQkfB3v0qBUdSBdknU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRBWZ6XRGz6K5fZ;
	Sun, 13 Oct 2024 15:17:14 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A261140447;
	Sun, 13 Oct 2024 15:17:43 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sun, 13 Oct
 2024 09:17:37 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan
	<shuah@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH net-next v04 3/3] selftests: net/psock_fanout: unbound socket fanout
Date: Sun, 13 Oct 2024 10:15:27 +0300
Message-ID: <7612fa90f613100e2b64c563cab3d7fdf36010db.1728802323.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1728802323.git.gur.stavi@huawei.com>
References: <cover.1728802323.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 frapeml500005.china.huawei.com (7.182.85.13)

Add a test that validates that an unbound packet socket cannot create/join
a fanout group.

Signed-off-by: Gur Stavi <gur.stavi@huawei.com>
---
 tools/testing/selftests/net/psock_fanout.c | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/testing/selftests/net/psock_fanout.c b/tools/testing/selftests/net/psock_fanout.c
index acdfae8f8a9a..84c524357075 100644
--- a/tools/testing/selftests/net/psock_fanout.c
+++ b/tools/testing/selftests/net/psock_fanout.c
@@ -279,6 +279,41 @@ static int sock_fanout_read(int fds[], char *rings[], const int expect[])
 	return 0;
 }
 
+/* Test that creating/joining a fanout group fails for unbound socket without
+ * a specified protocol
+ */
+static void test_unbound_fanout(void)
+{
+	int val, fd0, fd1, err;
+
+	fprintf(stderr, "test: unbound fanout\n");
+	fd0 = socket(PF_PACKET, SOCK_RAW, 0);
+	if (fd0 < 0) {
+		perror("socket packet");
+		exit(1);
+	}
+	/* Try to create a new fanout group. Should fail. */
+	val = (PACKET_FANOUT_HASH << 16) | 1;
+	err = setsockopt(fd0, SOL_PACKET, PACKET_FANOUT, &val, sizeof(val));
+	if (!err) {
+		fprintf(stderr, "ERROR: unbound socket fanout create\n");
+		exit(1);
+	}
+	fd1 = sock_fanout_open(PACKET_FANOUT_HASH, 1);
+	if (fd1 == -1) {
+		fprintf(stderr, "ERROR: failed to open HASH socket\n");
+		exit(1);
+	}
+	/* Try to join an existing fanout group. Should fail. */
+	err = setsockopt(fd0, SOL_PACKET, PACKET_FANOUT, &val, sizeof(val));
+	if (!err) {
+		fprintf(stderr, "ERROR: unbound socket fanout join\n");
+		exit(1);
+	}
+	close(fd0);
+	close(fd1);
+}
+
 /* Test illegal mode + flag combination */
 static void test_control_single(void)
 {
@@ -523,6 +558,7 @@ int main(int argc, char **argv)
 	const int expect_uniqueid[2][2] = { { 20, 20},  { 20, 20 } };
 	int port_off = 2, tries = 20, ret;
 
+	test_unbound_fanout();
 	test_control_single();
 	test_control_group(0);
 	test_control_group(1);
-- 
2.45.2


