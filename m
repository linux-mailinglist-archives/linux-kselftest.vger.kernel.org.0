Return-Path: <linux-kselftest+bounces-20510-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECBF9AD5AE
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091E71F23EA2
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 20:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A19420012A;
	Wed, 23 Oct 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG2jZxEY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CA71E32A5;
	Wed, 23 Oct 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729715987; cv=none; b=qmKg6BTwCGBSi8KieIHAO4F+ZAp1UZmgApElNkO32i6yYuF2xpq/mWraL6orK57/sYBEb5EcJOrrzR6s5dOA8eTYMLx5uETYOp4S4ktNMzRJGcpnoRaEqE6cN59NmzAsz2PCWmzlxXPx1dFjndFLz3DGuugjECK1JjIkCPQTngM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729715987; c=relaxed/simple;
	bh=FhWCGlX4GqW3drCLhOz7oP3Ieg9TfDbYSvqYk0V+nyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YgwwABD3/J/kTz5Kr/8EM+SesE/bFtucx1D2sVFrvQeKqqiS2/+63En/ugeJpOHrVpNv38gljL2cD6Jb1cL49EtCzB9shf6EGanEf15BapBoja5Z+rRPe+KxBT2ycUBT0/tIC9MYzgjf2vAbAlkdI1eGajkHw6Rvcdas0UX9s6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG2jZxEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8EAC4CEE5;
	Wed, 23 Oct 2024 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729715987;
	bh=FhWCGlX4GqW3drCLhOz7oP3Ieg9TfDbYSvqYk0V+nyI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cG2jZxEYaHm79SoQxc8GhTLIsCsTiHQHhRBHsxmhAZolW8/XUSWmqgZsX/inQT+Jt
	 cZ6Y85/epCbKDJXhUad5vZOsCkCSEh4bmOOcaDBwiSv0cEmXxOReInTXyNhB/Kqf+/
	 hmXCJjMqzKRREXXR9o7WUfErMqtj00v047ATZ378/zdQegMcSMpays2WcTa/2EAHAS
	 l4ALs86z5InFdcs2ZmX/V/NYBXJOAtxivOzrlS7xi4yYAvSkQVbaUD89wTpZJQATcz
	 BX75Sy1ZtkR8+L5Yj7rZdNPEixSkpt/NiWkdUmbbiKsBpn+Hy+0VYhS0ZtN84rTFLK
	 PjbX9vj7TTskg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 23 Oct 2024 21:38:31 +0100
Subject: [PATCH 3/6] kselftest/arm64: Corrupt P15 in the irritator when
 testing SSVE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-arm64-fp-stress-irritator-v1-3-a51af298d449@kernel.org>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=893; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FhWCGlX4GqW3drCLhOz7oP3Ieg9TfDbYSvqYk0V+nyI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnGV8HAtprWkaDeom0J0zZOIBZaJtVL+0CTV3rfZXo
 5d9PGCOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZxlfBwAKCRAk1otyXVSH0IToB/
 9RCm0u32j8dB88IyUiR+Jhgoe6iur7nWhVM9wLnewqQD7jW/StOFMDou1lhDiduv8Rf/njUEjfqfSP
 NFkQaaRcQYqdDB9xJ88pl6oLiq3PEPbN09UaUp5iaDhUGMxGAhMDHKJfYIL9QGx7cMWSXGZkPVkB/d
 CbP5m2e4LFcmJysjRmhCJHJnRCoQDGx79bn1nWsOqYd1AHeouicl+OyjKhQW+c0KlOyG4BMCjm1y3e
 Bboe9erv4FX/4cTxqHbvc5Fx9UDu4D5MOIjYvS7jw8GPAw2M1SXzjUkx8RWUJNzPlhmOql5MZVlvn0
 eU6Z/sCDxCJ5Cf+O4vLuIjNGnLSmE+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When building for streaming SVE the irritator for SVE skips updates of both
P15 and FFR. While FFR is skipped since it might not be present there is no
reason to skip corrupting P15 so move the ifdef appropriately.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-test.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index f1fb9745c681786f686f1fafcb7e1154f3c8e1a3..3c88dfe9c8cad29f44217314aeaffa984bac05e5 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -302,9 +302,9 @@ function irritator_handler
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
-#ifndef SSVE
 	// And P0
 	rdffr	p0.b
+#ifndef SSVE
 	// And FFR
 	wrffr	p15.b
 #endif

-- 
2.39.2


