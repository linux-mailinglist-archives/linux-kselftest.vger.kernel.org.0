Return-Path: <linux-kselftest+bounces-41896-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D05B86BD7
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 21:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED46F3BBD0D
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE232E7BB5;
	Thu, 18 Sep 2025 19:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUqtbVT+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB722E7BAA;
	Thu, 18 Sep 2025 19:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224674; cv=none; b=cLd4aZI86xvSep6U9bXfFWb/DSWnj5R/NX9A36MdiyFsV3ArL7LUOUA1FCfeJfbZBzEIqMFNjb9dxncvYWMRYWW8nAOtiXetT2kmV2kUsIFuuPyDE2WI9scBxu9qcBAMVvnH01NkekkgBt7XHaz0/UtryoHG42DG/by2SMnQQdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224674; c=relaxed/simple;
	bh=UMBZVNHnp7TR0KnOMakwtyW6HfF9SvkIdo+R8of+svU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HHg26Z5pLfKEId/qN7Z07XzCZuhQY7Occ8BGeizlVvi2wTJmiqdwQBB8m0GV2ZeuNNWK7ebCO5vGyWsbiocv7ZX/9JcQ1fz4Oerbp63T8OEfZ0HLrV9xpydcd8c5PpsWQKXgprLB05iYI3rEYY79mgv388vmvjP6bXqdmk5hOnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUqtbVT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCDFC4CEFA;
	Thu, 18 Sep 2025 19:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758224673;
	bh=UMBZVNHnp7TR0KnOMakwtyW6HfF9SvkIdo+R8of+svU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bUqtbVT+0haYvdTHb6blpWAGsyWfD6JaY7UKgBi4jOSopmDbJZHeCxFoFu+/fht0G
	 N6gsaEeuXYxUNx19h3M20zlrQSQvN/OOpS7UNh+0vG8Atrw4GeFRl23UBOHHnD0OPN
	 sQwQu96Xbick4kY2JWoZuAwyghOmjSAmasf/n/qttCnRE/bjEqTF8y+Bz4ODB2N9C8
	 cf2einhRiGSWw5T0zRs9DOHxZkYqbWMyGqGFegKcqdGEBgQyjSYzcJcDgfXQnVdRt/
	 HoYZmNvUfikhEe256UpFX4Y98kGQpyREMS0OqFmDyQuV64M0UU9+aiDL3PQGBwyc0o
	 cezmwQxnZIilg==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 18 Sep 2025 20:42:07 +0100
Subject: [PATCH v4 2/2] kselftest/arm64: Add lsfe to the hwcaps test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-arm64-lsfe-v4-2-0abc712101c7@kernel.org>
References: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
In-Reply-To: <20250918-arm64-lsfe-v4-0-0abc712101c7@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
 Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-56183
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UMBZVNHnp7TR0KnOMakwtyW6HfF9SvkIdo+R8of+svU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBozGEYpaN8KxqpqbIpix7Q/eUM4BVEie2c349je
 H2Lt7wGNx2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaMxhGAAKCRAk1otyXVSH
 0Ok9B/4v32pVhq4xEn2WtqPBqKENxP6kucAsLZtwxf5iwOSrCiG9KVi/6YaIAC1kx/sjTIVaD9L
 mKEAYyfwg5c8BxtzTnuaHiK0R5mccV5TOEWPCLDMGeYsCfAVxI+uVBIUJ2Mbg7tyxUylzzmbwg6
 8Vn7mCxnstbDXzMVPy5OS73MNdRuJjzIsVe1dmV9cd1Fa/1eOBriDvdJYymtpApHcWiI5N0u5fJ
 m+NBZORlDiLa9d86fk+c7KVVLr5ahog42FmW/pYrdJHXOkWKbtFlyrW0SuXfcxYsmX53b4Fa4iU
 JF8LnIEBKNjJysOhlR0xW4jvKcBXNGNJdual7Un8QJbbKubP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

This feature has no traps associated with it so the SIGILL is not reliable.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/hwcap.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/arm64/abi/hwcap.c b/tools/testing/selftests/arm64/abi/hwcap.c
index 002ec38a8bbb..0f9a64932481 100644
--- a/tools/testing/selftests/arm64/abi/hwcap.c
+++ b/tools/testing/selftests/arm64/abi/hwcap.c
@@ -17,6 +17,8 @@
 #include <asm/sigcontext.h>
 #include <asm/unistd.h>
 
+#include <linux/auxvec.h>
+
 #include "../../kselftest.h"
 
 #define TESTS_PER_HWCAP 3
@@ -169,6 +171,18 @@ static void lse128_sigill(void)
 		     : "cc", "memory");
 }
 
+static void lsfe_sigill(void)
+{
+	float __attribute__ ((aligned (16))) mem;
+	register float *memp asm ("x0") = &mem;
+
+	/* STFADD H0, [X0] */
+	asm volatile(".inst 0x7c20801f"
+		     : "+r" (memp)
+		     :
+		     : "memory");
+}
+
 static void lut_sigill(void)
 {
 	/* LUTI2 V0.16B, { V0.16B }, V[0] */
@@ -762,6 +776,13 @@ static const struct hwcap_data {
 		.cpuinfo = "lse128",
 		.sigill_fn = lse128_sigill,
 	},
+	{
+		.name = "LSFE",
+		.at_hwcap = AT_HWCAP3,
+		.hwcap_bit = HWCAP3_LSFE,
+		.cpuinfo = "lsfe",
+		.sigill_fn = lsfe_sigill,
+	},
 	{
 		.name = "LUT",
 		.at_hwcap = AT_HWCAP2,

-- 
2.47.2


