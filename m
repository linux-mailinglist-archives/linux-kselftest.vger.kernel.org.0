Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7ED360F5DD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 13:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbiJ0LDk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 07:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235086AbiJ0LDi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 07:03:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D779D57C9
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 04:03:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 38BE7B8258D
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Oct 2022 11:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1F5C433C1;
        Thu, 27 Oct 2022 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666868614;
        bh=+MR8sGo3C7Y3vD7WR21Lx+9dzQLDtvOgxHYrjYziRbs=;
        h=From:To:Cc:Subject:Date:From;
        b=BRjCgWsuT+tB4X3w4CzOg3LEpCXN/n3McisMXnqFzCH+cc9zuYccQjVGpsVPFITcV
         MbhZLWeNLwjm6pYCm+jgYQEBa6/liddt84ZhpeEB8Ry8SZeSegOK8EtG1vTagYsgFp
         /NWsHoBLHg4stC0oXFjLn9PJ9x1JvzieX1BjlLkqBkoxdTn8kNEFgd7395+Fv6rfWh
         J8fppoR/L+QMDPa0Jp1+qf5L3dcr20M4/8pIIYmpisqeTaXFhAJMk4lybeJAA7PeLa
         x4/TZuWV1856Q/cJCkkgxy1FRxECNkZRRwvayQw+87/exoldKJANqZBQfA6j0Fp7Uy
         MGEzFS1o3d5mQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1] kselftest/arm64: Remove validation of extra_context from TODO
Date:   Thu, 27 Oct 2022 12:03:24 +0100
Message-Id: <20221027110324.33802-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=843; i=broonie@kernel.org; h=from:subject; bh=+MR8sGo3C7Y3vD7WR21Lx+9dzQLDtvOgxHYrjYziRbs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjWmV7vxx04jCqHyclcxx7Z5Z48WOFuyQ25uGZVIDQ syXltMOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY1plewAKCRAk1otyXVSH0IuUB/ 9YHL7JJr2j1JNAULAzINyQP4gMOABLqK/RaFLybgPGrAo97rLx+TSwSdUSqblKkAfuL3Pu1npL0K9C H+2DIsGsZn7bkL7CowFBj/QYM5Dsrp6PE30FwObP1hatuv8xJpJyvg6snHydr2SBWjv7tlabUO/Oka OZbTH8S7MLmpcvSd4v9bDrvmr6s1ZbRBezYkYb/42YXqwLD3E9TzAgWJzHa7oIskAHJTaF4hcvFLUT 3Zlu7PjUTMGuKqe5TK/2df0HQTnws5uZ7Xlj4NK6KL0NHyXcRiYiZr7uP0aNvuAlXF2NA2th01IXYC BYCX/9rbWXwyXlFMnDe8WYt3fxk3QW
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When fixing up support for extra_context in the signal handling tests I
didn't notice that there is a TODO file in the directory which lists this
as a thing to be done. Since it's been done remove it from the list.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/TODO b/tools/testing/selftests/arm64/signal/testcases/TODO
index 110ff9fd195d..1f7fba8194fe 100644
--- a/tools/testing/selftests/arm64/signal/testcases/TODO
+++ b/tools/testing/selftests/arm64/signal/testcases/TODO
@@ -1,2 +1 @@
 - Validate that register contents are saved and restored as expected.
-- Support and validate extra_context.

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.30.2

