Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B918149AA37
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 05:36:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1325044AbiAYDfa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 22:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3420488AbiAYCY2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 21:24:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87815C038AEC
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Jan 2022 16:15:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27F566124B
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:15:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7BCC340E8;
        Tue, 25 Jan 2022 00:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069734;
        bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rCK1SZunrWXe+7ZyudtrRKUAZGI+kJyrnmNoVMEdUOtL/RfLAkTHpM/6MDHGdL148
         sidTPKmV5jxBIUlw6SA3zLaARUWmyQTAs+aZE4vo/4g7jWdbSKgCsa3rtpgYnxqRrX
         8WhlsoTEYa04CxRAaeBaKEDxoLbkoTDXuDR9oKfRv3yiPH6jEVSe4+simzqW9nTmY9
         KUsZKJIB7YUurz/6wdd8vcW2+m77AXo1wZ7QRMWYRJJ5UkgZPid6TsIZpDAPbUXPql
         FKpcO12EfbrC87YWAjy8hSzYSA86nN6G3BMJPdpDgzeIVdBlsBBB+FusmZh2xt0zUF
         9TkIWDDMu86dg==
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
Subject: [PATCH v8 03/38] kselftest/arm64: Remove local ARRAY_SIZE() definitions
Date:   Tue, 25 Jan 2022 00:10:39 +0000
Message-Id: <20220125001114.193425-4-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1265; h=from:subject; bh=cINPFgKL2Ut8k3Oy2wD5fkInRC1CnwPrnusLBuDdThE=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70ADgEzITa3c+LpcX6BANIKS7MW2GTUq48+G78Hk TYKq/JWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AAwAKCRAk1otyXVSH0B33B/ 4jGPTVDPXx5T6RrRQk+H/OZk4Q5FhydGJNUZltYSbxp2FS8RmrhFNNw1esXn0AlycrgQ9rwwowrbKe CiKGCDLRViQNPTdUV3LJw+Y0Vcek/EMZ8jt/V2gvTgJBPV2T81jU3c1rKM+M9EcGoZgVFkS9achgIB vFQzDbxFI+CBqoHoZKaQtIeZQf980w5QM9F8UOXwBYRrGy6upxq4ak3soifhA1pEMUtpOacjYsmfUV MZ7azYBToWAPWAZwtE3h3nIs98uAc7o2Cim8vVpB5spVWhpWWUOcRFdlia6mg3oIeb2O3NACwlYtoP gBS121Zj9RX2yGvS5iudEdvG2O3DbR
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

