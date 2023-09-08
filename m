Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E9798C06
	for <lists+linux-kselftest@lfdr.de>; Fri,  8 Sep 2023 20:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241807AbjIHSDj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Sep 2023 14:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343506AbjIHSDb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Sep 2023 14:03:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148DF1FF5;
        Fri,  8 Sep 2023 11:03:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4925FC433AB;
        Fri,  8 Sep 2023 18:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196102;
        bh=HA0290nYjJTra1Fa8i+NOPy4ak9llenwVNo887t/S40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeBTmy00faU4riUxisebRZ3nMkvolQUB6/N9OQeiBYa6ZxdU8yr/BhIVTEdDF/maM
         L14ZZjs282eK0w1VR2b5FvLR1pvOldZvXMgkZiolQe+bN4rTu4qygD+rpeipn9g4i0
         pLPxo46rFpyGawvk4NDhLw20UwAn5UdDYucMRXu1yWHs8+ie7CSsg6cMG/G196sG+Z
         C0+ucHBrJI2h73Q1F9fF/GgA86peurjw8fjH/LU8yjdYGaCiXXwhSHbRmRG/+JUm2c
         gnfra+ftxU4S9oYuCXhc3W81DU020OoFTrBpHOlAWanf8F88zW3M1uX78FVsHUen4r
         iblv2xr6RC6fw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        catalin.marinas@arm.com, shuah@kernel.org, broonie@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 08/13] kselftest/arm64: fix a memleak in zt_regs_run()
Date:   Fri,  8 Sep 2023 14:00:54 -0400
Message-Id: <20230908180100.3458151-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908180100.3458151-1-sashal@kernel.org>
References: <20230908180100.3458151-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

[ Upstream commit 46862da15e37efedb7d2d21e167f506c0b533772 ]

If memcmp() does not return 0, "zeros" need to be freed to prevent memleak

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20230815074915.245528-1-dingxiang@cmss.chinamobile.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/zt_regs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
index e1eb4d5c027ab..2e384d731618b 100644
--- a/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
+++ b/tools/testing/selftests/arm64/signal/testcases/zt_regs.c
@@ -65,6 +65,7 @@ int zt_regs_run(struct tdescr *td, siginfo_t *si, ucontext_t *uc)
 	if (memcmp(zeros, (char *)zt + ZT_SIG_REGS_OFFSET,
 		   ZT_SIG_REGS_SIZE(zt->nregs)) != 0) {
 		fprintf(stderr, "ZT data invalid\n");
+		free(zeros);
 		return 1;
 	}
 
-- 
2.40.1

