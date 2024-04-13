Return-Path: <linux-kselftest+bounces-7898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E158A3A2A
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 03:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A94BC283BE8
	for <lists+linux-kselftest@lfdr.de>; Sat, 13 Apr 2024 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B828BE71;
	Sat, 13 Apr 2024 01:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hELGoIfC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A173233;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712972584; cv=none; b=i2CEKFGfCUxI9/N8kx1teQzl1IH4rg1m+AsNX1tdmNog0R8qimHELHaW6Hcn0VuHvWx10zfswmY1M1Ul0uNR/KGVTYMCiXZ9dcpMJ6w2v7+IETya2/MfNu+WkykVsB+oGmDA5I8IA54qBiO+8j2+SuXcoEVIstHbS7J10p4mXZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712972584; c=relaxed/simple;
	bh=1zBOLKB4+pIe6A93dx/WvIB9KUfoduEU9FapuBAIaA0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERYXwfNNY7fElDJusuTBRV0UL1GKTLeLmnQYDSIDdi22VkRoBtzUJIcpYF1tpP6v0BzGYolxuky7bQawidUkdrSPXol6crmcDFXZ3kuUbHr4K3CXED1j3Ex+7sk4vk56qmG5M8N/j9YOjX9yuD0zWWHk8E7si/nOp9qw4s+mlMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hELGoIfC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7ABA0C32786;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712972584;
	bh=1zBOLKB4+pIe6A93dx/WvIB9KUfoduEU9FapuBAIaA0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=hELGoIfCH87KZzHVRnhTiDXXcXMJ+78K1DT/oWn2ddt9gSZlYsLnYJn0XKiL8o4TG
	 Wbl4+KO9VIVNobzxrd8UU4P2ADNQoXo2wnxIPTNOb6y1ddeFjNtwUpC1fLgV6gve5n
	 bZ+oZ3Ky61tFFgF7f1Jm6WoVXMt99pyXsOYGgrNVYM6ZgnfsWnGXlGYryrIdBXH1ZY
	 WbYa2Lg/6gAj+imJOpLoetyJJUvtntxCUY08KvJpm40h4I6ylGBs1a+4zi8YrC/3hL
	 A6zhCZVGLRizm+w6brBR+cB00oWUcmnY+4c9nfex/AxqZZR6FjRfLkPqhVpwjLLFEu
	 XM1nTDr6e5syA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE14C05023;
	Sat, 13 Apr 2024 01:43:04 +0000 (UTC)
From: Dmitry Safonov via B4 Relay <devnull+0x7f454c46.gmail.com@kernel.org>
Date: Sat, 13 Apr 2024 02:42:55 +0100
Subject: [PATCH net 4/4] selftests/tcp_ao: Printing fixes to confirm with
 format-security
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240413-tcp-ao-selftests-fixes-v1-4-f9c41c96949d@gmail.com>
References: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
In-Reply-To: <20240413-tcp-ao-selftests-fixes-v1-0-f9c41c96949d@gmail.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712972582; l=3422;
 i=0x7f454c46@gmail.com; s=20240410; h=from:subject:message-id;
 bh=wxpBb6LXRSkXjmd5ZWPuyM5ay6kCGD4vUjqDQ4vhKHA=;
 b=RzjpBpFw7UrSJlsSzfmRDK0F7NIVVw+KR068dfVdNt06AMkdy9ah7w7UoWLndoMjzomBVdPa14O0
 ZCVN90BLA1GKUznUJw6J2yAK+8RkIyG4lKRpp4CSVb4z9l4mCxIC
X-Developer-Key: i=0x7f454c46@gmail.com; a=ed25519;
 pk=cFSWovqtkx0HrT5O9jFCEC/Cef4DY8a2FPeqP4THeZQ=
X-Endpoint-Received: by B4 Relay for 0x7f454c46@gmail.com/20240410 with
 auth_id=152
X-Original-From: Dmitry Safonov <0x7f454c46@gmail.com>
Reply-To: 0x7f454c46@gmail.com

From: Dmitry Safonov <0x7f454c46@gmail.com>

On my new laptop with packages from nixos-unstable, gcc 12.3.0 produces
> lib/setup.c: In function ‘__test_msg’:
> lib/setup.c:20:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    20 |         ksft_print_msg(buf);
>       |         ^~~~~~~~~~~~~~
> lib/setup.c: In function ‘__test_ok’:
> lib/setup.c:26:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    26 |         ksft_test_result_pass(buf);
>       |         ^~~~~~~~~~~~~~~~~~~~~
> lib/setup.c: In function ‘__test_fail’:
> lib/setup.c:32:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    32 |         ksft_test_result_fail(buf);
>       |         ^~~~~~~~~~~~~~~~~~~~~
> lib/setup.c: In function ‘__test_xfail’:
> lib/setup.c:38:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    38 |         ksft_test_result_xfail(buf);
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> lib/setup.c: In function ‘__test_error’:
> lib/setup.c:44:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    44 |         ksft_test_result_error(buf);
>       |         ^~~~~~~~~~~~~~~~~~~~~~
> lib/setup.c: In function ‘__test_skip’:
> lib/setup.c:50:9: error: format not a string literal and no format arguments [-Werror=format-security]
>    50 |         ksft_test_result_skip(buf);
>       |         ^~~~~~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors

As the buffer was already pre-printed into, print it as a string
rather than a format-string.

Fixes: cfbab37b3da0 ("selftests/net: Add TCP-AO library")
Signed-off-by: Dmitry Safonov <0x7f454c46@gmail.com>
---
 tools/testing/selftests/net/tcp_ao/lib/setup.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/setup.c b/tools/testing/selftests/net/tcp_ao/lib/setup.c
index 92276f916f2f..e408b9243b2c 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/setup.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/setup.c
@@ -17,37 +17,37 @@ static pthread_mutex_t ksft_print_lock = PTHREAD_MUTEX_INITIALIZER;
 void __test_msg(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_print_msg(buf);
+	ksft_print_msg("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_ok(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_pass(buf);
+	ksft_test_result_pass("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_fail(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_fail(buf);
+	ksft_test_result_fail("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_xfail(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_xfail(buf);
+	ksft_test_result_xfail("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_error(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_error(buf);
+	ksft_test_result_error("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 void __test_skip(const char *buf)
 {
 	pthread_mutex_lock(&ksft_print_lock);
-	ksft_test_result_skip(buf);
+	ksft_test_result_skip("%s", buf);
 	pthread_mutex_unlock(&ksft_print_lock);
 }
 

-- 
2.42.0



