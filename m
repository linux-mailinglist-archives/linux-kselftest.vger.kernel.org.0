Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14CFF498758
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:56:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244557AbiAXR43 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:56:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:47618 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235526AbiAXR40 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:56:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAF8A6134F
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 17:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7439AC340EC;
        Mon, 24 Jan 2022 17:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643046985;
        bh=pQntHB6oEhL5YPB0I6MtdXcFJL95M2mYHCwTlgAkBsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liVefTSBIGk4mLL4G16I36m+SJV4/rxgVgklIeA6t7p7qa4Sn9QUsZGnukHeoeHHG
         vjQaNLpRhwGWqjRyQQJT+BVZG+PkaDxu5l8AC2QcIwz5cFWiTrHjvsNQb0kZmZGSHZ
         vpe8R1m/a5Igjc7ZX9bIitW9ltbNlSRqLmgHg/dj1+7AOtNL3qgr7Eh6saRUGvsRpY
         NPWFy8ipQj0E5R2wVAQ1aKptQQ3gASOaSHtHyP5cO+mI/fwLLLUsodYDCszO55uAxt
         UCRszVYkJQNJs1DcxxrtDYOFFXNQ6JsukED81/Rj82dQVMmax1t4KyuXfydQ+s5ayL
         2MZLRh5rJam5w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 1/2] kselftest/arm64: Skip VL_INHERIT tests for unsupported vector types
Date:   Mon, 24 Jan 2022 17:55:26 +0000
Message-Id: <20220124175527.3260234-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124175527.3260234-1-broonie@kernel.org>
References: <20220124175527.3260234-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1383; h=from:subject; bh=pQntHB6oEhL5YPB0I6MtdXcFJL95M2mYHCwTlgAkBsM=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh7ugNWenywsGYZOEebcFxeTxwO6ygoCOXkNo8iaRF PpW+4LKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe7oDQAKCRAk1otyXVSH0PzgB/ 9mbw2VQ8tbh4B6YR+VLg15/gWqNx4t0Sheq4sSBx8TsBYO/TGkwuI0xzE/7dHGxuJw1xivpSXm+MGn jgd3v1MobnfDHPmdv8521ZLdXyuSI0SfJvwjSFqyw53Zt2fYpk8vtnUA0Fge7whamQSsyH9EuqF5u9 uW6FDcztJ9qzmFPWvtRfVD/suk52+Q9D33wQv2hDLuekV3500dWfnWRmKW6olAoW6eOxRr9S5HfYWG u9lci+pDzf+FHZGYFUYOhL5zI55NWhTNf533jmSpls/PTcOlMfppCk/ICRiGBzoFT8c+X1h8MzOUDl xJaYDINB0WpDPY92Aw2gLDKWdemXFu
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we unconditionally test the ability to set the vector length
inheritance flag via ptrace meaning that we generate false failures on
systems that don't support SVE when we attempt to set the vector length
there. Check the hwcap and mark the tests as skipped when it's not present.

Fixes: 0ba1ce1e86052d ("selftests: arm64: Add coverage of ptrace flags for SVE VL inheritance")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index af798b9d232c..0cf78360c5bc 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -557,7 +557,14 @@ static int do_parent(pid_t child)
 		}
 
 		/* prctl() flags */
-		ptrace_set_get_inherit(child, &vec_types[i]);
+		if (getauxval(vec_types[i].hwcap_type) & vec_types[i].hwcap) {
+			ptrace_set_get_inherit(child, &vec_types[i]);
+		} else {
+			ksft_test_result_skip("%s SVE_PT_VL_INHERIT set\n",
+					      vec_types[i].name);
+			ksft_test_result_skip("%s SVE_PT_VL_INHERIT cleared\n",
+					      vec_types[i].name);
+		}
 
 		/* Step through every possible VQ */
 		for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
-- 
2.30.2

