Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8DD656B3A
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Dec 2022 14:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbiL0NHX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Dec 2022 08:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbiL0NHB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Dec 2022 08:07:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D4277;
        Tue, 27 Dec 2022 05:07:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1D06115E;
        Tue, 27 Dec 2022 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76D62C43392;
        Tue, 27 Dec 2022 13:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672146419;
        bh=ftKw9JxdN7OkfKbeAVWrxvHtpZk1v1+kLM5uE4WBFzg=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=J9jBpf7YpIT/KUPBfiL0ijOMl3up/EqOTWovYRw6AiDyR7ZiTWaN/IZV4HsfbVAj8
         GNrb0VSw3cJAsithpiUHhWeGY+yeBW0hzhbOL3zdgOFSE0G56hqwnD7JHIqfnyXV0o
         OSzveBmxCUQGzT2OSV9PGd7WnGt0otzMVFg5ywu0gHNFX7IVkGKRPgsQSEyxeEskKO
         lFydyFgMn7Fsiy81AsVE+Tcpf8Mg/xBP69hYNlO8h8seZAnLBnYNWPR9i6E/XkXyGh
         8hcMH+OhpXF7SjazH1HYRm5yHGJNNxDN17oeC3H/JknK8zltzkb+1JQ67GK+/t4Oxc
         FEIRKZsi3nUuQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Tue, 27 Dec 2022 13:06:38 +0000
Subject: [PATCH 4/4] kselftest/arm64: Only enumerate power of two VLs in syscall-abi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221223-arm64-syscall-abi-sme-only-v1-4-4fabfbd62087@kernel.org>
References: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
In-Reply-To: <20221223-arm64-syscall-abi-sme-only-v1-0-4fabfbd62087@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-7ab1d
X-Developer-Signature: v=1; a=openpgp-sha256; l=2013; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ftKw9JxdN7OkfKbeAVWrxvHtpZk1v1+kLM5uE4WBFzg=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjqu3oGR4UZqgD9m8L8fGlfTnGhEn85EVEwGm03O0/
 uGhK1kCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY6rt6AAKCRAk1otyXVSH0GAxB/
 0UF4ItAsSeRKn4TpESZ/DpfbOEkcF+ZzIdEuMKfESo072yQk+0JjHZulbv6n7to3jH5QfL1oJrvquA
 q4U/L7nbAOgaVe5C+9VYu4LDxNnfE7f9zmtCrT/9FrZTF+ZGxVpcerEcZ+nVWGYPWrOEKKQCDDaWf0
 h3DMQXbxveAaw/7DmCZxddZ3joC9VaoJaoxi9bcwwkd74tlpJAFRfiqlQ7vlX5z616Tl9gF562mAyC
 gAFVzJNTHKpRCE9J8PUzIOn0vteUImFQpCNFhjR60qeL59MkOscmVYIJlnPfLOmRkn9GLffkxIZNhs
 jA0at65HqbaaqP3U7u7NQTcp7Cjjmk
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

As documented in issue C215 in the known issues list for DDI0487I.a [1] Arm
will be making a retroactive change to SVE to remove the possibility of
selecting non power of two vector lengths. This has no impact on existing
physical implementations but most virtual implementations have implemented
the full range of permissible vector lengths.

Since virtual implementations are noticeably slow in general and the larger
vector lengths amplify the issue there's a useful improvement in runtime
from only covering the vector lengths that will exist in practical systems,
adjust our enumeration accordingly. We have other tests that aim to cover
the enumeration interfaces.

For symmetry we apply the same change to the eumeration for SME vector
lengths, though the power of two restriction was already present for SME
so there is no impact on the set of vector lengths tested.

[1] https://developer.arm.com/documentation/102105/ia-00/

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index 7c9b6e947040..8afcbf6861fd 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -444,7 +444,7 @@ void sve_count_vls(void)
 	/*
 	 * Enumerate up to SVE_VQ_MAX vector lengths
 	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+	for (vq = SVE_VQ_MAX; vq > 0; vq /= 2) {
 		vl = prctl(PR_SVE_SET_VL, vq * 16);
 		if (vl == -1)
 			ksft_exit_fail_msg("PR_SVE_SET_VL failed: %s (%d)\n",
@@ -470,7 +470,7 @@ void sme_count_vls(void)
 	/*
 	 * Enumerate up to SVE_VQ_MAX vector lengths
 	 */
-	for (vq = SVE_VQ_MAX; vq > 0; --vq) {
+	for (vq = SVE_VQ_MAX; vq > 0; vq /= 2) {
 		vl = prctl(PR_SME_SET_VL, vq * 16);
 		if (vl == -1)
 			ksft_exit_fail_msg("PR_SME_SET_VL failed: %s (%d)\n",

-- 
2.30.2
