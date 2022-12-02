Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B1D63FD05
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Dec 2022 01:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiLBA1U (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 19:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiLBA03 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 19:26:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16316CEF8B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 16:21:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A78DB621D8
        for <linux-kselftest@vger.kernel.org>; Fri,  2 Dec 2022 00:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DCBC4347C;
        Fri,  2 Dec 2022 00:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669940490;
        bh=2TvBpW+4mBe//AkYGD/5GQvrFqDxmtFqkYgIiMm0bgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcFXp35NRCmH6ZYPyy31n3LAu+jwq2kJCWgdVsvSztn9MMq3fN5lUinCJdZ1YvEkF
         xL4dZQRZhSzQ4HnmrrM8W96mwXdeFcWdNBgzcfpYZZ6d0fs2G/h2gfnE71GRNcKgVB
         OPdCbe8GRRkBJZM19WY0vEBK6bVn6t5s4lmGAH88H9goXOR08p+gBb4WbkamrzGCVc
         QoLCnO8NUQFK4YHOnW/xhVnLsW0lemZ41gg/UMz6x01iefSD22IYYFBkzVmliwREpA
         PJG9aAxqvFn7BtGoGzEMbzjIM6yyFZHxJCIMmJJOQTe/LalIEFXbZWNMbaILIB+XcB
         SCZurxV2CvlwQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 5/7] kselftest/alsa: pcm - Support optional description for tests
Date:   Fri,  2 Dec 2022 00:17:47 +0000
Message-Id: <20221202001749.3321187-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221202001749.3321187-1-broonie@kernel.org>
References: <20221202001749.3321187-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1131; i=broonie@kernel.org; h=from:subject; bh=2TvBpW+4mBe//AkYGD/5GQvrFqDxmtFqkYgIiMm0bgA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiUQq9PhIaf0O7Ezd65lBt/l7LVB7O8/W0d1//JGw IXs0OSGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4lEKgAKCRAk1otyXVSH0OyVB/ wLRcQW5P/g1qd8SZ5Zg9Fs9Jwc1mzWGb7otESMM0f0RMdhOW0Bge3A3SHfz+5BcIQH4lxdzgOb78Af B7HJdsZzP46f8w7uNybSWoqaYS4F9j0SF8GsxqOKytc0apmS315oCgTg0VE8jsB5aug0CO1HhzOSoG kSAcCs5KGqAHvckJm56UAILVKG/Udz6lqEYVudDuF1Eo2PxT7IuhQIEpZF7hKgQ9KmfTtbqlRkewZa JjQsUsZzz90F0V/TfbCNJrtpiRMeO+3ZEx8Nufw5KRpC9dS6jAPJOK/TDIcwWNXRBAmifSrau7X5nL Bw4t8oR5v+CZghefkEkgGID6hqR9uM
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to help with the comprehensibility of tests it is useful for us to
document what the test is attempting to cover. We could just do this through
comments in the configuration files but in order to aid people looking at
the output of the program in logs let's provide support for an optional
'description' directive which we log prior to running each of the tests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index 5fbb3ff517aa..57d3f6dcb46b 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -244,6 +244,11 @@ static void test_pcm_time(struct pcm_data *data, enum test_class class,
 	snd_pcm_sw_params_t *sw_params;
 	const char *test_class_name;
 	bool skip = true;
+	const char *desc;
+
+	desc = conf_get_string(pcm_cfg, "description", NULL, NULL);
+	if (desc)
+		ksft_print_msg("%s\n", desc);
 
 	switch (class) {
 	case TEST_CLASS_DEFAULT:
-- 
2.30.2

