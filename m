Return-Path: <linux-kselftest+bounces-19956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 014149A2421
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 15:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAC571F26573
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 13:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92381DDC38;
	Thu, 17 Oct 2024 13:40:16 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5E1D88AD
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 13:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729172416; cv=none; b=VE1X253A0d3aRogDzwg+sIp0x1+nZp3xIJSD+KlL6IHXvkRT27UkRN4YXQi+esuSPJcDkDF0EMftDMD+VmGgMnNq3tKN10WtRNNseS9wFgM7Kng0fEIb2eapPuV/WSP9mVo1XSEKetVE0SxNV6S3YL+K5duj1AzNEeJCoIoCeyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729172416; c=relaxed/simple;
	bh=Fk8xMl7sYmzI2Szm8oVlLvkOm0a68gYeoZ420DD8Org=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qht044Ub0XFYP5boeAzjj9pjnLN5MlsFRy+G+fg0PpEYNF9vJ/z1lmiLccoMXAxFDXeF8hB+GHQW+KTTGzBZrmb5Jl9NA0PPmQtQ0KsiHdJQn6aB3GFTU1ZipVfBDWbwxGZS7lRRE6L58ll2eU/orfyusYPYN5if2C+lZOo+LeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C14BBFEC;
	Thu, 17 Oct 2024 06:40:43 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A40583F71E;
	Thu, 17 Oct 2024 06:40:11 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	dave.martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	shuah@kernel.org,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH 1/5] arm64: signal: Remove unused macro
Date: Thu, 17 Oct 2024 14:39:05 +0100
Message-ID: <20241017133909.3837547-2-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017133909.3837547-1-kevin.brodsky@arm.com>
References: <20241017133909.3837547-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 33f082614c34 ("arm64: signal: Allow expansion of the signal
frame") introduced the BASE_SIGFRAME_SIZE macro but it has
apparently never been used.

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/arm64/kernel/signal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 561986947530..dc998326e24d 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -66,7 +66,6 @@ struct rt_sigframe_user_layout {
 	unsigned long end_offset;
 };
 
-#define BASE_SIGFRAME_SIZE round_up(sizeof(struct rt_sigframe), 16)
 #define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
 #define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
 
-- 
2.43.0


