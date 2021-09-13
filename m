Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D047408B3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 14:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbhIMMok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 08:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238241AbhIMMoj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 08:44:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BAD9660FBF;
        Mon, 13 Sep 2021 12:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631537004;
        bh=yJ4ueh+BO+Eim5GlQAHvD/jC8/yyMw/A2pszTTlipf8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uh7vPwgYDUjDa0Ka1KtcHPOvbYjYireDALG+UCMqB5zH1I+QzXU7kssiZ9Sv7aDJ0
         C+JVpDhRluKGMBK4A5APeW1ozq1gmAAUgwBOmL+4Au20gaKoOf9HFptPuXHLgJP7LH
         yfzI3ko9NOtNH9Bx8BzcGVg4gU7iHPS8DcwJNc3OD85FKCoQG/oIWb+TXgNOToIsfe
         LnxtQvRLS+QD5LPr0Mqdr1AKxiK3KDNYoPIp9bPAIn63bIqqndplIsrTX2E5KNj7L2
         mgDX/Ok1m7fCgDz1wF8gu1VQOEId/3pIwmBm6hjnDxFyBCZk/gsseQK//cJdW/98eG
         CBeTkiUYalMpg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] selftests: arm64: Remove bogus error check on writing to files
Date:   Mon, 13 Sep 2021 13:37:09 +0100
Message-Id: <20210913123711.51274-3-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913123711.51274-1-broonie@kernel.org>
References: <20210913123711.51274-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1028; h=from:subject; bh=yJ4ueh+BO+Eim5GlQAHvD/jC8/yyMw/A2pszTTlipf8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0X0GHlxtnIY4Eu/5/J5cdKSDM5mRmL00dmRJpB8 pcoNJEyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9F9AAKCRAk1otyXVSH0AbNB/ 97T/ElaD18tKfvi6H8tjzaKDZp3Lis7lsloiDMe2ZznGjX7kDm2EY6c9liJYAsynngFKLCoPotrMVS mjQxUnFfo3ktFrSol91MMls0M1jVPd1CTc/QWDYArFbOSFck9YzaTG3blB8Kl4nqsD4hdhY+RlUKB7 sSmoh1AvQgkueZzplBnuM/sGOFZHkqZT4mizvP4ySzrpjjhj6q+CvCPDwmYZhU3CTCeNMFKkJt9/bQ v+n1ratWmfPG0Y/1IfJmxnE9BhhR7qVsgDHMrj20z4HAzDVUhu7rSVzEv4nSC5I7ivqsxQ0S8oNVKg srTsxhFB9yLGuEwdluUPm10Hs//dol
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

