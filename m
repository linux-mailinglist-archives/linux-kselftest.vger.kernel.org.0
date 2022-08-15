Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB91592FF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbiHONbX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242920AbiHONa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:30:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2A62BED
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:30:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B6BC60EC2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6655C4347C;
        Mon, 15 Aug 2022 13:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570254;
        bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dY/cBhPC+c5vFAssvIgKf4Nx+W3fnS6xlFy26PRoI0dxOgyT3RUCvh2P+y4zej/c2
         ZB5gCh+jIvpd0aH+UV5+Xoq6VMph4mPF4pNuVuGaaI5/abt7BZwOuY25xN85ASS8uQ
         uLYRdxG2AJnl/re1AYaY+znKLZ5knGS8KvImw7qKkT+g1x4IDsBCdqSQ4/Wj3PaSB3
         Kl4c2Pvf0nyYjffvC2pzWPlXcJivjA7XMhvKnjoYVsRAVm5KqKZxNm0yHfniVWhSbv
         gQzaTSIPormeLaxx/hiSNRzTbuTs9+dvSSY9sU+/g3lQE5YA32IDxpbOmFjvfPaIkz
         haoNK3FsXGd0A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/4] arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
Date:   Mon, 15 Aug 2022 14:30:32 +0100
Message-Id: <20220815133034.231718-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133034.231718-1-broonie@kernel.org>
References: <20220815133034.231718-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; i=broonie@kernel.org; h=from:subject; bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kp4G54LoL/yWs5q4ClkhlcssbMavyJEG2YIqqRj 7oMMUOKJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpKeAAKCRAk1otyXVSH0IXlB/ 9WeX1dRtDY/BNys1kbhOkU+wPPZygwmkIR+Zkfom+7oLfFtsSZqUWJQVFwb4fnkay3CSLE8R9Oyym7 GnXFqSiWafDJ+hjU/i+XfH/2EGmNcgVPZVuAdIa7wKtoTDfuyx9rGQaVvit50vHwoeU+VLKKHzim09 s6xL8OIajCw13JoSx1tfgq/oFezIrRoQTvIAzCae7ZBN22jz+Oh1IAGBqFGKoG/HEkPTOVS8dxWY8X T6KeVHfdzNnaa+iG31O3TEt2On8AAi4C75L5XqvKhwcwbJJwhZFLt+r0EcosRZO6C3TjWjAQ1txWSc 5lljqu1DG6XJoONBN4FWcRr828jyKB
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

