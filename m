Return-Path: <linux-kselftest+bounces-5566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DB286BDB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:03:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 743411C2427D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7130381CC;
	Thu, 29 Feb 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MBVYyakL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4C381AA;
	Thu, 29 Feb 2024 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168368; cv=none; b=fPlS0eqmWxW5oI9zjV3Vd/UEPEHcKM/7KOciXjvB5MYeQMSyryJQT1ItzU29BsnjQFnskVCX2S87/a9ZMxgit29+ORGmm2vZE+b/5X0cPRxgMrPBFchDl0v0822ljHqfzpf7DBeBrdQuIe3FwLvdXXq9V/Uujue44eN8ejGv15s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168368; c=relaxed/simple;
	bh=8TDlLakfXfH1TgFjYOG2kAdbF+RRLERm0lTrtPVp+PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ceA2bvV5i+/JPz0WtMbhAfMmnI6orxZh17r5pgwVfaqjhK6thNLwvs2+jS4vfoc2WYfOR+v8JgYk6DVUW+BYloEvuY7/OQFK6OjFyZIX5/c5KLfrQHZ0A3vvBiD5Gy7+V8PtSIcDXO0j+4wiH0nEUnaZ2GOKDF25+VFWptfKhsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MBVYyakL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBE1C433F1;
	Thu, 29 Feb 2024 00:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168368;
	bh=8TDlLakfXfH1TgFjYOG2kAdbF+RRLERm0lTrtPVp+PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MBVYyakLuTRcHP6qxqUxu4OiJD4DHGQwWjKnMK9Xct0TUe5cB27D4kPMkduVF6buX
	 N4jx1VcsGRQsY64GSy1TvGqU909NT4hIEDkvQ/h1GFgEd1jXCIji3FBL2pSkx6/IgR
	 3PEKZmV64X/bIjrbZivzgnI/i7mqYPVJpIMY8Job4Xj+7tZJJ2E9qubVd2ny5txZgh
	 PtGOWrhNwSGBwChLSFfzoNiAVIKPu729WRj8yMbzvR71EevtyQ23JUWh3dHLq/JytY
	 uCxtQKIZO6uzb4AO+NBa63dCE34NJfmaGLmfoWIAuGsPnDRDY3vuG7/Qlrv0tyuduw
	 oIiAYA5U4h0fQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v4 01/12] selftests/landlock: Redefine TEST_F() as TEST_F_FORK()
Date: Wed, 28 Feb 2024 16:59:08 -0800
Message-ID: <20240229005920.2407409-2-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mickaël Salaün <mic@digikod.net>

This has the effect of creating a new test process for either TEST_F()
or TEST_F_FORK(), which doesn't change tests but will ease potential
backports.  See next commit for the TEST_F_FORK() merge into TEST_F().

Cc: Günther Noack <gnoack@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/landlock/common.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index e64bbdf0e86e..f40146d40763 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -37,7 +37,7 @@
 		struct __test_metadata *_metadata, \
 		FIXTURE_DATA(fixture_name) *self, \
 		const FIXTURE_VARIANT(fixture_name) *variant); \
-	TEST_F(fixture_name, test_name) \
+	__TEST_F_IMPL(fixture_name, test_name, -1, TEST_TIMEOUT_DEFAULT) \
 	{ \
 		int status; \
 		const pid_t child = fork(); \
@@ -80,6 +80,10 @@
 			__attribute__((unused)) *variant)
 /* clang-format on */
 
+/* Makes backporting easier. */
+#undef TEST_F
+#define TEST_F(fixture_name, test_name) TEST_F_FORK(fixture_name, test_name)
+
 #ifndef landlock_create_ruleset
 static inline int
 landlock_create_ruleset(const struct landlock_ruleset_attr *const attr,
-- 
2.43.2


