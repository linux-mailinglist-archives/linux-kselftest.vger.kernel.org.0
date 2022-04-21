Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A45509EF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Apr 2022 13:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbiDULxR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Apr 2022 07:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiDULxP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Apr 2022 07:53:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E3325EB6
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 04:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF0A061BC4
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Apr 2022 11:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC75EC385A5;
        Thu, 21 Apr 2022 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650541825;
        bh=2Qj24wHxJHGYnRy8/BlrM7tH3a9QjizVNtDyHG9KTL0=;
        h=From:To:Cc:Subject:Date:From;
        b=Q6Q6RhriZNI88NZnnbMIOKcipX0oXpTnyNgyWHYgVJO6s6uXvf0Aqw1eNb4yjkOu8
         BWC7hV0yNS5nz6NBxmZJX2gPuEP1Y6Rv7OHWJlZ6i+/wQhfRb5+7vBTus8+U2J3xwO
         me8C+XJRE83t7JCm4V8C+LSeVQ1CfSuDgJt+ndyy3QffyrjurcsQaDdU+zohGOGr96
         Sk/LPYLCzQMCrb57nVOJFkzYtlBfVS41sD/wBZYhQUMrX0BgN9ztZeBcpDoRu6Ixml
         0OO+B3kmjN7G0SA7a3ADNCdZmoYD42/yhFDjAevzqUUYGS8+sts8S9qsLQvrlBdSsj
         CDO2uOcKueUZw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] selftests: alsa: Start validating control names
Date:   Thu, 21 Apr 2022 12:50:20 +0100
Message-Id: <20220421115020.14118-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2549; h=from:subject; bh=2Qj24wHxJHGYnRy8/BlrM7tH3a9QjizVNtDyHG9KTL0=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiYUSpMT4SDjmEMOj+aJmQ/ChH9T/sDSTcy9NmBuYo nMDmLXiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmFEqQAKCRAk1otyXVSH0DWNB/ 4z6yCa2JhkKwSDKm4zOkyRMvA8w7U6j+QCfvTHvhgl9B5D1Orlw1/RiTDcaqNop1Mnoylv3Jcrnhyj zWfaaCS+GGCilhGy8TLmdJsEiKxfKMxUqG5PwueH+L0/L8GzXTB4xTFzyxRtt1EuELem05qiKL3pX+ VCqB86D/w3lRFBhFt3ht3zVV8MnEJR+JZQkMMCsN2Pz5s9WhRVnDwFFz5dDCOIMpBmQu2FvxUhvEcE NmNok948eUkNC7klyfHeIz94OFaC4tCSrIYBPLDiqpbTQVC77cCvqbwlWoDq2reYtLQxXrWs2Vpwjr Imq5SQxN2+MnBdS6VN6P5+lHQCGNYD
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Not much of a test but we keep on getting problems with boolean controls
not being called Switches so let's add a few basic checks to help people
spot problems.

Signed-off-by: Mark Brown <broonie@kernel.org>
---

v2:
 - Make strend() static.
 - Check for " Switch" rather than "Switch" at the end of the name.

 tools/testing/selftests/alsa/mixer-test.c | 41 ++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index eb2213540fe3..a38b89c28030 100644
--- a/tools/testing/selftests/alsa/mixer-test.c
+++ b/tools/testing/selftests/alsa/mixer-test.c
@@ -27,7 +27,7 @@
 
 #include "../kselftest.h"
 
-#define TESTS_PER_CONTROL 6
+#define TESTS_PER_CONTROL 7
 
 struct card_data {
 	snd_ctl_t *handle;
@@ -456,6 +456,44 @@ static void test_ctl_get_value(struct ctl_data *ctl)
 			 ctl->card->card, ctl->elem);
 }
 
+static bool strend(const char *haystack, const char *needle)
+{
+	size_t haystack_len = strlen(haystack);
+	size_t needle_len = strlen(needle);
+
+	if (needle_len > haystack_len)
+		return false;
+	return strcmp(haystack + haystack_len - needle_len, needle) == 0;
+}
+
+static void test_ctl_name(struct ctl_data *ctl)
+{
+	bool name_ok = true;
+	bool check;
+
+	/* Only boolean controls should end in Switch */
+	if (strend(ctl->name, " Switch")) {
+		if (snd_ctl_elem_info_get_type(ctl->info) != SND_CTL_ELEM_TYPE_BOOLEAN) {
+			ksft_print_msg("%d.%d %s ends in Switch but is not boolean\n",
+				       ctl->card->card, ctl->elem, ctl->name);
+			name_ok = false;
+		}
+	}
+
+	/* Writeable boolean controls should end in Switch */
+	if (snd_ctl_elem_info_get_type(ctl->info) == SND_CTL_ELEM_TYPE_BOOLEAN &&
+	    snd_ctl_elem_info_is_writable(ctl->info)) {
+		if (!strend(ctl->name, " Switch")) {
+			ksft_print_msg("%d.%d %s is a writeable boolean but not a Switch\n",
+				       ctl->card->card, ctl->elem, ctl->name);
+			name_ok = false;
+		}
+	}
+
+	ksft_test_result(name_ok, "name.%d.%d\n",
+			 ctl->card->card, ctl->elem);
+}
+
 static bool show_mismatch(struct ctl_data *ctl, int index,
 			  snd_ctl_elem_value_t *read_val,
 			  snd_ctl_elem_value_t *expected_val)
@@ -1062,6 +1100,7 @@ int main(void)
 		 * test stores the default value for later cleanup.
 		 */
 		test_ctl_get_value(ctl);
+		test_ctl_name(ctl);
 		test_ctl_write_default(ctl);
 		test_ctl_write_valid(ctl);
 		test_ctl_write_invalid(ctl);
-- 
2.30.2

