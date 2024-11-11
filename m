Return-Path: <linux-kselftest+bounces-21789-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A209C427C
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E60E1F22F82
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 16:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857BC1A256B;
	Mon, 11 Nov 2024 16:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+BwE4Nn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3FA1A254F;
	Mon, 11 Nov 2024 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341953; cv=none; b=bvfUDVezEidNU9EULlhBmQdHIaaDurgoCiIAV9q2uRbKpaKutF+MLsr/GkpMnQQ+R9itLiwxkRTSMYc3qPtxQ8ciYbrA0EYCFCYPE/PH2ahJr+G6ZA0qgA8oNv86at+FPvROfHZlJNESHILlSFi4H/QXZnw8FqGB4BTivGI7Kxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341953; c=relaxed/simple;
	bh=g4YRupDmS6rsFE+fXj4fCiJaZnhgWz5kCy7tqLUbGPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NDVAeg6rwC58NlSgKjldWKoNbsChJq0sv8VIp1UY5R74sxIBO7KfG+D1nmvHogGZqSkRHP/Md6Ugu+A1Tdug4/4I5j5a1XwVN8qk2bmWzShZPwabpJll1Zr+z53p51O8HQdayEagIIbSkJEWq81b/atIIb9xEU5KDn1qgNlVTWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+BwE4Nn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388D7C4CED5;
	Mon, 11 Nov 2024 16:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341952;
	bh=g4YRupDmS6rsFE+fXj4fCiJaZnhgWz5kCy7tqLUbGPc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+BwE4NnKbLT5R3oGmmZtiRrc+XhPt8Nmq3mDWP7k7VgCQRhSg5Ufoj/wAKAjHhPd
	 vPhpkrU3GdEQJkRY7vwaKXuz5jO+OBD7ClUtV90r37ccrrB5itCWDLynhxDp0GeNI6
	 yFktqayQrOsOKjJbd9/M0t/u6IEwRtrgCwg71pE/Xtopf6mK0dlvrZUH2VudV5qUFk
	 /TQFR+WXSL0r8f9IN2yPgHZAPNocGahZ0KGufVvj9fcFuejnOJA96IvyqIcebYVAHA
	 Cl3ubG/YEWueRf1YOj97/Z5IJc8nKmfq/wjGrl6M4o8Pi6ffIpNDQB0P7lwe/1c+7U
	 xbtyRPoK8SYwQ==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 11 Nov 2024 16:18:55 +0000
Subject: [PATCH 1/2] kselftest/arm64: Don't leak pipe fds in
 pac.exec_sign_all()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-arm64-pac-test-collisions-v1-1-171875f37e44@kernel.org>
References: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
In-Reply-To: <20241111-arm64-pac-test-collisions-v1-0-171875f37e44@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=broonie@kernel.org;
 h=from:subject:message-id; bh=g4YRupDmS6rsFE+fXj4fCiJaZnhgWz5kCy7tqLUbGPc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnMi57hYbOZoCypxxS5DdntS9d1pQSZA5sNIhza
 3ZAtKIvlWGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZzIuewAKCRAk1otyXVSH
 0Ct6B/9GaplZ+Wh3jbdMs+/axyR5eFAUQoGrgCp4yDH16vLv6X6MxioUbodUygXW9QAlaFfCISv
 uTKM2qH7KJvur5hsY4sGV1cmmZWNAB8jhWNVpzZ2nbjIiidg6GXYPm09Ck9KAO8mkFDSuc+eDfH
 p4Nynex1KCFehgEI/AYG6y0Nc6XNx83LpPqiTxHEeEe1nxS1OCdRtAzVUP2/BmFMBUxdS8RnBrx
 rDC+bMGrY5NrBKOfm+dbPSnnORUcDNrBHGVxYOgudxew/CKp16yVECIo1+HX7S0gskv96hAc7qH
 AI8O3nEP2dnlcKzTZeBTx80K4LNKdRDIH1QXvhqAsg3DG8p4
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The PAC exec_sign_all() test spawns some child processes, creating pipes
to be stdin and stdout for the child. It cleans up most of the file
descriptors that are created as part of this but neglects to clean up the
parent end of the child stdin and stdout. Add the missing close() calls.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/pauth/pac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index b743daa772f55f570a3c0a912ac0c2c403c4256a..5a07b3958fbf292b09c9d6b11b8f9db2880beeed 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -182,6 +182,9 @@ int exec_sign_all(struct signatures *signed_vals, size_t val)
 		return -1;
 	}
 
+	close(new_stdin[1]);
+	close(new_stdout[0]);
+
 	return 0;
 }
 

-- 
2.39.5


