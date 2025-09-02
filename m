Return-Path: <linux-kselftest+bounces-40561-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 809DAB3FE04
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 13:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AD04E35D7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 11:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621562F998B;
	Tue,  2 Sep 2025 11:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJIhnvVY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A671269B0D;
	Tue,  2 Sep 2025 11:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756813467; cv=none; b=enwlRRFWFFLm9Od2nMdOORWZOnR+61Pto94QiUWjn49l4dyrbpvWsksINGb/KWW70sK+lnKW6bndX1JHt48n1hnFjlKiOndo53nXJZnXyjlqqqNl8psQ2xA1aaM0+17ilX2O55bYMic+hV/FZduVWgs2Rp9c4NsVMmeL/pWYt38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756813467; c=relaxed/simple;
	bh=G6Ht9INfK364jYp0ofZOIq49bsCw7bcFjAmT7TRHKx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lch0X9E9GKPRPyGfLHE0REQ9gglU2tvHPBohSgEJF+UzQVWdesokWxAkj3E87c1VmT0NyFjOknZtV63rj6ZRON2Cy4x4oyW9ikNLm+y3n25LX9kl/ezP3CEFo4Eakw2iX3qm4x4zjSg3YMM/MTv7Z/ozYmQBaEeCK/JEgE6SO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJIhnvVY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A08C4CEF8;
	Tue,  2 Sep 2025 11:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756813465;
	bh=G6Ht9INfK364jYp0ofZOIq49bsCw7bcFjAmT7TRHKx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SJIhnvVYQuFR9TyxTzl3Kl/dkzJQBx0GRXQOcgm3qAQHYpngqcPgEfq3e2fUJJSm3
	 9+YTHYRmssQPG6azFD5RIRiYQp1nEEx1OnR3iPIflpAdQsTgvPWP1VXqA9QylndJBN
	 qkBofMd3J79V6SMXhwA+XfbQzNLtv20skjt7ab+4gEB09M2gBZbqEyaepbW3zmhztS
	 HZAYmn9NbGk4iBWmrcZN/IAM6XVE0jNZP+ACrXee1aep7KsapDcYGrzMmad8PFwdx+
	 Ys7hXRDF7AcTQCIrO9LROqUI0IBzRCUzgeWOn0a+XtZAFBPx/57if5ic27b4ds/tTN
	 3gyJ0U2QXf8ig==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 12:36:04 +0100
Subject: [PATCH v8 01/29] arm64/sysreg: Update SMIDR_EL1 to DDI0601 2025-06
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-kvm-arm64-sme-v8-1-2cb2199c656c@kernel.org>
References: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
In-Reply-To: <20250902-kvm-arm64-sme-v8-0-2cb2199c656c@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G6Ht9INfK364jYp0ofZOIq49bsCw7bcFjAmT7TRHKx8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotth6k+2hoSImM/h32YbvKVktd3/3yir2UgAmJ
 scXtjTK5UaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbYegAKCRAk1otyXVSH
 0NxdB/9u21D4uvIMz1tC7G+VW0wrH0PjUX2Cu34VnLsxk0WqrsW4URtOXQmUKwJvW2ah0BGmP6X
 J5d6odTp5J/yYibDWw7QpAq4zYu54l4fmE8RfTE3Og+W2/fTIdPCTW0uaBYw9WP1oUqfbjdkZCb
 4RUkXRjFP0eb/D8djZouXRY9tFhvXu4pJdiDMdkYQF6io2pEHKE7Ts1pDJnLAmlusopxQxWcQjX
 bEjuhtL+n6AytMok8B6FHRX6YarG3rPC4kUK5qpKn63P5+oaIE/WpAShqzioqYMHZq/XF4iBjSZ
 zxoK7e/peNR8mJJHA1qKO55MoHjS085cXTHp+HlzR4uo+G8W
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Update the definiton of SMIDR_EL1 in the sysreg definition to reflect the
information in DD0601 2025-06. This includes somewhat more generic ways of
describing the sharing of SMCUs, more information on supported priorities
and provides additional resolution for describing affinity groups.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 696ab1f32a67..9a1adb234ff0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3659,11 +3659,15 @@ Field	3:0	BS
 EndSysreg
 
 Sysreg	SMIDR_EL1	3	1	0	0	6
-Res0	63:32
+Res0	63:60
+Field	59:56	NSMC
+Field	55:52	HIP
+Field	51:32	AFFINITY2
 Field	31:24	IMPLEMENTER
 Field	23:16	REVISION
 Field	15	SMPS
-Res0	14:12
+Field	14:13	SH
+Res0	12
 Field	11:0	AFFINITY
 EndSysreg
 

-- 
2.39.5


