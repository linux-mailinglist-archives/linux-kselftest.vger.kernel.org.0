Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A3541C837
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 17:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345088AbhI2PWw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 29 Sep 2021 11:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344945AbhI2PWw (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 29 Sep 2021 11:22:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B755260E90;
        Wed, 29 Sep 2021 15:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632928871;
        bh=hobP6jAeZx6QQ7Ydf7I7XKHrEPYgz0Kcb2X81UWdEzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAnsW+/TIn7yqICiV7iDnrNvt0wQKf3YWAra0TmD9IjN86NntajbbmC0hw/CURvnM
         PvD2E9aDInAgphyreNzQHnAoA36uf2KdRHI2ut+zt/1BOCiAfHB2pB7fFTzzJb8DHc
         6fTCOFOzXhxkkXz2f9l/eL/Wvlt3qHdaOjoycVdt7ZIotMgj2Ybd/WiM/ugoPyRYXO
         DB6XAL5O6Usnxa3AqjF1nmvBIFNdOu3ZkV8XzCbV3lQv7PNpdFLnkiwwZneErEa84g
         8iWK4y4BuqHp48oRwJMDWgc8oB0UZcj+sT1N9x1D5jKCeZYRtewqEYvjhphw+lNdPc
         4aTj6hGxhPNyg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>,
        Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH v3 4/4] selftests: arm64: Verify that all possible vector lengths are handled
Date:   Wed, 29 Sep 2021 16:19:25 +0100
Message-Id: <20210929151925.9601-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929151925.9601-1-broonie@kernel.org>
References: <20210929151925.9601-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3241; h=from:subject; bh=hobP6jAeZx6QQ7Ydf7I7XKHrEPYgz0Kcb2X81UWdEzg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhVIP7Fn17ZOJa3L5PcYWuX+0Qn0CBOhU1UrioNDG0 AFh7nqSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYVSD+wAKCRAk1otyXVSH0FXnB/ 0Z31Lf97w/PUE84vk/vYjxF665UQQCW+tr0sSFdairDNjmq0xQRAAbmfYddgzlmY3hvI6HQ8J4PXiF CqsS5a738kvXrlCa20N+pYeYm3cyP9mT31+9+yfTj//Tx3kqXHgHJmVSPDN+BA/uJTXBZ3Oo5zvBdz uoYh+5TfKbijuaWagurdXFWBM2VaUIKb3UaSmUUou0IKRpRlgngOgN3Dnn9jZtWi29VykK+qYufuQv p+rlJLCu9ykSNr3d/T6FcF0kGt/TTkS8eAGr29DvZ0UNA9FyOh6Q5b9sJUj+QWAlSu/e6EsikrinWb C/GWfDmJGSij4DNEJXgKIlo+SWORiz
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As part of the enumeration interface for setting vector lengths it is valid
to set vector lengths not supported in the system, these will be rounded to
a supported vector length and returned from the prctl(). Add a test which
exercises this for every valid vector length and makes sure that the return
value is as expected and that this is reflected in the actual system state.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 9d6ac843e651..272b888e018e 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -540,6 +540,82 @@ static void prctl_set_onexec(struct vec_data *data)
 	file_write_integer(data->default_vl_file, data->default_vl);
 }
 
+/* For each VQ verify that setting via prctl() does the right thing */
+static void prctl_set_all_vqs(struct vec_data *data)
+{
+	int ret, vq, vl, new_vl;
+	int errors = 0;
+
+	if (!data->min_vl || !data->max_vl) {
+		ksft_test_result_skip("%s Failed to enumerate VLs, not testing VL setting\n",
+				      data->name);
+		return;
+	}
+
+	for (vq = SVE_VQ_MIN; vq <= SVE_VQ_MAX; vq++) {
+		vl = sve_vl_from_vq(vq);
+
+		/* Attempt to set the VL */
+		ret = prctl(data->prctl_set, vl);
+		if (ret < 0) {
+			errors++;
+			ksft_print_msg("%s prctl set failed for %d: %d (%s)\n",
+				       data->name, vl,
+				       errno, strerror(errno));
+			continue;
+		}
+
+		new_vl = ret & PR_SVE_VL_LEN_MASK;
+
+		/* Check that we actually have the reported new VL */
+		if (data->rdvl() != new_vl) {
+			ksft_print_msg("Set %s VL %d but RDVL reports %d\n",
+				       data->name, new_vl, data->rdvl());
+			errors++;
+		}
+
+		/* Was that the VL we asked for? */
+		if (new_vl == vl)
+			continue;
+
+		/* Should round up to the minimum VL if below it */
+		if (vl < data->min_vl) {
+			if (new_vl != data->min_vl) {
+				ksft_print_msg("%s VL %d returned %d not minimum %d\n",
+					       data->name, vl, new_vl,
+					       data->min_vl);
+				errors++;
+			}
+
+			continue;
+		}
+
+		/* Should round down to maximum VL if above it */
+		if (vl > data->max_vl) {
+			if (new_vl != data->max_vl) {
+				ksft_print_msg("%s VL %d returned %d not maximum %d\n",
+					       data->name, vl, new_vl,
+					       data->max_vl);
+				errors++;
+			}
+
+			continue;
+		}
+
+		/* Otherwise we should've rounded down */
+		if (!(new_vl < vl)) {
+			ksft_print_msg("%s VL %d returned %d, did not round down\n",
+				       data->name, vl, new_vl);
+			errors++;
+
+			continue;
+		}
+	}
+
+	ksft_test_result(errors == 0, "%s prctl() set all VLs, %d errors\n",
+			 data->name, errors);
+}
+
 typedef void (*test_type)(struct vec_data *);
 
 static const test_type tests[] = {
@@ -557,6 +633,7 @@ static const test_type tests[] = {
 	prctl_set_no_child,
 	prctl_set_for_child,
 	prctl_set_onexec,
+	prctl_set_all_vqs,
 };
 
 int main(void)
-- 
2.20.1

