Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4594C4D2E8E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Mar 2022 13:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbiCIMBM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Mar 2022 07:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbiCIMBK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Mar 2022 07:01:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803BB101F1F
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 04:00:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CE9D61900
        for <linux-kselftest@vger.kernel.org>; Wed,  9 Mar 2022 12:00:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81643C340F5;
        Wed,  9 Mar 2022 12:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646827210;
        bh=Vlup48Xgnsiv7OUsMwoDzP6QOt9jogCej0lZhuCOeX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eVGKDytz8Dn6b85MNydpKd6tbs1rxMb9C1ENxay+VvuocM20fYoI7TqbWmqY6MbZ8
         gfD/Q0/J2mycv8Lw90pL5dUlt/5THjNMBOYPrUXvyPxBnRabTTnZo106dMQtJJstoA
         ZvXhg7Ha58VgacVrOnso1SXbtayyL0shHeLvhcpcq8fXvgtsCnRHw32DrE3Ox1euY8
         miPmU9zd3cf2d6qznuHjvKsWTQNlcpNIa1PEOAIAcWzs1VZkTFgYAxw3jgN224bZjV
         r2+UrkwvuoEjph3/+iKpt23I+K4niTZKNGlcH46mH8cMyw4wH86eSSoMX8mV+sOBRp
         4P8dma9S0yCuw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/3] kselftest/arm64: Validate setting via FPSIMD and read via SVE regsets
Date:   Wed,  9 Mar 2022 11:59:18 +0000
Message-Id: <20220309115918.22469-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220309115918.22469-1-broonie@kernel.org>
References: <20220309115918.22469-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5345; h=from:subject; bh=Vlup48Xgnsiv7OUsMwoDzP6QOt9jogCej0lZhuCOeX4=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiKJaUdVzNxXsur79b5JVRLjrtkNxCJ6glZwyldm7f GItPLZ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYiiWlAAKCRAk1otyXVSH0BEHB/ 4y/G3CLl0XoeL35UUo1FI2WKZhIjM6GWVMaANvfJpuDGh3xiBiqtfQtJwtO1HMaFfYbEddNUmGnDu8 ioYAoIAkgB03OywUFO4XTouyolPR8ZrryrWldu5hSsuhjxVLDzXH+eF5FVHynAN2V9MLvOWWfEjJJl u5zHum+pdT46DYT0HIHiPum6HCy6GP8/vn/KoayGyonTeFvOfpR6fVnS8dY0KkmZpeOfVd/OZ+KiYm i2g61a3T2jkP6TKMrBHxvcROPj1m5ltBD1ZYNp9rdGsRp2K94h2VCywY5s/YAsL/306TE1uKvhKSAq 6QvSTJ9lAJ4TtUs4hmJrqjY2Pv22Xc
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently we validate that we can set the floating point state via the SVE
regset and read the data via the FPSIMD regset but we do not valiate that
the opposite case works as expected. Add a test that covers this case,
noting that when reading via SVE regset the kernel has the option of
returning either SVE or FPSIMD data so we need to accept both formats.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 123 +++++++++++++++++-
 1 file changed, 122 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index ccd3ff1e8c06..cdfb5107fd0c 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -46,7 +46,7 @@ static const struct vec_type vec_types[] = {
 	},
 };
 
-#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 3)
+#define VL_TESTS (((SVE_VQ_MAX - SVE_VQ_MIN) + 1) * 4)
 #define FLAG_TESTS 2
 #define FPSIMD_TESTS 2
 
@@ -80,6 +80,15 @@ static int get_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
 	return ptrace(PTRACE_GETREGSET, pid, NT_PRFPREG, &iov);
 }
 
+static int set_fpsimd(pid_t pid, struct user_fpsimd_state *fpsimd)
+{
+	struct iovec iov;
+
+	iov.iov_base = fpsimd;
+	iov.iov_len = sizeof(*fpsimd);
+	return ptrace(PTRACE_SETREGSET, pid, NT_PRFPREG, &iov);
+}
+
 static struct user_sve_header *get_sve(pid_t pid, const struct vec_type *type,
 				       void **buf, size_t *size)
 {
@@ -475,6 +484,115 @@ static void ptrace_set_sve_get_fpsimd_data(pid_t child,
 	free(write_buf);
 }
 
+/* Validate attempting to set FPSIMD data and read it via the SVE regset */
+static void ptrace_set_fpsimd_get_sve_data(pid_t child,
+					   const struct vec_type *type,
+					   unsigned int vl)
+{
+	void *read_buf = NULL;
+	unsigned char *p;
+	struct user_sve_header *read_sve;
+	unsigned int vq = sve_vq_from_vl(vl);
+	struct user_fpsimd_state write_fpsimd;
+	int ret, i, j;
+	size_t read_sve_size = 0;
+	size_t expected_size;
+	int errors = 0;
+
+	if (__BYTE_ORDER == __BIG_ENDIAN) {
+		ksft_test_result_skip("Big endian not supported\n");
+		return;
+	}
+
+	for (i = 0; i < 32; ++i) {
+		p = (unsigned char *)&write_fpsimd.vregs[i];
+
+		for (j = 0; j < sizeof(write_fpsimd.vregs[i]); ++j)
+			p[j] = j;
+	}
+
+	ret = set_fpsimd(child, &write_fpsimd);
+	if (ret != 0) {
+		ksft_test_result_fail("Failed to set FPSIMD state: %d\n)",
+				      ret);
+		return;
+	}
+
+	if (!get_sve(child, type, (void **)&read_buf, &read_sve_size)) {
+		ksft_test_result_fail("Failed to read %s VL %u data\n",
+				      type->name, vl);
+		return;
+	}
+	read_sve = read_buf;
+
+	if (read_sve->vl != vl) {
+		ksft_test_result_fail("Child VL != expected VL %d\n",
+				      read_sve->vl, vl);
+		goto out;
+	}
+
+	/* The kernel may return either SVE or FPSIMD format */
+	switch (read_sve->flags & SVE_PT_REGS_MASK) {
+	case SVE_PT_REGS_FPSIMD:
+		expected_size = SVE_PT_FPSIMD_SIZE(vq, SVE_PT_REGS_FPSIMD);
+		if (read_sve_size < expected_size) {
+			ksft_test_result_fail("Read %d bytes, expected %d\n",
+					      read_sve_size, expected_size);
+			goto out;
+		}
+
+		ret = memcmp(&write_fpsimd, read_buf + SVE_PT_FPSIMD_OFFSET,
+			     sizeof(write_fpsimd));
+		if (ret != 0) {
+			ksft_print_msg("Read FPSIMD data mismatch\n");
+			errors++;
+		}
+		break;
+
+	case SVE_PT_REGS_SVE:
+		expected_size = SVE_PT_SVE_SIZE(vq, SVE_PT_REGS_SVE);
+		if (read_sve_size < expected_size) {
+			ksft_test_result_fail("Read %d bytes, expected %d\n",
+					      read_sve_size, expected_size);
+			goto out;
+		}
+
+		for (i = 0; i < __SVE_NUM_ZREGS; i++) {
+			__uint128_t tmp = 0;
+
+			/*
+			 * Z regs are stored endianness invariant, this won't
+			 * work for big endian
+			 */
+			memcpy(&tmp, read_buf + SVE_PT_SVE_ZREG_OFFSET(vq, i),
+			       sizeof(tmp));
+
+			if (tmp != write_fpsimd.vregs[i]) {
+				ksft_print_msg("Mismatch in FPSIMD for %s VL %u Z%d/V%d\n",
+					       type->name, vl, i, i);
+				errors++;
+			}
+		}
+
+		check_u32(vl, "FPSR", &write_fpsimd.fpsr,
+			  read_buf + SVE_PT_SVE_FPSR_OFFSET(vq), &errors);
+		check_u32(vl, "FPCR", &write_fpsimd.fpcr,
+			  read_buf + SVE_PT_SVE_FPCR_OFFSET(vq), &errors);
+		break;
+	default:
+		ksft_print_msg("Unexpected regs type %d\n",
+			       read_sve->flags & SVE_PT_REGS_MASK);
+		errors++;
+		break;
+	}
+
+	ksft_test_result(errors == 0, "Set FPSIMD, read via SVE for %s VL %u\n",
+			 type->name, vl);
+
+out:
+	free(read_buf);
+}
+
 static int do_parent(pid_t child)
 {
 	int ret = EXIT_FAILURE;
@@ -578,11 +696,14 @@ static int do_parent(pid_t child)
 			if (vl_supported) {
 				ptrace_set_sve_get_sve_data(child, &vec_types[i], vl);
 				ptrace_set_sve_get_fpsimd_data(child, &vec_types[i], vl);
+				ptrace_set_fpsimd_get_sve_data(child, &vec_types[i], vl);
 			} else {
 				ksft_test_result_skip("%s set SVE get SVE for VL %d\n",
 						      vec_types[i].name, vl);
 				ksft_test_result_skip("%s set SVE get FPSIMD for VL %d\n",
 						      vec_types[i].name, vl);
+				ksft_test_result_skip("%s set FPSIMD get SVE for VL %d\n",
+						      vec_types[i].name, vl);
 			}
 		}
 	}
-- 
2.30.2

