Return-Path: <linux-kselftest+bounces-15455-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC948953CA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EC351F256E2
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 21:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A2C153824;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ih/YrelV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7191537DA;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723757569; cv=none; b=U484gl/CxV706AsKmVwfraZYKjveVqRfDx8iy3RTdrqO4fR2q6qfa3gwB3xnCj7ToezktPE63C7E6qOhVQ9TLQI9+rKtEsyfP0Us34avUeCgmqrAPPY/MKEb6MIuzZEDoj5E4zHDJKv5n7Stl9OuXfCzCAPQejfpp9MqKLQNLvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723757569; c=relaxed/simple;
	bh=gdo0igheQhF6s/jKqqf8T/+Oo8XxPTB3fpPf+BCe4so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hz4N5kK44kyFIMfr/NToKp6Ujb7u2cv7rKWzNXo57bDRQwKXbiw+zsNcXHfEzD0Imsk2VYvC2CLiABfG+rEqB69UAKJpOIqlJVBH3qWmsLWnrW9FmEnJk0HFp4FEHumfPQQR/+jQKfnCpxekEHXCg8DK1NBlKK9x4fv0prgOv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ih/YrelV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70FC3C4AF13;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723757569;
	bh=gdo0igheQhF6s/jKqqf8T/+Oo8XxPTB3fpPf+BCe4so=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ih/YrelVA5OJxWuyUz6eVmeHLFM+gvtxQN3Uv2iS1jEINgLwSs6uzZv0upd7lKnRf
	 6n71jV/D9BG01i0rh/BYuuiqMjjnKjZ1R4EnnwlX6xsX2x8uC0CKq4iGYXlE1AQbYJ
	 jkYF6xihlJCSluaNmpnznHf4AA58BIt+NcNO4ibbVY91l+vf7DrT/WXIrcqh3ufyBn
	 uBS/hcBM7c4iXLYAV7Lip22zI98ss6n7ww5zpalfVp/wGIelQL2996t74EtldEBeJa
	 tiROFxFVCEdVzrLND3HGQLs1y1bIlDGKkxY0A76P4ZVKjKp7wnIwmb+EJpdyab6kkb
	 kx51XmqE3gCfQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671B3C531DE;
	Thu, 15 Aug 2024 21:32:49 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Thu, 15 Aug 2024 22:32:28 +0100
Subject: [PATCH net-next v3 3/8] selftests/net: Be consistent in kconfig
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240815-tcp-ao-selftests-upd-6-12-v3-3-7bd2e22bb81c@gmail.com>
References: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
In-Reply-To: <20240815-tcp-ao-selftests-upd-6-12-v3-0-7bd2e22bb81c@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723757567; l=2700;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=PdEStG299EXQfXQVBhomcx2f3Galb07Vq+9A5L4s+Lw=;
 b=iovW/1DpM+jKPBlHxRE/q9+4fbbjyBcXErDQBbETW/u2kFISMrGLzkkgrfoa4qmcXqNx1MCbf
 ML+zsdyp/BkAV58VXsVRBf8n48vIPsQWEWmttRgfkPzZJ5s/C4YOHyP
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

Most of the functions in tcp-ao lib/ return negative errno or -1 in case
of a failure. That creates inconsistencies in lib/kconfig, which saves
what was the error code. As well as the uninitialized kconfig value is
-1, which also may be the result of a check.

Define KCONFIG_UNKNOWN and save negative return code, rather than
libc-style errno.

Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/kconfig.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
index f279ffc3843b..3bf4a7e4b3c9 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/kconfig.c
@@ -6,7 +6,7 @@
 #include "aolib.h"
 
 struct kconfig_t {
-	int _errno;		/* the returned error if not supported */
+	int _error;		/* negative errno if not supported */
 	int (*check_kconfig)(int *error);
 };
 
@@ -62,7 +62,7 @@ static int has_tcp_ao(int *err)
 	memcpy(&tmp.addr, &addr, sizeof(addr));
 	*err = 0;
 	if (setsockopt(sk, IPPROTO_TCP, TCP_AO_ADD_KEY, &tmp, sizeof(tmp)) < 0) {
-		*err = errno;
+		*err = -errno;
 		if (errno != ENOPROTOOPT)
 			ret = -errno;
 	}
@@ -87,7 +87,7 @@ static int has_tcp_md5(int *err)
 	 */
 	*err = 0;
 	if (test_set_md5(sk, addr_any, 0, -1, DEFAULT_TEST_PASSWORD)) {
-		*err = errno;
+		*err = -errno;
 		if (errno != ENOPROTOOPT && errno == ENOMEM) {
 			test_print("setsockopt(TCP_MD5SIG_EXT): %m");
 			ret = -errno;
@@ -116,13 +116,14 @@ static int has_vrfs(int *err)
 	return ret;
 }
 
+#define KCONFIG_UNKNOWN			1
 static pthread_mutex_t kconfig_lock = PTHREAD_MUTEX_INITIALIZER;
 static struct kconfig_t kconfig[__KCONFIG_LAST__] = {
-	{ -1, has_net_ns },
-	{ -1, has_veth },
-	{ -1, has_tcp_ao },
-	{ -1, has_tcp_md5 },
-	{ -1, has_vrfs },
+	{ KCONFIG_UNKNOWN, has_net_ns },
+	{ KCONFIG_UNKNOWN, has_veth },
+	{ KCONFIG_UNKNOWN, has_tcp_ao },
+	{ KCONFIG_UNKNOWN, has_tcp_md5 },
+	{ KCONFIG_UNKNOWN, has_vrfs },
 };
 
 const char *tests_skip_reason[__KCONFIG_LAST__] = {
@@ -138,11 +139,11 @@ bool kernel_config_has(enum test_needs_kconfig k)
 	bool ret;
 
 	pthread_mutex_lock(&kconfig_lock);
-	if (kconfig[k]._errno == -1) {
-		if (kconfig[k].check_kconfig(&kconfig[k]._errno))
+	if (kconfig[k]._error == KCONFIG_UNKNOWN) {
+		if (kconfig[k].check_kconfig(&kconfig[k]._error))
 			test_error("Failed to initialize kconfig %u", k);
 	}
-	ret = kconfig[k]._errno == 0;
+	ret = kconfig[k]._error == 0;
 	pthread_mutex_unlock(&kconfig_lock);
 	return ret;
 }

-- 
2.42.2



