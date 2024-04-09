Return-Path: <linux-kselftest+bounces-7502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D743D89E48F
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 22:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DAD61F22A0E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F7158851;
	Tue,  9 Apr 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hMUuwKXV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29CE158843;
	Tue,  9 Apr 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695189; cv=none; b=IKYrQJO00e9fKqQ5eNZk4m3SvFzi3ZpGVgESAmeWFRKyz7gzrF6eRg4rJuKWUdcuog6mZ80hDK02sN+lZuJgipKbyRY2U4bc0Beh5xNY1o68uYYpzqs1qIh++sS8J3wOPNVN2qklPNbJOVY43RsVodvcTnCDmjuL7bwWVl0VZjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695189; c=relaxed/simple;
	bh=0Yc1aRq0cfqJFhJyIkDldFkrL/Y5AHCSI3i6IACqU04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c3/3YAFnlxhsREjMDtUwU4xPl1mU/RhxxqRuOSN2KHRuD6E4T4owXIWYu0o3RvuH4xSu5uYNBTe4btSbefPH6IuiVew6rheTKC1w3j5Xf/R0ttosrL9FJQV3Jbyp5W6KS+8wnoC/P9KM2Nlliv+2VUbNB3/Vs6AFMiDBE0gEYt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hMUuwKXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C00EC433F1;
	Tue,  9 Apr 2024 20:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712695189;
	bh=0Yc1aRq0cfqJFhJyIkDldFkrL/Y5AHCSI3i6IACqU04=;
	h=From:Date:Subject:To:Cc:From;
	b=hMUuwKXVWpHSCB08oTL4bQsM+y2MbzeXwjXoms7bGBa1G1wxAiIlFqmDglUGVtHh2
	 EhFEtWcXHWQ77H6s773LvtZZVRuYWDbpKV/WbiTWyl3wvnOBEMoCFO53OVkpxATMvh
	 g3CgrbeNJOmfdhwho49UTwhm4W8XKOrOvTI0oTubkaB0qcP0nT7eF9AqIqrVOL5wNA
	 rnUuMZHICDV+7P4ve0J6SzHkq8HBnarLl7DGL097BxKJ4IpqDo/vO/ZA6ktPXtDX1M
	 46HOP0FbxUrkYIZ+Dkecgtb2a1sx0OYpkydAxx/5d0V7G1/qrXYVilGQZWjwfQqw9y
	 TZqp8SG9kdSww==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 09 Apr 2024 21:39:43 +0100
Subject: [PATCH] selftests/clone3: Check that the child exited cleanly
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-kselftest-clone3-signal-v1-1-bbe49156171d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI+nFWYC/x3MQQqDMBBG4avIrDuQmEjBq5Quov6xgyGWjIgg3
 t3g8lu8d5KiCJT65qSCXVTWXGFfDY2/kGewTNXUmtYbbzpeFClu0I3HtGY4VplzSGwxDTa42Pm
 3o1r/C6Icz/nzva4bQIBCWmkAAAA=
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; i=broonie@kernel.org;
 h=from:subject:message-id; bh=0Yc1aRq0cfqJFhJyIkDldFkrL/Y5AHCSI3i6IACqU04=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmFaeTbrxsxMQPVHOJS1Rq3fBJfXRe6ITHtiWAWxK/
 MzXc+gmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZhWnkwAKCRAk1otyXVSH0Ke9B/
 9w6DBsuLvUH5CBI7kbhMfrrpkgyrnX3pibIAWlpmiaV695Fg8918CCCEfeatGxKIstjfhk/EN3tGbv
 mwLbqbdBjlw0CtiwwL9oA7Rge5UKwGfEzYwPkM4IIXbK8BVqEtp49wpdyMLDS2eE4BHfn8PRznjkHT
 GW866EZm7CNM5AYNWiTBBnTQw7qfsu9XrEPNPIUKxrwPYo5V+TigOvUSWKjsoB49dohj7blrvb+yJ5
 KascqXrfTvk/W1qzx5ljXkCy3h6I2xNYXWO0Dv/Ui59BT8FS5evOB89h6hwy+Lpe0MT1uOH/FAP0lr
 PQUr3cMWKSN1tdnlRkuF8mIZuUqPtA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When the child exits during the clone3() selftest we use WEXITSTATUS() to
get the exit status from the process without first checking WIFEXITED() to
see if the result will be valid. This can lead to incorrect results, for
example if the child exits due to signal. Add a WIFEXTED() check and report
any non-standard exit as a failure, using EXIT_FAILURE as the exit status
for call_clone3() since we otherwise report 0 or negative errnos.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 3c9bf0cd82a8..0e0e5dfa97c6 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -98,6 +98,11 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 		ksft_print_msg("Child returned %s\n", strerror(errno));
 		return -errno;
 	}
+	if (!WIFEXITED(status)) {
+		ksft_print_msg("Child did not exit normally, status 0x%x\n",
+			       status);
+		return EXIT_FAILURE;
+	}
 	if (WEXITSTATUS(status))
 		return WEXITSTATUS(status);
 

---
base-commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
change-id: 20240405-kselftest-clone3-signal-1edb1a3f5473

Best regards,
-- 
Mark Brown <broonie@kernel.org>


