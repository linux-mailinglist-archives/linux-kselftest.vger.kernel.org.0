Return-Path: <linux-kselftest+bounces-18349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA475985F2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 15:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B8A289F42
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Sep 2024 13:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E160E1D1E80;
	Wed, 25 Sep 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NF4Prtyj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBF1D1E7B;
	Wed, 25 Sep 2024 12:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266492; cv=none; b=p6xIoOHJGPYxKTQZ8xm4qUJnsnZ7B1p5gz2Ip6YLSxo+GI6s9eJnS2+Mklji3QT0WzvfVHd7c0+Rb79niX5k33jaln5afMr4HPqKSyzzNkC87/ZZWbqhc1ri0yRh7RZicSivxBL/tymb8ck65AIQBkIc1Q8gnayhPvSXL5yOmmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266492; c=relaxed/simple;
	bh=PG/vvvlJIiTk2olPbjMrsEl8S0N5MM3UIN0ccEDP9Hk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVrFon/qjznCN6N5JpjYO1Z5wsR9wSAFWohTg9YeTsUMvx1lHrf9iMgt/oLoEmGmTzKpKu4lH8X8+jadY0vRtv374OVbIIhHtlIAfym8YV3OCEx/l8SYojQWfwOuiNsLS9SeQTFePGJNDP8AibNLY7RoOCaeDD7KGb/5uKfhaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NF4Prtyj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C26C4CECD;
	Wed, 25 Sep 2024 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266492;
	bh=PG/vvvlJIiTk2olPbjMrsEl8S0N5MM3UIN0ccEDP9Hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NF4PrtyjPNDpfA3Et4kGxYu251FceC2noIwAqlGAxilXlfjsHhxFW8/jxHErjoMxv
	 CbiAoBQyL93x+jTMnCAInl23Z6S4bZgVaahhFQFcP2z/2NJj+rTH5kpzSfFS5qn+CS
	 Ga+7aXA9gTU3lwclnGQlhShoiWjWJUVmQta9FKzfr0W3nwa2C8jNxEXZEPOjx08BPV
	 zJ0caCjscK+wLbzkHBokhM4dlw9q4If7TuUGeAla1qNWcl1mEbHVTR7Fx+7AdvrbIJ
	 UmvsC4kgkMWNzxDtrP9dmdNq8Nw4BaZkv66n5VViDKTBHZGNP3eqAZ65eiEz7DXX+Z
	 0n2T00oQTuJbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	nathan@kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 071/139] selftests/nolibc: avoid passing NULL to printf("%s")
Date: Wed, 25 Sep 2024 08:08:11 -0400
Message-ID: <20240925121137.1307574-71-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Thomas Weißschuh <linux@weissschuh.net>

[ Upstream commit f1a58f61d88642ae1e6e97e9d72d73bc70a93cb8 ]

Clang on higher optimization levels detects that NULL is passed to
printf("%s") and warns about it.
While printf() from nolibc gracefully handles that NULL,
it is undefined behavior as per POSIX, so the warning is reasonable.
Avoid the warning by transforming NULL into a non-NULL placeholder.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Acked-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/r/20240807-nolibc-llvm-v2-8-c20f2f5fc7c2@weissschuh.net
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1fc4998f06bf6..4aaafbfc2f973 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -522,7 +522,7 @@ int expect_strzr(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (expr) {
 		ret = 1;
 		result(llen, FAIL);
@@ -541,7 +541,7 @@ int expect_strnz(const char *expr, int llen)
 {
 	int ret = 0;
 
-	llen += printf(" = <%s> ", expr);
+	llen += printf(" = <%s> ", expr ? expr : "(null)");
 	if (!expr) {
 		ret = 1;
 		result(llen, FAIL);
-- 
2.43.0


