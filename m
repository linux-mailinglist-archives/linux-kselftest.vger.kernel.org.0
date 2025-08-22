Return-Path: <linux-kselftest+bounces-39621-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E576B30B00
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 03:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706DE568069
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 01:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA80C1DA62E;
	Fri, 22 Aug 2025 01:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM0M271g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E31D5CC9;
	Fri, 22 Aug 2025 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755827672; cv=none; b=ft/zB6rcdBTqMOP1xmHDCe6YbGCmv7FAn3XSdCuPmRNWNG+a5Y6sT7KkB6603FUuyhOjoR0E1WRpp9GHCtUHk0+sOPH6gCDbzbmCTZtFdlqAaYNBE1Ngi48GT4lHwuWUpWGy96cy5hvPB8mzZMqMto7uXplDeaJjwN/DChfILSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755827672; c=relaxed/simple;
	bh=G6Ht9INfK364jYp0ofZOIq49bsCw7bcFjAmT7TRHKx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIcF8ld1dgChHB3DpTgxSvUjc8hdENbEJxITJUX/N2M2OTyxYu3J76CTAK+DCOg9kziYm8aiI99StLkqcd+I/2uIJmjUaBADj/BilneyDQehtsCZCH3NR+hyDJQ6hBx2YFTLcYV8dSUdRN4N7jp7rIJa5Ut+xcGkmksGSg+342k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM0M271g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3971BC116B1;
	Fri, 22 Aug 2025 01:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755827671;
	bh=G6Ht9INfK364jYp0ofZOIq49bsCw7bcFjAmT7TRHKx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DM0M271g5lQPwotvwbxFy0I9y5Z+lweO6zmFZ2UMsOPxBOBfO/wvIcnPwF7Jvm5Om
	 cgOs1GZQuDSjmo7qT4i3KLJ4/xWJjDZCa7TsascPFOvdzndZUfBJha8ezQqaTcb8EF
	 1jDPlNoF+lbfB/qLl9aG2p0CF+hcQ25MBtAZtp1pSn3tYGyNf/BkDwHamRQwQNCjbB
	 /ZC4+uPLzDN6YqkX60p6SMzmvYX0zncJtvEwetn4Y60gdJUJJeq2T2W3DtU/soGWrM
	 EjA6ZvGxnMFE4s4huyW9gpE9j9tG4VAP4pQX5EaD4U/dftCJjMbdFNVRGdzgmEBGDW
	 f5UCNCFgiGggA==
From: Mark Brown <broonie@kernel.org>
Date: Fri, 22 Aug 2025 02:53:30 +0100
Subject: [PATCH v7 01/29] arm64/sysreg: Update SMIDR_EL1 to DDI0601 2025-06
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-kvm-arm64-sme-v7-1-7a65d82b8b10@kernel.org>
References: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
In-Reply-To: <20250822-kvm-arm64-sme-v7-0-7a65d82b8b10@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <shuah@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Fuad Tabba <tabba@google.com>, 
 Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org, 
 kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=933; i=broonie@kernel.org;
 h=from:subject:message-id; bh=G6Ht9INfK364jYp0ofZOIq49bsCw7bcFjAmT7TRHKx8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBop825gBpk0joPx8ZrHWCZPK5OkpZBjPVq+c7zj
 Kis9wVS0myJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKfNuQAKCRAk1otyXVSH
 0KlSB/0Y9abY+riGwYWOySjPbCGGTymnhIrc7+c9wMa2G6eLR/t4z92bKXn7x4Eq5vcnkWyZPzA
 y0IG/CFXetslgbuLUYKUEcwfJxVLJOLlIuwUN5nYf5AYZKNwPGARQthDiEEqFkFctEaed0JCn6f
 yw9mpvyPjnCPFsFS4hhGSldHvGOJNTfUfa16PIo+nxDcC6FjyCKx9Hb6HkIXpcVXtTkVfI/Ddeg
 /w/uyo1fcAQAaFnMrevZh98pynztRoQ+F4bYJYZZtQHcTxdJL5GS3J++UQNPz087tDXv9oSFyby
 24efFVecbhL51mr+nsH1WR3RYHO7RWnQlVvdDRPnS+JcB4fh
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


