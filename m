Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC96463F5FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Dec 2022 18:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiLARLN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Dec 2022 12:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbiLARLL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Dec 2022 12:11:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3417A9CE4
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 09:11:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6472DB81FA9
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Dec 2022 17:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9B7EC433D7;
        Thu,  1 Dec 2022 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669914666;
        bh=SsZf73d9X+ThRijTkqSeXXiL7HY0s8AV50Pl2/LMh4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d4oBQ3kteMHWEcQ24QVg94vS6mnZG0tqtPlFGfZXSMoc6QvgXRyEcXdTfcIx4HBed
         cXLaS6drn90k2eq9LHu74IFQ3F9nL5aumbjTJmTAzt8E+rQeor5Y6wwiCcTbIQsjk4
         2E589/cDDoumjyybC28EpJP/KORJbWvqoBsrviRJKbqa2RYEOgHZwXqno24l+nE2bn
         4ViEiEQddg3xEQViGAEUAuBKZuBv7LBrIXed3BZOUUAq4lMINN3FE9tepFjxJw+IeI
         hRfzEZ4qGnSkButCwz3nIgfivdv0tW5OvQyecxOU/oLmfc+eFsAUxqNxCiQ81Z02jO
         dLwmKcrFfgI0g==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 6/6] kselftest/alsa: Add more coverage of sample rates and channel counts
Date:   Thu,  1 Dec 2022 17:07:45 +0000
Message-Id: <20221201170745.1111236-7-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221201170745.1111236-1-broonie@kernel.org>
References: <20221201170745.1111236-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1804; i=broonie@kernel.org; h=from:subject; bh=SsZf73d9X+ThRijTkqSeXXiL7HY0s8AV50Pl2/LMh4E=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjiN9gYhCauJMbUYoKEkuGL4i25qCvKKgpa7xW+O1O 5mwDEayJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4jfYAAKCRAk1otyXVSH0BqvB/ 48CSv+3GrAP2ipd3Hdm86AYV17FrqWYCkMBvcd7sBxicQbT/tD5JeI4gqbYd2RNkDWE7uALKBdgzHa 9Zn1TDCo3TZ+OMhH89+r1NwVlJ5sjg/RozETKgz4sCz/8eSHAQUXPMBYsOsfrHXBTtUUJHZN7FIOSN +l++kFrt/aVXRX1qLdasv5JS4IYT/RDRvdK/RYYNtpZpe3uqhV95b6EVJnmUNJ9M87eU99wPOln5gT f66GOOZ0xmr9ShvCDJUpcQ2oLaEolKT2ZZXbu3Arpst6MDujBT6zGZOlMHgNrW2KXfCP8jqRT3tSOU vkklRBJjl462UENFV9a897CesKd3za
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

Now that we can skip unsupported configurations add some more test cases
using that, cover 8kHz, 44.1kHz and 96kHz plus 8kHz mono and 48kHz 6
channel.

44.1kHz is a different clock base to the existing 48kHz tests and may
therefore show problems with the clock configuration if only 8kHz based
rates are really available (or help diagnose if bad clocking is due to
only 44.1kHz based rates being supported). 8kHz mono and 48Hz 6 channel
are real world formats and should show if clocking does not account for
channel count properly.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/alsa/pcm-test.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/alsa/pcm-test.c b/tools/testing/selftests/alsa/pcm-test.c
index afa13377481d..f293c7d81009 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -446,9 +446,14 @@ static void test_pcm_time1(struct pcm_data *data,
 }
 
 static const struct time_test_def time_tests[] = {
-	/* name              format     rate   chan  period  buffer */
-	{ "S16.48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
-	{ "S16.48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
+	/* name          format     rate   chan  period  buffer */
+	{ "8k.1.big",    "S16_LE",   8000, 2,     8000,   32000 },
+	{ "8k.2.big",    "S16_LE",   8000, 2,     8000,   32000 },
+	{ "44k1.2.big",  "S16_LE",  44100, 2,    22050,  192000 },
+	{ "48k.2.small", "S16_LE",  48000, 2,      512,    4096 },
+	{ "48k.2.big",   "S16_LE",  48000, 2,    24000,  192000 },
+	{ "48k.6.big",   "S16_LE",  48000, 6,    48000,  576000 },
+	{ "96k.2.big",   "S16_LE",  96000, 2,    48000,  192000 },
 };
 
 int main(void)
-- 
2.30.2

