Return-Path: <linux-kselftest+bounces-14420-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DCA94043C
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 04:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E23D284051
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 02:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35B597FBD1;
	Tue, 30 Jul 2024 02:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qm+0ORO/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3C429D1C;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305610; cv=none; b=uYHKaaMppFx1plK8lhXxhgrJnC1D/E6elZdMZkImpqWzj3pn0/tOb2ILISQv2KZy9UISBwtwfulrFZFieu++O+YcftQGfolL+qpSkZ/nX3t1UA3fNlDyzJyKsHiMd9ZxS4DOhhLpegKNwuJAWBwKoH7Ht0fermPxfeHPyg0juak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305610; c=relaxed/simple;
	bh=gdo0igheQhF6s/jKqqf8T/+Oo8XxPTB3fpPf+BCe4so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W8MZaC08xrHfZ6ynVIAsSWwOv2BjasRNcjeo+0AvhHGpwbwtfDA04VC0NqOl6PYT1Iw22d3GpVGSs6hAbZwQPQBIsJhSJ8I79L7CfGkgDsPvc+jXnlfyROLeoGLclwNz7WT2qD7Xnz2vP0ALOhoAOU3FYTErcht3UpQx53L+Co4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qm+0ORO/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95352C4AF0F;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305609;
	bh=gdo0igheQhF6s/jKqqf8T/+Oo8XxPTB3fpPf+BCe4so=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Qm+0ORO/7gIElJjdJUS2he6hdPMplyrl3v9Ck70nXeTX46VLErjwT/j1eFUDITqQF
	 qUKMPaAeGY/D+YRrcUBkDEOFBxqwDUh16r3hL6OcWdqi0yN48tGdiPwLkPfRkm4LNW
	 Ob8RWkEdqP/zsX50EDKoJEml5WgTr65rVhr68QDjUI5AwFiZUzBbGkEG2myVArNuIU
	 /WCbTukVv6WrgzIbgsCUO70k2g+V6WmZGBkpNE8wD+573mSz0bVRTQN/5S155chNO6
	 fdTZt5m8ePxYQUYeadEbz+GuBpZjv7F0/sENjHqELpP6s5dWNVelWVdTFIbh9NpL8j
	 koIMC3SnubRQg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86606C3DA61;
	Tue, 30 Jul 2024 02:13:29 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Tue, 30 Jul 2024 03:12:17 +0100
Subject: [PATCH net-next 3/7] selftests/net: Be consistent in kconfig
 checks
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-tcp-ao-selftests-upd-6-12-v1-3-ffd4bf15d638@gmail.com>
References: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
In-Reply-To: <20240730-tcp-ao-selftests-upd-6-12-v1-0-ffd4bf15d638@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Mohammad Nassiri <mnassiri@ciena.com>, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722305607; l=2700;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=PdEStG299EXQfXQVBhomcx2f3Galb07Vq+9A5L4s+Lw=;
 b=uMBROFsSPN4MGu5IQV+mWnWwnDaL/ftb+UbVj6bG4WudU2Aen4e2F32hiz8AkRimC7Tto53Vt
 JD4v8GKGqKCDuf1FugHzWf7BCMWKiXL3uCyyzteQWb/iXt2DBnYntNj
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



