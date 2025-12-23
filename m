Return-Path: <linux-kselftest+bounces-47871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A5ECD7A6C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 02:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D2ABF303E474
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Dec 2025 01:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB61C23AB98;
	Tue, 23 Dec 2025 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+wMq0lM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2096239E8B;
	Tue, 23 Dec 2025 01:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766452899; cv=none; b=TScCCZC+RRweM6b/SabN/D2ypXun5DV3ARwQDhBnisYHZVDcUGzl1umHnXHMmD2FNJf/7aLjGkHJxBboApNwzaVSAWEgCGu9gv/sBIqZtBpcI8TolTcLrTw3rbBrqkNgCOzfEeicICQND3/I2MH/jG+EyBnrrUJQyqG1NxcL3uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766452899; c=relaxed/simple;
	bh=tQ8nCbdUJTwo8MNk2MKXqTeJ5K+/vBwe4kIZ5maLhR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fq4YtKpshZ2ZwWPhaB5dTDnv4CDa61eiowtiI5t+a6KBsKt0wCO77DCEDdFqSvY9ccfHggS5IyRGzZNLFlqyadjuQomqeBXy2RYGd8e3HLrQgJBGh67lj3isNWf8oFIXVqqRJcwcxieRu0EpxqjSOO6ku9CN/OGSeZMhIL7EDxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+wMq0lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E5CC4CEF1;
	Tue, 23 Dec 2025 01:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766452899;
	bh=tQ8nCbdUJTwo8MNk2MKXqTeJ5K+/vBwe4kIZ5maLhR4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o+wMq0lM9/+TnKbl+gbnSg9x8/g3lu3ihq0SGAdQYaF+0bUoyrsOkzpJBpTTg2YB7
	 6tPMhxBwbyRvG5JB+g7fOiRNAIrtiYZUbAsainxIGTCa00nZ/XySqArv4JQ/wF2nkR
	 tcfB/h8cRLNQ4teEl37H49eVcOD8wMJHG3EQRz9U9Y2EO43AtQ1HYdPAalb8mTx7ow
	 aqihYKHy0ceFpTD0YvztYTipXXW3F0lUR7L5ovqEqfLVKmqXxoCDdh3KTEUicDUE0f
	 DT9K2M3Wv68vVMR2t896QcnovfV+/nW5bGcSXGLLI9A/w3M0aReThDigP5BpMeCnPj
	 NyC05wevFK1kQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 23 Dec 2025 01:20:55 +0000
Subject: [PATCH v9 01/30] arm64/sysreg: Update SMIDR_EL1 to DDI0601 2025-06
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-kvm-arm64-sme-v9-1-8be3867cb883@kernel.org>
References: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
In-Reply-To: <20251223-kvm-arm64-sme-v9-0-8be3867cb883@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>, Oliver Upton <oupton@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Eric Auger <eric.auger@redhat.com>, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tQ8nCbdUJTwo8MNk2MKXqTeJ5K+/vBwe4kIZ5maLhR4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpSe6DNOnywKTsW/riZW5QxkSLSd9jk8d/Qf6pY
 wo50Sp4oeSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaUnugwAKCRAk1otyXVSH
 0GA8B/9/H1nErknV81fzXgbWjeIGEgxDVkGySJGQzFxbf2QyQQAxiZK4/ij0KRuOJ8umNWiahUE
 iCFHNIebt6kPq9vpkt9LXE81goKCCbaUz+ZbUuYFVIukNpu6XQb9MHZ2KfhNdS1yDYAfm7HaM1S
 vA3DdQxXbL6034/x5lXG3nNe1+iilzoh9EsL7uXziStnrXVKUeBERhloAbF+t4XozWyy8KwIXgr
 c2X1v6nWIIxNqqnOT7K8/K0NXLpFM1B9OkEvuoxlltV3uh1gBA2bQ/8Ci6LI1dCEPfy2VIW3oTv
 vtLtah/EkNAeQ1vYB6oGQ2t8YRkukVeuLxzRJHC0z4+N9cpu
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
index 8921b51866d6..6bf143bfe57c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -3660,11 +3660,15 @@ Field	3:0	BS
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
2.47.3


