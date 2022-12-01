Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A94BE63F5FA
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:11:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiLARLG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiLARLF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BB2A897B
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C67F662079
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:11:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0407C433D6;
        Thu,  1 Dec 2022 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914664;
        bh=Vx9X4XLGV+87QBonlTDAWmJxr2iTnW/AMH1GHUB2CgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6LIrwS80f3HWFnPn+E8TAsDfOpXiqIaFhngKHjGIgteI+OnVs86nf9jRq8+8jGOB
         RHvkYT2RKpp9MGg61f3J995kRHXZD6M7VUEwOeiDc0w0Fu7YclF0jhGRV8WBAdFwL4
         Iqk0gWRoM5zw5IsDY9VzNU0XizDg95UyPoAKNHokcBOzkOqtcz99pq1aeOjGdwqXJ6
         hWvZ+9cgGTrGebyIqOyn9ZWg1QUsSGbZqacRSARvqMUs9nXmoLsQSfxMWNUOa5SHbL
         HmHLcHI0Sc862ACC6Gom9XA3l44NyIWZOGPUHAL3ZT1SWbEk/MH+3wVSJCUrcxHzeg
         UEnwKlv65hqPQ==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 5/6] kselftest/alsa: Provide more meaningful names for tests
Date:   Thu,  1 Dec 2022 17:07:44 +0000
Message-Id: <20221201170745.1111236-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201170745.1111236-1-broonie@kernel.org>
References: <20221201170745.1111236-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=broonie@kernel.org; h=from:subject; bh=Vx9X4XLGV+87QBonlTDAWmJxr2iTnW/AMH1GHUB2CgI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiN9fpUWCP6bQYPg5IEoJ+soMA16r5YPqydc2hWsY EF2z3w2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4jfXwAKCRAk1otyXVSH0AZdB/ 0T7EDVqIvPaJ4DTpkUCVnYqTDAZcIVPsGXS7XYxGHohRda7U+pQQEvwrP5Xy0h16kSBSAbdNCwn/Fd tZVNqz3ppc3wgPsh5dqWpkd7hF6PUHD9vDLULrpKKZCRL4WQzD0pIsGfAdDt2sgk78p0IOfRii+xi1 T4kP8k9DwxDJCkvZFQa8Ysn4VyUXwi30/5qCryJ06gzZGpCqM+Vx2+I0Op+X/X7P+ADJmFqpsApOJ9 Y4oaU2ipxfaZIy08SezKPMrg+I88qyE0k4XdhLSNQTd3TxLsR0pl5ZSvsot81b/4lA5VvJu10SP7yV cCkIopHccpUw6jX/eOvuOLr/+9Vdjh
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

Rather than just numbering the tests try to provide semi descriptive names
for what the tests are trying to cover. This also has the advantage of
meaning we can add more tests without having to keep the list of tests
ordered by existing number which should make it easier to understand what
we're testing and why.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index c701cf507a95..afa13377481d 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -446,9 +446,9 @@ static void test_pcm_time1(struct pcm_data *data,
 }
 
 static const struct time_test_def time_tests[] = {
-	/* name          format     rate   chan  period  buffer */
-	{ "test.time1",  "S16_LE",  48000, 2,      512,    4096 },
-	{ "test.time2",  "S16_LE",  48000, 2,    24000,  192000 },
+	/* name              format     rate   chan  period  buffer */
+	{ "S16.48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
+	{ "S16.48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
 };
 
 int main(void)
-- 
2.30.2

