Return-Path: <linux-kselftest+bounces-21135-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF19B680E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 16:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ACD1C21B57
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 15:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1435D2141D7;
	Wed, 30 Oct 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNDcyWyp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5FA2141CA;
	Wed, 30 Oct 2024 15:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730302838; cv=none; b=ZpAzGYn3X9axTUaLVTlzvAuqwa5nRs6oPmK2/RkLnVk4BnvVKZRM9uY1KVaA4xz9jXQfAqY8ufxKU9rZ97ATuT4naXMVO8b8Fngg6bKpO+bIhpvmXgcoRXOd5DabcVeqyxPl/o8CCJK/WPwkXKnzTURaHa4elv/4ctSt5CHSVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730302838; c=relaxed/simple;
	bh=txJPBAKW/px8wqxUeO43xJFh9Jn0eyt07T5bMMNoQs0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M06fYDvi+VQEQQu7CR65GzLGA4DYV2tx4PuC8pB5hIh78HmKrPa+T8mu7joZIaBj8vH4DlW5Hc2QZ2nljEEv7eHTfh1smqAkCo6lmnLM/0OB/8ipnoEe0vd91xaSsn3cwmWIbZ+oxYf3ZMZVnBA2xOUim2g2mQGNnchAAPuzqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNDcyWyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F130C4CED0;
	Wed, 30 Oct 2024 15:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730302837;
	bh=txJPBAKW/px8wqxUeO43xJFh9Jn0eyt07T5bMMNoQs0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oNDcyWypyH3JXmdBfzY2hjjJC9FUkktQ+8ZS7KzScTsTKQoVmqG1KSftOJjyJC8S8
	 wFfzQHtrQXCauwV3RY1DiCipPYR6d8b3f5L/moVqymUTvLxahjzCNIFcCpisjCEXOq
	 xc0ZE6O9gidDuKzO17cgf0HKkVethYDJUrYq9OvLma4yKYYT6PVL+AdE6jqyYUelwi
	 wVcUXZtPH/wD6kXFVyjjDa6haqkLoA8T+Lg1HOCFV+nxbRnkPePWgFRbotZ/SU1VTA
	 SGIf/18ZWz1kckoY/rJtMgyvn4mu4QhP93e8uEREfjgy3P0OQV6RUFczLMViade+Nq
	 3SyvbtkJshmrQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 30 Oct 2024 15:34:48 +0000
Subject: [PATCH v2 3/9] arm64/sysreg: Update ID_AA64FPFR0_EL1 to DDI0601
 2024-09
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-arm64-2024-dpisa-v2-3-b6601a15d2a5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=766; i=broonie@kernel.org;
 h=from:subject:message-id; bh=txJPBAKW/px8wqxUeO43xJFh9Jn0eyt07T5bMMNoQs0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnIlNjLXhKJVoKwgkAhdsWtohTPWBWcUPKrbk5HU+X
 21nUD6SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZyJTYwAKCRAk1otyXVSH0GKvB/
 9RsjAbX++HHrZn5lx6ACubG9OuypNkVBXCg7syA34+aKKqTtQPynS7o/hFeyCqvLTHQh9zhMEjPTAz
 DMArnNB2uZ7tXTWfzGi8IZ9dCkdC+0lZhYjVW6dM1F+sHYXzwEqDzbnVe0/gfXfiykF5ESQ2uV1auu
 /aneOPRTvU0wuDeMXZ8j2AAhTDle+G09f03RQZAVmaOmcLpE61dq3RI6+HtlSEfFavesflwbgv+Cs2
 51YQlhGvHpUSOzNAexHIrhjXmk8uz/fKIxE0E23Lu859GFVSPptFo7n6xJQk2D7yX8aDR7UrXkJHYr
 hhOQPGk4huEt3sepT23aGtIJSyVI8c
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


