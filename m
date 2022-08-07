Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2E358BB3F
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Aug 2022 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiHGO3D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Aug 2022 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiHGO3B (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Aug 2022 10:29:01 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5536963E6;
        Sun,  7 Aug 2022 07:28:59 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <mhal@rbox.co>)
        id 1oKhGy-007po1-Sd; Sun, 07 Aug 2022 16:28:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
        s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From;
        bh=SkDyDNdlUoRerspo76l+6X16aQ22d3uzCxkG0Mkdu60=; b=AlYXYxAl5dI3DkFoJ8tTUwrC9Z
        /wJ02i4wsGSKCST4LbpK9CL5WwQbUm/abcF8xRMo8O170fofrAUKlfNMYLWR3+NgMmyenrTkuXNhI
        iQ5HC7FRvC+aSSqJauMAEqd8DHLyXHjbg5c0WB8gVunggNMnDslH3ruNsN98pntpj6JELgj2LzVqa
        fG+K1LmtEqQ0bXsev+RXzRTV5/xq8zR3D9t4VjM4E+trifSpAcmq/+EGPrJCBFzAhkWDvkbL+AEDt
        ir8793TcCGgpOn8ybmxq4MGgcAxL9dVQpoRvvX+Tngn0T1vNkWI4GvTgY5qSS3TiGU3cDI5RMGej4
        r6MUeisQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <mhal@rbox.co>)
        id 1oKhGy-0007jG-KC; Sun, 07 Aug 2022 16:28:56 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oKhGw-0002az-6x; Sun, 07 Aug 2022 16:28:54 +0200
From:   Michal Luczaj <mhal@rbox.co>
To:     seanjc@google.com
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, mhal@rbox.co
Subject: [kvm-unit-tests PATCH v2 5/5] x86: Test emulator's handling of LEA with /reg
Date:   Sun,  7 Aug 2022 16:28:32 +0200
Message-Id: <20220807142832.1576-6-mhal@rbox.co>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807142832.1576-1-mhal@rbox.co>
References: <20220807142832.1576-1-mhal@rbox.co>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

LEA with a register-direct source operand is illegal. Verify that the
emulator raises #UD.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
v1 -> v2: Use ASM_TRY_FEP()

 x86/emulator.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/x86/emulator.c b/x86/emulator.c
index 0eb7c1a..dc91ce3 100644
--- a/x86/emulator.c
+++ b/x86/emulator.c
@@ -897,6 +897,20 @@ static void test_mov_dr(uint64_t *mem)
 		report(rax == DR6_ACTIVE_LOW, "mov_dr6");
 }
 
+static void test_illegal_lea(void)
+{
+	unsigned int vector;
+
+	asm volatile (ASM_TRY_FEP("1f")
+		      ".byte 0x8d; .byte 0xc0\n\t"
+		      "1:"
+		      : : : "memory", "eax");
+
+	vector = exception_vector();
+	report(vector == UD_VECTOR,
+	       "Wanted #UD on LEA with /reg, got vector = %u", vector);
+}
+
 static void test_push16(uint64_t *mem)
 {
 	uint64_t rsp1, rsp2;
@@ -1188,6 +1202,7 @@ int main(void)
 		test_smsw_reg(mem);
 		test_nop(mem);
 		test_mov_dr(mem);
+		test_illegal_lea();
 	} else {
 		report_skip("skipping register-only tests, "
 			    "use kvm.force_emulation_prefix=1 to enable");
-- 
2.37.1

