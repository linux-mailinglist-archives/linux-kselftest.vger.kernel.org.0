Return-Path: <linux-kselftest+bounces-22737-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF5C09E1DAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB49B60214
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91441F7091;
	Tue,  3 Dec 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MqLNpnMS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6281F708D;
	Tue,  3 Dec 2024 12:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229825; cv=none; b=owzXDlvFqEPC99PGpd5EjmH9MpQz1GQ6qJN5czfJsPDqNDBfc/kv0+xS8kk22W21W2aqygYteqMBTgSj+mQKx7xLdoaD6++Qq1+13fkbTQNdH2IAZEkSdOJj/k3MGKZ+zcgQwZgwdOLMVLmUY3hHxjrhbMZ8PT5NUxeuGiTp27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229825; c=relaxed/simple;
	bh=JZ5YG/ZPtu0+rE3J++aCFRB1wnbLT9/tbF2mceWYsQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dagZSfTuL7REhotYxCZVJqpVe8X2Qze26707EJ+slt5v186fE6jbVyShPWSoNIGu5fLw+GakBhTOHJ2ecMdJuRxK1MX97EtH3nnDZN0vlRbFP/daZtyviGUxp/AdzpUYEbGFyCiEfTKyN19GqzmDCihHdCGNJIAWQN5/tULSigg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MqLNpnMS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2744C4CED6;
	Tue,  3 Dec 2024 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229825;
	bh=JZ5YG/ZPtu0+rE3J++aCFRB1wnbLT9/tbF2mceWYsQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MqLNpnMSxfXKNkwAiyGtAHz+PjY/cEOqfzx5pk84QkspoLpvAFTQFHDuQCjBOaOcH
	 hrYzxEPOBT47SUYd8CP2haXoa3m220LYpP1V+E7FZA37UDa7RQ/AsmF/WXF1qTPjl2
	 z5hIL8DZigDgWiuy4td6/Gl4CkrjBQd9o9EQtFwqVctEiGb0pMx1nGwEM/VR33Y1ti
	 v1KgeYmOAGuR5YkSdSlHRZ3ETjREGAyjFDY6C1rxmQSZLJ9+YAebrLn6cEQjKzyYRT
	 /MQQnzT3CisaeNQ0ywvN2AAXkTXYjLai1zON7J4K1bdQlaZaj8vt9R0EjMN5nYei8f
	 jHktvBXb1YLww==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:20 +0000
Subject: [PATCH v3 1/9] arm64/sysreg: Update ID_AA64PFR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-1-a6c78b1aa297@kernel.org>
References: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
In-Reply-To: <20241203-arm64-2024-dpisa-v3-0-a6c78b1aa297@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=771; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JZ5YG/ZPtu0+rE3J++aCFRB1wnbLT9/tbF2mceWYsQI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz0exMUM1k05N+NteMxb/PS3DKFXKYKVDe2VAqA
 u7dI2GOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0789AAKCRAk1otyXVSH0OJsB/
 4qAZ0/ezAvRfl6l87cUQLXedjUo+f5aJjldDkEkycIdA3mI1yC+bS7BSrN4yPJJf7QAJ33nqOMvLw9
 xeogePvloWXukyFZktUUSu3IfhR3Pc9+rlaaaYTQRdxJAhNB6EAUI3tVzxKDP0eJIlTceaBRRuWBaN
 Sm61AwQhZ5pKS2G/5PNmj1i0d8iNy+lxBPvjuOLINs68EKSBardSmzQkzi9FWjyKqsqfERYZdlLwTM
 P8qti1abSvRRd1KXnM73EUY3nufr0ZHogeLzNClxNQAfKEO6AKAQEgC+HuGBeJ/fK2wVeOeqVg6C/q
 jNMPPMnKFaUU3ernj4bq888DY8eHlT
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 defines a new feature flags in ID_AA64PFR2_EL1
describing support for injecting UNDEF exceptions, update sysreg to
include this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b081b54d6d227ed8300a6f129896647316f0b673..911f16c82ebd3ee98ffed965b02a5c6b153bc50c 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1010,7 +1010,12 @@ UnsignedEnum	35:32	FPMR
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	31:12
+Res0	31:20
+UnsignedEnum	19:16	UINJ
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	15:12
 UnsignedEnum	11:8	MTEFAR
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.5


