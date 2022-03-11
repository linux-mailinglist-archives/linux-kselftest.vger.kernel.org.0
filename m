Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C074D4D629D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Mar 2022 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348994AbiCKNxQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Mar 2022 08:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348989AbiCKNxJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Mar 2022 08:53:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329261C57C5
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 05:52:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C09FB61E0A
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Mar 2022 13:52:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE59C340EE;
        Fri, 11 Mar 2022 13:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647006723;
        bh=kEQALFvVnF2JUNgXMicTSPE1AfxRggwyPGzRYL7rWak=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LBVe9DTpYWpIsSAOZ/w08tlqk44E8xW8p7DbYxifXx+nQRpFYdk+ON2uNtJ826zFd
         AqeTPkECHqhHD95Jn/V9omZpbir/VWXCG4f1KVChICx/TWnVsiXM9fGeozPqW7FtLc
         okeU1M7e9O6CFkfN9oCWSiV7Fx3MO3cjrQvRriVxFzcZSTNYiHUYXTm1QINUXqmqHl
         0aGszBUdi2Bc33QIpmCYnVZHgNoxNXXr3qTgysZdM/Ftry6bGWXYk8iJz6MIUeMlkb
         bQhZ/5AWheUH+1t/4GSHUFRRSvjKIOEMvVpLBFsZa6RYtWsXU0CwIvJStZq1gAZYiW
         uU91JnmkpVM2Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Joey Gouly <joey.gouly@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 2/4] kselftest/arm64: Log unexpected asynchronous MTE faults
Date:   Fri, 11 Mar 2022 13:51:46 +0000
Message-Id: <20220311135148.410366-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311135148.410366-1-broonie@kernel.org>
References: <20220311135148.410366-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1041; h=from:subject; bh=kEQALFvVnF2JUNgXMicTSPE1AfxRggwyPGzRYL7rWak=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiK1PwoXEdRQ7/5KuVtfTwYvHv3UfBHnjTUblpso4O pdkhaOOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYitT8AAKCRAk1otyXVSH0OooB/ 9Xxw+HNPV/Lggv1Dc9e4GRdku0bi80hmkg90+6JN2CLPpnrWr+szi0KntnOVQTvEwG4LB7lGm6RiCs J+/hjP6X1iEydZkkR2vtK0AG4N1TrcSatLZz9LwhGp3NBKhgnEmaSvO3UJFSKORmlLkIJ1/Bz2BuHb Oz/kYN88TaUSe00PLAVzlxb3DurX8U8Y05dhDstAbhbZyDbOzUSQmlhCbVVZN47Be8ZLslYUoHR40R Dcm2p3vf/dOS0Xjf+GqzMMvkJRR3mIHRzKNJgAE7AQLMH5aT/DmTVl3d3RwTFXeHvdpxm+epTZ6niR /3JaecvlCDCp1XPsyHsJeRwlgaRRxn
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

Help people figure out problems by printing a diagnostic when we get an
unexpected asynchronous fault.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/mte/mte_common_util.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/arm64/mte/mte_common_util.c b/tools/testing/selftests/arm64/mte/mte_common_util.c
index 0328a1e08f65..5327aa958171 100644
--- a/tools/testing/selftests/arm64/mte/mte_common_util.c
+++ b/tools/testing/selftests/arm64/mte/mte_common_util.c
@@ -37,6 +37,10 @@ void mte_default_handler(int signum, siginfo_t *si, void *uc)
 		if (si->si_code == SEGV_MTEAERR) {
 			if (cur_mte_cxt.trig_si_code == si->si_code)
 				cur_mte_cxt.fault_valid = true;
+			else
+				ksft_print_msg("Got unexpected SEGV_MTEAERR at pc=$lx, fault addr=%lx\n",
+					       ((ucontext_t *)uc)->uc_mcontext.pc,
+					       addr);
 			return;
 		}
 		/* Compare the context for precise error */
-- 
2.30.2

