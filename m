Return-Path: <linux-kselftest+bounces-14863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 223A6949343
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 16:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3945B2580B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404EC1EA0BB;
	Tue,  6 Aug 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UN3u66td"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8901E7A5B;
	Tue,  6 Aug 2024 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955079; cv=none; b=QiXhPNeXCYgsJXxISFLbju8n8c3bI2KrsOawHhafj2yUT5lcRdVLc+xGc4FSl51YdP8oLS1QMozMuheKHx0U0dT0huuwdunC37nU78bHkL3XK/BsZf3Tx8ptFW3cA0bhRyEuuvhC4QYymb1CLpgXTuvpD/YoQy5fWtF9bBxZUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955079; c=relaxed/simple;
	bh=ZJGUtbKdmJO4/kaSi2X+uwqBREkxPub2iqn4Ks8jUWY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VU8BuoIpuICoNJPrg424XJ3tw8BHOmS+/Wkjsrwo6SelXhci1byTkYfz7d1vLw55AjSyotsMfo2VNDEmxAUzv47sHgzUIVv51kmD2akNq1MDbD5DYSMWo/ndjg0wIlZsFdyWpTzc0UMyIfzvAUWkH9mVcEqWYyHWTpLxLNuiIS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UN3u66td; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43055C4AF0C;
	Tue,  6 Aug 2024 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722955078;
	bh=ZJGUtbKdmJO4/kaSi2X+uwqBREkxPub2iqn4Ks8jUWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UN3u66td2a3xT4FHO9kEEZAfysQFQZgBgWAwhY0p90E933WyUpHlM1Xxqxv+448Y0
	 X5mp1wFJYT7LgAqACS4yeLLtUxTMYLo2WscWxdHDvWuM6BE40CWwa4fdWmMfKoLWcl
	 9tXnEtsHWDFWqeL9G6cC+4yX6Ty+e1pLY5KERBBO7/EU2hF6oNi177reEyPYcVJmVj
	 Fux4a/u5axaUbtoKQ0QD8LItFOVWBbYuOTW/+qABsdg5rUSDmRBjl+7OLGPS2cuOXu
	 hrH1Y5sCFic0UOeSBjuNRIcvPA+c6BgCfYToc9Buv7sTvP6xcgosIAbTBteAULK243
	 P77Wv/jKAEvMg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 06 Aug 2024 15:24:23 +0100
Subject: [PATCH v2 2/3] KVM: selftests: arm64: Use symbolic definitions for
 incorrect encodings
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-kvm-arm64-get-reg-list-v2-2-1d3fbc7b6844@kernel.org>
References: <20240806-kvm-arm64-get-reg-list-v2-0-1d3fbc7b6844@kernel.org>
In-Reply-To: <20240806-kvm-arm64-get-reg-list-v2-0-1d3fbc7b6844@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
 kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1728; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZJGUtbKdmJO4/kaSi2X+uwqBREkxPub2iqn4Ks8jUWY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmsjU8dXUg7lGFksSHERCDxBnP8Pe9J8hRxOLsDsUB
 0f0GL6OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZrI1PAAKCRAk1otyXVSH0AYYB/
 49VjmSrFbyL0Vd79stbnQwFBeLryXd4VLBMN4mYhYBBuZFLCMGq5lA8ZvaQ0tYlcdrbNuc3zV2f1R5
 oyefG/NdVWrbhNpBTiQKR5q+cpth5nflyd55Ylw2qdE9XXfXunkKOxS1dhGOtGZwUGV+/DSBsblswB
 LqgEv6xyuEFJG9XZkLk6G06knNkMhuqLmaFvdBuiLTy8RMMqTSddeiz3/uyP6l5bsoXaDWC8qRh+32
 8JIEGIeZ0aXHiax8JQCSaFTzw3BbedsiGuqTA77SGe31reeSMBO/2rChz+Kmd/4DhehhQPm+iv8yuO
 tnVb+/XXVhzosYnxf6ZHky3CsdhzLX
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Unfortunately incorrect encodings for CNTV_CTL_EL0 and CNTV_CVAL_EL0 made
their way into the KVM ABI, the encodings were swapped. The UAPI provides
custom KVM sysreg definitions with the incorrect encodings so let's update
get-reg-list to use them. Also add a comment explaining the situation to
help anyone looking at the test.

This will avoid these registers being picked up by further work to
automatically convert the test to use symbolic definitions rather than
manually repeating the encodings in the test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/kvm/aarch64/get-reg-list.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/aarch64/get-reg-list.c b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
index 97ac3f6b5c4b..a270287a4c88 100644
--- a/tools/testing/selftests/kvm/aarch64/get-reg-list.c
+++ b/tools/testing/selftests/kvm/aarch64/get-reg-list.c
@@ -313,8 +313,15 @@ static __u64 base_regs[] = {
 	KVM_REG_ARM_FW_FEAT_BMAP_REG(0),	/* KVM_REG_ARM_STD_BMAP */
 	KVM_REG_ARM_FW_FEAT_BMAP_REG(1),	/* KVM_REG_ARM_STD_HYP_BMAP */
 	KVM_REG_ARM_FW_FEAT_BMAP_REG(2),	/* KVM_REG_ARM_VENDOR_HYP_BMAP */
-	ARM64_SYS_REG(3, 3, 14, 3, 1),	/* CNTV_CTL_EL0 */
-	ARM64_SYS_REG(3, 3, 14, 3, 2),	/* CNTV_CVAL_EL0 */
+
+	/*
+	 * Incorrect encodings for CNTV_CTL_EL0 and CNTV_CVAL_EL0 made
+	 * it into the KVM ABI so we have custom encodings for them
+	 * that do not align with the architecture.
+	 */
+	KVM_REG_ARM_TIMER_CTL,
+	KVM_REG_ARM_TIMER_CVAL,
+
 	ARM64_SYS_REG(3, 3, 14, 0, 2),
 	ARM64_SYS_REG(3, 0, 0, 0, 0),	/* MIDR_EL1 */
 	ARM64_SYS_REG(3, 0, 0, 0, 6),	/* REVIDR_EL1 */

-- 
2.39.2


