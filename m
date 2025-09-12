Return-Path: <linux-kselftest+bounces-41377-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF45B54E73
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 14:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69AB11883E37
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52C73009CB;
	Fri, 12 Sep 2025 12:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CLwevAb3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84817304BBA;
	Fri, 12 Sep 2025 12:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757681503; cv=none; b=SIS1XXgzSaJHQOG25WkHtORJsT7xStGxgflPSTHlxFiDxI/9HTl7EOzv1jeGBz/nbYG4QwD2hr3hRfs1jvr1Ek81kCs5lnnDNaj2Q7/4WHzYdx2Aw8YWEtLfnh0GJVliqkDSEK0RkBhYus/2mJazRB9M1ObX84lwSa1unbTIx/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757681503; c=relaxed/simple;
	bh=2qOtmkngpDfQA1QjDe6RQo1pEYaj3+XYIoXwhftLLaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jb1suph0ULtZbYdOyddzaCHHN4Z40QPhGruZI5ReOvgyH+V1H0nBeZ7VvT6J6t1rcO5JFOVvrnZItU+/GbBP1XqxJFAvks9cC432AUtiWUWhWeiTaXC7H6u7P90uo9eQ9X00kr4qn31ceD7L3YibLf/+7xCWzO4Pm7m4EaLWbsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CLwevAb3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1757681499;
	bh=2qOtmkngpDfQA1QjDe6RQo1pEYaj3+XYIoXwhftLLaA=;
	h=From:To:Cc:Subject:Date:From;
	b=CLwevAb3CWcyJim69XKJIdeuO297ATtaWgZcLKBdj0cxs8L6/lJleYP4V5c3ARgzZ
	 mvApCazawRn7ksRS8rRgw7+M5IioDk889yvihSyxEjD01Xjzwl7h4yjXJw8uM+8EME
	 q9Efd0AFpPJRRxC4p1h44uM7i7JE1KaFCsr1tEnW6Oc2lQqZsOGK+fIEkro0Z3z5hQ
	 pUj37vBazcoYk04C2qJ8h1ERSRzNu82gQ9cVr78+0PC0w47vAOACV+O8RxHuiIcJ2c
	 QE3T8uVrL7Toa5dwJBwx4YHO1S7HsSJKBtzW5gmIPcYgtwYmnv3Hnh4/Zv7058b2i2
	 j90us0yAg7dqg==
Received: from mt.tail9873f4.ts.net (unknown [144.48.130.189])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EF4917E090D;
	Fri, 12 Sep 2025 14:51:33 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org
Subject: [PATCH] selftests/mm: centralize the __always_unused macro
Date: Fri, 12 Sep 2025 17:51:01 +0500
Message-ID: <20250912125102.1309796-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This macro gets used in different tests. Add it to kselftest.h
which is central location and tests use this header. Then use this new
macro.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kselftest.h          | 4 ++++
 tools/testing/selftests/mm/protection_keys.c | 2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c  | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 661d31c4b558c..274480e3573ab 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -92,6 +92,10 @@
 #endif
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
+#ifndef __always_unused
+#define __always_unused __attribute__((__unused__))
+#endif
+
 #ifndef __maybe_unused
 #define __maybe_unused __attribute__((__unused__))
 #endif
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 6281d4c61b50e..2085982dba696 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -1302,7 +1302,7 @@ static void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 
 static void test_ptrace_of_child(int *ptr, u16 pkey)
 {
-	__attribute__((__unused__)) int peek_result;
+	__always_unused int peek_result;
 	pid_t child_pid;
 	void *ignored = 0;
 	long ret;
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 9201f2905f2ce..688a5fa6fdacd 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -32,9 +32,10 @@
 
 #include <sys/socket.h>
 
+#include "../../kselftest.h"
+
 /* defines to make checkpatch happy */
 #define strscpy strncpy
-#define __always_unused __attribute__((__unused__))
 
 /* libnl < 3.5.0 does not set the NLA_F_NESTED on its own, therefore we
  * have to explicitly do it to prevent the kernel from failing upon
-- 
2.47.3


