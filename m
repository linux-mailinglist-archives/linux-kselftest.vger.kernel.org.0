Return-Path: <linux-kselftest+bounces-21138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8A49B6818
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:41:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC1171C20F99
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C318215012;
	Wed, 30 Oct 2024 15:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaDj3mZl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1A213EFC;
	Wed, 30 Oct 2024 15:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302847; cv=none; b=i8Jemn5oBo6SszECLQNbLo/ZKmnrF0J32wtq7Dj1JqUDXcKLBNsEws5+RkxkeW5SgK4OmeHbmbT9W6KDPff1WUGoxT6Dfpe28JSTfHFboD2qJXOns+rSgpHnaIjMNtiJ/aA94xo0hEX2//BwMQAB+x06aV6OqoAxWvfiManlKAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302847; c=relaxed/simple;
	bh=mdF9l8XoMfCClmS8E8sWltwQ5YchWlsCeLs+M166hTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eg1zMNBgbvm9X91duyfvQ55pOYqt5rBS/6AEPnE7Gks30swj1FUs0QucLsRMp6r4mXAaZmykOSZEsjPQbCLVEGfIEEtsudNRbbwEfuFhxIDIGA8bIytkyCbWgR/2o3DVZd4RE4GuGKsLWm7regXIn2G23l5zf8BpRSDs12ZMEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaDj3mZl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB00C4CECE;
	Wed, 30 Oct 2024 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302846;
	bh=mdF9l8XoMfCClmS8E8sWltwQ5YchWlsCeLs+M166hTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aaDj3mZlLVYfcvDJO+E+R4/Be3S4iaQk63rmX8wiWw1/dFJCH93/3sD2/zgHYh7wh
	 dwuDFV/dpKKLmFTnX5b3Sfj2LdccqXbneGvHaks+1MsIfL2fjDaPhrh5emC06xIUXE
	 XQ/OvqjEarbcvs+1Jj3F1xPdKN8a/eylIVFnbaRoacQKMhOdMUOBaPMMhGz+L0p5m/
	 CfiP0k0/lLXlzEuZW2J3USJ1Dh12//4g1AOBl0cnzJz+MkAhCpQb0YAnZgw0TzsfoE
	 xKe0+9xIvJkXr4PFfsjy6T+bh5D8d/daRYXIzAzLjql2RJlLeU3vJohuliuJR2IHcA
	 ctgmkAVxvDDsA==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:51 +0000
Subject: [PATCH v2 6/9] arm64/sysreg: Update ID_AA64ISAR2_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-6-b6601a15d2a5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=827; i=broonie@kernel.org;
 h=from:subject:message-id; bh=mdF9l8XoMfCClmS8E8sWltwQ5YchWlsCeLs+M166hTU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNm0j6x8UgWp6faY1nzLF9krmdT6RQwTnafTD8Q
 JURn3niJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTZgAKCRAk1otyXVSH0KcDB/
 9IC0APArk3dIya0nkA8PjNNFCzVemr2UjVkMWj+lK/cIgBOKN7/fcjUsgUp0ry7UVsQeQt632YJDjD
 gnswsPZnQeS3NLkM1qn5mU9W1CI52P+2GRTA55t3XqI1Ii1J7KV2XmzcNX/bJh1txtURXT88Fl/fe6
 OnfiT7Ua/kGiRyaidu4LFpjX7U6ggiJ4WXjj+a+RgUJLX+gsYGoRIWOW/F80q7h9jF5fvOc358k/78
 +YoaurRAdCQ/OakmR8bolL5jHxiHwcvZoG1JjtHcX12+yvBzkQQR8+kWkF1jRsvHIbU4HV5kozk2Ti
 57Bok0kArHiPu8Vfd3OLwDwIRQK2MN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

DDI0601 2024-09 introduces new features which are enumerated via
ID_AA64ISAR2_EL1, update the sysreg file to reflect these updates.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 808bbd6d3a40a4cd652ac25d686f11ccafc5acf3..c8cc092fc0f63f91c7e87d679266a1f8a38176b0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1521,12 +1521,16 @@ EndEnum
 UnsignedEnum	55:52	CSSC
 	0b0000	NI
 	0b0001	IMP
+	0b0010	CMPBR
 EndEnum
 UnsignedEnum	51:48	RPRFM
 	0b0000	NI
 	0b0001	IMP
 EndEnum
-Res0	47:44
+UnsignedEnum	47:44	PCDPHINT
+	0b0000	NI
+	0b0001	IMP
+EndEnum
 UnsignedEnum	43:40	PRFMSLC
 	0b0000	NI
 	0b0001	IMP

-- 
2.39.2


