Return-Path: <linux-kselftest+bounces-88-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D67EB22F
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 15:35:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738901C20A58
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Nov 2023 14:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2C3D3BE;
	Tue, 14 Nov 2023 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmlkUwAW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC241227;
	Tue, 14 Nov 2023 14:35:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E02C433B7;
	Tue, 14 Nov 2023 14:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699972546;
	bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AmlkUwAWO2XqB5Mupah1fuEkJfhJfVXANP0fSOIWheOkkVyEjYgz9j3yvniTaEqo4
	 Ry/qFI+imv6qgGXpOBByNfMkimEZKWOhV3FsiuTfmz5th39laHGXiEr2oVZw+e15vS
	 EtZ26tvBObAmimNESFpf86DUkEiNBu0yN4EUnUTJ2f+ruHKJSCUH5px2P6xwl10VyY
	 GavVQiOgexaYYyA7A4mgnR1FO8y8usaViy6rShuWdbth9CqRate8QOQjPMpp8l6fKj
	 tXEJ3H/I2loXBwCWGEmSxjZEf1j3aKquS7WnOX7QXEfgoZRPj8NwMeYQIKRmXmvhez
	 SwKH5B7uYA/gA==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 14 Nov 2023 14:34:52 +0000
Subject: [PATCH v2 07/21] arm64/sysreg: Update HCRX_EL2 definition for
 DDI0601 2023-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-arm64-2023-dpisa-v2-7-47251894f6a8@kernel.org>
References: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
In-Reply-To: <20231114-arm64-2023-dpisa-v2-0-47251894f6a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=666; i=broonie@kernel.org;
 h=from:subject:message-id; bh=BQwIlG0oOgH2zbKU3AwqILoaXU3JMfSvJqswNhTlD0w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlU4WaHe/+M/b5X9jP1rg5p8morKdu1D8EE6Ahjim2
 yAvg02yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZVOFmgAKCRAk1otyXVSH0J+2B/
 40ib/oULdd/d9oZVEuawOWDa+pD4lu3zatx1xVBQOmZy4xvOcIiLzhjp8vhx2C7aLHPkRYpIm9t0n0
 TCcHEMnJdWHJTLn6ovctmFh9B3ERG4KJ3n9ZkB2UTnMfxe7VGSFsVu4H7i3r0kmwIXzrqAQbxuis5E
 acPfNP0zEi+QM7eIrsTYq5TgIel0icPITsGchgTknOC89jSdgJ5xQHwlBGgbaaxUxLSPxMONxajjDR
 gRTbVr+wEkvkQ0HaFv7Ef7qQP+U1KvsRmaZGQTNEYa6Vdz++KvgMUO11ClQkFvs3jUsRhUYcgTKj0m
 LnS+mw+o0eDK+3veaphPvBhj2vW4Lf
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2023-09 defines new fields in HCRX_EL2 controlling access to new
system registers, update our definition of HCRX_EL2 to reflect this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index eea69bb48fa7..0b1a33a77074 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2412,7 +2412,9 @@ Fields	ZCR_ELx
 EndSysreg
 
 Sysreg	HCRX_EL2	3	4	1	2	2
-Res0	63:23
+Res0	63:25
+Field	24	PACMEn
+Field	23	EnFPM
 Field	22	GCSEn
 Field	21	EnIDCP128
 Field	20	EnSDERR

-- 
2.30.2


