Return-Path: <linux-kselftest+bounces-32444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8384DAAA192
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 00:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A649116F6FB
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 May 2025 22:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AED22C0339;
	Mon,  5 May 2025 22:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cK1xgT9v"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB382C0314;
	Mon,  5 May 2025 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483606; cv=none; b=YWCMoqK27AEx2FRUzs0NjRxtl7pdzGCbB7OE2vK6ZWriE9W8BwpVA9G2usu4nP06tGiuodiayhJUnCDB9NTXgDk8Az6RMs14Z/6DbhGposC50yrtolJBt4w1/ZAr3v+mAmOwsKKn0hqlI1LPfiaXiwxauaDCjFi+JafRwfkzkl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483606; c=relaxed/simple;
	bh=sVJA9vx5VRxkRkJ17oz98ZxnaSmZeRF93jUx2knoqDw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KD717xajPkDQmi7KTk2HjC90qaKj+eljdnEMyvWdWnXSbPgsHbvRx8qhq5a5VfQ1k+ll3OWK3VkhRz3W85IdNJ4blkKwv6ZI4Yo4X8eP4pV1xb/W6t2tRe+K7lUjEWL2P2jjCs9Fl1GXvyZriYvVubhms/dDNLrT0/HBXup/GfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cK1xgT9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B213C4CEF1;
	Mon,  5 May 2025 22:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483605;
	bh=sVJA9vx5VRxkRkJ17oz98ZxnaSmZeRF93jUx2knoqDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cK1xgT9vMXEBqpCZdF05zhzwJx2tAqP8nxTktG8ZzlrxQCm8jliyeKb7o0Kr86ob7
	 lFSPCgAFZ/lAgmP3oCys2vE+0sSSEi/5NzvNJ/yg8po3INvVUe1bs92lrtwhbJHBgA
	 CZynd5NQ0ITesLIeOIQZsts2UQNqTbfk5LFVrDBXafoUEq7uILR9+0yQKgmuganfuw
	 ed3YFL3TbftNcHre/4aytEysPp0z5lkkafW61ozb44E9IkW83C67q91NsVA/5EUl6d
	 kSF7hfu4WSGKfM97Ji1LYhu9Q215JjqxiyJKACt+6oFzV7V+y1U0o8PXxni5FEK6bB
	 VIxRsoaNCqHYQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.14 139/642] kunit: tool: Fix bug in parsing test plan
Date: Mon,  5 May 2025 18:05:55 -0400
Message-Id: <20250505221419.2672473-139-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Rae Moar <rmoar@google.com>

[ Upstream commit 1d4c06d51963f89f67c7b75d5c0c34e9d1bb2ae6 ]

A bug was identified where the KTAP below caused an infinite loop:

 TAP version 13
 ok 4 test_case
 1..4

The infinite loop was caused by the parser not parsing a test plan
if following a test result line.

Fix this bug by parsing test plan line to avoid the infinite loop.

Link: https://lore.kernel.org/r/20250313192714.1380005-1-rmoar@google.com
Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/kunit/kunit_parser.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 29fc27e8949bd..da53a709773a2 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -759,7 +759,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# If parsing the main/top-level test, parse KTAP version line and
 		# test plan
 		test.name = "main"
-		ktap_line = parse_ktap_header(lines, test, printer)
+		parse_ktap_header(lines, test, printer)
 		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
@@ -768,13 +768,12 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# the KTAP version line and/or subtest header line
 		ktap_line = parse_ktap_header(lines, test, printer)
 		subtest_line = parse_test_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
+		parse_test_plan(lines, test)
 		parent_test = (ktap_line or subtest_line)
 		if parent_test:
-			# If KTAP version line and/or subtest header is found, attempt
-			# to parse test plan and print test header
-			test.log.extend(parse_diagnostic(lines))
-			parse_test_plan(lines, test)
 			print_test_header(test, printer)
+
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
-- 
2.39.5


