Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319B9450857
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 16:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbhKOPdf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 10:33:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:52262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236565AbhKOPcS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 10:32:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B88186322C;
        Mon, 15 Nov 2021 15:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636990157;
        bh=jdQaB6Dqx1nRe0ynGMOyo7GfTnszvz8DQNqs7Dj3Vz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iBVqnexTI99zgWq9HlYIZwgcxpO64VXfxMoX1AAcl3tUhhhAKTbAXo8AcQby319Jq
         iK/OwwIKaLL47Z70Oa74Xvd/RENrMps1kSeiB4HJJGE/rcBt40qCmPJ4IzpknwTw5q
         TmQsqYvFXaF6evmzjJV9n7fnxRIZu0DISw+J/xgmUDvMxBcF+x+viwtp4Oq7O1NCPn
         9yI7leZUN2K8U4NxPz3dfGY8/aqsfFEi59OuyU7tak9aIe1hFh38YfCOtZIiTrPWVx
         kmMHVP6r+Us7KPeSAHbfvE3dxT2BgIcfz9ATL10Np9E0UCYJwPr0LCV8NFjGj4VDOv
         XK6Wd+Cysv97g==
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
Subject: [PATCH v6 08/37] arm64: cpufeature: Add has_feature_flag() match function
Date:   Mon, 15 Nov 2021 15:28:06 +0000
Message-Id: <20211115152835.3212149-9-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211115152835.3212149-1-broonie@kernel.org>
References: <20211115152835.3212149-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; h=from:subject; bh=jdQaB6Dqx1nRe0ynGMOyo7GfTnszvz8DQNqs7Dj3Vz8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhknyLLpzkZSN7QGSkFnacWBnV0sXCNPTyJwNiZWWp ugOT3Y+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYZJ8iwAKCRAk1otyXVSH0C0XB/ 9HL8z98JwngSLGVkPmtdg1svwsIrNcEs34IKkPI+rVkqzzsPwNF66XYFHcGC6RCPOe6xKWPrgvmG7g SURSOY0gMG1k6v3BjTzJkicLup8XqBRD20WMif4oYcy1aERD3js/Hx3z9wMtcUz3R8Dtu23dMOjwzw gI77h+da7YKgOpNdSwShtnqo7NWzccK7sFz2JgPWc+OcQIGUJhEe4Egqdq1jLV00YOM+CamQf2Kc+5 okWEK8TyJ/Jv6f11GuzR9NHKa7LhwgbrOPKG1FlaqfOD1O6bj7MmMEeRzAuJ8YSGdb7adaiAqC/dwj p60EDC5+38aOc69jogZy5MNP7mr2Gn
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
index 6f3e677d88f1..81824c7ea74f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1315,6 +1315,20 @@ has_cpuid_feature(const struct arm64_cpu_capabilities *entry, int scope)
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
@@ -2391,6 +2405,18 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
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

