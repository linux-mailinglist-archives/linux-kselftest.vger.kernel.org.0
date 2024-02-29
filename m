Return-Path: <linux-kselftest+bounces-5575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8BA86BDCE
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 02:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE97A1C241FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Feb 2024 01:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8578D3FB84;
	Thu, 29 Feb 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWwYWriX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBE3E48C;
	Thu, 29 Feb 2024 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709168373; cv=none; b=QL1zrknVjHPrnk2wbxSf5VoCje7JthFW361uSVPbvlWigMn8XPntCAluaafhkRlEzOZ/zOktfLika5iti1HYfCzeB6Qg1H9S8xPcrQfW6xdLYKSbLy/bFbu9g9AyF5DqTG29kSZfVYrl3p5xC9Oi2HubBjq1fzTQ5ODc84rhlMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709168373; c=relaxed/simple;
	bh=eo0XA91MK0x1+sBfoHYjHZ+5G044GpNBTQJ956u/WAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZBZQiAN63AwLFMciTN6fA7h6I/VEDvCcfup+NiuiZU03XUQSPFfH02K5pnSXkGo0jPtal/LvV3ioK5t+6kHNs4MHHDjrWP+/rpsm7HkAKZs0U1JdNhktsJmU9x0fT9un+C/n23yDfb/rOULWCzlrEQVe1LRIgsBW3tTvd66U3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWwYWriX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 958B1C433A6;
	Thu, 29 Feb 2024 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709168373;
	bh=eo0XA91MK0x1+sBfoHYjHZ+5G044GpNBTQJ956u/WAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WWwYWriXWf2Xoj76wTXPfvsaejmC9Ra4EfPbmFwpSSU4Zz6ga0iSNHXsADMa0Ge7K
	 gVQFDT/mrBWQI2JSXJCRmnYsP2BAvutMBTdsCOb2TQTAHatGR7m8n9IAyOcpGeJKfB
	 qhj4SqdHR0C8aG/u4LjdZw1rRAGa9NyOm/LtJcGBLuKVTC0aAIq6GxNIbSAAlXOuGu
	 q03Oow1urWT8pn6wlimQ4joBiGzv7YZ2h2Hpu8Qe13wmltzFC0qabZCkkMlQ3RUv8Q
	 n//QmKkEwXl5QhAt+emTeUKLIgAkUVjbzbHE4f/oPWVK6xzug7CznupXS1UjsT/Crd
	 Axvk9ig28OIcQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v4 10/12] selftests: kselftest_harness: let PASS / FAIL provide diagnostic
Date: Wed, 28 Feb 2024 16:59:17 -0800
Message-ID: <20240229005920.2407409-11-kuba@kernel.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240229005920.2407409-1-kuba@kernel.org>
References: <20240229005920.2407409-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
this gives us the ability to report diagnostic messages.

Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 5b0592e4b7a4..b643a577f9e1 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1143,14 +1143,13 @@ void __run_test(struct __fixture_metadata *f,
 
 	if (t->results->reason[0])
 		diagnostic = t->results->reason;
+	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
+		diagnostic = NULL;
 	else
 		diagnostic = "unknown";
 
-	if (t->exit_code == KSFT_SKIP)
-		ksft_test_result_code(t->exit_code, test_name,
-				      "%s", diagnostic);
-	else
-		ksft_test_result(__test_passed(t), "%s\n", test_name);
+	ksft_test_result_code(t->exit_code, test_name,
+			      diagnostic ? "%s" : "", diagnostic);
 }
 
 static int test_harness_run(int argc, char **argv)
-- 
2.43.2


