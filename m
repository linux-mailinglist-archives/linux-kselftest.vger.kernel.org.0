Return-Path: <linux-kselftest+bounces-20841-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF2609B3BB5
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AFAB1F22204
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B7A20402B;
	Mon, 28 Oct 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVoJOtnl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95041204022;
	Mon, 28 Oct 2024 20:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147190; cv=none; b=AAqQ7JV2AxCO5cggxGj9vc8gvfE0TtWKZrNGoH/WcIfxrsksCUAJ1QkAmrTSoVXWIYkQ9gVDZ1hKCK8/zaclfkyBc3BHjfQ8VP824IjD8/t4vg7tUCHb+WPMw+4c+v7XiSFJ6NjwmkHH24kwptIbtzZJxJsy+35wUbnV94FBMTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147190; c=relaxed/simple;
	bh=zpkfrQGx3HEw4mQkvZcocv9aZkCal4I29KIfJ/D2G4s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PpHSrU3j3WQ2t+nG9Lr5Xyw8ja79xGhEFtcak+CmsVCStnxkU4EOr11/HNVCYbKQk3EllSq6c6q8sxplYkD19f0SEKpyDBV9h/ZZG6+mmUJct6MQwIV3ZGBcetC7erkGNDl3M5P74BulChLzDntf+7XTZ8kEPirwZBwMT3WFAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVoJOtnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930BEC4CEE7;
	Mon, 28 Oct 2024 20:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147190;
	bh=zpkfrQGx3HEw4mQkvZcocv9aZkCal4I29KIfJ/D2G4s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LVoJOtnls23eeaY/JLQ9u58NUppI2xcVbHSx61MBQzlwCA9cvWdyqkugW21ljicTp
	 RH5u8HEe/rDyPYo/EblJOSZGQxmDcocD5anHKnFeehpHn/l+6rF1IWo74bChmbKR0q
	 DqCV5Tc8g7HmrzOqxD7Yeca/EX7a6nSKiDGxV59PjA4RTVSjsPToxhFG/TM/80lHpI
	 z/vCkmAXAaEQAmKRT0MWEJjn4sOIu0v0mlXvqOfVsiT6DFYO/UKXv8/jY4bx9llwJv
	 gOmslRVjsSxFhoE5FH/zwk7FPnV8g1/fVnuLC7gCYNDe1Tkd0vqhLNF0W82w+IsRJC
	 H4GJjhKcNtPyA==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:11 +0000
Subject: [PATCH 2/9] arm64/sysreg: Update ID_AA64ISAR3_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-2-a38d08b008a8@kernel.org>
References: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
In-Reply-To: <20241028-arm64-2024-dpisa-v1-0-a38d08b008a8@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=944; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zpkfrQGx3HEw4mQkvZcocv9aZkCal4I29KIfJ/D2G4s=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnT5z+lfj//cpOPFHn0oY+PzWrl9shuCzibou/z988Bh785k
 A/WVnYzGLAyMXAyyYoosa59lrEoPl9g6/9H8VzCDWJlApjBwcQrARLaHsv9TPs6/mcEkp99f6M+uH9
 v6ftW3zZa831Yfc7JL8EpTu1CmZO2ePOeLdQGLlj5cm8apEblc5tLXtddZHBUWBEg+uu6U2JLq4Oip
 sDBshbhOZrvR5z8Rd/OYVe3z1JIntqpIn4g4oXH1qJSfvZ713czJNULVEe9+TQpw4d1Ypif4Iasm78
 d3lluHUk4tdt7PYmY82bT0/69EJ+7omQGFHX+9zBpm/rzaN6Eks3z9ros9N4tktwT+ifWMelwvfWfh
 jKl8Hro+dXlMX3iNZy2/wvRTRE5mYq9WOONCtg0uoacjN0WJFn/1P87By/CO9XFLWNfxGnWF5080S7
 ZW7rBJMu9KNJWeFyXd2vY5KfYvAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines several new feature flags in ID_AA64ISAR3_EL1,
update our description in sysreg to reflect these.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 72d6ff1a9c7588dc4894ec6d673791fde108a857..c77343ff0901bbaee98eb76615dc7b81a563c4b0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1531,7 +1531,23 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64ISAR3_EL1	3	0	0	6	3
-Res0	63:16
+Res0	63:32
+UnsignedEnum	31:28	FPRCVT
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	27:24	LSUI
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	23:20	OCCMO
+	0b0000	NI
+	0b0010	IMP
+EndEnum
+UnsignedEnum	19:16	LSFE
+	0b0000	NI
+	0b0010	IMP
+EndEnum
 UnsignedEnum	15:12	PACM
 	0b0000	NI
 	0b0001	TRIVIAL_IMP

-- 
2.39.2


