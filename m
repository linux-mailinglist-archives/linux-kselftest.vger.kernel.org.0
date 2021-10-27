Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF7643D119
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243626AbhJ0Sxp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231897AbhJ0Sxo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:53:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 88E06610CA;
        Wed, 27 Oct 2021 18:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360679;
        bh=Xsn3FkGjlA3xQ8mCSRT/zKEYgsuq8aDGFT9y2Y/GifQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=baxq2/3XIOh4bNIlLhcUTVhEPti4+YuTJDj9ldl4Yy92EWwryfm5lXx95XyCGk7EM
         1r9t4QREWBx2cTxkongkv5NyjMTKjxGa+vxWdTX/7bp+jRbHwEzdlWTXglQTOvlVx8
         1/4GB4+OnmbhWJhuZztjqnxRB+383xwOZj0/KDFOONV2g5pXYupcEYp/CyVc4pZRID
         YfKIQaUdNpQ+WNNtpnnmroXcmzjj6XhAYIHa/usWCe4v+9XPkaOmFFqdx44SHlA015
         ePb7CM56Q/s6mH6O151fZdtyyepZlVe1IZ2J4OZT8wCSTU4eW11giJCeyleLA/rjQO
         RsWpwMxdvgpWw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [PATCH v5 09/38] arm64: cpufeature: Add has_feature_flag() match function
Date:   Wed, 27 Oct 2021 19:43:55 +0100
Message-Id: <20211027184424.166237-10-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; h=from:subject; bh=Xsn3FkGjlA3xQ8mCSRT/zKEYgsuq8aDGFT9y2Y/GifQ=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ3t7bCYwYvYMxRVjhGdYvloVJNrbyOgDrOBJPd8 JBu0hEmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmd7QAKCRAk1otyXVSH0NnyB/ 9cyNL1b57NXD1GyShIQhqMgJvFi47XzCwfyD1Qf7WkpEg2TeTPmIjKX7Bi4GNkQanrlM0FWQsv6DsB 9Fja8jploP+X8xiOmPevcs8zxR4NEIsgLS9RvLj6Vtn840Iys5Sfq3Fnxpb/pGBh4jpSk4TCmKWe8s m44OBJsjWfP5WKIM5fCREdDWD9ucleqdWg1PjjhvXxaI0rT8E+6ni9arO4WrtBUaJtBq8b09z8jlan h0sPP+IHeFWZ1KGOy7dXcQkocCn1DlBP1Eleu2hF7C3jSD9m8YxYSsGgxqbf3gwYF9A9qyaxaET9xY Pio0lNjp3K8RjjQMWPwDltx3WT4uLU
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default has_cpuid_feature() match function operates on the standard
4 bit fields used in the main ID registers which can't be used with some
of the ID registers used for SME extensions which have features
identified by single bits and need to be exposed both as hwcaps and for
kernel internal use.  Support matching such simple flag based matches by
providing an alternative match function which simply checks if the bit
at the specified field_pos is set and provide helper macros for defining
hwcaps using this match function rather than has_cpuid_feature().

Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 405a65d7e618..5fd56c6b294f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1311,6 +1311,20 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
 	return feature_matches(val, entry);
 }
 
+static bool
+has_feature_flag(const struct arm64_cpu_capabilities *entry, int scope)
+{
+	u64 val;
+
+	WARN_ON(scope == SCOPE_LOCAL_CPU && preemptible());
+	if (scope == SCOPE_SYSTEM)
+		val = read_sanitised_ftr_reg(entry->sys_reg);
+	else
+		val = __read_sysreg_by_encoding(entry->sys_reg);
+
+	return val & ((u64)1 << entry->field_pos);
+}
+
 const struct cpumask *system_32bit_el0_cpumask(void)
 {
 	if (!system_supports_32bit_el0())
@@ -2367,6 +2381,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
 		.matches = match,						\
 	}
 
+
+#define HWCAP_CPUID_FLAG_MATCH(reg, field)				\
+		.matches = has_feature_flag,					\
+		.sys_reg = reg,							\
+		.field_pos = field,
+
+#define HWCAP_CAP_FLAG(reg, field, cap_type, cap)			\
+	{									\
+		__HWCAP_CAP(#cap, cap_type, cap)				\
+		HWCAP_CPUID_FLAG_MATCH(reg, field)	\
+	}
+
 #ifdef CONFIG_ARM64_PTR_AUTH
 static const struct arm64_cpu_capabilities ptr_auth_hwcap_addr_matches[] = {
 	{
-- 
2.30.2

