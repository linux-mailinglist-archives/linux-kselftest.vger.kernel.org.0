Return-Path: <linux-kselftest+bounces-37606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30899B0AC19
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jul 2025 00:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A45AA0E4D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 22:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845A4224254;
	Fri, 18 Jul 2025 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcxoM0Y0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFF224240;
	Fri, 18 Jul 2025 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752877023; cv=none; b=EI1F3tSCvDJE0Xfh3qDHFrjIGRtzkWHDETXh77yMo56duWuJEbdn4HBZLYjyIIaAsgCdTrsW+U6pJnrsu4Ay8xnEGhbwq7w+kfrlbCAUu4JKnCEaIzAWQtUacOzhoyc7NyaN4KP8SlIwp7ZaTDOBUx763CLDSZmXqL8tF+E6Rjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752877023; c=relaxed/simple;
	bh=HuRh6CJ6lDfRc3S6heFYqYDheIESwPc+QBbxZ2wepx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HwK4EFpPdltm8mN77HE6kJFp7YkjBPcuBxMqf9Br041pNfcYFlYyOl6D8vm6kmF6qWjprj7hPYBceN9wdOA+91j2NxuUrGIUD/v+M6Hx4KXLeNhUOls4ibmkz+SKSyUZjZoD9tJYUl2f0T4aWDWbs/Q8yyvzmZnmcN86k47GLUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcxoM0Y0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E66AC4CEEB;
	Fri, 18 Jul 2025 22:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752877022;
	bh=HuRh6CJ6lDfRc3S6heFYqYDheIESwPc+QBbxZ2wepx4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZcxoM0Y0et8m1+EU8iPbE8fKxBzlvvfyPTWJh1ZAxEE3t7WLycG4PdwSR0q76tuJc
	 eu1Zv0/eheXbJjVeJuCSogpuET7uQmMCboA3NamtvpkEZSxZ4A6em3nHgO/3dnSGwH
	 tN0W+73XV1rFgSbu1TtUNKPUx8D2D5MmTNit5FSnyOsFt2864MDYMBwV4U1NNFbe/7
	 P61D3MlbAR4OUtYzu/7eFK62sAMRoZGpBZJAhfVgeqv1n8XtBBnIZ16UECqHPd4I/T
	 YZbFZkaO/Wqf7/ndKmDtPZ6myQSvRW90KIg4MtA9ElxOku/D2dpbm25gMfq7kvOY2C
	 bgz8cr6K+eSMg==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 18 Jul 2025 23:14:52 +0100
Subject: [PATCH 3/3] kselftest/arm64: Handle attempts to disable SM on SME
 only systems
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-arm64-fp-ptrace-sme-only-v1-3-3b96dd19a503@kernel.org>
References: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
In-Reply-To: <20250718-arm64-fp-ptrace-sme-only-v1-0-3b96dd19a503@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=broonie@kernel.org;
 h=from:subject:message-id; bh=HuRh6CJ6lDfRc3S6heFYqYDheIESwPc+QBbxZ2wepx4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoesfWyUKPCFwnQxa4ZgHgZdqDZoWgz28vbr8CG
 rXqgobX48mJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaHrH1gAKCRAk1otyXVSH
 0KlCB/49ZRHBcD6xN5wJLrtlMU0/nLoPH4Z/YYUFtehP2DnFvawijgbLt0DL98NZQMCUxGvWD6Q
 EbmXvySXCFBDbc2139SyXCOmogc8b81iG+Tiwi0EDMYiAR7a5NPOtex3aKSI7/fdUFQB/oyptkP
 6W1GMpI+teOKVILzctCgVpMUwhKgPvUNvxMrjscXIzf/4z9UaumgWYIX1MVYrGhfnmwj32OH6WR
 pj3N2ky2ZnHV8a+Fczb7t2l9E1x9YRRy/xnoAjaLFR+6kv8G/mhXHS5P9LqQ9lZPqSLyBnpE/kc
 VOPMGi6Dy5g7/lnhHk1HweGAZDzdcdO7j8uXGh+SVVKsdeZl
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The ABI for disabling streaming mode via ptrace is to do a write via the
SVE register set. Following the recent round of fixes to the ptrace code
we don't support this operation on systems without SVE, which is detected
as failures by fp-ptrace. Update the program so that it knows that this
operation is not currently supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index 9fc9dc4adaf9..21bc4eac092e 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1061,6 +1061,9 @@ static bool sve_write_supported(struct test_config *config)
 		if (config->sme_vl_in != config->sme_vl_expected) {
 			return false;
 		}
+
+		if (!sve_supported())
+			return false;
 	}
 
 	return true;

-- 
2.39.5


