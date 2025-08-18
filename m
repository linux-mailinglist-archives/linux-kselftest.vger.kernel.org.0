Return-Path: <linux-kselftest+bounces-39250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D03B2B18D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 21:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1EFA7ABF6E
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 19:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 161D9275112;
	Mon, 18 Aug 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JIk8LPIr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5112750E6;
	Mon, 18 Aug 2025 19:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545190; cv=none; b=SswfZMqiXUJCK0QC49iyu/dkEih1V9A8gLm7k0xix6PdYQOoFd/Bw0hQuxDBc/ycbD0KUz/BKdKLGRP77Cx3rvGysbaE+QmlK3DMzhvEr7wcylLUsBacieqZf1XYYVLfRHd6Rd0xDRKAS7+p73iZyiDwKGs6e/GDNwyve71vuew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545190; c=relaxed/simple;
	bh=WuZkA+3W6xGa4E/TZchTSAE/H6G9gi5ov679T+TmFuI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p9kke8DlaA21KAWtgDLMXRzojUKYWHTojOTwINxB2FB3FGgJbNqtKIz/UXA/w5UNiV2u8AY9g6LMi/tCZRDuHQnLO20eGGG/D1b/5UQ2rogJRY2inB7ncBW0f3sbh44HRBHBkYUHLpNPB0m6X8tx5NfAX7VnBs6auvuPgdbbtSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JIk8LPIr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06817C4CEEB;
	Mon, 18 Aug 2025 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755545189;
	bh=WuZkA+3W6xGa4E/TZchTSAE/H6G9gi5ov679T+TmFuI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JIk8LPIraA5qigmZ8M9b7LWFDtpBW0YZ0T2PP4XpGzOB2bLjSqHg09KbvFh8FSIKU
	 P+HNzDesyZC6q0ny07/MDt5gfqjf3hJNPgAicagMlmkAOJ5kC07+I/YNlcjkN9l0ZE
	 9QRRX0pnkWJafhhXBPXNUoGjWV/J+DaMNvhsOGSNW+FA5gL/sUppVJHwIE+EMa1y29
	 XBfC8jcbVCxoAgRQdLN6ipfPdSw8PyckHBGRqsq2HnPlLrnR6Oet7ms4QoQAzSze0n
	 KiyBCYgkqJdvJu7tiu3il8F03zFlGehLLxrwAeW5vwRyTdguUZw9HQx4tooG9sfa5G
	 zVLYCvuMgK7Qw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 18 Aug 2025 20:21:19 +0100
Subject: [PATCH v3 2/3] KVM: arm64: Expose FEAT_LSFE to guests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250818-arm64-lsfe-v3-2-af6f4d66eb39@kernel.org>
References: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
In-Reply-To: <20250818-arm64-lsfe-v3-0-af6f4d66eb39@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WuZkA+3W6xGa4E/TZchTSAE/H6G9gi5ov679T+TmFuI=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhozFddGCUonZ74SrJEXuBqxgCyt/drfgy4XF66bbipXda
 C7xvneuk9GYhYGRi0FWTJFl7bOMVenhElvnP5r/CmYQKxPIFAYuTgGYyPEC9n+qm/+fajtxQW1N
 cxTTmXmNdq5bqkvkP+hWhtmfNq3qCNG87ZhoJiica33V7+HdVMtsyZzyeW5ZRi4xd17wpPnse2F
 +6ZKdyqKdf+UmhOqu+SssF3irfktb7rff/Z6LrKzO9uxmXf9hY9U5H3m/SZZXDxWFFz374sjxIc
 J74bfgHRqtpnMOlJvI7nGKY6p7Vrp7uyqbaNZK7T0FDvPX782qemZh4erz8uXJ/Ds7G7O563eG6
 gV08Il6xd/7LaS+a835uZ0OMSGl+3LEX3lsn14+YfqDdfsWttzg5QgO9rf5y1t9ovSg0p/9wY0T
 mQz/8SS5d9xlVWKfc7r8jk/oWTW3Ht+tT2ST4rxlk32aAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

FEAT_LSFE (Large System Float Extension), providing atomic floating point
memory operations, is optional from v9.5. This feature adds no new
architectural state, expose the relevant ID register field to guests so
they can discover it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/kvm/sys_regs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 82ffb3b3b3cf..08e2cb94bff3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1642,7 +1642,8 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
 		break;
 	case SYS_ID_AA64ISAR3_EL1:
-		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX;
+		val &= ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_LSFE |
+			ID_AA64ISAR3_EL1_FAMINMAX;
 		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
@@ -2991,6 +2992,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 					ID_AA64ISAR2_EL1_APA3 |
 					ID_AA64ISAR2_EL1_GPA3)),
 	ID_WRITABLE(ID_AA64ISAR3_EL1, (ID_AA64ISAR3_EL1_FPRCVT |
+				       ID_AA64ISAR3_EL1_LSFE |
 				       ID_AA64ISAR3_EL1_FAMINMAX)),
 	ID_UNALLOCATED(6,4),
 	ID_UNALLOCATED(6,5),

-- 
2.39.5


