Return-Path: <linux-kselftest+bounces-39518-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2ECB2FE1D
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 17:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C150BA043FC
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 15:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95EC2DFA5B;
	Thu, 21 Aug 2025 15:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="rMl2rQX8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE91DEFE0;
	Thu, 21 Aug 2025 15:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755789196; cv=none; b=u1ITZggVkeriuz/i71BKRtezAXfZ30oHYqjY5WrILUvr0qA+rjX0owZjPGJmIpFUYcXtAP/97cxi9MyI0rPIzbjGZbCa6U8JkfQZ4+YlJQ1kLQrGgxnl8xmOgeFQj4INaZJe1pYT28WC+B4xRbrXO2vA7/ppy5q3IVRkyc3+tFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755789196; c=relaxed/simple;
	bh=qodkbxh+3qRl8JdkLf1RKw+tBZAn05xOsGyllQXNnGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bUnLJjjb0fPrhsGPfxQCd5ms1dxyIbxpKLwe7GLVTNYJ5GqidskmHgp4rmn15jMC9N+mdJ7WqqVGxnwbA4bv7OCTn2uYTUv5V/5eigyU+14SkqdcB3Uf27jlVYtGNtrUL4gG/VjRYejySSO2pdcWQn7OF53k1I3oxb+yjx4rbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=rMl2rQX8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1755789186;
	bh=qodkbxh+3qRl8JdkLf1RKw+tBZAn05xOsGyllQXNnGg=;
	h=From:Subject:Date:To:Cc:From;
	b=rMl2rQX8INuqKsgnuQBfCdmNBfgPoXTiAPULHv5yMpPUDWGF5M/p/4kePW701WDNb
	 akDC5b7bfvENcanirtjI/lZXR3RSsHlsAOf5rkezr5aG/KHgfuDqirXH2ZMVoCOuHw
	 KnSOpY52cEtlb6tLq35IBPRe97670ldMLXXpCgSQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/2] kselftest/arm64/gcs: Cleanups for basic-gcs.c
Date: Thu, 21 Aug 2025 17:13:01 +0200
Message-Id: <20250821-nolibc-gcs-fixes-v1-0-88519836c915@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAH03p2gC/x3LQQqAIBBA0avIrBtQSZKuEi3SphoIDQciCO+et
 Hx8/gtChUlgVC8Uulk4pwbTKYjHknZCXpvBauu0twZTPjlE3KPgxg8JGhO3wXkXwtBD265Cf2j
 XNNf6AbBcKthiAAAA
X-Change-ID: 20250821-nolibc-gcs-fixes-11cf7585bb74
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755789186; l=531;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=qodkbxh+3qRl8JdkLf1RKw+tBZAn05xOsGyllQXNnGg=;
 b=JE6FOoDOazDnOVA+XQS69RfeWKq/hWoXA6Jd8c9cGQo5lFQSmvSmfnwzVENC5di3S9qg8Tlt4
 X8UnVcDnx/5Dhjc0y8ukmX67x/BfIsqNhqI+OMtXnbFIqJfQm1OniiM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Two small cleanups.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (2):
      kselftest/arm64/gcs: Correctly check return value when disabling GCS
      kselftest/arm64/gcs: Use nolibc's getauxval()

 tools/testing/selftests/arm64/gcs/basic-gcs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20250821-nolibc-gcs-fixes-11cf7585bb74

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


