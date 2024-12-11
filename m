Return-Path: <linux-kselftest+bounces-23136-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A67F09EC149
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 02:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3281690BF
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Dec 2024 01:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EE519F11F;
	Wed, 11 Dec 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jig45qAH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9018A6D3;
	Wed, 11 Dec 2024 01:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733879080; cv=none; b=k0uenUHYx4SZkDHa2zZ6FYXUGk0MqFR88bqpyW0Ex3L0nGtSByyYJMyrfUeFyOiBGJz62wnmXhLamNgiDGSWd6AgcuOWpCIWhFj6qCHEzcCubYNie1maSGbHpdnNU2/edTA30R0CMHSg9oOf856MVqYtukyvHnCixaowz/br7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733879080; c=relaxed/simple;
	bh=D+ekxMaZJ4bu/QgKDMmDwTyVaCHyF9h+lu4yMHG3Fr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ajUiC3kaUnJRzKIr4AqvTFU5Yq+jIGHUXzeSXUSIXB+A0ljCZu+9uqkJE6fw3d9eCooezBYcGHLI+CAmZWOxbBDjbC+Msd4ASje7GavzpSh2Kw1WNC7gfuDhj+qkmOyBphqoqUUQyJeYVN54eXrKZ55NMHpV/LRo4chd2cNSF0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jig45qAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67295C4CEE4;
	Wed, 11 Dec 2024 01:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733879079;
	bh=D+ekxMaZJ4bu/QgKDMmDwTyVaCHyF9h+lu4yMHG3Fr4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jig45qAHCAYtmBYE5+CE8fxYhV7h9nuGy4oR8pubfZPFYILkV4+w9Zir+jn+PhZPK
	 yCHF6/atwf8RvI2VTgFcwLWFe3EajnCCcO4PveBPCOT5vE0I/17CvH2kNoSMt0iAWK
	 V8uJcYnvkW6dk0RsaHT3K/Lqjs1zsXfju9yl8BmtpRY8fMsRtw/yiKmyGPXOFSeK90
	 sBCCCGVau37CC7dlAj4F1zERyWIMlZ9U/nWltds0u3GUoD2ThF9SET1YuAx3OxonS9
	 4M3BWbFyjWXAj80jpNcB+XumEmPs+p388geiSwBl2p9PKbSrt7yZyt+jS344M3CxxT
	 9+Jc6mUs9nYiA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 11 Dec 2024 01:02:50 +0000
Subject: [PATCH v4 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241211-arm64-2024-dpisa-v4-5-0fd403876df2@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D+ekxMaZJ4bu/QgKDMmDwTyVaCHyF9h+lu4yMHG3Fr4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnWOUSn+pwvZbrPc/XVepAvxg2ayGL41bDZ0s6gR6C
 sj1dDx6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ1jlEgAKCRAk1otyXVSH0EPtB/
 4hlGPRUu3sTAj3l0XPBJMqa0ifeT7VpAlUyazSgpagYgW8DUrwk4EhQ3EwS3wWdomSWQMgnMRnkDJr
 UwQyraELpVHC/G9wz+yWJ+7pTvInAojunLezWZ71QuQfa8CzbV9L3xhAuGcCHleOasEmU5QPOvxHjx
 klDQmsu1PaBM4Pb3MHzX0wSjBS65zhMPpAGU2cf+ysCV/x3d/uA4TBN2yQ5iDBfNk0tiYxYFiIeVyo
 4w2z4iX9vy1p3k1yFbwlv+mtBlOXLo2XWU4x/ylbu/HxFeQ6iEszRqy6UZvo53XKeWP5jDNZd3BNS8
 +enXEwH6APpaictQCWKmxhHj10+8yZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SME 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64SMFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index c792bd3b0afbb5fb7e438a4d760d9f2d15621eee..d78b12c59658b480739ae797f5ea2c2f14d8d765 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1105,6 +1105,7 @@ UnsignedEnum	59:56	SMEver
 	0b0000	SME
 	0b0001	SME2
 	0b0010	SME2p1
+	0b0011	SME2p2
 	0b0000	IMP
 EndEnum
 UnsignedEnum	55:52	I16I64
@@ -1169,7 +1170,36 @@ UnsignedEnum	28	SF8DP2
 	0b0	NI
 	0b1	IMP
 EndEnum
-Res0	27:0
+UnsignedEnum	27	SF8MM8
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	26	SF8MM4
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	25	SBitPerm
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	24	AES
+	0b0	NI
+	0b1	IMP
+EndEnum
+UnsignedEnum	23	SFEXPA
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	22:17
+UnsignedEnum	16	STMOP
+	0b0	NI
+	0b1	IMP
+EndEnum
+Res0	15:1
+UnsignedEnum	0	SMOP4
+	0b0	NI
+	0b1	IMP
+EndEnum
 EndSysreg
 
 Sysreg	ID_AA64FPFR0_EL1	3	0	0	4	7

-- 
2.39.5


