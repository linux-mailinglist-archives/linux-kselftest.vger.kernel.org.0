Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D80F40F747
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhIQML2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:11:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhIQML2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:11:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E82561029;
        Fri, 17 Sep 2021 12:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631880606;
        bh=yJ4ueh+BO+Eim5GlQAHvD/jC8/yyMw/A2pszTTlipf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fIt81/ZvyJWP6ElADvEl64I067AReSwhQeg0YZlHP+ugWr03sSLTbNwjqmhNTWGDh
         YJjsfZHED5nMmaBkvDNVHFVJUXdRlItJp5PzSShxAevHoSfieAAGSCv3HLL6YrPlBE
         /Av8Fmt3kvAh/L5HVQtbzC3G6dL34uATS3HcvJvd+yLXKqHiPsdt1OuBpJE3PXm53v
         Od/BDMKtHTXQ4fv8Z6J+tEhrn7+GqQl6wedfxmd9eYmJqUE8wQSjXBL3yWiMeN0gJU
         F+61KSmM3IN5xGLmiK2GcAov3ROo8ywnt5pvakEkLqCrnzQZ2Zt62xIX1HDvd8cvOZ
         ndke3FJNseR2g==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/4] selftests: arm64: Remove bogus error check on writing to files
Date:   Fri, 17 Sep 2021 13:08:53 +0100
Message-Id: <20210917120855.13858-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917120855.13858-1-broonie@kernel.org>
References: <20210917120855.13858-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; h=from:subject; bh=yJ4ueh+BO+Eim5GlQAHvD/jC8/yyMw/A2pszTTlipf8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhRIVTGHlxtnIY4Eu/5/J5cdKSDM5mRmL00dmRJpB8 pcoNJEyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUSFUwAKCRAk1otyXVSH0AsnB/ 4uF8UuO/qc8eC2OvSne45kbXQK7H/UqOVOJdfbCbtJZ/Yg6SVz3EIkmHEbjFFFxPnDuDsKF361i/1q /ZZOUtDowrvahmjD40x96SQFrRrFSX+PLtMfJv1QfFzRfeNU0j3y0IsjL905+WdbiCMHg5qyGsJGPW JEzJ0ym76gMzopdWFf1CWa5P/qRcmxsxaksL/NSFz++NJhuCPHwdB7xUcwA0gcbiPrjYiw72ZPzjHI qds/4rUmG8hx8IzObBBrMt5e5HWbswz+gAZTQepCuJExjYyyZyfp4kwlhE3m/p4W1rbPm8/SQ5p/YN tHJBWupoGarDuXJOKp32YqJen54xX8
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

