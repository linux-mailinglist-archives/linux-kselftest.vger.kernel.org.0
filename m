Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FBCA66C5AB
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjAPQIs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjAPQIK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:08:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAE61CAC1;
        Mon, 16 Jan 2023 08:05:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46820B81077;
        Mon, 16 Jan 2023 16:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B566C433F2;
        Mon, 16 Jan 2023 16:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885150;
        bh=+AipM2Pq+d4OXfcZe0Uf7z/JOMjM5O4VBzmXDSASdHY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=C65v3vdiMNrh12tjb48fDRMHoGt+vISIqIe6ijmIFH3gk7APJ2vd6XMn8RgUNwFhh
         X1THh2L7iF7UFYIhPamO4VkdJxopzleboE/DAd4Y8eQ9D/bgl94RKpZQzWAL8Hp+gv
         f77JTV7g1OsTVZnufMSR39m+wTdVKAwuE6FDWI74fb95+Hfy3XHFftduHklPjS8pR0
         v3tuErxX7Qi7W1yb0rzA8j6l3FAHJNofWawFohluFmR+hr8btOCm7yTmpuo4qlqXyp
         X75mfaeafgbsZiTvwDYrrrOXCjwhXsSNVadh8lRDBYHnD0/fz3k1RTsA222U30I7Jt
         KNQyxLZ9Z/sDQ==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:41 +0000
Subject: [PATCH v4 06/21] arm64/sme: Manually encode ZT0 load and store
 instructions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-6-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=911; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+AipM2Pq+d4OXfcZe0Uf7z/JOMjM5O4VBzmXDSASdHY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWm6ka3iCKzF9msLFjOY6Tpod5hP5a4+oCc7Plz
 dsetlWuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1pgAKCRAk1otyXVSH0IoLB/
 oCzL/cvXGHbVK0qsfiCWqHKuX7fx4HIW7GoJjWbFMAujiA08YUJGei6o8O2VeLLs4Ph+P+cOX8cIn3
 77LCO25IOV9LPdhLadAL27wvGLfsFQlYWvR3bOycpRx9dVKo5LZxKiyZzx+p3Hk4mIOO6FWI8TmNUZ
 e1+zGw2AJg3clPMGzRqI0nBLWVUMr3fnpiq+Hgfo3MzFhkOmYBgz0jnkzIdisZG1gvq84mFTYWewOA
 RHeDMieyeYocbx6lWhBe/u+JpBRmwnbHaJBx7TJRegeOvUMNB1zG1cVA8ODqF8JmrMzQGEPoEyYAS2
 0Z/jAKYKEWAAcpny/vgsayGJ9k5LrN
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In order to avoid unrealistic toolchain requirements we manually encode the
instructions for loading and storing ZT0.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/fpsimdmacros.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/fpsimdmacros.h b/arch/arm64/include/asm/fpsimdmacros.h
index 5e0910cf4832..cd03819a3b68 100644
--- a/arch/arm64/include/asm/fpsimdmacros.h
+++ b/arch/arm64/include/asm/fpsimdmacros.h
@@ -220,6 +220,28 @@
 		| ((\offset) & 7)
 .endm
 
+/*
+ * LDR (ZT0)
+ *
+ *	LDR ZT0, nx
+ */
+.macro _ldr_zt nx
+	_check_general_reg \nx
+	.inst	0xe11f8000	\
+		 | (\nx << 5)
+.endm
+
+/*
+ * STR (ZT0)
+ *
+ *	STR ZT0, nx
+ */
+.macro _str_zt nx
+	_check_general_reg \nx
+	.inst	0xe13f8000		\
+		| (\nx << 5)
+.endm
+
 /*
  * Zero the entire ZA array
  *	ZERO ZA

-- 
2.34.1

