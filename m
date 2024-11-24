Return-Path: <linux-kselftest+bounces-22487-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B26D9D6EC9
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 13:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABB6163023
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Nov 2024 12:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7931DE8AE;
	Sun, 24 Nov 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duO3IIRe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C261DE883;
	Sun, 24 Nov 2024 12:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452124; cv=none; b=Uinpps1dPD1i+MUaXhcJcNtuN6B1fBvb3RlbzclyPYcMWRg9jRucD8xyg9OyJ7rKbvOFVfdk5tG8/39H+F1Gfb6LGVc15P2y1wX3LwpbBCDKK7ORfNai5f+t0F0B5flFRmtY01Ckh9NX6gsD+/2IgZwTZLVZ+Z9O0DtcfKa7Hwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452124; c=relaxed/simple;
	bh=dStXZbOZ68pcA4OHVXBepn0T/jxDTGEotO0Yx2wAYpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4TnCqE+HysNYpPEsN0Gg+rITY4Hq/FWYnNg2pA1H+NXQ+bNWbfDG5dCDFMSOkYSGMCST/pZ5h6khOHm72MJAaxEd5W6rnHkY3bO2PoGL4Yadbf8e7afg4lvQMVOfPYb7Wsp+6mNe4SwNsifMYCP34Au2qBHtNEZlndTcUW+cmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duO3IIRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B087C4CECC;
	Sun, 24 Nov 2024 12:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452124;
	bh=dStXZbOZ68pcA4OHVXBepn0T/jxDTGEotO0Yx2wAYpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=duO3IIReR+GEH7XGAdysGfdzl/wKUzz5EJ948fmFv2KIzkhsB/rzLdVtO1Sh/IWp6
	 YzGy3UTotA0qoWRSNO6s3KXBf0Dhj0OQC6BgKrqicAShnmxDgMdx6ZYeA87ZjKVRGd
	 O7VQYhPebvrOxEmafqzBM7PmYd2hgbyIPkbQvrN1fIXD/B4YMveLAE0mq4ysVhC50D
	 PCJz2SXfeFqjq5HLQzdh2uTJbL9WfhmE0GnZYXfs5OzEbkNOSzAU92UDMeGlAOob/8
	 IlGqHsaDWh+h/YGE1GzJgrTxpLyq/GkUlhPDKD1azmy0Vih6tHUHHUd4RsVe5doVdi
	 3lYzusL1MUGWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 6/6] kselftest/arm64: Don't leak pipe fds in pac.exec_sign_all()
Date: Sun, 24 Nov 2024 07:41:42 -0500
Message-ID: <20241124124149.3336868-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124124149.3336868-1-sashal@kernel.org>
References: <20241124124149.3336868-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 27141b690547da5650a420f26ec369ba142a9ebb ]

The PAC exec_sign_all() test spawns some child processes, creating pipes
to be stdin and stdout for the child. It cleans up most of the file
descriptors that are created as part of this but neglects to clean up the
parent end of the child stdin and stdout. Add the missing close() calls.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://lore.kernel.org/r/20241111-arm64-pac-test-collisions-v1-1-171875f37e44@kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/pauth/pac.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index b743daa772f55..5a07b3958fbf2 100644
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
2.43.0


