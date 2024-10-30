Return-Path: <linux-kselftest+bounces-21137-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7AF9B6815
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8334E1F22959
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC1F2144C8;
	Wed, 30 Oct 2024 15:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G0GEjD5T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401942144C3;
	Wed, 30 Oct 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302844; cv=none; b=nAcWyqrhXiWKnAJKeZGeYnczDTd5kELqGEjUHFvvstVIRay1gMOCxleOgh8dV8rDKTPbnPox8MRFW3vDn1m65iXx1HSut4Cq+Bv8nXTd93mY56ehshhCsfgsdPh5vqaIF3e1UAWr3h19flEuxtCzZrCovGY6/2ECMYFNBlVHBzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302844; c=relaxed/simple;
	bh=7uuIvssgPmNN0rgvBR2HltfMJC/cwbms6ZSXTgQ7BIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OunpEn5ao9f+jso3LYQZzSVMxTJfM7DjkcX2wDRxRhurcHlHsuU6Amlk7FQde8aR4ylqaUDc3ZimXrH1UT3QHv+Ybv+OVkuG/3uO4+77N/O3TwSBxd3vwKuPCa2rQd2+SjVQbCyS7R4uJDMcnqNl1caUJWSP5LjrgHOp9NKAB24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G0GEjD5T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30A47C4CECF;
	Wed, 30 Oct 2024 15:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302843;
	bh=7uuIvssgPmNN0rgvBR2HltfMJC/cwbms6ZSXTgQ7BIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G0GEjD5TISJvy742IzGbutfQ4u50fqrtE6HT/1KDZoAqdIwCacF4B+ELV3Phzw075
	 u3xr6eUQMVY1HXbbaMC+KLf1rY/5Xyc4ScbBfRlQXnhu+i3LqUHmgF+UjY5N1BQPYA
	 /uMTmjkpApWqugyNtwMWgsos/pYhliZ7gyQtzCoi0LIGBlqZCbkN0A0bSxXJCF33ne
	 nnYr5Osh52eXcFHZjfHpT9IggF3OYa4eLhYoRwTYS0ISjOPffwiiU7S8VzjXKb9iNh
	 b9JmIr0J3QRrabmxh/Dd8RlaThUcr/+xQzM+iHJ5C5eVCVvF+DinjZ03bEWSwYooU6
	 fG4uqgNRKdJWQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:50 +0000
Subject: [PATCH v2 5/9] arm64/sysreg: Update ID_AA64SMFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-5-b6601a15d2a5@kernel.org>
References: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
In-Reply-To: <20241030-arm64-2024-dpisa-v2-0-b6601a15d2a5@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNlmqFXYjzlAlCleWYLZpTb+8rwcSXpB6aLPkxg
 2uJuMA6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTZQAKCRAk1otyXVSH0OLeB/
 9tGOp6h37kYClv9jN/aC/4qihyegiYjXXkNcXYiywjXz5HddE36KCbkBr/u9bE0kAQnVEIifc+VgFI
 D+21doIjudj2FKa2h7k8r6AA1hH6wIHCQeZUbNXFeKXuaoXetVWFfb1NW5U64LAQ2bTY0blaltd6Ns
 yvNTNUSGvIy7hswblRPIHrH0R8qxHH0yCermzxKP6x4RqtwyPFI6Yg/7q4bNnuW6y1mgqpHrKJH1zt
 BirZGBvnkL1lwWL9NAwQnNI8r9tx1oosh8eUGJM0zLq9hR40HSmcW+uWRIXLEm0K/ac1mBLNu/EvkW
 QShh2xor+bI2vOKYZn1o/4TGgo0j+h
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


