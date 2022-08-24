Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FDE5A0437
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Aug 2022 00:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiHXWlS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Aug 2022 18:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiHXWlR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Aug 2022 18:41:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C2E58509
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 15:41:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DBAA2B826C1
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Aug 2022 22:41:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0621C433D6;
        Wed, 24 Aug 2022 22:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661380873;
        bh=KfVlzOQlsOOXomrl6+5uPthoSzbh44msbvZsSDxvUNI=;
        h=From:To:Cc:Subject:Date:From;
        b=dpvEnodEvFV0fZ6jw7jKbkw7iaa4Gc/CrjQxcVwmW0xU14i3S90k4E7brDdYJUuJW
         pLd60j0FyESuFwKcg7SNCt9AHabpPwni8o2w+DuLPToADnOxxizu3ZEqxU+rrB23rE
         +PWOYG2Oic950RHQVksPzhXOczxvydc+tdP7rlqOxQMNI7lRawMQ8ds3viBGZ4rrZk
         SiX+wR2tqE3dTaxOPUhWpYWZm/13pp0Qyylf4npDzGpmuNO4rTnOrsFGF/gJyuFShW
         VAaIFZmeGqjxL9RHRQX4rMPaeiCtg3GYAA9Kq8+m1P0SRKWauJYhaw8IUhirE6C/HP
         LS/UAnkeNfvXA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 0/2] kselftest/arm64: Small improvements to ZA signal handling coverag
Date:   Wed, 24 Aug 2022 23:40:24 +0100
Message-Id: <20220824224026.848932-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=655; i=broonie@kernel.org; h=from:subject; bh=KfVlzOQlsOOXomrl6+5uPthoSzbh44msbvZsSDxvUNI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjBqjXjQ/4/ia4qc29WEIJiYfFxAst7KmUa+YsiTBe gl5T4OuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwao1wAKCRAk1otyXVSH0HOeB/ 4jdZp3pF3eSAw5hQK2EAZdv+vFhpCnennsWzXXl4WnQaPSR5e8TYkiuqqf1oE/nVHypZjc6n2s32/R 7O8cJ4s81Al92wZy23WWfeCqiZiYX5m/ZzO5u7msk4erHn69vV+4a757F5N5sKia8VUwzpC7YzFfJH KqwF3z0kgenVJOliiXGOrdol+iI6An5k3sWS5XSqmTnycrF4nByxvtmUb/nIY6lZV7Uw35Je7Xf0zp O9uyyY/aDRcP/RVliziNImJKgGjkqTx52VC/+QgXUPr+FQVcap04OJ4FFILqZoEHL8pHW77pDpMLHY eaKfLCJBJAQMOzXb2bfkTvYshjodlS
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

These patches improve the coverage of ZA signal contexts a bit, adding
some validation that the actual data is correct and covering the case
where ZA is not enabled.

Mark Brown (2):
  kselftest/arm64: Tighten up validation of ZA signal context
  kselftest/arm64: Add a test for signal frames with ZA disabled

 .../arm64/signal/testcases/za_no_regs.c       | 119 ++++++++++++++++++
 .../arm64/signal/testcases/za_regs.c          |  16 ++-
 2 files changed, 134 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/signal/testcases/za_no_regs.c


base-commit: 568035b01cfb107af8d2e4bd2fb9aea22cf5b868
-- 
2.30.2

