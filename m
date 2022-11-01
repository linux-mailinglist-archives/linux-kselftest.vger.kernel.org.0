Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43496614CCC
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKAOj1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiKAOjW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:39:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3471C426
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47EB06119B
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:39:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F10C433C1;
        Tue,  1 Nov 2022 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313559;
        bh=2WtYkfyqwfbzmrCrdKWnq9io6zKV9H6MzPUD6asynbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wv4/yPK38kS6nMQN1rM9p5TgvQzvuq3eZuWNPrvL1bwTex894/QuqmO7PhaIc+/Vd
         W+ePc5eNtCdApA7RxZt4Tp6N+62MuUz5qu4tUSP7Z+Qu9DZE/zaG1phzfzKRAEsJxC
         EC/IQvEGTmoQjayyzXL3SH3+ohXJFyh8brj/snBhQmtiFmkj4594KAA8gCOktlJKVO
         Hw1s25ETia2aqInEvPxytkS+ZzUsqu8UVbJW/0+hKP0FtmfAEh1LOFFys0sHUqMt8d
         q1+lBhS+NHiC8sBum0t7FVoCIJACJzlFqDkoJoKzuKDf61CN/igy4IDJLYcqGbjWgx
         tOcBcXi4SB0VA==
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
Subject: [PATCH v2 02/21] arm64: Document boot requirements for SME 2
Date:   Tue,  1 Nov 2022 14:33:17 +0000
Message-Id: <20221101143336.254445-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=broonie@kernel.org; h=from:subject; bh=2WtYkfyqwfbzmrCrdKWnq9io6zKV9H6MzPUD6asynbg=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4qp/fnXI1ilfvmmnP6CxO7mMM9nfvM50hdIBdv A9TAH9+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuKgAKCRAk1otyXVSH0JiAB/ 9qBpKYFVHc8N/HI97CrKsnIMV9crK/IwLfzQV9lRi1wga7R8XDz1t5SEHKeurO9qxM5bvsVSEEpyWW 0wh4lZBlF3o2YdGb78jXFO88NHRLE9vzuLjpQCY2gDznAgr5Sg6tcISCVlH0JcJ1X1VXKV/sxrVlXX Ccov8AV27IF/2qkVKwELA1UMyMKc37bN+dOvzPTkWnK3gowKE30GRTfqBgyz1aAyE97O4pIrJ5gfBC cGDzNaP1TcjCT3874qWc+xECBhj7CjZRB0AZfZLFoAefflzvCl4SZK2Kjcqmr/Pw7xKzkBmk+u24et ZepAW2xhR/CNAeTunmKk+Utn7KRHS9
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

SME 2 introduces the new ZT0 register, we require that access to this
reigster is not trapped when we identify that the feature is supported.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/booting.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/arm64/booting.rst b/Documentation/arm64/booting.rst
index 8aefa1001ae5..b69b5cb596e6 100644
--- a/Documentation/arm64/booting.rst
+++ b/Documentation/arm64/booting.rst
@@ -360,6 +360,16 @@ Before jumping into the kernel, the following conditions must be met:
 
     - HCR_EL2.ATA (bit 56) must be initialised to 0b1.
 
+  For CPUs with the Scalable Matrix Extension version 2 (FEAT_SME2):
+
+  - If EL3 is present:
+
+    - SMCR_EL3.EZT0 (bit 30) must be initialised to 0b1.
+
+ - If the kernel is entered at EL1 and EL2 is present:
+
+    - SMCR_EL2.EZT0 (bit 30) must be initialised to 0b1.
+
 The requirements described above for CPU mode, caches, MMUs, architected
 timers, coherency and system registers apply to all CPUs.  All CPUs must
 enter the kernel in the same exception level.  Where the values documented
-- 
2.30.2

