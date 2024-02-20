Return-Path: <linux-kselftest+bounces-5068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 417E685C4B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D677DB24B29
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC4B14F9C6;
	Tue, 20 Feb 2024 19:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzKOQD48"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E680714E2FC;
	Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456972; cv=none; b=SVeFj7rsIHX+Viyrhm3iP3coNYrr11bcXMLSVIV/k0DafY5S2lAP7hIUUbOREiq5GRSuN9X1A3IgacsE+cxvhpJyfmbaYA8xFlPtzB2Ck9gNBbeZ9kukYg4hnMBgL/q6HOvudhRgykBW/h/vG1X121KOqazLJD9wVCEffQ/ASCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456972; c=relaxed/simple;
	bh=9Wj3EGg1bJZZ78CqquR3OBcBaDowmip0RKN2lao/f3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQ5KU3K/gO0HvVrCfrRO7q8+JNHbX62GDnj8MW2y3+/BlfAsOciw1GbQE1plYAiFiQ4JLiLSi2GXv9nOr0QwhkapBxTSxzZCaO0OIY0ozZLTgxwbjTrmtfdbLto0Du8MO2uFexgwCepRny0NhYuu5IJDlWp4wAcHpY8+6LepcrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzKOQD48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AEBC433A6;
	Tue, 20 Feb 2024 19:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456971;
	bh=9Wj3EGg1bJZZ78CqquR3OBcBaDowmip0RKN2lao/f3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VzKOQD48qaw1EA/D+lYIcRBeFLcCHN/vIkeocRaQzEcokFnYb1vvT+zomxN1NJxAB
	 UezFBNUtGDmIqvkeVA1pm+MlKlEEg2vJBg7VhFrW1rRLVz26SAwnu+Jm+kQf1UnGL9
	 e6N8/RUAKx1n1nit8qir7VOyTt32mLfR+JLgotDCaAmgcR5N9GG5YQrGkZvLH24k7u
	 LMgQZ/eK7LRLLID/iqQ869Gktb2gtECkSWVXvfAGs0kiVTzkKetGpNzj8tlYVkMddj
	 ynaxvcQR7Zbp24jfghoA1BMOwSEC9NOfAfym5dH7BEnUgLm6PWBFiH/oQ0SXO2JUlb
	 Fo2mLaDlHxbAw==
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
Subject: [PATCH net-next v3 09/11] selftests: kselftest_harness: let PASS / FAIL provide diagnostic
Date: Tue, 20 Feb 2024 11:22:33 -0800
Message-ID: <20240220192235.2953484-10-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
this gives us the ability to report diagnostic messages.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 6157a7b059c6..7c3d19bf4220 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -1147,14 +1147,13 @@ void __run_test(struct __fixture_metadata *f,
 
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
2.43.0


