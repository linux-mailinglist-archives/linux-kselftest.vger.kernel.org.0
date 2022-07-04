Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEC2565D6B
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Jul 2022 20:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233539AbiGDSO6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Jul 2022 14:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGDSO6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Jul 2022 14:14:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9376FB863
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 11:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48F90B811E0
        for <linux-kselftest@vger.kernel.org>; Mon,  4 Jul 2022 18:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202DDC341CF;
        Mon,  4 Jul 2022 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656958495;
        bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CW9jp+YMe6eY7y4NoxXDNeuZ4GNIRLulJ1I93h8VUfKI3cOD1e2P3ov+vCkGvkt96
         3X5KEJXwCb05GHAG1JKS8MU0qA9bb1L0A+iKfNDkK3Eyyy7dWihLRSTfmc7MbKQrGj
         +HojrmvmTfC546E6ZIXP88gsH6j3jl0X3cKdD/y9+rLr83mNiP0KEPLR8OGo973F7b
         bGtE3iEkCYc0UPs/r9KuceOzVqguTzGE70DhDwSc61wGRb5PxtoiWA4I+/dPorVTpZ
         rJ2abVuZwBR2eCX5U7xKrHAhhTPSwIiLBGT0P6ebE+jd2nHWRSM2iy/rRjLvX74CI+
         cKpdn0eAr1svw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 2/4] arm64/ptrace: Document extension of NT_ARM_TLS to cover TPIDR2_EL0
Date:   Mon,  4 Jul 2022 19:13:30 +0100
Message-Id: <20220704181332.3318214-3-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220704181332.3318214-1-broonie@kernel.org>
References: <20220704181332.3318214-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1023; h=from:subject; bh=4SS1HhiCCSG9y1tYIhTUgiCAE3c544P3f86asq/gm0U=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBiwy3KjoHA7nfaC+35Gif2a+0nlfbRiTju6t1wdb9X jyFWDcOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYsMtygAKCRAk1otyXVSH0B8+CA CDbpf/pnNRu1N1AfwGh+sKz1lY2Wb4IWG2kDZcUVVQpvowa/GPGXO87G3EJckwvJcyF0SwGrwyTbxW 1z0sdJRY80MogwewBjWVPs+o+03yDDEL5Q4mJ2hSuWqxBLL9NXQaD+2G0ecJ1N+r71Em5PwVnBAs0c wqb1E5/SvE1OqM3TSVOtCyNof+XhFq3W8unnGYZ0G+rUdkAVm4DB1LYbTrAO8+N/WnVKQ83dqzL6qu 3XIA/V31r8/w6RcKjZXaHEoR45sguAGmKmeyvlNj/+PUCKbl5oqszC5BWEmuE9ERi939o23k483R2k IsXN4WNWlbu2x0nR6Fmts00Nk4WCcn
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

