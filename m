Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEFB49CD64
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbiAZPLw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:11:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:40244 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235639AbiAZPLv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:11:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDCDA61805
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB488C340EC;
        Wed, 26 Jan 2022 15:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643209910;
        bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tT9VCyBdrS3B9ZoFShxsqCz0QxtS2GdjGFhNhWm+Wxm0+/lN55eFms5GjA9WpiJ5B
         k3FJTgTxkX3Hc7akhF0ks3701jAyyElK4OgnIsD7BgtZdN9hWldYMyyxGZfhQoMVWB
         NwAcwiEduh9nvseyckZkgVQquWKfauiBDzPBg6C6YSY1i4eHgklH9HunM+v2I6fchF
         LWWo4E6yKE3fdEW25zXzQoJn+0eJkdlMWwMyOAYgJV3t8gD9ltQTOmqsRUh9ojyPp3
         cnFnq9j4nWBKNq5fGJZnXsxhTDcY73fYVkubMsEu9xKdQoEIfnaKfXBYLXBCgHbIkI
         OcdXOa4nSPlCg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v9 04/40] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Wed, 26 Jan 2022 15:10:44 +0000
Message-Id: <20220126151120.3811248-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126151120.3811248-1-broonie@kernel.org>
References: <20220126151120.3811248-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WR5gEzITa3c+LpcX6BANIKS7MW2GTUq48+G78Hk TYKq/JWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFkeQAKCRAk1otyXVSH0DvxB/ 9DJRa/JLX29ujvL1yvZ0g9P3+KR265G4LetYNuU7RKHVV5gpVLg+fixOk08tTNFfOXsr+WLckAX6TN Prbs25szdV2Cbxv1CuWeZsvvBps90ydYJDEYqIatKaFKofhE99c2dzychkpYJUe+TyhHXuC6/wMZbI nTjsR8IVrtsNQj++yMjRbLe7jrbTnlqvCpsifzHegxb/rkUJHmFjHBuikAuxV5pEBkCSzfFCEe+qwk okOVELgMp5z9ah7y9hcXi5cRZn6t+EuUwRYh/khA/FNohoBEMBiAchgH55OZymASTGGnB9yaI0pFhR ulIiHCJcBqbTaQR2sZA1yk85U+zQv/
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

An ARRAY_SIZE() has been added to kselftest.h so remove the local versions
in some of the arm64 selftests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/syscall-abi.c | 1 -
 tools/testing/selftests/arm64/fp/sve-ptrace.c   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/arm64/abi/syscall-abi.c b/tools/testing/selftests/arm64/abi/syscall-abi.c
index d8eeeafb50dc..1e13b7523918 100644
--- a/tools/testing/selftests/arm64/abi/syscall-abi.c
+++ b/tools/testing/selftests/arm64/abi/syscall-abi.c
@@ -18,7 +18,6 @@
 
 #include "../../kselftest.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
 #define NUM_VL ((SVE_VQ_MAX - SVE_VQ_MIN) + 1)
 
 extern void do_syscall(int sve_vl);
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index af798b9d232c..90ba1d6a6781 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -21,8 +21,6 @@
 
 #include "../../kselftest.h"
 
-#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
-
 /* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
 #ifndef NT_ARM_SVE
 #define NT_ARM_SVE 0x405
-- 
2.30.2

