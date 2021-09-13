Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D157408B41
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236229AbhIMMop (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 08:44:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:34396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236172AbhIMMop (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 08:44:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED36760FBF;
        Mon, 13 Sep 2021 12:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631537009;
        bh=fTru8C82+qEoFuIVsOagDGbJOwRBZlo5okum4GyeuLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9gjwORFGr+vn3sbOiP4bKF25LrRbq0ABDo/IFz97eOSMFZt2cirE6eYWIy8jxP9e
         h/MJQQ+h3ODtZv6iF+WMrZeWiQRXuiz+S4mwIj1Cjc1QyVne9a+gbQKnQxgK7iMYAD
         S32gR2Mehs1hclwtgQW6LmdPSxpcw7LeaAHPG6V/nkzrl63RrIp3U9DjsVcG2r4b/J
         S5vWAPX5AWVQAO/FvlTtvFZh9SFexuNltWPBPWoAgcCVmt3eVkMKtYsOPyqNPgPIQn
         QgD0ywwyCuToqRZCvE+RW1P+5QWR+MOFas2Zr+aRJcWe+PjKHxKAy8F7bzG0Ue0+m0
         ieCwT3p2K1Neg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 4/4] selftests: arm64: Verify that all possible vector lengths are handled
Date:   Mon, 13 Sep 2021 13:37:11 +0100
Message-Id: <20210913123711.51274-5-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913123711.51274-1-broonie@kernel.org>
References: <20210913123711.51274-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3181; h=from:subject; bh=fTru8C82+qEoFuIVsOagDGbJOwRBZlo5okum4GyeuLU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0X1EJPUcKg2bw9frFI4J4texy0Ys97Sn2UTStdF BB8S2geJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9F9QAKCRAk1otyXVSH0HJ4B/ 0QksbnyUPgUTB3xEDuwrycz8LvUbA3Fjv/p3NvAtntuTytyTFGA3VyD851PKGaGIqDMtA2GPByYm2i zyosu0TlFg/eIq5vK8A5Isp6rfCF4Q8yCX9Q9HGfKFFcBxlgR/lE40FMtZNqc6FFWyZU1dORECRtjb BoLanFsM71ZI82/raBhfX5SraaGyeBZXPYANsFeVzreIK7hG/p3jdlQnAIR3EbGQ7KliJpdaQj5MJ3 4RI39UkbvHvWDWpqje/ahvaFEAXpROYHz1Ehv7e2p0aus6dqok63Wj/+DQoQI3iaKCoal/L9GwTxwE 9j5KUowa5VVRlZbpuEukjnY7BOnlxQ
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
 tools/testing/selftests/arm64/fp/vec-syscfg.c | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
index 9d6ac843e651..61e9704e03fe 100644
--- a/tools/testing/selftests/arm64/fp/vec-syscfg.c
+++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
@@ -540,6 +540,81 @@ static void prctl_set_onexec(struct vec_data *data)
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
+
+		/* We should've hit one of the other cases... */
+		ksft_print_msg("%s VL %d returned %d test logic failure\n",
+			       data->name, vl, new_vl);
+		errors++;
+	}
+
+	ksft_test_result(errors == 0, "%s prctl() set all VLs, %d errors\n",
+			 data->name, errors);
+}
+
 typedef void (*test_type)(struct vec_data *);
 
 static const test_type tests[] = {
@@ -557,6 +632,7 @@ static const test_type tests[] = {
 	prctl_set_no_child,
 	prctl_set_for_child,
 	prctl_set_onexec,
+	prctl_set_all_vqs,
 };
 
 int main(void)
-- 
2.20.1

