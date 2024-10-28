Return-Path: <linux-kselftest+bounces-20844-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 168379B3BBD
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 21:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B790A1F22D95
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 20:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7FD2040BE;
	Mon, 28 Oct 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3uO/ulc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B110F20400A;
	Mon, 28 Oct 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730147199; cv=none; b=Vz2HBITskBXYp0o9PiGV0A7S4MhI2YmgxF4CF0EnCW3QNThC6vT8c/XbVAKGxRKTELol770pTiDg4NHturqo7EJE6qoPGltRvA9oyA2NL9Uye5fBXNipDaYXCyFoiVG4/DEC5qGI50iN8YCreb/POFB0Aao7XEXklzZIt4lVJrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730147199; c=relaxed/simple;
	bh=7uuIvssgPmNN0rgvBR2HltfMJC/cwbms6ZSXTgQ7BIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uCPK2PggaAtZZntZ+JpxdRH40AyLH72+gTQmL62Z2iKefbl7ajmR2QBQ03Pn9SHs/ex0U1PQUG2n6Oqw3npPH2YASXcZTagPHKpeeaklbYK9Zt93tXJqVw3u20mH+wGoPhtw9Z2eEoYG/z8HHFP6mtp5imaZALMH/5V4W0jSj4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3uO/ulc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE27C4CEC3;
	Mon, 28 Oct 2024 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730147199;
	bh=7uuIvssgPmNN0rgvBR2HltfMJC/cwbms6ZSXTgQ7BIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l3uO/ulc3ocueXipIvwxjEj/c0ijlaZ8oAL1cZRXhMGXqldt5LMHpkebFm2iuqR2R
	 7lbwBHsAAPGxe/+dCexr2UqrJ5wc6L7KrxBvFHgyV0XOkcZlXtjctHrvu8u0ZEbKlY
	 9nloLi+6tYnF3gzNGET6LnpXD8jgenT89wgATOkpsP1Ldcn1dn7BCPodS2Ek6RgPO3
	 QK3teelEI8OjQCkABs26+pmK7WK0JlEFuqzYgaA8majnKgc1yDivewwr91jLB6uwYG
	 vFSBMCUjdFAgqJQaowbwDPLjHd3Fa5VhPMUbNvbxbobkjeU9Fl3te0ddMkX+IXm54j
	 /Ow5vr52c7vDg==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 28 Oct 2024 20:24:14 +0000
Subject: [PATCH 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-arm64-2024-dpisa-v1-5-a38d08b008a8@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7uuIvssgPmNN0rgvBR2HltfMJC/cwbms6ZSXTgQ7BIU=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhnT5z5mhH1wdu152/fp1M+Nmta6exZnPv89NDVWS8TbbX8uk
 w6XZyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwDcaD/2v+I3dtbv5FOdtKPxtczuko
 mWjM2LjJd7qiRpvo59mu6WXOkiEiF/YtZUx/hDe6V/ylkuOhd7ZPN0jgn2RoLusvUZ/V+YVZ7rteqI
 3ZjnNpfpdEbF8y/M/ifiz3O5MfNz2CuenOaif01OcfJ5eRkxzR7fB8ZnwpW0LFmDWyK/JAst9Tu0fn
 2lzGPbp2sttK4H+Wx5szDvwqF3istZNyReu/C7vu1MjFZKUaytRpO+pU0A//+bUUc0dOxf5W4TZUnz
 9p3qOc0h5vsl+c+BAZuP9e6tcnj01y1dS0rnZT6f8pq0MBG+p+t1So9vju2M+XFcfLGDs1Nlx7/bL4
 KWbWZgVmu17/mo0Bpgc0T8zFkA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces SME 2.2 as well as a few new optional features,
update sysreg to reflect the changes in ID_AA64SMFR0_EL1 enumerating them.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index d487c78520b97c8f96c70181e39eccb91d6fe1af..808bbd6d3a40a4cd652ac25d686f11ccafc5acf3 100644
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
2.39.2


