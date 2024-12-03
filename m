Return-Path: <linux-kselftest+bounces-22740-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511E9E1E04
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 14:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76807B4435F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 12:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B111F7590;
	Tue,  3 Dec 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhRL8I++"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9341F7571;
	Tue,  3 Dec 2024 12:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229834; cv=none; b=VoAvSSRXx0T6rMHQtjNTK/9jH+BV9iVwP0qT84gr/MhjV+71xH1vQCPV7stOUWqx1Kk8101wsEbhLELYJPpQfyEg0uLh84kxzkJdE8hnrZxlsZRq6IBck77aeYyBLTyscRHn+pLViiYtpm3Yfg4yWHprClCj/2AmOL9P2eRSi4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229834; c=relaxed/simple;
	bh=NaojwUVLM21ZDZfygwwfm+o2K56m57qMKMUVUASrExE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lFRR2vhtEA4YK3xI8kEVimNhdxKMcxfpb6PDUNfIOIu8oWWjyHR/zbzy7a8HMUS349UgHAzzabYPZVIUXHvswIQV7o5MvTcKhCm6M+dGiMtt6Xu8NRzrxZ8gGSF3/GEA/u+3/cez0kyTcIrJxY+eEApikXbjlPLvd5Dsnt+PlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhRL8I++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B225C4CEDE;
	Tue,  3 Dec 2024 12:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733229834;
	bh=NaojwUVLM21ZDZfygwwfm+o2K56m57qMKMUVUASrExE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LhRL8I++S5auftxIgrszQZbuYIlRHcoh5MJlB69fJ70Xl7bvSKawwwUknuxCXKLM7
	 IkBguPnTKG9CnkUzzDHcrIJUad3DV16YKR+/hVo23j3AWZ8IIDLvE93rFwMiSTOEYQ
	 EyB5peoyvHBy3NQEpf2kidhJtvQmqOi850wlSU7I5qpQ0pfPESrkUspO9PP2/j7Oqp
	 hNzNC3RKwwdRemnLo4Hyuy6SADhbQ6mJktWrz8CuCUBLPAalLvxkyq/0hRLXzEPH82
	 VCMolscJ2nj6nUvj7tA9kXNp4nZ/xrmXNwOtrR4dDdYhLZoLd6J6HchhZKdGg4otnY
	 t+uQfZZc1EjVQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 12:39:23 +0000
Subject: [PATCH v3 4/9] arm64/sysreg: Update ID_AA64ZFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-arm64-2024-dpisa-v3-4-a6c78b1aa297@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1302; i=broonie@kernel.org;
 h=from:subject:message-id; bh=NaojwUVLM21ZDZfygwwfm+o2K56m57qMKMUVUASrExE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnTvz2gK8oIx8Fu30RdmRdl5fa5wHYofielI0roi8L
 V0SdG+aJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ0789gAKCRAk1otyXVSH0L8mB/
 wI4/N5k/3zPdplG8iWP8owY7F0Shk+4oj2pNAbjMumHTOzO7GoCiP80dRjXbtFSm7BgkMFxP62frlN
 PtbqhN/VML6TU8UZmnYtfwYuSB8M2Ip578Sv/c5P82wmPTgN4KlBVkthL6v/rCUROeKe83ezPw+wml
 580yIdC4xf9JFOPWiBKSgdMSk0f7NegEO0pLSYyqEvKYsReRenq3MsKAfe/S5VgFsGAMqNOgpRbdBx
 qUEU+dja3OvlqjJy3Kh/CRhISwsQu4acKiPIGIpbm1JBR2Qu5fiKANjiuiweRUrmwv20ykVOJP8lin
 XcMLG7CmzgQwtkeSBUk+MxPNi+iQxt
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SVE 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64ZFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index b44ab511cf5d9d33efd7dca304d0e2f53ce47810..7e6b204e83270daabd0036c8109b2fdb0e9b700a 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1040,7 +1040,10 @@ UnsignedEnum	55:52	F32MM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	51:48
+UnsignedEnum	51:48	F16MM
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	47:44	I8MM
 	0b0000	NI
 	0b0001	IMP
@@ -1058,6 +1061,7 @@ Res0	31:28
 UnsignedEnum	27:24	B16B16
 	0b0000	NI
 	0b0001	IMP
+	0b0010	BFSCALE
 EndEnum
 UnsignedEnum	23:20	BF16
 	0b0000	NI
@@ -1068,16 +1072,22 @@ UnsignedEnum	19:16	BitPerm
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	15:8
+UnsignedEnum	15:12	EltPerm
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Res0	11:8
 UnsignedEnum	7:4	AES
 	0b0000	NI
 	0b0001	IMP
 	0b0010	PMULL128
+	0b0011	AES2
 EndEnum
 UnsignedEnum	3:0	SVEver
 	0b0000	IMP
 	0b0001	SVE2
 	0b0010	SVE2p1
+	0b0011	SVE2p2
 EndEnum
 EndSysreg
 

-- 
2.39.5


