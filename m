Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40B592FFA
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242234AbiHONdS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiHONc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66ECD17053
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:32:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00FA860EC3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:32:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC049C43470;
        Mon, 15 Aug 2022 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570375;
        bh=OEluHX2rINw79r1ixw5NAaWYr6eeAln8ZyuAwVaM4PU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FqjpqSdtvTVR00WtioVTRz5w/dnUqxr+tjd9LZ2lSuHIdHFgGxhp8kxhjAbMc+UIS
         RRHYBBHJKbh2vZOVwjuxcwP3OvEE5CJuRRE1XcphY7aCVU8ZV9d3TqZjgO9cyta0DP
         wpFyizqH3vVy7UWSPeq3D3HbSV+lqzvAf29ru6U0JErenhdHQDr6/u6zKINM0r9E3b
         L+dV24zCOysKUIWlJveydO4P4hOVKliUddsiu53/ryrHNqEvfsTVs4EIRn0pPeFTBM
         xWJK8OhfAOCJ/qRHOt7NVLDELfLuJcYNcxcI4ysz3sEpmtiTjXTWoZCEIjBbO7zh0m
         J5NI2ThtI1asQ==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 04/10] kselftest/arm64: Fix validation of EXTRA_CONTEXT signal context location
Date:   Mon, 15 Aug 2022 14:32:30 +0100
Message-Id: <20220815133236.235464-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133236.235464-1-broonie@kernel.org>
References: <20220815133236.235464-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1431; i=broonie@kernel.org; h=from:subject; bh=OEluHX2rINw79r1ixw5NAaWYr6eeAln8ZyuAwVaM4PU=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kru53ACy+qtRh8Sc/w53mW6y7ChJCJBs5P7thFO wOL9vv+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpK7gAKCRAk1otyXVSH0NIuB/ 0aTbFeU+6+7i0uom74XxllgBVR1jaf2adLdxxjq9sFkVP/mwEn3dcjTcX0pVk0HDRN0DoIKDHlyj8s AN8iCu4tSc1Xu1O5k5iyi01PDfTBc0NL4/de/agnPCWmVittKaZmG7rO4j7WWkP+HTmb7kaSQSF7Qh Mzp8lRSsn16zenytVTG7IpxDCnqEjK/rwXv5otETzrS2z9yZZ3R5ZGQQfyVMFLDDpsrdWzK7ebF45q 5xypYIGgABWqureil5VhROjWZ+RG+uBps0ifi+4/biHGLf87leMwDQl0+0fPsAMj2Q9k36iWWcyENA 1sPLBZ7not5WRTFRBd2NVc94Qa6K7T
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

Currently in validate_extra_context() we assert both that the extra data
pointed to by the EXTRA_CONTEXT is 16 byte aligned and that it immediately
follows the struct _aarch64_ctx providing the terminator for the linked
list of contexts in the signal frame. Since struct _aarch64_ctx is an 8
byte structure which must be 16 byte aligned these cannot both be true. As
documented in sigcontext.h and implemented by the kernel the extra data
should be at the next 16 byte aligned address after the terminator so fix
the validation to match.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/signal/testcases/testcases.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/testcases/testcases.c b/tools/testing/selftests/arm64/signal/testcases/testcases.c
index d98828cb542b..16dc916939f9 100644
--- a/tools/testing/selftests/arm64/signal/testcases/testcases.c
+++ b/tools/testing/selftests/arm64/signal/testcases/testcases.c
@@ -42,7 +42,7 @@ bool validate_extra_context(struct extra_context *extra, char **err)
 		*err = "Extra DATAP misaligned";
 	else if (extra->size & 0x0fUL)
 		*err = "Extra SIZE misaligned";
-	else if (extra->datap != (uint64_t)term + sizeof(*term))
+	else if (extra->datap != (uint64_t)term + 0x10UL)
 		*err = "Extra DATAP misplaced (not contiguous)";
 	if (*err)
 		return false;
-- 
2.30.2

