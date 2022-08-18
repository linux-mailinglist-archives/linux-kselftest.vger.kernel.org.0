Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1725989F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Aug 2022 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345401AbiHRRHY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Aug 2022 13:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbiHRRF2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Aug 2022 13:05:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54C5CD506
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 10:01:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EAFB616D2
        for <linux-kselftest@vger.kernel.org>; Thu, 18 Aug 2022 17:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7816DC433D6;
        Thu, 18 Aug 2022 17:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660842117;
        bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q97AzCFYBMA7iQeS+U6HEnU7FliQDvF7L5Kw0Y6XfRUzVKNB7H7gp6KMBkpftKDqU
         AUkma6yYyRAtEjmQWU9LBwD0HOLSnJR0LQEAyAvfBzsUlbZVrdIg4DOS2XXjNE91UQ
         eU6NkUWdRCZOLLvuqWvCH8hpRdaAeNbp0qjbU81EmrDJr+4kZsF7Uh8uETxPBg+cL3
         6j68lDEreppkv8pxKl4FymI/YM3NUVbpkOJ0iheyxr6wfEYjbTUDO8JSX585K3x3xq
         AiDj7uCJiy8QAAjT2UwGquG0qaqfO7PtRSMDO7u81fgtIxo8GT1nwCSW8C1E1RuVnm
         ismJquYiVzN3A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/4] arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
Date:   Thu, 18 Aug 2022 18:01:09 +0100
Message-Id: <20220818170111.351889-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220818170111.351889-1-broonie@kernel.org>
References: <20220818170111.351889-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=broonie@kernel.org; h=from:subject; bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi/nBUG54LoL/yWs5q4ClkhlcssbMavyJEG2YIqqRj 7oMMUOKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYv5wVAAKCRAk1otyXVSH0HHLB/ 9Kh4cwNJM4bg3HtqTlqPr/DTTwEh5IVptnLGPWYuA+fb7C4FlQ/KwkHeyZncDbkwzaX3wJ8uTtJKRk 1wWJWLWGk/Mppa8UQ7YMogLtp6HIi5rq/Gb87usuVfGRVePQhRHY43oIYGl585rUPCpwKC15xZmT8O K6LYm7T0ffn1TVEt5+3OgKM5W69WZRr7s+i9s4eOnQMX1zVPO1cN2j0wbBiW6q71+iuDt8y0ts4sMm mPvBB1m6+mVKeVd3n44sq7Fpej3KZDJOaIElwDW7XGc7MosrLeabfjzWVO+sWlLtbNgqraqvqykXgb 0wfSkJC597nmyMCc/TML726SONhElC
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

In order to allow debuggers to discover lazily saved SME state we need
to provide access to TPIDR2_EL0, we will extend the existing NT_ARM_TLS
used for TPIDR to also include TPIDR2_EL0 as the second register in the
regset.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/arm64/sme.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/arm64/sme.rst b/Documentation/arm64/sme.rst
index 937147f58cc5..16d2db4c2e2e 100644
--- a/Documentation/arm64/sme.rst
+++ b/Documentation/arm64/sme.rst
@@ -331,6 +331,9 @@ The regset data starts with struct user_za_header, containing:
   been read if a PTRACE_GETREGSET of NT_ARM_ZA were executed for each thread
   when the coredump was generated.
 
+* The NT_ARM_TLS note will be extended to two registers, the second register
+  will contain TPIDR2_EL0 on systems that support SME and will be read as
+  zero with writes ignored otherwise.
 
 9.  System runtime configuration
 --------------------------------
-- 
2.30.2

