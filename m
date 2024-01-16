Return-Path: <linux-kselftest+bounces-3053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EF882E4C1
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 01:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE94B22516
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 00:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9BA1F617;
	Tue, 16 Jan 2024 00:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLjjL7Iy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073F61F614;
	Tue, 16 Jan 2024 00:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2F4C433F1;
	Tue, 16 Jan 2024 00:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364046;
	bh=cW6hRmn+otuIyGPQpwcj9sDrhpCGcPW/qnKNPUk62jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tLjjL7Iyo+VVBFaEzakzSascOK0u/PTAv25bj38tuvRVYrJ6gW7h8Eb5smMYvhn0Z
	 w8JqrBDZwGWggkjCF3wnPNdcUMk/DKKjipn/nE39NBO/6Q3OQZKqEJ1uerJSitDXhu
	 1z6UZZuLyUUFSPYNGqj9A4PL6tdtgYg2elw2m/eb/t63IVssV3YC2A+ehe5Tum+6/R
	 Lwf51vx1UCbB09cyRERw2wxqWxnvAIcsL2AR/DnlNnlxz1VapiDMzbmrXU4nxlnHzG
	 EWvHK1YDINzkJPVee0A4F6P5rF+hKl9GG91fP0BmU6TAR3Qm/KFX+Xdguq5LhlKlHm
	 DZDW34PV/500g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rae Moar <rmoar@google.com>,
	David Gow <davidgow@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH AUTOSEL 6.6 11/14] kunit: tool: fix parsing of test attributes
Date: Mon, 15 Jan 2024 19:13:37 -0500
Message-ID: <20240116001347.213328-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116001347.213328-1-sashal@kernel.org>
References: <20240116001347.213328-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Rae Moar <rmoar@google.com>

[ Upstream commit 8ae27bc7fff4ef467a7964821a6cedb34a05d3b2 ]

Add parsing of attributes as diagnostic data. Fixes issue with test plan
being parsed incorrectly as diagnostic data when located after
suite-level attributes.

Note that if there does not exist a test plan line, the diagnostic lines
between the suite header and the first result will be saved in the suite
log rather than the first test case log.

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/kunit/kunit_parser.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 79d8832c862a..ce34be15c929 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -450,7 +450,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log = []  # type: List[str]
-	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START]
+	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START, TEST_PLAN]
 	while lines and not any(re.match(lines.peek())
 			for re in non_diagnostic_lines):
 		log.append(lines.pop())
@@ -726,6 +726,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		# test plan
 		test.name = "main"
 		ktap_line = parse_ktap_header(lines, test)
+		test.log.extend(parse_diagnostic(lines))
 		parse_test_plan(lines, test)
 		parent_test = True
 	else:
@@ -737,6 +738,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 		if parent_test:
 			# If KTAP version line and/or subtest header is found, attempt
 			# to parse test plan and print test header
+			test.log.extend(parse_diagnostic(lines))
 			parse_test_plan(lines, test)
 			print_test_header(test)
 	expected_count = test.expected_count
-- 
2.43.0


