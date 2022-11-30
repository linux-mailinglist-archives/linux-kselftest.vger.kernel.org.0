Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F1C63CC2E
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Nov 2022 01:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiK3AHO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 29 Nov 2022 19:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbiK3AHE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 29 Nov 2022 19:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B27044E
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Nov 2022 16:07:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3475D61981
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Nov 2022 00:07:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39566C43470;
        Wed, 30 Nov 2022 00:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669766822;
        bh=kOi2ubrZvDe707/dHvl2mMsoj6BDmru6DBWUPvLaUxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V76bYzMawZs2YAZJGTTI54SCy/ykzT/KViJgN1xRHteLpFJ4NMiP16Eu+ai6NkR9J
         KqjYNfFxvQicyYObFWmw5mjE2Bn2sMAiR/U6I+TpayzrU1xXHxgStxeY/YYzvWjcIw
         LA2P7bYO7U9xGtQVqwfGOEXHlMXaUoR9FI174M7iTCmJllRtbzG4CVYCjdjyn17usp
         XtzoUuo2GMffADPV756TGO5MiNZ5RkvKjtBR3d5ZiOSVCKy8joNLAB2DWY1WYfi+kL
         VTni1/k/QUM2NNDK4A6MX34ZDz6A8HYVJPppOyRWPuX+vdw1JVZD5HUVe8M+6Vd2aa
         PHnk+g1XBq72w==
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 5/6] kselftest/alsa: Provide more meaningful names for tests
Date:   Wed, 30 Nov 2022 00:06:07 +0000
Message-Id: <20221130000608.519574-6-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221130000608.519574-1-broonie@kernel.org>
References: <20221130000608.519574-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=broonie@kernel.org; h=from:subject; bh=kOi2ubrZvDe707/dHvl2mMsoj6BDmru6DBWUPvLaUxo=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjhp5vuot+YdREPb2LKHc+Hc4LtSKasB2J15HPSkKa bmmoyNiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY4aebwAKCRAk1otyXVSH0CQdB/ 9cJAjFX1Xnft5g+5CfO4Y8lx+WCr3PDsQszQed6iptz7DARLlXwMxdtMkdd604CYcSD6AvJNAK3cw/ ZkkB/JMf5+ux/09aCxl/d6Cikp9UygL6YGghksGVo45g3IKRJ7S/KIYXpF1bYrEVgXJRsLnmLttiDD 9wKr3MxG14S+OUBmHArQDXpFX4GhRdrhcLo1mzq9C3uftSxkbei3787vsCNf/JprSYk0HBd5yJM7+4 st6OIHQjPQ6gRYIcR0pxe8EHnn6Sut3MNmakDNDvkKVduqSpX0u7GCcCQz2P/h1WkYXH9Lwx/rQ3KZ pSJVo6mFnGccacTrr/nPenPPeiap2E
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
index bc0cb3c481f2..614ccc52cece 100644
--- a/tools/testing/selftests/alsa/pcm-test.c
+++ b/tools/testing/selftests/alsa/pcm-test.c
@@ -516,9 +516,9 @@ static void test_pcm_time1(struct pcm_data *data,
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

