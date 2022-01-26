Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46CEB49CE40
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jan 2022 16:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242824AbiAZPak (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jan 2022 10:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242823AbiAZPaj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jan 2022 10:30:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989CC06161C
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 07:30:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57174618CA
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Jan 2022 15:30:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CC7C340E6;
        Wed, 26 Jan 2022 15:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643211038;
        bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxQiSmmjmKgQtCOaRLBiNvFj8xpLijAiQgnwI0/mnXjb8d26UQDn2m6k5Jm4z1akf
         sVkGVS5QrK2wfBHzcGsLWcqKhH2l2lyf/NysTlEjfCbEKWR3OQ0Nx0rj6mDCApc8xA
         9USHBuawNhH4vvhud0C+HxeQCK/5BnzvcesjyHcnTCZshJtsTnW0mAjZalM4aK5KmW
         gzvKBMr4TODX+g+C8ygRc56UodYj4FW/zdw62+bzjU+UK6bXgHwfrcutneHaPtFp5b
         BPyq4EZNBUuZNJL+vMSo4Cwb3Mfm3/npOEeUQarIXmUXoL13rw4zgo1JKaZZO9mkrP
         KdLsH7/ik3q3A==
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
Subject: [PATCH v10 04/39] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Wed, 26 Jan 2022 15:27:14 +0000
Message-Id: <20220126152749.233712-5-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126152749.233712-1-broonie@kernel.org>
References: <20220126152749.233712-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh8WhUgEzITa3c+LpcX6BANIKS7MW2GTUq48+G78Hk TYKq/JWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYfFoVAAKCRAk1otyXVSH0Ir1B/ 9aFHdPLeVud1cdP2yd0+64geou3Hyg1UGhWHkMTCU7wW/Wjhqx8RneluZJO4mdW1/pSe7tTGs2MU6v w/f3WJdao8rdiwz7MTXDtFYHXmR16YYdTEatC/IrYjR4CE/VtEHhxXZt6atEoJtVKMQGja9ZeTM/cP cZyltVjgfxK/kyLyvb6cZm4PB6hWldF6K3lAwloT6Ope4nO3Ykh2TLhxWv4sLdm6TU844tCXjHKXMY rLOWfRvmVTUeMM9ewZOZmpp6eS/FKAp9lSw+PfXQL6Z5fTAsds3YtnDxJ419gHcEcndDKRRMvwsZPJ TbtrLuj3D1JG+fsYMWKPaM/ZON4rbd
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

