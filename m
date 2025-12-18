Return-Path: <linux-kselftest+bounces-47705-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE2BCCB965
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 12:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AD1D30CA09A
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Dec 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2055316900;
	Thu, 18 Dec 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHNFgUbu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796B03164A5;
	Thu, 18 Dec 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766056696; cv=none; b=ZhT3x/jXo0Zq6taOJoRNpwHDevQVS7rTh2QotlMcMzArhC49kzk3xXyTkBVFSASDBWeVcMHKF4TteD6T4aBu6zT/W/KSCxMFht8pyNmf79wgzikRVd/xjYkvZeoM+XHglAOlIA//TKiFTWMhMmm0Bt7nan+g+3IV2A9nNj1rtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766056696; c=relaxed/simple;
	bh=yNM1KucGusRUNSjrZXGlb77jtzoumCtkIOtLUUYrmfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p0XNlG6qHveCTVBjjpSigbmLNgZKf6fhhhWzhHgFwtFJ/vQFrh9RsGqJaoQFNZXmFRc15nJhJ/qCGz056boPxkAPhqzHX+iCzdBYIwi7YuCMwZ7g1W73dgYhu5/u9KoWospNvqgSau5tZFiztgFnWXYMXAQrzJv2sPBpgLueLt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHNFgUbu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E97AC116B1;
	Thu, 18 Dec 2025 11:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766056696;
	bh=yNM1KucGusRUNSjrZXGlb77jtzoumCtkIOtLUUYrmfs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MHNFgUbunTYrHgzGnqGFcCCIR3CUq0cuvZT9cuOFTVgI1RZYPIC26sgn3tDpDXezK
	 MeWY4o8mHTIO6DozDUojku7Pbybp/OCpfXpsCqVOw7F2PXK/frMU3U85f77AGAN2o4
	 H0CXCdivzGGHHbGFsZqzPuQXkDiZfRRod858GNhaf8x45rYwoGD5X1wUeL57kMJgun
	 J+mljw4XdP/3fxxbwXgxkTiVeV2z7IVcd+QTY0XZUa0s5tmlCyj9oR7uCiO749NLQ4
	 TCsK+yNFWDe2yGIQxqc/Zmca2Ndj5CCvs95yjDDMMhZF18/sGLbzLX0nxqlz78jeA3
	 e8BnuoLGzHeQA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Dec 2025 11:18:02 +0000
Subject: [PATCH v3 3/3] kselftest/filelock: Add a .gitignore file
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251218-selftest-filelock-ktap-v3-3-62acfea940dd@kernel.org>
References: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
In-Reply-To: <20251218-selftest-filelock-ktap-v3-0-62acfea940dd@kernel.org>
To: Shuah Khan <shuah@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=464; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yNM1KucGusRUNSjrZXGlb77jtzoumCtkIOtLUUYrmfs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpQ+LxhMVlY1kNRt7FqYpPmlVZQIXwNW+nx+Xci
 uLsRpNjTFSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUPi8QAKCRAk1otyXVSH
 0CUcB/94W8kaHG1W4MPwsxA18QYF5IVktzV91be4q9Ock0ihUKopUEBNrmF6qHKBaMkkxSk+ZBs
 tQn6Km0xXld2ZVjkf0HW1B2t8V/Bzbhe8r+OlsdLpNUrKZpQCkfGnZzhnjaAmbZrY8Gv/GICrjr
 +2RQucWWf4880SPC7pzIa0LAoDG9vcaY6SsNEIm1N4J7rMgjK1bOU1x+osBJIifRzE1gPwGW3Fi
 2GnLuvye2sbiskoeQpVRRuFJ6yp7q1MKyKFJ0zZFCzIDbAMUnw2n1UJltYClF+oQwFgsgU2YO4b
 z/FmhavWXRXP5RPYBogfirmeYh2rH1DrrIn8uO4gMK6BlvPb
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Tell git to ignore the generated binary for the test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/filelock/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/filelock/.gitignore b/tools/testing/selftests/filelock/.gitignore
new file mode 100644
index 000000000000..825e899a121b
--- /dev/null
+++ b/tools/testing/selftests/filelock/.gitignore
@@ -0,0 +1 @@
+ofdlocks

-- 
2.47.3


