Return-Path: <linux-kselftest+bounces-21582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797789BFBDB
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A771C21E85
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15AB12FF70;
	Thu,  7 Nov 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOGRyaQB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98C4126C1E;
	Thu,  7 Nov 2024 01:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943836; cv=none; b=dlkQ9xFaBA14X/J//C9JCtwO57qbnyAkPtjtubrd8nBgTP9wBDrcvNWWxcsoolIKqw+o8HYDeAx/1H+DbZpnvf8wO2mmWSx6wWYBax2Bi6Mj2vw6O3DxQ48XQOx0v9lTaOiXvuJPs5P1a/Vc01O9cwcJU4AVe4uPbpjz5UXmzjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943836; c=relaxed/simple;
	bh=Ntx8WxDk8rLB1Q5ojb39wO8KX0zB/auSEfmEWkUG1Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhYQ7yWPqgymjRXeZISuZ+SHipIRh8RJE6xhImf82hkZYMVHQ8ESVW5u9LcwawcgEJnmG+DAgFvdwHYOlZp1BlPGInn2OMHSWO40eQ7oksT5MaJDKutcVRGObAoaG/L+QNJYZ9eJIaiUhhBdV59lmDqnuhKhzbhuwICbtK+Rz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOGRyaQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD3AC4CED2;
	Thu,  7 Nov 2024 01:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943836;
	bh=Ntx8WxDk8rLB1Q5ojb39wO8KX0zB/auSEfmEWkUG1Zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eOGRyaQBHLWbThvMfSOe+NdKSSWq47FiT6b0jbREJrCrmCCkKRYzBX+kI8uqf4FGB
	 8Rv3aIyC0qor9e7OhXBedZ/cj9Of9jgpTWw/ukU8ZRaZzBW1kRxPIXrz7wQ72uT3Go
	 k3T+rD5Fmj8phhkMIU94o0Mc6vDXwQiq9tz8HUaiJBhUqOzNkve1cErbwnm5NhPshu
	 AzS2XHxlYB6oBLepZrn7YXVck1C5VRttG7VoARVhv4jOm4klkosh8LV7cTGDr1rCI+
	 r+4m1zmGwPYFpV3s2XQgqfkehkMXEBiIgUHjIOC0VUa5YYa+5E4YFmg/XikX2smBGe
	 eVxd6sDElshsA==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:39:22 +0000
Subject: [PATCH v2 3/6] kselftest/arm64: Corrupt P0 in the irritator when
 testing SSVE
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-stress-irritator-v2-3-c4b9622e36ee@kernel.org>
References: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
In-Reply-To: <20241107-arm64-fp-stress-irritator-v2-0-c4b9622e36ee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Ntx8WxDk8rLB1Q5ojb39wO8KX0zB/auSEfmEWkUG1Zw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnLBtRwxb32ApH8TNCcyHne3pvmw/cpBt6AyUptaVN
 CbigTQOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZywbUQAKCRAk1otyXVSH0Ez4B/
 wOuFw0QZXOAEYlFcCsYcnod9CvSTtuMwy5tDEnl0yp9kzzWK0P1Y3U89+XaFPf37gas7ljxNTWD85P
 ep6hgFfDMW3ZUzsQks3C8oSQPvpGEdsaNW7Bb3lCM6k30WJxpcA1AbWsNpgXEG2TAQHqSwLcZUHbr/
 Phe9TzUtRbi2szmDxzDGMzOL/JOz6K/v3AziIWHW3LWds5gA1DfXMFf2Y8tONxzQk/I6JXuX3MWZxV
 PNGhLcDB1GZx1onv67RT3a2zDo5zgAmJvV4dwJbMMvljWihwNE+pv35clsC/22S07uBgQRK8VFpNGU
 J36mxVJYc8xIgrRjhbJxYU2fCZ8E4U
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

When building for streaming SVE the irritator for SVE skips updates of both
P0 and FFR. While FFR is skipped since it might not be present there is no
reason to skip corrupting P0 so switch to an instruction valid in streaming
mode and move the ifdef.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-test.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index f1fb9745c681786f686f1fafcb7e1154f3c8e1a3..28eb8b5cc2d2e6f51818f29db037e55c9b838a41 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -302,9 +302,9 @@ function irritator_handler
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
-#ifndef SSVE
 	// And P0
-	rdffr	p0.b
+	ptrue	p0.d
+#ifndef SSVE
 	// And FFR
 	wrffr	p15.b
 #endif

-- 
2.39.2


