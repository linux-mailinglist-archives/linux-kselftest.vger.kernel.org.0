Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE78A41C834
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbhI2PWo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:22:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345017AbhI2PWo (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:22:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8D2161407;
        Wed, 29 Sep 2021 15:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632928863;
        bh=7ylfGXXJ8kffqS5H5ss3UKZCeSeFg8BoMiJBHNfE90c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pX2FN6hlo0FXjR1P5xPeQp9tllh2qXpjMg4FfDBZqBS8eR2Nk3pwLNrfiAhsAnvsp
         YDSopJP27TTV5hSuyorx3dBjvA9XUhN5sWi6xbSnlz3t46InPy8+85mpatAh0Er6jG
         SaWRrn+qOvr9a4mfRap0SsBdGaL6m6FEbk6AHqS2MrgI/yBY360a3LQzP+odRJWIrv
         0xgO532FG+IERH/xPTSScdEaEKmbXXuPTrn9Z8EteUXLRdZX7wfo0fEj7p6y387Zxg
         9bqRLbAhgP77Pk6UFUYw7HUPNWDa4D171duV5/f90OMtQapHNbzzkgqWgwjXMdd6QL
         3vh6VEnKhYdag==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 1/4] selftests: arm64: Fix printf() format mismatch in vec-syscfg
Date:   Wed, 29 Sep 2021 16:19:22 +0100
Message-Id: <20210929151925.9601-2-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929151925.9601-1-broonie@kernel.org>
References: <20210929151925.9601-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=901; h=from:subject; bh=7ylfGXXJ8kffqS5H5ss3UKZCeSeFg8BoMiJBHNfE90c=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVIP5FfNKGnLFWLyli3f4LmQge9pq7YMt+YL9ck0m EvunI0qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVSD+QAKCRAk1otyXVSH0I+CB/ 9v9CznO+cozkDitqH9JHdUihoaSNdXCqNOKckXQ9/vXTKYBX7UORAs2KRWQNc5wEZ7JjwyNMbclWni LnF3LiejvuMBLRm71fcmxTmmNNyLix9EOj3TwcPtdFGQB4vpYU0iji/MaiyOvaX+9kAwqI+wFCXvli EDxGHnDCJm9qOIMkZoHBvRi02WZLKKDVPKHi+WQOXWB0Wuta7JNjzxG/MgHqmbKIcBlHxb04qLYNXC w0hFoH8X/+gcIYlwSkRnAXbnsPYLbLu0jJvtxabXiSIKlbzGQA/w7Na9j1B3vOVAfXOro2yM58myMB XI+m3/8vt0Lr2wPIPs3i/yaMeswoUz
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

