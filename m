Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E201875B6FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 20:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbjGTSjZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGTSjY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 14:39:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C90270C;
        Thu, 20 Jul 2023 11:39:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7EC761BFD;
        Thu, 20 Jul 2023 18:39:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D507EC433C7;
        Thu, 20 Jul 2023 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689878357;
        bh=rXmOaMmqlk7QrELiC/kSDYYNiucDsBT8D5q7ohFdQ7s=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=mtgFWNoVWqppKfmmwXxHY8o8mfruxBcpLKPaSxviOeFSB2G6+jMlgOJ78/GJK3zyM
         YQivuehx4s4SjWWsN4xM6sAZEmyXkgNLlOCVKMv5/xVfMtIakGE6/QZZ2mrU4UynjF
         tKKo//JJKRRtRb7kfd4cL551+M2efF1R39kVXMKFbpLfzwSMUw/OP4XcFSU9W8/nNo
         vAOm8V2nd41dZcex48k+lsUx8u9tcNB+lr5v0KU8du4AY9lF1lJ4lK+1YMQIian7P4
         6MW26EsuCRI0e8fp0Wt5lWv/DJp16stqfeaB6fGqRnqZHFrOpparJUO+S4O++RMeRR
         mQmFpyuK9SXcQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 20 Jul 2023 19:39:00 +0100
Subject: [PATCH v2 3/3] kselftest/arm64: Validate that changing one VL type
 does not affect another
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-arm64-fix-sve-sme-vl-change-v2-3-8eea06b82d57@kernel.org>
References: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
In-Reply-To: <20230720-arm64-fix-sve-sme-vl-change-v2-0-8eea06b82d57@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     David Spickett <David.Spickett@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1868; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rXmOaMmqlk7QrELiC/kSDYYNiucDsBT8D5q7ohFdQ7s=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhpSd9R4iIrrWIkXKwQIKwffTPk6wM8nqKk9d36291sEiQZGh
 RbuT0ZiFgZGLQVZMkWXts4xV6eESW+c/mv8KZhArE8gUBi5OAZjItzvs/wu9qy0kFdUf+G5IsXo2/7
 hA/Zn8hGUznl1ZPTH9wTmOLVdtiw/kbM9N97+d5+DiXm8a6/TobS7388Be7ldpHnN0dyVNim351vDA
 WqKm+F/G2X3MsWyJxz9HX5zkW7pn0i03lxcy880MNniqfGGxDs7qibDhvLnvuv5tJVnG6sSsN05Tvq
 fJcabuT4uY0G9hfKT9xgSn74s2X/tdqdapw/J7eYjvi3vGwuY62bc1ZQVvepYWpLX32+zYvbr9KacP
 u8gNfevc8sqUee8MqoKOGG6Yaxr3xlZnayjTMyMdnqYVRdZH+jQbNXtN+BS4xPXm75nPVmG++OfPu4
 KnZWZU9m3ZG8tzRNjlQ8wdDi4A
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

