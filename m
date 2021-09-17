Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BC440F749
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Sep 2021 14:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhIQMLe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 17 Sep 2021 08:11:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhIQMLd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 17 Sep 2021 08:11:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B52D61029;
        Fri, 17 Sep 2021 12:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631880611;
        bh=kxlmWsIvJBPFCGEqPWM9dGFH0Yj8wRu49i4D5IG/WpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DjssvoiUN5ANfMlWEbsdVn27ClLMffxblPudScRWVEYnp70toFZQEF5yluaGvcD5T
         tcwWUgZ7BV8I8VTPTiYTyaKElxEvm3udJnn2pjfdh7Fq6JwfjbPb9L52aKZrL5oBT5
         oA9J2bfntOd6hOOAJupg9l6LDGZDY619hpuxESuVatHAPuEObluGG39IZohXfl8450
         bZODniQo2zAlX/+vww/QUTzjqE5LOFjH+ooUxmwLICYSshKet6vCypnFGcnSRtPcsV
         BzvYz2fn5y2l6C63SEgSWsZ9G1AET4t4OCMq+ZjGQV4on8m8WmpT2+DAaKKD2OtJDH
         l/BlQA8Mh0yZQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, misono.tomohiro@fujitsu.com,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 4/4] selftests: arm64: Verify that all possible vector lengths are handled
Date:   Fri, 17 Sep 2021 13:08:55 +0100
Message-Id: <20210917120855.13858-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210917120855.13858-1-broonie@kernel.org>
References: <20210917120855.13858-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3010; h=from:subject; bh=kxlmWsIvJBPFCGEqPWM9dGFH0Yj8wRu49i4D5IG/WpE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhRIVU7U6WVRMbQ4I9XZp4rIOvx6l6GsqSZbOGzJik VwZX33qJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUSFVAAKCRAk1otyXVSH0GjyB/ 9OudLcJQvNJfeWWWwTv0IOwf9iJzcdz57NT/VhZhZeKz0Wa49MaxrVo/M8/eT6cDV1M4eXDZ4LQP7p aJ96q4m1oDRHHk+mNSxwOikjecvNd0T1jNwKQt1hQmfBqe6b7QBfExKcPG7JJas3k77Als3XlzYI7q jpRQyrcpyYAqlABUl+gQnI32isOCaJwHHyCGQX0A5WYzoBc01a4a7U8jNZerEL+5+dVwWMvExrqs5u jy3JkODPeluOmpM1668rlNb3lLErdRciVL0DHOmUT+K6T9P0fY9aSXbfiprFf8LjQgl7SYplwPSDsZ nPv/33qFF2z6NyZ5IA7DeY0oEcnGJ3
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
---
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 9d6ac843e651..de11cd2f5d79 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -540,6 +540,76 @@ static void prctl_set_onexec(struct vec_data *data)
 	file_write_integer(data->default_vl_file, data->default_vl);
 }
 
+/* For each VQ verify that setting via prctl() does the right thing */
+static void prctl_set_all_vqs(struct vec_data *data)
+{
+	int ret, vq, vl, new_vl;
+	int errors = 0;
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
@@ -557,6 +627,7 @@ static const test_type tests[] = {
 	prctl_set_no_child,
 	prctl_set_for_child,
 	prctl_set_onexec,
+	prctl_set_all_vqs,
 };
 
 int main(void)
-- 
2.20.1

