Return-Path: <linux-kselftest+bounces-20842-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 805E69B3BB7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0191F22E15
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE505204088;
	Mon, 28 Oct 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ztrykpt+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C781E25F8;
	Mon, 28 Oct 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147193; cv=none; b=Iui26oFa3Xe2o0UOvPx2eLJ+j46lE5fJrg2OuHwrqBPH9sjkwPUdF5ErrGzxMTrW1A1LOfqBfKaTSunr2ATdE7RVZM7NDxf2nE88OE8dXuGnmM8TzTYUiGwX43jW+eoDPmiyU2f5lPnaBdS+WHVvLzlvs2tWWISrSb/tdWJBPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147193; c=relaxed/simple;
	bh=txJPBAKW/px8wqxUeO43xJFh9Jn0eyt07T5bMMNoQs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mp9keRDQH+SvaNiynFE3qXYI0waaGS4lrvOJrBgdyZS4TleXm03GhbGdaGjdOGvfq6wTjHQTThRBqB446GFcq7ggnVE+jVv/pTvj2l6mnJtSlWHiYAzql7kCLID1noX3H7J9PebH2KQds+Ozr4xg522DGmQtyj0XGWzdQ7ufrSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ztrykpt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94765C4CEC3;
	Mon, 28 Oct 2024 20:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147193;
	bh=txJPBAKW/px8wqxUeO43xJFh9Jn0eyt07T5bMMNoQs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ztrykpt+4b7wD4gyj6F+Wr6ZINzimVJUWczh+xmbnDbb55sTX5kn9+tc4qgX/jIhW
	 klLnlzPu/Yo2GHMWMXbhh8Pp1bGKYOgl6pV8vRwHOQMeZBggY01628hCMd/i1V/GYl
	 GVbnEdvSLoOB2zSzsimquyN4sg/WZWKMIAWFOUy70BSkKGBq2zzK5nwsRf/lm3klA1
	 PiJRjsOFWyeL7bqxIQXMJkrkPfrU42RdAKBlQ7L5760CuSmVViFeSPTQeYYXkocTlp
	 lBKMYK1mq5HMq6Ev1/BRMCSXPAUq+QcVXycTCxLvWjI8su+GlR6obHnIaOStDhL9ky
	 b2hzEssrxzG7g==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:12 +0000
Subject: [PATCH 3/9] arm64/sysreg: Update ID_AA64FPFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-3-a38d08b008a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=broonie@kernel.org;
 h=from:subject:message-id; bh=txJPBAKW/px8wqxUeO43xJFh9Jn0eyt07T5bMMNoQs0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnH/NnuV9phKJk9PYMPihoIk1sMnV7v0rwyQvWGFwr
 BqIRvviJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZx/zZwAKCRAk1otyXVSH0IxZB/
 9V3mOfS/3YcuhQpBI0oXyJHV9MoTvOq6YGCtMPwQs2imeiPfLoooRLEAVju+MCRFb7WxFaV6Uevp0K
 qu4i03F+KDohg7V5MgE2ODAMS+r9xn4fpLVXWBiIfJ1xCdDvsOd6dpmKLqAYGqODvCvk4sF/W6+S6j
 q7y2KTfR76DWdMXdBod6WAG/SL45Ck72Pzm9BBBggGrxw/3XSwzy5KqjqrFtqDiEAczxjU1bpZsJya
 z3I8KrQR6yRmJqZR7ZxJKTgmThmyaPZVXbb1HF9DVPVJYZ+JuPZrr/VZOyhNlW4ho9Ah2N+tAhogx3
 Kh25R8TO5Infk8/21yO4RIoDjzP9dZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines two new feature flags in ID_AA64FPFR0_EL1
describing new FP8 operations, describe them in sysreg.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c77343ff0901bbaee98eb76615dc7b81a563c4b0..26f1350c9d2e3baf39ac3bdcc96fc1e6deb5a5c6 100644
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
2.39.2


