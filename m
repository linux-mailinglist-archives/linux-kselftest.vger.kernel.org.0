Return-Path: <linux-kselftest+bounces-43181-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA83BDE79A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7383B350432
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FD41A38F9;
	Wed, 15 Oct 2025 12:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpaz3ITb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4264E17C220;
	Wed, 15 Oct 2025 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531479; cv=none; b=s9QY/Uu3AAQYeImuRFkkhqxKjGp8SI9M+DmwbhPGGKCx2wyrQ36Cefe1b8CtkCB1K9bAH1HfcQ9/268KWibb+HM47q+5fuJtTnI0NFninVDiFFDrPWKWOr1w/iTL0JsATGqf9x5+ccd46CsZXMU2iBL9JxfrxqQFWV3a9dKhhBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531479; c=relaxed/simple;
	bh=Bkw2ODQRakznFdFxXk7YjkkE9guUBO7iboCmj8g19Uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z5OupVcBIS3xUYmN/BWoEWzSGxDvjq52VIL8muvB8ER/lrnVxbvJUHr8X8hL0O0+RkI/ma3RP2lJZ+IcMk7AdRAw21EHsGIdwaBHQUhA5fdYTDRkK/jUxGB5GNNLBz8W5ZM7UIqnv31MTxAz6mrVnJozgFl+WRsQzRo5GU9gfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpaz3ITb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0020C4CEFE;
	Wed, 15 Oct 2025 12:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531478;
	bh=Bkw2ODQRakznFdFxXk7YjkkE9guUBO7iboCmj8g19Uc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cpaz3ITbnWlkI+RzniohnygXCpwDWJB/pkg4i1orgn/YkFXaKmTdOUeRursSq4qCA
	 mJdLtrXIT/Aw5BtzpdUMDOwghyJNvrVkTwFoXOwcx+Xvpv3YQcYSgFzD4/MPf404U/
	 IDqPLAfndfuawcigXsPPxRRc4qvtbYaz0jgT9Z8ENTim2KIO45ZTvcf0/gWOEbMWTa
	 Eb30tXFbz9JILqlKC/IXQ/uL8M+jQ6giAVC3yZ+f2GBWpCTmXkwK2WB+qXNybHO/6g
	 mXd5B3h3o+W5LvfBVKZZi2zgvn3tUMMSkQEqIFBF6ywuHFyKrSuaGO3B8EKu36OngC
	 4GHQ2bgckYlBw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:30:50 +0100
Subject: [PATCH v2 1/3] kselftest/filelock: Use ksft_perror()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-selftest-filelock-ktap-v2-1-f5fd21b75c3a@kernel.org>
References: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
In-Reply-To: <20251015-selftest-filelock-ktap-v2-0-f5fd21b75c3a@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Bkw2ODQRakznFdFxXk7YjkkE9guUBO7iboCmj8g19Uc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75QNbpb8rRNtxR3Zje1hHWnq/7r0GL0Ta4Sox
 UzygM8WOsCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+UDQAKCRAk1otyXVSH
 0DStB/48c0Gmpba81CWpJArIT/z88ZFPi9w2BARqjkkOcXUm4vTG3LxbjeUljZ/9+ZeR+pTED0x
 dCCs5u5UQpp5un12UmbRiI2WUKgo5j8kjOhpUIGh71E9En615ovYw/7tkV1F76QwO3lBiiFkm7H
 Bs6tilR2DSmLQZh95XRP6CBqqJ0mqGo6xfNjBGTh51rHXXYgK0Wck2ICDDToFhP5KEdp0zkcbZf
 J4vtqQxucSJLtLZ6Fhvkct22oUKHvxYsr7udTJuEpdL7BL29aPQE1RBm6fG368VVAwKRkchp589
 8FfWvYaHlwetZmI3k8E7D2EviLqrRnQrtAMuzXK8bfe6HYsa
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ofdlocks test reports some errors via perror() which does not produce
KTAP output, convert to ksft_perror() which does.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/filelock/ofdlocks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/filelock/ofdlocks.c b/tools/testing/selftests/filelock/ofdlocks.c
index a55b79810ab2..a59fbe6aca14 100644
--- a/tools/testing/selftests/filelock/ofdlocks.c
+++ b/tools/testing/selftests/filelock/ofdlocks.c
@@ -16,7 +16,7 @@ static int lock_set(int fd, struct flock *fl)
 	fl->l_whence = SEEK_SET;
 	ret = fcntl(fd, F_OFD_SETLK, fl);
 	if (ret)
-		perror("fcntl()");
+		ksft_perror("fcntl()");
 	return ret;
 }
 
@@ -28,7 +28,7 @@ static int lock_get(int fd, struct flock *fl)
 	fl->l_whence = SEEK_SET;
 	ret = fcntl(fd, F_OFD_GETLK, fl);
 	if (ret)
-		perror("fcntl()");
+		ksft_perror("fcntl()");
 	return ret;
 }
 

-- 
2.47.2


