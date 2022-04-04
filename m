Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5404F11A5
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Apr 2022 11:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347958AbiDDJI1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Apr 2022 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244472AbiDDJIZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Apr 2022 05:08:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F93B01F
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 02:06:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E3DB80A29
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Apr 2022 09:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D88C340F3;
        Mon,  4 Apr 2022 09:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649063187;
        bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BJGod9ZA8tWmPgrlmYbxPCt70Ze/NW5aw5mLQpEM6fkB2i4SyThfh03X+cQvz9Djn
         RgwPPMRvRqb1mU1+EZR2KJUChxqIw7od6ASPZRE2EiOIQy3qZ94ymhS0pgrTOUBCPP
         R9wUfLPVsIIsx7L97xFG7wjnogMTuydmkOnr/+z3x49AtTin879SZ6m2yhvpYG2dVG
         rZS1x8dYiZrAG0vMWnAeGhLd1DTqW6uDnWOiB//hHJ6ca0abQ52Q/NqdCnX7H4kF4R
         iUWcp29md5XbE8kTPXgu6QyqXte+nRJXh9D/9UAW4z74DVHzDyjAloKElFpcxLwjxc
         KlgOVPz+u4Ulg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] kselftest/arm64: Fix comment for ptrace_sve_get_fpsimd_data()
Date:   Mon,  4 Apr 2022 10:06:11 +0100
Message-Id: <20220404090613.181272-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404090613.181272-1-broonie@kernel.org>
References: <20220404090613.181272-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=947; h=from:subject; bh=8vVvI2qZ+WS2PpGgoEgf6Xhiefrm6qpFKgw1EK5Sp1U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiSrUAO+w0M52wR5OGcu7Rb9aMmx7Vhd+DLVQSaszX 8TQxkxaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYkq1AAAKCRAk1otyXVSH0G9gB/ 0WaFJ3qS5yRT+KGo662sL7pUHtaJaYDRxATCFDfeGl5s5TiOvlXskz8L8eE5smmIYtQuMb1NDi0hTI ChSdeK9xHZlftnoZiKAmaVpYDR4pzHaBc+hGTIrrpW5f8w2OoqRFCEycESmDZqBKBizWq6h3f/d2o4 j9sZ4BG0J4SlXzH38L5n0GNq86jpbFwunEO55ADwUM1iZhO0/QBRjDuha70W7vaUgwbKLD0+9+WYzR kAN94NxC0t/pwODpjp4oAq26zuv8F+kHmNBqx/m4Y5620bMmSByfh2R0iJptzdT1EYB1BqHdjIxqpp Pke/9CnB+porkbmg01KEkt4qVQk1Lh
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

The comment for ptrace_sve_get_fpsimd_data() doesn't describe what the test
does at all, fix that.

Signed-off-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 4c418b2021e0..7682798adbba 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -395,7 +395,7 @@ static void ptrace_set_sve_get_sve_data(pid_t child,
 	free(write_buf);
 }
 
-/* Validate attempting to set SVE data and read SVE data */
+/* Validate attempting to set SVE data and read it via the FPSIMD regset */
 static void ptrace_set_sve_get_fpsimd_data(pid_t child,
 					   const struct vec_type *type,
 					   unsigned int vl)
-- 
2.30.2

