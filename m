Return-Path: <linux-kselftest+bounces-21858-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A3139C589E
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DB3C280A72
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736D814E2CC;
	Tue, 12 Nov 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQqlaOzC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAA613C807;
	Tue, 12 Nov 2024 13:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731416913; cv=none; b=RU8FpYp6xmh34jQ8LUg9SZLFfiDmpWU8wImL7oTkzQY0SLKb1yguyhcW1RJBWuUKn34hxe4EvQ4JzYl88p3kz+VpGRva/QkQiNazrNTmYADURaxsNMCw8x7dOjZxwlIY304GU5LE+OSNdspPM/V9qQEV4/Kzq9RwnJYbGtCY6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731416913; c=relaxed/simple;
	bh=ADBvwCUOO5PzFobBknix6AUoJgfpspN/bImmNrGH1RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uxNmBY5gwX8y/p8H8PfIXcUCdgyoc4+lFV+zVCVLV69EgN9uxf2QSGaQHIDrlj4wczAnjALXtgNfGpwgpR/5wZUg2Bqnf9njccsHM5DBr/46KvOtY5j9M5rkwTSeon7bxy1jurxLDofhGYRcCTIhNWQnrRrmx+iCqkOvKs8wo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQqlaOzC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A504C4CED6;
	Tue, 12 Nov 2024 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731416912;
	bh=ADBvwCUOO5PzFobBknix6AUoJgfpspN/bImmNrGH1RY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NQqlaOzCcHY7WQnszum5TrNB1XKd11DNYw8lxjVX2bkVXTwa1MxeOQ30LCC5xXg2c
	 eJtVPufkZD5Ipzf6l0DgZkog+o9V2KhiuebgoCjE24t9XPZpRcQiAiMX0ja5eDX9S+
	 C/NvKBsSfM3kCOHsCPDb0MVjXZMRmQZEj005nfLi5OBwZQrQymw0ShgeLk6+Z9sOOm
	 ReWVDSSKZ5q/rgMyhj93ag7iPDzPXuetJZ2t9AKNrgCTQrdSm3QCAuqaQJ6pVAHVDe
	 4IPtOFe452Al4iIz2669VQmvp9UJ9z9edsBOW7zOpQLChljcilOYrZqvJwrpE2a9zo
	 899RfQ08oxU1g==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 12 Nov 2024 13:08:15 +0000
Subject: [PATCH v2 2/3] kselftest/arm64: Expand the set of ZA writes
 fp-ptrace does
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-arm64-fp-ptrace-fpmr-v2-2-250b57c61254@kernel.org>
References: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
In-Reply-To: <20241112-arm64-fp-ptrace-fpmr-v2-0-250b57c61254@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ADBvwCUOO5PzFobBknix6AUoJgfpspN/bImmNrGH1RY=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnTjYI/TscnsGw4p6T8rFpu/Z8a21dEC7N07L6+d3B7jz
 L1qaUZTJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkfKV7P/s2vhbJ01ISNP5
 06LS6M3UzK+XfPbu2SeLLl98J8HxTkfCNlO/ylMrrvhRqu2MqDpDM9+q6CSOyfri60tK/nLUN1y
 z8clfrcDl/ceroyv97g/tbeLLAxZ1c6dM+LJ2ztm+JIZ1YcL1Sy5yTtn3MKDy5O5d608xVO6YGH
 mHb2a2RqtX3FaFE1zHHx4q/+ha98v5896SB2l1/ukZ8SwXJ5zWCzNS353de9W/tHpZtey09apcY
 apeipXa7+uLfYQZgpQr5tW2Tfe+ftKoe5FukWXtnU/f2f6c9DB2eeUpvLGjUmCq187zqob6y5jK
 +7OX1GlNa2RdLcFy0vnzqiSdPNfwm2vmGp9azv9czqsAAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently our test for implementable ZA writes is written in a bit of a
convoluted fashion which excludes all changes where we clear SVCR.SM even
though we can actually support that since changing the vector length resets
SVCR. Make the logic more direct, enabling us to actually run these cases.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-ptrace.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-ptrace.c b/tools/testing/selftests/arm64/fp/fp-ptrace.c
index d96af27487fa642e94ecc971f53cb78c233e7b44..56cf6e02c535b5c1cf1134c5b1973605c96024ee 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1078,21 +1078,19 @@ static void sve_write(pid_t child, struct test_config *config)
 
 static bool za_write_supported(struct test_config *config)
 {
-	if (config->svcr_expected & SVCR_SM) {
-		if (!(config->svcr_in & SVCR_SM))
+	if (config->sme_vl_in != config->sme_vl_expected) {
+		/* Changing the SME VL exits streaming mode. */
+		if (config->svcr_expected & SVCR_SM) {
 			return false;
-
-		/* Changing the SME VL exits streaming mode */
-		if (config->sme_vl_in != config->sme_vl_expected) {
+		}
+	} else {
+		/* Otherwise we can't change streaming mode */
+		if ((config->svcr_in & SVCR_SM) !=
+		    (config->svcr_expected & SVCR_SM)) {
 			return false;
 		}
 	}
 
-	/* Can't disable SM outside a VL change */
-	if ((config->svcr_in & SVCR_SM) &&
-	    !(config->svcr_expected & SVCR_SM))
-		return false;
-
 	return true;
 }
 

-- 
2.39.5


