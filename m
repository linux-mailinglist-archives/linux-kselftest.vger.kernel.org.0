Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FCA509177
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Apr 2022 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241656AbiDTUhD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Apr 2022 16:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbiDTUhB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Apr 2022 16:37:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A609377C7
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 13:34:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1403B8215F
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Apr 2022 20:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E227BC385A1;
        Wed, 20 Apr 2022 20:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650486851;
        bh=tVFCDZ0vBwvWKJ8tL5yO0R/kUmljF0kqDX2ldSTF8Dg=;
        h=From:To:Cc:Subject:Date:From;
        b=MHjcFJJYYSWwm+k7Hw7O2Nz5QkZECo96GlzUt6uPQJiI37cgA27i9OfoUcO95O5VU
         rVCPZ+Twe9EHTndUyaAoVvQwJBIZeP4XvNzhXQFfqUNfBMFhlwWkfmc+w/QoysyiVs
         +J+zJ8IaROy2iE1uX4gNijBdfw8dn2Tkh6lWx+2dbz4KvJJdEYHOqI/1nhpl75bjNo
         2ZRbwfncv0F40gN1/szSkCFi4Sna7c766vJXcJVsjHaq0Q34jlE3uRJy/0/lUpDjCV
         dx1iIWaeceSeZab/Th7wfc0/ybTVBzSqxtJgtbjoavRo5E4MusjRUgSBtjE1sLvq2V
         9uNiOgCgGImEw==
From:   Mark Brown <broonie@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] selftests: alsa: Start validating control names
Date:   Wed, 20 Apr 2022 21:33:20 +0100
Message-Id: <20220420203320.3035329-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; h=from:subject; bh=tVFCDZ0vBwvWKJ8tL5yO0R/kUmljF0kqDX2ldSTF8Dg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiYG3mcAO/vJ0SBQyjb4SwpnhiafiONNdykHqOJk9A CBVYn1OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYmBt5gAKCRAk1otyXVSH0LnMB/ 4guK0eanunQTBSnw9DVKyEw5/rEpo98727kQQxDVlvGCGw1EOHKZQ/iOpPfxlJn2BEva+1zn/QZZSA BJaeHsysVIQyK7E1FZzcNHulqfNRQK8uEQ1UjqmI9G9JNolYyOwgm41ScPSdgnq8tZMze9UMjRp7/A FJz72pNDX74Qw8pzfooeLE9T80BOsiQ1n3URuy4tDW/HwN+9mNbGUt5IeXLxp9L1JHp0nJadsSC/3Q xIxuZsG9Vre2lag8oJz8LYqQDjbT8CjgZksjLY5NXDFTbz7LQIq0hiphVe1PitzcJsfpxnoTxKAz2J +CXaOW8YXUbQna93CPZpENtngsFpQH
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
 tools/testing/selftests/alsa/mixer-test.c | 41 ++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/alsa/mixer-test.c b/tools/testing/selftests/alsa/mixer-test.c
index eb2213540fe3..b747dbc023ab 100644
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
 
+bool strend(const char *haystack, const char *needle)
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
+	if (strend(ctl->name, "Switch")) {
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
+		if (!strend(ctl->name, "Switch")) {
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

