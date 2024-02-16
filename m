Return-Path: <linux-kselftest+bounces-4833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8510F8572B5
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 01:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F521C2388A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Feb 2024 00:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E44DDA7;
	Fri, 16 Feb 2024 00:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m34xrjnM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDF4D520;
	Fri, 16 Feb 2024 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044092; cv=none; b=NFaWMU1olNwySLd4t6dVk1B1p0BMYoMacCIunKyFrQmIeZDgNvCXELZZ9aW5cNr8ArX3/DxJdR7Z6l1HLtYupVk5O/IAgT4GlDOFPIRg3LspUxhkeR/pUUQQp0SULgqvUFAeIS+mj3ZjtyZ80B3HsU5ECV2EUJXWujOebFVOhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044092; c=relaxed/simple;
	bh=IOHIxewUik/BAcxqFdDqAKGAdsCDzq+9/PLMINaoM3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p0lv0v6N9vWKPEckg1H3YBCsDiuiZvb2FWqSXCkC8KeTe2dedh+XwnxjhcU/bt+mC675JMoRu3ngeuhub5FmLXVLw5YeuyvhQ9OQt4axC2C8cluBDAp+Mzcmk8FR0iBIlcL+eFwDJgORNGguY9NX8vhMXSAYzNIPksCrchwzLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m34xrjnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35438C43394;
	Fri, 16 Feb 2024 00:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708044091;
	bh=IOHIxewUik/BAcxqFdDqAKGAdsCDzq+9/PLMINaoM3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m34xrjnMt6Tp1ZLyegi9rnWQnbFLrKkLxwAbJpC2uoRz/z/YzwcNd/yb+7bexdh0o
	 Hqnz4uYpqwdBXJQJTlMor91LJL4oj7G7DB6TlOWEPT3KMZlMVg4KdmmFNTcwm7YvX0
	 uIhduo27pfXjyulMSBziCmHKWz6544FqLA97lv51aoD1DLIFthAglbt9ZCH39IlFTE
	 qLOZvjUWRVO3cITAMV1F+/H6xvo5Hq5WDDEJtL0ucSsMyk4AOkORRWKsu10v5YkbkE
	 2NkKOL3xpnn9levNneRaq4NHHXW3Eyyg6l0koO+kKP8ymGn/xoviPkicI9AWDMJcKb
	 OT3RFb+Q6J57g==
From: Jakub Kicinski <kuba@kernel.org>
To: jakub@cloudflare.com
Cc: shuah@kernel.org,
	keescook@chromium.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 6/7] selftests: kselftest_harness: let ksft_test_result_code() handle line termination
Date: Thu, 15 Feb 2024 16:41:21 -0800
Message-ID: <20240216004122.2004689-7-kuba@kernel.org>
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

According to the spec we should always print a # if we add
a diagnostic message. Having the caller pass in the new line
as part of diagnostic message makes handling this a bit
counter-intuitive.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest.h         | 5 +++++
 tools/testing/selftests/kselftest_harness.h | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 25e29626566e..541bf192e30e 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -287,10 +287,15 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 		break;
 	}
 
+	/* Docs seem to call for double space if directive is absent */
+	if (!directive[0] && msg[0])
+		directive = " #  ";
+
 	va_start(args, msg);
 	printf("%s %u %s%s", tap_code, ksft_test_num(), test_name, directive);
 	errno = saved_errno;
 	vprintf(msg, args);
+	printf("\n");
 	va_end(args);
 }
 
diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index beae50fd5ac3..5fca75e180b8 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1179,7 +1179,7 @@ void __run_test(struct __fixture_metadata *f,
 
 	if (t->exit_code == KSFT_SKIP || t->exit_code == KSFT_XFAIL)
 		ksft_test_result_code(t->exit_code, test_name,
-				      "%s\n", diagnostic);
+				      "%s", diagnostic);
 	else
 		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
-- 
2.43.0


