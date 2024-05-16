Return-Path: <linux-kselftest+bounces-10301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5F38C7981
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 17:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D20C28B453
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 15:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E7114D6E1;
	Thu, 16 May 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DMr1c36K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A27E1459F3;
	Thu, 16 May 2024 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715873342; cv=none; b=IzyQMzI204y0bk8tzuqI6wuLuns2Y23sHDGUu8PUawZfIVpmjLR4MlMwJw0osQ8sDgzmikgdeMDjHajJfhfbTKEHmM4mQ71GqThefSPTKHkVdW+GnhbfnqEZjvdVIOiHvjXQDhI2fzRuP8XhTy56lkV8Ri3NItTQMPn/qbFjk3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715873342; c=relaxed/simple;
	bh=MX0LRjLXUQsWzGkFdsvQn8hzF7tAiJFexrrfTe22xVw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=K631/pBGivhaG0IVQYkSB+WiSuI2zS5gI2E2QKYObITubGd7xum8TDtTmka9IvfITq9k6nBVndMbCsHX2MxMnPCRAlNduvem5/aSHLnidk5BTjdflN9DGPzlI71jXEZiXsDBMGnIdADBECOwnlx2+2eP1sV+q0Ogsq11sdUAklI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DMr1c36K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A01C113CC;
	Thu, 16 May 2024 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715873342;
	bh=MX0LRjLXUQsWzGkFdsvQn8hzF7tAiJFexrrfTe22xVw=;
	h=From:Date:Subject:To:Cc:From;
	b=DMr1c36Kp7sYIsOmLCKxQ3frHRaXSZB1vmY3AMxacwQaauZBGACmFLL2LlyqBIVXS
	 lPQJNUf+Cbwc35WUQ3716LYyieEsQJ+fx/rMGPnsnr1mZW3q4PQaL2kKZupq+PLZ8Z
	 IHh5fCG20DuEQIpN9V41Fl1e2qE2qA4Kcm/E40XG2/ETWNvMZyxQhQIIspKgvn6v6G
	 5fEnDmYBJn7JDln0702Ohlhf+0oRbSX/B3Tp4Chs4fT6TEIDUpyvCAcynkO7K0fVNI
	 DlG5BWkK1OToZo/nsVUN/12GH+tnnFT8awhvEIn0uZQjZ6LL3IUyAiFYpPDyfwIPt4
	 p8BwbvhlKuPFA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 16 May 2024 16:28:48 +0100
Subject: [PATCH] kselftest: Desecalate reporting of missing _GNU_SOURCE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-kselftest-mitigate-gnu-source-v1-1-a0e814ff2874@kernel.org>
X-B4-Tracking: v=1; b=H4sIAC8mRmYC/x3MQQqDMBAF0KvIrDtgghXpVaSLJH7j0DZKJpaCe
 PcGl2/zDlJkgdKjOSjjKyprqjC3hsLiUgTLVE22tV17Nz2/FO+5QAt/pEh0BRzTzrruOYB9Z7y
 dbPCDM1SPLWOW3/WPz/P8A80IG+tvAAAA
To: Kees Cook <keescook@chromium.org>, 
 Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Edward Liaw <edliaw@google.com>, John Hubbard <jhubbard@nvidia.com>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-f3d47
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MX0LRjLXUQsWzGkFdsvQn8hzF7tAiJFexrrfTe22xVw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmRiY7+vE/+V3F6Kk7JCm6dlXM/vKtGVY4wTiFBJIg
 Mew9OSOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZkYmOwAKCRAk1otyXVSH0Dw1B/
 9G2K4hWOH06GeuNL5GeG9rLmd1wIqlzhrxS5KWedK6dePhwbZ3lLSEzsxfQGx2iqFw3p7CYKLFVetA
 Y1UvTKA6O0fhboW+Pwy4wMTpTbhbxhgE5gbhLUKv7sKr7UEEWk0AleC4uIUT+3W3D0HWseSjq4Ov1E
 klbTO8e++42Iy9vvFj6X5wKiiw7HRCsPZCEArwTCk/MY1hK8guPiOnXxuKcYlfvjtvAsiek6IWJCws
 VgVslBKyjGmI/fzirCAFDlMD6FJdc49OsP1sfQTkSd3UXi/n4vNS9gtbYM9gBU5kuaYIQyZLhDVDHD
 qcySElUzOA9eA1vS/B6EH7cQQr7aAu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Commit daef47b89efd0b7 ("selftests: Compile kselftest headers with
-D_GNU_SOURCE") adds a static_assert() which means that things which
would be warnings about undeclared functions get escalated into build
failures.  While we do actually want _GNU_SOURCE to be defined for users
of kselftest_harness we haven't actually done that yet and this is
causing widespread build breaks which were previously warnings about
uses of asprintf() without prototypes, including causing other test
programs in the same directory to fail to build.

Since the build failures that are introduced cause additional issues due
to make stopping builds early replace the static_assert() with a
missing without making the error more severe than it already was.  This
will be moot once the issue is fixed properly but reduces the disruption
while that happens.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 37b03f1b8741..1cee8cacf9dc 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -51,7 +51,7 @@
 #define __KSELFTEST_HARNESS_H
 
 #ifndef _GNU_SOURCE
-static_assert(0, "kselftest harness requires _GNU_SOURCE to be defined");
+#warning kselftest harness requires _GNU_SOURCE to be defined
 #endif
 #include <asm/types.h>
 #include <ctype.h>

---
base-commit: 3c999d1ae3c75991902a1a7dad0cb62c2a3008b4
change-id: 20240516-kselftest-mitigate-gnu-source-b41b2d2cb8a1

Best regards,
-- 
Mark Brown <broonie@kernel.org>


