Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6486F656D40
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 18:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231652AbiL0RIL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 12:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiL0RHh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 12:07:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD913BF4F;
        Tue, 27 Dec 2022 09:07:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70790B810A9;
        Tue, 27 Dec 2022 17:07:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85A1C433EF;
        Tue, 27 Dec 2022 17:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672160849;
        bh=Qac4tRPVwm+vU5JwLiY8YoXwmuzFi3r8T7rPHIYOptY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=gJCEh+g2pV6+Gh7a9gs7qh3fiwSGW6rpOvzWwYM8MByFQNQdd4S5Tn3wnVfJJO3Iw
         DSkhlehz6Rs3dqcemfRGDzTrnu7+Dp9iHqETbJToTfTg420fYExUIPQqNzrrAsJUKU
         ku5wy3JMyxdHNbvv43v6NJcBwZL/ahDkp9V5FGkIEe2vXBa3TZNWgj5Gd1hWPFK0v1
         w7+CRFFHA/U5CaPqeihqHOqYQhfUr7UGAUFPBZg0/IaMqJJEptcH03DxiXvXZ7VgfR
         fJo5KDhVfC/SCQgzyBJPRXylG1+ztqbm7FUB9EYFIvA96XZelEZl2/tsO/TMeJNRLt
         L8E48VJOgRRrg==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 17:06:50 +0000
Subject: [PATCH v4 5/7] kselftest/alsa: pcm - Support optional description for tests
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-alsa-pcm-test-hacks-v4-5-5a152e65b1e1@kernel.org>
References: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
In-Reply-To: <20221208-alsa-pcm-test-hacks-v4-0-5a152e65b1e1@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Qac4tRPVwm+vU5JwLiY8YoXwmuzFi3r8T7rPHIYOptY=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhuTVas4MzQHH97r+zPKZlfcq4tujG01du025FifvLdR32ao2
 caN8J6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViawKVycAjCRrEUcDC0uLOEvdUVSdR3evdbfE6
 Adk7IpsjXsR//DtykbAmdtqxA7tHaRepginzdX1ocMg2ubGbce5dQqd6tq3bZGdOq9Fwv97lTWH42Z
 IiH7/PZa3qon/3t/XFp+wWzi7L1ba/YWG1bflF6y5HyG/+vs5q3NiY3M3xOMHj991JWoUsjfuHO3wp
 oE455t097EsFzWPd3CcsyjyoZZTIvn08u+vr1f2/o9ROsUoz82/JV0X6X8NLnlqtqlV9bWGjsDyrd1
 Kqxr2ril3e9TQGCX8P9FSzLZ05ru9UbO0PQsOyvMkXFjCZ9alisz1+ryAwv3PfKIXn934tQqYZ34IO
 kYI6fUWNWWXxGfPsgcC+fVu3ATAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
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

Reviewed-by: Jaroslav Kysela <perex@perex.cz>
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
