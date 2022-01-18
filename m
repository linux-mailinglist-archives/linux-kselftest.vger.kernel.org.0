Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E540949259E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 13:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240837AbiARMWO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 07:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbiARMWO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 07:22:14 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03585C061574;
        Tue, 18 Jan 2022 04:22:14 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 534CC1F43E46
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642508532;
        bh=rOgEZhiM8H0HymHkRIGT/B54ctz4TM16QK+AHnV43yk=;
        h=From:To:Cc:Subject:Date:From;
        b=TPWMhYnYdUcBtp0Y1lZ1pIgqMUia3ydh8x4TtfH3ZPiddMpqqLdrt4IkB0ynrwWRq
         5BtMknjndkIsBTfIW/3cG8eEEsoCNIPKlaRDaBVBTRUd/zLSQLWISnbSBizE6EIq5I
         Pv+SElpp4nUv6fdTttBBJbSnDLhf/wQoKhL1qjvNAiCMJ3JCyP4ISC/+wg81x6TYn/
         CnkhU8DpiU6LdIJ8O/KzWYFkvwHcwb9vToslDQnLCYfzzastSEH2kOvi+y0e+6PLnZ
         1ugclxyzLADjZiGugmSTzW5Tbno8FvO8lr1eo85d25Ob11DZ4G/CcWyBgCh6NceWbX
         yzndkdtgBiCUg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yang Zhong <yang.zhong@intel.com>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kvm: add amx_test to .gitignore
Date:   Tue, 18 Jan 2022 17:20:52 +0500
Message-Id: <20220118122053.1941915-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

amx_test's binary should be present in the .gitignore file for the git
to ignore it.

Fixes: bf70636d9443 ("selftest: kvm: Add amx selftest")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/kvm/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 8c129961accf..780066ae092c 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -8,6 +8,7 @@
 /s390x/memop
 /s390x/resets
 /s390x/sync_regs_test
+/x86_64/amx_test
 /x86_64/cr4_cpuid_sync_test
 /x86_64/debug_regs
 /x86_64/evmcs_test
-- 
2.30.2

