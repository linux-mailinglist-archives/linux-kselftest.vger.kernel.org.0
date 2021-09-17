Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDB940F746
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhIQML0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhIQMLZ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:11:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7C64960187;
        Fri, 17 Sep 2021 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631880604;
        bh=7ylfGXXJ8kffqS5H5ss3UKZCeSeFg8BoMiJBHNfE90c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oe47OioeXswMQgT91lPgmAaQZ6sGSYqfSWeSIUz2y+9wsyu8Mr8aohumPu/Cf7a11
         PuOvCAq3ulPa94KXIqS/3YjRqfmzqJbDy7wTdvUMuGKqxO5nRObP2YWroOR9kC/3V4
         ZH+88nbBCuz3b0bG5FADJKeZaS8BexeUNngJWlTeVvXr5H/aw9AwfWcOTn+Xqvu3MC
         HRnm1Gyha3fVWg5fxpkl/UIPK36kIbnAgaqOzq1vURM9Jpq+dC3aJrHtIXun0glmdt
         VDXuY7UD51+YjRR27VU8fNf3ZFBuGh1a7w6qHlqs0R2wOzYLaWgZ3fPADm7Ufb1CIp
         pwKzCbO9r5Rwg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/4] selftests: arm64: Fix printf() format mismatch in vec-syscfg
Date:   Fri, 17 Sep 2021 13:08:52 +0100
Message-Id: <20210917120855.13858-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917120855.13858-1-broonie@kernel.org>
References: <20210917120855.13858-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; h=from:subject; bh=7ylfGXXJ8kffqS5H5ss3UKZCeSeFg8BoMiJBHNfE90c=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhRIVSFfNKGnLFWLyli3f4LmQge9pq7YMt+YL9ck0m EvunI0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUSFUgAKCRAk1otyXVSH0FWUB/ 92GYL7NxN+w9+JXU5U8s7CvvXrZYC9XFIK/ljJBt0MG7SiRwBSSZ9eHsHdw9mO+/gYvP5VKVbCP97O 0JLoR7m3Xubp9rLz0i6u5ygb+nPxW6DkUYqV9Y605qoJoAtUlnZNO1BoaPtdXWzfYER7HEqqQVmEVY 8MR970WrdlwDJTOghzv/jMEqpPjg3DSXXUmkgAjgah118enrKeJIM3fpch4u96a2fgfEkUqTalN5x0 trMlahPBm+yox2tLx7TiDPjoy+p/4efDSdid/Z7snyM5CIt4REde/lbLp6Ku9n5mAFpdsRmjFw3cFt cScK5QveYHIeV9AHe29bRQP+4F0EIJ
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The format for this error message calls for the plain text version of the
error but we weren't supply it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index c02071dcb563..b2de002ee325 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -109,7 +109,7 @@ static int get_child_rdvl(struct vec_data *data)
 
 		/* exec() a new binary which puts the VL on stdout */
 		ret = execl(data->rdvl_binary, data->rdvl_binary, NULL);
-		fprintf(stderr, "execl(%s) failed: %d\n",
+		fprintf(stderr, "execl(%s) failed: %d (%s)\n",
 			data->rdvl_binary, errno, strerror(errno));
 
 		exit(EXIT_FAILURE);
-- 
2.20.1

