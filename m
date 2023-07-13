Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CCE752B70
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 22:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGMULt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 16:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbjGMULr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 16:11:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5065730D1;
        Thu, 13 Jul 2023 13:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9DC9561B5C;
        Thu, 13 Jul 2023 20:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7448DC433C7;
        Thu, 13 Jul 2023 20:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689279064;
        bh=rXmOaMmqlk7QrELiC/kSDYYNiucDsBT8D5q7ohFdQ7s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Dh3Hji+GokfBj3Nw3od6f/WvxyQj4FgLI9SYKpUbWImvCfhuEpnx9l9bEXQ0oNCQ2
         +fW2QhhsEb86pKNxOLTNFV1bbkVD18YpvgGlBCYgzVPyWtwax7OmkBVMLwd1wWyH4K
         +EA48T3/KHxguLpRWhzipdPLj0PW5qU7njdpOMbBHjkSHi14dR6ibThQiNWRxsCFxw
         bNaCielNdvqJNpicq+8DFVZotQ3UCQPG4q3dF0j17+gjlKGQ0ZEZ+uSjMGS3nJ88xw
         hdOjQhQPvOCUo7v+CFAw9AC2kDknpiXMNEgN9poccUumVaAz/I7KDzLt0wIWwQKse7
         CzmaLtIJ72d4A==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 13 Jul 2023 21:06:06 +0100
Subject: [PATCH 3/3] kselftest/arm64: Validate that changing one VL type
 does not affect another
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-arm64-fix-sve-sme-vl-change-v1-3-129dd8611413@kernel.org>
References: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
In-Reply-To: <20230713-arm64-fix-sve-sme-vl-change-v1-0-129dd8611413@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rXmOaMmqlk7QrELiC/kSDYYNiucDsBT8D5q7ohFdQ7s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBksFpOCjYO1OOQVtYTH9sPPOR3+Xz9V8BWbDTBW4Pp
 GWfNe4SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZLBaTgAKCRAk1otyXVSH0Iu2B/
 wIRfaFgefheO/Xj5GZBgB9FVb81SFw5aD50REv/xVXdJ5spcz4DGwzM+o29bB6UEo6q9/K/zeAZ5m3
 RkXHaCr7e5oOCNQ2yA7nmaUxgkVRurq7ZR0iw7a+CXa2v+kJJXm57gxwzW2TxXuifYmhRH4I7v6TQs
 +xstxbf7hyvX70BnVYgj6LFdswICVgXIBngyV9141gpgkApw8se8jObvU8LD0bwaOIwVxXj2YMrLn3
 pp6DZMMUv+xgE3WvbPXmf5VdLoIvPzNE8UARWTL0duYKSBIF3DNTIcEqS1dAxfU9RMPatmAvTKqGbr
 VtpN0VmWvVGBW2yYZz+ID2/hu1Q4i+
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On a system with both SVE and SME when we change one of the VLs this should
not result in a change in the other VL. Add a check that this is in fact
the case to vec-syscfg.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 58ea4bde5be7..5f648b97a06f 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -554,7 +554,8 @@ static void prctl_set_onexec(struct vec_data *data)
 /* For each VQ verify that setting via prctl() does the right thing */
 static void prctl_set_all_vqs(struct vec_data *data)
 {
-	int ret, vq, vl, new_vl;
+	int ret, vq, vl, new_vl, i;
+	int orig_vls[ARRAY_SIZE(vec_data)];
 	int errors = 0;
 
 	if (!data->min_vl || !data->max_vl) {
@@ -563,6 +564,9 @@ static void prctl_set_all_vqs(struct vec_data *data)
 		return;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(vec_data); i++)
+		orig_vls[i] = vec_data[i].rdvl();
+
 	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
 		vl = sve_vl_from_vq(vq);
 
@@ -585,6 +589,22 @@ static void prctl_set_all_vqs(struct vec_data *data)
 			errors++;
 		}
 
+		/* Did any other VLs change? */
+		for (i = 0; i < ARRAY_SIZE(vec_data); i++) {
+			if (&vec_data[i] == data)
+				continue;
+
+			if (!(getauxval(vec_data[i].hwcap_type) & vec_data[i].hwcap))
+				continue;
+
+			if (vec_data[i].rdvl() != orig_vls[i]) {
+				ksft_print_msg("%s VL changed from %d to %d\n",
+					       vec_data[i].name, orig_vls[i],
+					       vec_data[i].rdvl());
+				errors++;
+			}
+		}
+
 		/* Was that the VL we asked for? */
 		if (new_vl == vl)
 			continue;

-- 
2.30.2

