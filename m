Return-Path: <linux-kselftest+bounces-23134-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7029EC144
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1DC188A962
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD5D17C20F;
	Wed, 11 Dec 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekEfOa+D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E38D175D4F;
	Wed, 11 Dec 2024 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879074; cv=none; b=Nftioe4HDkB5zqdgqfQ21LcoE6O22plxrPomUVT9wuzm7JEmPHuCInoW8jwzmWL+DMy0W605KxTExdvH2o6EcVmzekBv/fS6xgW/PNppk9uWiXPqptaaHktaCRnqBlLdethrA0+xciJyW5D3ad0Rp4TeU6v96AXj6PkuSGld6EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879074; c=relaxed/simple;
	bh=tQADLfY41IKkZA7AF+bwW0vqWMNKD/LB1TwUvRuOyFw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kf2RveaokNvvIz/GF4ufvUWSfH+nUlHyBR0MC6IOb1rl+ae7LkPQeESHhCwqRRwqIpEvI1iNt5dy+IBczekq4VUkhKK/TO00FrrkiPG5jEemabwPBU5u5ivPUtz1shlikz4OdL3XzwRg4uH7KAYH2dwjEScsBGIrlFaxbMmgOEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekEfOa+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76626C4CEE0;
	Wed, 11 Dec 2024 01:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879074;
	bh=tQADLfY41IKkZA7AF+bwW0vqWMNKD/LB1TwUvRuOyFw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ekEfOa+D7gTQPfXr5Lye5GpRK+oVf9lwGrZT14PftSwovtc8ztssd4YCoIvMd13oA
	 26PUmg+8tFb/n6rbePs78HsPAY7101P65l8CWESgaz9uIABnIe/hHNaFkPbMr62aUq
	 1X2F5RimLEHgXwo7mhNhgNLZvo6ltr3zpyJ0YPaADIsrMKRp0OzeezzaRcg7Z7g6sY
	 eV3qxSf18W4MK6+zMBVQVK9gHt3E8pyz4fdSjBJC+JaC7E+9flV9OXz4k8xb5QivCP
	 btNQsv6xBcdbx+odrTszf3xwUfv0TG4W8WSChv5VYmjIpsnxUmuTBgql5JLEa/l0J/
	 xWyb0JFbhECmg==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:48 +0000
Subject: [PATCH v4 3/9] arm64/sysreg: Update ID_AA64FPFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-3-0fd403876df2@kernel.org>
References: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
In-Reply-To: <20241211-arm64-2024-dpisa-v4-0-0fd403876df2@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tQADLfY41IKkZA7AF+bwW0vqWMNKD/LB1TwUvRuOyFw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUQ9vSB2ZButDKT3O5CIq700NkB8Wdk1iHpnq9v
 +9T4qgeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlEAAKCRAk1otyXVSH0JlHB/
 4pmcGhkRMFoqxjd8JK/sPpRwDExvNZGBH1O8DfXZMGJxyelW4V0/BcJHCVWTzHwe5XvPatleecP2rt
 p/mThbtjJKP+gWZBSzqo4smYVgADT5nLO55IYsEsOf2tOaLy4lUrnLsiSm2DMejN089x9gjChr/Ylo
 5x7C/yukXmmGyuPP7eGmb20amBiJ2a5+om/3isx6F0r0+6YXyiW0MAV5EDNZHjqNoJX1Hr9kpagq3t
 4k/zHG3ZMAxcD5+mi4/6XtcvViQGsTAz1Y4BHstmmc1wZIS4XPCpYC18cyT79OEfQoXBR8oQ8fc9lt
 xIt/gPh6BQY/NCDv5soD3WUOOSZY+t
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines two new feature flags in ID_AA64FPFR0_EL1
describing new FP8 operations, describe them in sysreg.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 6273068fd4fdef145cb7dd49e2d9bee4db467975..14284a120a5796bb510a0382984236eba9bf73ab 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1180,7 +1180,15 @@ UnsignedEnum	28	F8DP2
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	27:2
+UnsignedEnum	27	F8MM8
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	26	F8MM4
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	25:2
 UnsignedEnum	1	F8E4M3
 	0b0	NI
 	0b1	IMP

-- 
2.39.5


