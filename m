Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E7141C835
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbhI2PWr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344945AbhI2PWr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:22:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8354F60E90;
        Wed, 29 Sep 2021 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632928866;
        bh=yJ4ueh+BO+Eim5GlQAHvD/jC8/yyMw/A2pszTTlipf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WeosoLhjSZ2ADw8VKBMi1lZE0t2uDGiTjJUw0ycueB3gr1dBqo99pL1I9WHG6HKV7
         qXi1FN/IAwGkVX0dzVMJK4nMPf0vZUbHDkLYk1jqw+Yn7fJMd1OqD14zzB5Q/X+fO5
         UDEtNxcU8fO0KcNERM4AKqMdJkm/l/acQ1UmRcXRw3h6Oz36iclxctw6USk5l5rNng
         MIbBr7v1U04/aFj4lXNrApHbdZZnBgYlO6X9nqlln4s4msU3Yyjk+4mO00CVlzVt52
         LI5RMXXMgRovqp/0q1GU7FX+zmcAzyYMoBUa2ixzRySnJoofG0pzUryhPQ2ofqrQhR
         z06k+GlVhuK5w==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/4] selftests: arm64: Remove bogus error check on writing to files
Date:   Wed, 29 Sep 2021 16:19:23 +0100
Message-Id: <20210929151925.9601-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929151925.9601-1-broonie@kernel.org>
References: <20210929151925.9601-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; h=from:subject; bh=yJ4ueh+BO+Eim5GlQAHvD/jC8/yyMw/A2pszTTlipf8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVIP6GHlxtnIY4Eu/5/J5cdKSDM5mRmL00dmRJpB8 pcoNJEyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVSD+gAKCRAk1otyXVSH0E18B/ 9Hs4jDmaOPQGNF84tDPugrITikWZnf2rOqvbePNTeuXKU+pjBgEI7bKkAak6UbYEioytcV++EUxOSx RjT2IXqKrIvCq1WrkBV2/3V8fF94Uu6lIS5jIAnzTEbTMWcNLIoDRaPpTf3EtmTgvltykTH9UhhDWm amvOLpAxUhsIx2aoICp/a3mtNPm6clUfSK/f/tNtZwk5hm3vQeSgJGi2P63LjyOIRiezNnNS5fv6sp hOusJLjutWPtE30sep9teggPkJS5vZN1Ma0ni2uQe7y9Qx4w9fOYhDyAWIUr1IuMcp+HguYeiSX95v pHIW1nZUtJneeKWQ+T0FXECKQbXC2+
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Due to some refactoring with the error handling we ended up mangling things
so we never actually set ret and therefore shouldn't be checking it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index b2de002ee325..d48d3ee1bc36 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -180,7 +180,6 @@ static int file_read_integer(const char *name, int *val)
 static int file_write_integer(const char *name, int val)
 {
 	FILE *f;
-	int ret;
 
 	f = fopen(name, "w");
 	if (!f) {
@@ -192,11 +191,6 @@ static int file_write_integer(const char *name, int val)
 
 	fprintf(f, "%d", val);
 	fclose(f);
-	if (ret < 0) {
-		ksft_test_result_fail("Error writing %d to %s\n",
-				      val, name);
-		return -1;
-	}
 
 	return 0;
 }
-- 
2.20.1

