Return-Path: <linux-kselftest+bounces-4834-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497158572B7
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54EC1F230CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58652DDC4;
	Fri, 16 Feb 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQ/u6HGl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F81946F;
	Fri, 16 Feb 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044092; cv=none; b=DwDLdjAD0qVzpUxKj7DVEOPXHTKjeMjaJXPd6P5yFQM3Ls8ac8y759LVOJNsDyORnYrgGv4AtTrOP6bhC2PDy3mwTLtluE3eoL6b6b91ibjKytijXTP1OSEDp0r+z68bFwq7rag/pnDGaCApeOKO17FCPPF0KURgxnxWjBZ06Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044092; c=relaxed/simple;
	bh=hO1c5nGTovIvhjqxDgR/7VZPe6HATF0p1iglGL7g2mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbY+jevS63MUOXlSy3kNIH6k2HP3QFPQg5Frkn0eJGIWJCKkToVXCTLriUbMxXeqeSSfEl2NIZiWO7DkNn97lPcEektOP9QBxRWHp40yGr599LcyRS6Z0fG7ulGcRMV2LJ2pfJKRMmJ9qeNHvHqoWLoSjkTqJ8/XEbanBSqDais=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQ/u6HGl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA6DC433A6;
	Fri, 16 Feb 2024 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044092;
	bh=hO1c5nGTovIvhjqxDgR/7VZPe6HATF0p1iglGL7g2mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AQ/u6HGlqBbE386G5Mpr0vYotn/Z/vsWAVwpPKB4iy9FsIaclTc7UkKRADomAhxLO
	 Whzc+fmxnyvTW4SfG1qdqgMG95Mn8gx2u2aTMHoFPiDPwGtI+XiHTZypHbS3+lySlZ
	 H3rQCvYv15GBOafdSNr4rjzCHozllTWCYmDQgFnUtHpMqb+8Ril7OWVsSFCvVN9Hrs
	 VIoYf6FU/curNbhAqaGAZR1YZvmeDppjYHhYNksicCWybwDKyumRs8s/Ii+4j1pQdE
	 MOomQcxmeI74pkRf6LOvbazNM2wjMeOsZGseSz2lsy4O0EZ6cVSVwudSSZ4aFSMXX1
	 8SVyfBTV1Q+TQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 7/7] selftests: kselftest_harness: let PASS / FAIL provide diagnostic
Date: Thu, 15 Feb 2024 16:41:22 -0800
Message-ID: <20240216004122.2004689-8-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>
References: <20240216004122.2004689-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
this gives us the ability to report diagnostic messages for free.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5fca75e180b8..202f599c1462 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1174,14 +1174,12 @@ void __run_test(struct __fixture_metadata *f,
 
 	if (t->results->reason[0])
 		diagnostic = t->results->reason;
+	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
+		diagnostic = "";
 	else
 		diagnostic = "unknown";
 
-	if (t->exit_code == KSFT_SKIP || t->exit_code == KSFT_XFAIL)
-		ksft_test_result_code(t->exit_code, test_name,
-				      "%s", diagnostic);
-	else
-		ksft_test_result(__test_passed(t), "%s\n", test_name);
+	ksft_test_result_code(t->exit_code, test_name, "%s", diagnostic);
 }
 
 static int test_harness_run(int argc, char **argv)
-- 
2.43.0


