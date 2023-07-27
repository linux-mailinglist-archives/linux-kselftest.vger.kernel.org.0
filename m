Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3562A766037
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 01:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjG0X1F (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 19:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbjG0X1E (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 19:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007EA30D2
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 16:27:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A69161F84
        for <linux-kselftest@vger.kernel.org>; Thu, 27 Jul 2023 23:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91005C433C9;
        Thu, 27 Jul 2023 23:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690500422;
        bh=Znm9gRTwsFwQfwD1M+msy3+6gP9lF4h25ZTmsNIMG+8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=WXvhCx3tVGtpH7KM3WsPf+wJKi5tzA8AnxDAawXXSng2MmFBYN0/MOXK0hpTf1zmq
         4OHjaNBIFFH3UAccIjni55fGQFBVuTPLXT+t3urAataGB7cePSb0kFKv2TP1GatcaG
         aPzOQovlIspJwoFZqRTLmSsj5s+6MiFqj4c7yeALO8SVg9C13lrx6WgmWZvDwCBXbu
         Boz2mn5Q0wKvEvWiUTD3dL9pEKqA0/mgQypPE/e5U0CEQjYle5JI7JgcLPD2AMcRU1
         J3ManrUKmRAZnIY9U3lhMr893MAvaOM+1JoBgusZacBW5rkYCQU4MYuyParCK8q1z3
         mwEhAlv4/o42Q==
From:   Mark Brown <broonie@kernel.org>
Date:   Fri, 28 Jul 2023 00:26:14 +0100
Subject: [PATCH v4 3/6] tools include: Add some common function attributes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230728-arm64-signal-memcpy-fix-v4-3-0c1290db5d46@kernel.org>
References: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
In-Reply-To: <20230728-arm64-signal-memcpy-fix-v4-0-0c1290db5d46@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=895; i=broonie@kernel.org;
 h=from:subject:message-id; bh=Znm9gRTwsFwQfwD1M+msy3+6gP9lF4h25ZTmsNIMG+8=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhpRDf60vB71y215inrJV+E2EvtuMndOPcufzzNzl5MwV+Hzv
 Vf5vnYzGLAyMXAyyYoosa59lrEoPl9g6/9H8VzCDWJlApjBwcQrARFqY2f/X7OoRrrAS0kqpYioQzq
 nK0o7ktSu1PC/Nt2ihyavyes2Vfp4fb32arL/5T5mD5+M//xgaNiUeCk2XuvaHvccveOu1Z3OdzT46
 a4r0KKaoWcpxNFucLtg/SUw1wK+3kmtGjGKsr8f/CR1GveLSq26zehhIHHTMDP2w0apD/OhHA9Wzsa
 U7/kVMzzHdqHnO91v3ul/PbdbV8i+Qlrp59vyrHas25S+Kcc1/vKPuccdv16k+tuazJfonf7bn6spO
 DnRya1z3pCH2UsqpzR4nKr6fl3OpNvz6cut0pntr1Vh9k2t3HWF0ZU8ICRM6Jc7UweD2OWfqr8aFV2
 /qN0ruOfzjdOr/PBXpYjaHJAdbAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We don't have definitions of __always_unused or __noreturn in the tools
version of compiler.h, add them so we can use them in kselftests.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/include/linux/compiler.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/include/linux/compiler.h b/tools/include/linux/compiler.h
index f75cced41d59..1684216e826a 100644
--- a/tools/include/linux/compiler.h
+++ b/tools/include/linux/compiler.h
@@ -42,6 +42,18 @@
 # define __always_inline	inline __attribute__((always_inline))
 #endif
 
+#ifndef __always_unused
+#define __always_unused __attribute__((__unused__))
+#endif
+
+#ifndef __noreturn
+#define __noreturn __attribute__((__noreturn__))
+#endif
+
+#ifndef unreachable
+#define unreachable() __builtin_unreachable()
+#endif
+
 #ifndef noinline
 #define noinline
 #endif

-- 
2.30.2

