Return-Path: <linux-kselftest+bounces-49001-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E90D23568
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 10:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 874D330DB54E
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Jan 2026 09:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F274342526;
	Thu, 15 Jan 2026 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ubX5azMq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB7C34216C;
	Thu, 15 Jan 2026 09:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768467770; cv=none; b=KurOPkgV2StONxgi5K7bomRBef1/CnayEq3usAITPuIZlaKYWT+3RWiK55gBTy6p+7JIkEylZWjMG3x/2F0CpgLP+uWaAj7O/+JmXsxIXRGQN9BZA/py1uJt3IOsSr79laAiaTGpvJkrxieOZQ7bMSn2DcD48UanCobHdWcYiwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768467770; c=relaxed/simple;
	bh=OJj8CRmBJiC3L/Xh0D1spEOAiNmtLuldfxbZuCRn0ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WIr74MGpAFdnhbfPYAd2Ki2TGdlPAylW7xFFJliW7bcYtvhwS0Cp4GHHHcYQam4HhuOvabYBHFNUZbLrZmtI9XRRI7BwCw7Zfv4qsTgdy5xrweHB0QqtLsrEkLpCXUodQv23muqCxWcxc8PNaRZ4jYUsGcOc3wLNVQCcEYRCs2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ubX5azMq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C217C19421;
	Thu, 15 Jan 2026 09:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768467770;
	bh=OJj8CRmBJiC3L/Xh0D1spEOAiNmtLuldfxbZuCRn0ZI=;
	h=From:To:Cc:Subject:Date:From;
	b=ubX5azMqdkrf9FZ5tv34PY1boGwgvK0kZf0QdGDz4KUfT9TSD6NfbTSYITwsG/H6b
	 ZA+gyY1uRUuJzDh0Mglfta50RGX3PWKFcpGwxWiuaZJdvytZBf9PXkPXQ5XYOlEO/Y
	 gD8XZQRCg81iY59uEKZC9XSmCW54TQ0D9gLE2znmowtTX/PoTAy9dHRWHcCJF0lHkW
	 /FHWCv796uJi1zm8nT/9+4hhSKhIrXv+WW9+XEcovAtgwZnWT17Yr8BTu/aHuiSKOo
	 HUQBYwI4oVRLZMDLCp0DwF3Gfr+sUCVaWW6lD/s/To0+AprIoj4kWqL9EFfP/xoaZY
	 GYzuUZyK+isGA==
From: Geliang Tang <geliang@kernel.org>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Gang Yan <yangang@kylinos.cn>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	mptcp@lists.linux.dev,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH net-next v2] selftests: tls: use mkstemp instead of open(O_TMPFILE)
Date: Thu, 15 Jan 2026 17:02:40 +0800
Message-ID: <2fa14a04f5287c956a1112cef8cdfb2c86931d2d.1768467496.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gang Yan <yangang@kylinos.cn>

When running TLS tests in a virtual machine/container environment, they
fail in test_mutliproc():

 # tls.c:1479:mutliproc_even: Expected fd (-1) >= 0 (0)
 # mutliproc_even: Test terminated by assertion
 #          FAIL  tls.12_aes_gcm.mutliproc_even
 not ok 59 tls.12_aes_gcm.mutliproc_even
 #  RUN           tls.12_aes_gcm.mutliproc_readers ...
 # tls.c:1479:mutliproc_readers: Expected fd (-1) >= 0 (0)
 # mutliproc_readers: Test terminated by assertion
 #          FAIL  tls.12_aes_gcm.mutliproc_readers
 not ok 60 tls.12_aes_gcm.mutliproc_readers
 #  RUN           tls.12_aes_gcm.mutliproc_writers ...
 # tls.c:1479:mutliproc_writers: Expected fd (-1) >= 0 (0)
 # mutliproc_writers: Test terminated by assertion
 #          FAIL  tls.12_aes_gcm.mutliproc_writers
 not ok 61 tls.12_aes_gcm.mutliproc_writers

This is because the /tmp directory uses the virtiofs filesystem, which does
not support the O_TMPFILE feature.

This patch uses mkstemp() to create temporary files, just like the approach
used in chunked_sendfile(), thereby eliminating the dependency on the
O_TMPFILE feature.

For better code reuse, factor out this code from chunked_sendfile() into a
separate helper create_temp_file(). Use this new heler in test_mutliproc()
and closes the file descriptor (fd) after the test ends.

Co-developed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
---
v2:
 - factor out a new helper, use it in both chunked_sendfile() and
   test_mutliproc().
---
 tools/testing/selftests/net/tls.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 9e2ccea13d70..2eaacb7f2e56 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -467,6 +467,15 @@ TEST_F(tls, send_then_sendfile)
 	close(filefd);
 }
 
+static int create_temp_file(void)
+{
+	char filename[] = "/tmp/mytemp.XXXXXX";
+	int fd = mkstemp(filename);
+
+	unlink(filename);
+	return fd;
+}
+
 static void chunked_sendfile(struct __test_metadata *_metadata,
 			     struct _test_data_tls *self,
 			     uint16_t chunk_size,
@@ -476,11 +485,9 @@ static void chunked_sendfile(struct __test_metadata *_metadata,
 	uint16_t test_payload_size;
 	int size = 0;
 	int ret;
-	char filename[] = "/tmp/mytemp.XXXXXX";
-	int fd = mkstemp(filename);
+	int fd = create_temp_file();
 	off_t offset = 0;
 
-	unlink(filename);
 	ASSERT_GE(fd, 0);
 	EXPECT_GE(chunk_size, 1);
 	test_payload_size = chunk_size + extra_payload_size;
@@ -1469,7 +1476,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 	write_bias = n_readers / n_writers ?: 1;
 
 	/* prep a file to send */
-	fd = open("/tmp/", O_TMPFILE | O_RDWR, 0600);
+	fd = create_temp_file();
 	ASSERT_GE(fd, 0);
 
 	memset(buf, 0xac, file_sz);
@@ -1527,6 +1534,7 @@ test_mutliproc(struct __test_metadata *_metadata, struct _test_data_tls *self,
 			left -= res;
 		}
 	}
+	close(fd);
 }
 
 TEST_F(tls, mutliproc_even)
-- 
2.51.0


