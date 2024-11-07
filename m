Return-Path: <linux-kselftest+bounces-21577-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70B9BFBC3
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 02:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C841F211AA
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Nov 2024 01:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A28A7868B;
	Thu,  7 Nov 2024 01:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UihTm/GH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9D96EB4C;
	Thu,  7 Nov 2024 01:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943544; cv=none; b=tDlewKc0x6v6ZLFHNAQ7zqFVPvjYjgMVqILcpPYJJc4eCMurBWzDPdd6lCsYoKpgbSJEu7jcDDtqLbNFdXV4S6i9Snx4tM/fjH7tlrDFLfytWKsxfk4S/brWZguDM5TDpCkSDFZKZY+jx/G2od+5aLTlJD1wGmO1gXV9RadFETg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943544; c=relaxed/simple;
	bh=KklDMIgTg/IOEK6oxdwvdnPBCakPUdGsPPh8gcrBzcE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sAQT0C7ughLtj3do/tV0sGQ/kMFIK1JsuKjyfPCi5TYYkfRBGRKfa7lZb+/xPpTFR364lCKrSXS1x2fz3daSZUryx474KaX+bPKORFWmgolMkRnguHiXegu1SsAigFEautouh1Xyze4wPDMEMgndrHOC2PXZx8i7MqjX/P4Vox8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UihTm/GH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13874C4CEC6;
	Thu,  7 Nov 2024 01:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730943543;
	bh=KklDMIgTg/IOEK6oxdwvdnPBCakPUdGsPPh8gcrBzcE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UihTm/GHRtLziJ5MHQKpNiGQVbYwHV4s7wXIXepK/uTo3Hcu4gdAqhS6M/WfR/vM8
	 /z3TGvCgxn/ebUpIcQtmJ/jLqqgtdplkymYX6HA2fdZj3vyu5gK6kncipxyjJ90SmV
	 7kXRkjOLDYSazv0BRB8jEU4tsJ3FvM0uiHiYm8mvnrDLSgkKB35OtqbFe4Feq8a2RG
	 ZL6gYFybgHgvb/n9QoxiOvcvwyTMHBrIg5sbyT0wmN9or6yNnes0lSN+ng4XjlT15k
	 tJSVtN67TK21bf6pwh+MSVyUJHHDGoXSou7ND8daNQcobAKlM3oTERj7x/EAO1PJ54
	 5Nm4O81+qbbpg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 07 Nov 2024 01:38:06 +0000
Subject: [PATCH 3/4] kselftest/arm64: Expand the set of ZA writes fp-ptrace
 does
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-arm64-fp-ptrace-fpmr-v1-3-3e5e0b6e3be9@kernel.org>
References: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
In-Reply-To: <20241107-arm64-fp-ptrace-fpmr-v1-0-3e5e0b6e3be9@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=1674; i=broonie@kernel.org;
 h=from:subject:message-id; bh=KklDMIgTg/IOEK6oxdwvdnPBCakPUdGsPPh8gcrBzcE=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnQdKb0Q/VNPg0Pm2klw5ssbN95+tDtay8dsohPz91d7387x
 +prTyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBMpK+B/Z99llzGdrcXVg7+HX/mn6
 /e8K6TaUe/l2bCVFHD1bXaOS9tivgbuTfPf3ov66HptM6ohUuTeEPe39z51jfo02OWlUt3xGl4XT6n
 MEtVeqf5RqvUAA7eGVUFWgrN15gdWHW1bnoeytsckHpw2crysx5NnTdl9XYskGRdWFj4MOGzh/7Uaw
 wtp+2FP1hZ7I2Yl97s8iHQRFU5avHB4vAXTFlFsYXP5wg/F81fGGWuyZ7wPbxsZWphyJQLzKG6qu+O
 x0tecV7bvqItqmTR1oyct3tFmOb1Vn903cDufnlW/rsTFmEHl6+SCGSb++cIczRzn3/UVIFv0stS+z
 m7rRv4Wa+t2ySctObrvO2S8gK2AA==
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
index 22d52a75ac9687673c4354f66abcf7204ce17875..a35dc6d8f82af47bf6adedba7e69a6577ee9f7de 100644
--- a/tools/testing/selftests/arm64/fp/fp-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/fp-ptrace.c
@@ -1080,21 +1080,19 @@ static void sve_write(pid_t child, struct test_config *config)
 
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
2.39.2


