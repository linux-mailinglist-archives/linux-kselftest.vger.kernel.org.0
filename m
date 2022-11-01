Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E229614CD9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiKAOj4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKAOjz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C91D12AFF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0981B615AF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB67C43470;
        Tue,  1 Nov 2022 14:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313593;
        bh=zqkOAhenCAUz/pr+kao3s+tImHaUhiiOv81se6Arx3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L+S42iIJapDuL1XrNcnuA2MA7YtDcnIlSZvsg5AorrJbEb5xUo8M6Am+DGVwaUX6C
         cVM+Y4VlAL89bXckn/nqLNN0fnP8rLlZf9K1wXznLdhnDwfKBme8rVoLtk0s9sSPLT
         2JoPZzFBs0qPikAFvCN4iOi5LKPB6NnFL6S0n6GtD8lDm8cK7nmp2AQC0PrOzU1IeB
         aQshaOvL1zOewgeLM7g/bO0z16PRLxn/Ro79mxO2+nfAjZFD9LZ9yAlN1PfmcSNy0R
         1vOK7inrdAsNseJZr2chm0AqzgF5Du+VMwNnXiOm3QwXVH+YS8bIrmKsACzBUkDp7e
         4b9YyxQevKHYA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 15/21] kselftest/arm64: Cover ZT in the FP stress test
Date:   Tue,  1 Nov 2022 14:33:30 +0000
Message-Id: <20221101143336.254445-16-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=broonie@kernel.org; h=from:subject; bh=zqkOAhenCAUz/pr+kao3s+tImHaUhiiOv81se6Arx3U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS44kTT9WgLFS1V0pEZsK+z22NxdqOJDGueqkO+F 4kFPcaqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuOAAKCRAk1otyXVSH0CuUB/ 45oX7TIICnH5JmXWqrZtA9rn+rG6cp4FRhnren2at2GpygqQQv5Ul23Rk3V/JGR0lLZe+KLzofN7GW sAFr9rKM8DJgBPDpfjLhv5OFcUB2EMRSzO48V/D0D6kovvRZrBvH8rb5Udkr7wbaJgPFt15/70viA4 Nda2n6cTCKuEpSscxxxCxObxZ7e48ogyjMPJaKxAXi21I8XIxt1Jb+ID49Vnlfcrf7wqKnt+axvZrq 3pJFi72yJ5lZu0lcmyLZFMZntPU0AvbffHB7AIWyIDtxrmTz7JwyxSp0mcljVLWMVBY7LWW5Lldp0Y 0yYbT0MiGjLhu00fyN70YBFAVHIepE
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hook up the newly added zt-test program in the FPSIMD stress tests, start
a copy per CPU when SME2 is supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/fp-stress.c | 29 ++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
index 4e62a9199f97..7f4eef8717ad 100644
--- a/tools/testing/selftests/arm64/fp/fp-stress.c
+++ b/tools/testing/selftests/arm64/fp/fp-stress.c
@@ -350,6 +350,19 @@ static void start_za(struct child_data *child, int vl, int cpu)
 	ksft_print_msg("Started %s\n", child->name);
 }
 
+static void start_zt(struct child_data *child, int cpu)
+{
+	int ret;
+
+	child_start(child, "./zt-test");
+
+	ret = asprintf(&child->name, "ZT-%d", cpu);
+	if (ret == -1)
+		ksft_exit_fail_msg("asprintf() failed\n");
+
+	ksft_print_msg("Started %s\n", child->name);
+}
+
 static void probe_vls(int vls[], int *vl_count, int set_vl)
 {
 	unsigned int vq;
@@ -404,6 +417,7 @@ int main(int argc, char **argv)
 	int cpus, tests, i, j, c;
 	int sve_vl_count, sme_vl_count, fpsimd_per_cpu;
 	int sve_vls[MAX_VLS], sme_vls[MAX_VLS];
+	bool have_sme2;
 	struct epoll_event ev;
 	struct sigaction sa;
 
@@ -437,6 +451,13 @@ int main(int argc, char **argv)
 		sme_vl_count = 0;
 	}
 
+	if (getauxval(AT_HWCAP2) & HWCAP2_SME2) {
+		tests += cpus;
+		have_sme2 = true;
+	} else {
+		have_sme2 = false;
+	}
+
 	/* Force context switching if we only have FPSIMD */
 	if (!sve_vl_count && !sme_vl_count)
 		fpsimd_per_cpu = 2;
@@ -447,8 +468,9 @@ int main(int argc, char **argv)
 	ksft_print_header();
 	ksft_set_plan(tests);
 
-	ksft_print_msg("%d CPUs, %d SVE VLs, %d SME VLs\n",
-		       cpus, sve_vl_count, sme_vl_count);
+	ksft_print_msg("%d CPUs, %d SVE VLs, %d SME VLs, SME2 %s\n",
+		       cpus, sve_vl_count, sme_vl_count,
+		       have_sme2 ? "present" : "absent");
 
 	if (timeout > 0)
 		ksft_print_msg("Will run for %ds\n", timeout);
@@ -495,6 +517,9 @@ int main(int argc, char **argv)
 			start_ssve(&children[num_children++], sme_vls[j], i);
 			start_za(&children[num_children++], sme_vls[j], i);
 		}
+
+		if (have_sme2)
+			start_zt(&children[num_children++], i);
 	}
 
 	for (;;) {
-- 
2.30.2

